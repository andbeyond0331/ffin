<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>메뉴 목록</title>
    <jsp:include page="../../common/lib.jsp"/>

    <style>
        <%--/////////////////////////////////////  장바구니 소스 ////////////////////////////////////--%>
        .card {
            display: flex;
            /*justify-content: space-between;*/
            margin: 0 70px;
            margin-top: 65px;
            flex-wrap: wrap;
        float: left;
        }
        <%--/////////////////////////////////////  장바구니 소스 ////////////////////////////////////--%>
    </style>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

    <script type="text/javascript">

        window.onload = function () {
            alert("why? : " + $("tr.ct_list_pop td").find("input[name=menuNo]").val());


            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            // var menuNo = trim($(this.find("input[name=menuNo]").val()));
            $("tr.ct_list_pop td").on("click", function () {
                self.location = "/menu/getMenu?menuNo=" + $("tr.ct_list_pop td").find("input[name=menuNo]").val();
            });

        };
        <%--/////////////////////////////////////  장바구니 소스 ////////////////////////////////////--%>

        var stmnLEFT = 50; // 오른쪽 여백
        var stmnGAP1 = 0; // 위쪽 여백
        var stmnGAP2 = 150; // 스크롤시 브라우저 위쪽과 떨어지는 거리
        var stmnBASE = 150; // 스크롤 시작위치
        var stmnActivateSpeed = 35; //스크롤을 인식하는 딜레이 (숫자가 클수록 느리게 인식)
        var stmnScrollSpeed = 20; //스크롤 속도 (클수록 느림)
        var stmnTimer;

        function RefreshStaticMenu() {
            var stmnStartPoint, stmnEndPoint;
            stmnStartPoint = parseInt(document.getElementById('staticMenu').style.top, 10);
            stmnEndPoint = Math.max(document.documentElement.scrollTop, document.body.scrollTop) + stmnGAP2;
            if (stmnEndPoint < stmnGAP1) stmnEndPoint = stmnGAP1;
            if (stmnStartPoint != stmnEndPoint) {
                stmnScrollAmount = Math.ceil( Math.abs( stmnEndPoint - stmnStartPoint ) / 15 );
                document.getElementById('staticMenu').style.top = parseInt(document.getElementById('staticMenu').style.top, 10) + ( ( stmnEndPoint<stmnStartPoint ) ? -stmnScrollAmount : stmnScrollAmount ) + 'px';
                stmnRefreshTimer = stmnScrollSpeed;
            }
            stmnTimer = setTimeout("RefreshStaticMenu();", stmnActivateSpeed);
        }
        function InitializeStaticMenu() {
            document.getElementById('staticMenu').style.right = stmnLEFT + 'px'; //처음에 오른쪽에 위치. left로 바꿔도.
            document.getElementById('staticMenu').style.top = document.body.scrollTop + stmnBASE + 'px';
            RefreshStaticMenu();
        }

        <%--/////////////////////////////////////  장바구니 소스 ////////////////////////////////////--%>


    </script>
<style>
    #staticMenu { margin: 0pt; padding: 0pt; position: absolute; right: 0px; top: 0px;}

</style>
</head>
<body onload="InitializeStaticMenu();">

<jsp:include page="/views/navbar.jsp" />
<br>
<br>
<div class="container mt-3">
    <h2>메뉴 목록이야</h2>
    <p>주문을 해보지 않을래?</p>

                <c:set var="i" value="0"/>
                <c:forEach var="menu" items="${list}">
                    <c:set var="i" value="${i+1}"/>
                    <div class="card" style="width: 17rem; margin-bottom:15px; margin-left: 10px;">
                        <img class="card-img-top" src="/resources/image/${menu.menuImg1}" alt="Card image cap"
                             style="border-bottom: 1px solid #eee; height: 200px;">
                        <div class="card-body">
                            <ul class='card-body-ul'>
                                <li> ${menu.menuName}</li>
                                <li> ${menu.menuDetail}</li>
                                <li> ${menu.menuPrice}원</li>
                            </ul>
                            <div class="btn-detail">
                                <button class="button is-warning is-light"
                                        style='margin-left: 100px; margin-bottom: 13px; height: 25px'
                                        onclick="fncGetMenuOptionGroup();">메뉴 상세보기
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>


</div>
<%--/////////////////////////////////////  장바구니 소스 ////////////////////////////////////--%>
<div id="staticMenu">

    <div class="card" style="width: 18rem;">
        <div class="card-header">
            <div class="row">
                <div class="col-10">
            장바구니</div>
            <div class="col-2">
            <svg type="button" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
            </svg></div>
            </div>
        </div>
        <div class="card-body">


        </div>
        <div class="card-footer" type="button">
         <p class="text-center" style="font-size: x-large">주문하기</p>
        </div>
    </div>

</div>

<%--/////////////////////////////////////  장바구니 소스 ////////////////////////////////////--%>
<br>
<br>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

<jsp:include page="/views/footer.jsp" />
</body>
</html>
