package com.webapp.erpapp.model.dto.management_time;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ToDoListDto {
    private List<ItemDto> sixToTwelvePm;
    private List<ItemDto> twelveToSixPm;
    private List<ItemDto> sixToTwelveAm;
}
