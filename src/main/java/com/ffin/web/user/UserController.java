package com.ffin.web.user;

import com.ffin.service.domain.User;
import com.ffin.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;

@Controller
@RequestMapping("/user/*")
public class UserController {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    private ModelAndView modelAndView;

    @Autowired
    private JavaMailSender mailSender;

    public UserController(){
        System.out.println(this.getClass());
    }

    @RequestMapping(value = "login", method = RequestMethod.GET)
    public String login2() throws Exception{
        System.out.println("UserController.login : GET");
        return "views/user/login.jsp";
    }

    @RequestMapping( value="login", method=RequestMethod.POST )
    public String login(@ModelAttribute("user") User user , HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{

        System.out.println("/user/login : POST");
        //Business Logic
        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>");
        User dbUser=userService.getUser(user.getUserId());
//        ModelMap modelMap = modelAndView.getModelMap();
//        Object userCoo = modelMap.get("user");

        if( user.getUserPassword().equals(dbUser.getUserPassword())){

            session.setAttribute("user", dbUser);
            session.setAttribute("role","user");

            if(request.getParameter("userCookie") == null) {
                System.out.println("자동로그인");

                Cookie loginCookie = new Cookie("loginCookie", session.getId());

                loginCookie.setPath("/");
                int amount = 60*60*24*7;
                loginCookie.setMaxAge(amount);

                System.out.println("쿠키줘!!!"+session.getId());

                response.addCookie(loginCookie);

                Date sessionLimit = new Date(System.currentTimeMillis()+(1000*amount));
                userService.autoLogin(user.getUserId(), session.getId(), sessionLimit);
            }

//            if(user.isUseCookie())

            return "redirect:/views/home.jsp";

        } else {
            System.out.println("로그인Nope");
            return "views/user/login.jsp";
        }
    }

    //Rest gogo!
    @RequestMapping(value = "logout", method = RequestMethod.GET)
    public String logout(HttpSession session, HttpServletResponse response, HttpServletRequest request) throws Exception {
        System.out.println("UserController.logout : GET");

        User user = (User) session.getAttribute("user");
        if(user != null) {

            session.removeAttribute("user");
            session.invalidate();

            Cookie loginCookie = WebUtils.getCookie(request, "loginCookie"  );
            if(loginCookie != null){
                loginCookie.setPath("/");
                loginCookie.setMaxAge(0);
                response.addCookie(loginCookie);

                Date date = new Date(System.currentTimeMillis());
                userService.autoLogin(user.getUserId(), session.getId(), date);
            }
        }
        return "redirect:/views/home.jsp";
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

    @RequestMapping( value="getUser", method=RequestMethod.GET )
    public String getUser(@RequestParam("userId") String userId , Model model ) throws Exception {

        System.out.println("/user/getUser : GET");
        User user = userService.getUser(userId);
        model.addAttribute("user", user);

        return "views/user/getUser.jsp";
    }





}
