<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">

<!doctype html>
<html lang="ko">
<meta charset="EUC-KR">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<head>
    <jsp:include page="../../common/lib.jsp"/>
</head>
<body>
<jsp:include page="/views/navbar.jsp"/>
<!-- Bootstrap Dropdown Hover CSS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>

<style>
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
</style>
<main>

    <div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel"
         tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalToggleLabel">Modal 1</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">


                    <div class="container-fluid">
                        <div class="row">
                            <input type="radio" class="btn-check" name="orderNopeReason" id="btnradio1"
                                   autocomplete="off" value="1" checked>
                            <label class="btn btn-outline-primary" for="btnradio1">구매의사 취소</label>
                        </div>
                    </div>

                    <div class="container-fluid">
                        <div class="row">
                            <input type="radio" class="btn-check" name="orderNopeReason" id="btnradio2"
                                   autocomplete="off" value="2">
                            <label class="btn btn-outline-primary" for="btnradio2">메뉴 및 수량 변경</label>
                        </div>
                    </div>

                    <div class="container-fluid">
                        <div class="row">
                            <input type="radio" class="btn-check" name="orderNopeReason" id="btnradio3"
                                   autocomplete="off" value="3">
                            <label class="btn btn-outline-primary" for="btnradio3">주문접수 지연</label>
                        </div>
                    </div>
                    <div class="container-fluid">
                        <div class="row">
                            <input type="radio" class="btn-check" name="orderNopeReason" id="btnradio4"
                                   autocomplete="off" value="4">
                            <label class="btn btn-outline-primary" for="btnradio4">기 타</label>
                        </div>
                    </div>


                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary" data-bs-dismiss="modal" aria-label="Close">취소</button>
                    <button class="btn btn-primary" data-bs-target="#exampleModalToggle2" data-bs-toggle="modal">다 음
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="exampleModalToggle2" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2"
         tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalToggleLabel2">Modal 2</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    정말로 주문취소 하나요??
                </div>
                <div class="modal-footer">

                    <button class="btn btn-primary" data-bs-dismiss="modal" aria-label="Close">취소</button>
                    <button class="btn btn-primary" onclick="cancelPay()">확인</button>
                </div>
            </div>
        </div>
    </div>




    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">영업모드</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <c:if test="${truck.truckBusiStatus.equals('1')}">
                        영업종료하시겠습니까??
                    </c:if>
                    <c:if test="${truck.truckBusiStatus.equals('0')}">
                        영업시작하시겠습니까??
                    </c:if>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" id="busiStatus">등록</button>
                </div>
            </div>
        </div>
    </div>


    <div class="container py-4">
        <header class="pb-4 mb-5 py-4 border-bottom">
            <span class="fs-1">주문내역</span>
        </header>

        <div class="container-fluid">
            <div class="row justify-content-evenly">

                <div class="col-5 p-3 mb-2  bg-light text-dark">

                    <div class="row ">
                        <div class="col-2">

                            <button class="btn btn-primary" id="ing" type="button">처리중</button>

                            <button class="btn btn-primary" id="end" type="button">픽업완료</button>

                            <button class="btn btn-primary" id="cancel" type="button">주문취소</button>
                        </div>
                        <div class="col-10">
                            <div class="row justify-content-between">
                                <div class="col-6 text-center"> 전체 :</div>
                                <div class="col-6">
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
                                <br><br>
                            </div>

                            <c:set var="i" value="0"/>
                            <c:forEach var="cart" items="${map.get('list')}">
                                <c:set var="i" value="${i+1}"/>

                                <hr class="my-2">
                                <div class="row">
                                    <div class="col-1">
                                            ${i}
                                    </div>
                                    <div class="col-9">
                                        <div class="row">
                                            <div class="col-4">
                                                <a href="#" class="text-break" id="orderUserId">${cart.orderUserId.userId}</a>
                                                <input type="hidden" id="orderNo" name="orderNo" value="${cart.orderNo}"/>

                                            </div>
                                            <div class="col-6" id="orderPickUp">
                                                픽업희망시간 : ${cart.orderPickUpTime}
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-4">
                                                <a href="#" class="text-break"><%--${cart.odMenuName}--%></a>

                                            </div>
                                            <div class="col-6">
                                                예상조리시간 : ${cart.orderCookingTime}
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-1">
                                            ${cart.orderStatus}
                                    </div>
                                </div>

