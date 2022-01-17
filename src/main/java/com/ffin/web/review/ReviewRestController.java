package com.ffin.web.review;

import com.ffin.common.Search;
import com.ffin.service.domain.Inquiry;
import com.ffin.service.domain.Menu;
import com.ffin.service.domain.Purchase;
import com.ffin.service.domain.Review;
import com.ffin.service.purchase.PurchaseService;
import com.ffin.service.review.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/review/*")
public class ReviewRestController {

    ///FFF
    @Autowired
    @Qualifier("reviewServiceImpl")
    private ReviewService reviewService;

    @Autowired
    @Qualifier("purchaseServiceImpl")
    private PurchaseService purchaseService;

    public ReviewRestController(){
        System.out.println(this.getClass());
    }

    @Value("${pageUnit}") //pageUnit은 propertySource를 위에 선언하고 @value의 값을 지정해줌
    //추후 pageUnit과 pageSize 출력되는지 jUnit에서 확인이 필요합니다.
    //@Value("#{commonProperties['pageUnit'] ?: 3}")
    int pageUnit;

    @Value("${pageSize}")
    int pageSize;

    @RequestMapping(value="json/getReviewList/{truckId}", method= RequestMethod.GET)
    @ResponseBody
    public ModelAndView getReviewList(@PathVariable("truckId")String truckId, HttpServletRequest request, HttpServletResponse response) throws Exception{
        /*
            모달에서 리뷰 목록 보낼 준비!
         */
        request.setCharacterEncoding("utf-8");

        System.out.println("ReviewController.REST - getReviewList");
        System.out.println("truckId = " + truckId + ", request = " + request + ", response = " + response);

        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(100);
        Map<String, Object> map = new HashMap<String, Object>();

        map = reviewService.getReviewListTruck(search,truckId);
        System.out.println("review list : " + map.get("list"));

        List reviewList = new ArrayList();
        reviewList = (List) map.get("list");
        ModelAndView mv = new ModelAndView("jsonView");
        mv.addObject("review", reviewList);




        return mv;
    }


    @RequestMapping(value="json/getReviewDetail/{rvNo}", method=RequestMethod.GET)
    @ResponseBody
    public ModelAndView getReviewDetail(@PathVariable("rvNo")int rvNo, HttpServletRequest request, HttpServletResponse response) throws Exception{
        /*
            리뷰 상세정보 조회 ! orderDetail도 뿌려주기~
         */
        request.setCharacterEncoding("utf-8");

        System.out.println("ReviewController.REST");
        System.out.println("rvNo = " + rvNo);

        Review review = reviewService.getReview(rvNo);
        System.out.println("rest.getReviewDetail.review : " + review);

//        Purchase purchase = purchaseService.getPurchase(review.getRvOrderNo());

        Map orderDetail = purchaseService.getOrderDetail(review.getRvOrderNo());
        System.out.println("orderDetail = " + orderDetail);

        ModelAndView mv = new ModelAndView("jsonView");
        mv.addObject("review", review);
        mv.addObject("orderDetail", orderDetail);




        return mv;
    }


    //트럭 마이페이지에서 리뷰 목록 중 사장님 댓글 작성 post
    @RequestMapping(value = "json/updateRvForAddTruckCmt", method = RequestMethod.POST)
    @ResponseBody
    public Review updateRvForAddTruckCmt(@ModelAttribute Review review, @RequestParam("rvNo") int rvNo) throws Exception {

        System.out.println("ReviewRestController.updateRvForAddTruckCmt : POST");

        reviewService.updateRVAddTruckComment(review);
        return reviewService.getReview(rvNo);
    }

    //트럭 마이페이지에서 리뷰 목록 중 사장님 댓글 수정 post
    @RequestMapping(value = "json/updateRvForUpdateTruckCmt", method = RequestMethod.POST)
    @ResponseBody
    public Review updateRvForUpdateTruckCmt(@ModelAttribute Review review, @RequestParam("rvNo") int rvNo) throws Exception {

        System.out.println("ReviewRestController.updateRvForAddTruckCmt : POST");

        reviewService.updateRVUpdateTruckComment(review);
        return reviewService.getReview(rvNo);
    }





}
