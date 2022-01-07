package com.ffin.web.qna;

import com.ffin.service.qna.QnAService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequestMapping("/qna/*")
public class QnAController {

    @Autowired
    @Qualifier("qnAServiceImpl")
    private QnAService qnAService;

    public QnAController(QnAService qnAService) {
        this.qnAService = qnAService;
    }

    /* 첨부파일 업로드 */
    @RequestMapping(value = "uploadInquiryFile", method = RequestMethod.POST)
    public void uploadInquiryFile(MultipartFile uploadFile) throws Exception{

        System.out.println("QnAController.uploadInquiryFile : POST");

        System.out.println("파일 이름 : "+uploadFile.getOriginalFilename());
        System.out.println("파일 타입 : "+uploadFile.getContentType());
        System.out.println("파일 크기 : "+uploadFile.getSize());
    }

}
