package com.ffin.service.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Heart {
	private int heartNo;
	private int heartTargetP;
	private String heartTargetT;
	private int heartType;
	private Date heartRegDate;
	private int heartFlag;
	private String heartUserId;
	

	
}
