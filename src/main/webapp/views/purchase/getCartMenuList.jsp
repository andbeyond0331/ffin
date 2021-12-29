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
        $("button.btn.btn-primary:Contains('주문하기')").click(function () {
            alert("djkdjdk");
            $("form").attr("method" , "POST").attr("action" , "/purchase/addCart").submit();

        });
    });
    $(function() {
        $("button.btn.btn-primary:Contains('json')").click(function () {
            alert("djkdjdk");
            to_ajax();
            $("form").attr("method" , "POST").attr("action" , "/purchase/addCart").submit();
        });
    });
    function  to_ajax(){
        var query = $("form").serialize();
        $.ajax({
            type: "post",
            url: '/purchase/json/addPayView',
            data : query,
            dataType: 'json',
            error: function (xhr, status, error) {
                alert(error);
            },
            success: function (json) {
                alert(json)
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

<form>

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
                    <input type="hidden"  name="orderUserId.userId" value="user01"/>
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
                    <input type="hidden"  name="odMenuName" value="${cart.odMenuName}"/>
                    <input type="hidden"  name="odOptionGroupName" value="${cart.odOptionGroupName}"/>
                    <input type="hidden"  name="odOptionName" value="${cart.odOptionName}"/>
                    <input type="hidden"  name="odMenuQty" value="${cart.odMenuQty}"/>
                    <input type="hidden"  name="odMenuPrice" value="${cart.odMenuPrice}"/>
                    <input type="hidden"  name="odOptionPrice" value="${cart.odOptionPrice}"/>
                    <input type="hidden"  name="odMenuImage" value="${cart.odMenuImage}"/>
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

            <button type="button" class="btn btn-primary">주문하기</button>
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
