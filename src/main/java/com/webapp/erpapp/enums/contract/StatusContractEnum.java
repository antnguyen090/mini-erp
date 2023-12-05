package com.webapp.erpapp.enums.contract;

public enum StatusContractEnum {

    ACTIVE("Active"), INACTIVE("Inactive");

    private String value;

    StatusContractEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
