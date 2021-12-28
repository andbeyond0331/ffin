package com.ffin.web.community;

import com.ffin.common.Page;
import com.ffin.common.Search;
import com.ffin.service.community.CommunityService;
import com.ffin.service.domain.Post;
import com.ffin.service.domain.Truck;
import com.ffin.service.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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

    public CommunityController(){
        System.out.println(this.getClass());
    }

    @Value("#{commonProperties['pageUnit']}")
    int pageUnit;
    @Value("#{commonProperties['pageSize']}")
    int pageSize;

    @RequestMapping( value = "addPost", method = RequestMethod.GET)
    public String addPost() throws Exception    {
        System.out.println("/community/addPost : GET");

        return "/community/addPostView.jsp";
    }

    @RequestMapping( value = "addPost", method = RequestMethod.POST)
    public String addPost(@ModelAttribute("post") Post post, @ModelAttribute("truck") Truck truck, @ModelAttribute("user") User user, Model model,HttpSession session) throws Exception    {
        System.out.println("/community/addPost : POST");

        System.out.println(session.getAttribute("truckId"));

        String postUser = ((User)session.getAttribute("user")).getUserId();
        System.out.println(postUser);
        String postTruck = ((Truck)session.getAttribute("truck")).getTruckId();
        System.out.println(postTruck);
//        post.setPostUser("postUserId", postUser);
//        post.setPostTruck("postTruckId", postTruckId);
        communityService.addPost(post);

        return "/views/community/getPostList.jsp";
    }

    @RequestMapping( value = "getPost", method = RequestMethod.GET)
    public ModelAndView getPost(HttpServletRequest request, ModelAndView m) throws Exception{

        System.out.println("CommunityContoller.getPost : GET");
        int postNo = Integer.parseInt(request.getParameter("postNo"));

        System.out.println("postNo = " + postNo);
        Post post = communityService.getPost(postNo);
        System.out.println("post = "+post);
        m.addObject("post", post);
        m.setViewName("/community/getPost.jsp");

        return m;
    }

    @RequestMapping( value = "updatePost", method = RequestMethod.GET)
    public String updatePost(@ModelAttribute("postNo") int postNo, Model model, HttpSession httpSession) throws Exception{
        System.out.println("/community/updatePost : GET");
        //Business Logic
        Post post = communityService.getPost(postNo);
        //Model 과 View 연결
        model.addAttribute("post", post);

        return "forward:/community/updatePost.jsp";
    }

    @RequestMapping( value = "updatePost", method = RequestMethod.POST)
    public String updatePost(@ModelAttribute("post") Post post, Model model, HttpSession session) throws Exception{

        System.out.println("/community/updatePost : POST");
        //Business Logic
        communityService.updatePost(post);

        int sessionNo = ((Post)session.getAttribute("post")).getPostNo();
        if(sessionNo == post.getPostNo()){
            session.setAttribute("post", post);
        }
        return "redirect:/community/getPost?postNo="+post.getPostNo();
    }

    @RequestMapping( value = "getPostList")
    public String getPostList(@ModelAttribute("search")Search search, Model model, HttpServletRequest request) throws Exception{

        System.out.println("/community/getPostList : GET/POST");

        if(search.getCurrentPage() ==0 ){
            search.setCurrentPage(1);
        }
        search.setPageSize(pageSize);

        // Business Logic 수행
        Map<String, Object> map = communityService.getPostList(search);

        Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
        System.out.println(resultPage);

        //  Model 과 View 연결
        model.addAttribute("list", map.get("list"));
        model.addAttribute("resultPage", resultPage);
        model.addAttribute("search", search);

        return "forward:/community/getPostList.jsp";
    }
}
