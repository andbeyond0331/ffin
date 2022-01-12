package com.ffin.web.truck;

import com.ffin.common.Page;
import com.ffin.common.Search;
import com.ffin.service.domain.Truck;
import com.ffin.service.truck.TruckService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.Map;

//==> 트럭관리 Controller
@Controller
@RequestMapping("/truck/*")
public class TruckController {

    ///Field
    @Autowired
    private JavaMailSender mailSender;
    @Autowired
    @Qualifier("truckServiceImpl")
    private TruckService truckService;
    //setter Method 구현않음

    public TruckController() {
        System.out.println(this.getClass());
    }

    @Value("#{commonProperties['pageUnit']}")
    int pageUnit;
    @Value("#{commonProperties['pageSize']}")
    int pageSize;

    // 회원가입화면요청
    @RequestMapping(value = "addTruck", method = RequestMethod.GET)
    public String addTruck() throws Exception {

        System.out.println("/truck/addTruck : GET");

        return "/views/truck/addTruckView.jsp";
    }

    // 회원가입
    @RequestMapping(value = "addTruck", method = RequestMethod.POST)
    public String addTruck(@ModelAttribute("truck") Truck truck, @RequestParam("busiLice") MultipartFile file1, @RequestParam("proImg") MultipartFile file2, Model model, HttpServletRequest request) throws Exception {

        System.out.println("/truck/addTruck : POST");
        //Business Logic
        System.out.println("truck = " + truck);

        //String temDir = "/Users/js/IdeaProjects/ffin/src/main/webapp/resources/image";
        String temDir = request.getSession().getServletContext().getRealPath("/resources/image");

        System.out.println("temDir = " + temDir);


        if (!file1.getOriginalFilename().isEmpty()) {
            file1.transferTo(new File(temDir, file1.getOriginalFilename()));
        }
        if (!file2.getOriginalFilename().isEmpty()) {
            file2.transferTo(new File(temDir, file2.getOriginalFilename()));
        }

        truck.setTruckBusiLice(file1.getOriginalFilename());
        truck.setTruckProImg(file2.getOriginalFilename());
        truckService.addTruck(truck);

        model.addAttribute("truck", truck);

        return "redirect:/views/home.jsp";
    }

    // 트럭조회
    @RequestMapping(value = "getTruck", method = RequestMethod.GET)
    public ModelAndView getTruck(HttpServletRequest request, ModelAndView m) throws Exception {

        System.out.println("TruckController.getTruck : GET");
        String truckId = request.getParameter("truckId");

        System.out.println("truckId = " + truckId);
        Truck truck = truckService.getTruck(truckId);
        System.out.println("truck = " + truck);
        m.addObject("truck", truck);
        m.setViewName("/views/truck/getTruck.jsp");

        return m;
    }

    // 트럭조회
    @RequestMapping(value = "getTruckInfo", method = RequestMethod.GET)
    public String getTruckInfo(Model model, HttpSession session) throws Exception {

        System.out.println("/truck/getTruckInfo : GET");

        Truck truck = (Truck) session.getAttribute("truck");
        //Model 과 View 연결
        model.addAttribute("truck", truck);

        return "forward:/views/truck/getTruckInfo.jsp";
    }

    @RequestMapping(value = "getNotice", method = RequestMethod.GET)
    public String getNotice(Model model, HttpSession session) throws Exception {

        System.out.println("/truck/getNotice : GET");

        Truck truck = (Truck) session.getAttribute("truck");

        String truckId = (String) truck.getTruckId();

        System.out.println("truckId = " + truckId);

        model.addAttribute("truck", truck);

        truckService.getNotice(truckId);

        session.setAttribute("truckId", truckId);

        return "forward:/views/truck/getNotice.jsp";
    }

