package com.ffin.service.menu;

import com.ffin.common.Search;
import com.ffin.service.domain.Menu;
import com.ffin.service.domain.OptionGroup;

import java.util.List;
import java.util.Map;

public interface MenuDao {

    //INSERT
//    public void addMenu(Menu menu) throws Exception;

    //INSERT
    //optionGroup이랑 menu 같이 insert하는 방법 고안 1 -> 헷가려서 실패
//    public void addMenu(List list) throws Exception;

    //INSERT
    //optionGroup이랑 menu 같이 insert하는 방법 고안 2
    public int addMenu(Menu menu) throws Exception;

    //INSERT
    //public void addOptionGroup(OptionGroup optionGroup) throws Exception;

    //INSERT
    //optionGroup이랑 menu 같이 insert하는 방법 고안 2
    public void addOptionGroup(List list) throws Exception;

    //SELECT LIST
    //optionGroup이랑 menu  같이 isnert하는 방법 고안 2를 위한 getOptionGroupList
    public List<OptionGroup> getOptionGroupList(int optionGroupNo) throws Exception;

    //SELECT ONE
    public Menu getMenu(int menuNo) throws Exception;


    // 옵션 그룹의 모든 옵션 받아오기
    //SELECT LIST
    public Map<String, Object> getOptionGroup(Search search, int optionGroupNo) throws Exception;

    // 옵션 그룹 중 옵션 하나 받아오기
    //SELECT ONE
    public OptionGroup getOption(int optionNo) throws Exception;

    //SELECT LIST
    public Map<String, Object> getMenuList(Search search, String truckId) throws Exception;

    //UPDATE
    public void updateMenu(Menu menu) throws Exception;

    //UPDATE
    public void updateOptionGroup(OptionGroup optionGroup) throws Exception;

    //DELETE
    public void deleteMenu(Menu menu) throws Exception;

    //DELETE
    public void deleteOptionGroup(OptionGroup optionGroup) throws Exception;

    //DELETE
    public void deleteOption(OptionGroup optionGroup) throws Exception;

    // 게시판 page 처리를 위한 전체 Row(totalCount) return
    public int getTotalCount(Search search) throws Exception;


}
