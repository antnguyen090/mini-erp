package com.webapp.erpapp.enums.setting;

public enum CodeSettingEnum {

    USER("User"),
    CONTRACT("Contract"),
    ACCOUNTING("Accounting"),
    NOTIFICATION("Notification"),
    NOTIFICATION_COMMENT("Notification comment"),
    TASK("Task"),
    TASK_COMMENT("Task comment"),
    BOOK("Book");

    private String value;

    CodeSettingEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
