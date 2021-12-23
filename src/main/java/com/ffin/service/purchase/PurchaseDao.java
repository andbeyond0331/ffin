package com.ffin.service.purchase;


import com.ffin.common.Search;
import com.ffin.service.domain.*;

import java.util.List;

public interface PurchaseDao {

    public void addCart(List list) throws Exception ;//장바구니에 정보 등록
    public int addPurchase(Purchase purchase)throws Exception;//주문번호 생성을 위해서
    public void updatePoint(Point point)throws Exception;// 포인트 적립차감 등록
    public void addCoupon(Coupon coupon)throws Exception;// 쿠폰발급 등록


    public void updatePurchase(Purchase purchase)throws Exception; //결제 시 결제에 대한 정보 업데이트
    public void updateTotalPoint (User user)throws Exception; //총포인트 수정
    public void updateCouponStatus (Coupon coupon)throws Exception; //쿠폰사용으로 사용유무수정
    public void updateOrderTranCode (Purchase purchase) throws Exception;//주문접수로 주문상태변경
    public void updateOrderCookingTime (Purchase purchase) throws Exception;//주문접수 시 예상조리시간
    public void updateOrderCancel (Purchase purchase)throws Exception; //주문취소로 주문상태변경,주문취소사유
    public void updateOrderRefusal (Purchase purchase)throws Exception; //주문거절로 주문상태변경,주문거절사유
    public void updateRefundStatus(Purchase purchase) throws Exception;//환불처리유무
    public void updateOrder(Purchase purchase)throws Exception; //결제이후 결제정보 추가업데이트

    public List<Coupon> getCouponList(Coupon coupon)throws Exception; //이용자가 가지고 있는 쿠폰 리스트를 출력
    public List<OrderDetail> getCartList( int orderNo)throws Exception; //주문상세에 있는 정보 List?로 가져옴
    public List<Purchase> getOrderList(String truckId)throws Exception; //푸드트럭에 대한 현재판매목록
    public List<Purchase> getPurchaseList(Search search , String userId)throws Exception;//마이페이지에서 구매이력
    public List<Purchase> getSalesList(Search search , String truckId)throws Exception; //마이페이지에서 판매이력
    public List<Point> getPointList(Search search , String userId)throws Exception;//마이페이지에서 포인트내역조회



    public Purchase getPurchase( int orderNo)throws Exception; // 결제정보 조회
    public Purchase getOrderDetail(int orderNo) throws Exception;//주문정보 조회 이용자의 정보도 함께
    public Coupon getCoupon(int couponNo)throws Exception;// 쿠폰 할인금
    public User getTotalPoint (String userId)throws Exception;//보유 총포인트 조회



}
