package com.ffin.web.community;

import com.ffin.service.community.CommunityService;
import com.ffin.service.domain.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.awt.color.CMMException;
import java.util.ArrayList;
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

    // 댓글작성 메소드
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

//    @RequestMapping(value = "deleteComment", method = RequestMethod.GET)
//    @ResponseBody
//    public String deleteComment(@ModelAttribute("comment") Comment comment, @RequestParam("commentNo") int commentNo, Model model, HttpServletRequest request, HttpSession session)
//        throws Exception {
//
//        System.out.println("/community/deleteComment : GET");
//
//        commentNo = Integer.parseInt(request.getParameter("commentNo"));
//
//        System.out.println("commentNo = " + commentNo);
//
//        communityService.getComment(commentNo);
//
//        System.out.println("comment = " + comment);
//
//        int postNo = (int) session.getAttribute("postNo");
//
//        System.out.println("postNo = " + postNo);
//
//        communityService.deleteComment(comment);
//
//        return "forward:/community/getPost?postNo="+postNo;
//    }

    @RequestMapping(value = "getComment", method = RequestMethod.GET)
    @ResponseBody
    public Comment getComment(@RequestParam("commentNo") int commentNo) throws Exception {
        return communityService.getComment(commentNo);
    }









    /*
        HHJ
        좋아요 구현
     */


    //하트 ADD
    @RequestMapping(value = "json/addHeart")
    @ResponseBody
    public ModelAndView addHeart(@RequestParam int postNo, HttpSession session) throws Exception {

        Heart heart = new Heart();

        // 게시물 번호 세팅
        heart.setHeartTargetP(postNo);


        String role = (String)session.getAttribute("role");
        if (role == "user" || role.equals("user")){

            heart.setHeartUserId(((User) session.getAttribute("user")).getUserId());

        }else if(role == "truck" || role.equals("truck")){


            heart.setHeartTruckId(((Truck) session.getAttribute("truck")).getTruckId());
        }


        // +1된 하트 갯수를 담아오기위함
        int heartCount = communityService.addHeart(role, heart);
        System.out.println("heartCount: "+heartCount);

        ModelAndView mv = new ModelAndView("jsonView");
        mv.addObject("heartCount", heartCount);
        return mv;
    }

    // 하트 해제
    @RequestMapping(value = "json/removeHeart")
    @ResponseBody
    public ModelAndView removeHeart(@RequestParam int postNo, HttpSession session) throws Exception {

        Heart heart = new Heart();
        // 게시물 번호 세팅
        heart.setHeartTargetP(postNo);


        // -1된 하트 갯수를 담아오기위함

        String role = (String)session.getAttribute("role");
        if (role == "user" || role.equals("user")){

            heart.setHeartUserId(((User) session.getAttribute("user")).getUserId());

        }else if(role == "truck" || role.equals("truck")){


            heart.setHeartTruckId(((Truck) session.getAttribute("truck")).getTruckId());
        }



        int heartCount = communityService.removeHeart(role, heart);


        ModelAndView mv = new ModelAndView("jsonView");
        mv.addObject("heartCount", heartCount);
        return mv;
    }


    @RequestMapping(value = "json/getCardDetail/{postNo}", method = RequestMethod.GET)
    @ResponseBody
    public ModelAndView getCardDetail(@PathVariable("postNo") int postNo, HttpServletRequest request, HttpSession session) throws Exception {

        System.out.println("json/community/getCardDetail : GET");
        System.out.println("postNo = " + postNo);
        String role = (String)session.getAttribute("role");

        String id="";
        if (role == "user" || role.equals("user")){

           id = ((User) session.getAttribute("user")).getUserId();

        }else if(role == "truck" || role.equals("truck")){

            id = ((Truck) session.getAttribute("truck")).getTruckId();

        }

        communityService.updatePostHitUp(postNo);
        Post post = communityService.getCardDetail(id, role, postNo);


        ModelAndView mv = new ModelAndView("jsonView");
        mv.addObject("post", post);


        return mv;
    }



    // 댓글 리스트
    @ResponseBody
    @RequestMapping(value = "json/replyList")
    public ModelAndView reply_list(@RequestParam int postNo, HttpSession session) throws Exception {


        // 가져올 댓글 리스트의 게시물번호(postNo)
        String role = (String) session.getAttribute("role");
        ArrayList<Comment> replyList = new ArrayList();
        replyList = communityService.getreplyList(role, postNo);


        ModelAndView mv = new ModelAndView("jsonView");
        mv.addObject("replyList", replyList);
        return mv;
    }


    // 답글 작성
    @ResponseBody
    @RequestMapping(value = "json/write_rereply")
    public ModelAndView write_rereply(@RequestParam int commentNo, @RequestParam int commentPostNo , @RequestParam String commentContent,
                                   HttpSession session,  HttpServletRequest request) throws Exception {

        Comment to = new Comment();

        // 게시물 번호 세팅
        to.setCommentPostNo(commentPostNo);

        // grp, grps, grpl 은 ReplyTO에 int로 정의되어 있기 때문에 String인 no를 int로 변환해서 넣어준다.
        // 모댓글 번호 no를 grp으로 세팅한다.
        to.setGrp(commentNo);

        // 답글은 깊이가 1이되어야 하므로 grpl을 1로 세팅한다.
        to.setGrpl(1);
        commentContent = new String(request.getParameter("commentContent").getBytes("8859_1"),"UTF-8");
        // 답글 내용 세팅
        to.setCommentContent(commentContent);

        String role = (String) session.getAttribute("role");
        if (role =="user"){
            to.setCommentUserId(((User)session.getAttribute("user")).getUserId());
        }else if (role =="truck"){
            to.setCommentTruckId(((Truck)session.getAttribute("truck")).getTruckId());
        }
        // 답글작성자 nick을 writer로 세팅


        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.");
        System.out.println("role = " + role);
        System.out.println("to = " + to);
        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.");

        // +1된 댓글 갯수를 담아오기 위함
        int replyCount = communityService.writeReReply(role, to);


        ModelAndView mv = new ModelAndView("jsonView");
        mv.addObject("replyCount", replyCount);
        return mv;

    }

    // 모댓글 삭제
    @ResponseBody
    @RequestMapping(value = "json/delete_reply")
    public ModelAndView picture_delete_reply(@RequestParam int commentNo, @RequestParam int commentPostNo ) throws Exception {


        Comment to = new Comment();

        // 모댓글 번호 세팅
        to.setCommentNo(commentNo);

        // 게시물 번호 세팅
        to.setCommentPostNo(commentPostNo);

        // 갱신된 댓글 갯수를 담아오기 위함
        int replyCount = communityService.deleteReply(to);


        ModelAndView mv = new ModelAndView("jsonView");
        mv.addObject("replyCount", replyCount);
        return mv;

    }


    // 답글 삭제
    @ResponseBody
    @RequestMapping(value = "json/delete_rereply")
    public ModelAndView delete_rereply(@RequestParam int commentNo, @RequestParam int commentPostNo, @RequestParam int grp) throws Exception {

        System.out.println("commentNo = " + commentNo + ", commentPostNo = " + commentPostNo + ", grp = " + grp);
        Comment to = new Comment();

        // 답글 번호 세팅 - 답글 삭제하기 위해서 필요함
        to.setCommentNo(commentNo);

        // 게시물 번호 세팅
        to.setCommentPostNo(commentPostNo);
        // 게시물 번호 세팅 - p_board 의 reply+1하기 위해 필요함


        // grp 세팅(모댓글이 뭔지) - 모댓글은 삭제를 해도 답글이 있으면 남아있게 되는데 답글이 모두 삭제되었을 때 모댓글도 삭제하기 위해
        // 필요함
        to.setGrp(grp);

        // 갱신된 댓글 갯수를 담아오기 위함
        int replyCount = communityService.deleteReReply(to);
        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");

        ModelAndView mv = new ModelAndView("jsonView");
        mv.addObject("replyCount", replyCount);
        return mv;

    }

    @ResponseBody
    @RequestMapping(value = "json/write_reply")
    public ModelAndView write_reply(@RequestParam int postNo, @RequestParam String commentContent, HttpSession session, HttpServletRequest request) throws Exception {

        System.out.println("PostNo = " + postNo + ", commentContent = " + commentContent);
        Comment to = new Comment();

        // 게시물 번호 세팅
        to.setCommentPostNo(postNo);
       commentContent = new String(request.getParameter("commentContent").getBytes("8859_1"),"UTF-8");
        // 댓글 내용 세팅
        to.setCommentContent(commentContent);

        // 댓글작성자 nick을 writer로 세팅
        String role = (String) session.getAttribute("role");
        if (role =="user"){
            to.setCommentUserId(((User)session.getAttribute("user")).getUserId());
        }else if (role =="truck"){
            to.setCommentTruckId(((Truck)session.getAttribute("truck")).getTruckId());
        }

        // +1된 댓글 갯수를 담아오기 위함
        int replyCount= communityService.writeReply(role, to);


        ModelAndView mv = new ModelAndView("jsonView");
        mv.addObject("replyCount", replyCount);
        return mv;

    }

    @ResponseBody
    @RequestMapping(value = "json/deletePostPic", method = RequestMethod.GET)
    public String deletePostPic(@RequestParam("postNo") int postNo, HttpServletRequest request, HttpSession session)
            throws Exception {

        System.out.println("json/community/deletePostPic : GET");

        System.out.println("postNo = " + postNo);
        Post post = new Post();
        post.setPostNo(postNo);
        communityService.deletePost(post);

        return "y";
    }


    @RequestMapping(value = "json/getPostPic", method = RequestMethod.GET)
    @ResponseBody
    public ModelAndView getPostPic(@RequestParam("postNo") int postNo, HttpServletRequest request, HttpSession session) throws Exception {

        System.out.println("/community/json/getPostPic : GET");

        Post post = communityService.getPost(postNo);
        ModelAndView mv = new ModelAndView("jsonView");
        mv.addObject("post", post);



        return mv;
    }



}
