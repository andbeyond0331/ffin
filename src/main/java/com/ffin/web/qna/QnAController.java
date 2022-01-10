package com.ffin.web.qna;

import com.ffin.common.Page;
import com.ffin.common.Search;
import com.ffin.service.domain.Inquiry;
import com.ffin.service.qna.QnAService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.jws.WebParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/qna/*")
public class QnAController {

    @Autowired
    @Qualifier("qnAServiceImpl")
    private QnAService qnAService;

    public QnAController(QnAService qnAService) {
        this.qnAService = qnAService;
    }

    @Value("#{commonProperties['pageUnit']}")
    int pageUnit;

    @Value("#{commonProperties['pageSize']}")
    int pageSize;



    @RequestMapping(value = "addInquiry", method = RequestMethod.GET)
    public  String addInquiry() throws Exception {
        System.out.println("QnAController.addInquiry : GET");
        return "/views/qna/addInquiryView.jsp";
    }

    @RequestMapping(value = "addInquiry", method = RequestMethod.POST)
    public String addInquiry(@ModelAttribute("inquiry")Inquiry inquiry, @RequestParam("inquiryId")String inquiryId ,
                             @RequestParam("role") String role ,@RequestPart(value="uploadFile",required = false)MultipartFile file)  throws Exception{

        System.out.println("QnAController.addInquiry : POST");
        System.out.println("회원구별 : "+inquiryId + " && "+role);

        if( role.equals("user")) {
            inquiry.setInquiryUserId(inquiryId);
        } else if(role.equals("truck")){
            inquiry.setInquiryTruckId(inquiryId);
        }

        inquiry.setInquiryFile(file.getOriginalFilename());

        qnAService.addInquiry(inquiry);
        System.out.println("addInquiry :: "+inquiry);

        return "/views/user/userMyPage.jsp";
    }

    @RequestMapping(value = "getUserInquiryList")
    public String getUserInquiryList(@ModelAttribute("search")Search search, Model model,
                                     HttpSession session, HttpServletRequest request) throws Exception {

        System.out.println("QnAController.getUserInquiryList : POST");

        if(search.getCurrentPage() == 0){
            search.setCurrentPage(1);
        }

        search.setPageSize(pageSize);

        Map<String, Object> map = qnAService.getUserInquiryList(search, (String) session.getAttribute("inquiry"));

        Page resultPage = new Page(search.getCurrentPage(), (Integer) map.get("totalCount"), pageUnit, pageSize);

        model.addAttribute("list", map.get("list"));
        model.addAttribute("resultPage", resultPage);
        model.addAttribute("search", search);

        return "/views/qna/getInquiryList.jsp";
    }

    @RequestMapping(value = "getTruckInquiryList")
    public String getTruckInquiryList(@ModelAttribute("search")Search search, Model model,
                                     HttpSession session, HttpServletRequest request) throws Exception {

        System.out.println("QnAController.getTruckInquiryList : POST");

        if(search.getCurrentPage() == 0){
            search.setCurrentPage(1);
        }

        search.setPageSize(pageSize);

        Map<String, Object> map = qnAService.getTruckInquiryList(search, (String) session.getAttribute("inquiry"));

        Page resultPage = new Page(search.getCurrentPage(), (Integer) map.get("totalCount"), pageUnit, pageSize);

        model.addAttribute("list", map.get("list"));
        model.addAttribute("resultPage", resultPage);
        model.addAttribute("search", search);

        return "/views/qna/getInquiryList.jsp";
    }



}
