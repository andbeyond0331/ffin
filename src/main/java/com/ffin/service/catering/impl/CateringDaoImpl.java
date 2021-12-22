package com.ffin.service.catering.impl;


import com.ffin.common.Search;
import com.ffin.service.catering.CateringDao;
import com.ffin.service.domain.Catering;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository("cateringDaoImpl")
public class CateringDaoImpl implements CateringDao {

    @Autowired
    @Qualifier("sqlSessionTemplate")
    private SqlSession sqlSession;
    public void setSqlSession(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    ///Constructor
    public CateringDaoImpl() {
        System.out.println(this.getClass());
    }

    @Override
    public Map<String, Object> getCtList(Search search, String id) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("search",search);
        map.put("id", id);

        List<Catering> list = sqlSession.selectList("CateringMapper.getCtList", map);
        map.put("list",list);
        return map;
    }

    @Override
    public Map<String, Object> getCtStatusList(Search search, String id, String ctStatusCode) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("search",search);
        map.put("id", id);
        map.put("ctStatusCode", ctStatusCode);

        List<Catering> list = sqlSession.selectList("CateringMapper.getCtStatusList", map);
        map.put("list",list);
        return map;
    }

    @Override
    public Map<String, Object> getCtDateList(Search search, String ctDate) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("search",search);
        map.put("ctDate", ctDate);

        List<Catering> list = sqlSession.selectList("CateringMapper.getCtDateList", map);
        map.put("list",list);
        return map;
    }

    @Override
    public Catering getCtTruckMenu(String truckId) throws Exception {
        return sqlSession.selectOne("CateringMapper.getCtTruckMenu", truckId);
    }

    @Override
    public Catering getCtDetail(int ctNo) throws Exception {
        return sqlSession.selectOne("CateringMapper.getCtDetail", ctNo);
    }

    @Override
    public void addCt(Catering catering) throws Exception {
        sqlSession.insert("CateringMapper.addCt", catering);
    }

    @Override
    public void updateCtResAdd(Catering catering) throws Exception {
        sqlSession.update("CateringMapper.updateCtResAdd", catering);
    }

    @Override
    public void updateCtMenuQty(int ctNo, int ctMenuMinQty, int ctMenuMaxQty) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("ctMenuMinQty",ctMenuMinQty);
        map.put("ctMenuMaxQty", ctMenuMaxQty);
        sqlSession.update("CateringMapper.updateCtMenuQty", map);
    }

    @Override
    public void updateCtRes(Catering catering) throws Exception {
        sqlSession.update("CateringMapper.updateCtRes", catering);
    }

    @Override
    public void updateCtResCancel(int cnNo, String ctStatusCode) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("cnNo",cnNo);
        map.put("ctStatusCode", ctStatusCode);
        System.out.println("cnNo = " + cnNo + ", ctStatusCode = " + ctStatusCode);
        // 쿼리문 수정 필요함
        // 경우에 따라 2 or 3 으로 나눈건데
        // 안먹으면 걍 condition 으로 나눠

        sqlSession.update("CateringMapper.updateCtResCancel", map);
    }
/*
    @Override
    public Map<String, Object> getUserResList(Search search, String userId, String resStatusCode) throws Exception {
        // userId에 따른 user의 예약 내역 dao
        // search Condition 으로 구분할 것 : controller 에서 구분해서 mapper에서 처리
         *//*
         21. 12. 20
         searchCondition 으로 나누려고 하고 있다.
         0이면 user의 전체 내역을
         1이면 user의 정보 중에서 resStatus를 확인하는 값을
         mapper에서 구분하는 것으로.
         그럼 애초에 status도 함께 넣는 메소드로 변경해야 할 듯.
         *//*

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("search",search);
        map.put("userId", userId);
        map.put("resStatusCode", resStatusCode);
        List<ResCatering> list = sqlSession.selectList("ResMapper.getUserResList", map);
        map.put("list",list);
        return map;
    }

    @Override
    public Map<String, Object> getTruckResList(Search search, String truckId) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("search",search);
        map.put("userId", truckId);
        List<AddCatering> list = sqlSession.selectList("ResMapper.getUserResList", map);
        map.put("list", list);
        return map;
    }

    @Override
    public void addRes(ResCatering resCatering) throws Exception {
        sqlSession.insert("ResMapper.addRes", resCatering);
    }

    @Override
    public void addCate(AddCatering addCatering) throws Exception {
        sqlSession.insert("ResMapper.addCate", addCatering);
    }

    @Override
    public ResCatering getUserRes(int resNo) throws Exception {
        return sqlSession.selectOne("ResMapper.getUserRes", resNo);
    }

    @Override
    public AddCatering getTruckServ(int servNo) throws Exception {
        return sqlSession.selectOne("ResMapper.getTruckServ", servNo);
    }

    @Override
    public void updateUserResStatus(int resNo, int resStatus, String memo) throws Exception {
        System.out.println("resNo = " + resNo + ", resStatus = " + resStatus + ", memo = " + memo);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("resNo",resNo);
        map.put("resStatus", resStatus);
        map.put("memo", memo);
        sqlSession.update("ResMapper.updateUserRes1", map);
    }

    @Override
    public void updateUserRes(ResCatering resCatering) throws Exception {
        sqlSession.update("ResMapper.updateUserRes2", resCatering);
    }

    @Override
    public List<AddCatering> getTruckAllServList(Search search) throws Exception {
        return sqlSession.selectList("ResMapper.getTruckAllServList", search);
    }*/
}