    @RequestMapping(value = "updateNotice", method = RequestMethod.GET)
    public String updateNotice(@ModelAttribute("truck")Truck truck, Model model, HttpSession session) throws Exception {

        System.out.println("/truck/updateNotice : GET");
        //Business Logic
        truck = (Truck) session.getAttribute("truck");

        String truckId = (String) truck.getTruckId();

        System.out.println("truckId = " + truckId);

        Truck notice = truckService.getNotice(truckId);
        //Model 과 View 연결
        model.addAttribute("truck", notice);

        return "forward:/views/truck/updateNotice.jsp";
    }

    @RequestMapping(value = "updateNotice", method = RequestMethod.POST)
    public String updateNotice(@ModelAttribute("truck") Truck truck, @RequestParam("truckNoticeTitle") String truckNoticeTitle, @RequestParam("truckNoticeContent")String truckNoticeContent, @RequestParam("truckNoticeImg1") MultipartFile file1, Model model, HttpSession session, HttpServletRequest request) throws Exception {

        System.out.println("/truck/updateNotice : POST");

        truck = (Truck) session.getAttribute("truck");

        String truckId = (String) truck.getTruckId();

        System.out.println("truckId = " + truckId);

        String temDir = request.getSession().getServletContext().getRealPath("/resources/image");

        if (!file1.getOriginalFilename().isEmpty()) {
            file1.transferTo(new File(temDir, file1.getOriginalFilename()));
        }

        truck.setTruckNoticeImg(file1.getOriginalFilename());
        truck.setTruckId(truckId);
        truck.setTruckNoticeTitle(truckNoticeTitle);
        truck.setTruckNoticeContent(truckNoticeContent);

        model.addAttribute("truck", truck);

        truckService.updateNotice(truck);

        return "redirect:/truck/getNotice?truckId="+truckId;
    }


    @RequestMapping(value = "updateTruckInfo", method = RequestMethod.GET)
    public String updateTruckInfo(Model model, HttpSession session) throws Exception {

        System.out.println("/truck/updateTruckInfo : GET");
        //Business Logic
        String truckId = (String) session.getAttribute("truckId");

        Truck truck = truckService.getTruck(truckId);
        //Model 과 View 연결
        model.addAttribute("truck", truck);

        return "/views/truck/updateTruckInfo.jsp";
    }

    @RequestMapping(value = "updateTruckInfo", method = RequestMethod.POST)
    public String updateTruckInfo(@ModelAttribute("truck") Truck truck, @RequestParam("busiLice") MultipartFile file1, @RequestParam("proImg") MultipartFile file2, Model model, HttpSession session, HttpServletRequest request) throws Exception {

        System.out.println("/truck/updateTruckInfo : POST");
        //Business Logic

        String temDir = request.getSession().getServletContext().getRealPath("/resources/image");

        if (!file1.getOriginalFilename().isEmpty()) {
            file1.transferTo(new File(temDir, file1.getOriginalFilename()));
        }
        if (!file2.getOriginalFilename().isEmpty()) {
            file2.transferTo(new File(temDir, file2.getOriginalFilename()));
        }

        truck.setTruckBusiLice(file1.getOriginalFilename());
        truck.setTruckBusiLice(file2.getOriginalFilename());

        truckService.updateTruckInfo(truck);

        session.setAttribute("truck", truck);

        return "redirect:/truck/getTruckInfo?truckId=" + truck.getTruckId();
    }


    @RequestMapping(value = "updateTruckPassword", method = RequestMethod.GET)
    public String updateTruckPassword(Model model, HttpSession session, HttpServletRequest request) throws Exception {

        System.out.println("/truck/updateTruckPassword : GET");

        String truckPassword = request.getParameter("passwordC");

        System.out.println("truckPassword = " + truckPassword);

        model.addAttribute("passwordC", truckPassword);

        return "/views/truck/updateTruckPasswordBefore.jsp";
    }


