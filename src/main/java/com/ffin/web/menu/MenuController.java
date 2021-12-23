package com.ffin.web.menu;


import com.ffin.service.domain.Menu;
import com.ffin.service.domain.Truck;
import com.ffin.service.menu.MenuService;
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
import javax.servlet.http.HttpServletResponse;

// 메뉴 관리 Controller
@Controller
@RequestMapping("/menu/*")
public class MenuController {

    ///FFF
    @Autowired
    @Qualifier("menuServiceImpl")
    private MenuService menuService;
    //Setter method 구현 안 한다.

    @Autowired
    @Qualifier("truckServiceImpl")
    private TruckService truckService;

    // classpath:config/common.properties,
    // classpath:config/commonservce.xml 참조 할 것
//    @Value("#{commonProperties['pageUnit'] ?: 3")
//    int pageUnit;
//
//    @Value("#{commonProperties['pageSize'] ?: 2")
//    int pageSize;

    @Value("100") //pageUnit은 propertySource를 위에 선언하고 @value의 값을 지정해줌
    //추후 pageUnit과 pageSize 출력되는지 jUnit에서 확인이 필요합니다.
    //@Value("#{commonProperties['pageUnit'] ?: 3}")
    int pageUnit;

    @Value("100")
    int pageSize;

    @RequestMapping(value = "addMenu", method= RequestMethod.GET)
    public ModelAndView addMenu(@RequestParam("truckId") String truckId) throws Exception{

        /*
            사업자가 메뉴를 등록하기 위해 사용하는 화면
            truckId로 truck의 상호를 화면에 뿌려주고, 추가할 메뉴 정보를 받는다.
         */
        System.out.println("/menu/addMenu : GET");
        System.out.println("truckId : " + truckId);

        Truck truck = truckService.getTruck(truckId);
        System.out.println("truck : " + truck);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("truck", truck);
        modelAndView.setViewName("/menu/addMenuView.jsp");

        return modelAndView;
    }
//
//    @RequestMapping(value = "addMenu", method=RequestMethod.POST)
//    public ModelAndView addMenu(@ModelAttribute("menu") Menu menu) throws Exception{
//        /*
//            메뉴 추가 로직
//         */
//        System.out.println("/menu/addMenu : POST");
//        System.out.println("menu = " + menu);
//
//        menuService.addMenu(menu);
//
//        //Business Logic
//
//        ModelAndView modelAndView = new ModelAndView();
//        modelAndView.addObject("menu", menu);
//        modelAndView.setViewName("/truck/getTruck.jsp"); // 추후 진석님께 여쭤보고 변경
//
//        return modelAndView;
//    }


    @RequestMapping(value="getMenu", method=RequestMethod.GET)
    public String getMenu(@RequestParam("menuNo") int menuNo, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception{

        System.out.println("/menu/getMenu : GET");

        String menuNoo=Integer.toString(menuNo);

        String menu = request.getParameter("menu");




        System.out.println("menuNo = " + menuNo + ", model = " + model + ", request = " + request);

        return "forward:/menu/getMenu.jsp";
    }
/*
    @RequestMapping(value="updateMenu", method=RequestMethod.GET)
    public String updateMenu(@RequestParam("menuNo")int menuNo, Model model) throws Exception{

        System.out.println("/menu/updateMenu : GET");

        //Business Logic
        Menu menu = menuService.getMenu(menuNo);
        //Model - View 연결
        model.addAttribute("menu", menu);

        System.out.println("menuNo = " + menuNo + ", model = " + model);

        return "forward:/menu/updateMenuView.jsp";
    }
*/


}
