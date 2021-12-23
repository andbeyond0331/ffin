package com.ffin.service.menu;

import com.ffin.common.Search;
import com.ffin.service.domain.Menu;
import com.ffin.service.domain.OptionGroup;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.Map;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/context-common.xml",
        "classpath:config/context-aspect.xml",
        "classpath:config/context-mybatis.xml",
        "classpath:config/context-transaction.xml" })
public class MenuServiceTest {

    @Autowired
    @Qualifier("menuServiceImpl")
    private MenuService menuService;


//    @Test  //OKAY
//    public void addMenu() throws Exception{
//
//        Menu menu = new Menu();
//
//        menu.setMenuNo(10);
//        menu.setMenuTruckId("truck04");
//        menu.setMenuName("menuTest1");
//        menu.setMenuPrice(10000);
//        menu.setMenuDetail("menuDetailTest1");
//        menu.setIsSigMenu(0);
//        menu.setMenuImg1("menuImgTest1");
//        menu.setMenuImg2("menuImgTest2");
//        menu.setMenuImg3("menuImgTest3");
//
//        menuService.addMenu(menu);
//
//        Assert.assertEquals(10,menu.getMenuNo());
//        Assert.assertEquals("truck04",menu.getMenuTruckId());
//        Assert.assertEquals("menuTest1",menu.getMenuName());
//        Assert.assertEquals(10000,menu.getMenuPrice());
//        Assert.assertEquals("menuDetailTest1",menu.getMenuDetail());
//        Assert.assertEquals(0,menu.getIsSigMenu());
//        Assert.assertEquals("menuImgTest1",menu.getMenuImg1());
//        Assert.assertEquals("menuImgTest2",menu.getMenuImg2());
//        Assert.assertEquals("menuImgTest3",menu.getMenuImg3());
//
//
//    }

//
//    @Test  //OKAY
//    public void addOptionGroup() throws Exception {
//
//        OptionGroup optionGroup = new OptionGroup();
//
//        optionGroup.setMenuNo(8);
//        optionGroup.setOptionGroupNo(100);
//        optionGroup.setOptionNo(100);
//        optionGroup.setOptionGroupName("ogname100");
//        optionGroup.setOptionName("oname100");
//        optionGroup.setOptionPrice(10000);
//
//        menuService.addOptionGroup(optionGroup);
//
//        System.out.println("optionGroup : " + optionGroup);
//
//        Assert.assertEquals(8, optionGroup.getMenuNo());
//        Assert.assertEquals(100, optionGroup.getOptionGroupNo());
//        Assert.assertEquals(100, optionGroup.getOptionNo());
//        Assert.assertEquals("ogname100", optionGroup.getOptionGroupName());
//        Assert.assertEquals("oname100", optionGroup.getOptionName());
//        Assert.assertEquals(10000, optionGroup.getOptionPrice());
//
//    }


//    @Test  //OKAY
//    public void getMenu() throws Exception {
//
//        Menu menu = new Menu();
//
//
//        menu = menuService.getMenu(8);
//
//        Assert.assertEquals(8,menu.getMenuNo());
//
//
//
//    }

//    @Test //okay
//    public void getOptionGroup() throws Exception{
//
//        Search search = new Search();
//        search.setCurrentPage(1);
//        search.setPageSize(100);
//        search.setSearchCondition("0");
//        search.setSearchKeyword("");
//        Map<String, Object> map = menuService.getOptionGroup(search, 1);
//
//        List<Object> list = (List<Object>)map.get("list");
//
//        Assert.assertEquals(3, list.size());
//
//
//    }

//        @Test   //okay
//    public void getOption() throws Exception{
//
//        OptionGroup optionGroup = new OptionGroup();
//
//        optionGroup = menuService.getOption(104);
//
//        Assert.assertEquals(104,optionGroup.getOptionNo());
//
//
//    }

//
//
//    @Test //okay!!!!!!!!!!!!!!!
//    public void getMenuList() throws Exception {
//        Search search  = new Search();
//        search.setCurrentPage(1);
//        search.setPageSize(8);
//        search.setSearchCondition("0");
//        search.setSearchKeyword("");
//        Map<String, Object> map = menuService.getMenuList(search, "truck01");
//
//        List<Object> list = (List<Object>)map.get("list");
//        Assert.assertEquals(8, list.size());
//
//        System.out.println("list : " + list);
//
//
//    }




//    @Test //okay
//    public void updateMenu() throws Exception {
//
//        Menu menu = menuService.getMenu(8);
//
//        Assert.assertNotNull(menu);
//
//
//        Assert.assertEquals(8,menu.getMenuNo());
//        Assert.assertEquals("truck04",menu.getMenuTruckId());
//        Assert.assertEquals("menuTest1",menu.getMenuName());
//        Assert.assertEquals(10000,menu.getMenuPrice());
//        Assert.assertEquals("menuDetailTest1",menu.getMenuDetail());
//        Assert.assertEquals(0,menu.getIsSigMenu());
//        Assert.assertEquals("menuImgTest1",menu.getMenuImg1());
//        Assert.assertEquals("menuImgTest2",menu.getMenuImg2());
//        Assert.assertEquals("menuImgTest3",menu.getMenuImg3());
//
//        menu.setMenuName("menuUpdateTest1");
//        menu.setMenuPrice(50000);
//        menu.setMenuDetail("menuDetailUpdateTest1");
//        menu.setIsSigMenu(1);
//        menu.setMenuImg1("menuImgUpdateTest1");
//        menu.setMenuImg2("menuImgUpdateTest2");
//        menu.setMenuImg3("menuImgUpdateTest3");
//
//        menuService.updateMenu(menu);
//
//        menu = menuService.getMenu(8);
//        Assert.assertNotNull(menu);
//
//        System.out.println("menu : " + menu);
//        Assert.assertEquals("menuUpdateTest1",menu.getMenuName());
//        Assert.assertEquals(50000,menu.getMenuPrice());
//        Assert.assertEquals("menuDetailUpdateTest1",menu.getMenuDetail());
//        Assert.assertEquals(1,menu.getIsSigMenu());
//        Assert.assertEquals("menuImgUpdateTest1",menu.getMenuImg1());
//        Assert.assertEquals("menuImgUpdateTest2",menu.getMenuImg2());
//        Assert.assertEquals("menuImgUpdateTest3",menu.getMenuImg3());
//
//    }



//    @Test //OKAY
//    public void updateOptionGroup() throws Exception {
//
//        OptionGroup optionGroup = menuService.getOptionGroup(100);
//
////        Assert.assertNotNull(optionGroup);
////
////        Assert.assertEquals(8,optionGroup.getMenuNo());
////        Assert.assertEquals(100,optionGroup.getOptionGroupNo());
////        Assert.assertEquals(100,optionGroup.getOptionNo());
////        Assert.assertEquals("ogname100",optionGroup.getOptionGroupName());
////        Assert.assertEquals("oname100",optionGroup.getOptionName());
////        Assert.assertEquals(10000,optionGroup.getOptionPrice());
////
////
////        optionGroup.setOptionGroupName("ognameUpdateTest1");
////        optionGroup.setOptionName("onameUpdateTest1");
////        optionGroup.setOptionPrice(50000);
//
//
//        menuService.updateOptionGroup(optionGroup);
//
//        optionGroup = menuService.getOptionGroup(100);
//        Assert.assertNotNull(optionGroup);
//
//        Assert.assertEquals("ognameUpdateTest1",optionGroup.getOptionGroupName());
//        Assert.assertEquals("onameUpdateTest1",optionGroup.getOptionName());
//        Assert.assertEquals(50000,optionGroup.getOptionPrice());
//
//    }

//    @Test  // OKAY
//    public void deleteMenu() throws Exception {
//
//        Menu menu = new Menu();
//
//        menu = menuService.getMenu(9);
//
//        Assert.assertNotNull(menu);
//
//        System.out.println("지우기 전 menu : " + menu);
//
//        menuService.deleteMenu(menu);
//
//        System.out.println("/////////////////////////");
//
//        menu = menuService.getMenu(10);
//
//        Assert.assertNotNull(menu);
//        System.out.println("지우기 전 menu : " + menu);
//
//        menuService.deleteMenu(menu);



