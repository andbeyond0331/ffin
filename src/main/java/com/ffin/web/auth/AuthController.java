package com.ffin.web.auth;

import com.sun.xml.internal.ws.api.ha.StickyFeature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.web.bind.annotation.*;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import java.util.Random;


public class AuthController {

    @Autowired
    private JavaMailSender mailSender;

    //1.MimeMessage 객체 생성
    @RequestMapping(value = "sendMail", method = RequestMethod.GET)
    public void sendMailTest() throws Exception {
        String subject = "testMail";
        String content = "Java Mail Test";
        String from = "crud.ffin@gmail.com";
        String to = "crud.ffin@gmail.com";

        try{
            MimeMessage mail = mailSender.createMimeMessage();
            MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");

            mailHelper.setFrom(from);
            mailHelper.setTo(to);
            mailHelper.setSubject(subject);
            mailHelper.setText(content,true);

            mailSender.send(mail);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //2.MimeMessagePreparator (MimeMessage 객체화X)
    @RequestMapping(value = "sendMail", method = RequestMethod.GET)
    public void sendMailPre() throws Exception {

        String subject = "testMail";
        String content = "Java Mail Test";
        String from = "crud.ffin@gmail.com";
        String to = "crud.ffin@gmail.com";

        final MimeMessagePreparator preparator = new MimeMessagePreparator() {
            @Override
            public void prepare(MimeMessage mimeMessage) throws Exception {
                final MimeMessageHelper mailHelper = new MimeMessageHelper(mimeMessage, "UTF-8");

                mailHelper.setFrom(from);
                mailHelper.setTo(to);
                mailHelper.setSubject(subject);
                mailHelper.setText(content, true);
            }
        };

        try {
            mailSender.send(preparator);
        }catch (Exception e){
            e.printStackTrace();
        }
    }


}
