package com.ffin.web.menu;


import com.ffin.service.domain.Menu;
import com.ffin.service.menu.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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

    public MenuController(){
        System.out.println(this.getClass());
    }

    // classpath:config/common.properties,
    // classpath:config/commonservce.xml 참조 할 것
//    @Value("#{commonProperties['pageUnit'] ?: 3")
//    int pageUnit;
//
//    @Value("#{commonProperties['pageSize'] ?: 2")
//    int pageSize;

    @RequestMapping(value = "addMenu", method= RequestMethod.GET)
    public String addMenu() throws Exception{

        System.out.println("/menu/addMenu : GET");

        return "redirect:/menu/addMenuView.jsp";
    }

    @RequestMapping(value = "addMenu", method=RequestMethod.POST)
    public String addMenu(@ModelAttribute("menu") Menu menu) throws Exception{

        System.out.println("/menu/addMenu : POST");

        //Business Logic

        System.out.println("menu = " + menu);

        return "forward:/menu/addMenu.jsp";
    }
/*

    @RequestMapping(value="getMenu", method=RequestMethod.GET)
    public String getMenu(@RequestParam("menuNo") int menuNo, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception{

        System.out.println("/menu/getMenu : GET");

        String menuNoo=Integer.toString(menuNo);

        String menu = request.getParameter("menu");




        System.out.println("menuNo = " + menuNo + ", model = " + model + ", request = " + request);

        return "forward:/menu/getMenu.jsp";
    }

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