    // 트럭 Password 변경
    @RequestMapping(value = "updateTruckPasswordB", method = RequestMethod.POST)
    public String updateTruckPasswordB(@ModelAttribute("truck") Truck truck ,Model model, HttpSession session, HttpServletRequest request) throws Exception {

        System.out.println("/truck/updateTruckPasswordB : POST");

        String truckPassword = request.getParameter("passwordC");

        System.out.println("truckPassword = " + truckPassword);

        truck = (Truck) session.getAttribute("truck");

        //System.out.println("truck = " + truck);

        Truck dbTruck = truckService.getTruck(truck.getTruckId());

        //System.out.println("dbTruck = " + dbTruck);

        System.out.println("dbTruckPassword : "+dbTruck.getTruckPassword());

        if(truckPassword.equals(dbTruck.getTruckPassword())){
            System.out.println("11111");
            model.addAttribute(truck);
            System.out.println("model = " + model);
        }else{
            System.out.println("password가 일치하지않습니다");
        }

        return "redirect:/views/truck/updateTruckPassword.jsp" ;
    }


    // 트럭 Password 변경
    @RequestMapping(value = "updateTruckPassword", method = RequestMethod.POST)
    public String updateTruckPassword(@ModelAttribute("truck") Truck truck,  Model model, HttpSession session, HttpServletRequest request) throws Exception {

        System.out.println("/truck/updateTruckPassword : POST");
        //Business Logic

        String newPassword = request.getParameter("truckPasswordChk");

        System.out.println("newPassword = " + newPassword);

        truck = (Truck) session.getAttribute("truck");

        System.out.println("truck = " + truck);

        truck.setTruckPassword(newPassword);

        truckService.updateTruckPassword(truck);

        session.invalidate();

        return "redirect:/views/home.jsp";
    }

    // 트럭 로그인 화면 요청 // 이제 안씀
    @RequestMapping(value = "loginTruck", method = RequestMethod.GET)
    public String login() throws Exception {

        System.out.println("/truck/loginTruck : GET");

        return "/truck/loginTruck.jsp";
    }
//
//    // 트럭 로그인 // 이제 안씀
//    @RequestMapping(value = "loginTruck", method = RequestMethod.POST)
//    public String login(@ModelAttribute("truck") Truck truck, HttpSession session) throws Exception {
//
//        System.out.println("/truck/loginTruck : POST");
//        //Business Logic
//        Truck dbTruck = truckService.getTruck(truck.getTruckId());
//
//        if (truck.getTruckPassword().equals(dbTruck.getTruckPassword())) {
//            session.setAttribute("truck", dbTruck);
//            session.setAttribute("truckId", dbTruck.getTruckId());
//            session.setAttribute("role", "truck");
//        }
//
//        System.out.println("로그인성공");
//        System.out.println("truck = " + truck + ", session = " + session);
//        System.out.println("truckId = " + session.getAttribute("truckId"));
//        System.out.println("role = " + session.getAttribute("role"));
//
//        return "redirect:/views/home.jsp";
//    }

    // 로그아웃
    @RequestMapping(value = "logoutTruck", method = RequestMethod.GET)
    public String logout(HttpSession session) throws Exception {

        System.out.println("/truck/logoutTruck : GET");

        session.invalidate();

        System.out.println("로그아웃성공");

        return "redirect:/views/home.jsp";
    }

    // 트럭 리스트
    @RequestMapping(value = "getTruckList")
    public String getTruckList(@ModelAttribute("search") Search search, Model model, HttpServletRequest request) throws Exception {

        System.out.println("/truck/getTruckList : GET / POST");

        if (search.getCurrentPage() == 0) {
            search.setCurrentPage(1);
        }
        search.setPageSize(pageSize);

        // Business logic 수행
        Map<String, Object> map = truckService.getTruckList(search);

        Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
        System.out.println(resultPage);

        // Model 과 View 연결
        model.addAttribute("list", map.get("list"));
        model.addAttribute("resultPage", resultPage);
        model.addAttribute("search", search);

        return "forward:/views/user/getTruckListByAdmin.jsp";
    }

