package com.ffin.service.user.impl;

import com.ffin.common.Search;
import com.ffin.service.domain.User;
import com.ffin.service.user.UserDao;
import com.ffin.service.user.UserService;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import javax.xml.crypto.Data;
import java.util.*;

@Service("userServiceImpl")
public class UserServiceImpl implements UserService {

    ///Field
    @Autowired
    @Qualifier("userDaoImpl")
    private UserDao userDao;
    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    ///Constructor
    public UserServiceImpl() {
        System.out.println(this.getClass());
    }

    @Override
    public void autoLogin(String userId, String sessionKey, Date sessionLimit) throws Exception {
        System.out.println("UserServiceImpl.autoLogin");
        userDao.autoLogin(userId, sessionKey, sessionLimit);
    }

    @Override
    public User sessionKeyAuth(String sessionKey) throws Exception {
        System.out.println("UserServiceImpl.SessionKeyAuth");
        return userDao.sessionKeyAuth(sessionKey);
    }

    ///Method
    @Override
    public void addUserInfo(User user) throws Exception {
        System.out.println("UserServiceImpl.addUserInfo");
        userDao.addUserInfo(user);
    }

    @Override
    public boolean idChkDuplication(String userId) throws Exception {
        System.out.println("UserServiceImpl.idChkDuplication");
        boolean result = true;
        User user = userDao.getUser(userId);
        if(user != null){
            result = false;
        }
        return result;
    }

    @Override
    public User getUser(String userId) throws Exception {
        System.out.println("UserServiceImpl.getUser");
        return userDao.getUser(userId);
    }

    @Override
    public User getUserTotalPoint(String userId) throws Exception {
        System.out.println("UserServiceImpl.getUserTotalPoint");
        return userDao.getUserTotalPoint(userId);
    }

    @Override
    public User getReportCount(String userId) throws Exception {
        System.out.println("UserServiceImpl.getReportCount");
        return userDao.getReportCount(userId);
    }

    @Override
    public Map<String, Object> getUserList(Search search) throws Exception {
        System.out.println("UserServiceImpl.getUserList");
        List<User> list = userDao.getUserList(search);
        int totalCount = userDao.getTotalCount(search);

        Map<String, Object>map = new HashMap<String, Object>();
        map.put("list", list);
        map.put("totalCount", new Integer(totalCount));

        return map;
    }

    @Override
    public Map<String, Object> getBlackList(Search search) throws Exception {
        System.out.println("UserServiceImpl.getBlackList");
        List<User> list = userDao.getBlackList(search);
        int totalCount = userDao.getBlackTotalCount(search);

        Map<String, Object>map = new HashMap<String, Object>();
        map.put("list", list);
        map.put("totalCount", new Integer(totalCount));

        return map;
    }

    @Override
    public void updateUserInfo(User user) throws Exception {
        System.out.println("UserServiceImpl.updateUserInfo");
        userDao.updateUserInfo(user);
    }

    @Override
    public void updateUserProfile(User user) throws Exception {
        System.out.println("UserServiceImpl.updateUserProfile");
        userDao.updateUserProfile(user);
    }

    @Override
    public void updateProImg(User user) throws Exception {
        System.out.println("UserServiceImpl.updateProImg");
        userDao.updateProImg(user);
    }

    @Override
    public void updateUserMap(User user) throws Exception {
        System.out.println("UserServiceImpl.updateUserMap");
        userDao.updateUserMap(user);
    }

    @Override
    public String getUserId(String userName, String userPhone) throws Exception {

        System.out.println("UserServiceImpl.getUserId");
        return userDao.getUserId(userName, userPhone);
    }

    @Override
    public String getUserIdForPassword(String userId, String userName, String userPhone) throws Exception {

        System.out.println("UserServiceImpl.getUserIdForPassword");
        return userDao.getUserIdForPassword(userId, userName, userPhone);
    }

    //임시비밀번호 전송&저장
    @Override
    public void sendSMSForPassword(String userId, String userPhone, int tempPassword) throws Exception {

        String api_key = "NCSZ8KC6ERB3YVCA";
        String api_secret = "FYKRI2N8YKOR8BUGOKSLPQ3LKOJTYMMX";
        
        User user = userDao.getUser(userId);
        String userName = user.getUserName();

        Message coolsms = new Message(api_key, api_secret); // 4 params(to, from, type, text) are mandatory. must be filled
        HashMap<String, String> params = new HashMap<String, String>();

        params.put("to", userPhone); // 수신전화번호
        params.put("from", "01071484785"); // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
        params.put("type", "SMS");
        params.put("text", "[TEST]"+userName+"님의 임시 비밀번호는 " + "["+tempPassword+"]" + " 입니다." +
                            " 로그인 후 비밀번호를 변경해주세요."); // 문자 내용 입력
        params.put("app_version", "test app 1.2"); // application name and version

        try { JSONObject obj = (JSONObject) coolsms.send(params);
            System.out.println(obj.toString());
        } catch (CoolsmsException e) {
            System.out.println(e.getMessage());
            System.out.println(e.getCode());
        }

        user.setUserPassword(String.valueOf(tempPassword));
        System.out.println("임시비밀번호 전송 후 DB 업데이트 확인 :: "+user);

        userDao.updatePassword(user);

    }

    @Override
    public boolean nowPwCheck(String userId, String userPassword) throws Exception {
        System.out.println("UserServiceImpl.nowPwCheck");
        boolean result = true;
        User user = userDao.getUser(userId);
        if(!Objects.equals(user.getUserPassword(), userPassword)) {
            result = false;
        }
        return result;
    }

    @Override
    public void updatePassword(User user) throws Exception {
        System.out.println("UserServiceImpl.updatePassword");
        userDao.updatePassword(user);
    }

    @Override
    public void sendSMS(String inputPhone, int randomNumber) {

        String api_key = "NCSZ8KC6ERB3YVCA";
        String api_secret = "FYKRI2N8YKOR8BUGOKSLPQ3LKOJTYMMX";

        Message coolsms = new Message(api_key, api_secret); // 4 params(to, from, type, text) are mandatory. must be filled
        HashMap<String, String> params = new HashMap<String, String>();

        params.put("to", inputPhone); // 수신전화번호
        params.put("from", "01071484785"); // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
        params.put("type", "SMS");
        params.put("text", "[TEST] 인증번호는" + "["+randomNumber+"]" + "입니다."); // 문자 내용 입력
        params.put("app_version", "test app 1.2"); // application name and version

        try { JSONObject obj = (JSONObject) coolsms.send(params);
            System.out.println(obj.toString());
        } catch (CoolsmsException e) {
            System.out.println(e.getMessage());
            System.out.println(e.getCode());
        }
    }

    @Override
    public void updateUserByeStatus(User user) throws Exception {
        System.out.println("UserServiceImpl.updateUserByeStatus");
        userDao.updateUserByeStatus(user);
    }

    @Override
    public void updateReportCount(User user) throws Exception {
        System.out.println("UserServiceImpl.updateReportCount");
        userDao.updateReportCount(user);
    }

    @Override
    public void updateBlackStatus(User user) throws Exception {
        System.out.println("UserServiceImpl.updateBlackStatus");
        userDao.updateBlackStatus(user);
    }

}
