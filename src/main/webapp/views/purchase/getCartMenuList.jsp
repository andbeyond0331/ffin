<%@ page contentType="text/html;charset=UTF-8" language="java"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!doctype html>
<html lang="ko">
<meta charset="EUC-KR">

<head>
    <jsp:include page="/views/toolbar.jsp" />
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

</head>

<!-- Bootstrap Dropdown Hover CSS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>




<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<script type="text/javascript">

    $(function() {
        $("button.btn.btn-primary:Contains('확인')").click(function () {
            alert("넘거간다.");
            $("form").attr("method" , "POST").attr("action" , "/purchase/addCart").submit();

        });
    });
    $(function() {
        $("button.btn.btn-primary:Contains('json')").click(function () {
            alert("ddk");
            to_ajax();
            $("form").attr("method" , "POST").attr("action" , "/purchase/addCart").submit();
        });
    });
    function  to_ajax(){

        $.ajax({
            type: "post",
            url: '/purchase/json/addCartList',
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            data : $("#form input").serialize(),
            dataType: 'json',
            success: function(response){
                if(response === 1){
                    //load chech.php file
                }  else {
                    //show error
                }
            }
        });
    }

</script>
<style type="text/css">


    html,
    body {
        margin: 0; }
    .header {
        height: 80px;
        position: sticky;
        top: 0;
        background: burlywood; }
    .container {
        display: flex;
        flex-flow: row nowrap; }
    .content {
        width: 120%;
        height: 3000px;
        background: #f5f5f5; }
    .sidebar {
        font-size: 10px;
        width: 40%;
        height: 400px;
        position: sticky;
        top: 80px;
        background: yellowgreen; }
    .footer {
        background: #333;
        height: 200px; }




</style>



    <title>Title</title>
    <link rel="stylesheet" href="/css/admin.css" type="text/css">
</head>
<body bgcolor="#ffffff" text="#000000">

<form name="form">


    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">New message</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="orderPickUpTime" class="col-form-label">픽업희망시간:</label>
                        <div class="btn-group" role="group" id="orderPickUpTime" aria-label="Basic radio toggle button group">
                            <input type="radio" class="btn-check"  id="btnradio1" autocomplete="off" checked>
                            <label class="btn btn-outline-primary" for="btnradio1" value="5">5분</label>

                            <input type="radio" class="btn-check"  id="btnradio2" autocomplete="off">
                            <label class="btn btn-outline-primary" for="btnradio2" value="10">10분</label>

                            <input type="radio" class="btn-check" id="btnradio3" autocomplete="off">
                            <label class="btn btn-outline-primary" for="btnradio3" value="15">15분</label>

                            <input type="radio" class="btn-check"  id="btnradio4" autocomplete="off">
                            <label class="btn btn-outline-primary" for="btnradio4" value="20">20분</label>

                            <input type="radio" class="btn-check"  id="btnradio5" autocomplete="off">
                            <label class="btn btn-outline-primary" for="btnradio5" value="30">30분</label>

                            <input type="radio" class="btn-check"  id="btnradio6" autocomplete="off">
                            <label class="btn btn-outline-primary" for="btnradio6" value="40">40분</label>

                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="message-text" class="col-form-label">주문요청사항:</label>
                        <textarea class="form-control" id="message-text"  value="${purchase.orderRequest}"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary">확인</button>
                </div>
            </div>
        </div>
    </div>

<div class="container">
    <div class="content">Main content</div>
    <div class="sidebar">



        <div class="content">



            <div class="page-header text-info">
                <h3>장바구니</h3>
            </div>

        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">


            <thead>
            <tr>
                <td class="ct_list_b" width="100">no</td>
                <td class="ct_line02" size></td>
                <td class="ct_list_b" width="150">메뉴 이름</td>
                <td class="ct_line02"></td>
                <td class="ct_list_b" width="150">메뉴 설명</td>
                <td class="ct_line02"></td>
                <td class="ct_list_b" width="150">메뉴 가격</td>
                <td class="ct_line02"></td>
                <td class="ct_list_b">대표 메뉴 여부
                    <input type="hidden"   name="orderUserId.userId" value="user01"/>
                    <input type="hidden"  name="orderTruckId.truckId" value="truck01"/>
                    <input type="hidden"  name="orderQty" value="3"/>
               <input type="hidden"  name="orderPickUpTime" value="15"/>
                    <input type="hidden"  name="orderTotalPrice" value="3000"/>

                </td>
                <td class="ct_line02"></td>
                <td class="ct_list_b">메뉴 이미지</td>
            </tr>
            </thead>

        <c:set var="i" value="0"/>
        <c:forEach var="cart" items="${map.get('list')}">
            <c:set var="i" value="${i+1}" />
            <tr class="ct_list_pop">
                <td align="center">

                        ${i}
                </td>
                <td></td>

                <td align="left">

                    <span class="odMenuName">${cart.odMenuName}</span>
                    <span class="odOptionGroupName" hidden="">${cart.odOptionGroupName}</span>
                    <span class="odOptionName" hidden="">${cart.odOptionName}</span>

                </td>

                <td></td>
                <td align="left">
                    <input type="hidden" id="odMenuName" name="odMenuName" value="${cart.odMenuName}"/>
                    <input type="hidden" id="odOptionGroupName" name="odOptionGroupName" value="${cart.odOptionGroupName}"/>
                    <input type="hidden" id="odOptionName" name="odOptionName" value="${cart.odOptionName}"/>
                    <input type="hidden" id="odMenuQty" name="odMenuQty" value="${cart.odMenuQty}"/>
                    <input type="hidden" id="odMenuPrice" name="odMenuPrice" value="${cart.odMenuPrice}"/>
                    <input type="hidden" id="odOptionPrice" name="odOptionPrice" value="${cart.odOptionPrice}"/>
                    <input type="hidden" id="odMenuImage" name="odMenuImage" value="${cart.odMenuImage}"/>
                        ${cart.odMenuQty}
                </td>
                <td></td>
                <td align="left">
                        ${cart.odMenuPrice}
                </td>
                <td></td>
                <td align="left">
                        ${cart.odOptionPrice}
                </td>
            <tr>
                <td id="${cart.odMenuImage}" colspan="11" bgcolor="D6D7D6" height="1"></td>
            </tr>
        </c:forEach>
        </table>

            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">주문하기</button>
            <button type="button" class="btn btn-primary">json</button>
        </div>
       <%-- <table border=1>
            <tr>
                <td>메뉴이름</td>
                <td>${cart.odMenuName}</td>
                <td></td>
            </tr>
            <tr>
                <td>옵션그룹이름</td>
                <td>${cart.odOptionGroupName}</td>
                <td></td>
            </tr>
            <tr>
                <td>옵션이름</td>
                <td>${cart.odOptionName}</td>
                <td></td>
            </tr>
            <tr>
                <td>메뉴수량</td>
                <td>${cart.odMenuQty}</td>
                <td></td>
            </tr>
            <tr>
                <td>메뉴가격</td>
                <td>${cart.odMenuPrice}</td>
                <td></td>
            </tr>
            <tr>
                <td>옵션가격</td>
                <td>${cart.odOptionPrice}</td>
                <td></td>
            </tr>
            <tr>
                <td>메뉴이미지</td>
                <td>${cart.odMenuImage}</td>
                <td></td>
            </tr>
        </table>--%>
    </div>
</div>

</form>
<jsp:include page="/views/footer.jsp" />
</body>



</html>
