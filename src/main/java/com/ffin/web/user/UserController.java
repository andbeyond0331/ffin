package com.ffin.web.user;

import com.ffin.common.Page;
import com.ffin.common.Search;
import com.ffin.service.domain.User;
import com.ffin.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.Date;
import java.util.Map;
import java.util.Objects;

@Controller
@RequestMapping("/user/*")
public class UserController {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    private ModelAndView modelAndView;

    @Value("#{commonProperties['pageUnit']}")
    int pageUnit;
    @Value("#{commonProperties['pageSize']}")
    int pageSize;

    // 파일 저장경로 지정
    private static final String FILE_SERVER_PATH = "C:\\ffinPJT\\src\\main\\webapp\\resources\\image";


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
        System.out.println("user!!!!" + user);
        User dbUser=userService.getUser(user.getUserId());
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

            return "redirect:/views/homeTest.jsp";

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
        return "redirect:/";
    }

    @RequestMapping( value="addUser", method=RequestMethod.GET )
    public String addUser() throws Exception{

        System.out.println("/user/addUser : GET");

        return "/views/user/addUserInfo.jsp";
    }

    @RequestMapping( value="addUser", method=RequestMethod.POST )
    public String addUser( @ModelAttribute("user") User user, HttpSession session, Model model ) throws Exception {

        System.out.println("/user/addUser : POST");
        //Business Logic
        userService.addUserInfo(user);
        model.addAttribute(user);
        session.setAttribute("user", user);
        System.out.println("UserController.addUser : session "+user);

        return "/views/user/addUserProfile.jsp";
    }

    @RequestMapping( value="getUser", method=RequestMethod.GET )
    public String getUser(@RequestParam("userId") String userId , Model model, HttpSession session ) throws Exception {

        System.out.println("/user/getUser : GET");

        System.out.println("!!!!!!!!!"+session.getAttribute("role"));

        User user = userService.getUser(userId);
        model.addAttribute("user", user);

        if( session.getAttribute("role").equals("admin") ){
            System.out.println("관리자페이지로 이동");
            return "/views/user/getUserByAdmin.jsp";
        }

        System.out.println("회원전용페이지로 이동");
        return "/views/user/getUserInfo.jsp";
    }


    @RequestMapping(value = "updateUserProfile", method = RequestMethod.POST)
    public String updateUserProfile(@ModelAttribute("user") User user, @RequestParam("userId") String userId,
                                    @RequestParam("fileName1")MultipartFile file,
                                    Model model, HttpSession session) throws Exception {

        System.out.println("UserController.updateUserProfile : POST");
        System.out.println("!!!!!!!!userId!!!!!!!!!!!!"+userId);

        if(!Objects.requireNonNull(file.getOriginalFilename()).isEmpty()){
            file.transferTo(new File(FILE_SERVER_PATH, file.getOriginalFilename()));
            model.addAttribute("msg", "File uploaded successfully.");
        }else {
            model.addAttribute("msgs", "Please select a valid mediaFile..");
        }

        user.setUserProImg(file.getOriginalFilename());
        userService.updateUserProfile(user);

        System.out.println("UserController.updateUserProfile"+user);

        return "redirect:/";

    }

    @RequestMapping(value = "updateProImg", method = RequestMethod.POST)
    public String updateProImg(@ModelAttribute("user") User user, @RequestParam("userId")String userId, @RequestParam("fileName1") MultipartFile file,
                               Model model, HttpSession session) throws Exception{
        System.out.println("UserController.updateProImg : POST");

        if(!Objects.requireNonNull(file.getOriginalFilename()).isEmpty()){
            file.transferTo(new File(FILE_SERVER_PATH, file.getOriginalFilename()));
            model.addAttribute("msg", "File uploaded successfully.");
        }else {
            model.addAttribute("msgs", "Please select a valid mediaFile..");
        }

        System.out.println("!!!!!"+file.getOriginalFilename());

        //user.setUserProImg(file.getOriginalFilename());
        userService.updateProImg(userId, file.getOriginalFilename());

        return "redirect:/views/user/getUserProfile.jsp";
    }

    @RequestMapping(value="kakaoLogin", method=RequestMethod.POST)
    public String kakaoLogin( @RequestParam("userId") String userId, HttpSession session ) throws Exception{

        System.out.println("/user/snsLogin : POST");

        User dbUser = userService.getUser(userId);
        session.setAttribute("user", dbUser);
        session.setAttribute("role","user");

        return "redirect:/";
    }

    @RequestMapping(value = "getUserList")
    public String getUserList(@ModelAttribute("search")Search search, Model model, HttpServletRequest request) throws Exception{

        System.out.println("UserController.getUserList");

        if(search.getCurrentPage() == 0){
            search.setCurrentPage(1);
        }
        search.setPageSize(pageSize);

        Map<String, Object> map = userService.getUserList(search);

        Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
        System.out.println("여기는 UserList resultPage : "+resultPage);

        model.addAttribute("list", map.get("list"));
        model.addAttribute("resultPage", resultPage);
        model.addAttribute("search", search);

        return "/views/user/getUserList.jsp";
    }



}
