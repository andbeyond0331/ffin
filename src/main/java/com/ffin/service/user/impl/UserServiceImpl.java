package com.ffin.service.user.impl;

import com.ffin.common.Search;
import com.ffin.service.domain.User;
import com.ffin.service.user.UserDao;
import com.ffin.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        int totalCount = userDao.getTotalCount(search);

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
    public void updateUserMap(User user) throws Exception {
        System.out.println("UserServiceImpl.updateUserMap");
        userDao.updateUserMap(user);
    }

    @Override
    public void getUserId(String userId) throws Exception {
        System.out.println("UserServiceImpl.getUserId");
        userDao.getUserId(userId);
    }

    @Override
    public void updatePassword(User user) throws Exception {
        System.out.println("UserServiceImpl.updatePassword");
        userDao.updatePassword(user);
    }

    @Override
    public void updateUserByeStatus(User user) throws Exception {
        System.out.println("UserServiceImpl.updateUserByeStatus");
        userDao.updateUserByeStatus(user);
    }

    @Override
    public void updateBlackStatus(User user) throws Exception {
        System.out.println("UserServiceImpl.updateBlackStatus");
        userDao.updateBlackStatus(user);
    }

}
