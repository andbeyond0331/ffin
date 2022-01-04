//package com.ffin.web.menu;
//
//import com.ffin.service.menu.MenuService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.factory.annotation.Qualifier;
//import org.springframework.web.bind.annotation.*;
//import org.springframework.web.multipart.MultipartFile;
//import org.springframework.web.servlet.ModelAndView;
//
//@RestController
//@RequestMapping("/menu/*")
//public class MenuRestController {
//
//    ///FFF
//    @Autowired
//    @Qualifier("menuServiceImpl")
//    private MenuService menuService;
//
//    public MenuRestController(){
//        System.out.println(this.getClass());
//    }
//
//    @PostMapping(value="json/imageUpload")
//    @ResponseBody
//    public String imageUpload(@ModelAttribute MultipartFile file){
//        return menuService.imageUpload(file.getMultipartFile());
//    }
//
//
//}
