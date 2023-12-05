package com.webapp.erpapp.model.response.feelingofbook;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FeelingOfBookResponse {

    private String id;
    private String[] quotes;
    private String createdDate;
    private String fullnameUser;
    private String avatarUser;
    private String idUser;
}