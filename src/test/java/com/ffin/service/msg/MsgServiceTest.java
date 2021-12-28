package com.ffin.service.msg;

import com.ffin.service.domain.User;
import com.ffin.service.user.UserService;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
        "classpath:config/context-auth.xml",
        "classpath:config/context-common.xml",
        "classpath:config/context-aspect.xml",
        "classpath:config/context-mybatis.xml",
        "classpath:config/context-transaction.xml" })

public class MsgServiceTest {

    @Autowired
    @Qualifier("msgServiceImpl")
    private MsgService msgService;

    //@Test
  /*  public void messageList() throws Exception {

        User user = new User();

        user = userService.getUser("user01");

        Assert.assertEquals("user01", user.getUserId());

    }*/
    /*
      public List<Msg> messageList(Msg to) throws Exception;
    public ArrayList<Msg> roomContentList(Msg to) throws Exception;
    public int messageSendInlist(Msg to) throws Exception;
     */
}