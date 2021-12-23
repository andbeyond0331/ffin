package com.ffin.service.qna;

import com.ffin.common.Search;
import com.ffin.service.domain.Inquiry;
import com.ffin.service.domain.Report;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.Map;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {	"classpath:config/context-common.xml",
                                    "classpath:config/context-aspect.xml",
                                    "classpath:config/context-mybatis.xml",
                                    "classpath:config/context-transaction.xml" })
public class QnAServiceTest {

    @Autowired
    @Qualifier("qnAServiceImpl")
    private QnAService qnAService;

    //@Test
    public void testAddReport() throws Exception{

        Report report = new Report();
        report.setReportUserId("testId");
        report.setReportTargetId("test01");
        report.setReportDate("2021-12-22");
        report.setReportLink("www.ffin.com/testReport");
        report.setReportContent("testReport");
        report.setReportType(3);

        qnAService.addReport(report);
    }

    //@Test
    public void testGetReport() throws Exception{
        Report report = new Report();
        report = qnAService.getReport(1);
        System.out.println(report);
    }

    //@Test
    public void testGetReportList() throws Exception{
        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(3);
        search.setStartRowNum(1);
        search.setEndRowNum(7);
        Map<String, Object> map = qnAService.getReportList(search);

        List<Object> list = (List<Object>) map.get("list");
        for(Object i : list){
            System.out.println(i);
        }
    }

    //@Test
    public void testUpdateReport() throws Exception{
        Report report = qnAService.getReport(7);
        Assert.assertNotNull(report);

        report.setReportContent("junitTest");
        report.setReportLink("junitTest@test.com");
        report.setReportType(4);

        qnAService.updateReport(report);
        System.out.println(report);
    }

    //@Test
    public void testUpdateReportProcStatus() throws Exception{
        Report report = qnAService.getReport(7);
        Assert.assertNotNull(report);

        report.setReportProcStatus(2);

        qnAService.updateReportProcStatus(report);
        System.out.println(report);
    }


    // ***** Inquiry *****
    //@Test
    public void testAddInquiry() throws Exception {
        Inquiry inquiry = new Inquiry();
        inquiry.setInquiryTruckId("truck01");
        inquiry.setInquiryTitle("testTitle");
        inquiry.setInquiryContent("testTestTest");
        inquiry.setInquiryFile("testFile");
        inquiry.setInquiryDate("2021-10-10");
        inquiry.setInquiryAnsStatus(1);

        qnAService.addInquiry(inquiry);
        System.out.println(inquiry);
    }

    @Test
    public void testGetInquiry() throws Exception {
        Inquiry inquiry = new Inquiry();
        inquiry = qnAService.getInquiry(8);
        System.out.println(inquiry);
    }

}
