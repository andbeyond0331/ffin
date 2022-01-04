package com.ffin.web.user;

import com.ffin.service.domain.User;
import com.ffin.service.user.UserService;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

@RestController
@RequestMapping("/user/*")
public class UserRestController {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    // 파일 저장경로 지정
    //private static final String FILE_SERVER_PATH = "C:\\ffinPJT\\src\\main\\webapp\\resources\\image";

    public UserRestController(){
        System.out.println(this.getClass());
    }
    
    //Method
    //phone 인증
    @RequestMapping(value = "json/sendSMS/{inputPhone}", method = RequestMethod.GET)
    @ResponseBody
    public String sendSMS(@PathVariable String inputPhone) {

        System.out.println("TruckRestController.sendSMS");// 휴대폰 문자보내기
        System.out.println("truckPhoneNumber = " + inputPhone);

        int randomNumber = (int) ((Math.random() * (9999 - 1000 + 1)) + 1000);//난수 생성
        System.out.println("randomNumber = " + randomNumber);
        userService.sendSMS(inputPhone, randomNumber);

        return Integer.toString(randomNumber);
    }


    //email 인증
    @RequestMapping(value = "json/checkDuplication/{userId:.+}", method = RequestMethod.GET)
    public Boolean idChkDuplication(@PathVariable String userId, Model model) throws Exception{

        System.out.println("/user/checkDuplication : GET");
        //Business Logic
        boolean result=userService.idChkDuplication(userId);
        // Model 과 View 연결
        /*model.addAttribute("result", new Boolean(result));
        model.addAttribute("userId", userId);*/

        System.out.println("gogo!!");
        System.out.println("!!!!!!!!!!"+userId);
        System.out.println("!!!!!!!!!!"+result);
        return result;
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

    @RequestMapping(value = "json/addUser", method = RequestMethod.GET)
    public String addUser() throws Exception{

        System.out.println("/user/addUser : GET");

        return "/views/user/addUserInfo.jsp";
    }


    @RequestMapping(value = "json/addUser", method = RequestMethod.POST)
    public User addUser( @RequestBody User user, HttpSession session) throws Exception {
        System.out.println("UserRestController.addUser");

        userService.addUserInfo(user);
        session.setAttribute("user", user);

        return userService.getUser(user.getUserId());
    }

    @RequestMapping(value = "json/updateUserInfo/{userId}", method = RequestMethod.POST)
    public User updateUserInfo(User user, @PathVariable String userId, HttpServletRequest request) throws Exception {
        System.out.println("UserRestController.updateUserInfo : POST");

        request.setCharacterEncoding("UTF-8");
        userService.updateUserInfo(user);

        return user;
    }

    @RequestMapping(value = "json/updateUserProfile/{userId}", method = RequestMethod.POST)
    public User updateUserProfile(User user, @PathVariable String userId, HttpServletRequest request) throws Exception {

        System.out.println("UserRestController.updateUserProfile : POST");
        request.setCharacterEncoding("UTF-8");

        userService.updateUserProfile(user);

        return user;
    }


/*    @RequestMapping(value = "json/updateProImg/{userId}", method = RequestMethod.POST)
    public String updateProImg(@PathVariable String userId, MultipartFile file, HttpSession session, RedirectAttributes redirectAttributes) throws Exception{

        if(file == null) {
            redirectAttributes.addFlashAttribute("msg","FAIL");
            return "redirect:/user/getUserProfile.jsp";
        }

        String uploadFile = UploadFileUtils.uploadFile(userProImgPath, file.getOriginalFilename(), file.getBytes());
        String front = uploadFile.substring(0,12);
        String end = uploadFile.substring(14);
        String userProImg = front + end;
        userService.updateProImg(userId, userProImg);

        Object userObj = session.getAttribute("user");
        User user = (User) userObj;
        user.setUserProImg(userProImg);
        session.setAttribute("user", user);
        redirectAttributes.addFlashAttribute("msg", "SUCCESS");
        return "redirect:/user/getUserProfile.jsp";
    }*/



}
