package com.webapp.erpapp.enums.user;

public enum TypeUserEnum {

    PROBATION("Probation"), OFFICIAL("Official"), PARTTIME("Partime");

    private String value;

    TypeUserEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
