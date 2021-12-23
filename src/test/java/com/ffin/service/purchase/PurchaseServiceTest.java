package com.ffin.service.purchase;

import com.ffin.common.Search;
import com.ffin.service.domain.*;
import com.ffin.service.user.UserService;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.AbstractList;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {	"classpath:config/context-common.xml",
        "classpath:config/context-aspect.xml",
        "classpath:config/context-mybatis.xml",
        "classpath:config/context-transaction.xml" })
public class PurchaseServiceTest {

    @Autowired
    @Qualifier("purchaseServiceImpl")
    private PurchaseService purchaseService;


    /////////////////////////GET////////////////////////////////
    //@Test
    public void TestGetPurchase() throws Exception {

        Purchase purchase = new Purchase();

        purchase = purchaseService.getPurchase(1);

        Assert.assertEquals(1, purchase.getOrderNo());
        Assert.assertEquals("user01", purchase.getOrderUserId());
        Assert.assertEquals("truck01", purchase.getOrderTruckId());
        Assert.assertEquals("주문요청사항", purchase.getOrderRequest());
        Assert.assertEquals(3, purchase.getOrderStatus());
        Assert.assertEquals(15, purchase.getOrderPickUpTime());
        Assert.assertEquals(15, purchase.getOrderCookingTime());


    }

    //@Test
    public void TestGetCoupon() throws Exception {
        int couponNo = 1;

        Coupon coupon = new Coupon();

        coupon = purchaseService.getCoupon(couponNo);

        Assert.assertEquals(1000, coupon.getCouponDcPrice());

    }

    //@Test
    public void TestGetTotalPoint() throws Exception {

        User user = new User();

        user = purchaseService.getTotalPoint("user01");

        Assert.assertEquals(0, user.getUserTotalPoint());

    }


    //@Test
    public void TestGetOrderDetail() throws Exception {
        Purchase purchase = new Purchase();
        purchase = purchaseService.getOrderDetail(1);
        System.out.println(purchase);

    }

///////////////////////List/////////////////////////////////
    //@Test
    public void TestGetCouponList() throws Exception {

        User user = new User();
        Coupon coupon = new Coupon();
        user.setUserId("user01");
        coupon.setCouponReceivedUserId(user);
        Map map = purchaseService.getCouponList(coupon);
        System.out.println(map);


    }

    //@Test
    public void TestGetCartList() throws Exception {
        Map map = purchaseService.getCartList(1);
        System.out.println(map);

    }

    //@Test
    public void TestGetOrderList() throws Exception {
        Map map = purchaseService.getOrderList("truck01");
        System.out.println(map);

    }






    //@Test
    public void TestGetPointList() throws Exception {
        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(3);
        Map map = purchaseService.getPointList(search,"user01");
        System.out.println(map);

    }

    //@Test
    public void TestGetPurchaseList() throws Exception {
        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(3);
        Map map = purchaseService.getPurchaseList(search,"user01");
        System.out.println(map);

    }


    //@Test
    public void TestGetSalesList() throws Exception {
        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(3);
        Map map = purchaseService.getSalesList(search,"truck01");
        System.out.println(map);

    }



////////////////////ADD///////////////////////////////////

  // @Test
    public void testAddPurchase() throws Exception {

        Purchase purchase = new Purchase();
        User user = new User();
        user.setUserId("user03");
        Truck truck = new Truck();
        truck.setTruckId("truck03");
        purchase.setOrderUserId(user);
        purchase.setOrderTruckId(truck);
        purchase.setOrderQty(3);
        purchase.setOrderStatus(0);
        purchase.setOrderPickUpTime(15);
        purchase.setOrderTotalPrice(3000);

        int orderNo = purchaseService.addPurchase(purchase);

       System.out.println("받아온정보!!!!"+orderNo);


    }


    @Test
    public void testAddOrderDetail() throws Exception {

        OrderDetail orderDetail = new OrderDetail();
/*        Purchase purchase = new Purchase();
        purchase.setOrderNo(8);*/
        Purchase purchase = new Purchase();
        purchase.setOrderNo(8);
        orderDetail.setOdOrderNo(purchase);
        orderDetail.setOdMenuImage("imag5-1");
        orderDetail.setOdMenuName("menu10");
        orderDetail.setOdMenuPrice(1000);
        orderDetail.setOdMenuQty(3);
        orderDetail.setOdMenuQtyFlag(1);
        orderDetail.setOdOptionGroupName("null");
        orderDetail.setOdOptionName("null");
        orderDetail.setOdOptionPrice(0);
   /*     List list = new ArrayList();
        list.add(orderDetail);*/

        purchaseService.addCart(orderDetail);



    }

    //@Test
    public void testAddCoupon() throws Exception {
        User user = new User();
        user.setUserId("user01");
       Coupon coupon = new Coupon();
       coupon.setCouponReceivedUserId(user);
        coupon.setCouponDcPrice(1000);
        coupon.setCouponType(3);
        coupon.setCouponStatus(0);
        purchaseService.addCoupon(coupon);

    }


    //@Test
    public void testUpdatePoint() throws Exception {
        User user = new User();
        user.setUserId("user01");
        Point point = new Point();
        point.setPointAmt(50);
        point.setPointBirthCode(2);
        point.setPointStatus(0);
        point.setPointUserId(user);
        point.setPointPlmnStatus(0);
        purchaseService.updatePoint(point);
    }

///////////////////Update////////////////////////////

