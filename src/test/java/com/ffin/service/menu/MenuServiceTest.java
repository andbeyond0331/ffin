package com.ffin.service.menu;

import com.ffin.common.Search;
import com.ffin.service.domain.Menu;
import com.ffin.service.domain.OptionGroup;
import com.ffin.service.domain.Truck;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/context-auth.xml",
        "classpath:config/context-common.xml",
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

//    @Test
//    public void getLatestOptionGroupNo() throws Exception{
//
//        OptionGroup optionGroup = menuService.getLatestOptionGroupNo();
//
//        Assert.assertEquals(14, optionGroup.getOptionGroupNo());
//    }

//    @Test // okay!
//    public void isThereOGTest() throws Exception{
//
//
//
//                Search search = new Search();
//        search.setCurrentPage(1);
//        search.setPageSize(100);
//        search.setSearchCondition("0");
//        search.setSearchKeyword("");
//        //Map<String, Object> map = menuService.getOptionGroup(search, 1);
//        int count = menuService.isThereOG(search,1);
//
//        Assert.assertEquals(9, count);
//
//    }

//
//    @Test  //OKAY
//    public void addOptionGroup() throws Exception {
//        OptionGroup optionGroup1 = new OptionGroup();
//
//        optionGroup1.setMenuNo(27);
//        optionGroup1.setOptionGroupNo(517);
//        optionGroup1.setOptionNo(517);
//        optionGroup1.setOptionGroupName("ogname517");
//        optionGroup1.setOptionName("oname517");
//        optionGroup1.setOptionPrice("517");
//
//        OptionGroup optionGroup2 = new OptionGroup();
//
//        optionGroup2.setMenuNo(27);
//        optionGroup2.setOptionGroupNo(517);
//        optionGroup2.setOptionNo(518);
//        optionGroup2.setOptionGroupName("ogname517");
//        optionGroup2.setOptionName("oname518");
//        optionGroup2.setOptionPrice("518");
//
//        OptionGroup optionGroup3 = new OptionGroup();
//
//        optionGroup3.setMenuNo(27);
//        optionGroup3.setOptionGroupNo(517);
//        optionGroup3.setOptionNo(519);
//        optionGroup3.setOptionGroupName("ogname517");
//        optionGroup3.setOptionName("oname519");
//        optionGroup3.setOptionPrice("519");
//
//
//
//        List<OptionGroup> optionGroup = new ArrayList<OptionGroup>();
//        optionGroup.add(optionGroup1);
//        optionGroup.add(optionGroup2);
//        optionGroup.add(optionGroup3);
//
//
//        menuService.addOptionGroup(optionGroup);
//
//        System.out.println("optionGroup : " + optionGroup);
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
//
    @Test
    public void getOptionGroupByMenu() throws Exception{

        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(100);
        search.setSearchCondition("0");
        search.setSearchKeyword("");
        Map<String, Object> map = menuService.getOptionGroupByMenu(search, 1);

        List<Object> list = (List<Object>)map.get("list");

        Assert.assertEquals(9, list.size());


    }
//
//        @Test
//    public void getLargestOptionGroupNo() throws Exception {
//
//
//
//        OptionGroup optionGroup = menuService.getLargestOptionGroupNo();
//
//            System.out.println("optionGroupNo : " +optionGroup);
//
//        Assert.assertEquals(5,optionGroup.getOptionGroupNo());
//
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
//    @Test
//    public void getMenuList() throws Exception {
//        Search search  = new Search();
//        search.setCurrentPage(1);
//        search.setPageSize(8);
//        search.setSearchCondition("0");
//        search.setSearchKeyword("");
//        Map<String, Object> map = menuService.getMenuList(search, "truck01");
//
//        List<Object> list = (List<Object>)map.get("list");
//        Assert.assertEquals(3, list.size());
//
//        System.out.println("list : " + list);
//
//
//    }

