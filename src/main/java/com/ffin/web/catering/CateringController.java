package com.ffin.web.catering;

import com.ffin.common.Page;
import com.ffin.common.Search;
import com.ffin.service.catering.CateringService;
import com.ffin.service.domain.Catering;
import com.ffin.service.domain.Truck;
import com.ffin.service.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/catering/*")
@PropertySource("classpath:config/common.properties")
public class CateringController {

    ///Field
    @Autowired
    @Qualifier("cateringServiceImpl")
    private CateringService cateringService;

    public CateringController(){
        System.out.println(this.getClass());
    }


    @Value("${pageUnit}") //pageUnit은 propertySource를 위에 선언하고 @value의 값을 지정해줌
    //추후 pageUnit과 pageSize 출력되는지 jUnit에서 확인이 필요합니다.
    //@Value("#{commonProperties['pageUnit'] ?: 3}")
    int pageUnit;

    @Value("${pageSize}")
    int pageSize;

    @RequestMapping( value="/mainCalendar", method= RequestMethod.GET)
    public ModelAndView mainCalendar(@ModelAttribute("search") Search search , HttpSession session) throws Exception {
        System.out.println("CateringController.mainCalendar");
           /* 메인 화면
            달력으로 노출할 예정
            이용자, 사업자 구분
            full Calendar ...*/

        session.setAttribute("role", "truck");
        //User testUser = new User();
        //testUser.setUserId("user01");
        Truck testTruck = new Truck();
        testTruck.setTruckId("truck01");
        session.setAttribute("truck", testTruck);

        String id="";
        Map<String , Object> map= new HashMap<String , Object>();
        String role = (String)session.getAttribute("role");// role로 구분할 예정 - user / truck
        System.out.println("role = " + role);

        if (role == "user" || role.equals("user")){
            // session 처리 되면 주석 풀어서 체크하기. 지금은 임의로 한거.
            //id = ((User)session.getAttribute("user")).getUserId();
            //id = (String) session.getAttribute("userId");
            User user = (User) session.getAttribute("user");
            id = user.getUserId();
            System.out.println("user id: "+id);
            search.setSearchCondition("0");

        }else if(role == "truck" || role.equals("truck")){
            // truck이라면
            id = ((Truck)session.getAttribute("truck")).getTruckId();
            System.out.println("truck id: "+id);
            search.setSearchCondition("1");

        }
        map = cateringService.getCtList(search, id);
        System.out.println("map = " + map);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("list", map.get("list"));
        modelAndView.setViewName("/views/catering/mainCalendar.jsp");
        return modelAndView;
    }



    @RequestMapping( value="getUserResList")
    public ModelAndView getUserResList(@ModelAttribute("search") Search search, @RequestParam("userId") String userId) throws Exception {
        /*
            이용자가 '예약내역목록'을 출력했을 때 노출되는 화면
            초기값 : 전체값
         */
        System.out.println("CateringController.getUserResList");

        Map<String , Object> map =  cateringService.getCtList(search, userId);

        System.out.println("map = " + map);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("list", map.get("list"));
        modelAndView.setViewName("/views/catering/userList.jsp");

        return modelAndView;
    }


    @RequestMapping( value="getCtStatusList")
    public ModelAndView getCtStatusList(@ModelAttribute("search") Search search, String ctStatusCode, HttpSession session) throws Exception {
        /*
            '예약내역목록' 에서 탭별로 다른 값 노출
           0 : 이용자의 STATUS 값 조회
           1 : 사업자의 STATUS 값 조회
            Ajax 로 노출시킬지 고민 중.
         */
        System.out.println("CateringController.getCtStatusList");

        String id="";
        Map<String , Object> map= new HashMap<String , Object>();
        String role = (String)session.getAttribute("role");// role로 구분할 예정 - user / truck
        System.out.println("role = " + role);
        ModelAndView modelAndView = new ModelAndView();

        if (role == "user" || role.equals("user")){
            // user 라면
            id = ((User)session.getAttribute("user")).getUserId();
            System.out.println("user id: "+id);
            search.setSearchCondition("0");
            modelAndView.setViewName("/views/catering/userResList.jsp");
        }else if(role == "truck" || role.equals("truck")){
            // truck이라면
            id = ((Truck)session.getAttribute("truck")).getTruckId();
            System.out.println("truck id: "+id);
            search.setSearchCondition("1");
            modelAndView.setViewName("/views/catering/truckResList.jsp");
        }

        map = cateringService.getCtStatusList(search, id, ctStatusCode);
        System.out.println("map = " + map);
        modelAndView.addObject("list", map.get("list"));

        return modelAndView;
    }



    @RequestMapping( value="getCtDateList")
    public ModelAndView getCtDateList(@ModelAttribute("search") Search search, @RequestParam("ctDate") String ctDate) throws Exception {
        /*
            달력에서 필요한 내용
            날짜 눌렀을때 해당 날짜에 나오는 리스트.
            아마도 ajax 일 듯.
            넘기는 jsp는 대충 써놓음
         */
        System.out.println("CateringController.getCtDateList");

        Map<String , Object> map =  cateringService.getCtDateList(search, ctDate);

        System.out.println("map = " + map);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("list", map.get("list"));
        modelAndView.setViewName("/views/catering/userList.jsp");

        return modelAndView;
    }


    @RequestMapping( value="addCt", method=RequestMethod.POST)
    public ModelAndView addCt(@ModelAttribute("catering") Catering catering) throws Exception {
          /*
            서비스를 등록!
            이것도 ajax인 것 같기도...^^
         */

        System.out.println("addCt   : POST") ;
        System.out.println("catering = " + catering);

        cateringService.addCt(catering);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("catering", catering);
        modelAndView.setViewName("/views/catering/mainCalendar.jsp");

        return modelAndView;
    }

    @RequestMapping( value="getCtDetail")
    public ModelAndView getCtDetail(@RequestParam("ctNo") int ctNo) throws Exception {
        /*
            서비스내역, 예약 내역을 불러온다.
            상세정보조회.

            0일떄랑 아닐떄를 나눠야하나 고민.
         */
        System.out.println("CateringController.getCtDetail");
        System.out.println("ctNo = " + ctNo);

        Catering catering = cateringService.getCtDetail(ctNo);
        System.out.println("catering = " + catering);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("catering", catering);
        modelAndView.setViewName("/views/catering/getCtDetail.jsp");

        return modelAndView;
    }




    @RequestMapping( value="addCtUser", method=RequestMethod.GET)
    public ModelAndView addCtUser(@RequestParam("ctNo") int ctNo)  throws Exception {
        /*
            이용자가 예약하기 눌렀을 때 보이는 view 화면.
            우선 서비스 값 담아와서 뿌려줘야하기때문에
            getCtDetail을 함
         */
        System.out.println("addCtUser   : GET");
        System.out.println("ctNo = " + ctNo);


        Catering catering = cateringService.getCtDetail(ctNo);
        System.out.println("catering = " + catering);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("catering", catering);
        modelAndView.setViewName("/views/catering/getCtDetail.jsp");

        return modelAndView;
    }





    @RequestMapping( value="updateCtRes", method=RequestMethod.POST)
    public ModelAndView updateCtRes(@ModelAttribute("catering") Catering catering) throws Exception {
        /*
            이용자가 예약한 내용을 수정함
            기준 ; status = 1 이어야 함 (애초에 status가 1이어야 수정 버튼을 보이게 하려고 해서 따로 where절에 조건을 붙이지는 않았음
            추후 견고한 코딩을 위하여 이 부분은 수정할 예정임
         */
        System.out.println("CateringController.updateCtRes");
        System.out.println("catering = " + catering);

        cateringService.updateCtRes(catering);

        Catering resCatering = cateringService.getCtDetail(catering.getCtNo());
        // 업데이트 이후, 등록된 전체 내용을 보내고자 함

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("catering", resCatering);
        modelAndView.setViewName("/views/catering/getCtDetail.jsp");
        return modelAndView;
    }








}