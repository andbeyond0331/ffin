package com.ffin.web.menu;


import com.ffin.common.Page;
import com.ffin.common.Search;
import com.ffin.service.domain.Menu;
import com.ffin.service.domain.OptionGroup;
import com.ffin.service.domain.Truck;
import com.ffin.service.domain.User;
import com.ffin.service.menu.MenuService;
import com.ffin.service.review.ReviewService;
import com.ffin.service.truck.TruckService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileOutputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
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

    //getMenuList에서 truck 평균 별점을 위한 attribute
    @Autowired
    @Qualifier("reviewServiceImpl")
    private ReviewService reviewService;

    @Value("100") //pageUnit은 propertySource를 위에 선언하고 @value의 값을 지정해줌
    //추후 pageUnit과 pageSize 출력되는지 jUnit에서 확인이 필요합니다.
    //@Value("#{commonProperties['pageUnit'] ?: 3}")
    int pageUnit;

    @Value("100")
    int pageSize;





    //FILE UPLOAD를 위한 FIELD 설정
//    private static final String FILE_UPLOAD_PATH = "/resources/menu/";
    private static final String FILE_UPLOAD_PATH = "/resources/image/";
//    private static final String FILE_UPLOAD_PATH = "C:/CRUD/ffin/src/main/webapp/resources/image/";

    // 트럭 리스트 - 전체
    @RequestMapping(value = "getTruckList")
    public String getTruckList (@ModelAttribute("search") Search search, Model model, HttpServletRequest request) throws Exception {
//    public String getTruckList(@RequestParam(value="cateCondition", required = false) String cateCondition, @ModelAttribute("search") Search search, Model model, HttpServletRequest request) throws Exception {

        System.out.println("/truck/getTruckList : GET / POST");

        if (search.getCurrentPage() == 0) {
            search.setCurrentPage(1);
        }


//        String searchKeyword = search.getSearchKeyword();
//        System.out.println("////searchKeyword : " +searchKeyword);
//        if(searchKeyword != null) {
//            search.setSearchKeyword(new String(searchKeyword.getBytes("8859_1"), "euc-kr"));
//        }
        System.out.println("////searchKeyword : " + search.getSearchKeyword());

        search.setPageSize(pageSize);


        // Business logic 수행
        Map<String, Object> map = truckService.getTruckList(search);

        Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
        System.out.println(resultPage);

        // Model 과 View 연결
        model.addAttribute("list", map.get("list"));
//        model.addAttribute("list2", list2);
        model.addAttribute("resultPage", resultPage);
        model.addAttribute("search", search);

        return "forward:/views/menu/getTruckMenuList.jsp";
    }

    // TODO: 2022-01-13 다시 와서 위치기반 잡자
    // 트럭 리스트 - 전체 위치기반
    @RequestMapping(value = "getTruckListLo")
    public String getTruckListLo (@RequestParam(value="la", required = false) String la, @RequestParam(value="lo", required = false) String lo, @ModelAttribute("search") Search search, Model model) throws Exception {
//    public String getTruckList(@RequestParam(value="cateCondition", required = false) String cateCondition, @ModelAttribute("search") Search search, Model model, HttpServletRequest request) throws Exception {

        System.out.println("/truck/getTruckListLo : GET / POST");

        if (search.getCurrentPage() == 0) {
            search.setCurrentPage(1);
        }

        float laa = Float.parseFloat(la);
        float loo = Float.parseFloat(lo);

        System.out.println("////searchKeyword : " + search.getSearchKeyword());

        search.setPageSize(pageSize);


        // Business logic 수행
        Map<String, Object> map = truckService.truckNearBy(search, laa, loo);

        Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
        System.out.println(resultPage);

        // Model 과 View 연결
        model.addAttribute("list", map.get("list"));
//        model.addAttribute("list2", list2);
        model.addAttribute("resultPage", resultPage);
        model.addAttribute("search", search);

        return "forward:/views/menu/getTruckMenuList.jsp";
    }



