package com.ffin.service.domain;


import java.sql.Timestamp;
import java.util.Date;

import lombok.Data;

@Data
public class Comment {
	
	private int commentNo;
	private int commentPostNo;
	private String commentContent;
	private String commentUserId;
	private String commentTruckId;
	private Timestamp commentDate;
	private int secretKey;

}
