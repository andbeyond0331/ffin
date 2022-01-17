package com.ffin.web.catering;



import com.ffin.common.Search;
import com.ffin.service.catering.CateringService;
import com.ffin.service.domain.*;
import com.ffin.service.qna.QnAService;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Date;
import java.util.*;

@RestController
@RequestMapping("/catering/*")
public class CateringRestController {

    ///Field
    @Autowired
    @Qualifier("cateringServiceImpl")
    private CateringService cateringService;


    public CateringRestController(){
        System.out.println(this.getClass());
    }


    @Value("${pageUnit}") //pageUnit은 propertySource를 위에 선언하고 @value의 값을 지정해줌
    //추후 pageUnit과 pageSize 출력되는지 jUnit에서 확인이 필요합니다.
    //@Value("#{commonProperties['pageUnit'] ?: 3}")
    int pageUnit;

    @Value("${pageSize}")
    int pageSize;


    @RequestMapping( value="json/updateUserRes")
    @ResponseBody
    public Catering updateUserRes(HttpServletRequest request, HttpServletResponse response) throws Exception {


        System.out.println("json/updateUserRes   : POST");
        request.setCharacterEncoding("UTF-8");

        // statusCode (수락시/거절시/취소시)
        // memo (수락메모/거절메모/ 취소시null)
        // update method 쓰고 (status와 memo만 업데이트 하는 메소드 생성)
        // return 값은 예약내용 보내야하니까 ResCatering
        Catering catering = new Catering();
        catering = cateringService.getCtDetail(1); // 그냥... 이건 아늶...
        return catering;
    }


    @RequestMapping( value="json/getCtDetail/{ctNo}", method=RequestMethod.GET)
    @ResponseBody
    public ModelAndView getCtDetail(@PathVariable("ctNo") int ctNo, HttpServletRequest request, HttpServletResponse response) throws Exception {
            /*
                서비스내역, 예약 내역을 불러온다.
                상세정보조회.
             */
        request.setCharacterEncoding("UTF-8");

        System.out.println("CateringController.REST");
        System.out.println("ctNo = " + ctNo);


        Catering catering = cateringService.getCtDetail(ctNo);
        System.out.println("catering = " + catering);
            /*Map<String, Object> map = new HashMap<>();
            map.put("ctNo", catering.getCtNo());
            map.put("ctTruckId", catering.getCtTruck().getTruckId());*/
        ModelAndView mv = new ModelAndView("jsonView");
        mv.addObject("catering", catering);

        return mv;
    }


    @RequestMapping( value="json/updateCtResAdd", method=RequestMethod.POST)
    @ResponseBody
    public String updateCtResAdd(HttpServletRequest request, HttpServletResponse response) throws Exception {
        /*
            이용자가 예약을 등록함
         */


        request.setCharacterEncoding("UTF-8");
        System.out.println("CateringController.updateCtResAdd");

        int ctNo = Integer.parseInt(request.getParameter("ctNo"));
        String ctUserId = request.getParameter("ctUserId");
        String ctUserName = request.getParameter("ctUserName");
        String ctPhone = request.getParameter("ctUserPhone");
        String ctAdd = request.getParameter("ctUserAddr");
        String ctAddDetail = request.getParameter("ctUserAddrDetail");
        int ctMenuQty = Integer.parseInt(request.getParameter("ctMenuQty"));
        int ctQuotation = Integer.parseInt(request.getParameter("ctQuotation"));
        String ctStartTime = request.getParameter("ctStartTime");
        String ctEndTime = request.getParameter("ctEndTime");
        String ctUserRequest = request.getParameter("ctUserRequest");

        User user = new User();
        user.setUserId(ctUserId);
        user.setUserName(ctUserName);
        Catering catering = new Catering();
        catering.setCtNo(ctNo);
        catering.setCtUser(user);
        catering.setCtPhone(ctPhone);
        catering.setCtAdd(ctAdd);
        catering.setCtAddDetail(ctAddDetail);
        catering.setCtMenuQty(ctMenuQty);
        catering.setCtQuotation(ctQuotation);
        catering.setCtStartTime(ctStartTime);
        catering.setCtEndTime(ctEndTime);
        catering.setCtUserRequest(ctUserRequest);


        cateringService.updateCtResAdd(catering);

        //Catering resCatering = cateringService.getCtDetail(catering.getCtNo());
        // 업데이트 이후, 등록된 전체 내용을 보내고자 함

       /* ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("catering", resCatering);
        modelAndView.setViewName("/views/catering/getCtDetail.jsp");*/
        return "y";
    }