//    // 트럭 리스트 - 전체
//    @RequestMapping(value = "getTruckList")
//    public String getTruckList(@ModelAttribute("search") Search search, Model model, HttpServletRequest request) throws Exception {
////    public String getTruckList(@RequestParam(value="cateCondition", required = false) String cateCondition, @ModelAttribute("search") Search search, Model model, HttpServletRequest request) throws Exception {
//
//        System.out.println("/truck/getTruckList : GET / POST");
//
//        if (search.getCurrentPage() == 0) {
//            search.setCurrentPage(1);
//        }
//
//
////        String searchKeyword = search.getSearchKeyword();
////        System.out.println("////searchKeyword : " +searchKeyword);
////        if(searchKeyword != null) {
////            search.setSearchKeyword(new String(searchKeyword.getBytes("8859_1"), "euc-kr"));
////        }
//        System.out.println("////searchKeyword : " + search.getSearchKeyword());
//
//        search.setPageSize(pageSize);
//
//
//        // Business logic 수행
//        Map<String, Object> map = truckService.getTruckList(search);
//
//        Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
//        System.out.println(resultPage);
//
//        // Model 과 View 연결
//        model.addAttribute("list", map.get("list"));
////        model.addAttribute("list2", list2);
//        model.addAttribute("resultPage", resultPage);
//        model.addAttribute("search", search);
//
//        return "forward:/views/menu/getTruckMenuList.jsp";
//    }

    // TODO: 2022-01-08 !!! 별점순, 거리순, 구매순 나열하기 
    // TODO: 2022-01-15 대표메뉴 로직!!!!!!!!개중요!!!!!!!!!!!!!!잊지말기!!!!!!!!!add할 때 트럭도 건드리도록 !!!!!!!!!반드시!!!!!!!!!!기억!!!!!!!

    // 트럭 리스트 - 카테고리에 따른
    @RequestMapping(value = "getTruckListCate")
//    public String getTruckList(@ModelAttribute("search") Search search, Model model, HttpServletRequest request) throws Exception {
    public String getTruckListCate(@RequestParam(value="sortCondition", required = false) String sortCondition, @RequestParam(value="cateCondition", required = false) String cateCondition, @ModelAttribute("search") Search search, Model model, HttpServletRequest request) throws Exception {

        System.out.println("/truck/getTruckList : GET / POST");
//        if(sortCondition != null) sortCondition = new String(sortCondition.getBytes("EUC-KR"), "utf-8");
        System.out.println("sortCondition = " + sortCondition + ", cateCondition = " + cateCondition + ", search = " + search + ", model = " + model + ", request = " + request);

        if (search.getCurrentPage() == 0) {
            search.setCurrentPage(1);
        }

        //category 나누기
//        String[] cate = null;
//        String cateCondition = search.getCateCondition();
//        if(cateCondition !=null && !cateCondition.equals("")){
//            cate=cateCondition.split(",");
//
//            if(cate[0].equals("0")){
//
//            }
//        }
//        String cate=Integer.toString(cateCondition);
        if (cateCondition!=null && !cateCondition.equals("")){

            search.setCateCondition(cateCondition);
        }
        if (sortCondition!=null && !sortCondition.equals("")){

            search.setSortCondition(sortCondition);
        }
        System.out.println("search ; " + search);

//        String searchKeyword = search.getSearchKeyword();
//        System.out.println(searchKeyword);
//        if(searchKeyword != null) {
//            search.setSearchKeyword(new String(searchKeyword.getBytes("8859_1"), "euc-kr"));
//        }
        System.out.println("searchKeyword : " +search.getSearchKeyword());

        search.setPageSize(pageSize);


        // Business logic 수행
        Map<String, Object> map = truckService.getTruckList(search);

        Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
        System.out.println(resultPage);

        // Model 과 View 연결
        model.addAttribute("list", map.get("list"));
//        model.addAttribute("list2", list2);
        model.addAttribute("resultPage", resultPage);
        model.addAttribute("search", search);
        model.addAttribute("cateCondition", cateCondition);
        model.addAttribute("sortCondition",sortCondition);

        return "forward:/views/menu/getTruckMenuList.jsp";
    }



    @RequestMapping(value = "addMenu", method= RequestMethod.GET)
    public ModelAndView addMenu(@RequestParam("truckId") String truckId,HttpServletRequest request) throws Exception{

        /*
            사업자가 메뉴를 등록하기 위해 사용하는 화면
            truckId로 truck의 상호를 화면에 뿌려주고, 추가할 메뉴 정보를 받는다.
         */
        System.out.println("/menu/addMenu : GET");
        System.out.println("truckId : " + truckId);

        Truck truck = truckService.getTruck(truckId);
        System.out.println("truck : " + truck);

        ////
        String root_path = request.getSession().getServletContext().getRealPath("/");
//        String attach_path = "menu/";



//        String realPath = request.getSession().getServletContext().getRealPath(FILE_UPLOAD_PATH);
        System.out.println("//////////////////////////////////////attach_path : " + root_path);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("truck", truck); //화면단에서 truck.truckId를 menuTruckId에 넣기
        modelAndView.setViewName("/views/menu/addMenuView.jsp");

        return modelAndView;
    }

    @Transactional(rollbackFor = Exception.class) //menu만 들어가고 optionGroup은 들어가지 않는 상황 방지
    @RequestMapping(value="addMenuOptionGroup", method=RequestMethod.POST)
