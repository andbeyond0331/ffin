package com.ffin.service.user.impl;

import com.ffin.service.domain.User;
import com.ffin.service.user.UserDao;
import com.ffin.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

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
    public User getUser(String userId) throws Exception {
        System.out.println("UserServiceImpl.getUser");
        return userDao.getUser(userId);
    }
}
