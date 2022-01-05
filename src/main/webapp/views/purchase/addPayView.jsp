<%@ page contentType="text/html;charset=UTF-8" language="java"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>




<!doctype html>
<html lang="ko">
<meta charset="EUC-KR">


<head>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>
<jsp:include page="/views/navbar.jsp" />
<!-- Bootstrap Dropdown Hover CSS -->
<!--  ///////////////////////// CSS ////////////////////////// -->
<!-- 제이쿼리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous" type="text/javascript"></script>
<!-- 아임포트 -->
<script src ="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>


<style>

body{
    margin-top: 122px;

}


</style>
<script type="text/javascript">


    var kakaopay = function(){


        var IMP = window.IMP; // 생략가능
        IMP.init('imp67651684'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        var msg;

        var orderUserId = $("input[name='orderUserId.userId']").val();
        var orderTotalPrice= $("input[name='orderTotalPrice']").val();
        var orderTruckId = $("input[name='orderTruckId.truckId']").val();
        var payOption = $("input[name='payOption']:checked").val();
        var payPrice =  $("input[name='payPrice']").val();
        var pointAmt =  $("input[name='pointAmt']").val();
        var couponNo =  $("input[name='couponNo']").val();
        var orderNo = $("input[name='orderNo']").val();

        if(couponNo == "" || couponNo === undefined){
            couponNo = 0;
        }
        if(pointAmt == "" || pointAmt === undefined){
            pointAmt =0;
        }
        var postData = { "payOption" : payOption,
            "orderTotalPrice" :orderTotalPrice,
            "orderTruckId" : orderTruckId,
            "orderNo"  :  orderNo}

        if(payOption=='1'){
            IMP.request_pay({
                pg : 'danal',
                pay_method : 'phone',
                merchant_uid : 'merchant_' + new Date().getTime(),
                name : '주문명:결제테스트',
                amount : orderTotalPrice,
                buyer_tel : '010-2056-1658',
                buyer_name : 'receiverName'


            }, function(rsp) {
                if ( rsp.success ) {

                    alert("결제 들어왔어")


                    //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
                    $.ajax({
                        type: 'POST',
                        dataType : 'json',
                        url: "/purchase/json/addPayView", //cross-domain error가 발생하지 않도록 주의해주세요
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",

                        data : {
                            "payOption" : payOption,
                            "orderTotalPrice" :orderTotalPrice,
                            "orderUserId" : orderUserId,
                            "orderTruckId" : orderTruckId,
                            "orderNo" : orderNo,
                            "pointAmt" : pointAmt,
                            "couponNo" : couponNo,
                            "imp_uid" : rsp.imp_uid,



                        }


                    }).done(function(data) {
                        //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                        if ( everythings_fine ) {
                            msg = '결제가 완료되었습니다.';
                            msg += '\n고유ID : ' + rsp.name;
                            msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                            msg += '결제 금액 : ' + rsp.amount;


                            alert(msg);
                        } else {
                            //[3] 아직 제대로 결제가 되지 않았습니다.
                            //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
                        }
                    });
                    //성공시 이동할 페이지
                    $("form").attr("method" , "POST").attr("action" , "/purchase/getOrderUser").submit();
                } else {
                    msg = '결제에 실패하였습니다.';
                    msg += '에러내용 : ' + rsp.error_msg;
                    //실패시 이동할 페이지

                    alert(msg);
                }
            });}else if(payOption=='2'){
            IMP.request_pay({
                pg : 'kakaopay',
                pay_method : 'card',
                merchant_uid : 'merchant_' + new Date().getTime(),
                name : '주문명:결제테스트',
                amount : orderTotalPrice,
                buyer_tel : '010-2056-1658',
                buyer_name : 'receiverName'

            }, function(rsp) {
                if ( rsp.success ) {
                    //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
                    jQuery.ajax({
                        type: 'POST',
                        dataType : 'json',
                        url: "/purchase/json/addPayView", //cross-domain error가 발생하지 않도록 주의해주세요
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",

                        data : {
                            "payOption" : payOption,
                            "orderTotalPrice" :orderTotalPrice,
                            "orderUserId" : orderUserId,
                            "orderTruckId" : orderTruckId,
                            "orderNo" : orderNo,
                            "pointAmt" : pointAmt,
                            "couponNo" : couponNo,
                            "imp_uid" : rsp.imp_uid,

                        }
                    }).done(function(data) {
                        //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                        if ( everythings_fine ) {
                            msg = '결제가 완료되었습니다.';
                            msg += '\n고유ID : ' + rsp.name;
                            msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                            msg += '결제 금액 : ' + rsp.amount;


                            alert(msg);
                        } else {
                            //[3] 아직 제대로 결제가 되지 않았습니다.
                            //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
                        }
                    });
                    //성공시 이동할 페이지
                    $("form").attr("method" , "POST").attr("action" , "/purchase/getOrderUser").submit();
                } else {
                    msg = '결제에 실패하였습니다.';
                    msg += '에러내용 : ' + rsp.error_msg;
                    //실패시 이동할 페이지

                    alert(msg);
                }
            });}else if(payOption=='3'){
            IMP.request_pay({
                pg : 'danal',
                pay_method : 'vbank',
                merchant_uid : 'merchant_' + new Date().getTime(),
                name : prnm+"외 "+total+"건",
                amount : price,
                buyer_email : 'flora@naver.com',
                buyer_name : receiverName,
                buyer_tel : receiverPhone,
                buyer_addr : divyAddr,
                buyer_postcode : '123-456',
                //m_redirect_url : 'http://www.naver.com'
            }, function(rsp) {
                if ( rsp.success ) {
                    //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
                    jQuery.ajax({
                        url: "/purchase/json/addPayView", //cross-domain error가 발생하지 않도록 주의해주세요
                        type: 'POST',
                        dataType: 'json',
                        data: postData
                    }).done(function(data) {
                        //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                        if ( everythings_fine ) {
                            msg = '결제가 완료되었습니다.';
                            msg += '\n고유ID : ' + rsp.imp_uid;
                            msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                            msg += '\결제 금액 : ' + rsp.paid_amount;
                            msg += '카드 승인번호 : ' + rsp.apply_num;

                            alert(msg);
                        } else {
                            //[3] 아직 제대로 결제가 되지 않았습니다.
                            //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
                        }
                    });
                    //성공시 이동할 페이지
                    location.href="http://127.0.0.1:8080/purchase/getOrderUser";
                } else {
                    msg = '결제에 실패하였습니다.';
                    msg += '에러내용 : ' + rsp.error_msg;
                    //실패시 이동할 페이지

                    alert(msg);
                }
            });}

    }


    $(function() {
        $("button.btn.btn-primary:contains('진짜결제')").click(function() {

            kakaopay();


        });
    });

    $(function() {
        $("button.btn.btn-primary:contains('뒤로가기')").click(function () {
            history.go(-1);

        });
    });

    // coupon modal
    var count = 0;

    $(function(){

        var modal = $('#myModal');


        modal.find('button.btn-primary').on("click", function(){
            alert("ssa")

            realCouponDcPrice = modal.find('input[name=options]:checked').val();
          /*  var couponNo =modal.find('input[name=couponNumber]').val();*/
            console.log(realCouponDcPrice + " : realOptionGroupName");
            data = realCouponDcPrice.split(",");
            var couponDcPrice = data[0];
            var couponNo = data[1];
            console.log(couponNo + ": couponNo");

            append = "<input type=\"hidden\" id=\"couponNo\" name=\"couponNo\" value=\""+couponNo+"\">";

            alert(append + ":append");

            $('#couponDcPrice').val(couponDcPrice);
            $('#test').append(append);

             modal.modal('hide');

        });

    });

    $(function() {
        $("button.btn.btn-outline-secondary:contains('적용')").click(function () {

            usePoint = $('input[name="usePoint"]').val();

            alert(usePoint)
            append = "<input type=\"hidden\" id=\"pointAmt\" name=\"pointAmt\" value=\""+usePoint+"\">";

            $('#usePointAmt').append(append);
        });

    });