//    public String addMenuOptionGroup(HttpServletRequest request,@ModelAttribute("optionGroup")OptionGroup optionGroup, @ModelAttribute("menu") Menu menu, Model model) throws Exception{
//    public String addMenuOptionGroup(HttpServletRequest request,MultipartHttpServletRequest mtfRequest, @ModelAttribute("optionGroup")OptionGroup optionGroup, @ModelAttribute("menu") Menu menu, Model model) throws Exception{
    public String addMenuOptionGroup
            (@RequestParam("menuImg11")MultipartFile file1,
             @RequestParam("menuImg22")MultipartFile file2,
             @RequestParam("menuImg33")MultipartFile file3,
             HttpServletRequest request,
             @ModelAttribute("optionGroup")OptionGroup optionGroup,
             @ModelAttribute("menu") Menu menu,
             Model model) throws Exception{
//    public String addMenuOptionGroup(@RequestParam("menuImg1")MultipartFile file1,@RequestParam(value="menuImg2", required = false)MultipartFile file2,@RequestParam(value="menuImg3", required = false)MultipartFile file3,HttpServletRequest request,@ModelAttribute("optionGroup")OptionGroup optionGroup, @ModelAttribute("menu") Menu menu, Model model) throws Exception{
   // public String addMenuOptionGroup(@ModelAttribute("optionGroup")OptionGroup optionGroup, Model model) throws Exception{
//    public String addMenuOptionGroup(HttpServletRequest request, Model model) throws Exception{

        System.out.println("/menu/addMenuOptionGroup:POST");

        System.out.println("optionGroup = " + optionGroup + ", menu = " + menu + ", model = " + model);

        String realPath = request.getSession().getServletContext().getRealPath("/resources/menu");
//        String realPath = "/resources/menu";

        String menuImg1  = file1.getOriginalFilename();

        String menuImg2  = file2.getOriginalFilename();
        String menuImg3  = file3.getOriginalFilename();

//        String root_path = request.getSession().getServletContext().getRealPath("/");
        System.out.println("/////////realPath : " + realPath);

        if(!file1.getOriginalFilename().isEmpty()){
            file1.transferTo(new File(realPath, menuImg1));
//            model.addAttribute("msg", "File uploaded successfully.");
//            model.addAttribute("menuImg1", menuImg1);
        }

        menu.setMenuImg1(file1.getOriginalFilename());


        if(!file2.getOriginalFilename().isEmpty()){
            file2.transferTo(new File(realPath, menuImg2));
//            model.addAttribute("msg", "File uploaded successfully.");
//            model.addAttribute("menuImg2", menuImg2);
//        }else {
//            model.addAttribute("msg", "Please select a valid mediaFile..");
        }
        menu.setMenuImg2(file2.getOriginalFilename());
//
        if(!file3.getOriginalFilename().isEmpty()){
            file3.transferTo(new File(realPath, menuImg3));
//            model.addAttribute("msg", "File uploaded successfully.");
//            model.addAttribute("menuImg3", menuImg3);
//        }else {
//            model.addAttribute("msg", "Please select a valid mediaFile..");
        }
        menu.setMenuImg3(file3.getOriginalFilename());


//        //경로 생성
//        if (! new File(FILE_UPLOAD_PATH).exists()){
//            new File(FILE_UPLOAD_PATH).mkdirs();
//        }
//        //파일 복사
//        try{
//            FileCopyUtils.copy(file.getBytes(), target);
//            model.addAttribute("file", file);
//        }catch(Exception e){
//            e.printStackTrace();
//            model.addAttribute("file", "error");
//        }


        int menuNo = menuService.addMenu(menu);

        System.out.println("menuNo : " + menuNo);


            optionGroup.setMenuNo(menuNo);

//        optionGroup.setMenuNo(menuNo);
            Menu menu1 = new Menu();

            System.out.println("/////////////////");


            System.out.println("optionGroupName : " + optionGroup.getOptionGroupName());
            System.out.println("optionName : " + optionGroup.getOptionName());
//        System.out.println("optionPrice : " + optionGroup.getOptionPrice());
            System.out.println("optionPrice : " + request.getParameterValues("optionPrice")[0]);


            String[] optionGroupName = optionGroup.getOptionGroupName().split(",");
            String [] optionName = optionGroup.getOptionName().split(",");
            String [] optionPrice = optionGroup.getOptionPrice().split(",");

            System.out.println("optionGroupName length: " + optionGroupName.length);
            System.out.println("optionName length: " + optionName.length);
            System.out.println("optionPrice length: " + optionPrice.length);

            List<OptionGroup> optionGroupList = new ArrayList<OptionGroup>();

            int optGroupNo = menuService.getLatestOptionGroupNo().getOptionGroupNo()+1;
            System.out.println("optGroupNo : " + optGroupNo);
            for(int i = 0; i<optionName.length; i++){



                OptionGroup optionGroup1 = new OptionGroup();

                optionGroup1.setMenuNo(menuNo);
                optionGroup1.setOptionPrice(optionPrice[i]);
                optionGroup1.setOptionName(optionName[i]);
                optionGroup1.setOptionGroupName(optionGroupName[i]);
//            if(optionGroupName[i]==null){
//                for(int j=i; j>0; j--){
//                    if(optionGroupName[j]!=null){
//                        optionGroup1.setOptionGroupName(optionGroupName[j]);
//                    }
//                    if(optionGroup1.getOptionGroupName()!=null){
//                        break;
//                    }
//                }
//
//            }else{
//                optionGroup1.setOptionGroupName(optionGroupName[i]);
//            }

                if(i==0){
                    optionGroup1.setOptionGroupNo(optGroupNo);
                }else{
                    if(optionGroupName[i].equals(optionGroupName[i-1])){
                        optionGroup1.setOptionGroupNo(optGroupNo);
                    }else{
                        optGroupNo++;
                        optionGroup1.setOptionGroupNo(optGroupNo);
                    }
                }
                System.out.println("optionGroup1 : " + optionGroup1);
                System.out.println("///// optGroupNo : " + optGroupNo);
                System.out.println("request = " + request + ", optionGroup = " + optionGroup + ", menu = " + menu + ", model = " + model);

                optionGroupList.add(optionGroup1);

            }

            menuService.addOptionGroup(optionGroupList);
            System.out.println("menuNo : " + menuNo);

//        menu = menuService.getMenu(menuNo);
            // Menu menu1 = menuService.getMenu(menuNo);
//        menuService.addOptionGroup(list);
//            model.addAttribute("menu", menu1);
            model.addAttribute("optionGroup-list", optionGroupList);



        model.addAttribute("menu", menu);
        model.addAttribute("menuNo", menuNo);
        model.addAttribute("truckId", menu.getMenuTruckId());

        System.out.println("model 확인 : " + model);

        return "redirect:/views/menu/getMenuListM.jsp";

    }

    @RequestMapping(value="addMenu", method=RequestMethod.POST)
