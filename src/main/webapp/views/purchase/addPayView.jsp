<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>




<html>
<head>
<meta charset="EUC-KR">
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<link rel="stylesheet" href="/css/admin.css" type="text/css">

</head>
<body>
<!-- Bootstrap Dropdown Hover CSS -->
<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

<!-- Bootstrap Dropdown Hover JS -->
<script src="/javascript/bootstrap-dropdownhover.min.js"></script>


<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<!--  ///////////////////////// CSS ////////////////////////// -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<style>

    body {
        padding-top: 50px;
    }
</style>
<script type="text/javascript">


    var kakaopay = function(){


        var IMP = window.IMP; // 생략가능
        IMP.init('imp67651684'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        var msg;

        var price= $("input[name='price']").val()
        var prnm = $("input[name='prodName']").val();
        var total = 0;
        var prodParam = [];
        var stkcntParam = [];


        $( "input[name='chklist']:checked" ).each(function(i){
            var chk = $(this).val();
            //alert($(this).parents('div').find("input[name='stockCount']").val())
            var amount = $(this).parents('div').find("input[name='"+chk+"']").val()

            var pr = $("input[name='price']").val()

            prodParam.push($(this).val());
            stkcntParam.push(amount);
            price += pr * amount ;

            total++;
        });

        var paymentOption = $("select[name='paymentOption']").val();
        var receiverName =  $("input[name='receiverName']").val();
        var receiverPhone =  $("input[name='receiverPhone']").val();
        var divyAddr =  $("input[name='divyAddr']").val();
        var divyRequest =  $("input[name='divyRequest']").val();
        var divyDate =  $("input[name='divyDate']").val();



        var postData = { "prodParam" : prodParam,
            "stkcntParam" :stkcntParam,
            "paymentOption" : paymentOption,
            "receiverName" : receiverName,
            "receiverPhone" : receiverPhone,
            "divyAddr" : divyAddr,
            "divyRequest" : divyRequest,
            "divyDate" : divyDate,
            "totalPrice" : price }


        alert(paymentOption);
        if(paymentOption=='1'){
            IMP.request_pay({
                pg : 'danal',
                pay_method : 'phone',
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
                        url: "/purchase/json/addPurchase", //cross-domain error가 발생하지 않도록 주의해주세요
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
            });}else if(paymentOption=='2'){
            IMP.request_pay({
                pg : 'kakaopay',
                pay_method : 'card',
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
                        url: "/purchase/json/addPurchase", //cross-domain error가 발생하지 않도록 주의해주세요
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
            });}else if(paymentOption=='3'){
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
                        url: "/purchase/json/addPurchase", //cross-domain error가 발생하지 않도록 주의해주세요
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

        var amount = $("input[name='amount']").val();
        var quantity = $("input[name='quantity']").val();
        var divyDate = $("input[name='divyDate']").val();
        var paymentOption = $("select[name='paymentOption']").val();
        var price = $("input[name='price']").val();
        var receiverName = $("input[name='receiverName']").val();
        var receiverPhone = $("input[name='receiverPhone']").val();
        var divyRequest = $("input[name='divyRequest']").val();
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
        $("td.ct_btn01:contains('구매')").click(function() {

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

</script>


<form name="addPurchase">
    <!-- Modal -->
    <%--Modal 작은칸--%>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                </div>
                <div class="modal-body">
                    ...
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>


    <div class="container-fluid">
    <div class="row">


        <div class="col">
            <div class="jumbotron ">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-12">
                        <h3>결제하기</h3>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <h3>할인 및 적립금</h3>
                        </div>
                    </div>

                        <div class="row">
                        <label for="couponPrice" class="col-sm-offset-1 col-sm-3 control-label">할인쿠폰</label>
                        <div class="col-sm-3">
                            <div class="well well-sm">${coupon.couponPrice}</div>
                            <input type="hidden" class="form-control" id="couponPrice"
                                   name="couponPrice" placeholder="상품명을 입력하세요" >
                        </div>
                        <div class="col-sm-1">
                           원
                        </div>
                        <div class="col-sm-3">
                            <!-- Button trigger modal -->
                            <button type="button" class="btn btn-secondary btn-sm" data-toggle="modal" data-target="#myModal">
                                쿠폰적용
                           </button>
                        </div>
                        </div>

                        <div class="row">

                            <label for="pointAmt" class="col-sm-offset-1 col-sm-3 control-label">적립금</label>
                            <div class="col-sm-2">
                                <%--<div class="well well-sm">${user.userTotalPorint}</div>--%>
                                <input type="hidden" name="pointAmt" id="pointAmt" value="${point.pointAmt}">
                                <div class="well well-sm">0</div>
                            </div>
                            <div class="col-sm-2">
                                <div class="well well-sm">${point.pointAmt}</div>
                            </div>
                            <div class="col-sm-1">
                                원
                            </div>
                            <div class="col-sm-2">
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
                        <div class="row">
                            <div class="col-sm-10">
                    <h3>결제방법</h3>
                            </div>
                        </div>
                    <div class="row">
                        <div class="col-sm-5">
                            <button type="button" class="btn btn-secondary btn-lg btn-block">
                                카카오톡
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






                </div>








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
            <td width="300" class="ct_write">상품번호 <img
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01" width="299">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="105"><%--${product.prodNo}--%></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">상품명
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01"><%--${product.prodName}--%><input type="hidden"
                                                             name="prodNo" value="<%--${product.prodNo}--%>" /></td>


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
            <td width="104" class="ct_write">제조일자</td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01"><%--${product.manuDate}--%><input type="hidden"
                                                             name="manuDate" value="<%--${product.manuDate}--%>" /></td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">가격</td>
            <td bgcolor="D6D6D6" width="1"></td>
            <input type="hidden" name="price" value="${purchase.orderTotalPrice}"/>
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
            <td class="ct_write01"><select name="paymentOption"
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
                    다음
                </button>
            </div>

</div>
    </div>
    </div>


</form>


</body>
</html>
