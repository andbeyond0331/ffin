package com.ffin.service.truck.impl;

import com.ffin.common.Search;
import com.ffin.service.domain.Truck;
import com.ffin.service.domain.User;
import com.ffin.service.truck.TruckDao;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//==> 푸드트럭관리 Dao CRUD 구현
@Repository("truckDaoImpl")
public class TruckDaoImpl implements TruckDao {

    //Field
    @Autowired
    @Qualifier("sqlSessionTemplate")
    private SqlSession sqlSession;
    public void setSqlSession(SqlSession sqlSession) {

        this.sqlSession = sqlSession;
    }

    //Constructor
    public TruckDaoImpl(){
        System.out.println(this.getClass());
    }

    ///Method

    // 푸드트럭 회원가입
    @Override
    public void addTruck(Truck truck) throws Exception {
        sqlSession.insert("TruckMapper.addTruck",truck);
    }

    // 푸드트럭 상세조회
    @Override
    public Truck getTruck(String truckId) throws Exception {
        return sqlSession.selectOne("TruckMapper.getTruck", truckId);
    }
    // 공지 보기
    @Override
    public Truck getNotice(String truckId) throws Exception {
        return sqlSession.selectOne("TruckMapper.getNotice", truckId);
    }

    // 푸드트럭 프로필보기
    @Override
    public Truck getTruckProfile(String truckId) throws Exception {
        return sqlSession.selectOne("TruckMapper.getTruck",truckId);
    }
    // 푸드트럭 내정보보기
    @Override
    public Truck getTruckInfo(String truckId) throws Exception {
        return sqlSession.selectOne("TruckMapper.getTruck", truckId);
    }

    @Override
    public Truck getNewTruck(String truckId) throws Exception {
        return sqlSession.selectOne("TruckMapper.getNewTruck", truckId);
    }

    @Override
    public List<Truck> getNewTruckListByAdmin(Search search) throws Exception {
        return sqlSession.selectList("TruckMapper.getNewTruckListByAdmin", search);
    }

    @Override
    public void updateTruckJoin(Truck truck) throws Exception {
        System.out.println("TruckDaoImpl.updateTruckJoin");
        sqlSession.update("TruckMapper.updateTruckJoin", truck);
    }

    @Override
    public void updateTruckAvgStar(Truck truck) throws Exception {
        System.out.println("TruckDaoImpl.updateTruckAvgStar");
        sqlSession.update("TruckMapper.updateTruckAvgStar", truck);
    }

    // 푸드트럭 수정...
    @Override
    public void updateTruck(Truck truck) throws Exception {
        sqlSession.update("TruckMapper.updateTruck", truck);
    }
    // 푸드트럭 프로필 입력(수정)
    @Override
    public void updateTruckProfile(Truck truck) throws Exception {
        sqlSession.update("TruckMapper.updateTruck", truck);
    }
    // 푸드트럭 내정보 수정
    @Override
    public void updateTruckInfo(Truck truck) throws Exception {
        sqlSession.update("TruckMapper.updateTruckI", truck);
    }
    // 푸드트럭 영업상태변경
    @Override
    public void updateBusiStatus(Truck truck) throws Exception {
        sqlSession.update("TruckMapper.updateBusiStatus", truck);
    }
    // 푸드트럭 공지등록(수정)
    @Override
    public void updateNotice(Truck truck) throws Exception {
        sqlSession.update("TruckMapper.updateNotice", truck);
    }
    // 푸드트럭 패스워드 변경
    @Override
    public void updateTruckPassword(Truck truck) throws Exception {
        sqlSession.update("TruckMapper.updateTruck", truck);
    }
    // 푸드트럭 목록보기
    @Override
    public List<Truck> getTruckList(Search search) throws Exception {
        return sqlSession.selectList("TruckMapper.getTruckList", search);
    }

    @Override
    public List<Truck> getTruckListByAdmin(Search search) throws Exception {
        return sqlSession.selectList("TruckMapper.getTruckListByAdmin", search);
    }

    // 푸드트럭 로그인
    @Override
    public void login(Truck truck) throws Exception {

    }
    // 푸드트럭 로그아웃
    @Override
    public void logout(Truck truck) throws Exception {

    }

    // 푸드트럭 아이디 찾기
    @Override
    public String findTruckId(String truckName, String truckPhone) throws Exception {

        Map<String, Object> map = new HashMap<String, Object>();

        map.put("truckName", truckName);
        map.put("truckPhone", truckPhone);
        System.out.println("truckName = " + truckName + ", truckPhone = " + truckPhone);

        return sqlSession.selectOne("TruckMapper.findTruckId", map);
    }

