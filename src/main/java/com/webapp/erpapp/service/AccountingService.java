package com.webapp.erpapp.service;

import com.webapp.erpapp.model.request.accountings.AccountingCreateRequest;
import com.webapp.erpapp.model.request.accountings.AccountingUpdateRequest;
import com.webapp.erpapp.model.response.accounting.AccountResponse;
import com.webapp.erpapp.model.response.accounting.MonthHistoryList;
import com.webapp.erpapp.model.response.accounting.PageAccountListResponse;
import com.webapp.erpapp.model.response.accounting.RemainBalanceEachMonth;

import java.time.LocalDate;
import java.util.List;

public interface AccountingService {
    MonthHistoryList findAllMonthlyHistory();

    PageAccountListResponse findAccountingByMonth(Integer page, Integer size, LocalDate startTime, LocalDate endTime);

    int createAccounting(AccountingCreateRequest accountingCreateRequest);

    AccountResponse updateAccounting(AccountingUpdateRequest accountingCreateRequest);

    int deleteAccounting(String id);

    AccountResponse findAccountingById(String id);

    List<RemainBalanceEachMonth> getRemainBalanceEachMonth();
}

