package com.ffin.web.purchase;

import com.ffin.service.domain.OrderDetail;
import com.ffin.service.domain.Purchase;
import com.ffin.service.domain.User;
import com.ffin.service.purchase.PurchaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {

    @Autowired
    @Qualifier("purchaseServiceImpl")
    private PurchaseService purchaseService;

    public PurchaseRestController(){
        System.out.println(this.getClass());
    }

    @RequestMapping( value = "json/addPayView", method=RequestMethod.POST)
    @ResponseBody
    public ModelAndView addPayView(HttpServletRequest request ,@RequestParam("payOption") int payOption,
                                   @RequestParam("orderTotalPrice") int orderTotalPrice,
                                   @RequestParam("orderTruckId") String orderTruckId,@RequestParam("orderNo") int orderNo,
                                   HttpServletResponse response  )throws Exception{
        //System.out.println("postLLLL"+purchase);
        request.setCharacterEncoding("UTF-8");
        System.out.println("json/addPayView");
        System.out.println(", payOption = " + payOption + ", orderTotalPrice = " + orderTotalPrice + ", orderTruckId = " + orderTruckId + ", orderNo = " + orderNo );

        ModelAndView modelAndView = new ModelAndView();

        OrderDetail orderDetail = new OrderDetail();
        //int orderNo = purchaseService.addPurchase(purchase);
       // orderDetail.setOdOrderNo(purchase);
        //Map cart = purchaseService.getCartList(orderNo);
        //purchase = purchaseService.getPurchase(orderNo);
        //User totalPoint = purchaseService.getTotalPoint(purchase.getOrderUserId().getUserId());
        return modelAndView;
    }


    //addIamport
    //cancelIamport
    //getCouponList
}
