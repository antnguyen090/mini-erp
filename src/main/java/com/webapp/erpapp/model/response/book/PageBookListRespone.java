package com.webapp.erpapp.model.response.book;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class PageBookListRespone {
    List<ShowBookResponse> books;
    long pageNumber;
    long totalPages;
    long pageSize;
    Boolean hasNext;
    Boolean hasPrevious;
}
