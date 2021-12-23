package com.ffin.service.msg.impl;


import com.ffin.service.domain.Msg;
import com.ffin.service.msg.MsgDao;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class MsgDaoImpl implements MsgDao {

    @Autowired
    private SqlSession sqlSession;

    // 메세지 리스트
    //public ArrayList<Msg> messageList(Msg to) {
    public List<Msg> messageList(Msg to) {
        String id = to.getId();

        // 메세지 리스트에 나타낼 것들 가져오기 - 가장 최근 메세지, 보낸사람 profile 사진, 보낸사람 nick
        //List list = (List) sqlSession.selectList("MessageMapper.message_list", to);
        System.out.println("id = " + id);
        System.out.println("to = " + to);
        List<Msg> list = sqlSession.selectList("MessageMapper.message_list", to);
        System.out.println("list: "+list);
        for (Msg mto : list) {
            mto.setId(id);
            System.out.println("mto = " + mto);
            // 현재 사용자가 해당 room에서 안읽은 메세지의 갯수를 가져온다.
            int unread = sqlSession.selectOne("MessageMapper.count_unread", mto);
            System.out.println("unread = " + unread);
            // 현재 사용자가 메세지를 주고받는 상대 profile을 가져온다. (pro-img)
            String profile = sqlSession.selectOne("MessageMapper.get_other_profile",mto);
            // 안읽은 메세지 갯수를 mto에 set한다.
            mto.setUnread(unread);
            // 메세지 상대의 프로필사진을 mto에 set한다.
            mto.setProfile(profile);
            // 메세지 상대 id을 세팅한다. other_id
            if (id.equals(mto.getMsgSendUserId())) {
                mto.setOther_id(mto.getMsgRecvUserId());
            } else {
                mto.setOther_id(mto.getMsgSendUserId());
            }
        }

        return list;
    }


    // room 별 메세지 내용을 가져온다.
    public ArrayList<Msg> roomContentList(Msg to) {

        System.out.println("room : " + to.getMsgRoom());
        System.out.println("recv_id : " + to.getMsgRecvUserId());
        System.out.println("id : " + to.getId());
        // 메세지 내역을 가져온다
        ArrayList<Msg> clist = (ArrayList) sqlSession.selectList("MessageMapper.room_content_list", to);

        // 해당 방의 메세지들 중 받는 사람이 현재사용자의 nick인 메세지를 모두 읽음 처리한다
        sqlSession.update("message_read_chk", to);

        return clist;
    }

    // 메세지 list에서 메세지를 보낸다.
    public int messageSendInlist(Msg to) {

        // 메세지리스트에서 보낸건지 프로필에서 보낸건지 구분하기 위함
        if(to.getMsgRoom() == 0) {	// room이 0이라면 프로필에서 보낸거다
            int exist_chat = sqlSession.selectOne("MessageMapper.exist_chat", to);
            // 프로필에서 보낸것중 메세지 내역이없어서 첫메세지가 될경우를 구분하기 위함
            if(exist_chat == 0) {	// 메세지 내역이 없어서 0이면 message 테이블의 room 최댓값을 구해서 to에 set 한다.
                int max_room = sqlSession.selectOne("MessageMapper.max_room", to);
                to.setMsgRoom(max_room+1);
            }else {		// 메세지 내역이 있다면 해당 room 번호를 가져온다.
                int room = Integer.parseInt(sqlSession.selectOne("MessageMapper.select_room", to) );
                to.setMsgRoom(room);
            }
        }

        int flag = sqlSession.insert("MessageMapper.messageSendInlist",to);
        return flag;
    }

}