    @RequestMapping( value="json/updateCtMenuQty", method=RequestMethod.POST)
    @ResponseBody
    public String updateCtMenuQty(HttpServletRequest request, HttpServletResponse response) throws Exception {
           /* 사업자가 등록한 서비스를 수정함
            기준 ; status = 0 이어야 함 (애초에 status가 0이어야 수정 버튼을 보이게 하려고 해서 따로 where절에 조건을 붙이지는 않았음
            추후 견고한 코딩을 위하여 이 부분은 수정할 예정임*/


        System.out.println("CateringController.updateCtMenuQty");
        int ctNo = Integer.parseInt(request.getParameter("ctNo"));
        int ctMenuMinQty = Integer.parseInt(request.getParameter("ctMenuMinQty"));
        int ctMenuMaxQty = Integer.parseInt(request.getParameter("ctMenuMaxQty"));
        System.out.println("ctNo = " + ctNo + ", ctMenuMinQty = " + ctMenuMinQty);
        System.out.println("ctMenuMaxQty = " + ctMenuMaxQty);

        cateringService.updateCtMenuQty(ctNo, ctMenuMinQty, ctMenuMaxQty);

        return "y";
    }

    @RequestMapping( value="json/updateCtServDelete", method=RequestMethod.POST)
    @ResponseBody
    public String updateCtServDelete(@RequestParam("ctNo") int ctNo) throws Exception {
        /*
            statusCode = 6
         */


        System.out.println("CateringController.updateCtServDelete");
        System.out.println("ctno: "+ctNo);
        cateringService.updateCtResCancel(ctNo, "6");

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/views/catering/getCtDetail.jsp");
        return "y";
    }




    @RequestMapping( value="json/getResDetail/{ctNo}", method=RequestMethod.GET)
    @ResponseBody
    public ModelAndView getResDetail(@PathVariable("ctNo") int ctNo, HttpServletRequest request, HttpServletResponse response) throws Exception {
            /*
                예약 내역을 불러온다. 상세정보조회.
             */
        request.setCharacterEncoding("UTF-8");


        System.out.println("CateringController.REST");
        System.out.println("ctNo = " + ctNo);

        Catering catering = cateringService.getResDetail(ctNo);
        System.out.println("catering = " + catering);
            /*Map<String, Object> map = new HashMap<>();
            map.put("ctNo", catering.getCtNo());
            map.put("ctTruckId", catering.getCtTruck().getTruckId());*/
        ModelAndView mv = new ModelAndView("jsonView");
        mv.addObject("catering", catering);

        return mv;
    }


    @RequestMapping( value="json/updateCtResCancel", method=RequestMethod.POST)
    @ResponseBody
    public String updateCtResCancel(@RequestParam("ctNo") int ctNo, @RequestParam("ctStatusCode") String ctStatusCode) throws Exception {
        /*
            이용자 혹은 트럭이 취소를 할 수 있음
            추후 메모가 생기면 메모도 같이 보낼 수 있어야 할 듯
         */


        System.out.println("Rest. CateringController.updateCtResCancel");


        cateringService.updateCtResCancel(ctNo, ctStatusCode);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/views/catering/getCtDetail.jsp");
        return ctStatusCode;
    }


    @RequestMapping( value="json/addCt/{truckId}", method= RequestMethod.GET)
    @ResponseBody
    public ModelAndView addCt(@PathVariable("truckId") String truckId) throws Exception {
        /*
            addCtView
            사업자가 서비스를 등록하기 위해 사용하는 화면
            truckId로 truck의 정보 및 메뉴 정보를 불러와서 화면에 뿌려준다.
         */


        System.out.println("addCt   : GET/REST");
        System.out.println("truckId = " + truckId);

        Catering catering = cateringService.getCtTruckMenu(truckId);



        ModelAndView modelAndView = new ModelAndView("jsonView");
        modelAndView.addObject("catering", catering);


        return modelAndView;
    }


