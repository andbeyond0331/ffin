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
                    <button type="button" class="btn btn-primary" data-toggle="modal"
                            data-target="#exampleModalCenter">
                        주문하기
                    </button>
                </div>
                <div class="col-2">

                </div>
                <div class="col-4">
                    <button type="button" class="btn btn-primary">삭제</button>
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
                        <label for="orderPickUpTime" class="col-form-label">픽업희망시간:</label>
                        <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
                            <input type="radio" class="btn-check" id="orderPickUpTime" name="orderPickUpTime" value="5"
                                   id="btnradio1" autocomplete="off" checked>
                            <label class="btn btn-outline-primary" for="btnradio1">5분</label>

                            <input type="radio" class="btn-check" name="orderPickUpTime" value="10" id="btnradio2"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="btnradio2">10분</label>

                            <input type="radio" class="btn-check" name="orderPickUpTime" value="15" id="btnradio3"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="btnradio3">15분</label>

                            <input type="radio" class="btn-check" name="orderPickUpTime" value="20" id="btnradio4"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="btnradio4">20분</label>

                            <input type="radio" class="btn-check" name="orderPickUpTime" value="30" id="btnradio5"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="btnradio5">30분</label>

                            <input type="radio" class="btn-check" name="orderPickUpTime" value="40" id="btnradio6"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="btnradio6">40분</label>

                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="orderRequest" class="col-form-label">주문요청사항:</label>
                        <textarea class="form-control" id="orderRequest" name="orderRequest"
                                  value="${purchase.orderRequest}"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" id="orderGo">확인</button>


                   <%-- <input type="hidden" id="orderUserId" name="orderUserId.userId" value="hhj_01"/>
                    <input type="hidden" id="orderTruckId" name="orderTruckId.truckId" value="truck01"/>
                    <input type="hidden" id="orderQty" name="orderQty" value="3"/>
                    <input type="hidden" id="orderTotalPrice" name="orderTotalPrice" value="3000"/>--%>
                </div>
            </div>
        </div>
    </div>


</form>


<script>
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

        $(document).on('click', '.bs-canvas-close, .bs-canvas-overlay', function () {
            var elm = $(this).hasClass('bs-canvas-close') ? $(this).closest('.bs-canvas') : $('.bs-canvas');
            elm.removeClass('mr-0 ml-0');
            $('.bs-canvas-overlay').remove();
            return false;
        });



    });





    /*모달 화면에서 확인 클릭 시 데이터를 List로 담아서 전송*/
    $(function () {
        $("#orderGo").click(function () {
            alert("ss")

            var order = to_ajax()


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

    function to_ajax() {
        var reOrderNo;
        var odMenuName = [];
        var odOptionGroupName = [];
        var odOptionName = [];
        var odMenuQty = [];
        var odMenuPrice = [];
        var odOptionPrice = [];
        var odMenuImage = [];
        var odMenuQtyFlag = [];
        var orderPickUpTime = $('input[name="orderPickUpTime"]:checked').val();
        var orderTotalPrice = $('#orderTotalPrice').val();
        var orderUserId = $('#orderUserId').val();
        var orderTruckId = $('#orderTruckId').val();
        var orderRequest = $('#orderRequest').val();
        var orderQty = $('#orderQty').val();

        $('input[name="odMenuName"]').each(function (i) {
            odMenuName.push($(this).val());
        });

        $('input[name="odOptionGroupName"]').each(function (i) {
            odOptionGroupName.push($(this).val());
        });

        $('input[name="odOptionName"]').each(function (i) {
            odOptionName.push($(this).val());
        });

        $('input[name="odMenuQty"]').each(function (i) {
            odMenuQty.push($(this).val());
        });

        $('input[name="odMenuPrice"]').each(function (i) {
            odMenuPrice.push($(this).val());
        });

        $('input[name="odOptionPrice"]').each(function (i) {
            odOptionPrice.push($(this).val());
        });

        $('input[name="odMenuImage"]').each(function (i) {
            odMenuImage.push($(this).val());
        });

        $('input[name="odMenuQtyFlag"]').each(function (i) {
            odMenuQtyFlag.push($(this).val());
        });
        /*         alert(orderPickUpTime)
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
            },
            error: function (xhr, status, error) {
                alert("[Error]" + error);
                return;
            }


        });
        return reOrderNo;
    }

</script>