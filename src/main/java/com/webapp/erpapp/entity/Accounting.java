package com.webapp.erpapp.entity;

import com.webapp.erpapp.enums.accounting.StatusAccountingEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;


@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Accounting {
    private String id;
    private LocalDateTime createdDate;
    private LocalDateTime payDate;
    private Long expense;
    private Long remain;
    private User user;
    private String bill;
    private String title;
    private StatusAccountingEnum status;
    private String note;
}

