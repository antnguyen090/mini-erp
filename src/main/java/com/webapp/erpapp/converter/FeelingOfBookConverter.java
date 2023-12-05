package com.webapp.erpapp.converter;

import com.webapp.erpapp.entity.FeelingOfBook;
import com.webapp.erpapp.entity.User;
import com.webapp.erpapp.mapper.BookMapper;
import com.webapp.erpapp.mapper.FeelingOfBookMapper;
import com.webapp.erpapp.mapper.UserMapper;
import com.webapp.erpapp.model.request.feelingofbook.FeelingOfBookCreateRequest;
import com.webapp.erpapp.model.request.feelingofbook.FeelingOfBookUpdateRequest;
import com.webapp.erpapp.model.response.feelingofbook.FeelingOfBookResponse;
import com.webapp.erpapp.utils.ApplicationUtils;
import com.webapp.erpapp.utils.DateUtils;
import com.webapp.erpapp.utils.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class FeelingOfBookConverter {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private BookMapper bookMapper;

    @Autowired
    private FeelingOfBookMapper feelingOfBookMapper;

    public FeelingOfBookResponse toResponse(FeelingOfBook feelingOfBook) {
        if(feelingOfBook == null) return null;
        return FeelingOfBookResponse.builder()
                .id(feelingOfBook.getId())
                .quotes(feelingOfBook.getQuote().split("---"))
                .createdDate(DateUtils.formatDate(feelingOfBook.getCreatedDate()))
                .idUser(feelingOfBook.getUser().getId())
                .fullnameUser(feelingOfBook.getUser().getFullname())
                .avatarUser(FileUtils.getPathUpload(User.class,feelingOfBook.getUser().getAvatar()))
                .build();
    }

    public List<FeelingOfBookResponse> toListResponse(List<FeelingOfBook> feelingOfBooks){
        return feelingOfBooks.stream().map(this::toResponse).collect(Collectors.toList());
    }

    public FeelingOfBook toEntity(FeelingOfBookCreateRequest feelingOfBookCreateRequest){
        return FeelingOfBook.builder()
                .id(ApplicationUtils.generateId())
                .user(userMapper.findById(feelingOfBookCreateRequest.getUserId()))
                .quote(feelingOfBookCreateRequest.getQuote())
                .createdDate(new Date())
                .book(bookMapper.findById(feelingOfBookCreateRequest.getBookId())).build();
    }

    public FeelingOfBook toEntity(FeelingOfBookUpdateRequest feelingOfBookUpdateRequest){

        FeelingOfBook feelingOfBook = feelingOfBookMapper.findById(feelingOfBookUpdateRequest.getId());
        feelingOfBook.setQuote(feelingOfBookUpdateRequest.getQuote());
        return feelingOfBook;
    }
}