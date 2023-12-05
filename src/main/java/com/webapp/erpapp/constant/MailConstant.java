package com.webapp.erpapp.constant;

public class MailConstant {
    public final static String VERIFY_MAIL_SUBJECT = "VERIFY GMAIL";
    public final static String REGISTER_SUBJECT = "CONFIRM NEW USER REGISTRATION";
    public final static String REGISTER_CONTENT =
            "<p>Your account have been registered!!!</p>" +
            "<p>Please login through this <b>link</b>: http://localhost:8080/login</p>" +
                    "<hr><img src='cid:logoImage' />";
}
