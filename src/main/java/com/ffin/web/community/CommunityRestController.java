package com.ffin.web.community;

import com.ffin.service.community.CommunityService;
import com.ffin.service.domain.Comment;
import com.ffin.service.domain.Post;
import com.ffin.service.domain.Truck;
import com.ffin.service.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.awt.color.CMMException;
import java.util.List;

// @ResponseBody를 붙이지 않아도 뷰가 아닌 데이터 리턴 가능
@RestController // spring 4.0부터 사용 가능
@RequestMapping("/community/*") //공통적인 url pattern
public class CommunityRestController {

    /// Field
    @Autowired
    @Qualifier("communityServiceImpl")
    private CommunityService communityService;
    // setter Method 구현않음

    public CommunityRestController() {
        System.out.println(this.getClass());
    }

    @Value("#{commonProperties['pageUnit']}")
    int pageUnit;
    @Value("#{commonProperties['pageSize']}")
    int pageSize;

    //댓글리스트를 호출할때 맵핑되는 메소드
    @RequestMapping(value = "getCommentList", method = RequestMethod.GET)
    @ResponseBody
    public ModelAndView getCommentList(@RequestParam("commentPostNo") int commentPostNo, HttpServletRequest request, ModelAndView m, HttpSession session) throws Exception{

        System.out.println("/community/getCommentList : GET");

        int postNo = (int) session.getAttribute("postNo");

        System.out.println("postNo = " + postNo);

        commentPostNo = postNo;

        System.out.println("commentPostNo = " + commentPostNo);

        List<Comment> list = communityService.getCommentList(commentPostNo); //댓글 목록

        System.out.println("list = " + list);

        //m.setViewName("/community/getPost?postNo="+postNo); //뷰의 이름
        m.setViewName("/community/json/getCommentList?commentPostNo="+commentPostNo); //뷰의 이름

        m.addObject("list", list); //뷰에 전달할 데이터 저장

        //System.out.println("m = " + m);

        return m; //뷰로 이동
    }

    //댓글 목록을 ArrayList로 리턴
    @RequestMapping(value = "json/getCommentList", method = RequestMethod.GET)
    @ResponseBody
    public List<Comment> list_json(@RequestParam("commentPostNo") int commentPostNo) throws Exception {
        return communityService.getCommentList(commentPostNo);
    }

    // 댓글작성 메소
    @RequestMapping(value = "addComment", method = RequestMethod.POST) //세부적인 url pattern
    @ResponseBody
    public String addComment(@ModelAttribute("comment") Comment comment, HttpSession session) throws Exception {

        System.out.println("/community/addComment : POST");

        String role =(String) session.getAttribute("role");

        System.out.println("role = " + role);

        User commentUser = null;
        Truck commentTruck = null;

        if (session.getAttribute("role").equals("user")) {
            commentUser = (User) session.getAttribute("user");
            System.out.println("댓글 작성자(user) : " + commentUser.getUserId());
            comment.setCommentUserId(commentUser.getUserId());
        } else if (session.getAttribute("role").equals("truck")) {
            commentTruck = (Truck) session.getAttribute("truck");
            System.out.println("댓글 작성자(truck) : " + commentTruck.getTruckId());
            comment.setCommentTruckId(commentTruck.getTruckId());
        }
        
        int commentPostNo = (int) session.getAttribute("postNo");

        System.out.println("commentPostNo = " + commentPostNo);

        comment.setCommentPostNo(commentPostNo);

        communityService.addComment(comment);

        return "redirect:/community/getPost";
    }

//    @RequestMapping(value = "updateComment", method = RequestMethod.GET)
//    @ResponseBody
//    public String updateComment(@ModelAttribute("comment") Comment comment, Model model, HttpSession session) throws Exception {
//
//        System.out.println("/community/updateComment : GET");
//        //Business Logic
//        communityService.updateComment(comment);
//
//        int sessionNo = ((Comment) session.getAttribute("comment")).getCommentNo();
//        if (sessionNo == comment.getCommentNo()) {
//            session.setAttribute("comment", comment);
//        }
//        return "redirect:/community/getComment?commentNo=" + comment.getCommentNo();
//    }

    @RequestMapping(value = "/deleteComment?commentNo={commentNo}", method = RequestMethod.GET)
    @ResponseBody
    public String deleteComment(@ModelAttribute("comment") Comment comment,@PathVariable("commentNo") int commentNo,@RequestParam(value = "postNo") int postNo, Model model, HttpSession session)
        throws Exception {

        System.out.println("/community/deleteComment : GET");

        commentNo = (int) session.getAttribute("commentNo");

        System.out.println("commentNo = " + commentNo);

        int commentPostNo = (int) session.getAttribute("postNo");

        System.out.println("commentPostNo = " + commentPostNo);

        comment.setCommentPostNo(commentPostNo);

        model.addAttribute(commentPostNo);

        communityService.deleteComment(comment);

        return "redirect:/community/getPost";
    }
}
