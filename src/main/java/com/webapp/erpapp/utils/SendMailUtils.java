package com.webapp.erpapp.utils;

import com.webapp.erpapp.model.dto.DataMailDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;

@Component
public class SendMailUtils {

    @Autowired
    JavaMailSender javaMailSender;

    public Boolean sendEmail(DataMailDto dataMailDto) throws MessagingException {
        try {
            MimeMessage mimeMessage = javaMailSender.createMimeMessage();

            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage,true,"utf-8");

            helper.setFrom("nguyenquocthinh99@gmail.com","ERP-MINI");
            helper.setTo(dataMailDto.getTo());
            helper.setSubject(dataMailDto.getSubject());
            helper.setText(dataMailDto.getContent(),true);

            ClassPathResource resource = new ClassPathResource("logo.png");
            helper.addInline("logoImage",resource);

            javaMailSender.send(mimeMessage);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    public static String getContentVerifyMail(String token){
        return "<p>The code will expire after 3 minutes. Your code is: " + token + "</p>";
    }
}
