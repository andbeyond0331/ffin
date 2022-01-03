package com.ffin.web.review;

import com.ffin.common.Page;
import com.ffin.common.Search;
import com.ffin.service.domain.*;
import com.ffin.service.purchase.PurchaseService;
import com.ffin.service.review.ReviewService;
import com.ffin.service.truck.TruckService;
import com.ffin.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

// 리뷰 관리 Controller
@Controller
@RequestMapping("/review/*")
public class ReviewController {

    ///FFF
    @Autowired
    @Qualifier("reviewServiceImpl")
    private ReviewService reviewService;

    @Autowired
    @Qualifier("purchaseServiceImpl")
    private PurchaseService purchaseService;

    @Autowired
    @Qualifier("truckServiceImpl")
    private TruckService truckService;

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    @Value("100") //pageUnit은 propertySource를 위에 선언하고 @value의 값을 지정해줌
    //추후 pageUnit과 pageSize 출력되는지 jUnit에서 확인이 필요합니다.
    //@Value("#{commonProperties['pageUnit'] ?: 3}")
    int pageUnit;

    @Value("100")
    int pageSize;

    @RequestMapping(value = "addReview", method= RequestMethod.GET)
    public ModelAndView addReview(@RequestParam("orderNo") int orderNo) throws Exception{

        /*
            이용자가 리뷰를 등록하기 위해 사용하는 화면
            orderNo로 이용자의 주문 정보를 화면에 뿌려주고, 추가할 리뷰 정보를 받는다.
         */
        System.out.println("/review/addReview : GET");
        System.out.println("orderNo : " + orderNo);

        Purchase purchase = purchaseService.getPurchase(orderNo);

        Map orderDetail = purchaseService.getOrderDetail(orderNo);
        System.out.println("orderDetail Map : " + orderDetail);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("orderDetail", orderDetail);
        modelAndView.addObject("purchase",purchase);

        modelAndView.setViewName("/views/review/addReviewView.jsp");

        return modelAndView;
    }

    @RequestMapping(value="addReview", method=RequestMethod.POST)
    public String addReview(@ModelAttribute("rvOrderNo") int rvOrderNo, @ModelAttribute("review") Review review, Model model) throws Exception{

        System.out.println("/review/addReview:POST");
        System.out.println("rvOrderNo = " + rvOrderNo + ", review = " + review + ", model = " + model);

        Purchase purchase = purchaseService.getPurchase(rvOrderNo);


        review.setRvOrderNo(rvOrderNo);
        review.setRvTruckId(purchase.getOrderTruckId().getTruckId());
        review.setRvUserId(purchase.getOrderUserId().getUserId());

        reviewService.addReview(review);

        model.addAttribute("review", review);

        return "redirect:/views/menu/getMenu.jsp"; //송화님&진석님과 얘기해보기


    }

    @RequestMapping(value="updateReview", method=RequestMethod.GET)
    public ModelAndView updateReview(HttpServletRequest request, ModelAndView modelAndView) throws Exception{

        System.out.println("/review/updateReview : GET");

        //Business Logic

        String rvNoo = request.getParameter("rvNo");

        int rvNo = Integer.parseInt(rvNoo);

        Review review = reviewService.getReview(rvNo);

        //Model - View 연결
        modelAndView.addObject("review", review);
        modelAndView.setViewName("/views/review/updateReviewView.jsp");

        System.out.println("request = " + request + ", modelAndView = " + modelAndView);

        return modelAndView;
    }

    @RequestMapping(value="updateReview", method=RequestMethod.POST)
    public String updateReview(@ModelAttribute("rvNo") int rvNo, @ModelAttribute("review") Review review, Model model) throws Exception{

        System.out.println("/review/updateReview:POST");
        System.out.println("rvNo = " + rvNo + ", review = " + review + ", model = " + model);

        review.setRvNo(rvNo);

        reviewService.updateReview(review);

        model.addAttribute("review", review);

        return "redirect:/views/review/addReviewView.jsp"; //송화님&진석님과 얘기해보기


    }


