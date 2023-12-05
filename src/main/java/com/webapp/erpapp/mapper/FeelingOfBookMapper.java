package com.webapp.erpapp.mapper;


import com.webapp.erpapp.entity.FeelingOfBook;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface FeelingOfBookMapper {
    List<FeelingOfBook> findAll();
    int createFeelingOfBook(FeelingOfBook feelingOfBook);
    FeelingOfBook findById(String id);
    int updateFeelingOfBook(FeelingOfBook feelingOfBook);
    int deleteFeelingOfBook(String bookId,
                            String userId);
    List<FeelingOfBook> findAllByBook(String id);
    FeelingOfBook findFeelingByUser(String bookId,
                                    String userId);
}