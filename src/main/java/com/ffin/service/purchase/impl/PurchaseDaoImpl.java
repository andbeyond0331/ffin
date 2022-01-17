package com.ffin.service.purchase.impl;

import com.ffin.common.Search;
import com.ffin.service.domain.*;
import com.ffin.service.purchase.PurchaseDao;
import com.sun.scenario.effect.impl.sw.java.JSWBlend_SRC_OUTPeer;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
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
    public void addCart(List list) throws Exception{
        System.out.println("orderDetail = " + list);
        Map map = new HashMap();
        map.put("list",list);
        System.out.println("map에 들어간것 확인 "+map.get("list"));
        sqlSession.insert("PurchaseMapper.addCart",map);
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
    public int updatePoint(Point point)throws Exception{
        sqlSession.insert("PurchaseMapper.updatePoint",point);
        int no = point.getPointNo();
        return no;
    }// 포인트 적립차감 등록
    @Override//수정 HHJ
    public int addCoupon(Coupon coupon)throws Exception{
        sqlSession.insert("PurchaseMapper.addCoupon",coupon);
        int no = coupon.getCouponNo();
        return no;
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
    public void updateBusiStatus(Truck truck)throws Exception{
        sqlSession.update("PurchaseMapper.updateBusiStatus",truck);
    }//영업중 모드 변경






    @Override
    public List<Coupon> getCouponList(Coupon coupon)throws Exception{
        return sqlSession.selectList("PurchaseMapper.getCouponList",coupon);
    } //쿠폰 리스트를 출력
    @Override
    public List<OrderDetail> getCartList(int orderNo)throws Exception{
        return sqlSession.selectList("PurchaseMapper.getCartList",orderNo);
    } //주문상세에 있는 정보 List?로 가져옴
    @Override
    public Map<String, Object> getOrderList(Search search,String truckId)throws Exception{
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("search",search);
        map.put("truckId",truckId);
        List<Purchase> list = new ArrayList<>();
        list = sqlSession.selectList("PurchaseMapper.getOrderList",map);
        map.put("list",list);
        return map;
    } //현재판매목록

    @Override
    public List<Purchase> getPurchaseList(Map<String, Object> map) throws Exception {
        return sqlSession.selectList("PurchaseMapper.getPurchaseList", map);
    }

    /*@Override
    public List getPurchaseList(Search search , String userId)throws Exception{
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("search",search);
        map.put("userId",userId);
        return sqlSession.selectList("PurchaseMapper.getPurchaseList",map);
    }//마이페이지에서 구매이력*/
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
    public List getOrderDetail(int orderNo)throws Exception{
        System.out.println("orderNo = " + orderNo);
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("orderNo",orderNo);
        return sqlSession.selectList("PurchaseMapper.getOrderDetail",map);
    } //주문정보 조회 이용자의 정보도 함께
    @Override
    public Map<String, Object> getOrderUserList(Search search,String userId) throws Exception {
        Map<String,Object> map = new HashMap<>();
        map.put("userId",userId);
        map.put("search",search);
        List<Purchase> list = sqlSession.selectList("PurchaseMapper.getOrderUserList",map);
        map.put("list",list);
        return map;
    }



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
    public int getLastOrderNo (String truckId)throws Exception{
        System.out.println("purchaseDaoImpl"+truckId);
        Purchase purchase = sqlSession.selectOne("PurchaseMapper.getLastOrderNo",truckId);
        System.out.println("ddd"+purchase.getOrderNo());
        int orderNo= purchase.getOrderNo();
        return orderNo;
    }// 푸드트럭 주문목록에서 마지막결과 값으로 상세정보

    @Override
    public String getTruckBusiStatus(String truckId)throws Exception{
        Truck truck = sqlSession.selectOne("PurchaseMapper.getTruckBusiStatus",truckId);
        String truckBusiStatus = truck.getTruckBusiStatus();



        return truckBusiStatus;
    }
    @Override
    public int getUsePoint(int pointNo)throws Exception{
        Point point = sqlSession.selectOne("PurchaseMapper.getUsePoint",pointNo);
        int pointAmt = point.getPointAmt();
        return pointAmt;
    }



    //HHJ
    @Override
    public String checkCoupon(Coupon coupon) throws Exception {
        return sqlSession.selectOne("PurchaseMapper.checkCoupon",coupon);
    }

    @Override
    public int getTotalCountByUser(Search search, String userId) throws Exception {
        Map<String, Object> map = new HashMap<>();
        map.put("search", search);
        map.put("userId", userId);
        return sqlSession.selectOne("PurchaseMapper.getTotalCountByUser", map);
    }
}