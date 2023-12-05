package com.webapp.erpapp.service.impl;

import com.webapp.erpapp.constant.ContractConstant;
import com.webapp.erpapp.converter.ContractConverter;
import com.webapp.erpapp.entity.Contract;
import com.webapp.erpapp.enums.contract.StatusContractEnum;
import com.webapp.erpapp.exception.NotFoundException;
import com.webapp.erpapp.mapper.ContractMapper;
import com.webapp.erpapp.mapper.UserMapper;
import com.webapp.erpapp.model.request.contract.CreateContractRequest;
import com.webapp.erpapp.model.request.contract.UpdateContractRequest;
import com.webapp.erpapp.model.response.contract.ContractResponse;
import com.webapp.erpapp.service.ContractService;
import com.webapp.erpapp.utils.ApplicationUtils;
import com.webapp.erpapp.utils.FileUtils;
import com.webapp.erpapp.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public class ContractServiceImpl implements ContractService {

    @Autowired
    private ContractConverter contractConverter;

    @Autowired
    private ContractMapper contractMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private HttpServletRequest request;

    @Autowired
    private ApplicationUtils applicationUtils;

    @Override
    public ContractResponse addContract(CreateContractRequest createContractRequest) {
        String userId = createContractRequest.getUserId();
        if(userMapper.findById(userId) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("userId"));


        String parentId = createContractRequest.getParentId();
        Contract contract = null;
        if (parentId != null) {
            contract = contractMapper.findById(parentId);
        }

        MultipartFile contractFile = createContractRequest.getContract();

        if(contractFile!=null) applicationUtils.checkValidateFile(Contract.class, contractFile);

        String fileNameContract = null;
        boolean isSaveContractSuccess = true;

        if(contractFile != null){
            fileNameContract = FileUtils.formatNameImage(contractFile);
            isSaveContractSuccess = FileUtils.saveImageToServer(
                    request, ContractConstant.UPLOAD_FILE_DIR, createContractRequest.getContract(), fileNameContract);
        }

        if(isSaveContractSuccess){
            Contract c = contractConverter.toEntity(createContractRequest, fileNameContract);
            try {
                contractMapper.addContract(c);
                return contractConverter.toResponse(contractMapper.findById(c.getId()));
            } catch (Exception e){
                FileUtils.deleteImageFromServer(request, ContractConstant.UPLOAD_FILE_DIR, fileNameContract);
                return null;
            }
        }
        return null;
    }

    @Override
    public ContractResponse findById(String id) {
        return contractConverter.toResponse(contractMapper.findById(id));
    };


    @Override
    public int updateContract(UpdateContractRequest updateContractRequest) {

        Contract contract = contractMapper.findById(updateContractRequest.getId());

        if(contract == null) throw new NotFoundException("id");

        MultipartFile contractFile = updateContractRequest.getContract();

        if(contractFile!=null) applicationUtils.checkValidateFile(Contract.class, contractFile);

        String fileNameContract = null;
        boolean isSaveContractSuccess;

        if(contractFile != null){
            fileNameContract = FileUtils.formatNameImage(contractFile);
            isSaveContractSuccess = FileUtils.saveImageToServer(
                    request, ContractConstant.UPLOAD_FILE_DIR, updateContractRequest.getContract(), fileNameContract);
        } else isSaveContractSuccess = false;

        Contract c;
        if(isSaveContractSuccess){
            c = contractConverter.toEntity(updateContractRequest, fileNameContract);
            try {
                contractMapper.updateContract(c);
                FileUtils.deleteImageFromServer(request, ContractConstant.UPLOAD_FILE_DIR, contract.getContract());
                return 1;
            } catch (Exception e){
                FileUtils.deleteImageFromServer(request, ContractConstant.UPLOAD_FILE_DIR, fileNameContract);
                return 0;
            }
        } else {
            fileNameContract = contract.getContract();
            c = contractConverter.toEntity(updateContractRequest, fileNameContract);
            try{
                contractMapper.updateContract(c);
            }catch (Exception e) {
                System.out.println(e);
            }
            return 1;
        }
    }

    @Override
    public int deleteContract(String id) {
        Contract contract = contractMapper.findById(id);
        if(contract == null) throw new NotFoundException("id");

        try{
            contractMapper.changeStatusContract(id, StatusContractEnum.INACTIVE.toString());
            return 1;
        } catch (Exception e){
            return 0;
        }
    }

    @Override
    public List<ContractResponse> getContractByUser(String userId) {
        return contractConverter.toListResponse(contractMapper.getContractByUser(userId));
    }
}
