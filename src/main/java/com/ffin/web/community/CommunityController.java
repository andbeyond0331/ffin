package com.ffin.web.community;

import com.ffin.common.Page;
import com.ffin.common.Search;
import com.ffin.service.community.CommunityService;
import com.ffin.service.domain.*;
import com.ffin.service.truck.TruckService;
import com.ffin.service.user.UserDao;
import com.ffin.service.user.UserService;
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
    private UserService userService;
    private TruckService truckService;
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

        communityService.updatePostHitUp(postNo); // 조회수 증가 추가

        /* HHJ 추가 */
        String role = (String)session.getAttribute("role");

        String id="";
        if (role == "user" || role.equals("user")){

            id = ((User) session.getAttribute("user")).getUserId();

        }else if(role == "truck" || role.equals("truck")){

            id = ((Truck) session.getAttribute("truck")).getTruckId();

        }

        Post post = communityService.getCardDetail(id, role, postNo);

       // Post post = communityService.getPost(postNo);
       //Post post = communityService.getCardDetail(id, role, postNo);

        System.out.println("post = " + post);
        try {
            if (post.getPostUser() != null) {
                User user = (User) userService.getUser(post.getPostUser().getUserId());
                String postUserProImg = user.getUserProImg();
                System.out.println("postUserProImg = " + postUserProImg);
                //session.setAttribute("userProImg", postUserProImg);
               // System.out.println("session에 담긴 postUserProImg = " + postUserProImg);
                post.setUserProImg(postUserProImg);
            } else if (post.getPostTruck() != null) {
                Truck truck = (Truck) truckService.getTruck(post.getPostTruck().getTruckId());
                String postTruckProImg = truck.getTruckProImg();
                //session.setAttribute("truckProImg", postTruckProImg);
                //System.out.println("postTruckProImg = " + postTruckProImg);
                //System.out.println("session에 담긴 postTruckProImg = " + postTruckProImg);
                post.setTruckProImg(postTruckProImg);
            }
        }catch (Exception e){
            e.printStackTrace();
            System.out.println("예외처리");
        }
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
    public String updatePost(@ModelAttribute("post") Post post,@RequestParam("file1") MultipartFile file1,@RequestParam("file2") MultipartFile file2,@RequestParam("file3") MultipartFile file3, Model model, HttpServletRequest request, HttpSession session) throws Exception {

        System.out.println("/community/updatePost : POST");
        //Business Logic
        int postNo = (int) session.getAttribute("postNo");

        System.out.println("postNo = " + postNo);

        post = (Post) model.getAttribute("post");

        post.setPostNo(postNo);

        System.out.println("post = " + post);

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

        communityService.updatePost(post);

        communityService.getPost(postNo);

        return "redirect:/community/getPost?postNo="+postNo;
    }

    @RequestMapping(value = "blindPost", method = RequestMethod.GET)
    public String blindPost(@ModelAttribute("post") Post post, Model model, HttpSession session) throws Exception {

        System.out.println("/community/blindPost : GET");
        //Business Logic
        int postNo = (int) session.getAttribute("postNo");

        System.out.println("postNo = " + postNo);

        post = (Post) model.getAttribute("post");

        post.setPostNo(postNo);

        System.out.println("post = " + post);

        communityService.blindPost(post);

        communityService.getPost(postNo);

        return "redirect:/community/getPost?postNo="+postNo;
    }

    @RequestMapping(value = "seePost", method = RequestMethod.GET)
    public String seePost(@ModelAttribute("post") Post post, Model model, HttpSession session) throws Exception {

        System.out.println("/community/seePost : GET");
        //Business Logic
        int postNo = (int) session.getAttribute("postNo");

        System.out.println("postNo = " + postNo);

        post = (Post) model.getAttribute("post");

        post.setPostNo(postNo);
        post.setSecretKey(0);

        System.out.println("post = " + post);

        communityService.seePost(post);

        communityService.getPost(postNo);

        return "redirect:/community/getPost?postNo="+postNo;
    }

    // 댓글 비공개처리
    @RequestMapping(value = "blindComment", method = RequestMethod.GET)
    public String blindComment(@ModelAttribute("comment") Comment comment, @RequestParam("commentNo") int commentNo, HttpSession session, HttpServletRequest request) throws Exception {

        System.out.println("/community/blindComment : GET");

        int postNo = (int) session.getAttribute("postNo");

        System.out.println("postNo = " + postNo);

        comment = communityService.getComment(commentNo);

        communityService.blindComment(comment);

        return "redirect:/community/getPost?postNo="+postNo;
    }

    @RequestMapping(value = "seeComment", method = RequestMethod.GET)
    public String seeComment(@ModelAttribute("comment") Comment comment,@RequestParam("commentNo") int commentNo, Model model, HttpSession session) throws Exception {

        System.out.println("/community/seeComment : GET");
        //Business Logic
        int postNo = (int) session.getAttribute("postNo");

        System.out.println("postNo = " + postNo);

        comment = communityService.getComment(commentNo);

        communityService.seeComment(comment);

        return "redirect:/community/getPost?postNo="+postNo;
    }

    @RequestMapping(value = "getPostList")
    public String getPostList(@ModelAttribute("search") Search search, Model model, HttpServletRequest request, HttpSession session) throws Exception {

        System.out.println("/community/getPostList : GET/POST");
        pageSize = 9;
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

    // 게시물 삭제
    @RequestMapping(value = "deletePost", method = RequestMethod.GET)
    public String deletePost(@ModelAttribute("post") Post post, @RequestParam("postNo") int postNo, Model model, HttpServletRequest request, HttpSession session)
            throws Exception {

        System.out.println("/community/deletePost : GET");

        postNo = (int) session.getAttribute("postNo");

        System.out.println("postNo = " + postNo);

        communityService.deletePost(post);

        return "redirect:/community/getPostList";
    }







    /* HHJ */

    @RequestMapping(value = "getPostList2")
    public String getPostList2(@ModelAttribute("search") Search search, Model model, HttpServletRequest request, HttpSession session) throws Exception {


        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.");
        //t currentPage = (int) session.getAttribute("currentPage");
        //search.setCurrentPage(currentPage);

        //System.out.println("::::::::::::::::::::::::::::::::currentPage = " + currentPage);
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

        String cate = "p"; //게시판 구분

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


    @RequestMapping(value="addPostPic", method=RequestMethod.POST)
    public String addPostPic(@RequestParam("postFile11")MultipartFile file1,
                          @RequestParam(value="postFile22", required = false)MultipartFile file2,
                          @RequestParam(value="postFile33", required = false)MultipartFile file3,
                          HttpServletRequest request,
                          @ModelAttribute("post") Post post,
                          @RequestParam("postContent") String postContent, HttpSession session
    ) throws Exception{


        System.out.println("/community/addPostPic:POST");

        System.out.println("request = " + request + ", post = " + post + ", postContent = " + postContent);

        String role = (String) session.getAttribute("role");
        if (role == "user"){
            User user = new User();
            user.setUserId( ((User)(session.getAttribute("user"))).getUserId());
            post.setPostUser(user);
        }else if (role == "truck"){
            Truck truck = new Truck();
            truck.setTruckId( ((Truck)(session.getAttribute("truck"))).getTruckId());
            post.setPostTruck(truck);
        }
        String realPath = request.getSession().getServletContext().getRealPath("/resources/image");
//        String realPath = "/resources/menu";

        String postFile1  = file1.getOriginalFilename();
        String postFile2  = file2.getOriginalFilename();
        String postFile3  = file3.getOriginalFilename();

//        String root_path = request.getSession().getServletContext().getRealPath("/");
        System.out.println("/////////realPath : " + realPath);

        if(!file1.getOriginalFilename().isEmpty()){
            file1.transferTo(new File(realPath, postFile1));
//            model.addAttribute("msg", "File uploaded successfully.");
//            model.addAttribute("menuImg1", menuImg1);
        }

        post.setPostFile1(file1.getOriginalFilename());


        if(!file2.getOriginalFilename().isEmpty()){
            file2.transferTo(new File(realPath, postFile2));
//            model.addAttribute("msg", "File uploaded successfully.");
//            model.addAttribute("menuImg2", menuImg2);
//        }else {
//            model.addAttribute("msg", "Please select a valid mediaFile..");
        }
        post.setPostFile2(file2.getOriginalFilename());
//
        if(!file3.getOriginalFilename().isEmpty()){
            file3.transferTo(new File(realPath, postFile3));
//            model.addAttribute("msg", "File uploaded successfully.");
//            model.addAttribute("menuImg3", menuImg3);
//        }else {
//            model.addAttribute("msg", "Please select a valid mediaFile..");
        }
        post.setPostFile3(file3.getOriginalFilename());

        communityService.addPostPic(post);



        return "redirect:/community/getPostList2";

    }


    @RequestMapping(value="updatePostPic", method=RequestMethod.POST)
    public String updatePostPic(@RequestParam("postFile111")MultipartFile file1,
                             @RequestParam(value="postFile222", required = false)MultipartFile file2,
                             @RequestParam(value="postFile333", required = false)MultipartFile file3,
                             HttpServletRequest request,
                             @ModelAttribute("post") Post post,
                             @RequestParam("postContent") String postContent, HttpSession session
    ) throws Exception{


        System.out.println("/community/updatePostPic:POST");

        System.out.println("request = " + request + ", post = " + post + ", postContent = " + postContent);


        String realPath = request.getSession().getServletContext().getRealPath("/resources/image");
//        String realPath = "/resources/menu";

        String postFile1  = file1.getOriginalFilename();
        String postFile2  = file2.getOriginalFilename();
        String postFile3  = file3.getOriginalFilename();


//        String root_path = request.getSession().getServletContext().getRealPath("/");
        System.out.println("/////////realPath : " + realPath);

        if(!file1.getOriginalFilename().isEmpty()){
            file1.transferTo(new File(realPath, postFile1));
//            model.addAttribute("msg", "File uploaded successfully.");
//            model.addAttribute("menuImg1", menuImg1);
        }

        post.setPostFile1(file1.getOriginalFilename());


        if(!file2.getOriginalFilename().isEmpty()){
            file2.transferTo(new File(realPath, postFile2));
//            model.addAttribute("msg", "File uploaded successfully.");
//            model.addAttribute("menuImg2", menuImg2);
//        }else {
//            model.addAttribute("msg", "Please select a valid mediaFile..");
        }
        post.setPostFile2(file2.getOriginalFilename());
//
        if(!file3.getOriginalFilename().isEmpty()){
            file3.transferTo(new File(realPath, postFile3));
//            model.addAttribute("msg", "File uploaded successfully.");
//            model.addAttribute("menuImg3", menuImg3);
//        }else {
//            model.addAttribute("msg", "Please select a valid mediaFile..");
        }
        post.setPostFile3(file3.getOriginalFilename());

        communityService.updatePostPic(post);



        return "redirect:/community/getPostList2";

    }




}
