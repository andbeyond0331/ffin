package com.ffin.service.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Inquiry {
	
	private int inquiryNo;
	private String inquiryUserId;
	private String inquiryTruckId;
	private int inquiryType;
	private String inquiryTitle;
	private String inquiryContent;
	private String inquiryFile;
	private Date inquiryDate;
	private int inquiryAnsStatus;
	private String inquiryAnsTitle;
	private String inquiryAnsContent;
	private Date inquiryAnsDate;
	private int inquiryUserRole;
	
}
