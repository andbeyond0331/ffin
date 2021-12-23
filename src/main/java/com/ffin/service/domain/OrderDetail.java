package com.ffin.service.domain;

import lombok.Data;

@Data
public class OrderDetail {

	private int odNo;
	private Purchase odOrderNo;
	private String odMenuName;
	private String odOptionGroupName;
	private String odOptionName;
	private int odMenuQty;
	private int odMenuQtyFlag;
	private int odMenuPrice;
	private int odOptionPrice;
	private String odMenuImage;

}
