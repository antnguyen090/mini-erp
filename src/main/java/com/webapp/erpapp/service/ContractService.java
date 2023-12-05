package com.webapp.erpapp.service;

import com.webapp.erpapp.model.request.contract.CreateContractRequest;
import com.webapp.erpapp.model.request.contract.UpdateContractRequest;
import com.webapp.erpapp.model.response.contract.ContractResponse;

import java.util.List;

public interface ContractService {
    ContractResponse addContract(CreateContractRequest createContractRequest);
    ContractResponse findById(String id);
    int updateContract(UpdateContractRequest updateContractRequest);
    int deleteContract(String id);
    List<ContractResponse> getContractByUser(String userId);
}