    @RequestMapping(value="updateRVAddTruckComment", method=RequestMethod.GET)
    public String updateRVAddTruckComment(@ModelAttribute("rvNo") int rvNo, Model model) throws Exception{
        System.out.println("rvNo = " + rvNo + ", model = " + model);

        Review review = reviewService.getReview(rvNo);

        int orderNo = review.getRvOrderNo();

        Purchase purchase = purchaseService.getPurchase(orderNo);

        User user  = purchase.getOrderUserId();

        String userId = user.getUserId();


        model.addAttribute("review", review);
        model.addAttribute("userId", userId);

        return "/views/review/updateRVAddTruckCommentView.jsp";
    }

    @RequestMapping(value="updateRVAddTruckComment", method=RequestMethod.POST)
    public String updateRVAddTruckComment(@ModelAttribute("rvNo") int rvNo, @ModelAttribute("review") Review review, Model model) throws Exception{

        System.out.println("/review/updateReview:POST");
        System.out.println("rvNo = " + rvNo + ", review = " + review + ", model = " + model);

        review.setRvNo(rvNo);

        reviewService.updateRVAddTruckComment(review);

        model.addAttribute("review", review);

        return "redirect:/views/review/updateReviewView.jsp"; //송화님&진석님과 얘기해보기


    }

    @RequestMapping(value="updateRVUpdateTruckComment", method=RequestMethod.GET)
    public String updateRVUpdateTruckComment(@ModelAttribute("rvNo") int rvNo, Model model) throws Exception{

        System.out.println("/review/updateRVUpdateTruckComment:GET");
        System.out.println("rvNo = " + rvNo + ", model = " + model);

        Review review = reviewService.getReview(rvNo);

        int orderNo = review.getRvOrderNo();

        Purchase purchase = purchaseService.getPurchase(orderNo);

        User user  = purchase.getOrderUserId();

        String userId = user.getUserId();


        model.addAttribute("review", review);
        model.addAttribute("userId", userId);

        return "/views/review/updateRVUpdateTruckCommentView.jsp";
    }

    //truckcommnet를 update하기 위한 update review
    @RequestMapping(value="updateRVUpdateTruckComment", method=RequestMethod.POST)
    public String updateRVUpdateTruckComment(@ModelAttribute("rvNo") int rvNo, @ModelAttribute("review") Review review, Model model) throws Exception{

        System.out.println("/review/updateRVUpdateTruckComment:POST");
        System.out.println("rvNo = " + rvNo + ", review = " + review + ", model = " + model);

        review.setRvNo(rvNo);

        reviewService.updateRVUpdateTruckComment(review);

        model.addAttribute("review", review);

        return "redirect:/views/review/updateReviewView.jsp"; //송화님&진석님과 얘기해보기


    }

    //truck에 의한 getReview List
    @RequestMapping("getReviewListTruck")
    public ModelAndView getReviewListTruck(@ModelAttribute("search") Search search, @RequestParam("truckId") String truckId,
                                    ModelAndView modelAndView) throws Exception{

        search.setPageSize(pageSize);

        Truck truck  = truckService.getTruck(truckId);
        float rvAvg = reviewService.getReviewAvg(search,truckId);

        Map<String , Object> map= reviewService.getReviewListTruck(search, truck.getTruckId());

        Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);

        modelAndView.addObject("resultPage", resultPage);
        modelAndView.addObject("list", map.get("list"));
        modelAndView.addObject("rvAvg", rvAvg);
        modelAndView.setViewName("/views/review/getReviewList.jsp");

        return modelAndView;
    }

    //user에 의한 getReviewList
    @RequestMapping("getReviewListUser")
    public ModelAndView getReviewListUser(@ModelAttribute("search") Search search, @RequestParam("userId") String userId,
                                    ModelAndView modelAndView) throws Exception{

        search.setPageSize(pageSize);
        User user  = userService.getUser(userId);

        Map<String , Object> map= reviewService.getReviewListTruck(search, user.getUserId());

        modelAndView.addObject("list", map.get("list"));
        modelAndView.setViewName("/views/review/getReviewList.jsp");

        return modelAndView;
    }



}
