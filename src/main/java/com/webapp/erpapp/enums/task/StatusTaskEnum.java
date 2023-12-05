package com.webapp.erpapp.enums.task;

public enum StatusTaskEnum {

    REGISTERED("Registered", new ActionChangeStatusTaskEnum[] {ActionChangeStatusTaskEnum.OPEN}),
    OPENED("Opened", new ActionChangeStatusTaskEnum[] {ActionChangeStatusTaskEnum.POSTPONE, ActionChangeStatusTaskEnum.CLOSE}),

    POSTPONED("Postponed", new ActionChangeStatusTaskEnum[] {ActionChangeStatusTaskEnum.REOPEN}),
    REOPENED("Reopened", new ActionChangeStatusTaskEnum[] {ActionChangeStatusTaskEnum.POSTPONE, ActionChangeStatusTaskEnum.CLOSE}),

    CLOSED("Closed", new ActionChangeStatusTaskEnum[] {ActionChangeStatusTaskEnum.REOPEN});

    private String value;
    private ActionChangeStatusTaskEnum[] actions;

    StatusTaskEnum(String value, ActionChangeStatusTaskEnum[] actions) {
        this.value = value;
        this.actions = actions;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public ActionChangeStatusTaskEnum[] getActions() {
        return actions;
    }

    public void setActions(ActionChangeStatusTaskEnum[] actions) {
        this.actions = actions;
    }
}
