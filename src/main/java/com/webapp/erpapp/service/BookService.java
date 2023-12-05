package com.webapp.erpapp.service;

import com.webapp.erpapp.model.request.book.BookCreateRequest;
import com.webapp.erpapp.model.request.book.BookUpdateRequest;
import com.webapp.erpapp.model.response.book.BookDetailResponse;
import com.webapp.erpapp.model.response.book.ShowBookResponse;

import java.util.List;

public interface BookService {
    List<ShowBookResponse> findAll(String searchTerm, int start, int pageSize);
    long getTotalItem(String search);
    int createBook(BookCreateRequest bookCreateRequest);
    BookDetailResponse findById(String id);
    int updateBook(BookUpdateRequest bookUpdateRequest);
    int deleteBook(String id);
}