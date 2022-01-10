package com.ffin.service.purchase.impl;

import com.ffin.common.Search;
import com.ffin.service.domain.*;
import com.ffin.service.purchase.PurchaseDao;
import com.ffin.service.purchase.PurchaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService {

    @Autowired
    @Qualifier("purchaseDaoImpl")
    private PurchaseDao purchaseDao;
    public void setPurchaseDao(PurchaseDao purchaseDao){
        this.purchaseDao = purchaseDao;
    }
    public PurchaseServiceImpl(){
        System.out.println(this.getClass());
    }

    @Override
    public void addCart(List list) throws Exception{
        System.out.println("PurchaseServiceImpl.addCart");
        purchaseDao.addCart(list);

    }//장바구니에 정보 등록, 등록된 주분번호 가져오기
    @Override
    public int addPurchase(Purchase purchase)throws Exception{
        System.out.println("PurchaseServiceImpl.addPurchase");
         return purchaseDao.addPurchase(purchase);
    }
    //주문번호 생성을 위해서
    @Override
    public int updatePoint(Point point)throws Exception{
       return purchaseDao.updatePoint(point);
    }// 포인트 적립차감 등록
    @Override
    public void addCoupon(Coupon coupon)throws Exception{
       purchaseDao.addCoupon(coupon);
    }// 쿠폰발급 등록




    @Override
    public void updatePurchase(Purchase purchase) throws Exception{
        purchaseDao.updatePurchase(purchase);
    } //결제 시 결제에 대한 정보 업데이트
    @Override
    public void updateTotalPoint (User user)throws Exception{
        purchaseDao.updateTotalPoint(user);
    } //총포인트 수정
    @Override
    public void updateCouponStatus (Coupon coupon)throws Exception{
        purchaseDao.updateCouponStatus(coupon);
    } //쿠폰사용으로 사용유무수정
    @Override
    public void updateOrderTranCode (Purchase purchase) throws Exception{
        purchaseDao.updateOrderTranCode(purchase);
    }//주문접수로 주문상태변경
    @Override
    public void updateOrderCookingTime (Purchase purchase)throws Exception {
        purchaseDao.updateOrderCookingTime(purchase);
    }//주문접수 시 예상조리시간
    @Override
    public void updateOrderRefusal (Purchase purchase) throws Exception{
        purchaseDao.updateOrderRefusal(purchase);
    } //주문거절로 주문상태변경,주문거절사유
    @Override
    public void updateOrderCancel (Purchase purchase)throws Exception{
        purchaseDao.updateOrderCancel(purchase);
    } //주문취소로 주문상태변경,주문취소사유
    @Override
    public void updateRefundStatus(Purchase purchase)throws Exception{
        System.out.println("purchase = " + purchase);
        purchaseDao.updateRefundStatus(purchase);
    }//환불처리유무
    @Override
    public void updateOrder(Purchase purchase)throws Exception{
        purchaseDao.updateOrder(purchase);
    } //결제이후 결제정보 추가업데이트
    @Override
    public void updateBusiStatus(Truck truck)throws Exception{
        purchaseDao.updateBusiStatus(truck);
    }





    @Override
    public Map<String,Object> getCouponList(Coupon coupon)throws Exception{
        Map<String,Object> map = new HashMap<String,Object>();
        List<Coupon> list = purchaseDao.getCouponList(coupon);
        map.put("list", list);
        return map;
    } //쿠폰 리스트를 출력
    @Override
    public Map<String,Object> getCartList(int orderNo)throws Exception{
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("list", purchaseDao.getCartList(orderNo));
        return map;
    } //주문상세에 있는 정보 List?로 가져옴
    @Override
    public Map<String, Object> getOrderList(Search search,String truckId)throws Exception{
        return purchaseDao.getOrderList(search , truckId);

    } //현재판매목록
    @Override
    public Map<String,Object> getPurchaseList(Search search , String userId)throws Exception{
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("list", purchaseDao.getPurchaseList(search, userId));
        return map;
    }//마이페이지에서 구매이력
    @Override
    public Map<String,Object> getSalesList(Search search , String truckId)throws Exception{
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("list", purchaseDao.getSalesList(search, truckId));
        return map;
    } //마이페이지에서 판매이력
    @Override
    public Map<String,Object> getPointList(Search search , String userId)throws Exception{
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("list", purchaseDao.getPointList(search, userId));
        return map;
    }//마이페이지에서 포인트내역조회
    @Override
    public Map getOrderDetail(int orderNo)throws Exception{
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("list",purchaseDao.getOrderDetail(orderNo));
        System.out.println(map);
        return map;
    } //주문정보 조회 이용자의 정보도 함께



    @Override
    public  Purchase getPurchase(int orderNo)throws Exception{
        return purchaseDao.getPurchase(orderNo);
    } // 결제정보 조회
    @Override
    public Coupon getCoupon(int couponNo)throws Exception{
        System.out.println("PurchaseServiceImpl.getCoupon");
        return purchaseDao.getCoupon(couponNo);
    }// 쿠폰 할인금
    @Override
    public User getTotalPoint (String userId)throws Exception{
        return purchaseDao.getTotalPoint(userId);
    }//보유 총포인트 조회
    @Override
    public int getLastOrderNo(String truckId)throws Exception{
        return purchaseDao.getLastOrderNo(truckId);
    }
    @Override
    public String getTruckBusiStatus(String truckId)throws Exception{
        return purchaseDao.getTruckBusiStatus(truckId);
    }
    @Override
    public int getUsePoint(int pointNo)throws Exception{
        return purchaseDao.getUsePoint(pointNo);
    }

}