    // 회원탈퇴화면 요청
    @RequestMapping(value = "byeTruck", method = RequestMethod.GET)
    public String byeTruck() throws Exception {

        System.out.println("/truck/byeTruck : GET");

        return "/views/truck/byeTruck.jsp";
    }

    // 회원탈퇴
    @RequestMapping(value = "byeTruck", method = RequestMethod.POST)
    public String byeTruck(@ModelAttribute("truckId") String truckId, @ModelAttribute("truckPassword") String truckPassword, @ModelAttribute("truck") Truck truck, @RequestParam("truckByeReason") int truckByeReason, Model model, HttpSession session, HttpServletRequest request) throws Exception {

        System.out.println("/truck/byeTruck : POST");
        //Business Logic
        // 세션 값 불러오기
        truckId = (String) (session.getAttribute("truckId"));

        System.out.println("truckId = " + truckId);

        truck = (Truck) session.getAttribute("truck");

        // 탈퇴사유 받아오기 getParameter
        truckByeReason = Integer.parseInt(request.getParameter("truckByeReason"));
        System.out.println("truckByeReason = " + truckByeReason);

        truck.setTruckByeStatus(1);
        truck.setTruckByeReason(truckByeReason);

        // DB Update
        truckService.byeTruck(truck);

        System.out.println("탈퇴성공");

        // 세션 값 삭제
        session.invalidate();

        // 홈화면으로 이동
        return "redirect:/views/home.jsp";
    }

    // 사업자 아이디 찾기 화면 요청
    @RequestMapping(value = "findTruckId", method = RequestMethod.GET)
    public String findTruckId() throws Exception {

        System.out.println("/truck/findTruckId : GET");

        return "/views/truck/findTruckId.jsp";
    }

    // 사업자 아이디 찾기
    @RequestMapping(value = "findTruckId", method = RequestMethod.POST)
    @ResponseBody
    public String findTruckId(@ModelAttribute("truckId") String truckId, @RequestParam("inputName_1") String truckName, @RequestParam("inputPhone_1") String truckPhone, HttpServletRequest request) throws Exception {

        System.out.println("/truck/findTruckId : POST");

        truckName = request.getParameter("inputName_1");
        truckPhone = request.getParameter("inputPhone_1");

        System.out.println("truckName = " + truckName);
        System.out.println("truckPhone = " + truckPhone);

        Truck truck = new Truck();

        truck.setTruckName(truckName);
        truck.setTruckPhone(truckPhone);

        String result = truckService.findTruckId(truckName, truckPhone);

        return result;
    }
//
//    // 사업자 비밀번호 찾기
//    @RequestMapping(value = "findPassword", method = RequestMethod.GET)
//    @ResponseBody
//    public String passwordSearch(@RequestParam("truckId")String truckId,
//                                 @RequestParam("truckEmail")String truckEmail,
//                                 HttpServletRequest request) {
//
//        mailSender.mailSendWithPassword(truckId, truckEmail, request);
//
//        return "truck/truckFindPassword";
//    }


    @RequestMapping(value = "getSalesList")
    public String getSalesList(@ModelAttribute("search") Search search, Model model, HttpServletRequest request, HttpSession session) throws Exception {

        System.out.println("/truck/getSalesList : GET/POST");

        Truck truck = (Truck) session.getAttribute("truck");

        String truckId = truck.getTruckId();

        System.out.println("truckId = " + truckId);

        if (search.getCurrentPage() == 0) {
            search.setCurrentPage(1);
        }
        search.setPageSize(pageSize);

        // Business Logic 수행
        Map<String, Object> map = truckService.getSalesList(search, truckId);

        Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
        System.out.println(resultPage);
        //  Model 과 View 연결
        model.addAttribute("list", map.get("list"));
        model.addAttribute("resultPage", resultPage);
        model.addAttribute("search", search);

        System.out.println("map = " + map);

        return "forward:/views/truck/getSalesList.jsp";

    }
}
