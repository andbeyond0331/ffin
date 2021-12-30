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
    public Catering getResDetail(int ctNo) throws Exception {
        return sqlSession.selectOne("CateringMapper.getResDetail", ctNo);
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
        map.put("ctNo",ctNo);
        map.put("ctMenuMinQty",ctMenuMinQty);
        map.put("ctMenuMaxQty", ctMenuMaxQty);
        sqlSession.update("CateringMapper.updateCtMenuQty", map);
    }

    @Override
    public void updateCtRes(Catering catering) throws Exception {
        sqlSession.update("CateringMapper.updateCtRes", catering);
    }

    @Override
    public void updateCtResCancel(int ctNo, String ctStatusCode) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("ctNo",ctNo);
        map.put("ctStatusCode", ctStatusCode);
        System.out.println("cnNo = " + ctNo + ", ctStatusCode = " + ctStatusCode);
        // 쿼리문 수정 필요함
        // 경우에 따라 2 or 3 으로 나눈건데
        // 안먹으면 걍 condition 으로 나눠

        sqlSession.update("CateringMapper.updateCtResCancel", map);
    }
}
