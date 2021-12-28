package com.ffin.web.chatting;


import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

import com.ffin.service.domain.Room;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;


@Controller
public class ChattingController {

    List<Room> roomList = new ArrayList<Room>();
    static int roomNumber = 0;

    @RequestMapping("/chat")
    public ModelAndView chat() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/views/chatting/chat.jsp");
        return mv;
    }

    /**
     * 방 페이지
     * @return
     */
    @RequestMapping("/room")
    public ModelAndView room() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/views/chatting/room.jsp");
        return mv;
    }

    /**
     * 방 생성하기
     * @param params
     * @return
     */
    @RequestMapping("/createRoom")
    public @ResponseBody List<Room> createRoom(@RequestParam HashMap<Object, Object> params){
        String roomName = (String) params.get("roomName");
        if(roomName != null && !roomName.trim().equals("")) {
            Room room = new Room();
            room.setRoomNumber(++roomNumber);
            room.setRoomName(roomName);
            roomList.add(room);
        }
        return roomList;
    }

    /**
     * 방 정보가져오기
     * @param params
     * @return
     */
    @RequestMapping("/getRoom")
    public @ResponseBody List<Room> getRoom(@RequestParam HashMap<Object, Object> params){
        return roomList;
    }

    /**
     * 채팅방
     * @return
     */
    @RequestMapping("/moveChating")
   // public ModelAndView chating(@RequestParam HashMap<Object, Object> params) {
    //public ModelAndView chating(@RequestParam("roomName") String roomName, @RequestParam("roomNumber") int roomNumber) {
    public ModelAndView chating(HttpServletRequest request) throws Exception  {
        System.out.println("ChattingController.chating");
        request.setCharacterEncoding("UTF-8");
        String roomName = new String(request.getParameter("roomName").getBytes("8859_1"),"UTF-8");

        int roomNumber = Integer.parseInt(request.getParameter("roomNumber"));
        System.out.println("roomName = " + roomName + ", roomNumber = " + roomNumber);
        ModelAndView mv = new ModelAndView();
       // int roomNumber = Integer.parseInt((String) params.get("roomNumber"));

        List<Room> new_list = roomList.stream().filter(o->o.getRoomNumber()==roomNumber).collect(Collectors.toList());
        if(new_list != null && new_list.size() > 0) {
            mv.addObject("roomName", roomName);
            mv.addObject("roomNumber", roomNumber);
            mv.setViewName("/views/chatting/chat.jsp");
        }else {
            mv.setViewName("/views/chatting/room.jsp");
        }
        return mv;
    }
}