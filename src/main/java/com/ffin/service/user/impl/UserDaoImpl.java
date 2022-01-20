package com.ffin.service.user.impl;

import antlr.NameSpace;
import com.ffin.common.Search;
import com.ffin.service.domain.User;
import com.ffin.service.user.UserDao;
import com.sun.xml.internal.ws.api.ha.StickyFeature;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import javax.xml.crypto.Data;
import java.util.Date;
import java.util.HashMap;
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

    @Override
    public void autoLogin(String userId, String sessionKey, Date sessionLimit) throws Exception {
        Map<String, Object> map = new HashMap<>();
        map.put("userId", userId);
        map.put("sessionKey", sessionKey);
        map.put("sessionLimit", sessionLimit);

        sqlSession.update("UserMapper.autoLogin", map);
    }

    @Override
    public User sessionKeyAuth(String sessionKey) throws Exception {
        System.out.println("UserDaoImpl.sessionKeyAuth");
        return sqlSession.selectOne("UserMapper.sessionKeyAuth", sessionKey);
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
    public int getBlackTotalCount(Search search) throws Exception {
        System.out.println("UserDaoImpl.getBlackTotalCount");
        return sqlSession.selectOne("UserMapper.getBlackTotalCount", search);
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
    public void updateProImg(User user) throws Exception {
        System.out.println("UserDaoImpl.updateProImg");
        sqlSession.update("UserMapper.updateProImg", user);
    }

    @Override
    public void updateUserMap(User user) throws Exception {
        System.out.println("UserDaoImpl.updateUserMap");
        sqlSession.update("UserMapper.updateUserMap",user);
    }

    @Override
    public String getUserId(String userName, String userPhone) throws Exception {
        System.out.println("UserDaoImpl.getUserId");

        Map<String, Object> map = new HashMap<>();

        map.put("userName", userName);
        map.put("userPhone", userPhone);

        return sqlSession.selectOne("UserMapper.getUserId", map);
    }

    @Override
    public String getUserIdForPassword(String userId, String userName, String userPhone) throws Exception {

        System.out.println("UserDaoImpl.getUserIdForPassword");

        Map<String, Object> map = new HashMap<>();
        map.put("userId", userId);
        map.put("userName", userName);
        map.put("userPhone", userPhone);

        return sqlSession.selectOne("UserMapper.getUserIdForPassword", map);
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
    public void updateReportCount(User user) throws Exception {
        System.out.println("UserDaoImpl.updateReportCount");
        sqlSession.update("UserMapper.updateReportCount",user);
    }

    @Override
    public void updateBlackStatus(User user) throws Exception {
        System.out.println("UserDaoImpl.updateBlackStatus");
        sqlSession.update("UserMapper.updateBlackStatus", user);
    }

    //HHJ
    @Override
    public void updateUserCurMap(User user) throws Exception {
        System.out.println("UserDaoImpl.updateUserCurMap");
        sqlSession.update("UserMapper.updateCurLaLo", user);
    }
}