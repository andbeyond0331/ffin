package com.ffin.service.domain;

import lombok.Data;

import java.util.Date;

@Data
public class Menu {
	
	private int menuNo;
	private String menuTruckId;
	private String menuName;
	private int menuPrice;
//	private String menuPrice;
	private String menuDetail;
	private int isSigMenu;
	private Date menuRegDate;
	private String menuImg1;
	private String menuImg2;
	private String menuImg3;
	//private String multiMenuImg;
	
	
}
