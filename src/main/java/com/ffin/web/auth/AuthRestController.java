package com.ffin.web.auth;

import com.ffin.service.auth.AuthService;
import com.ffin.service.auth.Coolsms;
import com.ffin.service.truck.TruckService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.bind.annotation.*;

import javax.mail.internet.MimeMessage;
import java.util.Random;

@RestController
@RequestMapping("/auth/*")
public class AuthRestController {

    @Autowired
    private JavaMailSender mailSender;

    public AuthRestController(JavaMailSender mailSender) {
        this.mailSender = mailSender;
        System.out.println("Default Constructor :: AuthRestController.AuthRestController");
    };

    @RequestMapping(value = "json/emailAuth/{inputEmail:.+}", method = RequestMethod.GET)
    @ResponseBody
    public String emailAuth(@PathVariable String inputEmail) throws Exception {

        //data check
        System.out.println("Send Email Data");
        System.out.println("Email :: "+inputEmail);

        //난수생성
        Random random = new Random();
        int authNum = random.nextInt(888888)+111111;

        String setFrom = "crud.ffin@gmail.com";
        String toMail = inputEmail;
        String title = "F.FIN 이메일 인증번호입니다.";
        String content;
        content ="";
        content+="<p align =\"center\"><img alt=\"Logo\" src=\"http://localhost:8080/resources/image/logo_flat_point.png\" style=\"height:150px\"class=\"ban\"></p>";
        content+="<p align=\"center\" style=\"text-align: center; \">F.FIN에 가입해주셔서 감사합니다.&nbsp;</p><p align=\"center\" style=\"text-align: center; \">아래 번호를 입력해 인증을 완료해주세요.</p>";
        content += "<p align=\"center\" style=\"text-align: center; \">인증번호는 "+authNum+"입니다.&nbsp;</p>\r\n";
        content+="<p style=\"text-align: center; \" align=\"center\">감사합니다.&nbsp;</p><br><br>\r\n";


        try{
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
        } catch(Exception e){
            e.printStackTrace();
        }
        String authNumChk = Integer.toString(authNum);
        return authNumChk;
    }

    @RequestMapping(value = "json/joinAcceptMail/{getEmail:.+}", method = RequestMethod.GET)
    @ResponseBody
    public void joinAcceptMail(@PathVariable String getEmail) throws Exception {

        //data check
        System.out.println("Send Email Data");
        System.out.println("Email :: "+getEmail);

        //난수생성
//        Random random = new Random();
//        int authNum = random.nextInt(888888)+111111;

        String setFrom = "crud.ffin@gmail.com";
        String toMail = getEmail;
        String title = "F.FIN 가입승인 메일입니다.";
        String content;
        content ="";
        content+="<p align =\"center\"><img alt=\"Logo\" src=\"http://localhost:8080/resources/image/logo_flat_point.png\" style=\"height:150px\"class=\"ban\"></p>";
        content+="<p align=\"center\" style=\"text-align: center; \">F.FIN에 가입해주셔서 감사합니다.&nbsp;</p><p align=\"center\" style=\"text-align: center; \">가입승인절차가 완료 되었으니 사이트 이용에 참고바랍니다.</p>";
//        content += "<p align=\"center\" style=\"text-align: center; \">인증번호는 "+authNum+"입니다.&nbsp;</p>\r\n";
        content+="<p style=\"text-align: center; \" align=\"center\">감사합니다.&nbsp;</p><br><br>\r\n";


        try{
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
        } catch(Exception e){
            e.printStackTrace();
        }
    }

}