//    public String addMenu(@RequestParam(value="menuImg11", required = false) MultipartFile file1,HttpServletRequest request,@ModelAttribute("menu") Menu menu, Model model) throws Exception{
    public String addMenu(@RequestParam("menuImg11")MultipartFile file1,
                          @RequestParam(value="menuImg22", required = false)MultipartFile file2,
                          @RequestParam(value="menuImg33", required = false)MultipartFile file3,
                          HttpServletRequest request,
                          @ModelAttribute("menu") Menu menu,
                          Model model
    ) throws Exception{
        // TODO: 2022-01-11 오늘 안에 파일 업로드 & optionGroup도 같이  add 넘기는 애 까먹지 말기!!!

        System.out.println("/menu/addMenu:POST");

        System.out.println("request = " + request + ", menu = " + menu + ", model = " + model);

//        MultipartFile file1 = (MultipartFile) request.getAttribute("menuImg1");
//        String realPath = application.getRealPath("/src/main/resources/menu");

        String realPath = request.getSession().getServletContext().getRealPath("/resources/menu");
//        String realPath = "/resources/menu";

        String menuImg1  = file1.getOriginalFilename();

        String menuImg2  = file2.getOriginalFilename();
        String menuImg3  = file3.getOriginalFilename();

//        String root_path = request.getSession().getServletContext().getRealPath("/");
        System.out.println("/////////realPath : " + realPath);

        if(!file1.getOriginalFilename().isEmpty()){
            file1.transferTo(new File(realPath, menuImg1));
//            model.addAttribute("msg", "File uploaded successfully.");
//            model.addAttribute("menuImg1", menuImg1);
        }

        menu.setMenuImg1(file1.getOriginalFilename());


        if(!file2.getOriginalFilename().isEmpty()){
            file2.transferTo(new File(realPath, menuImg2));
//            model.addAttribute("msg", "File uploaded successfully.");
//            model.addAttribute("menuImg2", menuImg2);
//        }else {
//            model.addAttribute("msg", "Please select a valid mediaFile..");
        }
        menu.setMenuImg2(file2.getOriginalFilename());
//
        if(!file3.getOriginalFilename().isEmpty()){
            file3.transferTo(new File(realPath, menuImg3));
//            model.addAttribute("msg", "File uploaded successfully.");
//            model.addAttribute("menuImg3", menuImg3);
//        }else {
//            model.addAttribute("msg", "Please select a valid mediaFile..");
        }
        menu.setMenuImg3(file3.getOriginalFilename());

        int menuNo = menuService.addMenu(menu);

        System.out.println("menuNo : " + menuNo);


        model.addAttribute("menu", menu);
        model.addAttribute("truckId", menu.getMenuTruckId());

        System.out.println("model 확인 : " + model);


        return "redirect:/views/menu/getMenuListM.jsp";

    }



    @RequestMapping(value="getMenu", method=RequestMethod.GET)
    public String getMenu(@ModelAttribute("search") Search search,
                          @RequestParam(value="menuNo", required = false) int menuNo,
                          Model model,
                          HttpServletRequest request,
                          HttpServletResponse response) throws Exception{

        System.out.println("/menu/getMenu : GET");

        System.out.println("search = " + search + ", menuNo = " + menuNo + ", model = " + model + ", request = " + request + ", response = " + response);


        search.setPageSize(pageSize);

        Menu menu = menuService.getMenu(menuNo);

        Map optionGroup = menuService.getOptionGroupByMenu(search,menuNo);

        System.out.println("menu : " + menu);

        model.addAttribute("menu", menu);
        model.addAttribute("menuNo", menuNo);
        model.addAttribute("list", optionGroup.get("list"));

        System.out.println("list="+ optionGroup.get("list")+", search = " + search + ", menuNo = " + menuNo + ", model = " + model + ", request = " + request + ", response = " + response);

        return "forward:/views/menu/getMenu.jsp";
    }

