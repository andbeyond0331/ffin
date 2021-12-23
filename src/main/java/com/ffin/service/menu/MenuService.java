package com.ffin.service.menu;

import com.ffin.common.Search;
import com.ffin.service.domain.Menu;
import com.ffin.service.domain.OptionGroup;

import javax.swing.text.html.Option;
import java.util.Map;

public interface MenuService {

    //메뉴 등록
    public void addMenu(Menu menu) throws Exception;

    //옵션 그룹 등록
    public void addOptionGroup(OptionGroup optionGroup) throws Exception;

    //메뉴 조회
    public Menu getMenu(int menuNo) throws Exception;

    //옵션 그룹 조회
    public Map<String,Object> getOptionGroup(Search search, int optionGroupNo) throws Exception;

    //옵션 조회
    public OptionGroup getOption(int optionNo) throws Exception;

    //메뉴 목록 조회
    public Map<String, Object> getMenuList(Search search, String menuTruckId) throws Exception;

    //메뉴 수정
    public void updateMenu(Menu menu) throws Exception;


    //옵션 그룹 수정
    public void updateOptionGroup(OptionGroup optionGroup) throws Exception;

    //메뉴 삭제
    public void deleteMenu(Menu menu) throws Exception;

    //옵션 그룹 삭제
    public void deleteOptionGroup(OptionGroup optionGroup) throws Exception;

    //옵션 삭제
    public void deleteOption(OptionGroup optionGroup) throws Exception;

}
