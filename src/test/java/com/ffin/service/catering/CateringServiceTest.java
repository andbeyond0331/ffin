package com.ffin.service.catering;

import com.ffin.common.Search;
import com.ffin.service.domain.Catering;
import com.ffin.service.domain.Menu;
import com.ffin.service.domain.Truck;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.sql.Date;
import java.util.Map;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {	"classpath:config/context-common.xml",
        "classpath:config/context-aspect.xml",
        "classpath:config/context-mybatis.xml",
        "classpath:config/context-transaction.xml" })

public class CateringServiceTest {

    @Autowired
    @Qualifier("cateringServiceImpl")
    private CateringService cateringService;

  // @Test
    public void getCtList() throws Exception {

        Search search = new Search();
        search.setSearchCondition("0");
        String id="user01";


        Map<String, Object>  map = cateringService.getCtList(search, id);

    }

    //@Test
    public void getCtStatusList() throws Exception {
        //getCtStatusList(Search search, String id, String ctStatusCode)
        Search search = new Search();
        search.setSearchCondition("1");
        String id="truck01";
        String ctStatusCode = "0";

        Map<String, Object>  map = cateringService.getCtStatusList(search, id, ctStatusCode);

    }

    //@Test
    public void getCtDateList() throws Exception {

        Search search = new Search();
        String ctDate="2021-12-22";


        Map<String, Object>  map = cateringService.getCtDateList(search, ctDate);

    }

    //@Test
  //  public void getCtTruckMenu() throws Exception {

      //  String truckId = "truck01";
        // truck 도메인 업데이트 후 다시 해보깅

       // Catering catering = cateringService.getCtTruckMenu(truckId);
      //  System.out.println(catering);
   // }

   // @Test
    public void getCtDetail() throws Exception {

        int ctNo = 4;
        // truck 도메인 업데이트 후 다시 해보깅

        Catering catering = cateringService.getCtDetail(ctNo);
        System.out.println(catering);
    }

   // @Test
    public void addCt() throws Exception {
        Truck truck = new Truck();
        truck.setTruckId("truck01");
        Catering catering = new Catering();
        catering.setCtTruck(truck);
        Menu menu = new Menu();
        menu.setMenuNo(1);
        catering.setCtMenu(menu);
        catering.setCtDate("2021-12-25");
        catering.setCtMenuMaxQty(100);
        catering.setCtMenuMinQty(50);

        // truck 도메인 업데이트 후 다시 해보깅

       cateringService.addCt(catering);

    }

  //  @Test
    public void updateCtResCancel() throws Exception {

        int ctNo=4;
        String ctStatusCode    = "2"  ;

        cateringService.updateCtResCancel(4, "2" );

    }


    /*

    public Map<String, Object> getCtList(Search search, String id) throws Exception;
    public Map<String, Object> getCtStatusList(Search search, String id, String ctStatusCode) throws Exception;
    public Map<String, Object> getCtDateList(Search search, String ctDate) throws Exception;
    public Catering getCtTruckMenu(String truckId) throws Exception;
    public Catering getCtDetail(int ctNo) throws Exception;
    public void addCt(Catering catering) throws Exception;
    public void updateCtResAdd(Catering catering) throws Exception;
    public void updateCtMenuQty(int ctNo, int ctMenuMinQty, int ctMenuMaxQty) throws Exception;
    public void updateCtRes(Catering catering) throws Exception;
    public void updateCtResCancel(int ctNo, String ctStatusCode) throws Exception;
     */
}