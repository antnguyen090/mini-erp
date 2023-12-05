package com.webapp.erpapp.enums.task;

public enum ActionChangeStatusTaskEnum {

    OPEN("Open"), POSTPONE("Postpone"), REOPEN("Reopen"), CLOSE("Close");

    private String value;

    ActionChangeStatusTaskEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
