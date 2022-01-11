package com.ffin.web.community;

import com.ffin.common.Page;
import com.ffin.common.Search;
import com.ffin.service.community.CommunityService;
import com.ffin.service.domain.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.List;
import java.util.Map;

// 소통관리 Controller
@Controller
@RequestMapping("/community/*")
public class CommunityController {

    ///Filed
    @Autowired
    @Qualifier("communityServiceImpl")
    private CommunityService communityService;
    //setter Method 구현않음

    public CommunityController() {
        System.out.println(this.getClass());
    }

    @Value("#{commonProperties['pageUnit']}")
    int pageUnit;
    @Value("#{commonProperties['pageSize']}")
    int pageSize;


    ///////////////////// 게시물 관련 메소드 ////////////////////////
    // 게시물 작성 화면 요청
    @RequestMapping(value = "addPost", method = RequestMethod.GET)
    public String addPost() throws Exception {

        System.out.println("/community/addPost : GET");

        return "/views/community/addPostView.jsp";
    }

    @RequestMapping(value = "addPost", method = RequestMethod.POST)
    public String addPost(@ModelAttribute("post") Post post, @RequestParam("file1") MultipartFile file1,@RequestParam("file2") MultipartFile file2,@RequestParam("file3") MultipartFile file3, HttpSession session, HttpServletRequest request) throws Exception {

        System.out.println("/community/addPost : POST");

        String role =(String) session.getAttribute("role");

        System.out.println("role = " + role);

        User postUser = null;
        Truck postTruck = null;

        if (role.equals("user")) {
            postUser = (User) session.getAttribute("user");
            System.out.println("게시물 작성자(user) : " + postUser);
            post.setPostUser(postUser);
        } else if (role.equals("truck")) {
            postTruck = (Truck) session.getAttribute("truck");
            System.out.println("게시물 작성자(truck) : " + postTruck);
            post.setPostTruck(postTruck);
        }

        //String temDir = "../../resources/image";
        String temDir = request.getSession().getServletContext().getRealPath("/resources/image");
        System.out.println("temDir = " + temDir);

        if (!file1.getOriginalFilename().isEmpty()) {
            file1.transferTo(new File(temDir, file1.getOriginalFilename()));
        }
        if (!file2.getOriginalFilename().isEmpty()) {
            file2.transferTo(new File(temDir, file2.getOriginalFilename()));
        }
        if (!file3.getOriginalFilename().isEmpty()) {
            file3.transferTo(new File(temDir, file3.getOriginalFilename()));
        }

        post.setPostFile1(file1.getOriginalFilename());
        post.setPostFile2(file2.getOriginalFilename());
        post.setPostFile3(file3.getOriginalFilename());

        communityService.addPost(post);

        //model.addAttribute("post", post);


        return "redirect:/community/getPostList";
    }

    @RequestMapping(value = "getPost", method = RequestMethod.GET)
    public ModelAndView getPost(@RequestParam("postNo") int postNo, HttpServletRequest request, ModelAndView m, HttpSession session) throws Exception {

        System.out.println("/community/getPost : GET");
        postNo = Integer.parseInt(request.getParameter("postNo"));
        System.out.println("postNo = " + postNo);

        Post post = communityService.getPost(postNo);
        System.out.println("post = " + post);

        session.setAttribute("postNo", postNo);

        System.out.println("session에 담긴 postNo = " +session.getAttribute("postNo"));

        List<Comment> list = communityService.getCommentList(postNo);
        System.out.println("list = " + list);

        m.addObject("post", post);
        m.addObject("list", list);

        m.setViewName("/views/community/getPost.jsp");

        return m;
    }

    @RequestMapping(value = "updatePost", method = RequestMethod.GET)
    public String updatePost(@ModelAttribute("postNo") int postNo, Model model, HttpSession session) throws Exception {

        System.out.println("/community/updatePost : GET");
        //Business Logic
        postNo = (int) session.getAttribute("postNo");

        System.out.println("postNo = " + postNo);

        Post post = communityService.getPost(postNo);

        //Model 과 View 연결
        model.addAttribute("post", post);

        return "/views/community/updatePostView.jsp";
    }

