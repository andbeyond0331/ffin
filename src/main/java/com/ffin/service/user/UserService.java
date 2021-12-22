package com.ffin.service.user;

import com.ffin.common.Search;
import com.ffin.service.domain.User;

import java.util.Map;

public interface UserService {

    //회원가입
    public void addUserInfo(User user) throws Exception;
    //Id중복
    public boolean idChkDuplication(String userId) throws Exception;

    //회원정보
    public User getUser(String userId) throws Exception;
    //회원목록
    public Map<String, Object> getUserList(Search search) throws Exception;
    //블랙목록
    public Map<String, Object> getBlackList(Search search) throws Exception;

    //내정보수정
    public void updateUserInfo(User user) throws Exception;
    //프로필수정
    public void updateUserProfile(User user) throws Exception;
    //위치수정
    public void updateUserMap(User user) throws Exception;

    //Id찾기
    public void getUserId(String userId) throws Exception;
    //PW변경
    public void updatePassword(User user) throws Exception;


    //회원탈퇴
    public void updateUserByeStatus(User user) throws Exception;
    //블랙여부
    public void updateBlackStatus(User user) throws Exception;
}