package com.ffin.web.truck;

import com.ffin.common.Page;
import com.ffin.common.Search;
import com.ffin.service.domain.Truck;
import com.ffin.service.truck.TruckService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
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

        return "/truck/addTruckView.jsp";
    }
    // 회원가입
    @RequestMapping(value = "addTruck", method = RequestMethod.POST)
    public String addTruck(@ModelAttribute("truck") Truck truck, @RequestParam("busiLice") MultipartFile file1, @RequestParam("proImg") MultipartFile file2, Model model, HttpServletRequest request) throws Exception {

        System.out.println("/truck/addTruck : POST");
        //Business Logic
        System.out.println("truck = " + truck);

        String temDir = "/Users/js/IdeaProjects/ffin/src/main/webapp/resources/image";

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
        m.setViewName("/truck/getTruck.jsp");

        return m;
    }

//    @RequestMapping(value = "updateTruck", method = RequestMethod.GET)
//    public String updateTruck(@RequestParam("truckId") String truckId, Model model, HttpSession session) throws Exception {
//
//        System.out.println("/truck/updateTruck : GET");
//        //Business Logic
//        Truck truck = truckService.getTruck(truckId);
//        //Model 과 View 연결
//        model.addAttribute("truck", truck);
//
//        return "forward:/truck/updateTruck.jsp";
//    }
//
//    @RequestMapping(value = "updateTruck", method = RequestMethod.POST)
//    public String updateTruck(@ModelAttribute("truck") Truck truck, Model model, HttpSession session) throws Exception {
//
//        System.out.println("/truck/updateTruck : POST");
//        //Business Logic
//        truckService.updateTruck(truck);
//
//        String sessionId = ((Truck) session.getAttribute("truck")).getTruckId();
//        if (sessionId.equals(truck.getTruckId())) {
//            session.setAttribute("truck", truck);
//        }
//
//        return "redirect:/truck/getTruck?truckId=" + truck.getTruckId();
//    }

    // 트럭 로그인 화면 요청 // 이제 안씀
    @RequestMapping(value = "loginTruck", method = RequestMethod.GET)
    public String login() throws Exception {

        System.out.println("/truck/loginTruck : GET");

        return "/truck/loginTruck.jsp";
    }
    // 트럭 로그인 // 이제 안씀
    @RequestMapping(value = "loginTruck", method = RequestMethod.POST)
    public String login(@ModelAttribute("truck") Truck truck, HttpSession session) throws Exception {

        System.out.println("/truck/loginTruck : POST");
        //Business Logic
        Truck dbTruck = truckService.getTruck(truck.getTruckId());

        if (truck.getTruckPassword().equals(dbTruck.getTruckPassword())) {
            session.setAttribute("truck", dbTruck);
            session.setAttribute("truckId", dbTruck.getTruckId());
            session.setAttribute("role", "truck");
        }

        System.out.println("로그인성공");
        System.out.println("truck = " + truck + ", session = " + session);
        System.out.println("truckId = " + session.getAttribute("truckId"));
        System.out.println("role = " + session.getAttribute("role"));

        return "redirect:/views/home.jsp";
    }
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

        return "forward:/truck/getTruckList.jsp";
    }

    // 회원탈퇴화면 요청
    @RequestMapping(value = "byeTruck", method = RequestMethod.GET)
    public String byeTruck(@RequestParam("truckId")String truckId, Model model, HttpSession session) throws Exception{

        System.out.println("/truck/byeTruck : GET");
        //Business Logic
        Truck truck = truckService.getTruck(truckId);
        //Model 과 View 연결
        model.addAttribute("truck", truck);

        return "/truck/byeTruck.jsp";
    }

    // 회원탈퇴
    @RequestMapping(value = "byeTruck", method = RequestMethod.POST)
    //public String byeTruck(@ModelAttribute("truck") Truck truck, @RequestParam("truckByeReason") int truckByeReason , HttpSession session) throws Exception{
    public String byeTruck(@ModelAttribute("truckId") String truckId, HttpSession session) throws Exception{

        System.out.println("/truck/byeTruck : POST");
        //Business Logic
        Truck byeTruck = (Truck) session.getAttribute("truckId");
        //String sessionId = ((Truck) session.getAttribute("truck")).getTruckId();
        //if(sessionId.equals(truck.getTruckId())){
            //truck.setTruckByeReason(session.getAttribute("truckByeReason", truck));
            byeTruck.setTruckByeStatus(1);
            //truck.setTruckByeReason(truckByeReason);
            truckService.byeTruck(byeTruck);
            System.out.println("회원탈퇴완료");
        //}

        return "redirect:/views/home.jsp";
    }

}
