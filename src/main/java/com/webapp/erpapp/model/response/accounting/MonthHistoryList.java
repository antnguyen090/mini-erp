package com.webapp.erpapp.model.response.accounting;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MonthHistoryList {
    List<MonthYearFormat> monthList;
}

