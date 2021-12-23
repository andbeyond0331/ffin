package com.ffin.service.qna;

import com.ffin.common.Search;
import com.ffin.service.domain.Report;

import java.util.Map;

public interface QnAService {

    // ***** report *****
    //신고등록
    public void addReport(Report report) throws Exception;
    //신고조회
    public Report getReport(int reportNo) throws Exception;
    //신고목록
    public Map<String, Object> getReportList(Search search) throws Exception;
    //신고수정

    //신고처리


    // ***** inquiry *****
    //문의등록

    //문의수정

    //답변여부

    //답변등록

    //문의조회

    //문의목록
}
