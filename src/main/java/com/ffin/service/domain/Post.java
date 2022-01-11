package com.ffin.service.domain;

import java.sql.Timestamp;
import java.util.Date;
import lombok.Data;


@Data
public class Post {

	private User postUser;		// 게시물을 작성한 이용자
	private Truck postTruck;	// 게시물을 작성한 트럭

	private int postNo;
	private String postTitle;
	private String postContent;
	private Timestamp postRegDate;
	private int secretKey;
	private String postFile1;
	private String postFile2;
	private String postFile3;

	// HHJ
	// 조회수
	private int postHit;
	// 좋아요 수 카운트
	private int heartCount;
	private int heartNo;

	private String heartUserId;
	private String heartTruckId;
	private int replyCount;
}