//    @Test //OKAY!!! -> REAL
//    public void addMenuTest() throws Exception{
//
//        Menu menu = new Menu();
//        Truck truck = new Truck();
//        truck.setTruckId("truck01");
//        menu.setMenuTruckId(truck.getTruckId());
//        menu.setMenuName("realTestmenuName");
//        menu.setMenuPrice(54321);
//        menu.setIsSigMenu(1);
//        menu.setMenuDetail("realtestMenuDetail");
//        menu.setMenuImg1("reatTestMenuImg1");
//
//        int menuNo = menuService.addMenu(menu);
//
//        System.out.println("menuNo : " + menuNo);
//
//
//
//    }



//    @Test //okay!!! -> real.. 한 번에!!!
//    public void testAddOptionGroup() throws Exception {
//
//        OptionGroup optionGroup = new OptionGroup();
//
//        Menu menu = new Menu();
//        menu.setMenuNo(8);
//        optionGroup.setMenuNo(menu.getMenuNo());
//        optionGroup.setOptionGroupNo(1000);
//        optionGroup.setOptionNo(1000);
//        optionGroup.setOptionGroupName("1000번옵션그룹이름");
//        optionGroup.setOptionName("1000번옵션이름");
//        optionGroup.setOptionPrice(654321);
//
//        OptionGroup optionGroup1 = new OptionGroup();
//
//        optionGroup1.setMenuNo(menu.getMenuNo());
//        optionGroup1.setOptionGroupNo(1000);
//        optionGroup1.setOptionNo(1001);
//        optionGroup1.setOptionGroupName("1000번옵션그룹이름");
//        optionGroup1.setOptionName("1001번옵션이름");
//        optionGroup1.setOptionPrice(7654321);
//
//        OptionGroup optionGroup2 = new OptionGroup();
//
//        optionGroup2.setMenuNo(menu.getMenuNo());
//        optionGroup2.setOptionGroupNo(1000);
//        optionGroup2.setOptionNo(1002);
//        optionGroup2.setOptionGroupName("1000번옵션그룹이름");
//        optionGroup2.setOptionName("1002번옵션이름");
//        optionGroup2.setOptionPrice(87654321);
//
//        List list = new ArrayList();
//        list.add(optionGroup);
//        list.add(optionGroup1);
//        list.add(optionGroup2);
//
//        menuService.addOptionGroup(list);
//
//        System.out.println("list : "+ list);
//    }

//    @Test
//    public void testGetOptionGroupList() throws Exception{
//        Map map = menuService.getOptionGroupList(1000);
//        System.out.println("map : " + map);
//    }

///////////////////////////////////////////


//    @Test //okay
//    public void updateMenu() throws Exception {
//
//        Menu menu = menuService.getMenu(8);
//
//        Assert.assertNotNull(menu);
//
//
//        Assert.assertEquals(8,menu.getMenuNo());
//        Assert.assertEquals("truck01",menu.getMenuTruckId());
//        Assert.assertEquals("realTestmenuName",menu.getMenuName());
//        Assert.assertEquals(54321,menu.getMenuPrice());
//        Assert.assertEquals("realtestMenuDetail",menu.getMenuDetail());
//        Assert.assertEquals(1,menu.getIsSigMenu());
//        Assert.assertEquals("reatTestMenuImg1",menu.getMenuImg1());
//
//
//        menu.setMenuName("아");
//        menu.setMenuPrice(10000);
//        menu.setMenuDetail("이");
//        menu.setIsSigMenu(0);
//        menu.setMenuImg1("우");
//        menu.setMenuImg2("에");
//        menu.setMenuImg3("오");
//
//        menuService.updateMenu(menu);
//
//        menu = menuService.getMenu(8);
//        Assert.assertNotNull(menu);
//
//        System.out.println("menu : " + menu);
//        Assert.assertEquals("아",menu.getMenuName());
//        Assert.assertEquals(10000,menu.getMenuPrice());
//        Assert.assertEquals("이",menu.getMenuDetail());
//        Assert.assertEquals(0,menu.getIsSigMenu());
//        Assert.assertEquals("우",menu.getMenuImg1());
//        Assert.assertEquals("에",menu.getMenuImg2());
//        Assert.assertEquals("오",menu.getMenuImg3());
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
//        List<OptionGroup> list= (List<OptionGroup>) menuService.getOptionGroup(search, 1002).get("list");
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