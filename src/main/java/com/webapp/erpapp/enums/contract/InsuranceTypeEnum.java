package com.webapp.erpapp.enums.contract;

public enum InsuranceTypeEnum {

    HEALTH_INSURANCE("Health insurance"), SOCIAL_INSURANCE("Social insurance");

    private String value;

    InsuranceTypeEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
