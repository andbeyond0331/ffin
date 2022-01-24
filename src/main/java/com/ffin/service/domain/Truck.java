package com.ffin.service.domain;

import java.sql.Date;
import lombok.Data;

@Data
public class Truck {

	private String truckId; //트럭 아이디
	private String truckPassword; //트럭 비밀번호
	private String truckCEOName; //트럭 사업자 이름
	private Date truckCEOBirth; // 트럭 사업자 생일
	private String truckAddr; // 트럭 주소
	private String truckAddrDetail; // 트럭 상세주소
	private String truckPhone; // 트럭 전화번호
	private String truckEmail; // 트럭 이메일
	private String truckName; //트럭 상호
	private String truckBusiLice; //트럭 사업자등록증
	private String truckBusiNo; //트럭 사업자등록번호
	private int truckCate; // 트럭 카테고리
	private String truckProImg; //트럭 프로필 이미지
	private String truckCEOIntro; //트럭 사업자 소개?
	private Float truckAVGStar; //트럭 평균 별점
	private Double truckMapLa; //트럭 위도
	private Double truckMapLo; //트럭 경도
	private int truckJoinReqStatus; //트럭 가입 요청 상태
	private Date truckJoinReqDate; //트럭 가입 등록일
	private String truckNoticeTitle; //트럭 공지 제목
	private String truckNoticeContent; // 트럭 공지 내용
	private String truckNoticeImg; //트럭 공지 사진
	private int truckByeStatus; //트럭 탈퇴 상태
	private int truckByeReason; //트럭 탈퇴 이유
	private String truckBusiStatus;//트럭 사업 상태?
	private Date truckRegDate; //트럭 등록 날짜
	private int role; // role

	// 트럭 리스트 소팅 위한 sigMenu 정보 추가
	private int truckSigMenuNo;
	private String truckSigMenuName;
	private String truckSigMenuImg1;
	private int menuPrice;

	//43 추가 0115 HHJ
	private int truckHeartCount;
}