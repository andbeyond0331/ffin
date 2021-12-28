package com.ffin.web.msg;


import com.ffin.service.domain.Msg;
import com.ffin.service.domain.User;
import com.ffin.service.msg.MsgService;
import com.ffin.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/msg/*")
public class MsgController {

    @Autowired
    @Qualifier("msgServiceImpl")
    private MsgService msgService;

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;
    public MsgController(){
        System.out.println(this.getClass());
    }



    // 메세지 목록
    @RequestMapping(value = "/message_list")
    public ModelAndView message_list(HttpServletRequest request, HttpSession session) throws Exception {
        // System.out.println("현대 사용자 nick : " + session.getAttribute("nick"));
        System.out.println("MsgController.message_list");
        //test하느라 id값 고정으로 해놓음
        String id = (String) session.getAttribute("userId");
        //String id="user01";

        Msg to = new Msg();
        to.setId(id);

        // 메세지 리스트
       // ArrayList<Msg> list = msgService.messageList(to);
        List<Msg> list = msgService.messageList(to);

        request.setAttribute("list", list);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("list", list);
        modelAndView.setViewName("/views/msg/message_list.jsp");
        return modelAndView;
    }


    @RequestMapping(value = "login", method = RequestMethod.GET)
    public ModelAndView login() throws Exception{
        System.out.println("UserController.login : GET");
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/views/msg/msglogin.jsp");
        return modelAndView;
    }

    @RequestMapping(value = "login", method = RequestMethod.POST)
    public ModelAndView login(@ModelAttribute("user") User user, HttpSession session) throws Exception{
        System.out.println("UserController.login : POST");

        User dbUser=userService.getUser(user.getUserId());
//        ModelMap modelMap = modelAndView.getModelMap();
//        Object userCoo = modelMap.get("user");
        System.out.println("dbUser = " + dbUser);
        if( user.getUserPassword().equals(dbUser.getUserPassword())) {

            session.setAttribute("user", dbUser);
            session.setAttribute("role", "user");
            session.setAttribute("userId", user.getUserId());

        }

        System.out.println("user = " + user);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("user", dbUser);
        modelAndView.setViewName("/views/msg/message_list.jsp");
        return modelAndView;


    }



/*

    // 메세지 목록
    @RequestMapping(value = "/message_ajax_list")
    public ModelAndView message_ajax_list(HttpServletRequest request, HttpSession session) throws Exception {
        // System.out.println("현대 사용자 nick : " + session.getAttribute("nick"));
        System.out.println("MsgController.message_ajax_list");

        //String id = (String) session.getAttribute("userId");
        String id="user03";

        Msg to = new Msg();
        to.setId(id);
        to.setMsgRoom(1);//지금 추가
        System.out.println("to: "+to);
        // 메세지 리스트
        //ArrayList<Msg> list = msgService.messageList(to);
        List<Msg> list = msgService.messageList(to);

       // request.setAttribute("list", list);

       // return "forward: cmnt/message_ajax_list";
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("list", list);
        modelAndView.setViewName("/WEB-INF/views/msg/message_ajax_list.jsp");
        return modelAndView;
    }

    @RequestMapping(value = "/message_content_list")
    public ModelAndView message_content_list(HttpServletRequest request, HttpSession session) throws Exception {
        System.out.println("MsgController.message_content_list");
        //int msgRoom = Integer.parseInt(request.getParameter("msgRoom"));
        int msgRoom = 1;
        Msg to = new Msg();
        to.setMsgRoom(msgRoom);
       // to.setId((String) session.getAttribute("userId"));
to.setId("user03");

        // 메세지 내용을 가져온다.
        ArrayList<Msg> clist = msgService.roomContentList(to);
        System.out.println("clist: "+clist);
      */
/*  request.setAttribute("clist", clist);

        return "forward : cmnt/message_content_list";*//*

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("clist", clist);
        modelAndView.setViewName("/WEB-INF/views/msg/message_content_list.jsp");
        return modelAndView;
    }

    // 메세지 리스트에서 메세지 보내기
    @ResponseBody
    @RequestMapping(value = "/message_send_inlist")
    public int message_send_inlist(@RequestParam int msgRoom, @RequestParam String other_id,
                                   @RequestParam String msgContent, HttpSession session, HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("UTF-8");

        Msg to = new Msg();
        to.setMsgRoom(msgRoom);
       // to.setMsgSendUserId((String) session.getAttribute("UserId"));
        to.setMsgSendUserId("user03");
        to.setMsgRecvUserId(other_id);
        to.setMsgContent(msgContent);
        System.out.println("msgRoom = " + msgRoom + ", other_id = " + other_id + ", msgContent = " + msgContent + ", session = " + session);
        
        int flag = msgService.messageSendInlist(to);
        System.out.println("flag = " + flag);
        return flag;
    }
*/

}
