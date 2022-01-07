<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html lang="ko">
<meta charset="EUC-KR">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<jsp:include page="../../common/lib.jsp"/>
<head>


</head>
<body>
<jsp:include page="/views/navbar.jsp"/>
<!-- Bootstrap Dropdown Hover CSS -->
<!--  ///////////////////////// CSS ////////////////////////// -->
<!-- 제이쿼리 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"
/>//        crossorigin="anonymous" type="text/javascript"></script>
<!-- 아임포트 -->
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>


<style>

    body {
        margin-top: 122px;

    }
    #priceT{
        margin: 1px;
    }


</style>
<script type="text/javascript">


    var kakaopay = function () {


        var IMP = window.IMP; // 생략가능
        IMP.init('imp67651684'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        var msg;

        var orderUserId = $("input[name='orderUserId.userId']").val();
        var orderTotalPrice = $("input[name='orderTotalPrice']").val();
        var orderTruckId = $("input[name='orderTruckId.truckId']").val();
        var payOption = $("input[name='payOption']:checked").val();
        var payPrice = $("input[name='payPrice']").val();
        var pointAmt = $("input[name='pointAmt']").val();
        var couponNo = $("input[name='couponNo']").val();
        var orderNo = $("input[name='orderNo']").val();

        if (couponNo == "" || couponNo === undefined) {
            couponNo = 0;
        }
        if (pointAmt == "" || pointAmt === undefined) {
            pointAmt = 0;
        }
        var postData = {
            "payOption": payOption,
            "orderTotalPrice": orderTotalPrice,
            "orderTruckId": orderTruckId,
            "orderNo": orderNo
        }

        if (payOption == '1') {
            IMP.request_pay({
                pg: 'danal',
                pay_method: 'phone',
                merchant_uid: 'merchant_' + new Date().getTime(),
                name: '주문명:결제테스트',
                amount: orderTotalPrice,
                buyer_tel: '010-2056-1658',
                buyer_name: 'receiverName'


            }, function (rsp) {
                if (rsp.success) {

                    /*alert("결제 들어왔어")*/


                    //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
                    $.ajax({
                        type: 'POST',
                        dataType: 'json',
                        url: "/purchase/json/addPayView", //cross-domain error가 발생하지 않도록 주의해주세요
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",

                        data: {
                            "payOption": payOption,
                            "orderTotalPrice": orderTotalPrice,
                            "orderUserId": orderUserId,
                            "orderTruckId": orderTruckId,
                            "orderNo": orderNo,
                            "pointAmt": pointAmt,
                            "couponNo": couponNo,
                            "imp_uid": rsp.imp_uid,


                        }


                    }).done(function (data) {
                        //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                        if (everythings_fine) {
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
                    $("form").attr("method", "POST").attr("action", "/purchase/getOrderUser").submit();
                } else {
                    msg = '결제에 실패하였습니다.';
                    msg += '에러내용 : ' + rsp.error_msg;
                    //실패시 이동할 페이지

                    alert(msg);
                }
            });
        } else if (payOption == '2') {
            IMP.request_pay({
                pg: 'kakaopay',
                pay_method: 'card',
                merchant_uid: 'merchant_' + new Date().getTime(),
                name: '주문명:결제테스트',
                amount: orderTotalPrice,
                buyer_tel: '010-2056-1658',
                buyer_name: 'receiverName'

            }, function (rsp) {
                if (rsp.success) {
                    //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
                    jQuery.ajax({
                        type: 'POST',
                        dataType: 'json',
                        url: "/purchase/json/addPayView", //cross-domain error가 발생하지 않도록 주의해주세요
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",

                        data: {
                            "payOption": payOption,
                            "orderTotalPrice": orderTotalPrice,
                            "orderUserId": orderUserId,
                            "orderTruckId": orderTruckId,
                            "orderNo": orderNo,
                            "pointAmt": pointAmt,
                            "couponNo": couponNo,
                            "imp_uid": rsp.imp_uid,

                        }
                    }).done(function (data) {
                        //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                        if (everythings_fine) {
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
                    $("form").attr("method", "POST").attr("action", "/purchase/getOrderUser").submit();
                } else {
                    msg = '결제에 실패하였습니다.';
                    msg += '에러내용 : ' + rsp.error_msg;
                    //실패시 이동할 페이지

                    alert(msg);
                }
            });
        } else if (payOption == '3') {
            IMP.request_pay({
                pg: 'danal',
                pay_method: 'vbank',
                merchant_uid: 'merchant_' + new Date().getTime(),
                name: prnm + "외 " + total + "건",
                amount: price,
                buyer_email: 'flora@naver.com',
                buyer_name: receiverName,
                buyer_tel: receiverPhone,
                buyer_addr: divyAddr,
                buyer_postcode: '123-456',
                //m_redirect_url : 'http://www.naver.com'
            }, function (rsp) {
                if (rsp.success) {
                    //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
                    jQuery.ajax({
                        url: "/purchase/json/addPayView", //cross-domain error가 발생하지 않도록 주의해주세요
                        type: 'POST',
                        dataType: 'json',
                        data: postData
                    }).done(function (data) {
                        //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                        if (everythings_fine) {
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
                    location.href = "http://127.0.0.1:8080/purchase/getOrderUser";
                } else {
                    msg = '결제에 실패하였습니다.';
                    msg += '에러내용 : ' + rsp.error_msg;
                    //실패시 이동할 페이지

                    alert(msg);
                }
            });
        }

    }


    $(function () {
        $("button.btn.btn-primary:contains('진짜결제')").click(function () {

            kakaopay();


        });
    });

    $(function () {
        $("button.btn.btn-primary:contains('뒤로가기')").click(function () {
            history.go(-1);

        });
    });

    // coupon modal
    var count = 0;

    $(function () {

        var modal = $('#myModal');


        modal.find('button.btn-primary').on("click", function () {

            var couponCheck = $("input[name='couponNo']").val()
            if (couponCheck == undefined) {
                realCouponDcPrice = modal.find('input[name=options]:checked').val();
                /*  var couponNo =modal.find('input[name=couponNumber]').val();*/
                console.log(realCouponDcPrice + " : realOptionGroupName");
                data = realCouponDcPrice.split(",");
                var couponDcPrice = data[0];
                var couponNo = data[1];
                console.log(couponNo + ": couponNo");

                append = "<input type=\"hidden\" id=\"couponNo\" name=\"couponNo\" value=\"" + couponNo + "\">";

                /*alert(append + ":append");*/

                $('#couponDcPrice').val(couponDcPrice);
                $('#test').append(append);

                modal.modal('hide');
            } else {
                alert("사용중인 쿠폰이 있습니다.")
            }

        });

    });

    $(function () {
        $("#button-addon2").click(function () {
            pointCheck = $("input[name='pointAmt']").val();
            if (pointCheck == undefined) {
                usePoint = $('input[name="usePoint"]').val();
                if (usePoint != "") {
                    if (usePoint % 1000 == 0) {
                        append = "<input type=\"hidden\" id=\"pointAmt\" name=\"pointAmt\" value=\"" + usePoint + "\">";

                        $('#usePointAmt').append(append);
                    } else {
                        alert("포인트는 1000단위로 사용가능합니다.")
                    }
                } else {
                    alert("사용할 포인트를 입력해주세요")
                }
            } else {
                alert("사용중인 포인트가 있습니다.")
            }
        });

    });


    $(function () {
        $('#removeCoupon').click(function () {
            var couponRe = document.getElementById("couponDcPrice");
            var couponde = document.getElementById("couponNo");
            couponde.remove();
            couponRe.value = "";
        });
    });

    $(function () {
        $('#removePoint').click(function () {
            var pointde = document.getElementById("pointAmt");
            var pointRe = document.getElementById("usePoint");
            pointde.remove();
            pointRe.value = "";
        });
    });


</script>


<form name="addPurchase">

    <!-- Modal coupon취소-->
    <div class="modal fade" id="couponCancel" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="couponCa">쿠폰</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    쿠폰 사용을 취소하겠습니까?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">뒤로</button>
                    <button type="button" class="btn btn-primary" id="removeCoupon" name="removeCoupon">확인</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal point취소 -->
    <div class="modal fade" id="pointCancel" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="pointCa">포인트</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    포인트 사용을 취소하겠습니까?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">뒤로</button>
                    <button type="button" class="btn btn-primary" id="removePoint">확인</button>
                </div>
            </div>
        </div>
    </div>


    <%--Modal coupon적용--%>
    <div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">

                    <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <table class="table">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">First</th>
                            <th scope="col">Last</th>
                            <th scope="col">Handle</th>
                        </tr>
                        </thead>
                        <c:set var="i" value="0"/>
                        <c:forEach var="couponLis" items="${couponList.get('list')}">
                            <c:set var="i" value="${i+1}"/>
                            <tr>
                                <th scope="row">${i}</th>
                                <td><label class="btn btn-secondary active">
                                    <input type="radio" name="options" id="option${i}" autocomplete="off"
                                           value="${couponLis.couponDcPrice}" checked> Active
                                </label></td>
                                <td>${couponLis.couponDcPrice}</td>
                                <td>${couponLis.couponType}</td>
                                <td>${couponLis.couponStatus}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-bs-dismiss="modal">Close</button>
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
                            <input type="text" class="form-control" id="couponDcPrice" name="couponDcPrice"
                                   placeholder="쿠폰을 적용하세요" value="${coupon.couponDcPrice}" disabled>
                            <span class="input-group-text">원</span>
                            <a href="#myModal"> <input class="btn btn-outline-secondary" type="button"
                                                       data-bs-toggle="modal"
                                                       data-bs-target="#myModal" value="쿠폰적용"/></a>
                            <button type="button" class="btn-close" aria-label="Close" data-bs-toggle="modal"
                                    data-bs-target="#couponCancel"></button>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <label for="usePoint" class="col-sm-offset-1 col-sm-3 control-label">적립금</label>
                        <div class="input-group mb-3" id="usePointAmt">
                            <span class="input-group-text">${totalPoint.userTotalPoint}</span>
                            <input type="text" class="form-control" id="usePoint" name="usePoint" placeholder="입력"
                                   value="${point.pointAmt}">
                            <input class="btn btn-outline-secondary" type="button" id="button-addon2"
                                   value="적용"/>
                            <button type="button" class="btn-close" aria-label="Close" data-bs-toggle="modal"
                                    data-bs-target="#pointCancel"></button>
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
                            <div class="col"><input type="radio" class="btn-check" name="payOption" id="btnradio1"
                                                    value="1" autocomplete="off" checked>
                                <label class="btn btn-outline-primary w-100" for="btnradio1">휴대폰결제</label>
                            </div>
                            <div class="col"><input type="radio" class="btn-check" name="payOption" id="btnradio2"
                                                    value="2" autocomplete="off">
                                <label class="btn btn-outline-primary w-100" for="btnradio2">카카오 페이</label>
                            </div>

                        </div>
                    </div>
                    <div class="container">
                        <div class="row row-cols-2">
                            <div class="col"><input type="radio" class="btn-check" name="payOption" id="btnradio3"
                                                    value="3" autocomplete="off">
                                <label class="btn btn-outline-primary w-100" for="btnradio3">신용카드</label>
                            </div>
                            <div class="col"><input type="radio" class="btn-check" name="payOption" id="btnradio4"
                                                    value="4" autocomplete="off">
                                <label class="btn btn-outline-primary w-100" for="btnradio4">무통장입금</label>
                            </div>

                        </div>
                    </div>
                </div>
            </div>


            <div class="col">
                <div class="jumbotron ">


                    <div class="row">
                        <div class="col-sm-12">
                            <h3>주문내역</h3>
                        </div>
                    </div>
                    <hr class="my-lg-12">
                    <div class="row">
                    <div class="col-sm-12">
                        <h3>${purchase.orderTruckId.truckId}</h3>
                    </div>
                </div>
                    <div id="order"></div>
                    <c:set var="i" value="0"/>
                    <c:forEach var="cart" items="${map.get('list')}">
                        <c:set var="i" value="${i+1}"/>


                        <input type="hidden" id="odMenuName" name="odMenuName" value="${cart.odMenuName}"/>
                        <input type="hidden" id="odOptionGroupName" name="odOptionGroupName"
                               value="${cart.odOptionGroupName}"/>
                        <input type="hidden" id="odOptionName" name="odOptionName" value="${cart.odOptionName}"/>
                        <input type="hidden" id="odMenuQty" name="odMenuQty" value="${cart.odMenuQty}"/>
                        <input type="hidden" id="odMenuPrice" name="odMenuPrice" value="${cart.odMenuPrice}"/>
                        <input type="hidden" id="odOptionPrice" name="odOptionPrice" value="${cart.odOptionPrice}"/>
                        <input type="hidden" id="odMenuImage" name="odMenuImage" value="${cart.odMenuImage}"/>
                        <input type="hidden" id="odMenuQtyFlag" name="odMenuQtyFlag" value="${cart.odMenuQtyFlag}"/>


                    </c:forEach>
                    <hr class="my-lg-12">
                    <div id="total"></div>


                    <button type="button" class="btn btn-primary btn-lg">
                        뒤로가기
                    </button>

                    <button type="button" class="btn btn-primary btn-lg">
                        진짜결제
                    </button>
                </div>

            </div>
        </div>
    </div>


</form>

<jsp:include page="/views/footer.jsp"/>


<script>
    $(function () {
        var odMenuNameCount = $("input[name='odMenuName']").length;


        var odMenuNameL;
        var odOptionGroupNameL;
        var odOptionNameL;
        var odMenuQtyL;
        var odMenuPriceL;
        var odOptionPriceL;
        var odMenuImageL;

        for (var i = 0; i < odMenuNameCount; i++) {
            var odMenuName = $("input[name='odMenuName']").eq(i).val();
            var odOptionGroupName = $("input[name='odOptionGroupName']").eq(i).val();
            var odOptionName = $("input[name='odOptionName']").eq(i).val();
            var odMenuQty = $("input[name='odMenuQty']").eq(i).val();
            var odMenuPrice = $("input[name='odMenuPrice']").eq(i).val();
            var odOptionPrice = $("input[name='odOptionPrice']").eq(i).val();
            var odMenuImage = $("input[name='odMenuImage']").eq(i).val();
            var odMenuQtyFlag = $("input[name='odMenuQtyFlag']").eq(i).val();


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

            } else if (test2 != odMenuName && odOptionNameCopy.substring(odOptionNameCopy.length - 1, odOptionNameCopy.length) != "/") {
                odOptionNameCopy = odOptionNameCopy + "/" + odOptionName;
                odOptionGroupNameCopy = odOptionGroupNameCopy + "/" + odOptionGroupName;
                odOptionPriceCopy = odOptionPriceCopy + "/" + odOptionPrice;

            } else if (odOptionNameCopy != undefined) {

                odOptionNameCopy = odOptionNameCopy + "," + odOptionName;
                test2 = odMenuName;
                odOptionGroupNameCopy = odOptionGroupNameCopy + "," + odOptionGroupName;
                odOptionPriceCopy = odOptionPriceCopy + odOptionPrice;
            }

            odOptionNameL = odOptionNameCopy.split("/");
            odOptionGroupNameL = odOptionGroupNameCopy.split("/");
            odOptionPriceL = odOptionPriceCopy.split("/").map(Number);


            /* alert("total"+odMenuPriceL)
             alert("price"+odOptionPriceL)*/


        }


        var menuPrice = 0;
        for (var i = 0; i < odMenuNameL.length; i++) {

   /*         alert(odMenuNameL[i]);
            alert(odOptionNameL[i]);*/

            menuPrice += (odOptionPriceL[i] + odMenuPriceL[i]);


            divElemApply1 = "<div class=\"card mb-3\" style=\"max-width: 540px;\">" +
                " <div class=\"row g-0\">" +
                "<div class=\"col-md-4\">" +
                "<img src=\"/resources/image/1.jpg\" class=\"img-fluid rounded-start\" alt=\"image\">" +
                "</div>" +
                "<div class=\"col-md-8\">" +
                "<div class=\"card-body\">" +
                "<h5 class=\"card-title\">" + odMenuNameL[i] + "</h5>" +
                "<p class=\"card-text\"><small class=\"text-muted\">옵션 " + odOptionNameL[i] + " :" + odOptionGroupNameL[i] + "  :</small></p>" +
                "<p class=\"card-text\"><small class=\"text-muted\">수량 :" + odMenuQtyL[i] + " 가격 :" + (odOptionPriceL[i] + odMenuPriceL[i]) + " </small></p>" +
                "</div>" +
                "</div>" +
                "</div>" +
                "</div>"


            $('#order').append(divElemApply1);

        }
        /*alert(menuPrice)*/

        divElemApply2 = "<input type=\"hidden\" name=\"orderPrice\" id=\"orderPrice\" value=\""+menuPrice+"\">"+
            "<h5 id='price'>합계 : "+menuPrice+"</h5>"


        $('#total').append(divElemApply2);


    });


    /*

                                        <input type="hidden" id="odMenuName" name="odMenuName" value="${cart.odMenuName}"/>
                                    <input type="hidden" id="odOptionGroupName" name="odOptionGroupName" value="${cart.odOptionGroupName}"/>
                                    <input type="hidden" id="odOptionName" name="odOptionName" value="${cart.odOptionName}"/>
                                    <input type="hidden" id="odMenuQty" name="odMenuQty" value="${cart.odMenuQty}"/>
                                    <input type="hidden" id="odMenuPrice" name="odMenuPrice" value="${cart.odMenuPrice}"/>
                                    <input type="hidden" id="odOptionPrice" name="odOptionPrice" value="${cart.odOptionPrice}"/>
                                    <input type="hidden" id="odMenuImage" name="odMenuImage" value="${cart.odMenuImage}"/>



*/


</script>
</body>
</html>