    @RequestMapping(value = "updatePost", method = RequestMethod.POST)
    public String updatePost(@ModelAttribute("post") Post post, Model model, HttpSession session) throws Exception {

        System.out.println("/community/updatePost : POST");
        //Business Logic
        int postNo = (int) session.getAttribute("postNo");

        System.out.println("postNo = " + postNo);

        post = (Post) model.getAttribute("post");

        post.setPostNo(postNo);

        System.out.println("post = " + post);

        communityService.updatePost(post);

        communityService.getPost(postNo);

        return "redirect:/community/getPost?postNo="+postNo;
    }

    @RequestMapping(value = "getPostList")
    public String getPostList(@ModelAttribute("search") Search search, Model model, HttpServletRequest request, HttpSession session) throws Exception {

        System.out.println("/community/getPostList : GET/POST");

        if (search.getCurrentPage() == 0) {
            search.setCurrentPage(1);
        }
        search.setPageSize(pageSize);

        // Business Logic 수행
        Map<String, Object> map = communityService.getPostList(search);

            Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
            System.out.println(resultPage);
            //  Model 과 View 연결
            model.addAttribute("list", map.get("list"));
            model.addAttribute("resultPage", resultPage);
            model.addAttribute("search", search);

            return "forward:/views/community/getPostList.jsp";

    }

//    @RequestMapping(value = "getComment", method = RequestMethod.GET)
//    public ModelAndView getComment(HttpServletRequest request, ModelAndView m) throws Exception {
//
//        System.out.println("/community/getComment : GET");
//        int commentNo = Integer.parseInt(request.getParameter("commentNo"));
//        System.out.println("commentNo = " + commentNo);
//
//        Comment comment = communityService.getComment(commentNo);
//        System.out.println("comment = " + comment);
//
//        m.addObject("comment", comment);
//        m.setViewName("/community/getComment");
//
//        return m;
//    }

    @RequestMapping(value = "updateComment", method = RequestMethod.GET)
    public String updateComment(@ModelAttribute("commentNo") int commentNo, Model model, HttpSession httpSession) throws Exception {
        System.out.println("/community/updateComment : GET");
        //Business Logic
        Comment comment = communityService.getComment(commentNo);
        //Model 과 View 연결
        model.addAttribute("comment", comment);

        return "forward:/community/updateComment.jsp";
    }

    @RequestMapping(value = "updateComment", method = RequestMethod.POST)
    public String updateComment(@ModelAttribute("comment") Comment comment, Model model, HttpSession session) throws Exception {

        System.out.println("/community/updateComment : POST");
        //Business Logic
        communityService.updateComment(comment);

        return "redirect:/community/getPost?postNo=" + comment.getCommentPostNo();
    }


