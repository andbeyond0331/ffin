package com.ffin.web.menu;


import com.ffin.common.Page;
import com.ffin.common.Search;
import com.ffin.service.domain.Menu;
import com.ffin.service.domain.Truck;
import com.ffin.service.domain.User;
import com.ffin.service.menu.MenuService;
import com.ffin.service.truck.TruckService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Map;

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

//    @RequestMapping(value = "addMenu", method= RequestMethod.GET)
//    public ModelAndView addMenu(@RequestParam("truckId") String truckId) throws Exception{
//
//        /*
//            사업자가 메뉴를 등록하기 위해 사용하는 화면
//            truckId로 truck의 상호를 화면에 뿌려주고, 추가할 메뉴 정보를 받는다.
//         */
//        System.out.println("/menu/addMenu : GET");
//        System.out.println("truckId : " + truckId);
//
//        Truck truck = truckService.getTruck(truckId);
//        System.out.println("truck : " + truck);
//
//        ModelAndView modelAndView = new ModelAndView();
//        modelAndView.addObject("truck", truck);
//        modelAndView.setViewName("/menu/addMenuView.jsp");
//
//        return modelAndView;
//    }
        // 메뉴 추가 옵션그룹이랑 같이 하는 방법 고안1
        @PostMapping ("addMenu")
    public ResponseEntity<Menu> addMenu(Menu menu, String[] optionGroupName, String[] optionName, Integer[] optionPrice, @RequestParam("truckId") String truckId) throws Exception{

        /*
            사업자가 메뉴를 등록하기 위해 사용하는 화면
            truckId로 truck의 상호를 화면에 뿌려주고, 추가할 메뉴 정보를 받는다.
            optionGroup 도 함께 등록하기 위해 노력해본다.
         */

//            menuService.addMenu(menu, map);
            return new ResponseEntity<Menu>(menu, HttpStatus.OK);
//        System.out.println("/menu/addMenu : GET");
//        System.out.println("truckId : " + truckId);
//
//        Truck truck = truckService.getTruck(truckId);
//        System.out.println("truck : " + truck);
//
//        ModelAndView modelAndView = new ModelAndView();
//        modelAndView.addObject("truck", truck);
//        modelAndView.setViewName("/menu/addMenuView.jsp");
//
//        return modelAndView;
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
    public String getMenu(@RequestParam(value="menuNo", required = false) int menuNo, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception{

        System.out.println("/menu/getMenu : GET");

        System.out.println("menuNo = " + menuNo + ", model = " + model + ", request = " + request + ", response = " + response);
//
//        int menuNoo = Integer.parseInt(menuNo);
//
//        System.out.println("menuNoo : " + menuNoo);

        Menu menu = menuService.getMenu(menuNo);

        System.out.println("menu : " + menu);

        model.addAttribute("menu", menu);
        model.addAttribute("menuNo", menuNo);



        System.out.println("menuNo = " + menuNo + ", model = " + model + ", request = " + request + ", response = " + response);

        return "forward:/menu/getMenu.jsp";
    }



    @RequestMapping(value="updateMenu", method=RequestMethod.GET)
    public ModelAndView updateMenu(HttpServletRequest request, ModelAndView modelAndView) throws Exception{

        System.out.println("/menu/updateMenu : GET");

        //Business Logic

        String menuNoo = request.getParameter("menuNo");

        int menuNo = Integer.parseInt(menuNoo);

        Menu menu = menuService.getMenu(menuNo);

        //Model - View 연결
        modelAndView.addObject("menu", menu);
        modelAndView.setViewName("/menu/updateMenuView.jsp");

        System.out.println("request = " + request + ", modelAndView = " + modelAndView);

        return modelAndView;
    }

    @RequestMapping("getMenuList")
    public ModelAndView getMenuList(@ModelAttribute("search") Search search, @RequestParam("truckId") String truckId,
                                  HttpServletRequest request, ModelAndView modelAndView) throws Exception{

        search.setPageSize(pageSize);
        Truck truck  = truckService.getTruck(truckId);

        Map<String , Object> map= menuService.getMenuList(search, truck.getTruckId());

        modelAndView.addObject("list", map.get("list"));
        modelAndView.setViewName("/menu/getTruck.jsp");
//       model.addAttribute("list", map.get("list"));
//        model.addAttribute("search", search);

        return modelAndView;
    }

    @RequestMapping(value="deleteMenu", method=RequestMethod.POST)
    public ModelAndView deleteMenu(HttpServletRequest request, ModelAndView modelAndView) throws Exception{

        System.out.println("/menu/deleteMenu : GET");

        //Business Logic

        String menuNoo = request.getParameter("menuNo");

        int menuNo = Integer.parseInt(menuNoo);

        Menu menu = menuService.getMenu(menuNo);

        menuService.deleteMenu(menu);

        //Model - View 연결
        modelAndView.addObject("menu", menu);
        modelAndView.setViewName("/menu/updateMenuView.jsp"); // 진석님과 메뉴 수정 어디서 할 지 상의해보고

        System.out.println("request = " + request + ", modelAndView = " + modelAndView);

        return modelAndView;
    }



}
