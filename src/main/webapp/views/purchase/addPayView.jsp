

<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html lang="ko">
<meta charset="EUC-KR">


<head>

    <!-- 제이쿼리 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
            crossorigin="anonymous"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- 아임포트 -->
    <script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <jsp:include page="../../common/lib.jsp"/>


    <style>

        .btn-outline-primary {
            color: #ffe537;
            border-color: #ffe537;
        }
        .btn-check:active+.btn-outline-primary, .btn-check:checked+.btn-outline-primary, .btn-outline-primary.active, .btn-outline-primary.dropdown-toggle.show, .btn-outline-primary:active {
            color: #212529;
            background-color: #ffe537;
            border-color: #ffe537;
        }
        .btn-outline-primary {
            color: #ffe537;
            border-color: #ffe537;
        }
        .btn-outline-primary:hover {
            color: #ffffff;
            background-color: #ffe537;
            border-color: #ffe537;
        }

        .btn-primary {
            color: #212529;
            background-color: #ffe537;
            border-color: #ffe537;
        }

        body {
            margin-top: 122px;

        }
        #priceT{
            margin: 1px;
        }
        /*이미지접히게*/
        .rounded-start {
            border-bottom-left-radius: 1.25rem!important;
            border-top-left-radius: 1.25rem!important;
        }
        /*이미지 사이즈*/
        .img-fluid {
            max-width: 100%;
            height: 113px;
        }
        /*카드 둥글게*/
        .card {
            position: relative;
            display: -ms-flexbox;
            display: flex;
            -ms-flex-direction: column;
            flex-direction: column;
            min-width: 0;
            word-wrap: break-word;
            background-color: #fff;
            background-clip: border-box;
            border: 1px solid rgba(0, 0, 0, 0.125);
            border-radius: 1.25rem;
        }
        .card-body{
            width: 100%;
            table-layout: fixed;
        }

        .card-title{
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
        }
        .container.shopping{
            margin-top: 70px;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 1px 2px 1px rgba(0,0,0,0.1);
            transition: 0.2s;
            border-radius: 10px;
        }

    </style>

</head>

<body>
<jsp:include page="/views/navbar.jsp"/>
<!-- Bootstrap Dropdown Hover CSS -->
<!--  ///////////////////////// CSS ////////////////////////// -->

