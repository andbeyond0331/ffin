package com.ffin.service.menu.impl;

import com.ffin.common.Search;
import com.ffin.service.domain.Menu;
import com.ffin.service.domain.OptionGroup;
import com.ffin.service.menu.MenuDao;
import com.ffin.service.menu.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("menuServiceImpl")
public class MenuServiceImpl implements MenuService {

    //FFF
    @Autowired
    @Qualifier("menuDaoImpl")
    private MenuDao menuDao;
    public void setMenuDao(MenuDao menuDao){
        this.menuDao = menuDao;
    }

    ///CCC
    public MenuServiceImpl(){

        System.out.println(this.getClass());
    }

    ///MMM
//    @Override
//    public void addMenu(Menu menu) throws Exception {
//        System.out.println("MenuServiceImpl.addMenu");
//        menuDao.addMenu(menu);
//    }
    //메뉴와 옵션그룹 한 번에 insert하는 방법 고안1 -> 헷갈려서 실패
//    public void addMenu(List list) throws Exception {
//        System.out.println("MenuServiceImpl.addMenu");
//        menuDao.addMenu(list);
//
//    }

    //메뉴와 옵션그룹 한 번에 insert하는 방법 고안2
    @Override
    public int addMenu(Menu menu) throws Exception{
        System.out.println("MenuServiceImpl.addMenu");
        return menuDao.addMenu(menu);
    }

//    @Override
//    public void addOptionGroup(OptionGroup optionGroup) throws Exception {
//        menuDao.addOptionGroup(optionGroup);
//    }

    //메뉴와 옵션그룹 한 번에 insert하는 방법 고안2
    @Override
    public void addOptionGroup(List list) throws Exception{
        System.out.println("MenuServiceImpl.addOptionGroup");
        menuDao.addOptionGroup(list);
    }

    //메뉴와 옵션그룹 한 번에 insert하는 방법 고안2 를 위한 optionGroup list get
    @Override
    public Map<String, Object> getOptionGroupList(int optionGroupNo) throws Exception{
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("list", menuDao.getOptionGroupList(optionGroupNo));
        return map;
    }

    @Override
    public Menu getMenu(int menuNo) throws Exception {
        return menuDao.getMenu(menuNo);
    }

    @Override
    public Map<String,Object> getOptionGroup(Search search, int optionGroupNo) throws Exception {

        return menuDao.getOptionGroup(search,optionGroupNo);
    }

    @Override
    public OptionGroup getOption(int optionNo) throws Exception {
        System.out.println("MenuServiceImpl.getOption");
        return menuDao.getOption(optionNo);
    }

    @Override
    public Map<String, Object> getMenuList(Search search, String truckId) throws Exception {

        return menuDao.getMenuList(search, truckId);
    }

    @Override
    public void updateMenu(Menu menu) throws Exception {

        menuDao.updateMenu(menu);

    }

    @Override
    public void updateOptionGroup(OptionGroup optionGroup) throws Exception {
        menuDao.updateOptionGroup(optionGroup);
    }

    @Override
    public void deleteMenu(Menu menu) throws Exception {
        menuDao.deleteMenu(menu);
    }

    @Override
    public void deleteOptionGroup(OptionGroup optionGroup) throws Exception {
        menuDao.deleteOptionGroup(optionGroup);
    }

    @Override
    public void deleteOption(OptionGroup optionGroup) throws Exception {
        menuDao.deleteOption(optionGroup);
    }


}