    @Override
    public String getTruckIdForPassword(String truckId, String truckName, String truckPhone) throws Exception {

        System.out.println("TruckDaoImpl.getTruckIdForPassword");

        Map<String, Object> map = new HashMap<>();
        map.put("truckId", truckId);
        map.put("truckName", truckName);
        map.put("truckPhone", truckPhone);

        return sqlSession.selectOne("TruckMapper.getTruckIdForPassword", map);
    }


    @Override
    public void updatePassword(Truck truck) throws Exception {
        System.out.println("TruckDaoImpl.updatePassword");
        sqlSession.update("TruckMapper.updatePassword", truck);
    }

    // 푸드트럭 회원탈퇴
    @Override
    public void byeTruck(Truck truck) throws Exception {
        sqlSession.update("TruckMapper.byeTruck", truck);
    }
    // 푸드트럭 파일업로드
    @Override
    public void uploadFile(Truck truck) throws Exception {
        sqlSession.update("TruckMapper.updateTruck", truck);
    }
    // 푸드트럭 인증메일발송/가입승인메일발송
    @Override
    public void sendEmail(Truck truck) throws Exception {

    }
    // 푸드트럭 이메일인증
    @Override
    public void emailAuth(Truck truck) throws Exception {

    }

    // 푸드트럭 캡차인증
    @Override
    public void captchaAuth(Truck truck) throws Exception {

    }
    // 푸드트럭 사업자등록번호인증(OCR 기능 이용하여 관리자가 인증..)
    @Override
    public void busiLiceAuth(Truck truck) throws Exception {

    }

    // 푸드트럭 아이디 중복체크
    @Override
    public int checkDuId(String truckId) throws Exception {
        return sqlSession.selectOne("TruckMapper.checkDuId", truckId);
    }

    // 푸드트럭 상호 중복체크
    @Override
    public int checkDuTruckName(String truckName) throws Exception {
        return sqlSession.selectOne("TruckMapper.checkDuTruckName", truckName);
    }


    // 게시판 Page 처리를 위한 전체Row(totalCount)  return
    @Override
    public int getTotalCount(Search search) throws Exception {
        return sqlSession.selectOne("TruckMapper.getTotalCount", search);
    }

    // 판매목록 Page 처리를 위한 전체Row(totalCount)  return
    @Override
    public int getTotalCountSales(Search search, String truckId) throws Exception {

        Map<String, Object> map = new HashMap<>();

        map.put("search", search);
        map.put("truckId", truckId);

        return sqlSession.selectOne("PurchaseMapper.getTotalCount", map);
    }


    @Override
    public void autoLogin(String truckId, String sessionKey, Date sessionLimit) throws Exception {
        Map<String, Object> map = new HashMap<>();
        map.put("truckId", truckId);
        map.put("sessionKey", sessionKey);
        map.put("sessionLimit", sessionLimit);

        sqlSession.update("TruckMapper.autoLogin", map);
    }

    @Override
    public Truck SessionKeyAuth(String sessionKey) throws Exception {
        System.out.println("TruckDaoImpl.SessionKeyAuth");
        return sqlSession.selectOne("TruckMapper.SessionKeyAuth", sessionKey);
    }

    // 마이페이지 판매목록
    @Override
    public List<Object> getSalesList(Search search, String truckId)throws Exception{
        System.out.println("truckId = " + truckId);
        Map<String, Object> map = new HashMap<>();
        map.put("search", search);
        map.put("truckId", truckId);

        return sqlSession.selectList("PurchaseMapper.getSalesList", map);
    }

    @Override
    public Map<String, Object> truckNearBy(Search search, float la, float lo) throws Exception {
        System.out.println("search = " + search + ", la = " + la + ", lo = " + lo);
        Map<String, Object> map = new HashMap<>();
        map.put("search", search);
        map.put("la", la);
        map.put("lo", lo);
        List<Truck> list = sqlSession.selectList("TruckMapper.truckNearBy", map);
        System.out.println("list : " + list);
        map.clear();
        map.put("list", list);
        return map;
    }
    // HHJ
    @Override
    public Truck getTruck2(String userId, String truckId) throws Exception {
        Map<String, Object> map = new HashMap<>();
        map.put("userId", userId);
        map.put("truckId", truckId);
        return sqlSession.selectOne("TruckMapper.getTruck2", map);
    }

    @Override
    public Map<String, Object> getTruckListPopular() throws Exception {
        System.out.println("getTruckListPopular" );

        List<Truck> list = sqlSession.selectList("TruckMapper.truckPopular");
        System.out.println("list : " + list);
        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        return map;
    }


}
