package com.ffin.web.truck;

import com.ffin.common.Page;
import com.ffin.common.Search;
import com.ffin.service.domain.Truck;
import com.ffin.service.domain.User;
import com.ffin.service.truck.TruckService;
import net.nurigo.java_sdk.Coolsms;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

//==> 트럭관리 RestController
@RestController
@RequestMapping("/truck/*")
public class TruckRestController {

    /// Field
    @Autowired
    @Qualifier("truckServiceImpl")
    private TruckService truckService;
    // setter Method 구현않음

    public TruckRestController() {
        System.out.println(this.getClass());
    }

    @Value("#{commonProperties['pageUnit']}")
    int pageUnit;
    @Value("#{commonProperties['pageSize']}")
    int pageSize;

//
//    @RequestMapping(value="json/truckNearBy/{la},{lo}", method=RequestMethod.GET)
//    @ResponseBody
//    public ModelAndView truckNearBy(@PathVariable("la")float la, @PathVariable("lo")float lo, HttpServletRequest request, HttpServletResponse response) throws Exception{
//        /*
//            위치 기반 트럭 소팅을 위한 !
//         */
//        request.setCharacterEncoding("utf-8");
//
//        System.out.println("MenuController.REST - isThereSigMenu");
//        System.out.println("la = " + la + ", lo = " + lo + ", request = " + request + ", response = " + response);
//
//
//        Search search = new Search();
//        search.setCurrentPage(1);
//        search.setPageSize(100);
//        String id="";
//        Map<String, Object> map = new HashMap<String, Object>();
//
////        int currentPage = Integer.parseInt(request.getP)
//
//        map = menuService.isThereSigMenu(search,truckId);
//        System.out.println("대표메뉴 : " + map.get("list"));
//
//        List menu = new ArrayList();
//        menu = (List) map.get("list");
//        ModelAndView mv = new ModelAndView("jsonView");
//        mv.addObject("menu", menu);
//
//
//
//
//        return mv;
//    }


    @RequestMapping(value = "json/getTruck/{truckId}", method = RequestMethod.GET)
    public Truck getTruck(@PathVariable String truckId) throws Exception {

        System.out.println("/truck/json/getTruck : GET");

        // Business Logic
        return truckService.getTruck(truckId);
    }

