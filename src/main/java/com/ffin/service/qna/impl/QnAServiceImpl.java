package com.ffin.service.qna.impl;

import com.ffin.common.Search;
import com.ffin.service.domain.Inquiry;
import com.ffin.service.domain.Report;
import com.ffin.service.qna.QnADao;
import com.ffin.service.qna.QnAService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("qnAServiceImpl")
public class QnAServiceImpl implements QnAService {

    //Field
    @Autowired
    @Qualifier("qnADaoImpl")
    private QnADao qnADao;
    public void setQnADao(QnADao qnADao){
        this.qnADao = qnADao;
    }


    @Override
    public void addReport(Report report) throws Exception {
        System.out.println("QnAServiceImpl.addReport");
        qnADao.addReport(report);
    }

    @Override
    public Report getReport(int reportNo) throws Exception {
        System.out.println("QnAServiceImpl.getReport");
        return qnADao.getReport(reportNo);
    }

    @Override
    public Map<String, Object> getReportList(Search search) throws Exception {
        System.out.println("QnAServiceImpl.getReportList");
        List<Report> list = qnADao.getReportList(search);
        int totalCount = qnADao.getTotalCount(search);

        Map<String, Object>map = new HashMap<String, Object>();
        map.put("list", list);
        map.put("totalCount", new Integer(totalCount));

        return map;
    }

    @Override
    public void updateReport(Report report) throws Exception {
        System.out.println("QnAServiceImpl.updateReport");
        qnADao.updateReport(report);
    }

    @Override
    public void updateReportProcStatus(Report report) throws Exception {
        System.out.println("QnAServiceImpl.updateReportProcStatus");
        qnADao.updateReportProcStatus(report);
    }

    @Override
    public void addInquiry(Inquiry inquiry) throws Exception {
        System.out.println("QnAServiceImpl.addInquiry");

        if(inquiry.getInquiryUserId() != null){
            inquiry.setInquiryUserRole(1);
        } else {
            inquiry.setInquiryUserRole(2);
        }

        qnADao.addInquiry(inquiry);
    }

    @Override
    public Inquiry getInquiry(int inquiryNo) throws Exception {
        System.out.println("QnAServiceImpl.getInquiry");
        return qnADao.getInquiry(inquiryNo);
    }


}
