package com.ffin.service.msg.impl;


import com.ffin.service.domain.Msg;
import com.ffin.service.msg.MsgDao;
import com.ffin.service.msg.MsgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("msgServiceImpl")
public class MsgServiceImpl implements MsgService {

    @Autowired
    @Qualifier("msgDaoImpl")
    private MsgDao msgDao;

    public MsgServiceImpl() {
        System.out.println(this.getClass());
    }


    @Override
    //public ArrayList<Msg> messageList(Msg to) throws Exception {
    public List<Msg> messageList(Msg to) throws Exception {
        return msgDao.messageList(to);
    }

    @Override
    public ArrayList<Msg> roomContentList(Msg to) throws Exception {
        return msgDao.roomContentList(to);
    }

    @Override
    public int messageSendInlist(Msg to) throws Exception {
        return msgDao.messageSendInlist(to);
    }
}
