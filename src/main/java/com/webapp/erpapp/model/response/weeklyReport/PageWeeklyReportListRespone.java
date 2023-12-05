package com.webapp.erpapp.model.response.weeklyReport;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class PageWeeklyReportListRespone {
    List<WeeklyReportShowResponse> listWeeklyReport;
    long pageNumber;
    long totalPages;
    long pageSize;
    Boolean hasNext;
    Boolean hasPrevious;
}
