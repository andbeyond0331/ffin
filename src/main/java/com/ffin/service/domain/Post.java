package com.ffin.service.domain;

import java.util.Date;
import lombok.Data;


@Data
public class Post {

	private User postUser;		// 게시물을 작성한 이용자
	private Truck postTruck;	// 게시물을 작성한 트럭

	private int postNo;
	private String postTitle;
	private String postContent;
	private Date postRegDate;
	private int secretKey;
	private String postFile1;
	private String postFile2;
	private String postFile3;

}