package com.ffin.web.purchase;

import com.ffin.service.domain.OrderDetail;
import com.ffin.service.domain.Purchase;
import com.ffin.service.domain.User;
import com.ffin.service.purchase.PurchaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
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
                                   @RequestParam("orderTotalPrice") int orderTotalPrice,@RequestParam("orderUserId") String orderUserId,
                                   @RequestParam("orderTruckId") String orderTruckId,
                                   HttpServletResponse response  )throws Exception{
        //System.out.println("postLLLL"+purchase);
        request.setCharacterEncoding("UTF-8");
        System.out.println("json/addPayView");
        System.out.println("request = " + request + ", payOption = " + payOption + ", orderTotalPrice = " + orderTotalPrice + ", orderUserId = " + orderUserId + ", orderTruckId = " + orderTruckId + ", response = " + response);

        ModelAndView modelAndView = new ModelAndView();

        OrderDetail orderDetail = new OrderDetail();
        //int orderNo = purchaseService.addPurchase(purchase);
       // orderDetail.setOdOrderNo(purchase);
        //Map cart = purchaseService.getCartList(orderNo);
        //purchase = purchaseService.getPurchase(orderNo);
        //User totalPoint = purchaseService.getTotalPoint(purchase.getOrderUserId().getUserId());
        return modelAndView;
    }
    @RequestMapping( value = "json/addCartList", method = RequestMethod.POST)
    @ResponseBody
    public void addCartList(HttpServletRequest request, OrderDetail orderDetail,
                            HttpServletResponse response, ModelMap model)throws IOException,Exception{
        System.out.println("/////////////////////////////////////////////////");

        System.out.println("odMenuName"+orderDetail.getOdMenuName());
        System.out.println("odOptionGroupName"+orderDetail.getOdOptionGroupName());
        System.out.println("odOptionName"+orderDetail.getOdOptionName());
        System.out.println("odMenuQty"+orderDetail.getOdMenuQty());
        System.out.println("odMenuPrice"+orderDetail.getOdMenuPrice());
        System.out.println("odOptionPrice"+orderDetail.getOdOptionPrice());
        System.out.println("odMenuImage"+orderDetail.getOdMenuImage());
        System.out.println("odOrderNo"+orderDetail.getOdOrderNo());

        String[] odMenuName = orderDetail.getOdMenuName().split(",");
        String[] odOptionGroupName = orderDetail.getOdOptionGroupName().split(",");
        String[] odOptionName = orderDetail.getOdOptionName().split(",");
        String[] odMenuQty = Integer.toString(orderDetail.getOdMenuQty()).split(",");
        String[] odMenuPrice = Integer.toString(orderDetail.getOdMenuPrice()).split(",");
        String[] odOptionPrice = Integer.toString(orderDetail.getOdOptionPrice()).split(",");
        String[] odMenuImage = orderDetail.getOdMenuImage().split(",");
        String[] odOrderNo = String.valueOf(orderDetail.getOdOrderNo()).split(",");

        System.out.println("odMenuName length"+odMenuName.length);
        System.out.println("odOptionGroupName length"+odOptionGroupName.length);
        System.out.println("odOptionName length"+odOptionName.length);
        System.out.println("odMenuQty length"+odMenuQty.length);
        System.out.println("odMenuPrice length"+odMenuPrice.length);
        System.out.println("odOptionPrice length"+odOptionPrice.length);
        System.out.println("odMenuImage length"+odMenuImage.length);
        System.out.println("odOrderNo length"+odOrderNo.length);
    }


    //addIamport
    //cancelIamport
    //getCouponList
}
