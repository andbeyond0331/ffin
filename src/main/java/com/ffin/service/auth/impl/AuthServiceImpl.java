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

    @Override
    public void sendSMS(String userPhone, int randomNumber) throws Exception {

        String api_key = "NCSZ8KC6ERB3YVCA";
        String api_secret = "FYKRI2N8YKOR8BUGOKSLPQ3LKOJTYMMX";
        Message coolsms = new Message(api_key, api_secret);

        HashMap<String, String> params = new HashMap<String, String>();

        params.put("to", userPhone);
        params.put("from", "01071484785");
        params.put("type", "SMS");
        params.put("text", "인증번호는 " + "["+randomNumber+"]" + "입니다.");
        params.put("app_version", "test app 1.2");

        try {
            JSONObject obj = (JSONObject) coolsms.send(params);
            System.out.println(obj.toString());
        } catch (CoolsmsException e) {
            System.out.println(e.getMessage());
            System.out.println(e.getCode());
        }

    }



}
