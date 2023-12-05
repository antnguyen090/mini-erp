package com.webapp.erpapp.enums.event;

import lombok.Getter;

@Getter
public enum EventTypeEnum {
    HOLIDAY("Holiday"),SEMINAR("Seminar"),TEAM_BUILDING("Team building"), MEETING("Meeting"),TRAINING("Training"), PARTY("Party"), OTHER("Other");
    private String value;
    EventTypeEnum(String value) {
        this.value = value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
