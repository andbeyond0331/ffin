package com.ffin.web.user;

import com.ffin.service.domain.User;
import com.ffin.service.user.UserService;
import com.sun.istack.internal.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.MediaType;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.Random;

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
    //phone 인증(회원가입)
    @RequestMapping(value = "json/sendSMS/{inputPhone}", method = RequestMethod.GET)
    @ResponseBody
    public String sendSMS(@PathVariable String inputPhone) {

        System.out.println("UserRestController.sendSMS");// 휴대폰 문자보내기
        System.out.println("userPhone = " + inputPhone);

        int randomNumber = (int) ((Math.random() * (9999 - 1000 + 1)) + 1000);//난수 생성
        System.out.println("randomNumber = " + randomNumber);
        userService.sendSMS(inputPhone, randomNumber);

        return Integer.toString(randomNumber);
    }


    //email 인증
    @RequestMapping(value = "json/checkDuplication/{userId:.+}", method = RequestMethod.GET)
    public String idChkDuplication(@PathVariable String userId, Model model) throws Exception{

        System.out.println("/user/checkDuplication : GET");
        //Business Logic
        boolean result=userService.idChkDuplication(userId);
        System.out.println("kakaoLogin 아이디 중복체크 :: "+result);

        if(!result){
            return "";
        }
        return userId;
    }

    @RequestMapping(value = "json/idChkDuplication", method = RequestMethod.POST)
    public Boolean idChkDuplication(@RequestParam String userId) throws Exception {

        System.out.println("UserRestController.idChkDuplication : POST ");

        return userService.idChkDuplication(userId);
    }

    @RequestMapping(value="kakaoLogin/{userId:.+}", method=RequestMethod.POST)
    public String kakaoLogin( @PathVariable String userId, HttpSession session ) throws Exception{

        System.out.println("/user/snsLogin : POST");

        User dbUser = userService.getUser(userId);
        session.setAttribute("user", dbUser);
        session.setAttribute("role","user");
        session.setAttribute("sns", "kakao");

        return "/views/home.jsp";
    }



    @RequestMapping(value = "json/login/{userId}", method = RequestMethod.POST)
    public ModelAndView login(@ModelAttribute("user") User user, @PathVariable String userId, HttpSession session,
                              HttpServletRequest request, HttpServletResponse response) throws Exception {

        System.out.println("/user/jon/login : POST");
        //Business Logic
        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>");
        ModelAndView modelAndView = new ModelAndView("jsonView");
        User dbUser = userService.getUser(user.getUserId());

        if (user.getUserPassword().equals(dbUser.getUserPassword())) {

            session.setAttribute("user", dbUser);
            if(dbUser.getRole() == 1 ) {
                session.setAttribute("role", "user");
            } else if (dbUser.getRole() == 0){
                session.setAttribute("role","admin");
            }

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
            modelAndView.addObject("userId", userId);

            System.out.println("!!!!!!!!!!"+modelAndView);

            return modelAndView;
        } else {
            System.out.println("로그인Nope");
            modelAndView.addObject("userid", "nope");
            System.out.println("!!!!!!!!!!"+modelAndView);
            return modelAndView;
        }
    }


    @RequestMapping(value = "json/addUser", method = RequestMethod.POST)
    public User addUser( @RequestBody User user, HttpSession session) throws Exception {
        System.out.println("UserRestController.addUser");

        userService.addUserInfo(user);
        session.setAttribute("user", user);

        return userService.getUser(user.getUserId());
    }

    @RequestMapping(value = "json/addUserSNS", method = RequestMethod.POST)
    public User addUserSNS(@RequestBody User user, Model model, HttpSession session) throws Exception {

        System.out.println("UserRestController.addUserSNS : POST");
        System.out.println("user = " + user);

        session.setAttribute("user", user);

        return user;
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

    //아이디 찾기
    @RequestMapping(value = "json/getUserId", method = RequestMethod.POST)
    @ResponseBody
    public String getUserId(@RequestParam("userName") String userName, @RequestParam("userPhone") String userPhone,
                            HttpServletRequest request) throws Exception{

        System.out.println("UserRestController.getUserId : POST ");

/*        userName = request.getParameter("userName");
        userPhone = request.getParameter("userPhone");*/

        System.out.println("!!!!!!!!!!!!!! : userName = " + userName + ", userPhone = " + userPhone);

        User user = new User();

        user.setUserName(userName);
        user.setUserPhone(userPhone);

        String result = userService.getUserId(userName, userPhone);

        if(result == null ){
            return "fail";
        }

        return result;
    }

    //임시비밀번호 전송을 위한 user check
    @RequestMapping(value = "json/getUserIdForPassword", method = RequestMethod.POST)
    @ResponseBody
    public String getUserIdForPassword(@RequestParam("userId") String userId, @RequestParam("userName") String userName,
                                  @RequestParam("userPhone") String userPhone, HttpServletRequest request) throws Exception {
        System.out.println("UserRestController.getUserPassword : POST");

/*        userId = request.getParameter("userId");
        userName = request.getParameter("userName");
        userPhone = request.getParameter("userPhone");*/

        User user = new User();

        user.setUserId(userId);
        user.setUserName(userName);
        user.setUserPhone(userPhone);

        String result = userService.getUserIdForPassword(userId, userName, userPhone);
        System.out.println("임시비밀번호 전송을 위한 user get!!"+result);
        return result;
    }


    //임시비밀번호전송
    @RequestMapping(value = "json/sendSMSForPassword/{userPhone}", method = RequestMethod.GET)
    @ResponseBody
    public String sendSMSForPassword(@RequestParam("userId") String userId, @PathVariable("userPhone") String userPhone,
                                  HttpServletRequest request) throws Exception {

        System.out.println("UserRestController.sendSMSForPassword");// 휴대폰 문자보내기
        System.out.println("userPhone = " + userPhone);

        Random random = new Random();
        int tempPassword = random.nextInt(888888)+111111;

        userService.sendSMSForPassword(userId, userPhone, tempPassword);

        return Integer.toString(tempPassword);

    }



}
