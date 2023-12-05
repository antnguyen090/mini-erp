package com.webapp.erpapp.enums.user;

public enum RoleEnum {
    OWNER("Owner"), MANAGER("Manager"), DEVELOPER("Developer");

    private String value;

    RoleEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
