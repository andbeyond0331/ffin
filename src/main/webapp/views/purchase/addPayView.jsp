<%@ page contentType="text/html;charset=UTF-8" language="java"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>




<!doctype html>
<html lang="ko">
<meta charset="EUC-KR">


<head>
    <jsp:include page="/views/toolbar.jsp" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>
<!-- Bootstrap Dropdown Hover CSS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>


<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<!--  ///////////////////////// CSS ////////////////////////// -->
<!-- 제이쿼리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous" type="text/javascript"></script>
<!-- 아임포트 -->
<script src ="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>


<style>




    input[type="text"]#pointAmttwo{
        -webkit-appearance: none!important;
        color: #171616;
        text-align: right;
        width: 75px;
        border: 1px solid gray;
        border-left: 0px;
        margin: 0 0 0 -7px;
        background: white;
    }
    input[type="text"]#pointAmt{
        -webkit-appearance: none!important;
        border: 1px solid gray;
        border-right: 0px;
        outline: none;
    }
</style>
<script type="text/javascript">


    var kakaopay = function(){


        var IMP = window.IMP; // 생략가능
        IMP.init('imp67651684'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        var msg;

        var orderTotalPrice= $("input[name='orderTotalPrice']").val()
        var orderTruckId = $("input[name='orderTruckId']").val();
        var payOption = $("select[name='payOption']").val();
        var payPrice =  $("input[name='payPrice']").val();
        var pointAmt =  $("input[name='pointAmt']").val();
        var couponDcPrice =  $("input[name='couponDcPrice']").val();
        var orderNo = $("input[name='orderNo']").val();




        var postData = { "payOption" : payOption,
            "orderTotalPrice" :orderTotalPrice,
            "orderTruckId" : orderTruckId,
            "orderNo"  :  orderNo}
        alert(postData)

        alert(payOption);
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
                            "orderTruckId" : "truck07",
                            "orderNo"  :  orderNo
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
                name : '치킨',
                amount : 2000,
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





    function fncAddPurchase() {

/*        var amount = $("input[name='amount']").val();
        var quantity = $("input[name='quantity']").val();
        var divyDate = $("input[name='divyDate']").val();
        var paymentOption = $("select[name='paymentOption']").val();
        var price = $("input[name='price']").val();
        var receiverName = $("input[name='receiverName']").val();
        var receiverPhone = $("input[name='receiverPhone']").val();
        var divyRequest = $("input[name='divyRequest']").val();*/
        alert(amount)
        alert(quantity)
  /*      if(quantity != null && quantity > amount ){
            alert("수량 확인 부탁드립니다");
            return;
        }
        if(divyDate == null || divyDate < 1){
            alert("날짜를 한번 확인하세요");
            return;
        }
        if(paymentOption == null || paymentOption < 1){
            alert("구매형식을 한번 확인하세요");
            return;
        }
        if(price == null || price < 1){
            alert("가격을 한번 확인하세요");
            return;
        }
        if(receiverName == null || receiverName < 1){
            alert("구매자이름을 한번 확인하세요");
            return;
        }
        if(receiverPhone == null || receiverPhone < 1){
            alert("구매자 연락처 한번 확인하세요");
            return;
        }
        if(divyRequest == null || divyRequest < 1){
            alert("구매요청사항 한번 확인하세요");
            return;
        }*/


        $("form").attr("method" , "POST").attr("action" , "/purchase/addPurchase").submit();
    }
    $(function() {
        $("button.btn.btn-primary:contains('진짜결제')").click(function() {

            kakaopay();


        });
    });
    $(function() {
        $("td.ct_btn01:contains('취소')").click(function() {
            history.go(-1);
        });
    });

    $(function() {
        $("td.ct_btn01:contains('건너뛰기')").click(function() {
            alert("djkdjdk");
            $("form").attr("method" , "POST").attr("action" , "/purchase/addOrder").submit();

        });
    });
    /*     $(function() {
            $( "#datepicker" ).datepicker({
              changeYear: true,
              changeMonth: true
            });
          });   */


    $(function() {
        $("button.btn.btn-primary:contains('결제하기')").click(function () {
            alert("djkdjdk");
            $("form").attr("method" , "POST").attr("action" , "/purchase/getOrderUser").submit();

        });
    });
    $('#myModal').on('shown.bs.modal', function () {
        $('#myInput').focus()
    })

    $('#exampleModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal
        var recipient = button.data('whatever') // Extract info from data-* attributes

        var modal = $(this)

        // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        modal.find('.modal-title').text('옵션그룹' + recipient);
        modal.find('.modal-body input').val(recipient);


    })
    $('#optionModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal
        var recipient = button.data('whatever') // Extract info from data-* attributes

        var modal = $(this)

        // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        modal.find('.modal-title').text('옵션' + recipient);
        modal.find('.modal-body input').val(recipient);


    })

    //옵션그룹추가 모달 로직
    var count = 0;

    $(function(){

        var modal = $('#myModal');


        modal.find('button.btn-primary').on("click", function(){
            alert("ssa")
            count++;

            realCouponDcPrice = modal.find('input[name=options]:checked').each().val();

            console.log(realOptionGroupName + " : realOptionGroupName");



            divElem = "<div class=\"form-group\" id=\"optionGroupName"+count+"\" name=\"optionGroupName\">"+
                "<label for=\"optionGroupName\" class=\"col-sm-offset-1 col-sm-3 control-label\">옵션그룹"+count+"</label>"+
                "<div class=\"col-xs-8 col-md-4\">"+realOptionGroupName+"</div>"+
                "<input type=\"button\" value=\"삭제\" onclick=\"javascript:removeEL("+count+")\"/>" +
                // "<input type=\"button\" value=\"옵션추가\" onclick=\"javascript:addOption(optionGroupName"+count+")\"/>" +
                "<button type=\"button\" class=\"btn btn-primary\" data-toggle=\"modal\" data-target=\"#optionModal\" data-whatever=\"option\">옵션 추가</button>"+
                "</div>";

            console.log("divElem :"+divElem);

            $('#couponDcPrice').val(1000);

            // modal.modal('hide');

        });

    });

