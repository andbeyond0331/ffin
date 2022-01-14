<%--
  Created by IntelliJ IDEA.
  User: PSW
  Date: 2022-01-12
  Time: 오후 6:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    .bs-canvas-overlay {
        opacity: 0.85;
        z-index: 1100;
    }

    .bs-canvas {
        top: 0;
        z-index: 1110;
        overflow-x: hidden;
        overflow-y: auto;
        width: 330px;
        transition: margin .4s ease-out;
        -webkit-transition: margin .4s ease-out;
        -moz-transition: margin .4s ease-out;
        -ms-transition: margin .4s ease-out;
    }



    .bs-canvas-right {
        right: 0;
        margin-right: -330px;
    }

    /* Only for demo */

</style>

<form class="cart">
    <div class="bs-canvas bs-canvas-right position-fixed bg-light h-100">
        <header class="bs-canvas-header p-3 bg-primary overflow-auto">
            <button type="button" class="bs-canvas-close float-left close" aria-label="Close"><span aria-hidden="true"
                                                                                                    class="text-light">&times;</span>
            </button>
            <h4 class="d-inline-block text-light mb-0 float-right">장바구니</h4>
        </header>
        <div class="bs-canvas-content px-3 py-5">
            <div class="content">

                <div id="cartOrderMenu"></div>

                <%--
                            <div class="card mb-3" style="max-width: 540px;">
                                <div class="row no-gutters">
                                    <div class="col-md-4">
                                        <div class="form-check">
                                            <input class="form-check-input position-static" type="checkbox" id="blankCheckbox" value="option1" aria-label="..." style="margin-left: -0.5em;">
                                        </div>
                                        <img src="/resources/image/1.jpg"  class="btn img-fluid rounded-start" alt="image" referrerpolicy="no-referrer" style="width: 100px;">
                                    </div>
                                    <div class="col-md-8">
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col6">
                                                    <h6 class="card-title">메뉴이름</h6>
                                                </div>
                                                <div class="col-6">


                                                </div>
                                            </div>
                                            <div class="row">
                                                <p class="card-text"><small class="text-muted" style="font-size: .600em;">Last updated 3 mins ago</small><br><small class="text-muted" style="font-size: .600em;">Last updated 3 mins ago</small></p>
                                        </div>
                                            <tr style="text-align:center;">
                                                <td>수량</td>
                                                <td class="bseq_ea">7</td>
                                                <td>
                                                    <button type ="button" onclick="fnCalCount('p',this);">+</button>
                                                    <input type="text" name="pop_out" value="0" readonly="readonly" style="text-align:center;"/>
                                                    <button type="button" onclick="fnCalCount('m', this);">-</button>
                                                </td>
                                            </tr>
                                        </div>
                                    </div>
                                </div>
                            </div>--%>



                <%--<div id="order"></div>--%>
                <%-- <c:set var="i" value="0"/>
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
     --%>
                <%--<div id="total"></div>--%>
                <div class="row">
                    <div class="col-6">
                        <button type="button" class="btn btn btn-primary" data-toggle="modal"
                                data-target="#exampleModalCenter">
                            주문하기
                        </button>
                    </div>
                    <div class="col-2">

                    </div>
                    <div class="col-4">
                        <button type="button" class="btn btn-primary" id="deleteCartMenu">삭제</button>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <%--modal--%>
    <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalCenterTitle">New message</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="mainOrderPickUpTime" class="col-form-label">픽업희망시간:</label>
                        <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
                            <input type="radio" class="btn-check" id="mainOrderPickUpTime" name="mainOrderPickUpTime" value="5"
                                   id="cancelTime1" autocomplete="off" checked>
                            <label class="btn btn-outline-primary" for="cancelTime1">5분</label>

                            <input type="radio" class="btn-check" name="mainOrderPickUpTime" value="10" id="cancelTime2"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="cancelTime1">10분</label>

                            <input type="radio" class="btn-check" name="mainOrderPickUpTime" value="15" id="cancelTime3"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="cancelTime1">15분</label>

                            <input type="radio" class="btn-check" name="mainOrderPickUpTime" value="20" id="cancelTime4"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="cancelTime1">20분</label>

                            <input type="radio" class="btn-check" name="mainOrderPickUpTime" value="30" id="cancelTime5"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="cancelTime1">30분</label>

                            <input type="radio" class="btn-check" name="mainOrderPickUpTime" value="40" id="cancelTime6"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="cancelTime1">40분</label>

                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="mainOrderRequest" class="col-form-label">주문요청사항:</label>
                        <textarea class="form-control" id="mainOrderRequest" name="mainOrderRequest"
                                  value="${purchase.orderRequest}"></textarea>

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" id="orderGo">확인</button>

                    <input type="hidden" id="mainOrderUserId" name="mainOrderUserId" value="${user.userId}"/>
                    <div id="mainSessionTruckId"></div>
                    <input type="hidden" id="mainOrderQty" name="mainOrderQty" value="3"/>
                    <input type="hidden" id="mainOrderTotalPrice" name="mainOrderTotalPrice" value="3000"/>
                </div>
            </div>
        </div>
    </div>


