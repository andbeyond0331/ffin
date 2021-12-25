package com.ffin.web.purchase;

import com.ffin.service.domain.*;
import com.ffin.service.purchase.PurchaseService;
import com.sun.javafx.collections.MappingChange;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {

    ///Field
    @Autowired
    @Qualifier("purchaseServiceImpl")
    private PurchaseService purchaseService;
    //setter Method 구현 않음

    public PurchaseController() {
        System.out.println(this.getClass());
    }

    //==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
    //==> 아래의 두개를 주석을 풀어 의미를 확인 할것
    @Value("#{commonProperties['pageUnit']}")
    //@Value("#{commonProperties['pageUnit'] ?: 3}")
        int pageUnit;

    @Value("#{commonProperties['pageSize']}")
    //@Value("#{commonProperties['pageSize'] ?: 2}")
        int pageSize;

    @RequestMapping(value = "getCartMenuList", method= RequestMethod.GET)
    public ModelAndView getCartMenuList(@RequestParam("userId") String userId, ModelAndView model ) throws Exception{
        System.out.println("/purchase/getCartMenuList : GET");
        //Session에 저장되어 있는 메뉴정보를 map에 담아서 List 로 확인
/*        Purchase purchase = new Purchase();
        purchase.setOrderNo(8);
        OrderDetail orderDetail = new OrderDetail();
        orderDetail.setOdOrderNo(purchase);
        orderDetail.setOdMenuImage("imag5-1");
        orderDetail.setOdMenuName("menu10");
        orderDetail.setOdMenuPrice(1000);
        orderDetail.setOdMenuQty(3);
        orderDetail.setOdMenuQtyFlag(1);
        orderDetail.setOdOptionGroupName("null");
        orderDetail.setOdOptionName("null");
        orderDetail.setOdOptionPrice(0);
        HttpSession session = new MockHttpSession();*/
        OrderDetail orderDetail = new OrderDetail();
        Map map = new HashMap();
        map = purchaseService.getOrderDetail(1);
       // session.setAttribute("cart",orderDetail);


        model.addObject("map",map);
        model.setViewName("/purchase/getCartMenuList.jsp");


        return model;
    }

    @RequestMapping(value = "addCart", method= RequestMethod.POST)
    public ModelAndView addCart(@ModelAttribute("orderDetail") OrderDetail orderDetail, @ModelAttribute("purchase") Purchase purchase, ModelAndView model) throws Exception{

        System.out.println("/purchase/addCart : POST");
        System.out.println("orderDetail11111 = " + orderDetail + ", purchase2222 = " + purchase);
      int orderNo = purchaseService.addPurchase(purchase);
        orderDetail.setOdOrderNo(purchase);
        List list = new ArrayList();
        list.add(orderDetail);
        purchaseService.addCart(list);
        System.out.println(orderNo);


        Map cart = purchaseService.getCartList(orderNo);
        purchase = purchaseService.getPurchase(orderNo);
        User totalPoint = purchaseService.getTotalPoint(purchase.getOrderUserId().getUserId());

//        model.addObject("cart", cart);
        model.addObject("purchase",purchase);
        model.addObject("cart",cart);
        model.addObject("orderNo",orderNo);
        model.addObject("point",totalPoint);
        model.setViewName("/purchase/addPayView.jsp");
        System.out.println("model에 들어간 정보:::::::::::"+model);
        //session.removeAttribute("s_name2");
        //session 삭제하는 방법
        //장바구니에 있는 정보를 저장하고 저장한 내용을 불러와서 addPayView.jsp로 네비게이션
        //장바구니에 있는 정보 저장 시 orderNo생성을 위해 Purchase에 먼저 생성하고(픽업희망시간, 요청사항 저장)
        //생성된 orderNo를 가지고 OrderDetail에 저장한다.
        //보여줄 값으로 주문넘버에 맞는 OrderDetail 정보
        //userId에 대한 쿠폰 목록, 보유포인트 내역


        // Purchase purchase = purchaseService.getCartList();
        // purchase.setOrderUserId("user01");
        //  purchase = purchaseService.getPoint(purchase.getOrderUserId());
        // addCart()
        // getCart()
        // getTotalPoint
        return model;
    }

    @RequestMapping(value = "addOrder", method= RequestMethod.POST)
    public String addOrder(@ModelAttribute("purchase")Purchase purchase, @ModelAttribute("user") User user,
                           @ModelAttribute("coupon") Coupon coupon, @ModelAttribute("point") Point point, Model model) throws Exception{
        //결제하기 클릭 시 입력한 결제방법과 결제금액 결제일시
        //
        System.out.println("/purchase/addCart : POST");
        //addOrder(),updateCouponStatus(),
        //       updatePoint (),updateTotalPoint ()

        purchaseService.updatePurchase(purchase);
        purchaseService.updateCouponStatus(coupon);
        purchaseService.updatePoint(point);
        purchaseService.updateTotalPoint(user);
        Map map = purchaseService.getOrderDetail(purchase.getOrderNo());
        model.addAttribute(purchase);



        return "forward:/purchase/getOrderUser.jsp";
    }




    @RequestMapping(value = "updateOrderCancel", method= RequestMethod.POST)
    public String updateOrderCancel() throws Exception{

        System.out.println("/purchase/updateOrderCancel : POST");
        //.updateOrderRefusal(),updatePoint(), updateTotalPoint()
        return "forward:/purchase/getOrderUser.jsp";
    }

    @RequestMapping(value = "getOrderList", method= RequestMethod.POST)
    public String getOrderList() throws Exception{

        System.out.println("/purchase/getOrderList : POST");
        //.updateOrderRefusal(),updatePoint(), updateTotalPoint()
        return "forward:/purchase/getOrderList.jsp";
    }


    //접수클릭시 주문상태코드 변경
    @RequestMapping(value = "updateOrderTranCode", method= RequestMethod.POST)
    public String updateOrderTranCode() throws Exception{

        System.out.println("/purchase/updateOrderTranCode : POST");
        //.updateOrderRefusal(),updatePoint(), updateTotalPoint()
        return "forward:/purchase/getOrder";
    }


    @RequestMapping(value = "updateBusiStatus", method= RequestMethod.POST)
    public String updateBusiStatus() throws Exception{

        System.out.println("/purchase/updateBusiStatus : POST");
        //.updateOrderRefusal(),updatePoint(), updateTotalPoint()
        return "forward:/purchase/getOrderList";
    }





}