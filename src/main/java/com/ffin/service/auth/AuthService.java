package com.ffin.service.auth;

public interface AuthService {

    //email auth
    public void sendEmail(String content) throws Exception;

    //phone auth
    public void sendSMS(String userPhone, int randomNumber) throws Exception;
}
