package com.ffin.service.truck;

import com.ffin.common.Search;
import com.ffin.service.domain.Truck;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration( locations = { "classpath:config/context-auth.xml",
        "classpath:config/context-common.xml",
        "classpath:config/context-aspect.xml",
        "classpath:config/context-mybatis.xml",
        "classpath:config/context-transaction.xml" })

public class TruckServiceTest {

    /**
     *
     */
    //==>@RunWith,@ContextConfiguration 이용 Wiring, Test 할 instance DI
    @Autowired
    @Qualifier("truckServiceImpl")
    private TruckService truckService;

//    @Test //okay - mj
    public void testTruckListForSortingNoKeywordNoCate() throws Exception{
        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(3);

        Map<String,Object> map = truckService.getTruckList(search);

        List<Object> list = (List<Object>)map.get("list");
        //Assert.assertEquals(3, list.size());

        //==> console 확인
        //System.out.println(list);

        //Integer totalCount = (Integer)map.get("totalCount");
        //System.out.println(totalCount);

        System.out.println("=======================================");


    }

//    @Test //okay - mj
    public void testTruckListForSortingYesKeywordNoCate() throws Exception{
        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(3);
        search.setSearchKeyword("떡볶이");


        Map<String,Object> map = truckService.getTruckList(search);

        List<Object> list = (List<Object>)map.get("list");
        //Assert.assertEquals(3, list.size());

        //==> console 확인
        //System.out.println(list);

        //Integer totalCount = (Integer)map.get("totalCount");
        //System.out.println(totalCount);

        System.out.println("=======================================");


    }

//    @Test //okay - mj
    public void testTruckListForSortingNoKeywordYesCate() throws Exception{
        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(3);
//        search.setSearchKeyword("떡볶이");
//        search.setCateCondition("0"); // TODO: 2022-01-08 catecondition이 0일 때는 쿼리 안 맞으니까 전체보기는 cateCondition == null
        search.setCateCondition("1");
//        search.setCateCondition("2");
//        search.setCateCondition("3");
//        search.setCateCondition("4");
//        search.setCateCondition("5");
//        search.setCateCondition("6");
//        search.setCateCondition("7");
//        search.setCateCondition("8");


        Map<String,Object> map = truckService.getTruckList(search);

        List<Object> list = (List<Object>)map.get("list");
        //Assert.assertEquals(3, list.size());

        //==> console 확인
        //System.out.println(list);

        //Integer totalCount = (Integer)map.get("totalCount");
        //System.out.println(totalCount);

        System.out.println("=======================================");

//        search.setCurrentPage(1);
//        search.setPageSize(3);
//        search.setSearchCondition("0");
//        search.setSearchKeyword("");
//        map = truckService.getTruckList(search);
//
//        list = (List<Object>)map.get("list");
        //Assert.assertEquals(3, list.size());

        //==> console 확인
        //System.out.println(list);

        //totalCount = (Integer)map.get("totalCount");
        //System.out.println(totalCount);
    }

    @Test
    public void testTruckListForSortingYesKeywordYesCate() throws Exception{
        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(3);

//        카테고리에 어울리는 키워드로 검색 시
        search.setSearchKeyword("떡볶이");
        search.setCateCondition("2");


        Map<String,Object> map = truckService.getTruckList(search);

        List<Object> list = (List<Object>)map.get("list");
        //Assert.assertEquals(3, list.size());


        System.out.println("search : " + search);
        //==> console 확인
        //System.out.println(list);

        //Integer totalCount = (Integer)map.get("totalCount");
        //System.out.println(totalCount);

        System.out.println("=======================================");


    }

    //@Test
    public void testAddTruck() throws Exception {

        Truck truck = new Truck();

        truck.setTruckId("testTruckId");
        truck.setTruckPassword("testPassword");
        truck.setTruckCEOName("testTruckCEOName");
        truck.setTruckPhone("000-0000-0000");
        truck.setTruckEmail("abc@gmail.com");
        truck.setTruckName("testTruckName");
        truck.setTruckBusiLice("aaa.jpg");
        truck.setTruckCate(8);
        truck.setTruckJoinReqStatus(1);
        truck.setTruckBusiStatus("0");
        truck.setRole(1);

        truckService.addTruck(truck);

        truck = truckService.getTruck("testTruckId");

        //==> console 확인
        //System.out.println(truck);

        //==> API 확인
        Assert.assertEquals("testTruckId", truck.getTruckId());
        Assert.assertEquals("testPassword", truck.getTruckPassword());
        Assert.assertEquals("testTruckCEOName", truck.getTruckCEOName());
        Assert.assertEquals("000-0000-0000", truck.getTruckPhone());
        Assert.assertEquals("abc@gmail.com", truck.getTruckEmail());
        Assert.assertEquals("testTruckName", truck.getTruckName());
        Assert.assertEquals("aaa.jpg", truck.getTruckBusiLice());
        Assert.assertEquals(8, truck.getTruckCate());
        Assert.assertEquals(Integer.parseInt("1"), truck.getTruckJoinReqStatus());
        Assert.assertEquals(Date.valueOf("2021-12-27"), truck.getTruckJoinReqDate());
        Assert.assertEquals("0", truck.getTruckBusiStatus());
        Assert.assertEquals(Date.valueOf("2021-12-27"), truck.getTruckRegDate());
        Assert.assertEquals(1, truck.getRole());
    }