</script>


<form name="addPurchase">
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
                            <c:set var="i" value="${i+1}" />
                            <tr>
                                <th scope="row">${i}</th>
                                <td><label class="btn btn-secondary active">
                                    <input type="radio" name="options" id="option${i}" autocomplete="off" value="${couponLis.couponDcPrice}" checked> Active
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


    <div class="container overflow-hidden">
        <div class="row gx-5">


            <div class="col">

                    <div class="container">
                        <div class="row">
                        <div class="col-sm-12">
                        <h3>결제하기</h3>
                        </div>

                    </div>
                    <hr class="my-2">
                    <div class="row">
                        <div class="col-sm-12">
                            <h3>할인 및 적립금</h3>
                        </div>
                    </div>


                        <div class="row">
                        <label for="couponDcPrice" class="col-sm-offset-1 col-sm-3 control-label">할인쿠폰</label>
                        <div class="col-sm-3">
                            <div class="well well-sm">${coupon.couponDcPrice}</div>
                            <input type="hidden" name="orderNo" value="${purchase.orderNo}">
                            <input type="text" class="form-control" id="couponDcPrice"
                                   name="couponDcPrice" placeholder="쿠폰을 적용하세요" value="" >
                        </div>
                        <div class="col-sm-1">
                           원
                        </div>
                        <div class="col-sm-3">
                            <!-- Button trigger modal -->
                            <button type="button" class="btn btn-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#myModal">
                                쿠폰적용
                           </button>
                        </div>
                        </div>

                        <div class="row">

                            <label for="pointAmt" class="col-sm-offset-1 col-sm-3 control-label">적립금</label>
                            <div class="col-sm-2">
                                <%--<div class="well well-sm">${user.userTotalPorint}</div>--%>

                                <div class="well well-sm">0</div>
                            </div>
                            <div class="col-sm-4">

                                <input type="text"  placeholder="o" id="pointAmt" naem="pointAmt">
                                <input type="text"  id="pointAmttwo" value="원" disabled/>



                            </div>

                            <div class="col-sm-1">
                                <!-- Button trigger modal -->
                                <button type="button" class="btn btn-secondary btn-sm">
                                    포인트 적용
                                </button>
                            </div>
                        </div>

                    <div class="row">
                            <div class="col-sm-10">
                                <div class="container">
                            적립금은 1000단위로 사용가능합니다.
                                </div>
                            </div>
                        </div>
                    <hr class="my-lg-4">
                        <div class="row">
                            <div class="col-sm-10">
                    <h3>결제방법</h3>
                            </div>
                        </div>
                        <div class="container">
                            <div class="row g-2">
                                <div class="col-6">
                                    <div class="p-3 border bg-light">
                                        <button type="button" class="btn btn-secondary btn-lg btn-block">
                                            카카오톡<
                                    </button>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="p-3 border bg-light">
                                        <button type="button" class="btn btn-secondary btn-lg btn-block">
                                            신용카드
                                        </button>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="p-3 border bg-light">
                                        <button type="button" class="btn btn-secondary btn-lg btn-block">
                                            휴대폰결제
                                        </button>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="p-3 border bg-light">
                                        <button type="button" class="btn btn-secondary btn-lg btn-block">
                                        무통장입금
                                    </button>
                                    </div>
                                </div>
                            </div>
                        </div>
