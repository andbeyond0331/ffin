package com.ffin.service.menu;

import com.ffin.common.Search;
import com.ffin.service.domain.Menu;
import com.ffin.service.domain.OptionGroup;

import java.util.List;

public interface MenuDao {

    //INSERT
    public void addMenu(Menu menu) throws Exception;

    //INSERT
    public void addOptionGroup(OptionGroup optionGroup) throws Exception;

    //SELECT ONE
    public Menu getMenu(int menuNo) throws Exception;


    // 옵션 그룹의 모든 옵션 받아오기
    //SELECT LIST
    public List<OptionGroup> getOptionGroup(Search search) throws Exception;

    // 옵션 그룹 중 옵션 하나 받아오기
    //SELECT ONE
    public OptionGroup getOption(int optionNo) throws Exception;

    //SELECT LIST
    public List<Menu> getMenuList(Search search) throws Exception;

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
