package com.ffin.web.user;

import com.ffin.service.domain.User;
import com.ffin.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/user/*")
public class UserController {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    @RequestMapping(value = "getUser", method = RequestMethod.GET)
    public ModelAndView getUser(HttpServletRequest request,ModelAndView m) throws Exception{
        System.out.println("UserController.getUser : GET");
        String userId= request.getParameter("userId");

        System.out.println("userId: "+userId);
        User user = userService.getUser(userId);
        System.out.println("user: "+user);
        m.addObject("user",user);
        m.setViewName("/WEB-INF/views/user/getUser.jsp");
        return m;
    }
}
