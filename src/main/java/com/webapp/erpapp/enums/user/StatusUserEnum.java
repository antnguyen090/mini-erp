package com.webapp.erpapp.enums.user;

public enum StatusUserEnum {

    ACTIVE("Active"), INACTIVE("Inactive"), PENDING("Pending"), REJECT("Reject");

    private String value;

    StatusUserEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
