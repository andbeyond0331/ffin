package com.ffin.service.user;

import com.ffin.common.Search;
import com.ffin.service.domain.User;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.Map;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {	"classpath:config/context-common.xml",
                                    "classpath:config/context-aspect.xml",
                                    "classpath:config/context-mybatis.xml",
                                    "classpath:config/context-transaction.xml" })
public class UserServiceTest {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;


    //@Test
    public void testAddUserInfo() throws Exception {
        User user = new User();
        user.setUserId("testId");
        user.setUserPassword("testPW");
        user.setUserName("testName");
        user.setUserPhone("010-0000-0000");
        user.setUserBirth("2021-11-12");
        user.setUserAddr("서울시 종로구");
        user.setUserAddrDetail("탑골공원");
        user.setUserEmail("testId@test.com");
        user.setUserEmailStatus(1);
        user.setUserRegDate("2021-12-25");

        userService.addUserInfo(user);
    }

    //@Test
    public void testIdChkDuplication() throws Exception {
        System.out.println("UserServiceTest.testIdChkDuplication");
        //Assert.assertFalse(userService.idChkDuplication("testId"));
        Assert.assertTrue(userService.idChkDuplication("testTest"));
    }

    //@Test
    public void testGetUser() throws Exception {
        User user = new User();
        user = userService.getUser("user03");
    }

    //@Test
    public void testGetUserTotalPoint() throws Exception {
        User user = new User();
        user = userService.getUserTotalPoint("test01");
    }

    //@Test
    public void testGetReportCount() throws Exception {
        User user = new User();
        user = userService.getReportCount("test01");
    }

    @Test
    public void testGetUserList() throws Exception {
        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(3);
        Map<String, Object> map = userService.getUserList(search);
        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>"+map);

        List<Object> list = (List<Object>)map.get("list");
        for( Object i : list) {
            System.out.println(i);
        }

    }

    //@Test
    public void testUpdateUserInfo() throws Exception{
        User user = userService.getUser("test01");
        Assert.assertNotNull(user);

        user.setUserName("testUpdate");
        user.setUserPhone("010-7777-8888");
        user.setUserBirth("2021-12-15");
        user.setUserAddr("updateAddr");
        user.setUserAddrDetail("updateAddrDetail");
        user.setUserEmail("update@test.com");
        user.setUserEmailStatus(2);
        user.setUserRegDate("2020-02-20");

        userService.updateUserInfo(user);
    }

    //@Test
    public void testUpdateUserProfile() throws Exception{
        User user = userService.getUser("test01");
        Assert.assertNotNull(user);

        user.setUserProImg("testProImg");
        user.setUserFavMenu("updateFavMenu");
        user.setUserFavPlace("updateFavPlace");
        user.setUserFavPlaceDetail("updateFavPlaceDetail");
        user.setUserIntro("HiHello");

        userService.updateUserProfile(user);
    }

    //@Test
    public void testUpdateUserMap() throws Exception{
        User user = userService.getUser("test01");
        Assert.assertNotNull(user);

        user.setUserMapLa(37.57052334677693);
        user.setUserMapLo(126.98531068460967);

        userService.updateUserMap(user);
    }

    //@Test
    public void testUpdatePassword() throws Exception{
        User user = userService.getUser("test01");
        Assert.assertNotNull(user);

        user.setUserPassword("updatePassword");

        userService.updatePassword(user);
    }

    //@Test
    public void testUpdateUserByeStatus() throws Exception {
        User user = userService.getUser("test01");
        Assert.assertNotNull(user);

        user.setUserByeReason(2);

        userService.updateUserByeStatus(user);
    }

    //@Test
    public void testUpdateBlackStatus() throws Exception {
        User user = userService.getUser("test01");
        Assert.assertNotNull(user);

        userService.updateBlackStatus(user);
    }

//    @Test
//    public void testGetUserIdByPhone() throws Exception {
//        User user = user.getUserId("");
//
//    }
}