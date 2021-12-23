package com.ffin.web.msg;



import com.ffin.service.catering.CateringService;
import com.ffin.service.domain.Catering;
import com.ffin.service.domain.Msg;
import com.ffin.service.msg.MsgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/msg/*")
public class MsgRestController {

    ///Field
    @Autowired
    @Qualifier("msgServiceImpl")
    private MsgService msgService;


    public MsgRestController(){
        System.out.println(this.getClass());
    }

/*

    @Value("#{commonProperties['pageUnit']}")
    //@Value("#{commonProperties['pageUnit'] ?: 3}")
    int pageUnit;

    @Value("#{commonProperties['pageSize']}")
    //@Value("#{commonProperties['pageSize'] ?: 2}")
    int pageSize;
*/


    @RequestMapping( value="json/message_ajax_list")
    @ResponseBody
    public ModelAndView message_ajax_list(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

        System.out.println("MsgController.message_ajax_list");
        request.setCharacterEncoding("UTF-8");
        String id = (String) session.getAttribute("userId");
        //String id="user01";

        Msg to = new Msg();
        to.setId(id);
        //to.setMsgRoom(1);//지금 추가
        //System.out.println("to: "+to);
        // 메세지 리스트
        ArrayList<Msg> list = (ArrayList<Msg>) msgService.messageList(to);
        //List<Msg> list = msgService.messageList(to);

         request.setAttribute("list", list);

        // return "/message_ajax_list.jsp";
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("list", list);
        modelAndView.setViewName("/msg/message_ajax_list.jsp");
        return modelAndView;
        //return list;
    }


    @RequestMapping(value = "json/message_content_list")
    public ModelAndView message_content_list(HttpServletRequest request, HttpSession session) throws Exception {
        request.setCharacterEncoding("UTF-8");
        System.out.println("MsgController.message_content_list");
        int msgRoom = Integer.parseInt(request.getParameter("msgRoom"));
       // int msgRoom = 1;
        Msg to = new Msg();
        to.setMsgRoom(msgRoom);
        to.setId((String) session.getAttribute("userId"));
       // to.setId("user01");

        // 메세지 내용을 가져온다.
        ArrayList<Msg> clist = msgService.roomContentList(to);
        request.setAttribute("clist", clist);
        //return "/WEB-INF/views/msg/message_content_list.jsp";
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("clist", clist);
        modelAndView.setViewName("/msg/message_content_list.jsp");
        return modelAndView;
        //return clist;
    }

    // 메세지 리스트에서 메세지 보내기
    @ResponseBody
    @RequestMapping(value = "json/message_send_inlist")
    public String message_send_inlist(@RequestParam int msgRoom, @RequestParam String other_id,
                                   @RequestParam String msgContent, HttpSession session, HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("UTF-8");
        msgRoom = Integer.parseInt(request.getParameter("msgRoom"));
        other_id = request.getParameter("other_id");
        msgContent = request.getParameter("msgContent");
        System.out.println("=========================\n msgContent = " + msgContent);
        System.out.println("msgRoom = " + msgRoom + ", other_id = " + other_id + ", msgContent = " + msgContent );
        Msg to = new Msg();
        to.setMsgRoom(msgRoom);
        to.setMsgSendUserId((String) session.getAttribute("userId"));
        //to.setMsgSendUserId("user01");
        to.setMsgRecvUserId(other_id);
        to.setMsgContent(msgContent);
        //System.out.println("msgRoom = " + msgRoom + ", other_id = " + other_id + ", msgContent = " + msgContent + ", session = " + session);

        int flag = msgService.messageSendInlist(to);
        return "1";//이거 json으로 안넘어가서 1로 했는데 괜찮으까 ㅠㅠ 훔,,,,,,, 근데 insert라 별 의미없엉
    }








}