package com.webapp.erpapp.model.response.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class PageUserListRespone {
    List<UserShowResponse> listUser;
    long pageNumber;
    long totalPages;
    long pageSize;
    Boolean hasNext;
    Boolean hasPrevious;
}
