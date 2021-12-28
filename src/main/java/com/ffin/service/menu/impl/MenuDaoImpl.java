package com.ffin.service.menu.impl;

import com.ffin.common.Search;
import com.ffin.service.domain.Menu;
import com.ffin.service.domain.OptionGroup;
import com.ffin.service.menu.MenuDao;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import javax.swing.text.html.Option;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository("menuDaoImpl")
public class MenuDaoImpl implements MenuDao {

    ///FFF
    @Autowired
    @Qualifier("sqlSessionTemplate")
    private SqlSession sqlSession;

    public void setSqlSession(SqlSession sqlSession){
        this.sqlSession = sqlSession;
    }

    public MenuDaoImpl(){

        System.out.println(this.getClass());
    }

    ///MMM

//    @Override
//    public void addMenu(Menu menu) throws Exception {
//
//        sqlSession.insert("MenuMapper.addMenu", menu);
//
//    }

    //menu 랑 optionGroup 같이 insert하는 방법 고안1 -> 헷갈려서 실패
//    public void addMenu(List list) throws Exception{
//        System.out.println("optionGroup list : " + list);
//        Map map = new HashMap();
//        map.put("list", list);
//        System.out.println("map에 들어간 것 확인 : " +map.get("list"));
//        sqlSession.insert("MenuMapper.addMenu", map);
//    }

    //menu 랑 optionGroup 같이 insert하는 방법 고안2
    @Override
    public int addMenu(Menu menu) throws Exception{
        System.out.println("MenuDaoImpl.addMenu");
        sqlSession.insert("MenuMapper.addMenu",menu);
        int menuNo = menu.getMenuNo();
        return menuNo;
    }

//    @Override
//    public void addOptionGroup(OptionGroup optionGroup) throws Exception {
//
//        sqlSession.insert("MenuMapper.addOptionGroup", optionGroup);
//    }

    //menu 랑 optionGroup 같이 insert하는 방법 고안2
    @Override
    public void addOptionGroup(List list) throws Exception{
        System.out.println("optionGroup list : " + list);
        Map map = new HashMap();
        map.put("list",list);
        System.out.println("map.get(\"list\") : " + map.get("list"));
        sqlSession.insert("MenuMapper.addOptionGroup",map);
    }

    //menu랑 optionGroup 같이 insert하는 방법 고안2 를 위한 getOptionGroupList
    @Override
    public List<OptionGroup> getOptionGroupList(int optionGroupNo) throws Exception{
        return sqlSession.selectList("MenuMapper.getOptionGroupList", optionGroupNo);
    }

    @Override
    public Menu getMenu(int menuNo) throws Exception {
        return sqlSession.selectOne("MenuMapper.getMenu", menuNo);
    }

    //옵션 그룹의 모든 옵션 받아오기
    @Override
    public Map<String, Object> getOptionGroup(Search search, int optionGroupNo) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("search", search);
        map.put("optionGroupNo", optionGroupNo);

        List<OptionGroup> list = sqlSession.selectList("MenuMapper.getOptionGroup", map);

        System.out.println("list : " + list);

        map.clear();
        map.put("list", list);

        return map;
    }

    // 옵션 하나 받아오기
    @Override
    public OptionGroup getOption(int optionNo) throws Exception {
        return sqlSession.selectOne("MenuMapper.getOption", optionNo);
    }

    @Override
    public Map<String, Object> getMenuList(Search search, String truckId) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("search", search);
        map.put("menuTruckId", truckId);
        List<Menu> list = sqlSession.selectList("MenuMapper.getMenuList", map);
        System.out.println("list : " + list);

        map.clear();
        map.put("list", list);

        return map;
    }

    @Override
    public void updateMenu(Menu menu) throws Exception {

        sqlSession.update("MenuMapper.updateMenu", menu);

    }

    @Override
    public void updateOptionGroup(OptionGroup optionGroup) throws Exception {

        sqlSession.update("MenuMapper.updateOptionGroup", optionGroup);
    }

    // 하나의 메뉴와 그 메뉴에 연결된 모든 옵션그룹과 그 안의 여러 옵션들을 삭제
    @Override
    public void deleteMenu(Menu menu) throws Exception {
        sqlSession.delete("MenuMapper.deleteOptionGroupMenu", menu.getMenuNo());
        sqlSession.delete("MenuMapper.deleteMenu", menu);
    }

    // 한 번에 하나의 옵션 그룹과 그 안의 여러 옵션 삭제
    @Override
    public void deleteOptionGroup(OptionGroup optionGroup) throws Exception {

        sqlSession.delete("MenuMapper.deleteOptionGroup", optionGroup);
    }

    // 한 번에 하나의 옵션 삭제
    @Override
    public void deleteOption(OptionGroup optionGroup) throws Exception {
        sqlSession.delete("MenuMapper.deleteOption", optionGroup);

    }

    @Override
    public int getTotalCount(Search search) throws Exception {
        return sqlSession.selectOne("MenuMapper.getTotalCount",search);
    }
}
