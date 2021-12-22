package com.ffin.service.msg;

import com.ffin.service.domain.Msg;

import java.util.ArrayList;
import java.util.List;

public interface MsgDao {
   // public ArrayList<Msg> messageList(Msg to) throws Exception;
   public List<Msg> messageList(Msg to) throws Exception;
    public ArrayList<Msg> roomContentList(Msg to) throws Exception;
    public int messageSendInlist(Msg to) throws Exception;

}