<%--                    <div class="row">
                        <div class="col-sm-5">
                            <button type="button" class="btn btn-secondary btn-lg btn-block">
                                <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                    카카오톡</div>
                            </button>
                        </div>
                        <div class="col-sm-5">
                            <button type="button" class="btn btn-secondary btn-lg btn-block">
                                신용카드
                            </button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <br/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-5">
                            <button type="button" class="btn btn-secondary btn-lg btn-block">
                                휴대폰결제
                            </button>
                        </div>
                        <div class="col-sm-5">
                            <button type="button" class="btn btn-secondary btn-lg btn-block">
                                무통장입금
                            </button>
                        </div>
                    </div>
                                            <div class="btn-group btn-group-toggle" data-toggle="buttons">
                            <label class="btn btn-secondary active">
                                <input type="radio" name="options" id="option1" autocomplete="off" checked> Active
                            </label>
                            <label class="btn btn-secondary">
                                <input type="radio" name="options" id="option2" autocomplete="off"> Radio
                            </label>
                            <label class="btn btn-secondary">
                                <input type="radio" name="options" id="option3" autocomplete="off"> Radio
                            </label>
                        </div>

                    --%>


            </div>
        </div>






























        <div class="col">
            <div class="jumbotron ">
    <table width="100%" height="37" border="0" cellpadding="0"
           cellspacing="0">
        <tr><input type="hidden" name="1" value="danal"/>
            <input type="hidden" name="2" value="phone"/>
            <input type="hidden" name="3" value="kakaopay"/>
            <input type="hidden" name="4" value="phone"/>
            <td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
                                            width="15" height="37"></td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="93%" class="ct_ttl01">상품상세조회</td>
                        <td width="20%" align="right">&nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <input type="hidden" name="orderNo" value="${purchase.orderNo}" /> <input type="hidden" name="prodName"
                                               value="<%--${orderDetail.odOrderMenuName}--%>" />

    <table width="600" border="0" cellspacing="0" cellpadding="0"
           align="center" style="margin-top: 13px;">
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>

        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">상품명
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01"><%--${product.prodName}--%>
                <input type="hidden" name="prodNo" value="<%--${product.prodNo}--%>" /></td>


        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">상품상세정보
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01"><%--${product.prodDetail}--%><input
                    type="hidden" name="fileName" value="<%--${product.fileName}--%>" />
            </td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">상품수량
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01"><%--${product.amount}--%><input type="hidden"
                                                           name="amount" value="<%--${product.amount}--%>" /></td>
        </tr>


        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">결제금액</td>
            <td bgcolor="D6D6D6" width="1"></td>
            <input type="hidden" name="orderTotalPrice" value="${purchase.orderTotalPrice}"/>
            <td class="ct_write01">${purchase.orderTotalPrice}<input type="hidden"
                                                          name="price" value="${purchase.orderTotalPrice}" /></td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">등록일자</td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">${orderDetail.odMenuImage}<input type="hidden"
                                                            name="regDate" value="<%--${product.regDate}--%>" /></td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">구매자아이디 <img
                    src="/images/ct_icon_red.gif" width="3" height="3"
                    align="absmiddle" />
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01"><%--${purchase.orderUserId.userId}--%><input type="hidden"
                                                        name="buyer.userId" value="<%--${purchase.orderUserId.userId}--%>" /></td>

        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">구매방법</td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01"><select name="payOption"
                                           class="ct_input_g" style="width: 100px; height: 19px"
                                           maxLength="20">
                <option value="1" selected="selected">현금구매</option>
                <option value="2">신용구매</option>
                <option value="3">카카오페이</option>
            </select></td>

        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">구매수량</td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01"><input type="text" name="quantity"
                                          class="ct_input_g" style="width: 100px; height: 19px"
                                          maxLength="20" /></td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">구매자이름</td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">
                <input type="hidden" name="pointAmt" value="${point.pointAmt}">
                <input type="text" name="receiverName"
                                          class="ct_input_g" style="width: 100px; height: 19px"
                                          maxLength="20" /></td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">구매자연락처</td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01"><input type="text" name="receiverPhone"
                                          class="ct_input_g" style="width: 100px; height: 19px"
                                          maxLength="20" /></td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">구매자주소</td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01"><input type="text" name="divyAddr"
                                          class="ct_input_g" style="width: 100px; height: 19px"
                                          maxLength="20" /></td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">구매요청사항</td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01"><input type="text" name="divyRequest"
                                          class="ct_input_g" style="width: 100px; height: 19px"
                                          maxLength="20" /></td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">배송희망일자</td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td width="200" class="ct_write01"><input type="text"
                                                      readonly="readonly" id="datepicker" name="divyDate"
                                                      class="ct_input_g" style="width: 100px; height: 19px"
                                                      maxLength="20" /></td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
    </table>


                <button type="button" class="btn btn-primary btn-lg" name="clickPay">
                    결제하기
                </button>
                <button type="button" class="btn btn-primary btn-lg" >
                    controller 2번 타기
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
