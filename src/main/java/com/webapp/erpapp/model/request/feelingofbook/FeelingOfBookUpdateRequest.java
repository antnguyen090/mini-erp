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
public class FeelingOfBookUpdateRequest {

    @NotBlank(message = "Field id is not filled")
    private String id;

    @NotBlank(message = "Field quote is not filled")
    private String quote;
}
