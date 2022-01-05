<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>메뉴 목록</title>
    <jsp:include page="../../common/lib.jsp"/>

    <style>
        .card {
            display: flex;
            /*justify-content: space-between;*/
            margin: 0 70px;
            margin-top: 65px;
            flex-wrap: wrap;
        float: left;
        }
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


    </script>

</head>
<body>
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


<jsp:include page="/views/footer.jsp" />
</body>
</html>
