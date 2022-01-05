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
import java.io.File;
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

    //FILE UPLOAD를 위한 FIELD 설정
    private static final String FILE_UPLOAD_PATH = "C:/CRUD/ffin/src/main/webapp/resources/image/";

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

//    @RequestMapping(value="addReviewER", method=RequestMethod.POST)
//    public String addReviewER(Model model) throws Exception{
    @RequestMapping(value = "addReviewER", method=RequestMethod.POST)
    public String addReviewER(@RequestParam("rvImg11")MultipartFile file1,
                              @RequestParam("rvImg22")MultipartFile file2,
                              @RequestParam("rvImg33")MultipartFile file3,
                              HttpServletRequest request,
                              @ModelAttribute("review") Review review, Model model) throws Exception{
        // TODO: 2022-01-05 truckId, userId 적용되도록! - 해결!
        // TODO: 2022-01-05 리뷰 이미지 추가 - 해결!

        System.out.println("/review/addReview:POST");
        System.out.println("review = " + review + ", model = " + model);

        String rvImg1  = file1.getOriginalFilename();
        String rvImg2  = file2.getOriginalFilename();
        String rvImg3  = file3.getOriginalFilename();

        if(!file1.getOriginalFilename().isEmpty()){
            file1.transferTo(new File(FILE_UPLOAD_PATH, rvImg1));
        }
        review.setRvImg1(file1.getOriginalFilename());

        if(!file2.getOriginalFilename().isEmpty()){
            file2.transferTo(new File(FILE_UPLOAD_PATH, rvImg2));

        }
        review.setRvImg2(file2.getOriginalFilename());
//
        if(!file3.getOriginalFilename().isEmpty()){
            file3.transferTo(new File(FILE_UPLOAD_PATH, rvImg3));
//            model.addAttribute("msg", "File uploaded successfully.");
//            model.addAttribute("menuImg3", menuImg3);
//        }else {
//            model.addAttribute("msg", "Please select a valid mediaFile..");
        }
        review.setRvImg3(file3.getOriginalFilename());

        Purchase purchase = purchaseService.getPurchase(review.getRvOrderNo());


//        review.setRvOrderNo(rvOrderNo);
        review.setRvTruckId(purchase.getOrderTruckId().getTruckId());
        review.setRvUserId(purchase.getOrderUserId().getUserId());

        System.out.println("aaaaa review : " + review);
        System.out.println("//////rvTruckId, rvUserId 확인/////////review.getRvTruckId : " + review.getRvTruckId());
        System.out.println("//////rvTruckId, rvUserId 확인/////////review.getRvUserId : " + review.getRvUserId());

        reviewService.addReview(review);

        model.addAttribute("review", review);
//        model.addAttribute("orderNo", rvOrderNo);

        return "forward:/views/menu/getMenu.jsp"; //송화님&진석님과 얘기해보기


    }
//
//    @RequestMapping(value="addReviewER", method=RequestMethod.POST)
//    public String addReviewER(Model model) throws Exception{
////    public String addReview(@ModelAttribute("review") Review review, @RequestParam(value="orderNo", required = false)int orderNo, Model model) throws Exception{
//
//        System.out.println("/review/addReview:POST");
////        System.out.println("review = " + review + ", model = " + model);
////
////        Purchase purchase = purchaseService.getPurchase(review.getRvOrderNo());
////
////
//////        review.setRvOrderNo(rvOrderNo);
////        review.setRvTruckId(purchase.getOrderTruckId().getTruckId());
////        review.setRvUserId(purchase.getOrderUserId().getUserId());
////
////        reviewService.addReview(review);
////
////        model.addAttribute("review", review);
//////        model.addAttribute("orderNo", rvOrderNo);
//
//        return "redirect:/views/menu/getMenu.jsp"; //송화님&진석님과 얘기해보기
//
//
//    }

    @RequestMapping(value="updateReview", method=RequestMethod.GET)
    public ModelAndView updateReview(HttpServletRequest request, ModelAndView modelAndView) throws Exception{

        System.out.println("/review/updateReview : GET");

        //Business Logic

        String rvNoo = request.getParameter("rvNo");

        int rvNo = Integer.parseInt(rvNoo);

        Review review = reviewService.getReview(rvNo);

        Purchase purchase = purchaseService.getPurchase(review.getRvOrderNo());

        Map orderDetail = purchaseService.getOrderDetail(review.getRvOrderNo());
        System.out.println("/////////////////");
        System.out.println("orderDetail Map : " + orderDetail);
        System.out.println("/////////////////");

        //Model - View 연결
        modelAndView.addObject("review", review);
        modelAndView.addObject("orderDetail", orderDetail);
        modelAndView.addObject("purchase",purchase);
        modelAndView.setViewName("/views/review/updateReviewView.jsp");

        System.out.println("request = " + request + ", modelAndView = " + modelAndView);

        return modelAndView;
    }

    @RequestMapping(value="updateReview", method=RequestMethod.POST)
    public String updateReview(
            @RequestParam("rvImg11")MultipartFile file1,
            @RequestParam("rvImg22")MultipartFile file2,
            @RequestParam("rvImg33")MultipartFile file3,
            @ModelAttribute("rvNo") int rvNo,
            @ModelAttribute("review") Review review,
            Model model) throws Exception{

        System.out.println("/review/updateReview:POST");
        System.out.println("rvNo = " + rvNo + ", review = " + review + ", model = " + model);

        String rvImg1  = file1.getOriginalFilename();
        String rvImg2  = file2.getOriginalFilename();
        String rvImg3  = file3.getOriginalFilename();

        if(!file1.getOriginalFilename().isEmpty()){
            file1.transferTo(new File(FILE_UPLOAD_PATH, rvImg1));
        }
        review.setRvImg1(file1.getOriginalFilename());

        if(!file2.getOriginalFilename().isEmpty()){
            file2.transferTo(new File(FILE_UPLOAD_PATH, rvImg2));

        }
        review.setRvImg2(file2.getOriginalFilename());

        if(!file3.getOriginalFilename().isEmpty()){
            file3.transferTo(new File(FILE_UPLOAD_PATH, rvImg3));

        }
        review.setRvImg3(file3.getOriginalFilename());


        review.setRvNo(rvNo);

        reviewService.updateReview(review);

        model.addAttribute("review", review);
        model.addAttribute("truckId", review.getRvTruckId());

        return "redirect:/views/review/getReviewList.jsp"; //송화님&진석님과 얘기해보기


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
