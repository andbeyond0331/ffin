package com.ffin.web.user;

import com.ffin.service.domain.User;
import com.ffin.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user/*")
public class UserController {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;


    @RequestMapping(value = "login", method = RequestMethod.GET)
    public String login() throws Exception{
        System.out.println("UserController.login : GET");
        return "redirect:/user/login.jsp";
    }

    @RequestMapping(value = "login", method = RequestMethod.POST)
    public String login(@ModelAttribute("user")User user, HttpSession session) throws Exception{
        System.out.println("UserController.login : POST");
        User dbUser = userService.getUser(user.getUserId());
        if(user.getUserPassword().equals(dbUser.getUserPassword())){
            session.setAttribute("user",dbUser);
            session.setAttribute("role","user");
        }
        return "redirect:/index.jsp";
    }



//    @RequestMapping(value = "getUser", method = RequestMethod.GET)
//    public ModelAndView getUser(HttpServletRequest request,ModelAndView m) throws Exception{
//        System.out.println("UserController.getUser : GET");
//        String userId= request.getParameter("userId");
//
//        System.out.println("userId: "+userId);
//        User user = userService.getUser(userId);
//        System.out.println("user: "+user);
//        m.addObject("user",user);
//        m.setViewName("/WEB-INF/views/user/getUser.jsp");
//        return m;
//    }

    @RequestMapping( value="getUser", method=RequestMethod.GET )
    public String getUser( @RequestParam("userId") String userId , Model model ) throws Exception {

        System.out.println("/user/getUser : GET");
        //Business Logic
        User user = userService.getUser(userId);
        // Model 과 View 연결
        model.addAttribute("user", user);

        return "forward:/user/getUser.jsp";
    }



}