    @RequestMapping(value = "json/login/{truckId}", method = RequestMethod.POST)
    public String login(@ModelAttribute("truck") Truck truck, @PathVariable String truckId, HttpSession session,
                        HttpServletRequest request, HttpServletResponse response) throws Exception {

        System.out.println("/truck/jon/login : POST");
        //Business Logic
        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>");

        if(session.getAttribute("user") != null || session.getAttribute("truck") != null || session.getAttribute("admin") != null){
            session.removeAttribute("user");
            session.removeAttribute("truck");
            session.removeAttribute("admin");
        }

        Truck dbTruck = truckService.getTruck(truck.getTruckId());

        if (truck.getTruckPassword().equals(dbTruck.getTruckPassword())) {

            session.setAttribute("truck", dbTruck);
            session.setAttribute("role", "truck");

            if (request.getParameter("truckCookie") == null) {
                System.out.println("자동로그인");

                Cookie loginCookie = new Cookie("loginCookie", session.getId());

                loginCookie.setPath("/");
                int amount = 60 * 60 * 24 * 7;
                loginCookie.setMaxAge(amount);

                System.out.println("쿠키줘!!!" + session.getId());

                response.addCookie(loginCookie);

                Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * amount));
                truckService.autoLogin(truck.getTruckId(), session.getId(), sessionLimit);
            }
            System.out.println("로그인 OK");
            return String.valueOf(0);
        } else {
            System.out.println("로그인 Nope");
            return String.valueOf(9);
        }
    }

    @RequestMapping(value = "json/updateTruck/{truckId}", method = RequestMethod.GET)
    public Truck updateTruck(@PathVariable String truckId, Model model) throws Exception {

        System.out.println("/truck/updateTruck : GET");

        Truck truck = truckService.getTruck(truckId);

        model.addAttribute("truck", truck);

        // Business Logic
        return truck;
    }

    @RequestMapping(value = "json/updateTruck/{truckId}", method = RequestMethod.POST)
    public Truck updateTruck(@ModelAttribute("truck") Truck truck, Model model, HttpSession session) throws Exception {

        System.out.println("/truck/updateTruck : POST");

        truckService.updateTruck(truck);

        String sessionId = ((Truck) session.getAttribute("truck")).getTruckId();
        if (sessionId.equals(truck.getTruckId())) {
            session.setAttribute("truck", truck);
        }

        return truck;
    }

    @RequestMapping(value = "/json/listTruck", method = RequestMethod.POST)
    public Map listTruck(@ModelAttribute("search") Search search, Truck truck, HttpServletRequest request) throws Exception {

        System.out.println("/truck/listTruck : GET / POST");

        if (search.getCurrentPage() == 0) {
            search.setCurrentPage(1);
        }
        search.setPageSize(pageSize);

        Map<String, Object> map = truckService.getTruckList(search);

        Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);

        System.out.println("resultPage :: " + resultPage);

        //list, totalCount
        return map;

    }

    @RequestMapping(value = "/json/addTruck/{truckId}", method = RequestMethod.POST)
    public Truck addTruck(@RequestBody Truck truck, Search search) throws Exception {

        System.out.println("/truck/addTruck : POST");
        //Business Logic

        truckService.addTruck(truck);

        return truck;
    }

    // 푸드트럭 아이디 중복확인
    @RequestMapping(value = "/checkDuId/{truckId}", method = RequestMethod.POST)
    @ResponseBody
    public String checkDuId(@PathVariable String truckId) throws Exception {
        System.out.println("TruckRestController.checkDuId");
        int flag = truckService.checkDuId(truckId);
        String result = "";
        if (flag == 0) {
            result = "y";
        } else {
            result = "n";
        }
        return result;
    }

    // 푸드트럭 상호 중복확인
    @RequestMapping(value = "/checkDuTruckName/{truckName}", method = RequestMethod.POST)
    @ResponseBody
    public String checkDuTruckName(@PathVariable String truckName) throws Exception {
        System.out.println("TruckRestController.checkDuTruckName");
        int flag = truckService.checkDuTruckName(truckName);
        String result = "";
        if (flag == 0) {
            result = "y";
        } else {
            result = "n";
        }
        return result;
    }

    // 푸드트럭 휴대폰번호인증

    @RequestMapping(value = "/phoneCheck/{phone}", method = RequestMethod.GET)
    @ResponseBody
    public String sendSMS(@PathVariable("phone") String truckPhoneNumber) {
        System.out.println("TruckRestController.sendSMS");// 휴대폰 문자보내기
        System.out.println("truckPhoneNumber = " + truckPhoneNumber);
        int randomNumber = (int) ((Math.random() * (9999 - 1000 + 1)) + 1000);//난수 생성
        System.out.println("randomNumber = " + randomNumber);
        truckService.certifiedPhoneNumber(truckPhoneNumber, randomNumber);
        return Integer.toString(randomNumber);
    }

    //아이디 찾기
    @RequestMapping(value = "json/getTruckId", method = RequestMethod.POST)
    @ResponseBody
    public String getUserId(@RequestParam("truckName") String truckName, @RequestParam("truckPhone") String truckPhone,
                            HttpServletRequest request) throws Exception{

        System.out.println("TruckRestController.findTruckId : POST ");

        System.out.println("!!!!!!!!!!!!!! : truckName = " + truckName + ", truckPhone = " + truckPhone);

        Truck truck = new Truck();

        truck.setTruckName(truckName);
        truck.setTruckPhone(truckPhone);

        String result = truckService.findTruckId(truckName, truckPhone);

        if(result == null ){
            return "fail";
        }

        return result;
    }


    //임시비밀번호 전송을 위한 user check
    @RequestMapping(value = "json/getTruckIdForPassword", method = RequestMethod.POST)
    @ResponseBody
    public String getTruckIdForPassword(@RequestParam("truckId") String truckId, @RequestParam("truckName") String truckName,
                                       @RequestParam("truckPhone") String truckPhone, HttpServletRequest request) throws Exception {
        System.out.println("TruckRestController.getTruckPassword : POST");

        Truck truck = new Truck();

        truck.setTruckId(truckId);
        truck.setTruckName(truckName);
        truck.setTruckPhone(truckPhone);

        String result = truckService.getTruckIdForPassword(truckId, truckName, truckPhone);
        System.out.println("임시비밀번호 전송을 위한 truck get!!"+result);
        return result;
    }


    //임시비밀번호전송
    @RequestMapping(value = "json/sendSMSForPassword/{truckPhone}", method = RequestMethod.GET)
    @ResponseBody
    public String sendSMSForPassword(@RequestParam("truckId") String truckId, @PathVariable("truckPhone") String truckPhone,
                                     HttpServletRequest request) throws Exception {

        System.out.println("TruckRestController.sendSMSForPassword");// 휴대폰 문자보내기
        System.out.println("truckPhone = " + truckPhone);

        Random random = new Random();
        int tempPassword = random.nextInt(888888)+111111;

        truckService.sendSMSForPassword(truckId, truckPhone, tempPassword);

        return Integer.toString(tempPassword);

    }

    @RequestMapping(value = "json/getNewTruck/{truckId}", method = RequestMethod.GET)
    public ModelAndView getNewTruck(@PathVariable String truckId) throws Exception {

        System.out.println("TruckRestController.getNewTruck : GET");

        ModelAndView modelAndView = new ModelAndView();
        Truck truck = truckService.getNewTruck(truckId);
        modelAndView.addObject("truck", truck);

        return modelAndView;
    }

    @RequestMapping(value = "json/updateTruckJoin", method = RequestMethod.POST)
    @ResponseBody
    public Truck updateTruckJoin(@ModelAttribute Truck truck, @RequestParam("truckId") String truckId,
                                 @RequestParam("truckJoinReqStatus") int truckJoinReqStatus) throws Exception {

        System.out.println("TruckRestController.updateTruckJoin : POST");
        
        //승인
        if(truckJoinReqStatus == 1){
            truck.setRole(1);
            truckService.updateTruckJoin(truck);
            return truckService.getNewTruck(truckId);
        }
        //거절
        truckService.updateTruckJoin(truck);
        return truckService.getNewTruck(truckId);
    }

}



