package com.webapp.erpapp.service;

import com.webapp.erpapp.model.request.feelingofbook.FeelingOfBookCreateRequest;
import com.webapp.erpapp.model.request.feelingofbook.FeelingOfBookUpdateRequest;
import com.webapp.erpapp.model.response.feelingofbook.FeelingOfBookResponse;

import java.util.List;

public interface FeelingOfBookService {
    List<FeelingOfBookResponse> findAll();
    FeelingOfBookResponse createFeelingOfBook(FeelingOfBookCreateRequest feelingOfBookCreateRequest);
    FeelingOfBookResponse findById(String id);
    FeelingOfBookResponse updateFeelingOfBook(FeelingOfBookUpdateRequest feelingOfBookUpdateRequest);
    FeelingOfBookResponse findFeelingByUser(String bookId, String userId);
    int deleteFeelingOfBook(String bookId, String userId);
}