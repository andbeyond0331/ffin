package com.ffin.web.community;

import com.ffin.service.community.CommunityService;
import com.ffin.service.community.impl.CommunityServiceImpl;
import com.ffin.service.domain.Comment;
import com.ffin.service.domain.Truck;
import com.ffin.service.domain.User;
import com.ffin.service.truck.TruckService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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
    @RequestMapping(value = "getCommentList", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView getCommentList(@RequestParam("commentPostNo") int commentPostNo, HttpServletRequest request, ModelAndView m) throws Exception{

        System.out.println("/community/getCommentList : POST");
        commentPostNo = Integer.parseInt(request.getParameter("commentPostNo"));
        System.out.println("commentPostNo = " + commentPostNo);

        List<Comment> list = (List<Comment>) communityService.getCommentList(commentPostNo); //댓글 목록
        m.setViewName("/community/getCommenList.jsp"); //뷰의 이름
        m.addObject("list", list); //뷰에 전달할 데이터 저장

        return m; //뷰로 이동
    }

    //댓글 목록을 ArrayList로 리턴
    @RequestMapping(value = "json/getCommentList", method = RequestMethod.GET)
    @ResponseBody
    public List<Comment> list_json(@RequestParam("commentPostNo") int commentPostNo) throws Exception {
        return (List<Comment>) communityService.getCommentList(commentPostNo);
    }

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
}
