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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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

    public TruckController(){
        System.out.println(this.getClass());
    }

    @Value("#{commonProperties['pageUnit']}")
    int pageUnit;
    @Value("#{commonProperties['pageSize']}")
    int pageSize;

    @RequestMapping( value = "addTruck", method = RequestMethod.GET)
    public String addTruck() throws Exception{

        System.out.println("/truck/addTruck : GET");

        return "/truck/addTruckView.jsp";
    }

    @RequestMapping( value = "addTruck", method=RequestMethod.POST)
    public String addTruck(@ModelAttribute("truck") Truck truck) throws Exception{

        System.out.println("/truck/addTruck : POST");
        //Business Logic
        truckService.addTruck(truck);

        return "redirect:/truck/loginTruck.jsp";
    }

    @RequestMapping( value = "getTruck", method = RequestMethod.GET)
    public ModelAndView getTruck(HttpServletRequest request,ModelAndView m) throws Exception{

        System.out.println("TruckController.getTruck : GET");
        String truckId = request.getParameter("truckId");

        System.out.println("truckId = " + truckId);
        Truck truck = truckService.getTruck(truckId);
        System.out.println("truck = " + truck);
        m.addObject("truck", truck);
        m.setViewName("/truck/getTruck.jsp");

        return m;
    }

    @RequestMapping( value = "updateTruck", method = RequestMethod.GET)
    public String updateTruck( @RequestParam("truckId") String truckId, Model model, HttpSession session) throws Exception{

        System.out.println("/truck/updateTruck : GET");
        //Business Logic
        Truck truck = truckService.getTruck(truckId);
        //Model 과 View 연결
        model.addAttribute("truck", truck);

        return "forward:/truck/updateTruck.jsp";
    }

    @RequestMapping( value = "updateTruck", method = RequestMethod.POST)
    public String updateTruck(@ModelAttribute("truck") Truck truck, Model model, HttpSession session) throws Exception{

        System.out.println("/truck/updateTruck : POST");
        //Business Logic
        truckService.updateTruck(truck);

        String sessionId=((Truck)session.getAttribute("truck")).getTruckId();
        if(sessionId.equals(truck.getTruckId())){
            session.setAttribute("truck",truck);
        }

        return "redirect:/truck/getTruck?truckId="+truck.getTruckId();
    }

    @RequestMapping( value = "loginTruck", method = RequestMethod.GET)
    public String login() throws Exception{

        System.out.println("/truck/loginTruck : GET");

        return "/truck/loginTruck.jsp";
    }

    @RequestMapping( value="loginTruck", method=RequestMethod.POST )
    public String login(@ModelAttribute("truck") Truck truck , HttpSession session ) throws Exception {

        System.out.println("/truck/loginTruck : POST");
        //Business Logic
        Truck dbTruck = truckService.getTruck(truck.getTruckId());

        if (truck.getTruckPassword().equals(dbTruck.getTruckPassword())) {
            session.setAttribute("truck", dbTruck);
            session.setAttribute("role", "truck");
        }

        System.out.println("로그인성공");
        System.out.println("truck = " + truck + ", session = " + session);
        System.out.println("role = " + session.getAttribute("role"));

        return "redirect:/index.jsp";
    }

    @RequestMapping( value="logoutTruck", method= RequestMethod.GET )
    public String logout(HttpSession session ) throws Exception{

        System.out.println("/truck/logoutTruck : GET");

        session.invalidate();

        System.out.println("로그아웃성공");

        return "redirect:/index.jsp";
    }

    @RequestMapping( value="getTruckList" )
    public String getTruckList(@ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{

        System.out.println("/truck/getTruckList : GET / POST");

        if(search.getCurrentPage() ==0 ){
            search.setCurrentPage(1);
        }
        search.setPageSize(pageSize);

        // Business logic 수행
        Map<String , Object> map=truckService.getTruckList(search);

        Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
        System.out.println(resultPage);

        // Model 과 View 연결
        model.addAttribute("list", map.get("list"));
        model.addAttribute("resultPage", resultPage);
        model.addAttribute("search", search);

        return "forward:/truck/getTruckList.jsp";
    }
}
