package com.webapp.erpapp.enums.user;

public enum PositionEnum {

    INTERN("Intern"), JUNIOR("Junior"), SENIOR("Senior"), MANAGER("Manager"), SENIOR_MANAGER("Senior Manager"), OWNER("Owner");

    private String value;

    PositionEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
