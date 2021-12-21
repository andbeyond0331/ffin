package com.ffin.service.user;

import com.ffin.service.domain.User;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {	"classpath:config/context-common.xml",
        "classpath:config/context-aspect.xml",
        "classpath:config/context-mybatis.xml",
        "classpath:config/context-transaction.xml" })
public class UserServiceTest {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    @Test
    public void getUser() throws Exception {

        User user = new User();

        user = userService.getUser("user01");

        Assert.assertEquals("user01", user.getUserId());

    }
}