package com.ffin.service.catering;

import com.ffin.common.Search;
import com.ffin.service.domain.Catering;
import com.ffin.service.domain.Menu;
import com.ffin.service.domain.Truck;
import com.ffin.service.domain.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {	"classpath:config/context-auth.xml",
        "classpath:config/context-common.xml",
        "classpath:config/context-aspect.xml",
        "classpath:config/context-mybatis.xml",
        "classpath:config/context-transaction.xml" })

public class CateringServiceTest {

    @Autowired
    @Qualifier("cateringServiceImpl")
    private CateringService cateringService;



    @Test
    public void mainCalendar() throws Exception {
        System.out.println("CateringController.mainCalendar");
        /*
            메인 화면
            달력으로 노출할 예정
            이용자, 사업자 구분
         */
        Search search = new Search();
        String role = "user";
        String id="user01";
        Map<String , Object> map= new HashMap<String , Object>();
        //String role = (String)session.getAttribute("role");// role로 구분할 예정 - user / truck
        System.out.println("role = " + role);

        if (role == "user" || role.equals("user")){
            // user 라면
           // id = ((User)session.getAttribute("user")).getUserId();
            System.out.println("user id: "+id);
            search.setSearchCondition("2");

        }else if(role == "truck" || role.equals("truck")){
            // truck이라면
            //id = ((Truck)session.getAttribute("truck")).getTruckId();
            System.out.println("truck id: "+id);
            search.setSearchCondition("1");

        }
        map = cateringService.getCtList(search, id);
        //System.out.println("map = " + map);
        List<Catering> list = (List<Catering>) map.get("list");
        System.out.println("list = " + list);
        Map<String, Catering> javaMap = new HashMap<>();
        
        
        //javaMap.put()
        //List<Product> list = productService.getAutoProdName(keyword);

        ArrayList ja = new ArrayList();



        for(int i=0; i<list.size(); i++) {

            ja.add(list.get(i).getCtNo());//title
            ja.add(list.get(i).getCtDate()); //start_time

        }

    }



    //@Test
    public void getCtList() throws Exception {

        Search search = new Search();
        search.setSearchCondition("2");
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