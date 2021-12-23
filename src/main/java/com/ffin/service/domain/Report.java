package com.ffin.service.domain;

import java.util.Date;
import lombok.Data;

@Data
public class Report {

	private int reportNo ;
	private String reportUserId;
	private String reportTargetId;
	private String reportDate;
	private String reportContent;
	private String reportLink;
	private int reportType;
	private int reportProcStatus;
	

	
}
