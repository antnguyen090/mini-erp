package com.webapp.erpapp.service.impl;

import com.webapp.erpapp.constant.AccountingConstant;
import com.webapp.erpapp.constant.SettingConstant;
import com.webapp.erpapp.converter.AccountingConverter;
import com.webapp.erpapp.entity.Accounting;
import com.webapp.erpapp.entity.Setting;
import com.webapp.erpapp.entity.User;
import com.webapp.erpapp.exception.FileTooLimitedException;
import com.webapp.erpapp.exception.NotFoundException;
import com.webapp.erpapp.mapper.AccountingMapper;
import com.webapp.erpapp.mapper.SettingMapper;
import com.webapp.erpapp.mapper.UserMapper;
import com.webapp.erpapp.model.request.accountings.AccountingCreateRequest;
import com.webapp.erpapp.model.request.accountings.AccountingUpdateRequest;
import com.webapp.erpapp.model.response.accounting.AccountResponse;
import com.webapp.erpapp.model.response.accounting.MonthHistoryList;
import com.webapp.erpapp.model.response.accounting.MonthYearFormat;
import com.webapp.erpapp.model.response.accounting.PageAccountListResponse;
import com.webapp.erpapp.model.response.accounting.RemainBalanceEachMonth;
import com.webapp.erpapp.model.response.accounting.TotalSpendAndRemain;
import com.webapp.erpapp.service.AccountingService;
import com.webapp.erpapp.utils.ApplicationUtils;
import com.webapp.erpapp.utils.DateUtils;
import com.webapp.erpapp.utils.FileUtils;
import com.webapp.erpapp.utils.MessageErrorUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;

@Service
public class AccountingServiceImpl implements AccountingService {
    @Autowired
    private AccountingMapper accountingMapper;
    @Autowired
    private AccountingConverter accountingConverter;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private HttpServletRequest request;
    @Autowired
    private ApplicationUtils applicationUtils;
    @Autowired
    private SettingMapper settingMapper;

    @Override
    public MonthHistoryList findAllMonthlyHistory() {
        List<MonthYearFormat> monthHistoryList = accountingMapper.findAllMonthlyHistory();
        return accountingConverter.convertListToObjectDTO(monthHistoryList);
    }

    @Override
    public PageAccountListResponse findAccountingByMonth(Integer page, Integer size, LocalDate startTime, LocalDate endTime) {
        int offset = (page - 1) * size;
        RowBounds rowBounds = new RowBounds(offset, size);
        LocalDateTime endDateWithTime = null;
        if (endTime != null) {
            endDateWithTime = endTime.atTime(23, 59, 59);
        }
        List<Accounting> accountingList = accountingMapper.findAccountingByMonth(rowBounds, startTime, endDateWithTime);
        List<AccountResponse> accountResponses = accountingConverter.convertToListResponse(accountingList);
        TotalSpendAndRemain totals = accountingMapper.getTotalSpending(startTime, endDateWithTime);
        if (totals == null) {
            return new PageAccountListResponse();
        }
        Long latestRemain = accountingMapper.getLatestRemain(endDateWithTime);
        totals.setTotalRemain(latestRemain);
        long totalRecordCount = accountingMapper.getTotalRecordCountPerMonth(startTime, endDateWithTime);
        long totalPage = (long) Math.ceil((double) totalRecordCount / size);
        boolean hasNext = page < totalPage;
        boolean hasPrevious = page > 1;
        return new PageAccountListResponse(accountResponses, page, totalPage, size, hasNext, hasPrevious, totals);
    }

    @Override
    public int createAccounting(AccountingCreateRequest accountingCreateRequest) {
        Accounting beforeCreateAccounting = accountingMapper.findBeforeCurrentAccounting(DateUtils.toLocalDateTime(accountingCreateRequest.getPayDate()));
        long latestRemain = 0L;
        if (beforeCreateAccounting != null) {
            latestRemain = beforeCreateAccounting.getRemain();
        }

        MultipartFile[] billFile = accountingCreateRequest.getBill();
        if (billFile != null) {
            applicationUtils.checkValidateFileAndImage(Accounting.class, billFile);
        }

        String dir = AccountingConstant.UPLOAD_FILE_DIR;
        List<String> listFileNameSaveFileSuccess = FileUtils.saveMultipleFilesToServer(request, dir, billFile);
        if (listFileNameSaveFileSuccess != null) {
            User currentUser = userMapper.findById(accountingCreateRequest.getUserId());
            if (currentUser == null) throw new NotFoundException(MessageErrorUtils.notFound("User id"));
            Accounting newAccounting = accountingConverter.convertToEntity(accountingCreateRequest, currentUser, latestRemain, listFileNameSaveFileSuccess);
            try {
                accountingMapper.createAccounting(newAccounting);
                List<Accounting> remainRecordInMonthList = accountingMapper.getRemainRecordInMonth(newAccounting,true);
                for (Accounting accounting : remainRecordInMonthList) {
                    latestRemain += accounting.getExpense();
                    accounting.setRemain(latestRemain);
                }
                accountingMapper.updateRecordsBatch(remainRecordInMonthList);
            } catch (Exception e) {
                FileUtils.deleteMultipleFilesToServer(request, dir, newAccounting.getBill());
                return 0;
            }
            return 1;
        }
        return 0;
    }

