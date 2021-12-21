package com.ffin.service.domain;

import java.sql.Timestamp;
import java.util.Date;
import lombok.Data;

@Data
public class Purchase {
	
	//***********************************
	
	private int orderNo;
	private String orderUserId;
	private String orderTruckId;
	private int payPointNo;
	private int payCouponNo;
	private int payResNo;
	private int orderQty;
	private String orderRequest;
	private int orderStatus;
	private int orderPickUpTime;
	private int orderCookingTime;
	private int orderCancelReason;
	private int orderNopeReason;
	private int orderTotalPrice;
	private Date payDateTime;
	private Date payRefundDateTime;
	private int payServiceType;
	private int payOption;
	private int payRefundStatus;
	private int payPrice;

}