    //@Test
    public void testGetTruck() throws Exception{

        Truck truck = new Truck();

        truck = truckService.getTruck("testTruckId");

        Assert.assertEquals("testTruckId", truck.getTruckId());
    }

    //@Test
    public void testGetNotice() throws Exception {

        Truck truck = new Truck();

        truck = truckService.getTruck("testTruckId");

        Assert.assertEquals("고오옹지", truck.getTruckNoticeTitle());
        Assert.assertEquals("공지올립니다!!", truck.getTruckNoticeContent());
        Assert.assertEquals("testNoticeImg.jpg", truck.getTruckNoticeImg());
    }

    //@Test
    public void testGetTruckProfile() throws Exception{

        Truck truck = new Truck();

        truck = truckService.getTruck("testTruckId");

        Assert.assertEquals("CRUD분식", truck.getTruckName());
        Assert.assertEquals("testLice.jpg", truck.getTruckBusiLice());
        Assert.assertEquals(1, truck.getTruckCate());
        Assert.assertEquals("testProImg.jpg", truck.getTruckProImg());
        Assert.assertEquals("맛있는 분식 드시고 가세요!!", truck.getTruckCEOIntro());
    }

    //@Test
    public void testGetTruckInfo() throws Exception{

        Truck truck = new Truck();

        truck = truckService.getTruck("testTruckId");

        Assert.assertEquals("changeTestCEOName", truck.getTruckCEOName());
        Assert.assertEquals(Date.valueOf("2021-12-21"), truck.getTruckCEOBirth());
        Assert.assertEquals("서울특별시 종로구", truck.getTruckAddr());
        Assert.assertEquals("종각역 4번출구", truck.getTruckAddrDetail());
        Assert.assertEquals("777-7777-7777", truck.getTruckPhone());
        Assert.assertEquals("test@test.com", truck.getTruckEmail());
    }

    //@Test
    public void testGetNewTruck() throws Exception{

        Truck truck = new Truck();

        truck = truckService.getTruck("testTruckId");

        Assert.assertNotNull(truck);
    }

    //@Test
    public void testUpdateTruck() throws Exception{

        Truck truck = new Truck();

        truck = truckService.getTruck("testTruckId");

        Assert.assertNotNull(truck);
    }

    //@Test
    public void testFindTruckId() throws Exception{

        String truck = truckService.findTruckId("CRUD분식","777-7777-7777");

        Assert.assertNotNull(truck);

    }

    //@Test
    public void testUpdateTruckProfile() throws Exception {

        Truck truck = new Truck();

        truck = truckService.getTruck("testTruckId");

        Assert.assertNotNull(truck);

        truck.setTruckName("CRUD트럭");
        truck.setTruckBusiLice("testLice.jpg");
        truck.setTruckCate(1);
        truck.setTruckProImg("testProImg.jpg");
        truck.setTruckCEOIntro("맛있는 분식 드시고 가세요!!");

        truckService.updateTruckProfile(truck);

        truck = truckService.getTruck("testTruckId");

        Assert.assertEquals("CRUD트럭", truck.getTruckName());
        Assert.assertEquals("testLice.jpg", truck.getTruckBusiLice());
        Assert.assertEquals(1, truck.getTruckCate());
        Assert.assertEquals("testProImg.jpg", truck.getTruckProImg());
        Assert.assertEquals("맛있는 분식 드시고 가세요!!", truck.getTruckCEOIntro());
    }

