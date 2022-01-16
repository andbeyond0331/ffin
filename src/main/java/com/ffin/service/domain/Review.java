package com.ffin.service.domain;
import lombok.Data;

@Data
public class Review {
	
	private int rvNo; 
	private int rvOrderNo;
	private String rvTruckId;
	private String rvUserId;
	private String rvRegTime; 
	private float rvStar;
	private String rvContent; 
	private String rvTruckCmtRegTime; 
	private String rvTruckCmtContent; 
	private String rvImg1; 
	private String rvImg2; 
	private String rvImg3;
	private char rvDelete;
	private char rvTCDelete;

	//프로필사진을 가져온다.
	private String userProImg;
	private String truckProImg;

	

}