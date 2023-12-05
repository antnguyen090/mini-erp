package com.webapp.erpapp.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Book {

    private String id;
    private String title;
    private String author;
    private String link;
    private Date createdDate;
    private String createdBy;
    private String image;
    private List<FeelingOfBook> feelingOfBooks;
}