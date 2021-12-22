package com.ffin.service.domain;

import java.sql.Timestamp;
import java.util.Date;

import lombok.Data;
@Data
public class Catering {

    private Truck ctTruck; // truck
    private User ctUser; // user
    private Menu ctMenu; //menu

    private int ctNo;
    private String ctDate;
    private String ctStartTime;
    private String ctEndTime;
    private int ctMenuMinQty;
    private int ctMenuMaxQty;
    private int ctMenuQty;
    private String ctAdd;
    private String ctAddDetail;
    private String ctUserRequest;
    private String ctPhone;
    private int ctQuotation;
    private int ctRealQuotation;
    private String ctTruckRequest;
    private String ctStatusCode;
    private Timestamp ctServRegDate;
    private Timestamp ctResRegDate;
    private Timestamp ctCancelDate;

}
