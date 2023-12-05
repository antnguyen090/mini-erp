package com.webapp.erpapp.enums.user;

public enum GenderEnum {
    MALE("Male"), FEMALE("Female");

    private String value;

    GenderEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
