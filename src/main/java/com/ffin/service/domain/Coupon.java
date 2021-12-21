package com.ffin.service.domain;

import java.sql.Timestamp;
import lombok.Data;
import lombok.Getter;

@Data
public class Coupon {
	private int couponNo; //flight_id
	private String couponReceivedUserId; //airline
	private int couponDcPrice; //price
	private int  couponStatus; //trip_course
	private int couponWeatherType; //dep_city

	
	

	
}