    // 여기서부턴 지웠던 메뉴 다시 되돌리는 작업     System.out.println("////지웠던 메뉴 다시 되돌리기!!!/////");
    //
    //
    //        menu.setMenuNo(8);
    //        menu.setMenuTruckId("truck04");
    //        menu.setMenuName("menuTest1");
    //        menu.setMenuPrice(10000);
    //        menu.setMenuDetail("menuDetailTest1");
    //        menu.setIsSigMenu(0);
    //        menu.setMenuImg1("menuImgTest1");
    //        menu.setMenuImg2("menuImgTest2");
    //        menu.setMenuImg3("menuImgTest3");
    //
    //        menuService.addMenu(menu);
    //
    //        Assert.assertEquals(8,menu.getMenuNo());
    //        Assert.assertEquals("truck04",menu.getMenuTruckId());
    //        Assert.assertEquals("menuTest1",menu.getMenuName());
    //        Assert.assertEquals(10000,menu.getMenuPrice());
    //        Assert.assertEquals("menuDetailTest1",menu.getMenuDetail());
    //        Assert.assertEquals(0,menu.getIsSigMenu());
    //        Assert.assertEquals("menuImgTest1",menu.getMenuImg1());
    //        Assert.assertEquals("menuImgTest2",menu.getMenuImg2());
    //        Assert.assertEquals("menuImgTest3",menu.getMenuImg3());
//
//
//    }
//
//    @Test  //okay!!!
//    public void deleteOptionGroup() throws Exception {
//
//        Search search = new Search();
//
//        OptionGroup optionGroup = new OptionGroup();
//
//        List<OptionGroup> list= (List<OptionGroup>) menuService.getOptionGroup(search, 101).get("list");
//
//        optionGroup = list.get(0);
//
//        int optionGroupNo = optionGroup.getOptionGroupNo();
//
//        Assert.assertNotNull(optionGroup);
//
//        System.out.println("지우기 전 OptionGroup : " + optionGroup);
//
//        menuService.deleteOptionGroup(optionGroup);
//
//        System.out.println("/////////////////////////");
//
//
//    }


//    @Test //OKAY
//    public void deleteOption() throws Exception {
//        OptionGroup optionGroup = new OptionGroup();
//
//        optionGroup = menuService.getOptionGroup(106);
//
//        Assert.assertNotNull(optionGroup);
//
//        System.out.println("지우기 전 option : " + optionGroup);
//
//        menuService.deleteOption(optionGroup);
//
//    }


}