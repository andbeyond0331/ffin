package com.ffin.common;

import lombok.Data;

@Data
public class Search {
	
	///Field
	private int currentPage;
	private String searchCondition;
	private String searchKeyword;
	private int pageSize;

	private int endRowNum;
	private int startRowNum;
	
	///Constructor
	public Search() {
	}

}