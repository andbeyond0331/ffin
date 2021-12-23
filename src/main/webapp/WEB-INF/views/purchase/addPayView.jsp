<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="/css/admin.css" type="text/css">

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
        src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Bootstrap Dropdown Hover CSS -->
<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

<!-- Bootstrap Dropdown Hover JS -->
<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
      href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<!--  ///////////////////////// CSS ////////////////////////// -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

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
                    location.href="http://127.0.0.1:8080/purchase/listPurchase";
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
                    location.href="http://127.0.0.1:8080/purchase/listPurchase";
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
                    location.href="http://127.0.0.1:8080/purchase/listPurchase";
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
        if(quantity != null && quantity > amount ){
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
        }


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
    /*     $(function() {
            $( "#datepicker" ).datepicker({
              changeYear: true,
              changeMonth: true
            });
          });   */
    $(function() {
        $( "#datepicker" ).datepicker({
            showButtonPanel: true,
            closeText: "닫기",
            currentText: "오늘",
            prevText: '이전 달',
            nextText: '다음 달',
            yearSuffix: '년',
            monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            dayNames: ['일', '월', '화', '수', '목', '금', '토'],
            dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
            dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
            weekHeader: "주",
            dateFormat: 'y/dd/mm'
        });
    });


</script>
</head>

<body>

<form name="addPurchase">

    <table width="100%" height="37" border="0" cellpadding="0"
           cellspacing="0">
        <tr><input type="hidden" name="1" value="danal"/>
            <input type="hidden" name="2" value="phone"/>
            <input type="hidden" name="3" value="kakaopay"/>
            <input type="hidden" name="4" value="phone"/>
            <td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
                                            width="15" height="37"></td>
            <td background="/images/ct_ttl_img02.gif" width="100%"
                style="padding-left: 10px;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="93%" class="ct_ttl01">상품상세조회</td>
                        <td width="20%" align="right">&nbsp;</td>
                    </tr>
                </table>
            </td>
            <td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
                                            width="12" height="37" /></td>
        </tr>
    </table>

    <input type="hidden" name="purchaseProd.prodNo"
           value="${product.prodNo}" /> <input type="hidden" name="prodName"
                                               value="${product.prodName}" /> <input type="hidden"
                                                                                     name="prodDetail" value="${product.prodDetail}" />

    <table width="600" border="0" cellspacing="0" cellpadding="0"
           align="center" style="margin-top: 13px;">
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="300" class="ct_write">상품번호 <img
                    src="/images/ct_icon_red.gif" width="3" height="3"
                    align="absmiddle" />
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01" width="299">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>

                        <td width="105">${product.prodNo}</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">상품명 <img
                    src="/images/ct_icon_red.gif" width="3" height="3"
                    align="absmiddle" />
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">${product.prodName}<input type="hidden"
                                                             name="prodNo" value="${product.prodNo}" /></td>


        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">상품상세정보 <img
                    src="/images/ct_icon_red.gif" width="3" height="3"
                    align="absmiddle" />
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">${product.prodDetail}<input
                    type="hidden" name="fileName" value="${product.fileName}" />
            </td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">상품수량 <img
                    src="/images/ct_icon_red.gif" width="3" height="3"
                    align="absmiddle" />
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">${product.amount}<input type="hidden"
                                                           name="amount" value="${product.amount}" /></td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">제조일자</td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">${product.manuDate}<input type="hidden"
                                                             name="manuDate" value="${product.manuDate}" /></td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">가격</td>
            <td bgcolor="D6D6D6" width="1"></td>
            <input type="hidden" name="price" value="${product.price}"/>
            <td class="ct_write01">${product.price}<input type="hidden"
                                                          name="price" value="${product.price}" /></td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">등록일자</td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">${product.regDate}<input type="hidden"
                                                            name="regDate" value="${product.regDate}" /></td>
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
            <td class="ct_write01">${user.userId}<input type="hidden"
                                                        name="buyer.userId" value="${user.userId}" /></td>

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
            <td class="ct_write01"><input type="text" name="receiverName"
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

    <table width="100%" border="0" cellspacing="0" cellpadding="0"
           style="margin-top: 10px;">
        <tr>
            <td width="53%"></td>
            <td align="center">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="17" height="23"><img src="/images/ct_btnbg01.gif"
                                                        width="17" height="23" /></td>
                        <td background="/images/ct_btnbg02.gif" class="ct_btn01"
                            style="padding-top: 3px;">
                            <!-- <a href="javascript:fncAddPurchase();">구매</a> -->구매
                        </td>
                        <td width="14" height="23"><img src="/images/ct_btnbg03.gif"
                                                        width="14" height="23" /></td>
                        <td width="30"></td>
                        <td width="17" height="23"><img src="/images/ct_btnbg01.gif"
                                                        width="17" height="23" /></td>
                        <td background="/images/ct_btnbg02.gif" class="ct_btn01"
                            style="padding-top: 3px;">
                            <!-- <a href="javascript:history.go(-1)">취소</a> -->취소
                        </td>
                        <td width="14" height="23"><img src="/images/ct_btnbg03.gif"
                                                        width="14" height="23" /></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</form>

</body>
</html>
