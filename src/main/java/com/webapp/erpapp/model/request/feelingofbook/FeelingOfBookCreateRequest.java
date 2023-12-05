package com.webapp.erpapp.model.request.feelingofbook;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FeelingOfBookCreateRequest {

    @NotBlank(message = "Field userId is not filled")
    private String userId;

    @NotBlank(message = "Field quote is not filled")
    private String quote;

    @NotBlank(message = "Field bookId is not filled")
    private String bookId;
}
