package com.webapp.erpapp.converter;

import com.webapp.erpapp.entity.Contract;
import com.webapp.erpapp.enums.contract.StatusContractEnum;
import com.webapp.erpapp.mapper.ContractMapper;
import com.webapp.erpapp.mapper.UserMapper;
import com.webapp.erpapp.model.request.contract.CreateContractRequest;
import com.webapp.erpapp.model.request.contract.UpdateContractRequest;
import com.webapp.erpapp.model.response.contract.ContractResponse;
import com.webapp.erpapp.utils.*;
import com.webapp.erpapp.utils.ApplicationUtils;
import com.webapp.erpapp.utils.DateUtils;
import com.webapp.erpapp.utils.FileUtils;
import com.webapp.erpapp.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class ContractConverter {

    @Autowired
    private ContractMapper contractMapper;

    @Autowired
    private UserMapper userMapper;

    public Contract toEntity(CreateContractRequest createContractRequest, String contractFileName){
        String parentContractId = createContractRequest.getParentId();

        Contract contract = null;

        if (!StringUtils.isBlank(parentContractId)) contract = contractMapper.findById(createContractRequest.getParentId());

        return Contract.builder()
                .id(ApplicationUtils.generateId())
                .basicSalary(createContractRequest.getBasicSalary())
                .allowance(createContractRequest.getAllowance())
                .contract(contractFileName)
                .createdDate(new Date())
                .user(userMapper.findById(createContractRequest.getUserId()))
                .insurance(createContractRequest.getInsurance())
                .parentContract(contract)
                .status(StatusContractEnum.ACTIVE).build();
    }

    public ContractResponse toResponse(Contract contract){

        if (contract == null) return null;

        return ContractResponse.builder()
                .id(contract.getId())
                .basicSalary(contract.getBasicSalary())
                .allowance(contract.getAllowance())
                .insurance((contract.getInsurance()))
                .contract(FileUtils.getPathUpload(Contract.class, contract.getContract()))
                .createdDate(DateUtils.formatDateTime(contract.getCreatedDate()))
                .historyContract(toListResponseHistory(contract.getHistoryContract()))
                .build();
    }

    public List<ContractResponse> toListResponse(List<Contract> contracts) {
        return contracts.stream().map(this::toResponse).collect(Collectors.toList());
    }
    public List<ContractResponse> toListResponseHistory(List<Contract> contracts) {
        if(contracts == null) return null;
        return contracts.stream().map(c -> toResponse(c)).collect(Collectors.toList());
    }

    public Contract toEntity(UpdateContractRequest updateContractRequest, String contractFileName){
        return Contract.builder()
                .id(updateContractRequest.getId())
                .basicSalary(updateContractRequest.getBasicSalary())
                .allowance(updateContractRequest.getAllowance())
                .contract(contractFileName)
                .insurance(updateContractRequest.getInsurance())
                .build();
    }
}