package com.ffin.web.purchase;

import com.ffin.service.domain.*;
import com.ffin.service.purchase.PurchaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static java.lang.Integer.parseInt;

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
    public ModelAndView addPayView(HttpServletRequest request ,@RequestParam int payOption,
                                   @RequestParam int orderTotalPrice,@RequestParam String orderUserId,
                                   @RequestParam String orderTruckId,@RequestParam int orderNo,
                                   @RequestParam int pointAmt,@RequestParam int couponNo,
                                   @RequestParam String imp_uid,
                                   HttpServletResponse response  )throws Exception{

        request.setCharacterEncoding("UTF-8");
        System.out.println("///////////////////////////////////////////////////////////////////////////////");
        System.out.println("///////////////////////////////////////////////////////////////////////////////");
        System.out.println("///////////////////////////////////////////////////////////////////////////////");
        System.out.println("///////////////////////////////////////////////////////////////////////////////");
        System.out.println("request = " + request + ", payOption = " + payOption + ", orderTotalPrice = " + orderTotalPrice + ", orderUserId = " + orderUserId + ", orderTruckId = " + orderTruckId + ", orderNo = " + orderNo + ", pointAmt = " + pointAmt + ", couponNo = " + couponNo + ", imp_uid = " + imp_uid + ", response = " + response);

        Purchase purchase = new Purchase();
        ModelAndView modelAndView = new ModelAndView();
        OrderDetail orderDetail = new OrderDetail();
        Coupon coupon = new Coupon();
        Point point = new Point();
        User user = new User();
        Truck truck = new Truck();

        user.setUserId(orderUserId);
        truck.setTruckId(orderTruckId);

        coupon.setCouponReceivedUserId(user);
        coupon.setCouponStatus(1);
        coupon.setCouponNo(couponNo);

        point.setPointAmt(pointAmt);
        point.setPointUserId(user);
        point.setPointPlmnStatus(0);
        point.setPointStatus(0);
        point.setPointBirthCode(orderNo);
        user = purchaseService.getTotalPoint(user.getUserId());

        purchase.setOrderNo(orderNo);
        purchase.setPayPrice(orderTotalPrice);
        purchase.setPayOption(payOption);
        purchase.setOrderTotalPrice(orderTotalPrice);
        purchase.setOrderUserId(user);
        purchase.setOrderTruckId(truck);
        purchase.setPayServiceType(1);
        purchase.setOrderStatus(1);



        if(coupon.getCouponNo() != 0) {
            purchaseService.updateCouponStatus(coupon);
            purchase.setPayCouponNo(coupon);
        }

        if(point.getPointAmt() != 0) {
            user.setUserTotalPoint(user.getUserTotalPoint()-point.getPointAmt());
            int pointNo = purchaseService.updatePoint(point);
            purchaseService.updateTotalPoint(user);
            point.setPointNo(pointNo);
            purchase.setPayPointNo(point);
        }
        System.out.println("/n/n/n ////////////////////////////////////////n"+purchase);
        purchaseService.updatePurchase(purchase);
        //int orderNo = purchaseService.addPurchase(purchase);
        // orderDetail.setOdOrderNo(purchase);
        //Map cart = purchaseService.getCartList(orderNo);
        //purchase = purchaseService.getPurchase(orderNo);
        //User totalPoint = purchaseService.getTotalPoint(purchase.getOrderUserId().getUserId());
        return modelAndView;
    }
    @RequestMapping( value = "json/addCartList", method = RequestMethod.POST)
    @ResponseBody
    public Object addCartList(@RequestParam(value="odMenuName[]") List<String> odMenuName,
                            @RequestParam(value="odOptionGroupName[]") List<String> odOptionGroupName,
                            @RequestParam(value="odOptionName[]") List<String> odOptionName,
                            @RequestParam(value="odMenuQty[]") List<String> odMenuQty,
                            @RequestParam(value="odMenuPrice[]") List<String> odMenuPrice,
                            @RequestParam(value="odOptionPrice[]") List<String> odOptionPrice,
                            @RequestParam(value="odMenuImage[]") List<String> odMenuImage,
                            @RequestParam(value="orderPickUpTime") int orderPickUpTime,
                            @RequestParam(value="orderTotalPrice") int orderTotalPrice,
                            @RequestParam(value="orderUserId") String orderUserId,
                            @RequestParam(value="orderTruckId") String orderTruckId,
                            @RequestParam(value="orderRequest") String orderRequest,
                            @RequestParam(value="orderQty") int orderQty
                                                                      )throws IOException,Exception{
        System.out.println("json/addCartList POST");
        System.out.println("odMenuName = " + odMenuName + ", odOptionGroupName = " + odOptionGroupName + ", odOptionName = " + odOptionName + ", odMenuQty = " + odMenuQty + ", odMenuPrice = " + odMenuPrice + ", odOptionPrice = " + odOptionPrice + ", odMenuImage = " + odMenuImage + ", orderPickUpTime = " + orderPickUpTime + ", orderTotalPrice = " + orderTotalPrice + ", orderUserId = " + orderUserId + ", orderTruckId = " + orderTruckId + ", orderRequest = " + orderRequest + ", orderQty = " + orderQty);
        Purchase purchase = new Purchase();
        OrderDetail orderDetail = new OrderDetail();
        User user = new User();
        Truck truck = new Truck();

        user.setUserId(orderUserId);
        truck.setTruckId(orderTruckId);

        purchase.setOrderPickUpTime(orderPickUpTime);
        purchase.setOrderTotalPrice(orderTotalPrice);
        purchase.setOrderUserId(user);
        purchase.setOrderTruckId(truck);
        purchase.setOrderRequest(orderRequest);
        purchase.setOrderQty(orderQty);

        System.out.println("odMenuName length"+odMenuName.size());
        System.out.println("odOptionGroupName length"+odOptionGroupName.size());
        System.out.println("odOptionName length"+odOptionName.size());
        System.out.println("odMenuQty length"+odMenuQty.size());
        System.out.println("odMenuPrice length"+odMenuPrice.size());
        System.out.println("odOptionPrice length"+odOptionPrice.size());
        System.out.println("odMenuImage length"+odMenuImage.size());

        int orderNo = purchaseService.addPurchase(purchase);
        orderDetail.setOdOrderNo(purchase);
        Purchase pur = new Purchase();


        List <OrderDetail> orderList = new ArrayList<OrderDetail>();

        for (int i = 0; i< odMenuName.size(); i++){
            OrderDetail order = new OrderDetail();

            order.setOdMenuName(odMenuName.get(i));
            if(i>=odOptionGroupName.size()){
                order.setOdOptionGroupName(null);
            }else{
                order.setOdOptionGroupName(odOptionGroupName.get(i));
            }
            if(i>=odOptionName.size()){
                order.setOdOptionName(null);
            }else{
                order.setOdOptionName(odOptionName.get(i));
            }
            if(i>=odOptionName.size()){
                order.setOdOptionName(null);
            }else{
                order.setOdOptionName(odOptionName.get(i));
            }
            if(i>=odMenuQty.size()){
                order.setOdMenuQty(0);
            }else{
                order.setOdMenuQty(parseInt(odMenuQty.get(i)));
            }
            if(i>=odMenuPrice.size()){
                order.setOdMenuPrice(0);
            }else{
                order.setOdMenuPrice(parseInt(odMenuPrice.get(i)));
            }
            if(i>=odOptionPrice.size()){
                order.setOdOptionPrice(0);
            }else{
                order.setOdOptionPrice(parseInt(odOptionPrice.get(i)));
            }
            if(i>=odMenuImage.size()){
                order.setOdMenuImage(null);
            }else{
                order.setOdMenuImage(odMenuImage.get(i));
            }

            pur.setOrderNo(orderNo);
            order.setOdOrderNo(pur);


            orderList.add(order);
        }

        purchaseService.addCart(orderList);
        System.out.println(orderNo);

        Map<String,Object> retVal = new HashMap<String,Object>();
        retVal.put("code","OK");
        retVal.put("orderNo",orderNo);


        return retVal;

    }



    //addIamport
    //cancelIamport
    //getCouponList
}
