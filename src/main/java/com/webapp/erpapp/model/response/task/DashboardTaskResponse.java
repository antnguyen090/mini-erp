package com.webapp.erpapp.model.response.task;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DashboardTaskResponse {
    List<TaskShowResponse> responseList;
    List<StatusTaskCountsResponse> statusTaskCounts;
}
