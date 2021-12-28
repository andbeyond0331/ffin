package com.ffin.web.purchase;

import com.ffin.service.domain.OrderDetail;
import com.ffin.service.domain.Purchase;
import com.ffin.service.domain.User;
import com.ffin.service.purchase.PurchaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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

    @RequestMapping( value = "json/addPayView",method = RequestMethod.POST)
    public OrderDetail addPayView(@RequestParam(value = "orderDetail")OrderDetail orderDetail,@RequestParam(value = "purchase") Purchase purchase)throws Exception{
        System.out.println("json/addPayView");
        int orderNo = purchaseService.addPurchase(purchase);
        orderDetail.setOdOrderNo(purchase);
        Map cart = purchaseService.getCartList(orderNo);
        purchase = purchaseService.getPurchase(orderNo);
        User totalPoint = purchaseService.getTotalPoint(purchase.getOrderUserId().getUserId());
        return orderDetail;
    }


    //addIamport
    //cancelIamport
    //getCouponList
}
