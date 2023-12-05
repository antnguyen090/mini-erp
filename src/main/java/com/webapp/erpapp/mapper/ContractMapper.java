package com.webapp.erpapp.mapper;

import com.webapp.erpapp.entity.Contract;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ContractMapper {
    int addContract(Contract contract);
    Contract findById(String id);
    int updateContract(Contract contract);
    int changeStatusContract(String id,String status);
    List<Contract> getContractByUser(String userId);
}