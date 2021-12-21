package com.ffin.service.user;

import com.ffin.service.domain.User;

public interface UserDao {

    public User getUser(String userId) throws Exception;

}
