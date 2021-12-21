package com.ffin.service.domain;

import java.util.Date;

import lombok.Data;



@Data
public class Chat {
	
	private int chatRoomNo; 
	private int chatNo; 
	private String sendUser; 
	private String chatContent; 
	private Date sendTime;
	

}