</script>


<form name="addPurchase" style="margin-top: 90px">
    <!-- Modal -->
    <%--Modal 작은칸--%>
    <div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">

                    <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <c:set var="i" value="0"/>
                    <c:forEach var="cart" items="${map.get('list')}">
                        <c:set var="i" value="${i+1}" />
                        <div class="card mb-3" style="max-width: 540px;">
                            <div class="row g-0">
                                <div class="col-md-4">
                                        ${i}
                                    <img src="/resources/image/1.jpg" class="img-fluid rounded-start" alt="image">
                                </div>
                                <div class="col-md-8">
                                    <div class="card-body">
                                        <h5 class="card-title">${cart.odMenuName}</h5>
                                        <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
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
                    </c:forEach>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary">쿠폰 적용</button>
                </div>
            </div>
        </div>
    </div>


    <div class="container py-4">
        <header class="pb-4 mb-5 border-bottom">
            <span class="fs-1">결제하기</span>
        </header>
        <div class="row gx-5">
            <div class="col">
                <div class="container">
                    <div class="row">
                        <br>
                        <div class="col-sm-12">
                            <input type="hidden" name="orderTruckId.truckId" value="${purchase.orderTruckId.truckId}">
                            <input type="hidden" name="payPrice" value="${purchase.payPrice}">
                            <input type="hidden" name="orderUserId.userId" value="${purchase.orderUserId.userId}">
                            <input type="hidden" name="orderNo" value="${purchase.orderNo}">
                            <input type="hidden" name="orderTotalPrice" value="${purchase.orderTotalPrice}"/>
                            <h3>할인 및 적립금</h3>
                        </div>
                    </div>
                    <br>
                    <div class="row" id="test">
                        <label for="couponDcPrice" class="col-sm-offset-1 col-sm-3 control-label">할인쿠폰</label>
                        <br>
                        <div class="input-group">
                            <input type="text" class="form-control" id="couponDcPrice" name="couponDcPrice" placeholder="쿠폰을 적용하세요" value="${coupon.couponDcPrice}" disabled>
                            <span class="input-group-text">원</span>
                            <button type="button" class="btn-close" aria-label="Close"></button>
                            <input class="btn btn-outline-secondary" type="button" data-bs-toggle="modal" data-bs-target="#myModal" value="쿠폰적용"></input>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <label for="usePoint" class="col-sm-offset-1 col-sm-3 control-label">적립금</label>
                        <div class="input-group mb-3" id="usePointAmt">
                            <span class="input-group-text">${totalPoint.userTotalPoint}</span>
                            <input type="text" class="form-control" id="usePoint" name="usePoint" placeholder="입력"  value="${point.pointAmt}" >
                            <input class="btn btn-outline-secondary" type="button" id="button-addon2" value="적용"></input>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="container">
                                적립금은 1000단위로 사용가능합니다.
                            </div>
                        </div>
                    </div>
                 <br>
                    <hr class="my-lg-12">
                    <div class="row">
                        <div class="col-sm-12">
                            <h3>결제방법</h3>
                        </div>
                    </div>


                    <div class="container">
                        <div class="row row-cols-2">
                            <div class="col"><input type="radio" class="btn-check" name="payOption" id="btnradio1" value="1" autocomplete="off" checked>
                                <label class="btn btn-outline-primary w-100" for="btnradio1" >다날</label>
                            </div>
                            <div class="col"><input type="radio" class="btn-check" name="payOption" id="btnradio2" value="2" autocomplete="off" >
                                <label class="btn btn-outline-primary w-100" for="btnradio2">카카오 페이</label>
                            </div>

                        </div>
                    </div>
                    <div class="container">
                        <div class="row row-cols-2">
                            <div class="col"><input type="radio" class="btn-check" name="payOption" id="btnradio3" value="3" autocomplete="off" >
                                <label class="btn btn-outline-primary w-100" for="btnradio3">신용카드</label>
                            </div>
                            <div class="col"><input type="radio" class="btn-check" name="payOption" id="btnradio4" value="4" autocomplete="off" >
                                <label class="btn btn-outline-primary w-100" for="btnradio4">무통장입금</label>
                            </div>

                        </div>
                    </div>
                </div>
            </div>






























            <div class="col">
                <div class="jumbotron ">
                    <div class="tip-off">
                        <h6>주문 상품 정보</h6>
                        <div class="row">
                            <div class="col-xs-12 col_ctr">
                                <!--상품정보에서 상품 이미지 및 가격과 가격 생성-->

                                <div class="shop_item_thumb">

                                        <div class="product_img_wrap">
                                            <img src="/resources/image/1.jpg" width="90" height="90" alt="주문상품 이미지">
                                        </div>
                                        <div class="product_info_wrap">
                                            <span class="shop_item_title">Aqua Culture Large Vase</span>
                                            <div class="shop_item_opt">
                                                <p>1개</p>
                                            </div>
                                            <div class="shop_item_pay">
                                                <span class="text-bold text-14">KRW 31,000</span>
                                            </div>
                                        </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tip-off">
                        <h6>주문 상품 정보</h6>
                        <div class="row">
                            <div class="col-xs-12 col_ctr">
                                <!--상품정보에서 상품 이미지 및 가격과 가격 생성-->

                                <div class="shop_item_thumb">
                                        <div class="product_img_wrap">
                                            <img src="https://cdn.imweb.me/thumbnail/20211107/84d566e0697a2.jpg" width="90" height="90" alt="주문상품 이미지">
                                        </div>
                                        <div class="product_info_wrap">
                                            <span class="shop_item_title">1year diary(ver.02) [pvc커버 포함]</span>
                                            <div class="shop_item_opt">
                                                <p>1개</p>
                                            </div>
                                            <div class="shop_item_pay">
                                                <span class="text-bold text-14">16,500원</span>
                                            </div>
                                        </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <button type="button" class="btn btn-primary btn-lg" >
                        뒤로가기
                    </button>

                    <button type="button" class="btn btn-primary btn-lg" >
                        진짜결제
                    </button>
                </div>

            </div>
        </div>
    </div>


</form>

<jsp:include page="/views/footer.jsp" />
</body>
</html>
