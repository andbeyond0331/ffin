package com.ffin.web.user;

import com.ffin.service.domain.User;
import com.ffin.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

    @RequestMapping(value="snsLogin/{userId}", method=RequestMethod.POST)
    public String snsLogin( @PathVariable String userId, HttpSession session ) throws Exception{
        System.out.println("/user/snsLogin : POST");

        User dbUser = userService.getUser(userId);
        session.setAttribute("user", dbUser);

        return "redirect:/index.jsp";
    }

    @RequestMapping(value = "json/addUser", method = RequestMethod.POST)
    public User addUser( @RequestBody User user, HttpSession session) throws Exception {
        System.out.println("UserRestController.addUser");

        userService.addUserInfo(user);
        return userService.getUser(user.getUserId());
    }


}