<script type="text/javascript">


    var kakaopay = function () {


        var IMP = window.IMP; // 생략가능
        IMP.init('imp67651684'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        var msg;

        var orderUserId = $("input[name='orderUserId.userId']").val();
        var orderTotalPrice = $("input[name='orderTotalPrice']").val();
        var orderTruckId = $("input[name='orderTruckId.truckId']").val();
        var payOption = $("input[name='payOption']:checked").val();
        var pp = document.getElementById('totalpp').innerHTML;
        var pointAmt = $("input[name='pointAmt']").val();
        var couponNo = $("input[name='couponNo']").val();
        var orderNo = $("input[name='orderNo']").val();
        var truckName = $("input[name='truckName']").val();
        var truckPhone = $("input[name='truckPhone']").val();
        var userPhone = $("input[name='userPhone']").val();
        var userEmail = $("input[name='userEmail']").val();
        var userName = $("input[name='userName']").val();
        var payPrice = pp.split(":");



        if (couponNo == "" || couponNo === undefined) {
            couponNo = 0;
        }
        if (pointAmt == "" || pointAmt === undefined) {
            pointAmt = 0;
        }
        var price = Number(payPrice[1]);
        //총 합계 급액 처리가 완료가 되면 price로 amount에 넣어서 사용



        if (payOption == '0') {
            IMP.request_pay({
                pg: 'html5_inicis',
                pay_method: 'card',
                merchant_uid: 'merchant_' + new Date().getTime(),
                name: truckName,
                amount: price,
                buyer_tel: userPhone,
                buyer_name: userName,
                buyer_email : userEmail


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
                            "payPrice": price,


                        }


                    }).done(function (data) {
                        //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                        if (everythings_fine) {
                            msg = '결제가 완료되었습니다.';
                            msg += '\n고유ID : ' + rsp.name;
                            msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                            msg += '결제 금액 : ' + rsp.amount;


                            alert("결제가 완료되었습니다");
                        } else {
                            //[3] 아직 제대로 결제가 되지 않았습니다.
                            //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
                        }
                    });
                    console.log("purchase.socket::::" + socket);
                    if(socket) {
                        // websocket에 보내기!!! (message, 보내는이, 받는이)
                        let socketMessage = "purchase,"+orderUserId+","+orderTruckId+","+orderTruckId;
                        console.log("socketM::::" + socketMessage);
                        socket.send(socketMessage);
                    }
                    //성공시 이동할 페이지
                    $("form").attr("method", "POST").attr("action", "/purchase/getOrderUser").submit();
                } else {
                    msg = '결제에 실패하였습니다.';
                    msg += '에러내용 : ' + rsp.error_msg;
                    //실패시 이동할 페이지

                    alert(msg);
                }
            });
        } else if (payOption == '1') {
            IMP.request_pay({
                pg: 'danal',
                pay_method: 'phone',
                merchant_uid: 'merchant_' + new Date().getTime(),
                name: truckName,
                amount: price,
                buyer_tel: userPhone,
                buyer_name: userName,
                buyer_email : userEmail

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
                            "payPrice": price,

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
                    console.log("purchase.socket::::" + socket);
                    if(socket) {
                        // websocket에 보내기!!! (message, 보내는이, 받는이)
                        let socketMessage = "purchase,"+orderUserId+","+orderTruckId+","+orderTruckId;
                        console.log("socketM::::" + socketMessage);
                        socket.send(socketMessage);
                    }
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
                            "payPrice": price,

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
                    console.log("purchase.socket::::" + socket);
                    if(socket) {
                        // websocket에 보내기!!! (message, 보내는이, 받는이)
                        let socketMessage = "purchase,"+orderUserId+","+orderTruckId+","+orderTruckId;
                        console.log("socketM::::" + socketMessage);
                        socket.send(socketMessage);
                    }
                    //성공시 이동할 페이지
                    $("form").attr("method", "POST").attr("action", "/purchase/getOrderUser").submit();
                } else {
                    msg = '결제에 실패하였습니다.';
                    msg += '에러내용 : ' + rsp.error_msg;
                    //실패시 이동할 페이지

                    alert(msg);

                }
            });
        } else if (payOption == '4') {
            IMP.request_pay({
                pg: 'html5_inicis',
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
                            "payPrice": price,

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
                    console.log("purchase.socket::::" + socket);
                    if(socket) {
                        // websocket에 보내기!!! (message, 보내는이, 받는이)
                        let socketMessage = "purchase,"+orderUserId+","+orderTruckId+","+orderTruckId;
                        console.log("socketM::::" + socketMessage);
                        socket.send(socketMessage);
                    }
                    //성공시 이동할 페이지
                    $("form").attr("method", "POST").attr("action", "/purchase/getOrderUser").submit();
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
        $("#addPay").click(function () {

            kakaopay();


        });
        $("#getPay").click(function(){
            alert("결제가 완료된 메뉴입니다")
        });
    });

    $(function () {
        var orderTruckId = $("input[name='orderTruckId.truckId']").val();
        $("button.btn.btn-primary:contains('뒤로가기')").click(function () {
            self.location = "/menu/getMenuList?truckId=" + orderTruckId;

        });
    });

    // coupon modal
    var count = 0;

    $(function () {

        var modal = $('#myModal');



        modal.find('button.btn-primary').on("click", function () {
            var totalPP1 =document.getElementById('totalpp').innerHTML;
            var totalSS1 = document.getElementById('sale').innerHTML;
            var totalSS2 = totalSS1.split(":").map(Number);
            var totalPP2 = totalPP1.split(":").map(Number);

            var realCouponDcPrice = modal.find('input[name=options]:checked').val();
            var couponCheck = $("input[name='couponNo']").val()
            data = realCouponDcPrice.split(",");
            var couponDcPrice = data[0];

            if (couponCheck == undefined) {
                if(couponDcPrice < Number(totalPP2[1])) {

                    /*  var couponNo =modal.find('input[name=couponNumber]').val();*/
                    console.log(realCouponDcPrice + " : realOptionGroupName");

                    var couponNo = data[1];
                    console.log(couponNo + ": couponNo");



                    /*alert(couponDcPrice + Number(totalSS2[1]))*/

                    var payPrice = Number(totalPP2[1]) - Number(couponDcPrice);
                    var sale = Number(totalSS2[1]) + Number(couponDcPrice);
                    /*var payPrice = (dd[1] - couponDcPrice);*/
                    $("input[name='payPrice']").val(payPrice);
                    append = "<input type=\"text\" id=\"couponNo\" name=\"couponNo\" value=\"" + couponNo + "\">";
                    totalPayPrice = "<span id='totalpp'>결제금액 : " + payPrice + "</span>"+
                        "<input type='hidden' id='payPrice' value='"+payPrice+"'>";
                    totalsale = "<span id='sale'>할인금액 : " + sale + "</span>"
                    /*alert(append + ":append");*/

                    $('#couponDcPrice').val(couponDcPrice);
                    $('#test').append(append);
                    $('#pp').html(totalPayPrice);
                    $('#dcp').html(totalsale);

                    modal.modal('hide');
                }else {
                    alert("사용가능 할인금액을 초과 하였습니다.")
                }
            } else {
                alert("사용중인 쿠폰이 있습니다.")
            }

        });

    });

    $(function () {
        /*        var modal = $('#couponCancel');
                modal.find('button.btn-primary').on("click", function () {*/
        $("#button-addon2").click(function () {

            var pointCheck = $("input[name='pointCheck']").val();

            var totalPoint = $("input[name='totalPoint']").val();
            var val = document.getElementById('totalpp').innerHTML;
            var orderTotalPayPrice = $("input[name='orderPrice']").val();
            var totalSS1 = document.getElementById('sale').innerHTML;
            var totalSS2 = totalSS1.split(":").map(Number);
            var dd = val.split(":").map(Number);
            var usePoint = $('input[name="usePoint"]').val();


            console.log("totalPoint"+totalPoint)
            console.log("val"+val)
            console.log("orderTotalPayPrice"+orderTotalPayPrice)
            console.log("totalSS1"+totalSS1)
            console.log("totalSS2"+totalSS2)
            console.log("dd"+dd)
            console.log("usePoint"+usePoint)

            if (pointCheck == undefined) {

                if(usePoint < totalPoint) {

                    if(usePoint < Number(orderTotalPayPrice)){
                        if (usePoint != "") {
                            if (usePoint % 1000 == 0) {

                                /* var useMinPoint = Number(totalPoint-usePoint);*/


                                var payPrice = Number(dd[1]) - usePoint;
                                var sale = Number(totalSS2[1]) + Number(usePoint);



                                /*   append = "<input type=\"text\" id=\"pointAmt\" name=\"pointAmt\" value=\"" + usePoint + "\">";*/
                                totalPayPrice = "<span id='totalpp' name='payPrice' >결제금액 : " + payPrice + "</span>"+
                                    "<input type='hidden' id='payPrice' value='"+payPrice+"'>"+
                                    "<input type=\"hidden\" id=\"pointAmt\" name=\"pointAmt\" value=\"" + usePoint + "\">";

                                pointHtmlCheck =  "<input type='hidden' name='pointCheck' id='pointCheck' value='1'>";
                                totalsale = "<span id='sale'>할인금액 : " + sale + "</span>"

                                $("input[name='payPrice']").val(payPrice);
                                /* $('#usePointAmt').append(append);*/
                                $('#pp').html(totalPayPrice);
                                $('#dcp').html(totalsale);
                                $('#order').append(pointHtmlCheck);
                                /*$('#totalPoint').html(useMinPoint);*/

                                alert("포인트가 적용되었습니다")

                            } else {
                                alert("포인트는 1000단위로 사용가능합니다.")
                            }
                        } else {
                            alert("사용할 포인트를 입력해주세요")
                        }
                    }else{
                        alert("사용하신 포인트가 결제금액을 초과 하였습니다.")
                    }
                }else{
                    alert("사용포인트가 보유포인트를 초과하였습니다.")
                }
            } else {

                $(document).ready(function(){
                    var result = confirm('기존에 사용한 포인트를 변경하시겠습니까??');
                    if(result){

                        if(usePoint < totalPoint) {

                            var vall = document.getElementById('totalpp').innerHTML;
                            var cc = vall.split(":").map(Number);
                            if(usePoint < Number(orderTotalPayPrice)){

                                if (usePoint != "") {

                                    if (usePoint % 1000 == 0) {

                                        if(usePoint){
                                            var usePointT = $('input[name="usePoint"]').val();
                                            var pointde = document.getElementById("pointAmt");
                                            var pointRe = document.getElementById("usePoint");
                                            var ususususPoint = $("#pointAmt").val();
                                            var usePlMnPoint = Number(totalPoint)+Number(ususususPoint);

                                            console.log("usePointT"+usePointT)
                                            console.log("pointde"+pointde)
                                            console.log("pointRe"+pointRe)
                                            console.log("")
                                            console.log("totalPoint 현재 보유 포인트 "+usePlMnPoint)
                                            console.log("usususPoint 현재 그전에 사용한 포인트"+ususususPoint)
                                            console.log("1번째 합친거 "+usePlMnPoint)

                                            const pointAmt = document.getElementById('pointAmt').value;
                                            var val =document.getElementById('totalpp').innerHTML;

                                            var dd = val.split(":").map(Number);
                                            var totalSS1 = document.getElementById('sale').innerHTML;
                                            var totalSS2 = totalSS1.split(":").map(Number);
                                            var payPrice = Number(dd[1]) + Number(pointAmt);

                                            var sale = Number(totalSS2[1])-Number(pointAmt);
                                            pointde.remove();

                                            pointRe.value = "";
                                            totalPayPrice =  "<span id='totalpp' name='totalpp' >결제금액 : "+payPrice+"</span>"+
                                                "<input type='hidden' id='payPrice' name='payPrice' value='"+payPrice+"'>";

                                            totalsale =  "<span id='sale'>할인금액 : "+sale+"</span>"

                                            console.log("지금 사용한 포인트 "+usePoint)
                                            $('#totalPoint').html(Number(usePlMnPoint)-Number(usePoint));
                                            $('#pp').html(totalPayPrice);
                                            $('#dcp').html(totalsale);



                                        }


                                        var valT = document.getElementById('totalpp').innerHTML;
                                        var totalSS1T = document.getElementById('sale').innerHTML;
                                        var totalSS2T = totalSS1T.split(":").map(Number);
                                        var ddT = valT.split(":").map(Number);


                                        var payPriceT = Number(ddT[1]) - usePointT;
                                        var saleT = Number(totalSS2T[1]) + Number(usePointT);



                                        /*append = "<input type=\"hidden\" id=\"pointAmt\" name=\"pointAmt\" value=\"" + usePointT + "\">";*/
                                        totalPayPrice = "<span id='totalpp' name='totalpp' >결제금액 : " + payPriceT + "</span>"+
                                            "<input type='hidden' id='payPrice' name='payPrice' value='"+payPrice+"'>"+
                                            "<input type=\"hidden\" id=\"pointAmt\" name=\"pointAmt\" value=\"" + usePointT + "\">";
                                        totalsale = "<span id='sale'>할인금액 : " + saleT + "</span>"

                                        $("input[name='payPrice']").val(payPrice);
                                        /* $('#usePointAmt').append(append);*/
                                        $('#pp').html(totalPayPrice);
                                        $('#dcp').html(totalsale);

                                        alert("포인트가 적용되었습니다")

                                    } else {
                                        alert("포인트는 1000단위로 사용가능합니다.")
                                    }
                                } else {
                                    alert("사용할 포인트를 입력해주세요")
                                }
                            }else{
                                alert("사용하신 포인트가 결제금액을 초과 하였습니다.")
                            }
                        }else{
                            alert("사용포인트가 보유포인트를 초과하였습니다.")
                        }
                    }else{
                    }
                });
            }
        });
    });


    $(function () {
        var modal = $('#couponCancel');
        modal.find('button.btn-primary').on("click", function () {
            /* modal$('#removeCoupon').click(function () {*/
            var couponRe = document.getElementById("couponDcPrice");
            var couponde = document.getElementById("couponNo");
            const couponDcPrice = document.getElementById('couponDcPrice').value;
            couponde.remove();
            couponRe.value = "";

            var totalPP1 =document.getElementById('totalpp').innerHTML;
            var totalSS1 = document.getElementById('sale').innerHTML;
            var totalSS2 = totalSS1.split(":").map(Number);
            var totalPP2 = totalPP1.split(":").map(Number);

            var payPrice = Number(totalPP2[1]) + Number(couponDcPrice);
            var sale = Number(totalSS2[1])-Number(couponDcPrice);

            totalPayPrice =  "<span id='totalpp'>결제금액 : "+payPrice+"</span>"+
                "<input type='hidden' id='payPrice' name='payPrice' value='"+payPrice+"'>";
            totalsale =  "<span id='sale'>할인금액 : "+sale+"</span>"
            /*alert(append + ":append");*/

            $('#pp').html(totalPayPrice);
            $('#dcp').html(totalsale);

            modal.modal('hide');
        });
    });

    $(function () {
        var modal = $('#pointCancel');
        modal.find('button.btn-primary').on("click", function () {
            /* $('#removePoint').click(function () {*/
            var totalPoint = Number(document.getElementById('totalPoint').innerHTML);
            var pointde = document.getElementById("pointAmt");
            var pointRe = document.getElementById("usePoint");
            const pointAmt = document.getElementById('pointAmt').value;
            console.log("pointde"+pointde)
            console.log("pointAmt"+pointAmt)
            console.log('totalPoint'+totalPoint)

            var val =document.getElementById('totalpp').innerHTML;
            var dd = val.split(":").map(Number);


            var totalSS1 = document.getElementById('sale').innerHTML;
            var totalSS2 = totalSS1.split(":").map(Number);
            var payPrice = Number(dd[1]) + Number(pointAmt);
            var sale = Number(totalSS2[1])-Number(pointAmt);

            pointde.remove();
            pointRe.value = "";

            totalPayPrice =  "<span id='totalpp' name='payPrice' >결제금액 : "+payPrice+"</span>"+
                "<input type='hidden' id='payPrice' name='payPrice' value='"+payPrice+"'>";
            totalsale =  "<span id='sale'>할인금액 : "+sale+"</span>"


            $('#pp').html(totalPayPrice);
            $('#dcp').html(totalsale);
            $('#totalPoint').html(Number(totalPoint)+Number(pointAmt));
            modal.modal('hide');
        });
    });




</script>

<section class="client_section layout_padding" style="padding-top: 30px;">
    <div class="container">
        <div class="col-md-12 mx-auto">

            <div class="detail-box" style="margin-top: 0;">
                <i class="fa fa-quote-left" aria-hidden="true" style="margin-bottom: 10px;"></i>
                <h3 class="truckNameForMenu" style="font-weight: bold;">주문 결제</h3>
            </div>

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
                                        <th scope="col"></th>
                                        <th scope="col">할인금액</th>
                                        <th scope="col">쿠폰유형</th>
                                    </tr>
                                    </thead>
                                    <c:set var="i" value="0"/>
                                    <c:forEach var="couponLis" items="${couponList.get('list')}">
                                        <c:set var="i" value="${i+1}"/>
                                        <c:if test="${couponLis.couponStatus==0}">
                                            <tr>
                                                <th scope="row">${i}</th>
                                                <td><label class="btn btn-secondary active">
                                                    <input type="radio" name="options" id="option${i}" autocomplete="off"
                                                           value="${couponLis.couponDcPrice},${couponLis.couponNo}" checked> Active
                                                </label></td>
                                                <td>${couponLis.couponDcPrice}</td>
                                                <td>
                                                    <c:if test="${couponLis.couponType == 0}">
                                                        BIRTH
                                                    </c:if>
                                                    <c:if test="${couponLis.couponType == 1}">
                                                        RAIN
                                                    </c:if>
                                                    <c:if test="${couponLis.couponType == 2}">
                                                        SNOW
                                                    </c:if>
                                                </td>


                                            </tr>
                                        </c:if>
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


                <div class="container shopping" style="min-height: 700px;">

                    <div class="row gx-5" style="min-height: inherit;">

                        <%-- 왼쪽 --%>
                        <div class="col" style="padding: 20px; display: flex; flex-direction: column; justify-content: space-between;">

                            <div  style=" box-shadow: 0 1px 2px 1px rgba(0,0,0,0.1); transition: 0.2s; border-radius: 10px; padding: 20px 5px; ">
                                <div style="text-align: left;">
                                    <div class="col-sm-12" style="margin-bottom: 20px;">
                                        <h5 style="box-shadow: inset 0 -11px 0 #fae100; width: fit-content;">주문내역</h5>
                                    </div>
                                </div>

                                <div style="padding: 15px;">
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
                                        <input type="text" id="odOptionPrice" name="odOptionPrice" value="${cart.odOptionPrice}"/>
                                        <input type="text" id="odMenuImage" name="odMenuImage" value="${cart.odMenuImage}"/>
                                        <input type="hidden" id="odMenuQtyFlag" name="odMenuQtyFlag" value="${cart.odMenuQtyFlag}"/>

                                    </c:forEach>
                                </div>
                            </div>

                            <%--<div>
                                <div>
                                    <div class="col-12">
                                        <div class="col-3">
                                            <p class="text"  id="total" ></p>
                                        </div>
                                        <div class="col-3">
                                            <p class="text"  id="dcp"  ><span id="sale" name="payPrice">할인금액 :</span></p>
                                            <input type="hidden" name="payPrice" value="${purchase.payPrice}">
                                        </div><div class="col-3">
                                        <p class="text"  id="pp"></p>
                                    </div></div>

                                    <div class="row">
                                        <div class="col-6">
                                            <button type="button" class="btn btn-cancle" style="width: inherit; margin: 0;">
                                                뒤로가기
                                            </button>
                                        </div>
                                        <div class="col-6">
                                            <c:if test="${purchase.orderStatus == 0}">
                                                <button type="button" id="addPay" class="btn btn-default" style="width: inherit; margin: 0;">
                                                    결제
                                                </button>
                                            </c:if>
                                            <c:if test="${purchase.orderStatus > 0}">
                                                <button type="button" id="getPay" class="btn btn-default" style="width: inherit; margin: 0;">
                                                    결제
                                                </button>
                                            </c:if>

                                        </div>
                                    </div>
                                </div>
                            </div>--%>

                        </div>

                        <%-- 오른쪽 --%>
                        <div class="col" style="padding: 20px; display: flex; flex-direction: column; justify-content: space-between;">

                            <div  style=" box-shadow: 0 1px 2px 1px rgba(0,0,0,0.1); transition: 0.2s; border-radius: 10px; padding: 20px 5px; ">
                                <div>
                                    <div style="text-align: left;">
                                        <div class="col-sm-12" style="margin-bottom: 20px;">
                                            <h5 style=" box-shadow: inset 0 -11px 0 #fae100; width: fit-content;">할인 및 적립금</h5>
                                        </div>

                                        <input type="hidden" name="userPhone" value="${purchase.orderUserId.userName}">
                                        <input type="hidden" name="userEmail" value="${purchase.orderUserId.userEmail}">
                                        <input type="hidden" name="truckPhone" value="${purchase.orderTruckId.truckPhone}">
                                        <input type="hidden" name="truckName" value="${purchase.orderTruckId.truckName}">
                                        <input type="hidden" name="userName" value="${purchase.orderUserId.userName}">
                                        <input type="hidden" name="orderTruckId.truckId" value="${purchase.orderTruckId.truckId}">
                                        <input type="hidden" name="orderUserId.userId" value="${purchase.orderUserId.userId}">
                                        <input type="hidden" name="orderNo" value="${purchase.orderNo}">
                                        <input type="hidden" name="orderTotalPrice" value="${purchase.orderTotalPrice}"/>
                                    </div>
                                </div>

                                <div>
                                    <div id="test" style="display: flex; align-items: center; justify-content: center; margin-bottom: 10px;">

                                        <label for="couponDcPrice" class="col-sm-1 col-sm-2 control-label" style="font-weight:600; margin: 0; padding: 0; text-align: left">할인쿠폰</label>
                                        <div class="input-group col-sm-1 col-sm-9" style="padding: 0;">
                                            <input type="text" class="form-control" id="couponDcPrice" name="couponDcPrice" placeholder="쿠폰을 적용하세요" value="${coupon.couponDcPrice}"
                                                   style="border-width: 1.5px; border-top: 0; border-right: 0; border-left: 0; background-color: white; border-radius: 0; text-align: center;" disabled>
                                            <span class="input-group-text" style="background-color: white; border: 0;">원</span>
                                            <a href="#myModal"> <input class="btn btn-default" type="button"
                                                                       data-bs-toggle="modal"
                                                                       data-bs-target="#myModal" value="적용" style="padding: 5px 10px;"/></a>
                                            <a href="#"><input class="btn btn-cancle" type="button" aria-label="Close" data-bs-toggle="modal" data-bs-target="#couponCancel" value="취소" style="padding: 5px 10px;"/></a>
                                        </div>
                                    </div>

                                    <div>

                                        <div style="display: flex; align-items: center; justify-content: center;">
                                            <label for="usePoint" class="col-sm-1 col-sm-2 control-label" style="font-weight:600; margin: 0; padding: 0; text-align: left">적립금</label>
                                            <div class="input-group col-sm-1 col-sm-9" style="padding: 0;">

                                                <input type="hidden" id="totalPoint" name="totalPoint" value="${totalPoint.userTotalPoint}">
                                                <%--<input type="hidden" class="input-group-text" id="totalPoint" style="background-color: white; border: 0;">${totalPoint.userTotalPoint}</input>--%>
                                                <input type="text" class="form-control" id="usePoint" name="usePoint" placeholder="보유 적립금 : ${totalPoint.userTotalPoint}" value="${point.pointAmt}"
                                                       style="border-width: 1.5px; border-top: 0; border-right: 0; border-left: 0; background-color: white; border-radius: 0; text-align: center;">
                                                <span class="input-group-text" style="background-color: white; border: 0;">원</span>
                                                <a href="#"><input class="btn btn-default" type="button" id="button-addon2" value="사용" style="padding: 5px 10px;"/></a>
                                                <a href="#"><input class="btn btn-cancle" type="button"  aria-label="Close" data-bs-toggle="modal" data-bs-target="#pointCancel" value="취소" style="padding: 5px 10px;"/></a>
                                            </div>
                                        </div>
                                        <span style="padding-right: 50px; font-size: 12px; color: grey;">적립금은 1,000원 단위로 사용 가능합니다.</span>
                                    </div>
                                </div>
                            </div>

                            <div style=" box-shadow: 0 1px 2px 1px rgba(0,0,0,0.1); transition: 0.2s; border-radius: 10px; padding: 20px 5px; ">

                                <div class="row">
                                    <div style="text-align: left;">
                                        <div class="col-sm-12" style="margin-bottom: 20px;">
                                            <h5 style=" box-shadow: inset 0 -11px 0 #fae100; width: fit-content;">결제방법</h5>
                                        </div>
                                    </div>
                                </div>

                                <div class="container">
                                    <div class="row row-cols-2" style="display:flex; align-items: center; justify-content: flex-start;">
                                        <div class="col-5">결제방법을 선택해주세요.</div>
                                        <div class="col-3" style="padding: 0;" ><input type="radio" class="btn-check" name="payOption" id="btnradio1"
                                                                                       value="0" autocomplete="off" checked >
                                            <label class="btn btn-outline-primary w-100" for="btnradio1" style="border-radius: 9.25rem; margin: 0;">일반 결제</label>
                                        </div>
                                        <div class="col-3" style="padding: 0;" ><input type="radio" class="btn-check" name="payOption" id="btnradio2"
                                                                                       value="1" autocomplete="off">
                                            <label class="btn btn-outline-primary w-100" for="btnradio2" style="border-radius: 9.25rem; margin: 0 0 0 15px;">휴대폰결제</label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div style=" box-shadow: 0 1px 2px 1px rgba(0,0,0,0.1); transition: 0.2s; border-radius: 10px; padding: 20px 5px; ">
                                <div>

                                    <div class="col-sm-12" style="margin-bottom: 20px;">
                                        <h5 style=" box-shadow: inset 0 -11px 0 #fae100; width: fit-content;">결제상세</h5>
                                    </div>

                                    <div class="col-12" style="display:flex; flex-direction: column; align-items: flex-start; padding: 0 25px;">
                                        <div>
                                            <p class="text"  id="total" ></p>
                                        </div>
                                        <div>
                                            <p class="text"  id="dcp" ><span id="sale" name="payPrice">할인금액 :</span></p>
                                            <input type="hidden" name="payPrice" value="${purchase.payPrice}">
                                        </div>
                                        <div>
                                            <p class="text"  id="pp"></p>
                                        </div>
                                        <hr style="border-style: unset; 10px; width: -webkit-fill-available"/>
                                    </div>

                                    <div class="col-12" style="display: flex; padding: 0; margin-top: 10px;">

                                        <div class="col-6">
                                            <button type="button" class="btn btn-cancle" style="width: inherit; margin: 0; padding: 5px 20px;">
                                                뒤로가기
                                            </button>
                                        </div>
                                        <div class="col-6">
                                            <c:if test="${purchase.orderStatus == 0}">
                                                <button type="button" id="addPay" class="btn btn-default" style="width: inherit; margin: 0; padding: 5px 20px;">
                                                    결제
                                                </button>
                                            </c:if>
                                            <c:if test="${purchase.orderStatus > 0}">
                                                <button type="button" id="getPay" class="btn btn-default" style="width: inherit; margin: 0; padding: 5px 20px;">
                                                    결제
                                                </button>
                                            </c:if>

                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>
            </form>


        </div>
    </div>
</section>

</body>

<script>
    $(function () {

        var odMenuNameCount = $("input[name='odMenuName']").length;
        console.log("odMenuCount : " + odMenuNameCount)

        var odMenuNameL;
        var odOptionGroupNameL;
        var odOptionNameL;
        var odMenuQtyL;
        var odMenuPriceL;
        var odOptionPriceL;
        var odMenuImageL;

        var totototoprice =0; // 전체 금액
        var totototoqty =0; // 수량
        var pricepriceprice =0 // 임시 가격

        var menuPriceOne = [];
        var menuPriceTwo = [];
        var optionPriceOne = [];
        var optionPriceTwo = [];
        var menuCount = 0;
        var menuCheck = [];


        var optionNameShow = []; // 이름 보여지게 할 값 만들기~ (최종)
        var optionPriceShow = [];
        var totalshow =0;
        for (var i = 0; i < odMenuNameCount; i++) {

            var odMenuName = $("input[name='odMenuName']").eq(i).val();
            var odOptionGroupName = $("input[name='odOptionGroupName']").eq(i).val();
            var odOptionName = $("input[name='odOptionName']").eq(i).val();
            var odMenuQty = $("input[name='odMenuQty']").eq(i).val();
            var odMenuPrice = $("input[name='odMenuPrice']").eq(i).val();
            var odOptionPrice = $("input[name='odOptionPrice']").eq(i).val();
            var odMenuImage = $("input[name='odMenuImage']").eq(i).val();
            var odMenuQtyFlag = $("input[name='odMenuQtyFlag']").eq(i).val();


            console.log(odMenuImage)
            /* HHJ */

            if (optionNameShow[menuCount] == undefined){
                optionNameShow[menuCount] = " ";
            }


            if ( odMenuQtyFlag == '0'){

                pricepriceprice = Number(odMenuPrice);
                totototoqty = Number(odMenuQty);
                menuCount++;
                totalshow=0;
                //pricepriceprice *= qtyqtyqty;
                //console.log("pricepriceprice *= qtyqtyqty" + (pricepriceprice *= qtyqtyqty));
                //tttttppppprrrr += Number(pricepriceprice)// 처음 들어온 값도 0, 이후엔 곱해짐 // 기존값 더함
                //qtyqtyqty = Number(odMenuQty); // 수량값 기억하고 있도록 for문 밖에 선언해준 qtyqtyqty 에 저장
            }else { // 옵션이면
                // console.log("odOptionName : "+odOptionName)
                pricepriceprice = Number(odOptionPrice);
                optionNameShow[Number(menuCount-1)] += odOptionName + "(+" + odOptionPrice + ") ";

            }
            //console.log("optionNameShow[menuCount]: "+optionNameShow[menuCount])
            totototoprice+= Number(pricepriceprice * totototoqty);
            totalshow += Number(pricepriceprice * totototoqty);
            optionPriceShow[Number(menuCount-1)] = totalshow;
            console.log("ttototototo :: " + totototoprice)

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
                //
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
            /* alert("total"+odMenuPriceL)
             alert("price"+odOptionPriceL)*/
        }
        var sum = new Array() ;
        var test3 = new Array();

        odOptionPriceL = odOptionPriceCopy.split("/"); //

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
        console.log(odMenuImageL[0])


        var menuPrice = 0;

        for (var i = 0; i < odMenuNameL.length; i++) {

            menuPrice += (sum[i] + odMenuPriceL[i]);
            menuQty = odMenuQtyL[i]

            divElemApply1 = "<div class=\"card mb-3\">" +
                " <div class=\"row g-0\">" +
                "<div class=\"col-md-4\">" +
                "<img src=\"/resources/menu/"+odMenuImageL[i]+"\" class=\"img-fluid rounded-start\" alt=\"image\">" +
                "</div>" +
                "<div class=\"col-md-8\">" +
                "<div class=\"card-body\" style='display: flex; flex-direction: column; align-items: flex-start; padding: 15px 0;'>" +
                "<h5 class=\"card-title\">" + odMenuNameL[i] + "</h5>" +
                "<p class=\"card-text\" style='margin:0; display: flex; flex-direction: column;'>" +
                "<div class=\"text-muted\"><span class='badge' style='background-color: #fae100; color: #110000'>&nbsp;옵션&nbsp;</span> " + optionNameShow[i] + "  </div>" +
                "<div class=\"text-muted\" style='text-align: initial;'><span class='badge' style='background-color: #fae100; color: #110000'>&nbsp;수량&nbsp;</span> " +
                odMenuQtyL[i] + " <br><span class='badge' style='background-color: #fae100; color: #110000'>총 가격</span> " +
                optionPriceShow[i] + " " +
                "</div></p>" +
                "</div>" +
                "</div>" +
                "</div>" +
                "</div>"


            $('#order').append(divElemApply1);

        }
        divElemApply2 = "<input type=\"hidden\" name=\"orderPrice\" id=\"orderPrice\" value=\""+totototoprice+"\">"+
            "<span id='price'>합계 : "+totototoprice+"</span>"

        divElemApply3 = "<input type=\"hidden\" name=\"orderPrice\" id=\"orderPrice\" value=\""+totototoprice+"\">"+
            "<input type='hidden' id='payPrice' name='payPrice' value='"+totototoprice+"'>"+
            "<span id='totalpp'>결제금액 :"+totototoprice+"</span>"

        $('#total').append(divElemApply2);
        $('#pp').append(divElemApply3);

    });

</script>
</html>

