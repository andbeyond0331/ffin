package com.ffin.service.auth;

import net.nurigo.java_sdk.api.GroupMessage;
import net.nurigo.java_sdk.api.Image;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.api.SenderID;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.mail.internet.MimeMessage;
import java.util.HashMap;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {	"classpath:config/context-auth.xml",
                                    "classpath:config/context-common.xml",
                                    "classpath:config/context-aspect.xml",
                                    "classpath:config/context-mybatis.xml",
                                    "classpath:config/context-transaction.xml" })
public class AuthServiceTest {

    @Autowired
    JavaMailSenderImpl mailSender;

    String api_key = "#ENTER_YOUR_OWN#";
    String api_secret = "#ENTER_YOUR_OWN#";

    Message message = new Message(api_key, api_secret);
    GroupMessage groupMessage = new GroupMessage(api_key, api_secret);
    Image image = new Image(api_key, api_secret);
    SenderID senderID;
    JSONObject result;
    JSONArray result_array;
    HashMap<String, String> params = new HashMap<String, String>();


    //@Test
    public void testMailSend() throws Exception {

        String subject = "TEST MAIL";
        String content = "TEST CONTENT GOGO";
        String from = "crud.ffin@gmail.com";
        String to = "crud.ffin@gmail.com";

        try {

            MimeMessage mail = mailSender.createMimeMessage();
            MimeMessageHelper mailHelper = new MimeMessageHelper(mail, "UTF-8");

            mailHelper.setFrom(from);
            mailHelper.setTo(to);
            mailHelper.setSubject(subject);
            mailHelper.setText(content,true);

            mailSender.send(mail);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //@Test
    public void testMailSendPre() throws Exception {

        String subject = "MERRY CHRISTMAS!";
        String content = "HAVE THE HAPPIEST OF X-MAS";
        String from = "crud.ffin@gmail.com";
        String to = "crud.ffin@gmail.com";

        try {
            final MimeMessagePreparator preparator = new MimeMessagePreparator() {
                @Override
                public void prepare(MimeMessage mimeMessage) throws Exception {
                    final MimeMessageHelper mailHelper = new MimeMessageHelper(mimeMessage, true,"UTF-8");

                    mailHelper.setFrom(from);
                    mailHelper.setTo(to);
                    mailHelper.setSubject(subject);
                    mailHelper.setText(content,true);

                }
            };

            mailSender.send(preparator);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void MessageTest() {
        try {
            // send
            params.put("to", "01000000000");
            params.put("from", "01000000000");
            params.put("type", "SMS");
            params.put("text", "Coolsms Testing Message!");
            params.put("mode", "test");
            result = message.send(params);
            assertNotNull(result.get("group_id"));

            // balance
            result = message.balance();
            assertNotNull(result.get("cash"));

            // sent
            params.clear();
            try {
                result = message.sent(params);
                assertNotNull(result.get("data"));
            } catch (Exception e) {
                result = (JSONObject) JSONValue.parse(e.getMessage());
                assertEquals(result.get("code"), "NoSuchMessage");
            }

            // status
            result = message.getStatus(params);
            assertNotNull(result.get("data"));

            // cancel
            params.put("mid", "MIDTEST");
            result = message.cancel(params);
            assertTrue(!result.isEmpty());
        } catch (Exception e) {
            fail(e.toString());
        }
    }


}
