package com.ffin.service.truck.impl;

import com.ffin.common.Search;
import com.ffin.service.domain.Truck;
import com.ffin.service.truck.TruckDao;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

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
        return sqlSession.selectOne("TruckMapper.getTruck", truckId);
    }

    // 푸드트럭 프로필보기
    @Override
    public Truck getTruckProfile(String truckId) throws Exception {
        return sqlSession.selectOne("TruckMapper.getTruck",truckId);
    }
    // 푸드트럭 내정보보기
    @Override
    public Truck getTruckInfo(String truckid) throws Exception {
        return sqlSession.selectOne("TruckMapper.getTruck", truckid);
    }
    // 새로 가입한 푸드트럭 보기(관리자)
    @Override
    public void getNewTruck(Truck truck) throws Exception {

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
        sqlSession.update("TruckMapper.updateTruck", truck);
    }
    // 푸드트럭 영업상태변경
    @Override
    public void updateBusiStatus(Truck truck) throws Exception {
        sqlSession.update("TruckMapper.updateTruck", truck);
    }
    // 푸드트럭 공지등록(수정)
    @Override
    public void updateNotice(Truck truck) throws Exception {
        sqlSession.update("TruckMapper.updateTruck", truck);
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
    // 새로 가입한 푸드트럭 목록보기(관리자)
    @Override
    public List<Truck> getNewTruckList(Search search) throws Exception {
        return null;
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
    // 푸드트럭 회원탈퇴
    @Override
    public void byeTruck(Truck truck) throws Exception {
        sqlSession.update("TruckMapper.updateTruck", truck);
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
    // 푸드트럭 휴대폰번호인증(메세지)
    @Override
    public void messageAuth(Truck truck) throws Exception {

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

    // 게시판 Page 처리를 위한 전체Row(totalCount)  return
    @Override
    public int getTotalCount(Search search) throws Exception {
        return sqlSession.selectOne("TruckMapper.getTotalCount", search);
    }
}
