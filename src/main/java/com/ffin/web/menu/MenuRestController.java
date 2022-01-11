package com.ffin.web.menu;

import com.ffin.common.Search;
import com.ffin.service.domain.Menu;
import com.ffin.service.menu.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/menu/*")
public class MenuRestController {

    ///FFF
    @Autowired
    @Qualifier("menuServiceImpl")
    private MenuService menuService;

    public MenuRestController(){
        System.out.println(this.getClass());
    }

    @Value("${pageUnit}") //pageUnit은 propertySource를 위에 선언하고 @value의 값을 지정해줌
    //추후 pageUnit과 pageSize 출력되는지 jUnit에서 확인이 필요합니다.
    //@Value("#{commonProperties['pageUnit'] ?: 3}")
    int pageUnit;

    @Value("${pageSize}")
    int pageSize;

    @RequestMapping(value="json/getMenu/{menuNo}", method=RequestMethod.GET)
    @ResponseBody
    public ModelAndView getMenu(@PathVariable("menuNo")int menuNo, HttpServletRequest request, HttpServletResponse response) throws Exception{
        /*
            메뉴 상세정보 조회 후 장바구니로 보낼 준비!
         */
        request.setCharacterEncoding("utf-8");

        System.out.println("MenuController.REST");
        System.out.println("menuNo = " + menuNo);

        Menu menu = menuService.getMenu(menuNo);
        System.out.println("menu : " + menu);

        ModelAndView mv = new ModelAndView("jsonView");
        mv.addObject("menu", menu);




        return mv;
    }

    @RequestMapping(value="json/getOptionGroupListOnModal/{menuNo}", method=RequestMethod.GET)
    @ResponseBody
    public ModelAndView getOptionGroupListOnModal(@PathVariable("menuNo")int menuNo, HttpServletRequest request, HttpServletResponse response) throws Exception{
        /*
            모달에서 옵션그룹 조회 후 장바구니로 보낼 준비!
         */
        request.setCharacterEncoding("utf-8");

        System.out.println("MenuController.REST - getOptionGroupListOnModal");
        System.out.println("menuNo = " + menuNo);

        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(100);
        String id="";
        Map<String, Object> map = new HashMap<String, Object>();

//        int currentPage = Integer.parseInt(request.getP)

        map = menuService.getOptionGroupByMenu(search,menuNo);
        System.out.println("optionGroup list : " + map.get("list"));

        List optionGroupList = new ArrayList();
        optionGroupList = (List) map.get("list");
        ModelAndView mv = new ModelAndView("jsonView");
        mv.addObject("optionGroup", optionGroupList);




        return mv;
    }

    @RequestMapping(value="json/isThereSigMenu/{truckId}", method=RequestMethod.GET)
    @ResponseBody
    public ModelAndView isThereSigMenu(@PathVariable("truckId")String truckId, HttpServletRequest request, HttpServletResponse response) throws Exception{
        /*
            트럭에 대표메뉴가 있는지 알아보기!
         */
        request.setCharacterEncoding("utf-8");

        System.out.println("MenuController.REST - isThereSigMenu");
        System.out.println("truckId = " + truckId);

        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(100);
        String id="";
        Map<String, Object> map = new HashMap<String, Object>();

//        int currentPage = Integer.parseInt(request.getP)

        map = menuService.isThereSigMenu(search,truckId);
        System.out.println("대표메뉴 : " + map.get("list"));

        List menu = new ArrayList();
        menu = (List) map.get("list");
        ModelAndView mv = new ModelAndView("jsonView");
        mv.addObject("menu", menu);




        return mv;
    }

    @RequestMapping(value="json/isThereOG/{menuNo}", method=RequestMethod.GET)
    @ResponseBody
    public int isThereOG(@PathVariable("menuNo")int menuNo, HttpServletRequest request, HttpServletResponse response) throws Exception{
        /*
            옵션 그룹 있는지 없는지 알기 위한 rest
         */
        // TODO: 2022-01-09 int return method 추가! - 완료!
        request.setCharacterEncoding("utf-8");

        System.out.println("MenuController.REST - isThereOG");
        System.out.println("menuNo = " + menuNo);

        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(100);
        int count;
        count = menuService.isThereOG(search,menuNo);

        System.out.println("count : " + count);

        return count;
    }

    @RequestMapping(value="json/deleteMenu/{menuNo}", method=RequestMethod.GET)
    @ResponseBody
    public void deleteMenu(@PathVariable("menuNo")int menuNo, HttpServletRequest request, HttpServletResponse response) throws Exception{
        /*
            메뉴 삭제 ㅠㅠㅠ 삭제하지마
         */
        // TODO: 2022-01-10 반드시 옵션그룹까지 깔꼼하게 처리할 것!
        request.setCharacterEncoding("utf-8");

        System.out.println("MenuController.REST - deleteMenu");
        System.out.println("menuNo = " + menuNo);

       Menu menu = menuService.getMenu(menuNo);
        menuService.deleteMenu(menu);

//        System.out.println("count : " + count);

//        return count;
    }


}
