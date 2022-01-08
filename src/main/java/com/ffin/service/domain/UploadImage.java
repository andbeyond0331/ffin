package com.ffin.service.domain;

import lombok.Data;

@Data
public class UploadImage {

    //경로
    private String uploadPath;
    //uuid
    private String uuid;
    //파일명
    private String fileName;
    //문의번호
    private int inquiryNo;
}
