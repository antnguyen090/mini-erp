package com.webapp.erpapp.enums.Notification;

public enum StatusNotificationEnum {
    ACTIVE("Active"), INACTIVE("Inactive");

    private String value;
    
    StatusNotificationEnum(String value) {
        this.value = value;
    }
    public String getValue() {
        return value;
    }
    public void setValue(String value) {
        this.value = value;
    }
}
