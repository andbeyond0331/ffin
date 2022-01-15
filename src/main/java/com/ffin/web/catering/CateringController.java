package com.ffin.web.catering;

import com.ffin.common.Page;
import com.ffin.common.Search;
import com.ffin.service.catering.CateringService;
import com.ffin.service.domain.Truck;
import com.ffin.service.domain.User;
import com.ffin.service.truck.TruckService;
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

    @Autowired
    @Qualifier("truckServiceImpl")
    private TruckService truckService;

    public CateringController(){
        System.out.println(this.getClass());
    }


    @Value("${pageUnit}") //pageUnit은 propertySource를 위에 선언하고 @value의 값을 지정해줌
    //추후 pageUnit과 pageSize 출력되는지 jUnit에서 확인이 필요합니다.
    //@Value("#{commonProperties['pageUnit'] ?: 3}")
    int pageUnit;

    @Value("${pageSize}")
    int pageSize;

    private int count=0;
    @RequestMapping( value="mainCalendar", method= RequestMethod.GET)
    public ModelAndView mainCalendar(@ModelAttribute("search") Search search , HttpSession session) throws Exception {

        count++;
        System.out.println("=============================================================");
        System.out.println("count = " + count);

        System.out.println("CateringController.mainCalendar");
           /* 메인 화면
            달력으로 노출할 예정
            이용자, 사업자 구분
            full Calendar ...*/

        String id="";
        Map<String , Object> map= new HashMap<String , Object>();
        String role = (String)session.getAttribute("role");// role로 구분할 예정 - user / truck
        System.out.println("role = " + role);

        String cate = "cld"; // calender 와 list 구분

        if (role == "user" || role.equals("user")){
            // session 처리 되면 주석 풀어서 체크하기. 지금은 임의로 한거.
            //id = ((User)session.getAttribute("user")).getUserId();
            //id = (String) session.getAttribute("userId");
            User user = (User) session.getAttribute("user");
            id = user.getUserId();
            System.out.println("user id: "+id);
            search.setSearchCondition("3"); //user는 mainCalendar에서 내가 예약한건 + 예약가능한 건을 출력한다.
            map = cateringService.getCtDateList(search, id, cate);


        }else if(role == "truck" || role.equals("truck")){
            // truck이라면
            id = ((Truck)session.getAttribute("truck")).getTruckId();
            System.out.println("truck id: "+id);
            search.setSearchCondition("0"); // truck은 mainCalendar에서 내가 등록한 모든 건을 출력한다.
            map = cateringService.getCtDateList(search, id, cate);
        }

        System.out.println("map = " + map);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("list", map.get("list"));
        modelAndView.setViewName("/views/catering/mainCalendar.jsp");
        return modelAndView;
    }


    @RequestMapping( value="listCatering")
    public ModelAndView listCatering(@ModelAttribute("search") Search search, HttpSession session) throws Exception {
          /*
            이용자가 '예약내역목록'을 출력했을 때 노출되는 화면
            초기값 : 전체값
         */

        if(search.getCurrentPage() ==0 ){
            search.setCurrentPage(1);
        }
        search.setPageSize(pageSize);




        System.out.println("CateringController.listCatering");
        String id="";
        Map<String , Object> map= new HashMap<String , Object>();
        String role = (String)session.getAttribute("role");// role로 구분할 예정 - user / truck
        System.out.println("role = " + role);
        String cate = "list";

        if (role == "user" || role.equals("user")){
            // session 처리 되면 주석 풀어서 체크하기. 지금은 임의로 한거.
            //id = ((User)session.getAttribute("user")).getUserId();
            //id = (String) session.getAttribute("userId");
            User user = (User) session.getAttribute("user");
            id = user.getUserId();
            System.out.println("user id: "+id);
            search.setSearchCondition("0"); // user가 예약한 모든 내역을 출력한다.
            map =  cateringService.getCtList(search, id, cate);

        }else if(role == "truck" || role.equals("truck")){
            // truck이라면
            id = ((Truck)session.getAttribute("truck")).getTruckId();
            System.out.println("truck id: "+id);
            search.setSearchCondition("1");
            map =  cateringService.getCtList(search, id, cate);
        }


        System.out.println("map = " + map);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("list", map.get("list"));
        modelAndView.addObject("flag", "0");

        modelAndView.setViewName("/views/catering/ListCatering.jsp");

        return modelAndView;
    }


    @RequestMapping( value="getCtStatusList")
    public ModelAndView getCtStatusList(@ModelAttribute("search") Search search, @RequestParam("ctct") String ctct, @RequestParam("cate") String cate, HttpSession session) throws Exception {
        /*
            '예약내역목록' 에서 탭별로 다른 값 노출
           0 : 이용자의 STATUS 값 조회
           1 : 사업자의 STATUS 값 조회
            Ajax 로 노출시킬지 고민 중.
         */

        System.out.println("CateringController.getCtStatusList");


        if(search.getCurrentPage() ==0 ){
            search.setCurrentPage(1);
        }
        search.setPageSize(pageSize);



        String id="";
        System.out.println("/////////ctStatusCode: "+ctct);
        Map<String , Object> map= new HashMap<String , Object>();
        String role = (String)session.getAttribute("role");// role로 구분할 예정 - user / truck
        System.out.println("role = " + role);
        ModelAndView modelAndView = new ModelAndView();


            if (role == "user" || role.equals("user")) {
                // user 라면

                id = ((User) session.getAttribute("user")).getUserId();
                if (ctct.equals("2")){
                    search.setSearchCondition("3");
                }else {
                    search.setSearchCondition("0"); //statusCode에 따라 출력
                }
            } else if (role == "truck" || role.equals("truck")) {
                // truck이라면

                id = ((Truck) session.getAttribute("truck")).getTruckId();
                System.out.println("truck id: " + id);
                if (ctct.equals("2") ){

                    search.setSearchCondition("4");

                }else {
                    search.setSearchCondition("1"); //statusCode에 따라 출력
                }



        }



        map = cateringService.getCtStatusList(search, id, ctct, cate);

        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.");
        System.out.println("ctStatus : "+ctct);
        System.out.println(map.get("list"));

        modelAndView.addObject("list", map.get("list"));
        modelAndView.addObject("flag", "1");
        modelAndView.addObject("ctct", ctct);
        if (cate == "list" || cate.equals("list")) {
            modelAndView.setViewName("/views/catering/ListCatering.jsp");
        }else{
            modelAndView.setViewName("/views/catering/mainCalendar.jsp");
        }
        return modelAndView;
    }



    @RequestMapping( value="getCtServAllList")
    public ModelAndView getCtServAllList(@ModelAttribute("search") Search search, @RequestParam("cate") String cate, HttpSession session) throws Exception {
        /*
            예약 가능한 서비스 출력, 즉 statusCode=0 인 것 출력
            이 때, user는 전체 서비스고 (condition=2)
            truck은 본인의 서비스만 출력
            search.condition 값 (1) 로 구분한당.
         */

        System.out.println("CateringController.getCtStatusList");


        if(search.getCurrentPage() ==0 ){
            search.setCurrentPage(1);
        }
        search.setPageSize(pageSize);




        String id="";

        Map<String , Object> map= new HashMap<String , Object>();
        String role = (String)session.getAttribute("role");// role로 구분할 예정 - user / truck
        System.out.println("role = " + role);
        ModelAndView modelAndView = new ModelAndView();


        if (role == "user" || role.equals("user")) {
            // user 라면

            id = ((User) session.getAttribute("user")).getUserId();
            search.setSearchCondition("2");

        } else if (role == "truck" || role.equals("truck")) {
            // truck이라면

            id = ((Truck) session.getAttribute("truck")).getTruckId();

            search.setSearchCondition("1");


        }


        map = cateringService.getCtDateList(search, id, cate);

        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.");
        System.out.println(map.get("list"));
        modelAndView.addObject("list", map.get("list"));
        modelAndView.addObject("flag", "2");

        if (cate == "list" || cate.equals("list")) {
            modelAndView.setViewName("/views/catering/ListCatering.jsp");
        }else{
            modelAndView.setViewName("/views/catering/mainCalendar.jsp");
        }
        return modelAndView;
    }



    /*
        HHJ
        메인창 열릴 때 별점 순으로 소팅할까 하는데! 지금은 테스트로 1~15만 노출되게 해보려고 하유.
        todo: 별점 순이라면 별점 순 query 필요함

     */
    @RequestMapping(value="/mainTruckList", method=RequestMethod.GET)
    public ModelAndView mainTruckList(HttpServletRequest request, HttpServletResponse response) throws Exception{

        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(15);
        Map<String, Object> map = new HashMap<String, Object>();

//        int currentPage = Integer.parseInt(request.getP)

        // todo : 우선은 테스트로 la, lo를 고정값으로 두었음 만들어둔거로 테스트 해보려고
        float la = (float) 37.57041195853664;
        float lo = (float) 126.98503967552996;

        map = truckService.truckNearBy(search,la, lo);

        System.out.println("위치기반 결과 : " + map.get("list"));

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("list", map.get("list"));
        modelAndView.setViewName("/views/home.jsp");



        return modelAndView;
    }

    /*
        위/경도 받아서 메인 출력하려고
     */
    @RequestMapping(value="/mainTruckListLaLo", method=RequestMethod.POST)
    public ModelAndView mainTruckListLaLo(HttpServletRequest request, @RequestParam("lo") float lo, @RequestParam("la") float la, @RequestParam("address") String address, HttpServletResponse response) throws Exception{
        request.setCharacterEncoding("UTF-8");

        System.out.println("mainTruckListLaLo !!!!!!!!!!!!!!!!!!!!!!!1 post");
        System.out.println("lo = " + lo + ", la = " + la +", address: "+address);
        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(15);
        Map<String, Object> map = new HashMap<String, Object>();

//        int currentPage = Integer.parseInt(request.getP)


        map = truckService.truckNearBy(search,la, lo);

        System.out.println("위치기반 결과 : " + map.get("list"));

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("list", map.get("list"));
        modelAndView.addObject("inputLocation", address);
        modelAndView.setViewName("/views/home.jsp");



        return modelAndView;
    }




}