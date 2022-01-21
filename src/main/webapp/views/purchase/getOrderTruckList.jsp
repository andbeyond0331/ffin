<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">

<!doctype html>
<html lang="ko">
<meta charset="EUC-KR">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<head>
    <jsp:include page="../../common/lib.jsp"/>
    <title>F.FIN | 주문접수</title></head>
<body>
<jsp:include page="/views/navbar.jsp"/>
<!-- Bootstrap Dropdown Hover CSS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>

<style>
    .btn-outline-success {
        color: #fae100;
        border-color: #fae100;
        margin: 0;
    }

    .btn-check:active+.btn-outline-success, .btn-check:checked+.btn-outline-success, .btn-outline-success.active, .btn-outline-success.dropdown-toggle.show, .btn-outline-success:active {
        color: #110000;
        background-color: #fae100;
        border-color: #fae100;
    }
    .btn-primary{
        color: #110000;
        background-color: #fae100;
        border-color: #fae100;
    }
    .btn.btn-outline-success:hover, .btn.btn-primary:hover{
        color: #110000;
        background-color: #fae100;
        border-color: #fae100;
    }
    .btn.btn-primary:hover{
        color: #110000;
        background-color: #ffffff;
        border-color: #fae100;
    }
    .btn.btn-outline-success:active, .btn.btn-primary:active{
        color: #110000;
        background-color: #fae100;
        border-color: #fae100;
    }

    .row {
        display: -ms-flexbox;
        display: flex;
        -ms-flex-wrap: wrap;
        flex-wrap: wrap;
        margin-right: -28px;
        margin-left: -17px;
    }

    /*장바구니내부 스크롤*/
    .card-body ul, .order-wrap-pc ul {
        max-height: 300px;
        overflow-x: hidden;
        overflow-y: auto;
    }
    body{
        margin-top: 80px;
    }
    .statusBtn{
        background-color: #fae100;
        color: #25323c;
        border-color: #fae100;
    }
    .statusBtn:hover{
        background-color: #fae100;
        color: #25323c;
        border-color: #fae100;
    }
    .statusBtn:after{
        background-color: #fae100;
        color: #25323c;
        border-color: #fae100;
    }
    .btn.btn-default-chk{
        background-color: #ffffff;
        color: #25323c;
        border-color: #fae100;
        border-radius: 50px;
    }
    .btn-check:checked+.btn.btn-default-chk, .btn-default-chk:hover, .btn-default-chk:checked{
        background-color: #fae100;
        color: #25323c;
        border-color: #fae100;
    }
    .container.orderCheck{
        margin-top: 70px;
        padding: 20px;
        background-color: #ffffff;
        box-shadow: 0 1px 2px 1px rgba(0,0,0,0.1);
        transition: 0.2s;
        border-radius: 20ox;
    }
    .orderList:hover{
        color: #fae100;
    }
