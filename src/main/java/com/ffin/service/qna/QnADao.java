package com.ffin.service.qna;

import com.ffin.common.Search;
import com.ffin.service.domain.Inquiry;
import com.ffin.service.domain.Report;

import java.util.List;

public interface QnADao {

    // ***** report *****
    //신고등록
    public void addReport(Report report) throws Exception;
    //신고조회
    public Report getReport(int reportNo) throws Exception;
    //신고목록
    public List<Report> getReportList(Search search) throws Exception;
    //totalCount
    public int getTotalCount(Search search) throws Exception;
    //신고수정
    public void updateReport(Report report) throws Exception;
    //신고처리
    public void updateReportProcStatus(Report report) throws Exception;

    // ***** inquiry *****
    //문의등록
    public void addInquiry(Inquiry inquiry) throws Exception;
    //문의조회
    public Inquiry getInquiry(int inquiryNo) throws Exception;
    //문의목록

    //문의수정

    //답변여부

    //답변등록


}