//    @RequestMapping(value="getMenu", method=RequestMethod.POST)
//    public String getMenu(@ModelAttribute("menuNo") int menuNo, Model model, HttpSession session) throws Exception{
//        System.out.println("/menu/getMenu : POST");
//
//        //BL
//        Menu menu = menuService.getMenu(menuNo);
//
//        session.setAttribute("menu", menu);
//
//        return "redirect:/views/menu/getMenu?menuNo="+menu.getMenuNo();
//
//    }

    @RequestMapping(value="updateMenu", method=RequestMethod.GET)
    public String updateMenu(@ModelAttribute("search") Search search, @RequestParam(value="menuNo", required = false) int menuNo, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception{

        System.out.println("/menu/updateMenu : GET");

        //Business Logic

        search.setPageSize(pageSize);

        Menu menu = menuService.getMenu(menuNo);

        Map optionGroup = menuService.getOptionGroupByMenu(search, menuNo);

        System.out.println("menu : " + menu);

        model.addAttribute("menu", menu);
        model.addAttribute("menuNo", menuNo);
        model.addAttribute("list", optionGroup.get("list"));
        // for문을 돌리기 위한 list하나 더! 제발 돌아라
//        model.addAttribute("list2", optionGroup.get("list"));
//
//        String menuNoo = request.getParameter("menuNo");
//
//        int menuNo = Integer.parseInt(menuNoo);
//
//        Menu menu = menuService.getMenu(menuNo);
//
//        //Model - View 연결
//        modelAndView.addObject("menu", menu);
//        modelAndView.addObject("menuNo", menuNo);
//        modelAndView.setViewName("/views/menu/updateMenuView.jsp");
//
//        System.out.println("request = " + request + ", modelAndView = " + modelAndView);
//
//        return modelAndView;
        System.out.println("search = " + search + ", menuNo = " + menuNo + ", model = " + model + ", request = " + request + ", response = " + response);

        return "forward:/views/menu/updateMenuView.jsp";
    }

    //@Transactional(rollbackFor = Exception.class)//menu만 update 방지
    @RequestMapping(value="updateMenuOptionGroup", method=RequestMethod.POST)
    public String updateMenuOptionGroup(
            @RequestParam("menuImg11")MultipartFile file1,
            @RequestParam(value="menuImg22", required = false)MultipartFile file2,
            @RequestParam(value="menuImg33", required = false)MultipartFile file3,
            HttpServletRequest request,@ModelAttribute("optionGroup")OptionGroup optionGroup, @ModelAttribute("menu") Menu menu, Model model) throws Exception{
        System.out.println("/menu/updateMenuOptionGroup : POST");

        System.out.println("request = " + request + ", optionGroup = " + optionGroup + ", menu = " + menu + ", model = " + model);

        String realPath = request.getSession().getServletContext().getRealPath("/resources/menu");

        String menuImg1  = file1.getOriginalFilename();

        String menuImg2  = file2.getOriginalFilename();
        String menuImg3  = file3.getOriginalFilename();

        System.out.println("/////////realPath : " + realPath);

        if(!file1.getOriginalFilename().isEmpty()){
            file1.transferTo(new File(realPath, menuImg1));
//            model.addAttribute("msg", "File uploaded successfully.");
//            model.addAttribute("menuImg1", menuImg1);
        }

        menu.setMenuImg1(file1.getOriginalFilename());


        if(!file2.getOriginalFilename().isEmpty()){
            file2.transferTo(new File(realPath, menuImg2));
//            model.addAttribute("msg", "File uploaded successfully.");
//            model.addAttribute("menuImg2", menuImg2);
//        }else {
//            model.addAttribute("msg", "Please select a valid mediaFile..");
        }
        menu.setMenuImg2(file2.getOriginalFilename());
//
        if(!file3.getOriginalFilename().isEmpty()){
            file3.transferTo(new File(realPath, menuImg3));
//            model.addAttribute("msg", "File uploaded successfully.");
//            model.addAttribute("menuImg3", menuImg3);
//        }else {
//            model.addAttribute("msg", "Please select a valid mediaFile..");
        }
        menu.setMenuImg3(file3.getOriginalFilename());


        menuService.updateMenu(menu);

        Menu menu1 = new Menu();

        System.out.println("/////////////////");

        System.out.println("optionGroupName : " + optionGroup.getOptionGroupName());
        System.out.println("optionName : " + optionGroup.getOptionName());
//        System.out.println("optionPrice : " + optionGroup.getOptionPrice());
        System.out.println("optionPrice : " + request.getParameterValues("optionPrice")[0]);
        System.out.println("///////////////////optionNo : " + optionGroup.getOptionNo());

        String[] optionGroupName = optionGroup.getOptionGroupName().split(",");
        String [] optionName = optionGroup.getOptionName().split(",");
        String [] optionPrice = optionGroup.getOptionPrice().split(",");
        String [] optionNo = optionGroup.getOptionNo().split(",");

        System.out.println("optionGroupName length: " + optionGroupName.length);
        System.out.println("optionName length: " + optionName.length);
        System.out.println("optionPrice length: " + optionPrice.length);
        System.out.println("optionNo length : " + optionNo.length);

        List<OptionGroup> optionGroupList = new ArrayList<OptionGroup>();


        /////
        for(int i = 0; i<optionName.length; i++){
            OptionGroup optionGroup1 = menuService.getOption(Integer.parseInt(optionNo[i]));

            optionGroup1.setOptionGroupName(optionGroupName[i]);
            optionGroup1.setOptionName(optionName[i]);
            optionGroup1.setOptionPrice(optionPrice[i]);

            optionGroupList.add(optionGroup1);

            menuService.updateOptionGroup(optionGroup1);

        }


        model.addAttribute("menu", menu1);
        model.addAttribute("optionGroupList", optionGroupList);
//        model.addAttribute("menuNo", menuNo);

        System.out.println("model 확인 : " + model);



        return "redirect:/menu/getMenu?menuNo="+menu.getMenuNo();

    }

    //@Transactional(rollbackFor = Exception.class)//menu만 update 방지
    @RequestMapping(value="updateMenu", method=RequestMethod.POST)
    public String updateMenu(
            @RequestParam("menuImg11")MultipartFile file1,
            @RequestParam(value="menuImg22", required = false)MultipartFile file2,
            @RequestParam(value="menuImg33", required = false)MultipartFile file3,
            HttpServletRequest request, @ModelAttribute("menu") Menu menu, Model model) throws Exception{
        System.out.println("/menu/updateMenu : POST");

        System.out.println("request = " + request + ", menu = " + menu + ", model = " + model);

        String realPath = request.getSession().getServletContext().getRealPath("/resources/menu");

        String menuImg1  = file1.getOriginalFilename();

        String menuImg2  = file2.getOriginalFilename();
        String menuImg3  = file3.getOriginalFilename();

        System.out.println("/////////realPath : " + realPath);

        if(!file1.getOriginalFilename().isEmpty()){
            file1.transferTo(new File(realPath, menuImg1));
//            model.addAttribute("msg", "File uploaded successfully.");
//            model.addAttribute("menuImg1", menuImg1);
        }

        menu.setMenuImg1(file1.getOriginalFilename());


        if(!file2.getOriginalFilename().isEmpty()){
            file2.transferTo(new File(realPath, menuImg2));
//            model.addAttribute("msg", "File uploaded successfully.");
//            model.addAttribute("menuImg2", menuImg2);
//        }else {
//            model.addAttribute("msg", "Please select a valid mediaFile..");
        }
        menu.setMenuImg2(file2.getOriginalFilename());
//
        if(!file3.getOriginalFilename().isEmpty()){
            file3.transferTo(new File(realPath, menuImg3));
//            model.addAttribute("msg", "File uploaded successfully.");
//            model.addAttribute("menuImg3", menuImg3);
//        }else {
//            model.addAttribute("msg", "Please select a valid mediaFile..");
        }
        menu.setMenuImg3(file3.getOriginalFilename());

        menuService.updateMenu(menu);

//        optionGroup.setMenuNo(menuNo);Gksmfchlrh0331)


        model.addAttribute("menu", menu);
//        model.addAttribute("menuNo", menuNo);

        System.out.println("model 확인 : " + model);



        return "redirect:/menu/getMenu?menuNo="+menu.getMenuNo();

    }

    // TODO: 2022-01-08 !!! session에 선택한 정보 담기도록 변경하기!!! -해결!

    @RequestMapping("getMenuList")
    public ModelAndView getMenuList(@ModelAttribute("search") Search search,
                                    @RequestParam("truckId") String truckId,
                                  HttpServletResponse response,
                                    ModelAndView modelAndView,HttpSession session) throws Exception{

//        File file = new File(FILE_UPLOAD_PATH, fileName);
//        byte[] bytes = FileCopyUtils.copyToByteArray(file);
//        String fn = new String(file.getName().getBytes(), "utf-8");
//        response.setHeader("Content-Disposition", "attachment;filename=\""+fn+"\"");
//        response.setContentLength(bytes.length);

        search.setPageSize(pageSize);

        Truck truck;
        if(session.getAttribute("user")!=null){
            String userId = ((User)(session.getAttribute("user"))).getUserId();
            truck  = truckService.getTruck2(userId, truckId);
        }
        else{
            truck = truckService.getTruck(truckId);
        }
        float rvAvg = reviewService.getReviewAvg(search,truckId);
        int rvTotal = reviewService.getReviewTotalCount(search,truckId);
        truck.setTruckAVGStar(rvAvg);

        Map<String , Object> map= menuService.getMenuList(search, truck.getTruckId());

        modelAndView.addObject("list", map.get("list"));
        modelAndView.addObject("path", FILE_UPLOAD_PATH);
        modelAndView.addObject("truck", truck);
        if (rvTotal!=0){

            modelAndView.addObject("rvTotal", rvTotal);
        }

        modelAndView.setViewName("/views/menu/getTruck.jsp");

        return modelAndView;
    }

    //getMenuList는 list인데 truck mypage에서 관리하는 용도!
    @RequestMapping("getMenuListM")
    public ModelAndView getMenuListM(@ModelAttribute("search") Search search,
                                    @RequestParam("truckId") String truckId,
                                  HttpServletResponse response,
                                    ModelAndView modelAndView) throws Exception{


        search.setPageSize(pageSize);
        Truck truck  = truckService.getTruck(truckId);
        float rvAvg = reviewService.getReviewAvg(search,truckId);
        int rvTotal = reviewService.getReviewTotalCount(search,truckId);
        truck.setTruckAVGStar(rvAvg);

        Map<String , Object> map= menuService.getMenuList(search, truck.getTruckId());

        modelAndView.addObject("list", map.get("list"));
        modelAndView.addObject("path", FILE_UPLOAD_PATH);
        modelAndView.addObject("truck", truck);
        if (rvTotal!=0){

            modelAndView.addObject("rvTotal", rvTotal);
        }

        modelAndView.setViewName("/views/menu/getMenuListM.jsp");

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
        modelAndView.setViewName("/views/menu/updateMenuView.jsp"); // 진석님과 메뉴 수정 어디서 할 지 상의해보고

        System.out.println("request = " + request + ", modelAndView = " + modelAndView);

        return modelAndView;
    }



}
