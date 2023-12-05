package com.webapp.erpapp.api;

import com.webapp.erpapp.constant.MailConstant;
import com.webapp.erpapp.model.dto.DataMailDto;
import com.webapp.erpapp.model.request.user.UserRegisterRequest;
import com.webapp.erpapp.service.AuthService;
import com.webapp.erpapp.utils.ApplicationUtils;
import com.webapp.erpapp.utils.CacheUtils;
import com.webapp.erpapp.utils.JsonUtils;
import com.webapp.erpapp.utils.SendMailUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.mail.MessagingException;
import javax.validation.Valid;


@RestController
@RequestMapping("/api/v1/auth")
public class AuthApi {

    @Autowired
    private AuthService authService;

    @Autowired
    private CacheUtils cacheUtils;

    @Autowired
    private SendMailUtils sendMailUtils;

    @PostMapping("/register")
    public ResponseEntity<?> registerUser(@Valid @RequestBody UserRegisterRequest user) {
        String token = ApplicationUtils.generateVerifyMailCode();
        cacheUtils.createVerificationToken(token, JsonUtils.objectToJson(user));
        try {
            sendMailUtils.sendEmail(new DataMailDto(user.getEmail(),
                    MailConstant.VERIFY_MAIL_SUBJECT,
                    SendMailUtils.getContentVerifyMail(token)));
            return ResponseEntity.ok(true);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        return ResponseEntity.ok(false);
    }

    @PostMapping("/register/confirm")
    public ResponseEntity<?> confirmRegisterUser(String code) {
        String data = cacheUtils.getVerificationToken(code);
        if(data != null){
            UserRegisterRequest user = JsonUtils.jsonToObject(data, UserRegisterRequest.class);
            int success = authService.registerUser(user);
            if(success > 0) cacheUtils.deleteVerificationToken(code);
            return ResponseEntity.ok(success);
        }
        return ResponseEntity.badRequest().build();
    }
}