    @RequestMapping( value="json/addCtServ", method= RequestMethod.POST)
    @ResponseBody
    public String addCtServ(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
        /*
            addCtView
            사업자가 서비스를 등록하기 위해 사용하는 화면
         */


        System.out.println("REST  addCt   : POST");
        String truckId = ((Truck)session.getAttribute("truck")).getTruckId();
        System.out.println("truckId = " + truckId);
        int menuNo = Integer.parseInt(request.getParameter("menuNo"));
        System.out.println("menuNo = " + menuNo);
        String ctDate = request.getParameter("ctDate");
        System.out.println("ctDate = " + ctDate);
        int ctMenuMinQty = Integer.parseInt(request.getParameter("ctMenuMinQty"));
        System.out.println("ctMenuMinQty = " + ctMenuMinQty);
        int ctMenuMaxQty = Integer.parseInt(request.getParameter("ctMenuMaxQty"));

        System.out.println("ctMenuMaxQty = " + ctMenuMaxQty);
        
        
        Truck truck = new Truck();
        truck.setTruckId(truckId);
        Menu menu = new Menu();
        menu.setMenuNo(menuNo);
        Catering catering = new Catering();
        catering.setCtTruck(truck);
        catering.setCtMenu(menu);
        catering.setCtDate(ctDate);
        catering.setCtMenuMinQty(ctMenuMinQty);
        catering.setCtMenuMaxQty(ctMenuMaxQty);

        cateringService.addCt(catering);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("catering", catering);
        modelAndView.setViewName("/views/catering/addCtView.jsp");

        return truckId;
    }

    @RequestMapping( value="json/listCatering", method= RequestMethod.POST)
    @ResponseBody
    public ModelAndView listCatering(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
        System.out.println("Rest. CateringController.listCatering");
        request.setCharacterEncoding("UTF-8");

        int currentPage = Integer.parseInt(request.getParameter("currentPage"));
        System.out.println("currentPage : "+currentPage);
        Search search = new Search();
        search.setCurrentPage(currentPage);
        search.setPageSize(pageSize);
        String id="";
        Map<String , Object> map= new HashMap<String , Object>();
        String role = (String)session.getAttribute("role");// role로 구분할 예정 - user / truck
        System.out.println("role = " + role);
        /*
            data
            - ctStatusCode
            - cate : list
            - flag : 0 / 1 / 2
                    0 : listCalendar
                    1 : getCtStatusList
                    2 : getCtServAllList
         */

        String ctct = request.getParameter("ctct");
        String cate = request.getParameter("cate");
        String flag = request.getParameter("flag");

        if ( flag.equals("0") ){ // listCalendar
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

        }else if ( flag.equals("1")){ //getCtStatusList



            if (role == "user" || role.equals("user")) {
                // user 라면

                id = ((User) session.getAttribute("user")).getUserId();
                if (ctct.equals("2") ){
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


        }else if( flag.equals("2")){ //getCtServAllList
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


        }



        ModelAndView modelAndView = new ModelAndView("jsonView");
        modelAndView.addObject("list", map.get("list"));
        modelAndView.addObject("ctct", ctct);

        return modelAndView;
    }




    @RequestMapping( value="json/addPurchaseCt", method= RequestMethod.POST)
    @ResponseBody
    public ModelAndView addPurchaseCt(@RequestParam("ctNo") int ctNo, HttpServletRequest request,
                                      HttpServletResponse response  ) throws Exception {
        /*
            addPurchaseCt
            결제
         */
        System.out.println(">>>>>>>>>>>>>>addPurchaseCt");
        request.setCharacterEncoding("UTF-8");
       // System.out.println("imp uid : "+imp_uid);
        System.out.println("ctNo = " + ctNo);

        //Catering catering = cateringService.getCtTruckMenu(truckId);
        cateringService.updateCtResCancel(ctNo, "5");


        ModelAndView modelAndView = new ModelAndView("jsonView");
        //modelAndView.addObject("catering", catering);


        return modelAndView;
    }
/*


    @RequestMapping( value="json/addReport", method= RequestMethod.POST)
    @ResponseBody
    public ModelAndView addReport(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {



        System.out.println("REST  addReport   : POST");


        Report report = new Report();
        report.setReportUserId(request.getParameter("reportUserId"));
        report.setReportTargetId(request.getParameter("reportTargetId"));
        report.setReportContent(request.getParameter("reportContent"));
        report.setReportLink(request.getParameter("reportLink"));
        report.setReportType(Integer.parseInt(request.getParameter("reportType")));


        qnAService.addReport(report);

        ModelAndView modelAndView = new ModelAndView("jsonView");

        return modelAndView;
    }


*/


}