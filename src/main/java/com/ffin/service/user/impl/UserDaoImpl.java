package com.ffin.service.user.impl;

import com.ffin.common.Search;
import com.ffin.service.domain.User;
import com.ffin.service.user.UserDao;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

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
    public void addUserInfo(User user) throws Exception {
        System.out.println("UserDaoImpl.addUserInfo");
        sqlSession.insert("UserMapper.addUserInfo",user);
    }

    @Override
    public User getUser(String userId) throws Exception {
        System.out.println("UserDaoImpl.getUser");
        return sqlSession.selectOne("UserMapper.getUser", userId);
    }

    @Override
    public User getUserTotalPoint(String userId) throws Exception {
        System.out.println("UserDaoImpl.getUserTotalPoint");
        return sqlSession.selectOne("UserMapper.getUserTotalPoint", userId);
    }

    @Override
    public User getReportCount(String userId) throws Exception {
        System.out.println("UserDaoImpl.getReportCount");
        return sqlSession.selectOne("UserMapper.getReportCount",userId);
    }

    @Override
    public List<User> getUserList(Search search) throws Exception {
        System.out.println("UserDaoImpl.getUserList");
        return sqlSession.selectList("UserMapper.getUserList", search);
    }

    @Override
    public List<User> getBlackList(Search search) throws Exception {
        System.out.println("UserDaoImpl.getBlackList");
        return sqlSession.selectList("UserMapper.getBlackList", search);
    }

    @Override
    public int getTotalCount(Search search) throws Exception {
        System.out.println("UserDaoImpl.getTotalCount");
        return sqlSession.selectOne("UserMapper.getTotalCount", search);
    }

    @Override
    public void updateUserInfo(User user) throws Exception {
        System.out.println("UserDaoImpl.updateUserInfo");
        sqlSession.update("UserMapper.updateUserInfo", user);
    }

    @Override
    public void updateUserProfile(User user) throws Exception {
        System.out.println("UserDaoImpl.updateUserProfile");
        sqlSession.update("UserMapper.updateUserProfile", user);
    }

    @Override
    public void updateUserMap(User user) throws Exception {
        System.out.println("UserDaoImpl.updateUserMap");
        sqlSession.update("UserMapper.updateUserMap",user);
    }

    @Override
    public void getUserId(String userId) throws Exception {
        System.out.println("UserDaoImpl.getUserId");
        sqlSession.selectOne("UserMapper.getUserId", userId);
    }

    @Override
    public void updatePassword(User user) throws Exception {
        System.out.println("UserDaoImpl.updatePassword");
        sqlSession.update("UserMapper.updatePassword", user);
    }

    @Override
    public void updateUserByeStatus(User user) throws Exception {
        System.out.println("UserDaoImpl.updateUserByeStatus");
        sqlSession.update("UserMapper.updateUserByeStatus", user);
    }

    @Override
    public void updateBlackStatus(User user) throws Exception {
        System.out.println("UserDaoImpl.updateBlackStatus");
        sqlSession.update("UserMapper.updateBlackStatus", user);
    }
}