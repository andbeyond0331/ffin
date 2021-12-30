package com.ffin.web.user;

import com.ffin.service.domain.User;
import com.ffin.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;

@RestController
@RequestMapping("/user/*")
public class UserRestController {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;


    public UserRestController(){
        System.out.println(this.getClass());
    }
    
    //Method
    @RequestMapping(value = "json/checkDuplication/{userId:.+}", method = RequestMethod.GET)
    public String idChkDuplication(@PathVariable String userId, Model model) throws Exception{

        System.out.println("/user/checkDuplication : POST");
        //Business Logic
        boolean result=userService.idChkDuplication(userId);
        // Model 과 View 연결
        /*model.addAttribute("result", new Boolean(result));
        model.addAttribute("userId", userId);*/
        System.out.println("gogo!!");
        return userId;
    }

    @RequestMapping(value = "json/idChkDuplication", method = RequestMethod.POST)
    public Boolean idChkDuplication(@RequestParam String userId) throws Exception {

        System.out.println("UserRestController.idChkDuplication : POST ");

        return userService.idChkDuplication(userId);
    }

    @RequestMapping(value="snsLogin/{userId}", method=RequestMethod.POST)
    public String snsLogin( @PathVariable String userId, HttpSession session ) throws Exception{
        System.out.println("/user/snsLogin : POST");

        User dbUser = userService.getUser(userId);
        session.setAttribute("user", dbUser);

        return "redirect:/index.jsp";
    }


    @RequestMapping(value = "json/login/{userId}", method = RequestMethod.POST)
    public String login(@ModelAttribute("user") User user, @PathVariable String userId, HttpSession session,
                        HttpServletRequest request, HttpServletResponse response) throws Exception {

        System.out.println("/user/jon/login : POST");
        //Business Logic
        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>");
        User dbUser = userService.getUser(user.getUserId());

        if (user.getUserPassword().equals(dbUser.getUserPassword())) {

            session.setAttribute("user", dbUser);
            session.setAttribute("role", "user");

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
            System.out.println("로그인 OK");
        } else {
            System.out.println("로그인Nope");
        }
        return userId;
    }


    @RequestMapping(value = "json/addUser", method = RequestMethod.POST)
    public User addUser( @RequestBody User user, HttpSession session) throws Exception {
        System.out.println("UserRestController.addUser");

        userService.addUserInfo(user);
        return userService.getUser(user.getUserId());
    }

}
