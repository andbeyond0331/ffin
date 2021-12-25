package com.ffin.web.user;

import com.ffin.service.domain.User;
import com.ffin.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user/*")
public class UserController {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;
    ModelAndView modelAndView;

    public UserController(){
        System.out.println(this.getClass());
        modelAndView = new ModelAndView();
    }


//    @RequestMapping(value = "login", method = RequestMethod.GET)
//    public ModelAndView login(HttpServletRequest request) throws Exception{
//        System.out.println("UserController.login : GET");
//        modelAndView.setViewName("/user/login.jsp");
//        modelAndView.setViewName("/user/login");
//        return modelAndView;
//    }


    @RequestMapping(value = "login", method = RequestMethod.GET)
    public String login2() throws Exception{
        System.out.println("UserController.login : GET");
        return "views/user/login.jsp";
    }

    @RequestMapping( value="login", method=RequestMethod.POST )
    public String login(@ModelAttribute("user") User user , HttpSession session) throws Exception{

        System.out.println("/user/login : POST");
        //Business Logic
        User dbUser=userService.getUser(user.getUserId());

        System.out.println("@@@"+ user);
        System.out.println("???"+dbUser);

        if( user.getUserPassword().equals(dbUser.getUserPassword())){
            session.setAttribute("user", dbUser);
            session.setAttribute("role","user");
            System.out.println("로그인OK");
            return "/views/home.jsp";
        }
        System.out.println("로그인Nope");
        return "views/user/login.jsp";
    }

    @RequestMapping( value="addUser", method=RequestMethod.GET )
    public String addUser() throws Exception{

        System.out.println("/user/addUser : GET");

        return "redirect:views/user/addUser.jsp";
    }

    @RequestMapping( value="addUser", method=RequestMethod.POST )
    public String addUser( @ModelAttribute("user") User user ) throws Exception {

        System.out.println("/user/addUser : POST");
        //Business Logic
        userService.addUserInfo(user);

        return "redirect:views/user/login.jsp";
    }

//    @RequestMapping(value = "login", method = RequestMethod.POST)
//    public ModelAndView login(@ModelAttribute("user") User user, HttpSession session) throws Exception{
//
//        System.out.println("UserController.login : POST");
//
//        User dbUser = userService.getUser(user.getUserId());
//
//        System.out.println("***"+user);
//        System.out.println("!!!!"+user.getUserPassword());
//        System.out.println("????"+dbUser.getUserPassword());
//
//        if(user.getUserPassword().equals(dbUser.getUserPassword())){
//            session.setAttribute("user",dbUser);
//            session.setAttribute("role","user");
//            modelAndView.setViewName("redirect:/user/getUser");
//        } else {
//            modelAndView.setViewName("/user/login");
//        }
//        return modelAndView;
//    }


//    @RequestMapping(value = "getUser", method = RequestMethod.GET)
//    public ModelAndView getUser(HttpServletRequest request) throws Exception{
//
//        System.out.println("UserController.getUser : GET");
//        String userId= request.getParameter("userId");
//
//        User user = userService.getUser(userId);
//        modelAndView.addObject("user",user);
//        modelAndView.setViewName("/user/getUser.jsp");
//        return modelAndView;
//    }

    @RequestMapping( value="getUser", method=RequestMethod.GET )
    public String getUser(@RequestParam("userId") String userId , Model model ) throws Exception {

        System.out.println("/user/getUser : GET");
        //Business Logic
        User user = userService.getUser(userId);
        // Model 과 View 연결
        model.addAttribute("user", user);

        return "views/user/getUser.jsp";
    }





}
