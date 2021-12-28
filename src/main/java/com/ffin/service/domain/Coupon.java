package com.ffin.service.domain;


import lombok.Data;

@Data
public class Coupon {
	private int couponNo; //flight_id
	private User couponReceivedUserId; //airline
	private int couponDcPrice; //price
	private int  couponStatus; //trip_course
	private int couponType; //쿠폰생성되는 날짜





}