    ////////////////////// 좋아요 관련 메소드 ////////////////////////////
   /* @RequestMapping(value = "addHeart", method = RequestMethod.GET)
    public String addHeart() throws Exception {
        System.out.println("/community/addHeart : GET");

        return "/community/getHeart.jsp";
    }

    @RequestMapping(value = "addHeart", method = RequestMethod.POST)
    public String addHeart(@ModelAttribute("heart") Heart heart, @ModelAttribute("truck") Truck truck, @ModelAttribute("user") User user, Model model, HttpSession session) throws Exception {
        System.out.println("/community/addHeart : POST");

        if (session.getAttribute("role").equals("user")) {
            String heartUser = ((User) session.getAttribute("user")).getUserId();
            System.out.println("좋아요 누른사람(user) : " + session.getAttribute("userId"));
            heart.setHeartUserId(heartUser);
        }
        communityService.addHeart(heart);

        return "/views/community/getHeart.jsp";
    }

    @RequestMapping(value = "getHeart", method = RequestMethod.GET)
    public ModelAndView getHeart(HttpServletRequest request, ModelAndView m) throws Exception {

        System.out.println("CommunityContoller.getHeart : GET");
        int heartNo = Integer.parseInt(request.getParameter("heartNo"));

        System.out.println("commentNo = " + heartNo);
        Heart heart = communityService.getHeart(heartNo);
        System.out.println("heart = " + heart);
        m.addObject("heart", heart);
        m.setViewName("/community/getHeart.jsp");

        return m;
    }


    @RequestMapping(value = "updateHeart", method = RequestMethod.GET)
    public String updateHeart(@ModelAttribute("heartNo") int heartNo, Model model, HttpSession httpSession) throws Exception {
        System.out.println("/community/updateHeart : GET");
        //Business Logic
        Heart heart = communityService.getHeart(heartNo);
        //Model 과 View 연결
        model.addAttribute("heart", heart);

        return "forward:/community/updateHeart.jsp";
    }

    @RequestMapping(value = "updateHeart", method = RequestMethod.POST)
    public String updateHeart(@ModelAttribute("heart") Heart heart, Model model, HttpSession session) throws Exception {

        System.out.println("/community/updateHeart : POST");
        //Business Logic
        communityService.updateHeart(heart);

        int sessionNo = ((Heart) session.getAttribute("heart")).getHeartNo();
        if (sessionNo == heart.getHeartNo()) {
            session.setAttribute("heart", heart);
        }
        return "redirect:/community/getHeart?heartNo=" + heart.getHeartNo();
    }

    @RequestMapping(value = "getHeartList")
    public String getHeartList(@ModelAttribute("search") Search search, Model model, HttpServletRequest request) throws Exception {

        System.out.println("/community/getHeartList : GET/POST");

        if (search.getCurrentPage() == 0) {
            search.setCurrentPage(1);
        }
        search.setPageSize(pageSize);

        // Business Logic 수행
        Map<String, Object> map = communityService.getHeartList(search);

        Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
        System.out.println(resultPage);

        //  Model 과 View 연결
        model.addAttribute("list", map.get("list"));
        model.addAttribute("resultPage", resultPage);
        model.addAttribute("search", search);

        return "forward:/community/getHeartList.jsp";
    }

    @RequestMapping(value = "deletePost", method = RequestMethod.GET)
    public String deletePost(@ModelAttribute("post") Post post, @RequestParam("postNo") int postNo, Model model, HttpServletRequest request, HttpSession session)
            throws Exception {

        System.out.println("/community/deletePost : GET");

        postNo = (int) session.getAttribute("postNo");

        System.out.println("postNo = " + postNo);

        communityService.deletePost(post);

        return "redirect:/community/getPostList";
    }


    @RequestMapping(value = "deleteComment", method = RequestMethod.GET)
    public String deleteComment(@ModelAttribute("comment") Comment comment, @RequestParam("commentNo") int commentNo, Model model, HttpServletRequest request, HttpSession session)
            throws Exception {

        System.out.println("/community/deleteComment : GET");

        commentNo = Integer.parseInt(request.getParameter("commentNo"));

        System.out.println("commentNo = " + commentNo);

        communityService.getComment(commentNo);

        System.out.println("comment = " + comment);

        int postNo = (int) session.getAttribute("postNo");

        System.out.println("postNo = " + postNo);

        communityService.deleteComment(comment);

        return "redirect:/community/getPost?postNo="+postNo;
    }
*/


    /* HHJ */

    @RequestMapping(value = "getPostList2")
    public String getPostList2(@ModelAttribute("search") Search search, Model model, HttpServletRequest request, HttpSession session) throws Exception {



        /*
            if (role == user)  일 때와 아닐 때를 구분하여야 하므로
            getPostList에 role을 추가해서 구현하는게 좋을 것 같음.
            그러면 user / truck별 리스트가 따로 출력되므로.

            그리고 return값을 다르게 주는 것으로~~

         */
        System.out.println("/community/getPostList2 : GET/POST");

        if (search.getCurrentPage() == 0) {
            search.setCurrentPage(1);
        }
        search.setPageSize(pageSize);

        String role = (String)session.getAttribute("role");
        String id= "";
        if (role == "user" || role.equals("user")){

            id =((User) session.getAttribute("user")).getUserId();

        }else if(role == "truck" || role.equals("truck")){

            id = ((Truck)session.getAttribute("truck")).getTruckId();

        }

        // Business Logic 수행
        Map<String, Object> map = communityService.getPostList2(search, id, role);


        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");

        System.out.println("list::::::::::::::::::::::::::::::" + map.get("list"));
        Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
        System.out.println(resultPage);
        //  Model 과 View 연결
        model.addAttribute("list", map.get("list"));
        model.addAttribute("resultPage", resultPage);
        model.addAttribute("search", search);

        return "forward:/views/community/getPostListTruck.jsp";

    }






}
