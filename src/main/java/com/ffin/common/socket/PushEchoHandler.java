package com.ffin.common.socket;


import com.ffin.service.domain.User;
import com.mysql.cj.util.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PushEchoHandler extends TextWebSocketHandler {
    // 이미지를 올리고 싶으면 바이너리웹소켓핸들러 extends

    List<WebSocketSession> sessions = new ArrayList<>();
    Map<String, WebSocketSession> userSessions = new HashMap<>();



    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        // connection이 연결이 되었을 때.
        System.out.println("afterConnectionEstablished : "+session);
        sessions.add(session); //세션을 관리하기 위하여 저장
        String senderId = getId(session); //세션의 고유한 id
        System.out.println("::::::::::::::::::::::::::::::::::senderId = " + senderId);
        userSessions.put(senderId, session);
        System.out.println("vvvvvvvvvvvvvvvvvvvvv    " +userSessions);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        System.out.println("handleTextMessage : "+session + " : "+message);
        // 소켓에 메세지를 보냈을 떄.
        //super.handleTextMessage(session, message);
        // 메세지 받은 사람에게 보내려고 함. 접속되어있는유저에게.
        // 공지 날릴떄 전체 유저에게 보낼 수도 잇음
        String senderId = getId(session); //세션의 고유한 id
       /* 모든 유저
       for(WebSocketSession sess : sessions){
            sess.sendMessage(new TextMessage(senderId+" : "+message.getPayload()));
        }*/
        // protocol : 어디서 보내는지 여부(ex. 메세지,주문 등등..) ,  보내는 사람, 받는 사람, no(필요시)  (message, user1, user2, 19)
        // message에서는 사실 no가 필요없어서 일단은 길이 3으로 가는데 만약에 다른 쪽에서 댓글 달았을 때 알림이 필요한 경우라면
        // no가 필요하기 떄문에 길이로 구분해서 if 로 처리해야할 것 같음
        System.out.println(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
        System.out.println("senderId " + senderId);
        String msg = message.getPayload();
        if (msg != null) {
            String[] strs = msg.split(",");
            System.out.println("strs:::::::::::::::::::::::"+ strs);
            if(strs != null && strs.length == 3) {
                String cmd = strs[0]; //message
                String sendUser = strs[1]; // 보내는 사람
                String recvUser = strs[2]; // 받는 사람
                System.out.println("recvUser = " + recvUser);
                System.out.println("sendUser = " + sendUser);
                System.out.println("cmd = " + cmd);
                // 근데 받는 사람이 접속했을 때에만 알림이 가는 거니까.
                WebSocketSession recvUserSession = userSessions.get(recvUser.trim());
                System.out.println("::::::::::recvUserSession = " + recvUserSession);
                if("message".equals(cmd) && recvUserSession != null){ // 다른 cmd일 땐 다르게 알림 날릴 수 잇쥐
                    TextMessage tmpMsg = new TextMessage("<a href='/msg/message_list'>"+sendUser + "</a>님이 메세지를 날려써여 공연보게해주세여 ");
                    // 여기서 no 를 달꺼면 여기에 <a href = ~~~~> 해서 쓰면 누르면 갈꺼야!!!!!!

                    System.out.println("::::::::::::::::::::::::::::tmpMsg = " + tmpMsg);
                    recvUserSession.sendMessage(tmpMsg);
                }
            }
        }

    }

    private String getId(WebSocketSession session) {
        Map<String, Object> httpSession = session.getAttributes();
       // User loginUser = httpSession.get("user"); user로 나중에 저장하면 글케 들고오기
        String loginUserId = ((User) httpSession.get("user")).getUserId();
        System.out.println("loginUserId = " + loginUserId);
        if(null == loginUserId)
            return session.getId();
        else
            return loginUserId;
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        // connection이 끊겼을 때.
        //super.afterConnectionClosed(session, status);
        System.out.println("afterConnectionClosed : "+session+" : "+status);
    }
}
