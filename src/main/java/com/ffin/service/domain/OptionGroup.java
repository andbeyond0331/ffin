package com.ffin.service.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class OptionGroup {
	
	private int MenuNo;
	private int optionGroupNo;
	private int optionNo;
	private String optionGroupName;
	private String optionName;
	private int optionPrice;
	
	
}