    @Override
    public AccountResponse updateAccounting(AccountingUpdateRequest accountingUpdateRequest) {
        Accounting currentAccounting = accountingMapper.findAccountingById(accountingUpdateRequest.getId());
        if (currentAccounting == null) throw new NotFoundException(MessageErrorUtils.notFound("Account id"));
        User currentUser = userMapper.findById(accountingUpdateRequest.getUserId());
        if (currentUser == null) throw new NotFoundException(MessageErrorUtils.notFound("User id"));
        String dir = AccountingConstant.UPLOAD_FILE_DIR;
        String fileList = currentAccounting.getBill();
        if (fileList == null) {
            fileList = "";
        }
        List<String> files = Arrays.asList(fileList.split(","));
        List<String> oldFile = Arrays.asList(accountingUpdateRequest.getOldFile());
        List<String> removeFiles = new ArrayList<>();
        List<String> newFiles = new ArrayList<>();
        for (String file : files) {
            if (!oldFile.contains(file)) {
                removeFiles.add(file);
            } else {
                newFiles.add(file);
            }
        }

        MultipartFile[] billFile = accountingUpdateRequest.getBill();
        if (billFile != null) {
            applicationUtils.checkValidateFileAndImage(Accounting.class, billFile);
        }

        List<String> newFilesUpdate;
        Setting setting = settingMapper.findByCode(SettingConstant.ACCOUNTING_CODE);
        if (accountingUpdateRequest.getBill() != null && (billFile.length + oldFile.size()) > setting.getFileLimit()) {
            throw new FileTooLimitedException(MessageErrorUtils.notAllowFileLimit(setting.getFileLimit()));
        }
        newFilesUpdate = FileUtils.saveMultipleFilesToServer(request, dir, billFile);
        assert newFilesUpdate != null;
        newFiles.addAll(newFilesUpdate);
        Accounting updateAccounting = accountingConverter.convertToEntity(accountingUpdateRequest, currentUser, newFiles);
        if (DateUtils.formatDate(currentAccounting.getPayDate()).equals(accountingUpdateRequest.getPayDate())) {
            try {
                updateAccounting.setPayDate(currentAccounting.getPayDate());
                accountingMapper.updateAccounting(updateAccounting);
                if (!Objects.equals(currentAccounting.getExpense(), accountingUpdateRequest.getExpense())) {
                    Accounting beforeCurrentAccounting = accountingMapper.findBeforeCurrentAccounting(currentAccounting.getPayDate());
                    List<Accounting> remainRecordInMonthList = accountingMapper.getRemainRecordInMonth(currentAccounting,true);
                    Long beforeRemain = 0L;
                    if (beforeCurrentAccounting != null) {
                        beforeRemain = beforeCurrentAccounting.getRemain();
                    }
                    for (Accounting accounting : remainRecordInMonthList) {
                        beforeRemain += accounting.getExpense();
                        accounting.setRemain(beforeRemain);
                    }
                    accountingMapper.updateRecordsBatch(remainRecordInMonthList);
                }
                FileUtils.deleteMultipleFilesToServer(request, dir, String.join(",", removeFiles));
            } catch (Exception e) {
                FileUtils.deleteMultipleFilesToServer(request, dir, String.join(",", newFilesUpdate));
                return null;
            }
        } else {
            try {
                accountingMapper.updateAccounting(updateAccounting);
                updateRemainsInTwoMonth(updateAccounting);

                if (!DateUtils.formatYearMonth(currentAccounting.getPayDate()).equals(accountingUpdateRequest.getPayDate())) {
                    updateRemainsInTwoMonth(currentAccounting);
                }

                FileUtils.deleteMultipleFilesToServer(request, dir, String.join(",", removeFiles));
            } catch (Exception e) {
                FileUtils.deleteMultipleFilesToServer(request, dir, String.join(",", newFilesUpdate));
                return null;
            }
        }
        return findAccountingById(accountingUpdateRequest.getId());
    }

    private void updateRemainsInTwoMonth(Accounting currentAccounting) {
        List<Accounting> remainRecordInMonthList = accountingMapper.getRemainRecordInMonth(currentAccounting,false);
        Long beforeRemain = 0L;
        for (Accounting accounting : remainRecordInMonthList) {
            beforeRemain += accounting.getExpense();
            accounting.setRemain(beforeRemain);
        }
        accountingMapper.updateRecordsBatch(remainRecordInMonthList);
    }

    @Override
    public int deleteAccounting(String id) {
        try {
            Accounting deleteAccounting = accountingMapper.findAccountingById(id);
            if (deleteAccounting == null) throw new NotFoundException(MessageErrorUtils.notFound("Account id"));
            accountingMapper.deleteAccounting(id);
            Accounting beforeCurrentAccounting = accountingMapper.findBeforeCurrentAccounting(deleteAccounting.getPayDate());
            List<Accounting> remainRecordInMonthList = accountingMapper.getRemainRecordInMonth(deleteAccounting,true);
            Long beforeRemain = 0L;
            if (beforeCurrentAccounting != null) {
                beforeRemain = beforeCurrentAccounting.getRemain();
            }
            if (remainRecordInMonthList.isEmpty()) {
                return 1;
            } else {
                for (Accounting accounting : remainRecordInMonthList) {
                    beforeRemain += accounting.getExpense();
                    accounting.setRemain(beforeRemain);
                }
                accountingMapper.updateRecordsBatch(remainRecordInMonthList);
                return 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public AccountResponse findAccountingById(String id) {
        Accounting accounting = accountingMapper.findAccountingById(id);
        return accountingConverter.convertToResponseDTO(accounting);
    }

    @Override
    public List<RemainBalanceEachMonth> getRemainBalanceEachMonth() {
        return accountingMapper.getRemainBalanceEachMonth();
    }

}

