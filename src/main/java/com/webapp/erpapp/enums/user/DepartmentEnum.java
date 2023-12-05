package com.webapp.erpapp.enums.user;

public enum DepartmentEnum {

    ADMINISTRATION("Administration"), MANAGEMENT("Management"), UI_UX("UI/UX"), DEV1("Dev1"), DEV2("Dev2");

    private String value;

    DepartmentEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
