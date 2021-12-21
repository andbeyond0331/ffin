package com.ffin.service.domain;

import java.util.Date;
import lombok.Data;


@Data
public class Post {
	
	private int boardCateNo;
	private int postNO;
	private String postUserId;
	private String postTitle;
	private String postContent;
	private Date postRegDate;
	private int secretKey;
	private String postFile1;
	private String postFile2;
	private String postFile3;
	

}