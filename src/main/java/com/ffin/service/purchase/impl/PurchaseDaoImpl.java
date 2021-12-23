package com.ffin.service.purchase.impl;

import com.ffin.common.Search;
import com.ffin.service.domain.*;
import com.ffin.service.purchase.PurchaseDao;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository("purchaseDaoImpl")
public class PurchaseDaoImpl implements PurchaseDao {

    @Autowired
    @Qualifier("sqlSessionTemplate")
    private SqlSession sqlSession;
    public void setSqlSession(SqlSession sqlSession){
        this.sqlSession = sqlSession;
    }
    public PurchaseDaoImpl(){
        System.out.println(this.getClass());
    }
    @Override
    public void addCart(OrderDetail orderDetail) throws Exception{
        System.out.println("orderDetail = " + orderDetail);
        sqlSession.insert("PurchaseMapper.addCart",orderDetail);
    }//장바구니에 정보 등록
    @Override
    public int addPurchase(Purchase purchase)throws Exception{
        System.out.println("PurchaseDaoImpl.addPurchase");
        sqlSession.insert("PurchaseMapper.addPurchase",purchase);
        int id = purchase.getOrderNo();
        return id;
    }
    //주문번호 생성을 위해서
    @Override
    public void updatePoint(Point point)throws Exception{
        sqlSession.insert("PurchaseMapper.updatePoint",point);
    }// 포인트 적립차감 등록
    @Override
    public void addCoupon(Coupon coupon)throws Exception{
        sqlSession.insert("PurchaseMapper.addCoupon",coupon);
    }// 쿠폰발급 등록



    @Override
    public void updatePurchase(Purchase purchase)throws Exception{
        sqlSession.update("PurchaseMapper.updatePurchase",purchase);
    } //결제 시 결제에 대한 정보 업데이트
    @Override
    public void updateTotalPoint (User user)throws Exception{
        sqlSession.update("PurchaseMapper.updateTotalPoint",user);
    } //총포인트 수정
    @Override
    public void updateCouponStatus (Coupon coupon)throws Exception{
        sqlSession.update("PurchaseMapper.updateCouponStatus",coupon);
    } //쿠폰사용으로 사용유무수정
    @Override
    public void updateOrderTranCode (Purchase purchase) throws Exception{
        sqlSession.update("PurchaseMapper.updateOrderTranCode",purchase);
    }//주문접수로 주문상태변경
    @Override
    public void updateOrderCookingTime (Purchase purchase) throws Exception{
        sqlSession.update("PurchaseMapper.updateOrderCookingTime",purchase);
    }//주문접수 시 예상조리시간
    @Override
    public void updateOrderCancel (Purchase purchase)throws Exception{
        sqlSession.update("PurchaseMapper.updateOrderCancel",purchase);
    } //주문취소로 주문상태변경,주문취소사유
    @Override
    public void updateOrderRefusal (Purchase purchase)throws Exception{
        sqlSession.update("PurchaseMapper.updateOrderRefusal",purchase);
    } //주문거절로 주문상태변경,주문취소사유
    @Override
    public void updateRefundStatus(Purchase purchase)throws Exception{
        System.out.println("PurchaseDaoImpl.updateRefundStatus");
        sqlSession.update("PurchaseMapper.updateRefundStatus",purchase);
    }//환불처리 유무
    @Override
    public void updateOrder(Purchase purchase)throws Exception{
        sqlSession.update("PurchaseMapper.updateOrder",purchase);
    } //결제이후 결제정보 추가업데이트






    @Override
    public List<Coupon> getCouponList(Coupon coupon)throws Exception{
        return sqlSession.selectList("PurchaseMapper.getCouponList",coupon);
    } //쿠폰 리스트를 출력
    @Override
    public List<OrderDetail> getCartList(int orderNo)throws Exception{
        return sqlSession.selectList("PurchaseMapper.getCartList",orderNo);
    } //주문상세에 있는 정보 List?로 가져옴
    @Override
    public List<Purchase> getOrderList(String truckId)throws Exception{
        return sqlSession.selectList("PurchaseMapper.getOrderList",truckId);
    } //현재판매목록
    @Override
    public List getPurchaseList(Search search , String userId)throws Exception{
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("search",search);
        map.put("userId",userId);
        return sqlSession.selectList("PurchaseMapper.getPurchaseList",map);
    }//마이페이지에서 구매이력
    @Override
    public List getSalesList(Search search , String truckId)throws Exception{
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("search",search);
        map.put("truckId",truckId);
        return sqlSession.selectList("PurchaseMapper.getSalesList",map);
    } //마이페이지에서 판매이력
    @Override
    public List getPointList(Search search , String userId)throws Exception{
        System.out.println("search = " + search + ", userId = " + userId);
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("search",search);
        map.put("userId",userId);
        return sqlSession.selectList("PurchaseMapper.getPointList",map);
    }//마이페이지에서 포인트내역조회


    @Override
    public User getTotalPoint (String userId)throws Exception{
        return sqlSession.selectOne("PurchaseMapper.getTotalPoint",userId);
    }//보유 총포인트 조회
    @Override
    public Coupon getCoupon(int couponNo)throws Exception{
        System.out.println("couponNo = " + couponNo);
        return sqlSession.selectOne("PurchaseMapper.getCoupon",couponNo);
    }// 쿠폰 할인금
    @Override
    public Purchase getPurchase(int orderNo)throws Exception{
        return sqlSession.selectOne("PurchaseMapper.getPurchase",orderNo);
    } // 결제정보 조회
    @Override
    public Purchase getOrderDetail(int orderNo)throws Exception{
        return sqlSession.selectOne("PurchaseMapper.getOrderDetail",orderNo);
    } //주문정보 조회 이용자의 정보도 함께

}