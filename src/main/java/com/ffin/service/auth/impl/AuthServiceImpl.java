package com.ffin.service.auth.impl;

import com.ffin.service.auth.AuthService;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service("AuthService")
public class AuthServiceImpl implements AuthService {

    @Autowired
    JavaMailSender mailSender;


    public AuthServiceImpl(JavaMailSender mailSender) {
        this.mailSender = mailSender;
        System.out.println("Default Constructor :: AuthServiceImpl.AuthServiceImpl");
    }

    @Override
    public void sendEmail(String content) throws Exception {

    }


}
