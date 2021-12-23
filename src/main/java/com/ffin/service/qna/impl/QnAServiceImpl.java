package com.ffin.service.qna.impl;

import com.ffin.common.Search;
import com.ffin.service.domain.Report;
import com.ffin.service.qna.QnADao;
import com.ffin.service.qna.QnAService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

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
        return null;
    }


}