<%--                                <input type="hidden" id="orderNo" name="orderNo" value="${cart.odOrderNo.orderNo}"/>--%>
                                <input type="hidden" id="userId" name="userId"
                                       value="${cart.orderUserId.userId}"/>
                                <input type="hidden" id="truckId" name="truckId"
                                       value="${cart.orderTruckId.truckId}"/>
                                <input type="hidden" id="orderStatus" name="orderStatus"
                                       value="${cart.orderStatus}"/>
                                <input type="hidden" id="odMenuPrice" name="orderPickUpTime"
                                       value="${cart.orderPickUpTime}"/>
                                <input type="hidden" id="orderCookingTime" name="orderCookingTime"
                                       value="${cart.orderCookingTime}"/>
                                <input type="hidden" name="searchCondition" value="${search.searchCondition}">

                                <%--<input type="hidden" id="odMenuName" name="odMenuName" value="${cart.odMenuName}"/>--%>

                            </c:forEach>
                        </div>
                    </div>


                </div>

                <div class="col-6 p-3 mb-2 bg-light  text-dark">
                    <div class="row " id="CookingTime">
                        <c:if test="${purchase.orderStatus == 1}">
                        <div class="col-2"> 상호 : ${purchase.orderTruckId.truckName}</div>
                        <div class="col-2">
                            <button class="btn btn-primary" data-bs-toggle="modal" href="#exampleModalToggle"
                                    type="button">주문거절
                            </button>
                        </div>
                        <div class="col-6">

                            <input type="radio" class="btn-check" name="orderCookingTime" id="btnradio5" autocomplete="off"
                                   value="5" checked>
                            <label class="btn btn-primary btn-sm" for="btnradio5">5분</label>

                            <input type="radio" class="btn-check" name="orderCookingTime" id="btnradio6" autocomplete="off"
                                   value="10">
                            <label class="btn btn-primary btn-sm" for="btnradio6">10분</label>

                            <input type="radio" class="btn-check" name="orderCookingTime" id="btnradio7" autocomplete="off"
                                   value="15">
                            <label class="btn btn-primary btn-sm" for="btnradio7">15분</label>

                            <input type="radio" class="btn-check" name="orderCookingTime" id="btnradio8" autocomplete="off"
                                   value="20">
                            <label class="btn btn-primary btn-sm" for="btnradio8">20분</label>

                            <input type="radio" class="btn-check" name="orderCookingTime" id="btnradio9" autocomplete="off"
                                   value="30">
                            <label class="btn btn-primary btn-sm" for="btnradio9">30분</label>

                            <input type="radio" class="btn-check" name="orderCookingTime" id="btnradi010" autocomplete="off"
                                   value="40">
                            <label class="btn btn-primary btn-sm" for="btnradi010">40분</label>
                        </div>
                        <div class="col-2">

                            <button class="btn btn-primary" type="button" name="updateTranCode">주문접수</button>

                        </div>
                        </c:if>
                        <c:if test="${purchase.orderStatus == 2}">
                            <div class="col-2"> 상호 : ${purchase.orderTruckId.truckName}</div>
                            <div class="col-5">
                                <button class="btn btn-primary" data-bs-toggle="modal" href="#exampleModalToggle"
                                        type="button">주문거절
                                </button>
                            </div>
                            <div class="col-5">

                                <button class="btn btn-primary" type="button" name="updateTranCode">픽업요청</button>

                            </div>
                        </c:if>
                        <c:if test="${purchase.orderStatus == 3}">
                            <div class="col-2"> 상호 : ${purchase.orderTruckId.truckName}</div>
                            <div class="col-5">

                            </div>
                            <div class="col-5">

                                <button class="btn btn-primary" type="button" name="updateTranCode">픽업완료</button>
                            </div>
                        </c:if>
                        <c:if test="${purchase.orderStatus == 4}">
                            <div class="col-2"> 상호 : ${purchase.orderTruckId.truckName}</div>
                            <div class="col-5">

                            </div>
                            <div class="col-5">

                                주문처리가 완료되었습니다
                            </div>
                        </c:if>
                        <c:if test="${purchase.orderStatus == 5}">
                            <div class="col-2"> 상호 : ${purchase.orderTruckId.truckName}</div>
                            <div class="col-5">

                            </div>
                            <div class="col-5">

                                주문취소된 메뉴 입니다
                            </div>
                        </c:if>

                    </div>
                    <hr class="my-2">
                    <div class="row">

                        <div class="col-7">

                            <div class="row">
                                <label for="orderRequest" class="col-form-label">주문요청사항 :</label>
                                <textarea class="form-control" id="orderRequest" name="orderRequest"
                                          value="${purchase.orderRequest}" disabled>${purchase.orderRequest}</textarea>
                            </div>
                            <br>
                            <div class="row">
                                <label for="orderRequest" class="col-form-label">픽업희망시간
                                    : ${purchase.orderPickUpTime}</label>
                            </div>
                            <hr class="my-2">
                            <div class="row" id="list">

                                <label for="orderRequest" class="col-form-label">주문내역 :</label>

                                <div id="order"></div>

                                <c:set var="list" value="${orderMap.get('list')}"/>
                                <c:set var="i" value="0"/>
                                <c:forEach var="order" items="#{list}">
                                    <c:set var="i" value="${i+1}"/>


                                    <input type="hidden" id="orderMenuName" name="orderMenuName"
                                           value="${order.odMenuName}"/>
                                    <input type="hidden" id="orderOptionGroupName" name="orderOptionGroupName"
                                           value="${order.odOptionGroupName}"/>
                                    <input type="hidden" id="orderOptionName" name="orderOptionName"
                                           value="${order.odOptionName}"/>
                                    <input type="hidden" id="orderMenuQty" name="orderMenuQty"
                                           value="${order.odMenuQty}"/>
                                    <input type="hidden" id="orderMenuPrice" name="orderMenuPrice"
                                           value="${order.odMenuPrice}"/>
                                    <input type="hidden" id="orderOptionPrice" name="orderOptionPrice"
                                           value="${order.odOptionPrice}"/>
                                    <input type="hidden" id="orderMenuImage" name="orderMenuImage"
                                           value="${order.odMenuImage}"/>
                                    <input type="hidden" id="orderMenuQtyFlag" name="orderMenuQtyFlag"
                                           value="${order.odMenuQtyFlag}"/>


                                </c:forEach>

                                <div id="total"><p class="text-end">결제금액 : ${purchase.payPrice}</p> </div>
                            </div>

                        </div>
                        <div class="col-1">
                            <div class="d-flex" style="height: 672px;">
                                <div class="vr"></div>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="row">
                                <label for="orderRequest" class="col-form-label">고객정보
                                    : </label>
                            </div>
                            <input type="hidden" name="payId" id="payId" value="${purchase.payId}">
                            <input type="hidden" name="purchaseOrder" id="purchaseOrder" value="${purchase.orderNo}">
                            <input type="hidden" name="truck" value="${purchase.orderTruckId.truckId}">
                            <input type="hidden" name="cookingTime" value="${purchase.orderCookingTime}">
                            <input type="hidden" name="truckBusiStatus" value="${truck.truckBusiStatus}">
                            <div class="row">

                                <img src="/resources/image/${purchase.orderUserId.userProImg}" width="90" height="120"
                                     alt="주문상품 이미지">

                            </div>
                            <br>
                            <div class="row" id="usId">
                                ${purchase.orderUserId.userId}
                            </div>
                            <br>
                            <div class="row" id="orNo">
                                주문번호 :${purchase.orderNo}
                            </div>
                            <br>
                            <div class="row" id="paDa">
                                주문일시 :${purchase.payDateTime}
                            </div>
                            <br>
                            <div class="row" id="usUN">
                                이름 : ${purchase.orderUserId.userName}
                            </div>
                            <br>
                            <div class="row" id="usUP">
                                연락처 : ${purchase.orderUserId.userPhone}
                            </div>
                            <br>

                            <div class="row" id="paOp">
                                <c:if test="${purchase.payOption == 0}">
                                    결제방법 : 휴대폰결제
                                </c:if>
                                <c:if test="${purchase.payOption == 1}">
                                    결제방법 : 카카오페이
                                </c:if>
                                <c:if test="${purchase.payOption == 2}">
                                    결제방법 : 신용카드
                                </c:if>
                                <c:if test="${purchase.payOption == 3}">
                                    결제방법 : 무통장입금
                                </c:if>
                            </div>

                        </div>

                    </div>

                </div>
            </div>

        </div>
        <%--</div>--%>
    </div>

