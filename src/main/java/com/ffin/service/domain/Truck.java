package com.ffin.service.domain;

import java.sql.Date;
import lombok.Data;

@Data
public class Truck {
	
	private String truckId;
	private String truckPassword; 
	private String truckCEOName; 
	private Date truckCEOBirth; 
	private String truckAddr; 
	private String truckAddrDetail; 
	private String truckPhone; 
	private String truckEmail; 
	private String truckBusiLice; 
	private String truckBusiNo; 
	private int truckCate; 
	private String truckProImg; 
	private String truckCEOIntro; 
	private Float truckAVGStar; 
	private Double truckMapLa; 
	private Double truckMapLo; 
	private Date truckJoinReqStatus; 
	private Date truckJoinReqDate; 
	private String truckNoticeTitle; 
	private String truckNoticeContent; 
	private String truckNoticeImg; 
	private int truckByeStatus; 
	private int truckByeReason; 
	private int truckBusiStatus; 
	private Date truckRegDate; 
	private int role; 
	

}
