package com.webapp.erpapp.model.response.accounting;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class TotalSpendAndRemain {
    private Long totalRevenue;
    private Long totalExpense;
    private Long totalRemain;
}

