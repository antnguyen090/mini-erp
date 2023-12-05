package com.webapp.erpapp.api;

import com.webapp.erpapp.model.request.accountings.AccountingCreateRequest;
import com.webapp.erpapp.model.request.accountings.AccountingUpdateRequest;
import com.webapp.erpapp.model.response.accounting.PageAccountListResponse;
import com.webapp.erpapp.service.AccountingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.time.LocalDate;

@RestController
@RequestMapping("/api/v1/accounts")
public class AccountingApi {
    @Autowired
    private AccountingService accountingService;

    @GetMapping("total-month")
    public ResponseEntity<?> findAllMonthlyHistory() {
        return ResponseEntity.ok(accountingService.findAllMonthlyHistory());
    }

    @GetMapping()
    public ResponseEntity<?> findAccountingByMonth(@RequestParam(name = "page",required = false,defaultValue = "1") Integer page,
                                                   @RequestParam(name = "size", required = false, defaultValue = "10") Integer size,
                                                   @RequestParam(name = "startDate", required = false) String startDate,
                                                   @RequestParam(name = "endDate", required = false) String endDate
    ) {
        LocalDate startDateParsed = null;
        LocalDate endDateParsed = null;
        if (startDate != null && !startDate.isEmpty()) {
            startDateParsed = LocalDate.parse(startDate);
        }
        if (endDate != null && !endDate.isEmpty()) {
            endDateParsed = LocalDate.parse(endDate);
        }
        PageAccountListResponse accountListResponse = accountingService.findAccountingByMonth(page,size,startDateParsed,endDateParsed);
        return ResponseEntity.ok(accountListResponse);
    }

    @PostMapping()
    public ResponseEntity<?> createAccounting(@Valid AccountingCreateRequest accountingCreateRequest, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(accountingService.createAccounting(accountingCreateRequest),HttpStatus.OK);
    }

    @PostMapping("/edit")
    public ResponseEntity<?> updateAccounting(@Valid AccountingUpdateRequest accountingUpdateRequest, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(accountingService.updateAccounting(accountingUpdateRequest),HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteAccounting(@PathVariable("id") String id) {
        return ResponseEntity.ok(accountingService.deleteAccounting(id));
    }

    @GetMapping("/detail/{id}")
    public ResponseEntity<?> detailAccounting(@PathVariable("id") String id) {
        return ResponseEntity.ok(accountingService.findAccountingById(id));
    }

    @GetMapping("/balance")
    public ResponseEntity<?> getRemainBalanceEachMonth() {
        return ResponseEntity.ok(accountingService.getRemainBalanceEachMonth());
    }

}

