package com.ffin.web.qna;

import com.ffin.service.domain.Inquiry;
import com.ffin.service.qna.QnAService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/qna/*")
public class QnAController {

    @Autowired
    @Qualifier("qnAServiceImpl")
    private QnAService qnAService;

    public QnAController(QnAService qnAService) {
        this.qnAService = qnAService;
    }

    @RequestMapping(value = "addInquiry", method = RequestMethod.GET)
    public  String addInquiry() throws Exception {
        System.out.println("QnAController.addInquiry : GET");
        return "/views/qna/addInquiryView.jsp";
    }

    @RequestMapping(value = "addInquiry", method = RequestMethod.POST)
    public String addInquiry(@ModelAttribute("inquiry")Inquiry inquiry, @RequestParam("userId")String userId ,
                             @RequestPart(value="uploadFile",required = false)MultipartFile file)  throws Exception{

        System.out.println("QnAController.addInquiry : POST");
        System.out.println("나와라아아아아아 : "+file);

        inquiry.setInquiryUserId(userId);
        inquiry.setInquiryFile(file.getOriginalFilename());

        qnAService.addInquiry(inquiry);
        System.out.println("addInquiry :: "+inquiry);

        return "/views/user/userMyPage.jsp";
    }



}
