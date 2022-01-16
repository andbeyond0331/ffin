package com.ffin.service.user;

import com.ffin.common.Search;
import com.ffin.service.domain.User;

import javax.xml.crypto.Data;
import java.util.Date;
import java.util.Map;

public interface UserService {

    //로그인 유지
    void autoLogin(String userId, String sessionKey, Date sessionLimit) throws Exception;
    //세션키 검증
    User sessionKeyAuth(String sessionKey) throws Exception;

    //회원가입
    public void addUserInfo(User user) throws Exception;
    //Id중복
    public boolean idChkDuplication(String userId) throws Exception;

    //회원정보
    public User getUser(String userId) throws Exception;
    //totalPoint
    public User getUserTotalPoint(String userId) throws Exception;
    //reportCount
    public User getReportCount(String userId) throws Exception;
    //회원목록
    public Map<String, Object> getUserList(Search search) throws Exception;
    //블랙목록
    public Map<String, Object> getBlackList(Search search) throws Exception;

    //내정보수정
    public void updateUserInfo(User user) throws Exception;
    //프로필수정
    public void updateUserProfile(User user) throws Exception;
    //프로필이미지 수정
    public void updateProImg(User user) throws Exception;
    //위치수정
    public void updateUserMap(User user) throws Exception;

    //Id찾기
    public String getUserId(String userName, String userPhone) throws Exception;
    //pw변경을 위한 findUser
    public String getUserIdForPassword(String userId, String userName, String userPhone) throws Exception;
    //임시비밀번호 발송&저장
    public void sendSMSForPassword(String userId, String userPhone, int tempPassword) throws Exception;
    //PW변경
    public void updatePassword(User user) throws Exception;
    //phone auth
    public void sendSMS(String inputPhone, int randomNumber);


    //회원탈퇴
    public void updateUserByeStatus(User user) throws Exception;
    //블랙여부
    public void updateBlackStatus(User user) throws Exception;
}