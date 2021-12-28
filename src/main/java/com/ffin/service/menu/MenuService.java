package com.ffin.service.menu;

import com.ffin.common.Search;
import com.ffin.service.domain.Menu;
import com.ffin.service.domain.OptionGroup;

import javax.swing.text.html.Option;
import java.util.List;
import java.util.Map;

public interface MenuService {

    //메뉴 등록
    //public void addMenu(Menu menu) throws Exception;

    //메뉴와 옵션 한꺼번에 등록하는 방법 고안1 -> 헷갈려서 실패
    //public void addMenu(List list) throws Exception;

    //메뉴와 옵션 한꺼번에 등록하는 방법 고안2
    public int addMenu(Menu menu) throws Exception;

    //옵션 그룹 등록
    //public void addOptionGroup(OptionGroup optionGroup) throws Exception;

    //메뉴와 옵션 한꺼번에 등록하는 방법 고안2
    //옵션 그룹 등록
    public void addOptionGroup(List list) throws Exception;

    //메뉴와 옵션 한꺼번에 등록하는 방법 고안 2를 위한 옵션 그룹 리스트 get!
    public Map getOptionGroupList(int optionGroupNo) throws Exception;

    //메뉴 조회
    public Menu getMenu(int menuNo) throws Exception;

    //옵션 그룹 조회
    public Map<String,Object> getOptionGroup(Search search, int optionGroupNo) throws Exception;

    //옵션 조회
    public OptionGroup getOption(int optionNo) throws Exception;

    //메뉴 목록 조회
    public Map<String, Object> getMenuList(Search search, String truckId) throws Exception;

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