</form>


<script>




    $(function(){


        var beforeAnyway = JSON.parse(sessionStorage.getItem("menuOdList"));

        for( var i in beforeAnyway){
            // console.log("beforeAnyway : " + beforeAnyway[i]);
            for(var j in beforeAnyway[i]){
                console.log("afterAnyway key : " +j+"/value : " + beforeAnyway[i][j]);

            }
        }
        //담을 li

        var finalCart = "";
        var forOne=0;
        var mainOrderList = "";

        ////////////시작///////////////////
        if(beforeAnyway) { // sessionStorage에 뭔가 있다?
            console.log("sessionStorage에 있다! 시작!");
            for (var i = 0; i < beforeAnyway.length; i++) {//sessionStorage만큼 for문 돌리기



                /*            mainOrderList += "<input type='hidden' name='mainOdMQFlag' id='mainOdMQFlag' value='" + beforeAnyway[i]['odMenuQtyFlag'] + "'>" +
                                "<input type='hidden' name='mainOdMQty' id='mainOdMQty' value='" + beforeAnyway[i]['odMenuQty'] + "'>" +
                                "<input type='hidden' name='mainOdMName' id='mainOdMName' value='" + beforeAnyway[i]['odMenuName'] + "'>" +
                                "<input type='hidden' name='mainOdMPrice' id='mainOdMPrice' value='" + beforeAnyway[i]['odMenuPrice'] + "'>" +
                                "<input type='hidden' name='mainOdOGName' id='mainOdOGName' value='" + beforeAnyway[i]['odOptionGroupName'] + "'>" +
                                "<input type='hidden' name='mainOdOpName' id='mainOdOpName' value='" + beforeAnyway[i]['odOptionName'] + "'>" +
                                "<input type='hidden' name='mainOdOpPrice' id='mainOdOpPrice' value='" + beforeAnyway[i]['odOptionPrice'] + "'>" +
                                "<input type='hidden' name='mainOdMImg1' id='mainOdMImg1' value='" + beforeAnyway[i]['odMenuImg1'] + "'>";

                            $("#cartOrderMenu").append(mainOrderList);*/



                console.log("for문 안에 있다!");
                console.log("beforeAnyway[" + i + "] : " + JSON.stringify(beforeAnyway[i]));

                if(beforeAnyway[i]['odMenuQtyFlag']==0){//플래그0일 때 메뉴 수량, 이름 출력
                    finalCart+=""+
                        "<li class=\"list-group-item d-flex justify-content-between lh-sm\">"+
                        "<div><h6 class=\"my-0\">"+beforeAnyway[i]['odMenuName']+"</h6>"+
                        "<h6 class=\"my-0\">수량 : "+beforeAnyway[i]['odMenuQty']+"</h6>"+
                        "";
                    forOne+=1;
                    // }else{
                    for(var j=i+1; j<beforeAnyway.length; j++){
                        if(beforeAnyway[j]['odMenuQtyFlag']==1){
                            finalCart+=""+
                                "<p></p>"+
                                "<small class=\"text-muted\">"+beforeAnyway[j]['odOptionGroupName']+"</small> : "+
                                "<small class=\"text-muted\">"+beforeAnyway[j]['odOptionName']+"</small> +"+
                                "<small class=\"text-muted\">"+beforeAnyway[j]['odOptionPrice']+"원</small>";
                            forOne+=1;
                        }else{
                            // i=j-1;
                            break;
                        }
                    }
                }else{
                    if(forOne!=0){
                        i=forOne;
                    }else{
                        break;
                    }

                }
                finalCart+="</div><span class=\"text-muted\">"+beforeAnyway[i]['odMenuPrice']+"원</span></li>";
                i=forOne;

            }//sessionStorage만큼 for문 돌리기
        }
        $("#cartOrderMenu").html(finalCart);


        var beforeAny = JSON.parse(sessionStorage.getItem("menuOdList"));
        var mainOrderList = "";
        var mainSessionTruckId = "";

        for (var i in beforeAny) {



            mainOrderList += "<input type='hidden' name='mainOdMQFlag' id='mainOdMQFlag' value='" + beforeAny[i]['odMenuQtyFlag'] + "'>" +
                "<input type='hidden' name='mainOdMQty' id='mainOdMQty' value='" + beforeAny[i]['odMenuQty'] + "'>" +
                "<input type='hidden' name='mainOdMName' id='mainOdMName' value='" + beforeAny[i]['odMenuName'] + "'>" +
                "<input type='hidden' name='mainOdMPrice' id='mainOdMPrice' value='" + beforeAny[i]['odMenuPrice'] + "'>" +
                "<input type='hidden' name='mainOdOGName' id='mainOdOGName' value='" + beforeAny[i]['odOptionGroupName'] + "'>" +
                "<input type='hidden' name='mainOdOpName' id='mainOdOpName' value='" + beforeAny[i]['odOptionName'] + "'>" +
                "<input type='hidden' name='mainOdOpPrice' id='mainOdOpPrice' value='" + beforeAny[i]['odOptionPrice'] + "'>" +
                "<input type='hidden' name='mainOdMImg1' id='mainOdMImg1' value='" + beforeAny[i]['odMenuImg1'] + "'>";

            mainSessionTruckId = "<input type='hidden' name='mainSessionTruckId' value='"+beforeAny[i]['menuTruckId']+"'>";



        }

        $("#mainSessionTruckId").html(mainSessionTruckId);
        $("#cartOrderMenu").append(mainOrderList);


    });

    /*메뉴수량*/
    function fnCalCount(type, ths){
        var $input = $(ths).parents("td").find("input[name='pop_out']");
        var tCount = Number($input.val());
        var tEqCount = Number($(ths).parents("tr").find("td.bseq_ea").html());

        if(type=='p'){
            if(tCount < tEqCount) $input.val(Number(tCount)+1);

        }else{
            if(tCount >0) $input.val(Number(tCount)-1);
        }
    }




    /*장바구니 화면에 보여주는 기능*/
    jQuery(document).ready(function ($) {
        $(document).on('click', '.pull-bs-canvas-right, .pull-bs-canvas-left', function () {
            $('body').prepend('<div class="bs-canvas-overlay bg-dark position-fixed w-100 h-100"></div>');
            if ($(this).hasClass('pull-bs-canvas-right'))
                $('.bs-canvas-right').addClass('mr-0');
            else
                $('.bs-canvas-left').addClass('ml-0');
            return false;
        });

        $(document).on('click', '.bs-canvas-close, .bs-canvas-overlay, .btn.btn.btn-primary', function () {
            var elm = $(this).hasClass('bs-canvas-close') ? $(this).closest('.bs-canvas') : $('.bs-canvas');
            elm.removeClass('mr-0 ml-0');
            $('.bs-canvas-overlay').remove();
            return false;
        });



    });
    $(function () {
        $("#deleteCartMenu").click(function () {

            sessionStorage.removeItem('menuOdList');
            location.reload();
        });
    });



    /*모달 화면에서 확인 클릭 시 데이터를 List로 담아서 전송*/
    $(function () {
        $("#orderGo").click(function () {

            // 1. menu 없으면 메뉴를 장바구니에 저장된 메뉴가 없습니다.
            // 2. menu 정보가 있으면 장바구니 주문하기 활성화 없으면 비활성화
            //var menucheck = document.getElementById().val;


            var order = main_cart()
            append = "<input type=\"hidden\" id=\"orderNo\" name=\"orderNo\" value=\"" + order + "\">";
            $('#app').append(append);
            /*alert(append)*/
            self.location = "/purchase/addCart?orderNo=" + order
            /* $("form").attr("method" , "POST").attr("action" , "/purchase/addCart").submit();*/

        });
    });
    $(function () {
        $("button.btn.btn-primary:Contains('json')").click(function () {
            alert("ddk");
            to_ajax();
            $("form.cart").attr("method", "POST").attr("action", "/purchase/addCart").submit();
        });
    });

    function main_cart() {
        var reOrderNo;
        var odMenuName = [];
        var odOptionGroupName = [];
        var odOptionName = [];
        var odMenuQty = [];
        var odMenuPrice = [];
        var odOptionPrice = [];
        var odMenuImage = [];
        var odMenuQtyFlag = [];
        var orderPickUpTime = $('input[name="mainOrderPickUpTime"]:checked').val();
        var orderTotalPrice = $('#mainOrderTotalPrice').val();
        var orderUserId = $('#mainOrderUserId').val();
        var orderTruckId = $('input[name="mainSessionTruckId"]').val();
        var orderRequest = $('#mainOrderRequest').val();
        var orderQty = $('#mainOrderQty').val();


        $('input[name="mainOdMName"]').each(function (i) {
            odMenuName.push($(this).val());
        });

        $('input[name="mainOdOGName"]').each(function (i) {
            odOptionGroupName.push($(this).val());
        });

        $('input[name="mainOdOpName"]').each(function (i) {
            odOptionName.push($(this).val());
        });

        $('input[name="mainOdMQty"]').each(function (i) {
            odMenuQty.push($(this).val());
        });

        $('input[name="mainOdMPrice"]').each(function (i) {
            odMenuPrice.push($(this).val());
        });

        $('input[name="mainOdOpPrice"]').each(function (i) {
            odOptionPrice.push($(this).val());
        });

        $('input[name="mainOdMImg1"]').each(function (i) {
            odMenuImage.push($(this).val());
        });

        $('input[name="mainOdMQFlag"]').each(function (i) {
            odMenuQtyFlag.push($(this).val());
        });
        /*  alert(orderPickUpTime)
          alert(orderTotalPrice)
          alert(orderUserId)
          alert(orderTruckId)
          alert(orderRequest)
          alert(orderQty)
          alert(odMenuQtyFlag)*/

        var data = {
            "odMenuName": odMenuName,
            "odOptionGroupName": odOptionGroupName,
            "odOptionName": odOptionName,
            "odMenuQty": odMenuQty,
            "odMenuPrice": odMenuPrice,
            "odOptionPrice": odOptionPrice,
            "odMenuImage": odMenuImage,
            "orderPickUpTime": orderPickUpTime,
            "orderTotalPrice": orderTotalPrice,
            "orderUserId": orderUserId,
            "orderTruckId": orderTruckId,
            "orderRequest": orderRequest,
            "orderQty": orderQty,
            "odMenuQtyFlag": odMenuQtyFlag,
        }
        $.ajax({
            type: "post",
            url: '/purchase/json/addCartList',
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            data: data,
            async: false,
            dataType: 'json',
            success: function (retVal) {
                reOrderNo = retVal.orderNo;
                sessionStorage.removeItem('menuOdList');
            },
            error: function (xhr, status, error) {
                alert("[Error]" + error);
                return;
            }


        });
        return reOrderNo;
    }

</script>