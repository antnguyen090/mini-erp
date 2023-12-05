package com.webapp.erpapp.enums.task;

public enum StatusDeleteTaskEnum {

    ACTIVE("Active"), INACTIVE("Inactive");

    private String value;

    StatusDeleteTaskEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
