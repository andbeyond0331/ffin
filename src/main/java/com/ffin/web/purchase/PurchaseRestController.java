package com.ffin.web.purchase;

import com.ffin.service.domain.*;
import com.ffin.service.purchase.PurchaseService;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
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
        purchase.setPayId(imp_uid);



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
                            @RequestParam(value="orderQty") int orderQty,
                            @RequestParam(value="odMenuQtyFlag[]")List<String> odMenuQtyFlag

                                                                      )throws IOException,Exception{
        System.out.println("json/addCartList POST");
        System.out.println("odMenuName = " + odMenuName + ", odOptionGroupName = " + odOptionGroupName + ", odOptionName = " + odOptionName + ", odMenuQty = " + odMenuQty + ", odMenuPrice = " + odMenuPrice + ", odOptionPrice = " + odOptionPrice + ", odMenuImage = " + odMenuImage + ", orderPickUpTime = " + orderPickUpTime + ", orderTotalPrice = " + orderTotalPrice + ", orderUserId = " + orderUserId + ", orderTruckId = " + orderTruckId + ", orderRequest = " + orderRequest + ", orderQty = " + orderQty + ", odMenuQtyFlag = " + odMenuQtyFlag);
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
        System.out.println("odMenuQtyFlag length"+odMenuQtyFlag.size());

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
            if(i>=odMenuQtyFlag.size()){
                order.setOdMenuQtyFlag(0);
            }else{
                order.setOdMenuQtyFlag(parseInt(odMenuQtyFlag.get(i)));
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


///////////////////////////////////환불////////////////////////////////////////

    IamportClient client;

    public void setup() throws Exception {
        String api_key = "4137265660436852";
        String api_secret = "cddee6e3a9dcb5f0fd4c8d7fa6c8949fc346c818f164e6bad7a7d94848da04a36756a3f60a031a5d";

        client = new IamportClient(api_key, api_secret);
    }

    public void testGetToken() throws Exception {
        String token = String.valueOf(client.getAuth());
        System.out.println("token : " + token);
    }

    @RequestMapping(value = "/json/payRefund/{payId}")
    public Map payRefund(@PathVariable String payId ) throws Exception {
        // 이미 취소된 거래 imp_uid
        System.out.println("testCancelPaymentByImpUid --- Start!---");

        Purchase purchase = new Purchase();
        purchase.setPayId(payId);
        purchase.setOrderStatus(5);

       /* Map<String, Object> map =  orderService.getOrderRefund(order);*/
        Map<String, Object> map =  new HashMap<String,Object>();

        setup();
        testGetToken();
        setup();
        //Order order = orderService.getFlightOrder(orderId);

        CancelData cancel = new CancelData(payId, true);
        System.out.println("imp_uid : " + payId);
        IamportResponse<Payment> cancelpayment = client.cancelPaymentByImpUid(cancel);
        System.out.println(cancelpayment.getMessage());
        System.out.println("testCancelPaymentByImpUid --- End!---");


        //환불 일시를 controller에서 할지 Mapper에서 할지 수정,,
/*        SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");

        String time1 = format1.format(System.currentTimeMillis());
        order.setRefundDate(time1);*/
/*        System.out.println("time : "+time1);
        System.out.println("order : "+order);
        map.put("orderId", orderId);
        map.put("order", order);*/

        return map;
    }

    ///////////////////////////////환불 끝///////////////////////////////////////////////

    //addIamport
    //cancelIamport
    //getCouponList
}