</style>
<main>

    <div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel"
         tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">

                <div class="modal-body">

                    <div style="text-align: -webkit-center;">
                        <h5 class="modal-title" id="updateTruckCmtModalLabel" style=" width: fit-content; margin: 10px 0 25px 0; box-shadow: inset 0 -11px 0 #fae100;">주문 거절</h5>
                    </div>

                    <hr style="border-width: inherit;"/>

                    <div>
                        <div>
                            <div style="display: flex; flex-direction: column;">
                                <input type="radio" class="btn-check" name="orderNopeReason" id="btnradio1" style="margin: 0;"
                                       autocomplete="off" value="1" checked>
                                <label class="btn btn-default-chk" for="btnradio1" style="width: inherit; margin-left: 0;">고객 요청</label>
                            </div>
                        </div>

                        <div >
                            <div style="display: flex; flex-direction: column;">
                                <input type="radio" class="btn-check" name="orderNopeReason" id="btnradio2" style="margin: 0;"
                                       autocomplete="off" value="2">
                                <label class="btn btn-default-chk" for="btnradio2" style="width: inherit; margin-left: 0;">고객 정보 부정확</label>
                            </div>
                        </div>

                        <div >
                            <div style="display: flex; flex-direction: column;">
                                <input type="radio" class="btn-check" name="orderNopeReason" id="btnradio3" style="margin: 0;"
                                       autocomplete="off" value="3">
                                <label class="btn btn-default-chk" for="btnradio3" style="width: inherit; margin-left: 0;">주문 지연</label>
                            </div>
                        </div>
                        <div>
                            <div style="display: flex; flex-direction: column;">
                                <input type="radio" class="btn-check" name="orderNopeReason" id="btnradio4" style="margin: 0;"
                                       autocomplete="off" value="4">
                                <label class="btn btn-default-chk" for="btnradio4" style="width: inherit; margin-left: 0;">재료 소진</label>
                            </div>
                        </div>
                        <div>
                            <div style="display: flex; flex-direction: column;">
                                <input type="radio" class="btn-check" name="orderNopeReason" id="btnradio5" style="margin: 0;"
                                       autocomplete="off" value="5">
                                <label class="btn btn-default-chk" for="btnradio4" style="width: inherit; margin-left: 0;">기타</label>
                            </div>
                        </div>
                    </div>

                    <hr style="border-width: inherit;"/>

                    <div style="display: flex; justify-content: center;">
                        <button class="btn btn-cancle" data-bs-dismiss="modal" aria-label="Close">취소</button>
                        <button class="btn btn-default" data-bs-target="#exampleModalToggle2" data-bs-toggle="modal">다 음
                        </button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="exampleModalToggle2" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2"
         tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body">
                    <div  style="display: grid; text-align: -webkit-center; margin-bottom: 30px;">
                        <br/>
                        <h5 class="modal-title" id="exampleModalToggleLabel2" ><i class="far fa-check-circle fa-2x"></i></h5>
                        <span style="margin-top: 10px; font-size: 15px;">정말 주문을 취소 할까요?</span>
                    </div>

                    <hr style="border-width: inherit;"/>

                    <div style="display: flex; justify-content: center;">
                        <button class="btn btn-cancle" data-bs-dismiss="modal" aria-label="Close" style="padding: 5px 10px;">취소</button>
                        <button class="btn btn-default" style="padding: 5px 10px;" onclick="cancelPay()">확인</button>
                    </div>
                </div>
            </div>
        </div>
    </div>




    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <div  style="display: grid; text-align: -webkit-center; margin-bottom: 30px;">
                            <br/>
                            <h5 class="modal-title" id="staticBackdropLabel" ><i class="fas fa-power-off fa-2x"></i></h5>
                        <c:if test="${truck.truckBusiStatus.equals('1')}">
                            <span style="margin-top: 10px; font-size: 15px;">영업을 종료하시나요??</span>
                        </c:if>
                        <c:if test="${truck.truckBusiStatus.equals('0')}">
                            <span style="margin-top: 10px; font-size: 15px;">영업을 시작하시나요??</span>
                        </c:if>
                    </div>

                    <hr style="border-width: inherit;"/>

                    <div style="display: flex; justify-content: center;">
                        <button class="btn btn-cancle" data-bs-dismiss="modal" aria-label="Close" style="padding: 5px 10px;">취소</button>
                        <button class="btn btn-default" style="padding: 5px 10px;" id="busiStatus">확인</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- MAIN VIEW --%>

    <section class="client_section layout_padding" style="padding-top: 30px;">
        <div class="container">
            <div class="col-md-12 ">

                <div class="detail-box" style="margin-top: 100px; margin-bottom: 50px;">
                    <i class="fa fa-quote-left" aria-hidden="true"></i>
                    <h4 class="truckNameForMenu" style="margin-top: 10px;">
                        ${truck.truckName} 주문접수
                    </h4>
                    <input type="hidden" id="truckId" name="truckId" value="${truck.truckId}"/>
                </div>


                <div class="container orderCheck" style="min-height: 700px;  box-shadow: 0 1px 2px 1px rgba(0,0,0,0.1); transition: 0.2s;">
                    <div class="row col-12" style="min-height: inherit;">

                        <%-- 주문목록 --%>
                        <div class="col-6" style="padding: 20px; display: flex; flex-direction: column; justify-content: space-between;">
                            <div class="col-12" style="padding: 0;">

                                <div class="col-12" style="margin-bottom: 4px;" >
                                    <div class="col-12 row" style=" margin:0; display: flex; justify-content: space-between;">
                                        <div class="col-6" style="padding: 0; text-align: initial;"> 전체 :</div>
                                        <div class="col-6" style="padding: 0; text-align: right;">
                                            <div class="form-check form-switch">
                                                <c:if test="${truck.truckBusiStatus.equals('1')}">
                                                    <input class="form-check-input" type="checkbox" role="switch"
                                                           id="swCh" name="swCh"  data-bs-toggle="modal" data-bs-target="#staticBackdrop" checked>
                                                    <label class="form-check-label" for="swCh">영업중</label>
                                                </c:if>
                                                <c:if test="${truck.truckBusiStatus.equals('0')}">
                                                    <input class="form-check-input" type="checkbox" role="switch"
                                                           id="swCh" name="swCh"  data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                                                    <label class="form-check-label" for="swCh">영업종료</label>
                                                </c:if>

                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div style="display:-webkit-box; margin-top: 15px;">

                                        <ul class="nav nav-tabs" style="display: table-caption;">
                                            <li class="nav-item">
                                                <button class="btn btn-outline-success" id="ing" type="button">처리중</button>
                                            </li>
                                            <li class="nav-item">
                                                <button class="btn btn-outline-success" id="end" type="button">픽업완료</button>
                                            </li>
                                            <li class="nav-item">
                                                <button class="btn btn-outline-success" id="cancel" type="button">주문취소</button>
                                            </li>
                                        </ul>

                                    <div class="col-12" style="padding-left: 0;">

                                        <c:set var="i" value="0"/>
                                        <c:forEach var="cart" items="${map.get('list')}">
                                        <c:set var="i" value="${i+1}"/>

                                            <%--<div> ${i} </div>--%>
                                            <div class="col-12 orderList" style="display: flex; align-items: center; background-color: rgba(37,50,60,0.07); padding: 15px 0;">
                                                <div class="col-4" style="padding: 0;">
                                                    <a type="button" class="text-break" id="orderUserId">${cart.orderUserId.userId}</a>
                                                    <input type="hidden" id="orderNo" name="orderNo" value="${cart.orderNo}"/>
                                                </div>
                                                <div class="col-5" style="padding: 0;">
                                                    <div id="orderPickUp" style="text-align: left">
                                                        픽업희망시간 : ${cart.orderPickUpTime}분
                                                    </div>
                                                    <div style="text-align: left">
                                                        예상조리시간 : ${cart.orderCookingTime}분
                                                    </div>
                                                </div>
                                                <div class="col-3" style="padding: 0;">
                                                    <c:if test="${cart.orderStatus == 1}">
                                                        <span id="badgeClick1" class="badge badge-click" style="background-color: #2ec0f3; color: #110000; zoom: 115%;">주문대기</span>
                                                    </c:if>
                                                    <c:if test="${cart.orderStatus == 2}">
                                                        <span id="badgeClick2" class="badge badge-click" style="zoom: 115%; background-color: #2ef3b7; color: #110000">주문접수</span>
                                                    </c:if>
                                                    <c:if test="${cart.orderStatus == 3}">
                                                        <span id="badgeClick3" class="badge badge-click" style="zoom: 115%; background-color: #f5cb00; color: #110000">픽업요청</span>
                                                    </c:if>
                                                    <c:if test="${cart.orderStatus == 4}">
                                                        <span id="badgeClick4" class="badge badge-click" style="zoom: 115%;background-color: #f79865; color: #110000">픽업완료</span>
                                                    </c:if>
                                                    <c:if test="${cart.orderStatus == 5}">
                                                        <span id="badgeClick6" class="badge badge-click" style="zoom: 115%; background-color: #d9d9d9; color: #110000">주문취소</span>
                                                    </c:if>
                                                </div>
                                            </div>

                                            <%--<input type="hidden" id="orderNo" name="orderNo" value="${cart.odOrderNo.orderNo}"/>--%>
                                            <input type="hidden" id="userId" name="userId" value="${cart.orderUserId.userId}"/>
                                            <input type="hidden" id="orderStatus" name="orderStatus" value="${cart.orderStatus}"/>
                                            <input type="hidden" id="odMenuPrice" name="orderPickUpTime" value="${cart.orderPickUpTime}"/>
                                            <input type="hidden" id="orderCookingTime" name="orderCookingTime" value="${cart.orderCookingTime}"/>
                                            <input type="hidden" name="searchCondition" value="${search.searchCondition}">

                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%-- 주문상세정보 --%>
                        <div class="col-6" style="padding: 20px 0; display: flex; flex-direction: column; justify-content: space-between;">
                            <div class="col-12" style="padding: 0;">

                                <div class="col-12" style="margin-bottom: 4px;">
                                    <div class="col-12" id="CookingTime" style="padding: 0; margin:0; display: flex; justify-content: space-between;">
                                    </div>
                                </div>

                                <div style="display:flex; flex-direction: column; padding: 15px 10px 15px 15px; background-color: #f8f9fa;">

                                    <div >
                                        <h6 style=" box-shadow: inset 0 -11px 0 #fae100; width: fit-content;">고객정보</h6>
                                    </div>

                                    <div id="orderUserInfo" style="display: flex; align-items: center; padding: 10px 0; margin: 0 15px;">
                                        <div id="orderMenuHidden">
                                            <div id="pointNoCouponNo"></div>