    //@Test
    public void testUpdatePurchase() throws Exception {
        int payPointNo;
        Purchase purchase = new Purchase();
        Coupon coupon = new Coupon();
        coupon.setCouponNo(0);

        Point point = new Point();
        point.setPointNo(0);

        Catering catering = new Catering();
        catering.setCtNo(0);

        purchase.setOrderStatus(1);
        purchase.setPayOption(1);
        purchase.setPayPrice(3000);
        purchase.setPayServiceType(0);
        purchase.setPayPointNo(point);
        purchase.setPayCouponNo(coupon);
        purchase.setPayResNo(catering);

        purchase.setOrderNo(1);


        purchaseService.updatePurchase(purchase);


        Assert.assertEquals(1, purchase.getOrderStatus());
        Assert.assertEquals(1, purchase.getPayOption());
        Assert.assertEquals(3000, purchase.getPayPrice());
        Assert.assertEquals(0, purchase.getPayServiceType());
        Assert.assertEquals(0, purchase.getPayPointNo());
        Assert.assertEquals(0, purchase.getPayCouponNo());
        Assert.assertEquals(0, purchase.getPayResNo());

    }


    //@Test
    public void testUpdateTotalPoint() throws Exception {


        User userOne = new User();
        userOne = purchaseService.getTotalPoint("user01");
        Assert.assertEquals(1000, userOne.getUserTotalPoint());


        User user = new User();
        user.setUserId("user01");
        user.setUserTotalPoint(1000);
        purchaseService.updateTotalPoint(user);


        User user1 = new User();
        user1 = purchaseService.getTotalPoint("user01");
        Assert.assertEquals(1000, user1.getUserTotalPoint());


    }

    //@Test
    public void testUpdateCouponStatus() throws Exception {

        Coupon couponStart = new Coupon();
        couponStart = purchaseService.getCoupon(2);
        Assert.assertEquals(1,couponStart.getCouponStatus());


        Coupon coupon = new Coupon();
        coupon.setCouponNo(2);
        coupon.setCouponStatus(0);
        purchaseService.updateCouponStatus(coupon);



        Coupon coupon1 = new Coupon();
        coupon1 = purchaseService.getCoupon(2);
        Assert.assertEquals(0, coupon1.getCouponStatus());


    }

    //@Test
    public void testUpdateOrderTranCode() throws Exception {

        Purchase purchaseStart = new Purchase();
        purchaseStart = purchaseService.getPurchase(1);
        Assert.assertEquals(1,purchaseStart.getOrderStatus());

        Purchase update = new Purchase();
        update.setOrderNo(1);
        update.setOrderStatus(2);
        purchaseService.updateOrderTranCode(update);


        Purchase end = new Purchase();
        end = purchaseService.getPurchase(1);
        Assert.assertEquals(2, end.getOrderStatus());

    }

    //@Test
    public void testUpdateCookingTime() throws Exception {

        Purchase purchase = new Purchase();
        purchase = purchaseService.getPurchase(1);
        Assert.assertEquals(2,purchase.getOrderStatus());
        Assert.assertEquals(15,purchase.getOrderCookingTime());


        purchase.setOrderNo(1);
        purchase.setOrderStatus(2);
        purchase.setOrderCookingTime(10);
        purchaseService.updateOrderCookingTime(purchase);


        purchase = purchaseService.getPurchase(1);
        Assert.assertEquals(2, purchase.getOrderStatus());
        Assert.assertEquals(10, purchase.getOrderCookingTime());


    }

    //@Test
    public void testUpdateOrderCancel() throws Exception {

        Purchase purchase = new Purchase();
        purchase = purchaseService.getPurchase(1);
        Assert.assertEquals(4,purchase.getOrderStatus());
//        Assert.assertEquals(3,purchase.getOrderCancelReason());


        purchase.setOrderNo(1);
        purchase.setOrderStatus(4);
        purchase.setOrderCancelReason(3);
        purchaseService.updateOrderCancel(purchase);


        purchase = purchaseService.getPurchase(1);
        Assert.assertEquals(4, purchase.getOrderStatus());
        Assert.assertEquals(3, purchase.getOrderCancelReason());


    }
    //@Test
    public void testUpdateOrderRefusal() throws Exception {

        Purchase purchase = new Purchase();
        purchase = purchaseService.getPurchase(1);
        Assert.assertEquals(4,purchase.getOrderStatus());
//        Assert.assertEquals(3,purchase.getOrderCancelReason());


        purchase.setOrderNo(1);
        purchase.setOrderStatus(1);
        purchase.setOrderNopeReason(3);
        purchaseService.updateOrderRefusal(purchase);


        purchase = purchaseService.getPurchase(1);
        Assert.assertEquals(1, purchase.getOrderStatus());
        Assert.assertEquals(3, purchase.getOrderNopeReason());


    }

    //@Test
    public void testUpdateRefundStatus() throws Exception {

        Purchase purchase = new Purchase();
        purchase = purchaseService.getPurchase(1);
        Assert.assertEquals(4,purchase.getOrderStatus());
//        Assert.assertEquals(3,purchase.getOrderCancelReason());


        purchase.setOrderNo(1);
        purchase.setOrderStatus(4);
        purchase.setPayRefundStatus(1);
        purchaseService.updateRefundStatus(purchase);


        purchase = purchaseService.getPurchase(1);
        Assert.assertEquals(4, purchase.getOrderStatus());
        Assert.assertEquals(1, purchase.getPayRefundStatus());

    }





}