</main>

<script>
    $(function () {
        var odMenuNameCount = $("input[name='orderMenuName']").length;


        var odMenuNameL;
        var odOptionGroupNameL;
        var odOptionNameL;
        var odMenuQtyL;
        var odMenuPriceL;
        var odOptionPriceL;
        var odMenuImageL;

        for (var i = 0; i < odMenuNameCount; i++) {
            var odMenuName = $("input[name='orderMenuName']").eq(i).val();
            var odOptionGroupName = $("input[name='orderOptionGroupName']").eq(i).val();
            var odOptionName = $("input[name='orderOptionName']").eq(i).val();
            var odMenuQty = $("input[name='orderMenuQty']").eq(i).val();
            var odMenuPrice = $("input[name='orderMenuPrice']").eq(i).val();
            var odOptionPrice = $("input[name='orderOptionPrice']").eq(i).val();
            var odMenuImage = $("input[name='orderMenuImage']").eq(i).val();
            var odMenuQtyFlag = $("input[name='orderMenuQtyFlag']").eq(i).val();


            var odMenuImageCopy;
            var odMenuNameCopy;
            var odOptionGroupNameCopy;
            var odOptionNameCopy;
            var odMenuQtyCopy;
            var odMenuPriceCopy;
            var odOptionPriceCopy;
            var test2;
            var totalPrice;


            if (odMenuNameCopy != undefined && odMenuQtyFlag == 0) {
                odMenuNameCopy = odMenuNameCopy + "," + odMenuName;
                odMenuImageCopy = odMenuImageCopy + "," + odMenuImage;
                odMenuQtyCopy = odMenuQtyCopy + "," + odMenuQty;
                odMenuPriceCopy = odMenuPriceCopy + "," + odMenuPrice;
                totalPrice = totalPrice + parseInt(odMenuPrice);
            } else if (odMenuNameCopy == undefined) {

                odMenuNameCopy = odMenuName;
                odMenuImageCopy = odMenuImage;
                odMenuQtyCopy = odMenuQty;
                odMenuPriceCopy = odMenuPrice;
                totalPrice = parseInt(odMenuPrice);

            }

            odMenuNameL = odMenuNameCopy.split(",");
            odMenuImageL = odMenuImageCopy.split(",");
            odMenuQtyL = odMenuQtyCopy.split(",");
            odMenuPriceL = odMenuPriceCopy.split(",").map(Number);

            if (odOptionNameCopy == undefined) {
                odOptionNameCopy = odOptionName;
                test2 = odMenuName;
                odOptionGroupNameCopy = odOptionGroupName;
                odOptionPriceCopy = odOptionPrice;

            } else if (test2 != odMenuName ) {
                odOptionNameCopy = odOptionNameCopy + "/" + odOptionName;
                odOptionGroupNameCopy = odOptionGroupNameCopy + "/" + odOptionGroupName;
                odOptionPriceCopy = odOptionPriceCopy + "/" + odOptionPrice;

            } else if (odOptionNameCopy != undefined) {

                odOptionNameCopy = odOptionNameCopy + "," + odOptionName;
                test2 = odMenuName;
                odOptionGroupNameCopy = odOptionGroupNameCopy + "," + odOptionGroupName;
                odOptionPriceCopy = odOptionPriceCopy + "," + odOptionPrice;
            }

            odOptionNameL = odOptionNameCopy.split("/");
            odOptionGroupNameL = odOptionGroupNameCopy.split("/");



        }

        var sum = new Array() ;
        var test3 = new Array();

        odOptionPriceL = odOptionPriceCopy.split("/");

        /*alert("ordejoijafjs"+odOptionPriceL)*/
        for(var i = 0; i<odOptionPriceL.length; i++){
            test3 = odOptionPriceL[i].split(",");

            for(var j = 0; j<test3.length; j++){

                if(sum[i]==undefined){
                    sum[i] =Number(test3[j]);
                    /*alert("첫번째값"+Number(test3[j]))*/
                }else{
                    sum[i]=(Number(sum[i])+Number(test3[j]));
                    /*alert("계속 들어가는 값"+Number(sum[i]));*/
                }

            }
            /* alert("test3"+test3)
             alert("test 길이"+test3.length)*/



        }


        var menuPrice = 0;
        for (var i = 0; i < odMenuNameL.length; i++) {


            menuPrice += (sum[i] + odMenuPriceL[i]);


            divElemApply1 = "<div class=\"card mb-3\" >" +
                " <div class=\"row g-0\">" +
                "<div class=\"col-md-12\">" +
                "<div class=\"card-body\">" +
                "<h6 class=\"card-title\">" + odMenuNameL[i] + "</h6>" +
                "<p class=\"card-text\"><small class=\"text-muted font-size 12px\">옵션 " + odOptionNameL[i] + " :" + odOptionGroupNameL[i] + "  :</small><br><small class=\"text-muted\">수량 :" + odMenuQtyL[i] + " 가격 :" + (sum[i] + odMenuPriceL[i]) + " </small></p>" +
                "</div>" +
                "</div>" +
                "</div>" +
                "</div>"


            $('#order').append(divElemApply1);

        }
/*        divElemApply2 = "<input type=\"hidden\" name=\"orderPrice\" id=\"orderPrice\" value=\"" + menuPrice + "\">" +
            "<h5 id='price'>합계 : " + menuPrice + "</h5>"


        $('#total').append(divElemApply2);*/

    });


    /*




                        <div class="card mb-3 h-10" style="width: 300px; height: 90px" >
                            <div class="row g-0">
                                <div class="col-md-4">
                                    <img src="/resources/image/1.jpg" class="img-fluid rounded-start" alt="image">
                                </div>
                                <div class="col-md-8">
                                    <div class="card-body">
                                        <h5 class="card-title">${cart.odMenuName}</h5>
                                        <p class="card-text"></p>
                                        <p class="card-text"><small class="text-muted">${cart.odMenuPrice + cart.odOptionPrice}</small></p>
                                    </div>
                                </div>
                            </div>
                        </div>


                                        <input type="hidden" id="odMenuName" name="odMenuName" value="${cart.odMenuName}"/>
                                    <input type="hidden" id="odOptionGroupName" name="odOptionGroupName" value="${cart.odOptionGroupName}"/>
                                    <input type="hidden" id="odOptionName" name="odOptionName" value="${cart.odOptionName}"/>
                                    <input type="hidden" id="odMenuQty" name="odMenuQty" value="${cart.odMenuQty}"/>
                                    <input type="hidden" id="odMenuPrice" name="odMenuPrice" value="${cart.odMenuPrice}"/>
                                    <input type="hidden" id="odOptionPrice" name="odOptionPrice" value="${cart.odOptionPrice}"/>
                                    <input type="hidden" id="odMenuImage" name="odMenuImage" value="${cart.odMenuImage}"/>



*/
    $("#busiStatus").on("click",function(){
        var truckId = $("input[name='truck']").val();
        var tb = $("input[name='truckBusiStatus']").val();
        $.ajax({
            url: "/purchase/json/updateBusiStatus",
            method: "POST",
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            data: {
                "truckId": truckId,
                "tb" : tb
            },
            success: function (data) {

                alert("영업중모드 변경되었습니다!")

                window.location.reload();
            }
        });


    });

    $("#ing").on("click",function(){

        var truckId = $("input[name='truck']").val();
        var search = "0";
        self.location = "/purchase/getOrderList?truckId="+truckId+"&search="+search

    });
    $("#cancel").on("click",function(){
        var truckId = $("input[name='truck']").val();
        self.location = "/purchase/getOrderList?truckId="+truckId+"&search="+2
    })

    $("#end").on("click",function(){
        var truckId = $("input[name='truck']").val();
        self.location = "/purchase/getOrderList?truckId="+truckId+"&search="+1
    })

    $("#swCh").on("click",function(){

        var on = $("input[name='swCh']:checked").val();

    })



    /*이용자아이디 클릭시*/
    $("a#orderUserId.text-break").on("click", function () {
        var orderNo = $(this).parent().find("input[name='orderNo']").val();
        var truckId = $("input[name='truck']").val();
        var search = $("input[name='searchCondition']").val();

        self.location = "/purchase/getOrderList?truckId="+truckId+"&orderNo="+orderNo+"&search="+search;

    });

       /* $.ajax({
            url: "/purchase/json/getPurchase",
            method: "POST",
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            data: {
                "orderNo": orderNo

            },
            success: function (data) {

                alert("상세보기선택하였습니다!")
                alert(data.purchase.orderNo)
                    var ordeerPickUp ="";

                var list = data.map;
                var usId = "";
                var orNo = "";
                var paDa = "";
                var usUN = "";
                var usUP = "";
                var paOp = "";
                var orderMenuName = "";
                var orderOptionGroupName ="";
                var orderOptionName ="";
                var orderMenuQty ="";
                var orderMenuPrice ="";
                var orderOptionPrice ="";
                var orderMenuImage ="";
                var orderMenuQtyFlag ="";
                var list = "";
              /!* orderPickUp =  "<div class="col-6" id="orderPickUp">"
                                "픽업희망시간 : cart.orderPickUpTime}"
                             "</div>"*!/


                usId = "<div class='row' id='usId'>"+data.purchase.orderUserId.userId+"</div>"
                orNo = "<div class='row' id='orNo'>주문번호 :"+data.purchase.orderNo+"</div>"
                paDa = "<div class='row' id='paDa'>주문일시 :"+data.purchase.payDateTime+"</div>"

                usUN = "<div class='row' id='usUN'>이름 : "+data.purchase.orderUserId.userName+"</div>"
                usUP = "<div class='row' id='usUP'>연락처 : "+data.purchase.orderUserId.userPhone+"</div>"
                paOp = "<div class='row' id='paOp'>결제방법 :"+data.purchase.payOption+"</div>"


                <c:remove var="list"/>
                <% pageContext.setAttribute("list", "data.map");%>
                data.map.forEach(x=>{
                    alert(x.odMenuName)*/