<%--                                            <label for="orderRequest" class="col-form-label">고객정보 : </label>--%>
                                        </div>

                                        <div class="col-3" id="img" style="display: contents;"></div>

                                        <div style="display: flex; flex-direction: column; align-items: flex-start; margin-left: 25px;">
                                            <div id="usId" >
                                                <input type="hidden" name="usId" value=""/>${purchase.orderUserId.userId}
                                            </div>
                                            <div id="orNo"> 주문번호 : </div>
                                            <div id="paDa"> 주문일시 : </div>
                                            <div id="usUN"> 이름 : </div>
                                            <div id="usUP"> 연락처 : </div>
                                            <div id="paOp"> </div>
                                        </div>
                                    </div>

                                    <div id="orderPayInfo" style="display: flex; flex-direction: column; align-items: flex-start; padding: 10px 0; margin-top: 15px;">

                                        <div >
                                            <h6 style=" box-shadow: inset 0 -11px 0 #fae100; width: fit-content;">주문내역</h6>
                                        </div>

                                        <div  id="list" style="display: contents;">
<%--                                            <label for="orderRequest" class="col-form-label">주문내역</label>--%>
                                            <div id="order" style="padding: 0 15px;"></div>
                                            <div class="col-12" id="total"><p class="text-end">결제금액 : </p> </div>
                                        </div>
                                    </div>

                                    <div id="orderReqInfo" style="display: flex; flex-direction: column; align-items: flex-start; padding: 10px 0;">

                                        <div >
                                            <h6 style=" box-shadow: inset 0 -11px 0 #fae100; width: fit-content;">주문요청사항</h6>
                                        </div>

                                        <div id="oRt" style="display: contents;">
