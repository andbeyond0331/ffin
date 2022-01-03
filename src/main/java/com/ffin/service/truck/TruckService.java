package com.ffin.service.truck;

import com.ffin.common.Search;
import com.ffin.service.domain.Truck;
import com.ffin.service.domain.User;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;
import java.util.Map;

//==> 회원관리에서 CRUD 추상화/캡슐화한 DAO Interface Definition
public interface TruckService {

    // INSERT
    // 푸드트럭 회원가입
    public void addTruck(Truck truck) throws Exception ;

    // SELECT ONE
    // 푸드트럭 상세조회
    public Truck getTruck(String truckId) throws Exception ;

    // 새로 가입한 푸드트럭 보기(관리자)
    public void getNewTruck(Truck truck) throws Exception ;

    // UPDATE
    // 푸드트럭 수정...
    public void updateTruck(Truck truck) throws Exception ;

    // 푸드트럭 프로필 입력(수정)
    public void updateTruckProfile(Truck truck) throws Exception ;
    // 푸드트럭 내정보 수정
    public void updateTruckInfo(Truck truck) throws Exception ;
    // 푸드트럭 공지등록(수정)
    public void updateNotice(Truck truck) throws Exception ;
    // 푸드트럭 영업상태변경
    public void updateBusiStatus(Truck truck) throws Exception;

    // 푸드트럭 패스워드 변경
    public void updateTruckPassword(Truck truck) throws Exception ;

    // SELECT LIST
    // 푸드트럭 목록보기
    public Map<String, Object> getTruckList(Search search) throws Exception ;
    // 새로 가입한 푸드트럭 목록보기(관리자)
    public List<Truck> getNewTruckList(Search search) throws Exception ;

    // 푸드트럭 로그인
    public void login(Truck truck) throws Exception ;
    // 푸드트럭 로그아웃
    public void logout(Truck truck) throws Exception ;
    // 푸드트럭 아이디 찾기
    public String findTruckId(String truckName, String truckPhone) throws Exception ;
    // 푸드트럭 회원탈퇴
    public void byeTruck(Truck truck) throws Exception ;
    // 푸드트럭 파일업로드
    public void uploadFile(Truck truck) throws Exception ;
    // 푸드트럭 인증메일발송/가입승인메일발송
    public void sendEmail(Truck truck) throws Exception ;
    // 푸드트럭 이메일인증
    public void emailAuth(Truck truck) throws Exception ;

//    // 푸드트럭 휴대폰번호인증(메세지)
//    public void messageAuth(String truckPhone, String numStr) throws Exception;

    // 푸드트럭 캡차인증
    public void captchaAuth(Truck truck) throws Exception ;
    // 푸드트럭 사업자등록번호인증(OCR 기능 이용하여 관리자가 인증..)
    public void busiLiceAuth(Truck truck) throws Exception ;

    // 푸드트럭 아이디 중복체크
    public int checkDuId(String truckId) throws Exception;

    // 푸드트럭 상호 중복체크
    public int checkDuTruckName(String truckName) throws Exception;

    // 게시판 Page 처리를 위한 전체Row(totalCount)  return
    public int getTotalCount(Search search) throws Exception ;

    // 문자인증
    public void certifiedPhoneNumber(String truckPhoneNumber, int randomNumber);


    //로그인 유지
    void autoLogin(String truckId, String sessionKey, Date sessionLimit) throws Exception;
    //세션키 검증
    Truck SessionKeyAuth(String sessionKey) throws Exception;
}
