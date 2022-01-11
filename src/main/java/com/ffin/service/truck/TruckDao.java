package com.ffin.service.truck;

import com.ffin.common.Search;
import com.ffin.service.domain.Truck;

import java.util.Date;
import java.util.List;

//==> 회원관리에서 CRUD 추상화/캡슐화한 DAO Interface Definition
public interface TruckDao {

    // INSERT
    // 푸드트럭 회원가입
    public void addTruck(Truck truck) throws Exception ;

    // SELECT ONE
    // 푸드트럭 상세조회
    public Truck getTruck(String truckId) throws Exception ;
    // 공지 보기
    public Truck getNotice(String truckId) throws Exception ;

    // 푸드트럭 프로필보기
    public Truck getTruckProfile(String truckId) throws Exception;

    // 푸드트럭 내정보보기
    public Truck getTruckInfo(String truckId) throws Exception;

    // 새로 가입한 푸드트럭 보기(관리자)
    public void getNewTruck(Truck truck) throws Exception ;

    // UPDATE
    // 푸드트럭 수정...
    public void updateTruck(Truck truck) throws Exception ;
    // 푸드트럭 프로필 입력(수정)
    public void updateTruckProfile(Truck truck) throws Exception ;
    // 푸드트럭 내정보 수정
    public void updateTruckInfo(Truck truck) throws Exception ;
    // 푸드트럭 영업상태변경
    public void updateBusiStatus(Truck truck) throws Exception ;
    // 푸드트럭 공지등록(수정)
    public void updateNotice(Truck truck) throws Exception ;
    // 푸드트럭 패스워드 변경
    public void updateTruckPassword(Truck truck) throws Exception ;

    // SELECT LIST
    // 푸드트럭 목록보기
    public List<Truck> getTruckList(Search search) throws Exception ;

    // 새로 가입한 푸드트럭 목록보기(관리자)
    public List<Truck> getNewTruckList(Truck role) throws Exception ;

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

    public int getTotalCountSales(Search search, String truckId) throws Exception ;


    //로그인 유지
    void autoLogin(String truckId, String sessionKey, Date sessionLimit) throws Exception;
    //세션키 검증
    Truck SessionKeyAuth(String sessionKey) throws Exception;

    // 인증키 생성
    //int GetKey(String truckId, String truckKey) throws Exception;

    // 인증키 Y로 바꿔주는 메소드
    //int alter_truckKey(String truckId, String key) throws Exception;

    // 임시비밀번호 변경 메소드
    //int findPassword(String truckId, String truckEmail, String key);록


    // 마이페이지 판매목록
    public List<Object> getSalesList(Search search, String truckId)throws Exception;

}
