package com.ffin.web.qna;

import com.ffin.common.Page;
import com.ffin.common.Search;
import com.ffin.service.domain.Inquiry;
import com.ffin.service.domain.Truck;
import com.ffin.service.domain.User;
import com.ffin.service.qna.QnAService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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



    @RequestMapping(value = "getReportListByUser")
    public String getReportListByUser(@ModelAttribute("search")Search search, Model model, HttpSession session) throws Exception{

        System.out.println("QnAController.getReportListByUser");

        if(search.getCurrentPage() == 0) {
            search.setCurrentPage(1);
        }
        search.setPageSize(pageSize);

        Map<String, Object> map = qnAService.getReportListByUser(search, ((User)session.getAttribute("user")).getUserId() );
        Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);

        model.addAttribute("list", map.get("list"));
        model.addAttribute("resultPage", resultPage);
        model.addAttribute("search", search);

        return "/views/qna/getReportListByUser.jsp";
    }


    @RequestMapping(value = "getReportList")
    public String getReportList(@ModelAttribute("search")Search search, Model model, HttpSession session) throws Exception {

        System.out.println("QnAController.getReportList");

        if(search.getCurrentPage() == 0){
            search.setCurrentPage(1);
        }
        search.setPageSize(pageSize);

        Map<String, Object> map = qnAService.getReportList(search);

        Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
        System.out.println("search = " + search + "resultPage = "+resultPage);

        model.addAttribute("list", map.get("list"));
        model.addAttribute("resultPage", resultPage);
        model.addAttribute("search", search);

        return "/views/qna/getReportListByAdmin.jsp";

    }



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

        if(role.equals("truck")){
            return "/views/truck/truckMyPage.jsp";
        }

        return "/views/user/userMyPage.jsp";
    }

    @RequestMapping(value = "updateInquiry", method = RequestMethod.GET)
    public String updateInquiry(@RequestParam("inquiryNo") int inquiryNo, Model model) throws Exception {

        System.out.println("QnAController.updateInquiry : GET");

        Inquiry inquiry = qnAService.getInquiry(inquiryNo);
        model.addAttribute("inquiry", inquiry);
        return "/views/qna/updateInquiryView.jsp";
    }

    @RequestMapping(value = "updateInquiry", method = RequestMethod.POST)
    public String updateInquiry(@ModelAttribute("inquiry") Inquiry inquiry, Model model, HttpSession session) throws Exception {

        System.out.println("QnAController.updateInquiry : POST");

        qnAService.updateInquiry(inquiry);

        return "redirect:/qna/getInquiryListByUser";
    }


    /* admin 문의목록 */
    @RequestMapping(value = "getInquiryListByAdmin")
    public String getInquiryListByAdmin(@ModelAttribute("search")Search search, Model model, HttpSession session) throws Exception {

        System.out.println("QnAController.getInquiryListByAdmin");

        if(search.getCurrentPage() == 0){
            search.setCurrentPage(1);
        }
        search.setPageSize(pageSize);

        Map<String, Object> map = qnAService.getInquiryListByAdmin(search);

        Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
        System.out.println("search = " + search + "resultPage = "+resultPage);

        model.addAttribute("list", map.get("list"));
        model.addAttribute("resultPage", resultPage);
        model.addAttribute("search", search);

        return "/views/qna/getInquiryListByAdmin.jsp";
    }

    /* user 문의목록 */
    @RequestMapping(value = "getInquiryListByUser")
    public String getUserInquiryList(@ModelAttribute("search")Search search, Model model,
                                     HttpSession session, HttpServletRequest request) throws Exception {

        System.out.println("QnAController.getUserInquiryList");

        if(search.getCurrentPage() == 0){
            search.setCurrentPage(1);
        }
        search.setPageSize(pageSize);

        Map<String, Object> map = qnAService.getInquiryListByUser(search, ((User)session.getAttribute("user")).getUserId());

        Page resultPage = new Page(search.getCurrentPage(), (Integer) map.get("totalCount"), pageUnit, pageSize);

        model.addAttribute("list", map.get("list"));
        model.addAttribute("resultPage", resultPage);
        model.addAttribute("search", search);

        return "/views/qna/getInquiryListByUser.jsp";
    }

    /* truck 문의목록 */
    @RequestMapping(value = "getInquiryListByTruck")
    public String getInquiryListByTruck(@ModelAttribute("search")Search search, Model model,
                                     HttpSession session, HttpServletRequest request) throws Exception {

        System.out.println("QnAController.getTruckInquiryList");

        if(search.getCurrentPage() == 0){
            search.setCurrentPage(1);
        }

        search.setPageSize(pageSize);

        Map<String, Object> map = qnAService.getInquiryListByTruck(search, ((Truck) session.getAttribute("truck")).getTruckId());

        Page resultPage = new Page(search.getCurrentPage(), (Integer) map.get("totalCount"), pageUnit, pageSize);

        model.addAttribute("list", map.get("list"));
        model.addAttribute("resultPage", resultPage);
        model.addAttribute("search", search);

        return "/views/qna/getInquiryListByTruck.jsp";
    }



}