/*

                        orderMenuName =     "<input type='text' id='orderMenuName' name='orderMenuName' value='"+x.odMenuName+"'/>"
                        /!*orderOptionGroupName = "<input type='text' id='orderOptionGroupName' name='orderOptionGroupName' value='"+x.odOptionGroupName+"'/>"
                        orderOptionName =   "<input type='hidden' id='orderOptionName' name='orderOptionName' value='"+x.odOptionName+"'/>"
                        orderMenuQty =      "<input type='hidden' id='orderMenuQty' name='orderMenuQty' value='"+x.odMenuQty+"'/>"
                        orderMenuPrice =    "<input type='hidden' id='orderMenuPrice' name='orderMenuPrice' value='"+x.odMenuPrice+"'/>"
                        orderOptionPrice =  "<input type='hidden' id='orderOptionPrice' name='orderOptionPrice' value='"+x.odOptionPrice+"'/>"
                        orderMenuImage =    "<input type='hidden' id='orderMenuImage' name='orderMenuImage' value='"+x.odMenuImage+"'/>"
                        orderMenuQtyFlag =   "<input type='hidden' id='orderMenuQtyFlag' name='orderMenuQtyFlag' value='"+x.odMenuQtyFlag+"'/>"*!/

            })
*/


/*
                        list =  "<label for='orderRequest' class='col-form-label'>주문내역 :</label>"+
                "<div id='order'></div>"+
               "<c:set var='i' value='0'/>"+
                "<c:forEach var='order' items='${data.map}'>"+
                "<c:set var='i' value='${i+1}'/>"+
                "<input type='hidden' id='orderMenuName' name='orderMenuName' value='"+order.odMenuName+"'/>"+
                "<input type='hidden' id='orderOptionGroupName' name='orderOptionGroupName' value='${order.odOptionGroupName}'/>"+
                "<input type='hidden' id='orderOptionName' name='orderOptionName'  value='${order.odOptionName}'/>"+
                "<input type='hidden' id='orderMenuQty' name='orderMenuQty' value='${order.odMenuQty}'/>"+
                "<input type='hidden' id='orderMenuPrice' name='orderMenuPrice' value='${order.odMenuPrice}'/>"+
                "<input type='hidden' id='orderOptionPrice' name='orderOptionPrice' value='${order.odOptionPrice}'/>"+
                "<input type='hidden' id='orderMenuImage' name='orderMenuImage' value='${order.odMenuImage}'/>"+
                "<input type='hidden' id='orderMenuQtyFlag' name='orderMenuQtyFlag' value='${order.odMenuQtyFlag}'/>"+
                "</c:forEach>"+
                "<div id='total'></div>"
*/
/*

                $('#orNo').html(orNo);
                $('#paDa').html(paDa);
                $('#usId').html(usId);
                $('#usUN').html(usUN);
                $('#usUP').html(usUP);
                $('#paOp').html(paOp);
               $('#orderMenuName').html(orderMenuName);
                 /!*$('#orderOptionGroupName').html(orderOptionGroupName);*!/
               /!* $('#orderOptionName').html(orderOptionName);
                $('#orderMenuQty').html(orderMenuQty);
                $('#orderMenuPrice').html(orderMenuPrice);
                $('#orderOptionPrice').html(orderOptionPrice);
                $('#orderMenuImage').html(orderMenuImage);
                $('#orderMenuQtyFlag').html(orderMenuQtyFlag);*!/

*/

    /*            /!*window.location.reload();*!/
            }
        });

    })
*/

    /*주문접수버튼*/
    $("button[name='updateTranCode']").on("click", function () {
        var orderCookingTime = $("input[name='orderCookingTime']:checked").val();
    if(orderCookingTime == undefined){
        orderCookingTime = $("input[name='cookingTime']").val();
    }
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

                    window.location.reload();
                }
            });

    });





    /* Iamport 환불시스템*/
    function cancelPay() {

        var payId = $("input[name='payId']").val();
        var orderNo = $("input[name='purchaseOrder']").val();
        var orderNopeReason = $("input[name='orderNopeReason']:checked").val();
        alert(orderNopeReason)
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
            },

            success: function (map) {
                location.href = "http://127.0.0.1:8080/";
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