    //@Test
    public void testUpdateTruckInfo() throws Exception{

        Truck truck = new Truck();

        truck = truckService.getTruck("testTruckId");

        Assert.assertNotNull(truck);

        truck.setTruckCEOName("changeTestCEOName");
        truck.setTruckCEOBirth(Date.valueOf("2021-12-21"));
        truck.setTruckAddr("서울특별시 종로구");
        truck.setTruckAddrDetail("종각역 4번출구");
        truck.setTruckPhone("777-7777-7777");
        truck.setTruckEmail("test@test.com");

        truckService.updateTruckInfo(truck);

        truck = truckService.getTruck("testTruckId");

        Assert.assertEquals("changeTestCEOName", truck.getTruckCEOName());
        Assert.assertEquals(Date.valueOf("2021-12-21"), truck.getTruckCEOBirth());
        Assert.assertEquals("서울특별시 종로구", truck.getTruckAddr());
        Assert.assertEquals("종각역 4번출구", truck.getTruckAddrDetail());
        Assert.assertEquals("777-7777-7777", truck.getTruckPhone());
        Assert.assertEquals("test@test.com", truck.getTruckEmail());
    }

    //@Test
    public void updateBusiStatus() throws Exception{

        Truck truck = new Truck();

        truck = truckService.getTruck("testTruckId");

        Assert.assertNotNull(truck);

        truck.setTruckBusiStatus("0");
        truck.setTruckMapLa(37.57);
        truck.setTruckMapLo(126.98);

        truckService.updateBusiStatus(truck);

        truck = truckService.getTruck("testTruckId");

        Assert.assertEquals("0", truck.getTruckBusiStatus());
        Assert.assertEquals(Double.valueOf(37.57), truck.getTruckMapLa());
        Assert.assertEquals(Double.valueOf(126.98), truck.getTruckMapLa());
    }


    //@Test
    public void testUpdateNotice() throws Exception {

        Truck truck = new Truck();
        System.out.println("인스턴스생성");
        truck = truckService.getTruck("testTruckId");
        System.out.println("getTruck");
//        Assert.assertNotNull(truck);
        truck.setTruckId("testTruckId");
        truck.setTruckNoticeTitle("고오옹지");
        truck.setTruckNoticeContent("공지올립니다!!");
        truck.setTruckNoticeImg("testNoticeImg.jpg");
        System.out.println("setTruck");

        truckService.updateNotice(truck);
        System.out.println("update");
        truck = truckService.getTruck("testTruckId");
        Assert.assertNotNull(truck);
        System.out.println("업데이트확인");
        Assert.assertEquals("고오옹지", truck.getTruckNoticeTitle());
        Assert.assertEquals("공지올립니다!!", truck.getTruckNoticeContent());
        Assert.assertEquals("testNoticeImg.jpg", truck.getTruckNoticeImg());
    }

    //@Test
    public void updateTruckPassword() throws Exception{

        Truck truck = new Truck();

        truck = truckService.getTruck("testTruckId");

        Assert.assertNotNull(truck);

        truck.setTruckPassword("changeTestTruckPassword");

        truckService.updateTruckPassword(truck);

        truck = truckService.getTruck("testTruckId");

        Assert.assertEquals("changeTestTruckPassword", truck.getTruckPassword());
    }

    //@Test
    public void testGetTruckListAll() throws Exception{
        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(3);
        Map<String,Object> map = truckService.getTruckList(search);

        List<Object> list = (List<Object>)map.get("list");
        //Assert.assertEquals(3, list.size());

        //==> console 확인
        //System.out.println(list);

        //Integer totalCount = (Integer)map.get("totalCount");
        //System.out.println(totalCount);

        System.out.println("=======================================");

        search.setCurrentPage(1);
        search.setPageSize(3);
        search.setSearchCondition("0");
        search.setSearchKeyword("");
        map = truckService.getTruckList(search);

        list = (List<Object>)map.get("list");
        //Assert.assertEquals(3, list.size());

        //==> console 확인
        //System.out.println(list);

        //totalCount = (Integer)map.get("totalCount");
        //System.out.println(totalCount);
    }

    //@Test
    public void getNewTruckList() throws Exception{
    }

    //@Test
    void login() {
    }

    //@Test
    void logout() {
    }

    //@Test
    public void testByeTruck() throws Exception{

        Truck truck = new Truck();

        truck = truckService.getTruck("testTruckId");

        Assert.assertNotNull(truck);

        truck.setTruckByeReason(1);
        truck.setTruckByeStatus(1);

        truckService.byeTruck(truck);

        truck = truckService.getTruck("testTruckId");

        Assert.assertEquals(1, truck.getTruckByeReason());
        Assert.assertEquals(1, truck.getTruckByeStatus());
    }

    //@Test
    public void testUploadFile() throws Exception{

    }

    //@Test
    void sendEmail() {
    }

    //@Test
    void emailAuth() {
    }

    //@Test
    void messageAuth() {
    }

    //@Test
    void captchaAuth() {
    }

    //@Test
    void busiLiceAuth() {
    }

    //@Test
    void getTotalCount() {
    }
}
