package com.ffin.service.menu;

import com.ffin.common.Search;
import com.ffin.service.domain.Menu;
import com.ffin.service.domain.OptionGroup;

import javax.swing.text.html.Option;
import java.util.List;
import java.util.Map;

public interface MenuService {

    //메뉴와 옵션 한꺼번에 등록하는 방법 고안2
    public int addMenu(Menu menu) throws Exception;

    //메뉴와 옵션 한꺼번에 등록하는 방법 고안2
    //옵션 그룹 등록
    public void addOptionGroup(List list) throws Exception;

    //옵션 등록 중 옵션 그룹 번호를 위한 최근 옵션그룹 번호 가져오기
    public OptionGroup getLatestOptionGroupNo() throws Exception;

//    //이미지 업로드
//    public

    //메뉴와 옵션 한꺼번에 등록하는 방법 고안 2를 위한 옵션 그룹 리스트 get!
    public Map getOptionGroupList(int optionGroupNo) throws Exception;

    //메뉴 조회
    public Menu getMenu(int menuNo) throws Exception;

    //옵션 그룹 by optionGroupNo
    public Map<String,Object> getOptionGroup(Search search, int optionGroupNo) throws Exception;

    //옵션그룹 조회 by menuNo
    public Map<String, Object> getOptionGroupByMenu(Search search, int menuNo) throws Exception;

    //옵션 조회
    public OptionGroup getOption(int optionNo) throws Exception;

    //메뉴 목록 조회
    public Map<String, Object> getMenuList(Search search, String truckId) throws Exception;

//    //옵션그룹 번호 지정을 위한 옵션 그룹 번호 중 가장 큰 값 조회
//    public OptionGroup getLargestOptionGroupNo() throws Exception;
//
//    //옵션 번호 지정을 위한 옵션 번호 중 가장 큰 값 조회
//    public OptionGroup getLargestOptionNo() throws Exception;

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

    //옵션 그룹 존재 여부
    public int isThereOG(Search search, int menuNo) throws Exception;


}
