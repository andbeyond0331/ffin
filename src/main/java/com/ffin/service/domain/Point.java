package com.ffin.service.domain;

import lombok.Data;

import java.util.Date;


@Data
public class Point {
	
	//point TABLE
	private int pointNo;
	private User pointUserId;
	private int pointAmt;
	private Date pointUseDate;
	private int pointPlmnStatus;
	private int pointStatus;
	private int pointBirthCode;
	

}
