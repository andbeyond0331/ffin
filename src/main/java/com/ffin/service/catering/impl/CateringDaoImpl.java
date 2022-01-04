package com.ffin.service.catering.impl;


import com.ffin.common.Search;
import com.ffin.service.catering.CateringDao;
import com.ffin.service.domain.Catering;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
    캘린더에서 보여지는거랑 리스트에서 보여지는거랑 쿼리를 다르게 써야 함
	이유는 캘린더는 한번에 전체를 다 불러온다면,
	리스트는 페이지 처리가 가능하므로...... ㅜ껚

	서비스도 다르게 가려다가
	그냥 daoImpl에서 구분하면 될 것 같아서 cate라는 구분 값을 parameter로 던짐
	이거로 구분해서 mapper를 구분짓기로 ..... 꼒

*/
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
    public Map<String, Object> getCtList(Search search, String id, String cate) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("search",search);
        map.put("id", id);
        List<Catering> list = new ArrayList<>();

        if (cate.equals("list")){
            list = sqlSession.selectList("CateringMapper.getCtList2", map);
        }else {
            list = sqlSession.selectList("CateringMapper.getCtList", map);
        }
        map.put("list",list);
        return map;
    }

    @Override
    public Map<String, Object> getCtStatusList(Search search, String id, String ctStatusCode, String cate) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("search",search);
        map.put("id", id);
        map.put("ctStatusCode", ctStatusCode);
        List<Catering> list = new ArrayList<>();
        if (cate.equals("list")){
            list = sqlSession.selectList("CateringMapper.getCtStatusList2", map);
        }else {
            list = sqlSession.selectList("CateringMapper.getCtStatusList", map);
        }
        map.put("list",list);
        return map;
    }

    @Override
    public Map<String, Object> getCtDateList(Search search, String id, String cate) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("search",search);
        map.put("id", id);

        List<Catering> list = new ArrayList<>();
        if (cate.equals("list")){
            list = sqlSession.selectList("CateringMapper.getCtDateList2", map);
        }else {
            list = sqlSession.selectList("CateringMapper.getCtDateList", map);
        }

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
