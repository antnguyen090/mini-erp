package com.webapp.erpapp.converter;

import com.webapp.erpapp.entity.Book;
import com.webapp.erpapp.mapper.FeelingOfBookMapper;
import com.webapp.erpapp.model.request.book.BookCreateRequest;
import com.webapp.erpapp.model.request.book.BookUpdateRequest;
import com.webapp.erpapp.model.response.book.BookDetailResponse;
import com.webapp.erpapp.model.response.book.ShowBookResponse;
import com.webapp.erpapp.utils.ApplicationUtils;
import com.webapp.erpapp.utils.DateUtils;
import com.webapp.erpapp.utils.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class BookConverter {

    @Autowired
    private FeelingOfBookConverter feelingOfBookConverter;

    @Autowired
    private FeelingOfBookMapper feelingOfBookMapper;

    public ShowBookResponse toShowBookResponse(Book book) {
        return ShowBookResponse.builder()
                .id(book.getId())
                .title(book.getTitle())
                .author(book.getAuthor())
                .createdDate(DateUtils.formatDateTime(book.getCreatedDate()))
                .createdBy(book.getCreatedBy())
                .link(book.getLink())
                .image(FileUtils.getPathUpload(Book.class, book.getImage()))
                .build();
    }

    public List<ShowBookResponse> toListShowBookResponse(List<Book> books) {
        return books.stream().map(this::toShowBookResponse).collect(Collectors.toList());
    }

    public BookDetailResponse toDetailResponse(Book book) {
        return BookDetailResponse.builder()
                .book(toShowBookResponse(book))
                .feelingOfBooks(feelingOfBookConverter.toListResponse(feelingOfBookMapper.findAllByBook(book.getId()))).build();
    }

    public Book toEntity(BookCreateRequest bookCreateRequest, String bookImageFileName){
        return Book.builder()
                .id(ApplicationUtils.generateId())
                .title(bookCreateRequest.getTitle())
                .author(bookCreateRequest.getAuthor())
                .link(bookCreateRequest.getLink())
                .createdDate(new Date())
                .createdBy(bookCreateRequest.getFullnameUser())
                .image(bookImageFileName)
                .build();
    }

    public Book toEntity(BookUpdateRequest bookUpdateRequest, String bookImageFileName){
        return Book.builder()
                .id(bookUpdateRequest.getId())
                .title(bookUpdateRequest.getTitle())
                .author(bookUpdateRequest.getAuthor())
                .link(bookUpdateRequest.getLink())
                .image(bookImageFileName)
                .build();
    }
}