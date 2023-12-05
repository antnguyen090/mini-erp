package com.webapp.erpapp.enums.task;

public enum PriorityTaskEnum {

    HIGH("High"), MEDIUM("Medium"), LOW("Low");

    private String value;

    PriorityTaskEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