<%--                                            <label for="orderRequest" class="col-form-label">주문요청사항</label>--%>
                                            <textarea class="form-control" id="orderRequest" name="orderRequest"
                                                      value="" disabled></textarea>
                                        </div>

                                        <div id="cancelOrder"> </div>

                                        <div class="col-12" id="opt" style="text-align: end;">
                                            <label for="orderRequest" class="col-form-label">픽업희망시간 : </label>
                                        </div>

                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </section>
</main>

<script>

    $("#busiStatus").on("click",function(){
        var truckId = $("input[name='truckId']").val();
        var tb = $("input[name='swCh']:checked").val();


        if(tb == 'on'){
            tb=1;
        }else if(tb==undefined){
            tb=0;
        }

        $.ajax({
            url: "/purchase/json/updateBusiStatus",
            method: "POST",
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            data: {
                "truckId": truckId,
                "tb" : tb
            },
            success: function (data) {

                alert("영업모드 변경되었습니다!")

                window.location.reload();
            }
        });


    });

    $("#ing").on("click",function(){

        var truckId = $("input[name='truckId']").val();
        var search = "0";
        self.location = "/purchase/getOrderList?truckId="+truckId+"&search="+search

    });
    $("#cancel").on("click",function(){
        var truckId = $("input[name='truckId']").val();
        self.location = "/purchase/getOrderList?truckId="+truckId+"&search="+2
    })

    $("#end").on("click",function(){
        var truckId = $("input[name='truckId']").val();
        self.location = "/purchase/getOrderList?truckId="+truckId+"&search="+1
    })




    /*이용자아이디 클릭시*/
    $("a#orderUserId.text-break").on("click", function () {

        var orderNo = $(this).parent().find("input[name='orderNo']").val();
        var couponNo = 0;
        var pointNo = 0;

        $.ajax({
            url: "/purchase/json/getDetailOrder",
            method: "POST",
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            data: {
                "orderNo": orderNo,
            },
            success: function (data) {

                if(data.purchase.payCouponNo==null){
                }else{

                    couponNo = data.purchase.payCouponNo.couponNo
                }

                if(data.purchase.payPointNo == null){
                }else{
                    pointNo = data.purchase.payPointNo.pointNo
                }
                var usId = "";
                var orNo = "";
                var paDa = "";
                var usUN = "";
                var usUP = "";
                var paOp = "";
                var img = "";
                var oRt = "";
                var opt = "";
                var total = "";
                var CookingTime = "";
                var orderMenuHidden = "";
                var pointNoCouponNo = "";
                var cancel = "";






               switch(data.purchase.orderCancelReason) {
                   case 1:
                       cancel = "<div style='margin-bottom: 30px;'>" +
                           " <label  class='form-label label-name'>주문취소사유</label>" +
                           "<input type='text' class='form-control' value='구매의사 취소'  readonly style='width: 340px;' >" +
                           "</div>";
                       break;
                   case 2 :
                       cancel = "<div style='margin-bottom: 30px;'>" +
                           " <label  class='form-label label-name'>주문취소사유</label>" +
                           "<input type='text' class='form-control' value='메뉴 및 수량 변경'  readonly style='width: 340px;' >" +
                           "</div>";
                       break;
                   case 3 :
                       cancel = "<div style='margin-bottom: 30px;'>" +
                           " <label  class='form-label label-name'>주문취소사유</label>" +
                           "<input type='text' class='form-control' value='주문접수 지연'  readonly style='width: 340px;' >" +
                           "</div>";
                       break;
                   case 4 :
                       cancel = "<div style='margin-bottom: 30px;'>" +
                           " <label  class='form-label label-name'>주문취소사유</label>" +
                           "<input type='text' class='form-control' value='기 타'  readonly style='width: 340px;' >" +
                           "</div>";
                       break;
               }
                switch(data.purchase.orderNopeReason){
                case 1 :
                    cancel = "<div style='margin-bottom: 30px;'>"+
                        "<label  class='form-label label-name'>주문거절사유</label>"+
                        "<input type='text' class='form-control' value='고객 요청' readonly style='width: 340px;' >"
                    break;
                case 2 :
                    cancel = "<div style='margin-bottom: 30px;'>"+
                        "<label  class='form-label label-name'>주문거절사유</label>"+
                        "<input type='text' class='form-control' value='고객 정보 부정확' readonly style='width: 340px;' >"
                    break;
                case 3 :
                    cancel = "<div style='margin-bottom: 30px;'>"+
                        "<label  class='form-label label-name'>주문거절사유</label>"+
                        "<input type='text' class='form-control' value='주문 지연' readonly style='width: 340px;' >"
                    break;
                case 4 :
                    cancel = "<div style='margin-bottom: 30px;'>"+
                        "<label  class='form-label label-name'>주문거절사유</label>"+
                        "<input type='text' class='form-control' value='재료 소진' readonly style='width: 340px;' >"
                    break;
                case 5 :
                    cancel = "<div style='margin-bottom: 30px;'>"+
                        "<label  class='form-label label-name'>주문거절사유</label>"+
                        "<input type='text' class='form-control' value='기 타' readonly style='width: 340px;' >"
                    break;
                }














                usId ="<input type='hidden' name='usId' value='"+data.purchase.orderUserId.userId+"'/>"+data.purchase.orderUserId.userId;

                orNo = "주문번호 :"+data.purchase.orderNo;

                paDa = "주문일시 :"+data.purchase.payDateTime;
 /*<time datetime="YYYY-MM-DD">
                      <i class="fas fa-calendar-alt mr-2"></i>${orderDetail.odOrderNo.payDateTime}
                    </time>*/
                usUN = "이름 : "+data.purchase.orderUserId.userName;


                if(data.purchase.payOption == 0){
                    paOp = "결제방법 : 일반결제";
                }else if(data.purchase.payOption == 1){
                    paOp = "결제방법 : 휴대폰결제";
                }

                img = "<img src='/resources/image/"+data.purchase.orderUserId.userProImg+"' width='90' height='120' alt='userProImg' " +
                    "style='width: fit-content; border-radius: 10px; box-shadow: 0 1px 2px 1px rgba(0,0,0,0.1); transition: 0.2s;'>";

                usUP = "연락처 : "+data.purchase.orderUserId.userPhone;

                opt = "<label for='orderRequest' class='col-form-label'>픽업희망시간 : <strong>"+data.purchase.orderPickUpTime+"분</strong></label>";

                oRt = "<label for='orderRequest' class='col-form-label'></label><textarea class='form-control' id='orderRequest' name='orderRequest'"+
                                          "value='"+data.purchase.orderRequest+"' disabled>"+data.purchase.orderRequest+"</textarea>";

                if(data.purchase.orderStatus == 1){
                    CookingTime =  /*"<div>"+data.purchase.orderTruckId.truckName+"</div>"+*/
                            "<div>"+
                                "<button class='btn btn-primary' data-bs-toggle='modal' href='#exampleModalToggle' type='button'>거절</button>"+
                            "</div>"+
                            "<div>"+
                                "<input type='radio' class='btn-check' name='cookingTime' id='cookingTimes' autocomplete='off' value='5' checked>"+
                                "<label class='btn btn-outline-success' for='cookingTimes' >5분</label>"+
                                "<input type='radio' class='btn-check' name='cookingTime' id='cookingTimes1' autocomplete='off' value='10'>"+
                                "<label class='btn btn-outline-success' for='cookingTimes1' >10분</label>"+
                                "<input type='radio' class='btn-check' name='cookingTime' id='cookingTimes2' autocomplete='off'  value='15'>"+
                                "<label class='btn btn-outline-success' for='cookingTimes2'>15분</label>"+
                                "<input type='radio' class='btn-check' name='cookingTime' id='cookingTimes3' autocomplete='off'  value='20'>"+
                                "<label class='btn btn-outline-success' for='cookingTimes3'>20분</label>"+
                                "<input type='radio' class='btn-check' name='cookingTime' id='cookingTimes4' autocomplete='off'  value='30'>"+
                                "<label class='btn btn-outline-success' for='cookingTimes4'>30분</label>"+
                                "<input type='radio' class='btn-check' name='cookingTime' id='cookingTimes5' autocomplete='off'  value='40'>"+
                                "<label class='btn btn-outline-success' for='cookingTimes5'>40분</label>"+
                           "</div>"+
                            "<div>"+
                                "<button class='btn btn-primary' type='button' id='updateTranCode' name='updateTranCode' value='주문 접수'>접수</button>"+
                            "</div>";
                }else if(data.purchase.orderStatus == 2){

                    CookingTime = /* "<div>"+data.purchase.orderTruckId.truckName+"</div>"+*/
                            "<div>"+
                                "<button class='btn btn-primary' data-bs-toggle='modal' href='#exampleModalToggle' type='button'>주문거절</button>"+
                            "</div>"+
                           " <div>"+
                                "<button class='btn btn-primary' type='button' id='updateTranCode' name='updateTranCode' value='픽업 요청'>픽업요청</button>"+
                            "</div>";
                    }else if(data.purchase.orderStatus == 3){
                    CookingTime = /*"<div>"+data.purchase.orderTruckId.truckName+"</div>"+*/
                            "<div></div>"+
                            "<div>"+
                                "<button class='btn btn-primary' type='button' id='updateTranCode' name='updateTranCode' value='픽업 완료를 확인'>픽업완료</button>"+
                            "</div>";
                    }else if(data.purchase.orderStatus == 4){
                    CookingTime = /*"<div>"+data.purchase.orderTruckId.truckName+"</div>"+*/
                            "<div></div>"+
                            "<div>주문처리가 완료되었습니다 </div>";
                    }else if(data.purchase.orderStatus == 5){

                    CookingTime =/* "<div>"+data.purchase.orderTruckId.truckName+"</div>"+*/
                           "<div></div>"+
                            "<div >주문취소된 메뉴 입니다</div>";
                    }else if(data.purchase.orderStatus == 6) {

                    CookingTime = /*"<div>" + data.purchase.orderTruckId.truckName + "</div>" +*/
                        "<div></div>" +
                        "<div>주문처리가 완료되었습니다</div>";
                    }else if(data.purchase.orderStatus == 7) {

                        CookingTime = /*"<div>" + data.purchase.orderTruckId.truckName + "</div>" +*/
                            "<div></div>" +
                            "<div >주문처리가 완료되었습니다</div>";
                    }

                    orderMenuHidden = ""+
                    "<input type='hidden' name='payId' id='payId' value='"+data.purchase.payId+"'>"+
                    "<input type='hidden' name='purchaseOrder' id='purchaseOrder' value='"+data.purchase.orderNo+"'>"+
                    "<input type='hidden' name='truck' value='"+data.purchase.orderTruckId.truckId+"'>"+
                    "<input type='hidden' name='cookingTime' value='"+data.purchase.orderCookingTime+"'>";

                    pointNoCouponNo = "<input type='hidden' name='couponNo' value='"+couponNo+"'>"+
                    "<input type='hidden' name='pointNo' value='"+pointNo+"'>";

                total = "<p class='text-end'>결제금액 : <strong>"+data.purchase.payPrice+"원</strong></p>";
                $("#usId").html(usId);
                $("#orNo").html(orNo);
                $("#paDa").html(paDa);
                $("#usUN").html(usUN);
                $("#usUP").html(usUP);
                $("#paOp").html(paOp);
                $("#img").html(img);
                $("#oRt").html(oRt);
                $("#opt").html(opt);
                $("#total").html(total);
                $("#CookingTime").html(CookingTime);
                $("#orderMenuHidden").html(orderMenuHidden);
                $("#orderMenuHidden").append(pointNoCouponNo);
                $("#cancelOrder").html(cancel);




                var list = data.map;

                var totototoprice =0; // 전체 금액
                var totototoqty =0; // 수량
                var pricepriceprice =0 // 임시 가격

                var menuCount = 0;

                var optionNameShow = []; // 이름 보여지게 할 값 만들기~ (최종)
                var optionPriceShow = [];
                var odMenuQtyL = [];
                var odMenuImageL = [];
                var odMenuNameL = [];
                var totalshow =0;

                var name = "" ;
                var image = "";
                var qty = "";

                for(var i = 0; i<list.length; i++){
                    var odMenuImage = list[i]['odMenuImage'];
                    var odMenuName = list[i]['odMenuName'];
                    var odMenuPrice = list[i]['odMenuPrice'];
                    var odMenuQty = list[i]['odMenuQty'];
                    var odMenuQtyFlag = list[i]['odMenuQtyFlag'];
                    var odOptionName = list[i]['odOptionName'];
                    var odOptionPrice = list[i]['odOptionPrice'];
                    var odOptionGroupName = list[i]['odOptionGroupName'];

                    /* HHJ */

                    if (optionNameShow[menuCount] == undefined){
                        optionNameShow[menuCount] = " ";
                    }


                    if ( odMenuQtyFlag == '0'){

                        pricepriceprice = Number(odMenuPrice);
                        totototoqty = Number(odMenuQty);
                        menuCount++;
                        totalshow=0;
                        name = odMenuName;
                        image = odMenuImage;
                        qty = odMenuQty;
                        console.log("name"+name)
                        console.log("image"+image)
                        console.log("qty"+qty)

                        //pricepriceprice *= qtyqtyqty;
                        //console.log("pricepriceprice *= qtyqtyqty" + (pricepriceprice *= qtyqtyqty));
                        //tttttppppprrrr += Number(pricepriceprice)// 처음 들어온 값도 0, 이후엔 곱해짐 // 기존값 더함
                        //qtyqtyqty = Number(odMenuQty); // 수량값 기억하고 있도록 for문 밖에 선언해준 qtyqtyqty 에 저장
                    }else { // 옵션이면
                         //console.log("odOptionName : "+odOptionName)
                        pricepriceprice = Number(odOptionPrice);
                        optionNameShow[Number(menuCount-1)] += odOptionName + "(+" + odOptionPrice + ") ";

                    }
                    //console.log("optionNameShow[menuCount]: "+optionNameShow[menuCount])
                    totototoprice+= Number(pricepriceprice * totototoqty);
                    totalshow += Number(pricepriceprice * totototoqty);
                    optionPriceShow[Number(menuCount-1)] = totalshow;
                    odMenuQtyL[Number(menuCount-1)] = qty;
                    odMenuImageL[Number(menuCount-1)] = image;
                    odMenuNameL[Number(menuCount-1)] = name;
                    console.log("ttototototo :: " + totototoprice)

                    console.log("odMenuQtyL"+odMenuQtyL)
                    console.log("odMenuImageL"+odMenuImageL)
                    console.log("odMenuNameL"+odMenuNameL)


                }
                console.log("optionNameShow"+optionNameShow[0])
                console.log("optionNameShow"+odMenuQtyL[1])
                console.log("optionNameShow"+optionPriceShow[0])
                console.log("optionNameShow"+menuCount)
                /*alert(totalPrice) 총금액*/
                /*$("#order").html(menuList);*/
                for (var i = 0; i < menuCount; i++) {




                    divElemApply1 = "<div class=\"card mb-3\" style='border: 0; box-shadow: 0 1px 2px 1px rgba(0,0,0,0.1); transition: 0.2s;'>" +
                        " <div class=\"row g-0\">" +
                        "<div class=\"col-md-4\">" +
                        "<img src=\"/resources/menu/"+odMenuImageL[i]+"\" class=\"img-fluid rounded-start\" alt=\"image\" style='height: fit-content;'>" +
                        "</div>" +
                        "<div class=\"col-md-8\" style='padding: 0;'>" +
                        "<div class=\"card-body\" style='padding: 10px 0; text-align: initial;'>" +
                        "<h6 class=\"card-title\">" + odMenuNameL[i] + "</h6>" +
                        "<p class=\"card-text\"><small class=\"text-muted\"><span class='badge' style='background-color: #fae100; color: #110000'>&nbsp;옵션&nbsp;</span> " + optionNameShow[i] + "  </small><br>" +
                        "<small class=\"text-muted\"><span class='badge' style='background-color: #fae100; color: #110000'>&nbsp;수량&nbsp;</span> " + odMenuQtyL[i] + " <br><span class='badge' style='background-color: #fae100; color: #110000'>총 가격</span> " + optionPriceShow[i] + " </small></p>" +
                        "</div>" +
                        "</div>" +
                        "</div>" +
                        "</div>"




                    $('#order').html(divElemApply1);

                }
            }
        })
       /* self.location = "/purchase/getOrderList?truckId="+truckId+"&orderNo="+orderNo+"&search="+search;*/

    });



    /*주문접수버튼*/
    $("body").on("click","button[name='updateTranCode']", function () {

        var orderUserId = $("input[name='usId']").val();
        var orderCookingTime = $("input[name='cookingTime']:checked").val();
        if(orderCookingTime == undefined){
            orderCookingTime = $("input[name='cookingTime']").val();
        }
        var m_sg = $(this).val();
        console.log("m_sg: "+m_sg)

        $.ajax({
            url: "/purchase/json/updateTranCode",
            method: "POST",
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            data: {
                "orderNo": $("input[name='purchaseOrder']").val(),
                "orderCookingTime" : orderCookingTime
            },
            success: function (data) {

                alert("접수되었습니다!")

                console.log("purchase.socket::::" + socket);

                var orderTruckId = '${sessionScope.truck.truckId}';

                if(socket) {
                    // websocket에 보내기!!! (message, 보내는이, 받는이)

                    let socketMessage = "purchaseUser,"+orderTruckId+","+orderUserId+","+orderUserId+","+m_sg;
                    console.log("socketM::::" + socketMessage);
                    socket.send(socketMessage);
                }
                window.location.reload();
            }
        });

    });





    /* Iamport 환불시스템*/
    function cancelPay() {
        var pointNo = $("input[name='pointNo']").val();
        var couponNo = $("input[name='couponNo']").val();
        var payId = $("input[name='payId']").val();
        var orderNo = $("input[name='purchaseOrder']").val();
        var orderNopeReason = $("input[name='orderNopeReason']:checked").val();
        if(pointNo == undefined && pointNo =='' ){
            pointNo = 0;

        }else if(pointNo ===null && pointNo == ""){
            pointNo = 0;

        }

        if(couponNo == undefined || couponNo == '' && couponNo == null){
            couponNo = 0;
        }
        var orderCancelReason =0;

        $.ajax({
            url: "/purchase/json/payRefund", // 예: http://www.myservice.com/payments/cancel
            type: "POST",
            async: false,
            dataType: "json",
            data: {
                "payId": payId,
                "orderNo": orderNo,
                "orderNopeReason": orderNopeReason,
                "orderCancelReason": orderCancelReason,
                "couponNo": couponNo,
                "pointNo": pointNo,
            },

            success: function (map) {
                var orderTruckName = '${sessionScope.truck.truckName}';
                var orderUserId = $("input[name='usId']").val();
                if(socket) {
                    // websocket에 보내기!!! (message, 보내는이, 받는이)
                    let socketMessage = "cancel,"+orderTruckName+","+orderUserId+","+orderUserId;
                    console.log("socketM::::" + socketMessage);
                    socket.send(socketMessage);
                }
                location.reload();
            },
            error: function (xhr, status, error) {
                alert("[Error]" + error);
                return;
            }

        });

    }


</script>
</body>
<%--<jsp:include page="/views/footer.jsp"/>--%>
</html>