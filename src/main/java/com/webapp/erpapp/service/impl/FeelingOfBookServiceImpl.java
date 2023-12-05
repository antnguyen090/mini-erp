package com.webapp.erpapp.service.impl;

import com.webapp.erpapp.converter.FeelingOfBookConverter;
import com.webapp.erpapp.entity.FeelingOfBook;
import com.webapp.erpapp.exception.NotFoundException;
import com.webapp.erpapp.mapper.BookMapper;
import com.webapp.erpapp.mapper.FeelingOfBookMapper;
import com.webapp.erpapp.mapper.UserMapper;
import com.webapp.erpapp.model.request.feelingofbook.FeelingOfBookCreateRequest;
import com.webapp.erpapp.model.request.feelingofbook.FeelingOfBookUpdateRequest;
import com.webapp.erpapp.model.response.feelingofbook.FeelingOfBookResponse;
import com.webapp.erpapp.service.FeelingOfBookService;
import com.webapp.erpapp.utils.MessageErrorUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class FeelingOfBookServiceImpl implements FeelingOfBookService {

    @Autowired
    private FeelingOfBookMapper feelingOfBookMapper;

    @Autowired
    private FeelingOfBookConverter feelingOfBookConverter;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private BookMapper bookMapper;

    @Override
    public List<FeelingOfBookResponse> findAll() {
        return feelingOfBookMapper.findAll().stream().map(f->feelingOfBookConverter.toResponse(f)).collect(Collectors.toList());
    }

    @Override
    public FeelingOfBookResponse createFeelingOfBook(FeelingOfBookCreateRequest feelingOfBookCreateRequest) {

        if(userMapper.findById(feelingOfBookCreateRequest.getUserId())== null)
            throw new NotFoundException(MessageErrorUtils.notFound("userId"));

        if(bookMapper.findById(feelingOfBookCreateRequest.getBookId())== null)
            throw new NotFoundException(MessageErrorUtils.notFound("bookId"));

        FeelingOfBook feelingOfBook = feelingOfBookConverter.toEntity(feelingOfBookCreateRequest);
        try{
            feelingOfBookMapper.createFeelingOfBook(feelingOfBook);
        } catch (Exception e){
            return null;
        }
        return feelingOfBookConverter.toResponse(feelingOfBook);
    }

    @Override
    public FeelingOfBookResponse findById(String id) {
        return feelingOfBookConverter.toResponse(feelingOfBookMapper.findById(id));
    }

    @Override
    public FeelingOfBookResponse updateFeelingOfBook(FeelingOfBookUpdateRequest feelingOfBookUpdateRequest) {

        if(feelingOfBookMapper.findById(feelingOfBookUpdateRequest.getId()) == null)
            throw new NotFoundException(MessageErrorUtils.notFound("id"));

        FeelingOfBook feelingOfBook = feelingOfBookConverter.toEntity(feelingOfBookUpdateRequest);
        try{
            feelingOfBookMapper.updateFeelingOfBook(feelingOfBook);
        } catch (Exception e){
            return null;
        }
        return feelingOfBookConverter.toResponse(feelingOfBook);
    }

    @Override
    public FeelingOfBookResponse findFeelingByUser(String bookId, String userId) {
        return feelingOfBookConverter.toResponse(feelingOfBookMapper.findFeelingByUser(bookId, userId));
    }

    @Override
    public int deleteFeelingOfBook(String bookId, String userId) {
//        if(feelingOfBookMapper.findById(id) == null)
//            throw new NotFoundException(MessageErrorUtils.notFound("id"));

        try{
            feelingOfBookMapper.deleteFeelingOfBook(bookId, userId);
            return 1;
        }catch (Exception e){}
        return 0;
    }
}
