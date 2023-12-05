package com.webapp.erpapp.api;


import com.webapp.erpapp.model.request.contract.CreateContractRequest;
import com.webapp.erpapp.model.request.contract.UpdateContractRequest;
import com.webapp.erpapp.service.ContractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/v1/contracts")
public class ContractApi {

    @Autowired
    private ContractService contractService;

    @PostMapping
    public ResponseEntity<?> createContract(@Valid CreateContractRequest createContractRequest) {
        return ResponseEntity.ok(contractService.addContract(createContractRequest));
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getContract(@PathVariable String id) {
        return ResponseEntity.ok(contractService.findById(id));
    }

    @GetMapping("/userContract/{userId}")
    public ResponseEntity<?> getContractByUser(@PathVariable("userId") String userId) {
        return ResponseEntity.ok(contractService.getContractByUser(userId));
    }

    @PostMapping("/updation")
    public ResponseEntity<?> updateContract(@Valid UpdateContractRequest updateContractRequest) {
        return ResponseEntity.ok(contractService.updateContract(updateContractRequest));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteContract(@PathVariable String id) {
        return ResponseEntity.ok(contractService.deleteContract(id));
    }
}