package com.ffin.common;

import lombok.Data;

@Data
public class Search {
	
	///Field
	private int currentPage;
	private String searchCondition;
	private String searchKeyword;
	private int pageSize;

	// TRUCK SORTING을 위한 SORTCONDITION
	private String sortCondition;

	//  2022-01-08 truck category 나누기 위한 cate condition
	private String cateCondition;

	private int endRowNum;
	private int startRowNum;
	
	///Constructor
	public Search() {
	}

	//==> Select Query 시 ROWNUM 마지막 값
	public int getEndRowNum() {
		return getCurrentPage()*getPageSize();
	}
	//==> Select Query 시 ROWNUM 시작 값
	public int getStartRowNum() {
		return (getCurrentPage()-1)*getPageSize();
	}


}