package com.webapp.erpapp.model.response.event;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DashBoardResponse {
    List<EventDashBoardResponse> list;
    long pageNumber;
    long totalPages;
    long totalRecords;
    long pageSize;
    Boolean hasNext;
    Boolean hasPrevious;
}
