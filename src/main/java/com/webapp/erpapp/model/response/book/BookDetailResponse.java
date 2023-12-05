package com.webapp.erpapp.model.response.book;

import com.webapp.erpapp.model.response.feelingofbook.FeelingOfBookResponse;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookDetailResponse {

    private ShowBookResponse book;
    private List<FeelingOfBookResponse> feelingOfBooks;
}