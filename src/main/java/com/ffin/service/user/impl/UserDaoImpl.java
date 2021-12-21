package com.ffin.service.user.impl;

import com.ffin.service.domain.User;
import com.ffin.service.user.UserDao;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository("userDaoImpl")
public class UserDaoImpl implements UserDao {

    ///Field
    @Autowired
    @Qualifier("sqlSessionTemplate")
    private SqlSession sqlSession;
    public void setSqlSession(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    ///Constructor
    public UserDaoImpl() {
        System.out.println(this.getClass());
    }

    ///Method
    @Override
    public User getUser(String userId) throws Exception {
        return sqlSession.selectOne("UserMapper.getUser", userId);
    }
}