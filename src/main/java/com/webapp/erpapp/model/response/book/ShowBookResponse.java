package com.webapp.erpapp.model.response.book;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ShowBookResponse {

    private String id;
    private String title;
    private String author;
    private String createdDate;
    private String createdBy;
    private String link;
    private String image;
}