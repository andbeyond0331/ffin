package com.ffin.service.qna;

import com.ffin.common.Search;
import com.ffin.service.domain.Inquiry;
import com.ffin.service.domain.Report;

import java.util.Map;

public interface QnAService {

    // ***** report *****
    //신고등록
    public void addReport(Report report) throws Exception;
    //신고조회
    public Report getReport(int reportNo) throws Exception;
    //신고목록-user
    public Map<String, Object> getReportListByUser(Search search, String reportUserId) throws Exception;
    //신고목록-admin
    public Map<String, Object> getReportList(Search search) throws Exception;
    //신고수정
    public void updateReport(Report report) throws Exception;
    //신고처리
    public void updateReportProcStatus(Report report) throws Exception;

    // ***** inquiry *****
    //문의등록
    public void addInquiry(Inquiry inquiry) throws Exception;
    //문의조회
    public Inquiry getInquiry(int inquiryNo) throws Exception;
    //전체목록
    public Map<String, Object> getInquiryListByAdmin(Search search) throws Exception;
    //유저문의목록
    public Map<String, Object> getInquiryListByUser(Search search, String inquiryUserId) throws Exception;
    //트럭문의목록
    public Map<String, Object> getInquiryListByTruck(Search search, String inquiryTruckId) throws Exception;
    //문의수정
    public void updateInquiry(Inquiry inquiry) throws Exception;
    //답변등록
    //-> 답변 status도 변경!
    public void updateInquiryAns(Inquiry inquiry) throws Exception;
}
