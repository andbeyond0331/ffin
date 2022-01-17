<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">

<!doctype html>
<html lang="ko">
<meta charset="EUC-KR">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<head>
    <jsp:include page="../../common/lib.jsp"/>
</head>
<body>
<jsp:include page="/views/navbar.jsp"/>
<!-- Bootstrap Dropdown Hover CSS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>

<style>
    .btn-outline-success {
        color: #ffba49;
        border-color: #ffba49;
    }

    .btn-check:active+.btn-outline-success, .btn-check:checked+.btn-outline-success, .btn-outline-success.active, .btn-outline-success.dropdown-toggle.show, .btn-outline-success:active {
        color: #fff;
        background-color: #ffba49;
        border-color: #ffba49;
    }

    .btn-primary {
        color: #f8f9fa;
        background-color: #ffba49;
        border-color: #ffba49;
    }
    .row {
        display: -ms-flexbox;
        display: flex;
        -ms-flex-wrap: wrap;
        flex-wrap: wrap;
        margin-right: -28px;
        margin-left: -17px;
    }

    /*장바구니내부 스크롤*/
    .card-body ul, .order-wrap-pc ul {
        max-height: 300px;
        overflow-x: hidden;
        overflow-y: auto;
    }
    body{
        margin-top: 80px;
    }
</style>
<main>

    <div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel"
         tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalToggleLabel">Modal 1</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">


                    <div class="container-fluid">
                        <div class="row">
                            <input type="radio" class="btn-check" name="orderNopeReason" id="btnradio1"
                                   autocomplete="off" value="1" checked>
                            <label class="btn btn-outline-primary" for="btnradio1">구매의사 취소</label>
                        </div>
                    </div>

                    <div class="container-fluid">
                        <div class="row">
                            <input type="radio" class="btn-check" name="orderNopeReason" id="btnradio2"
                                   autocomplete="off" value="2">
                            <label class="btn btn-outline-primary" for="btnradio2">메뉴 및 수량 변경</label>
                        </div>
                    </div>

                    <div class="container-fluid">
                        <div class="row">
                            <input type="radio" class="btn-check" name="orderNopeReason" id="btnradio3"
                                   autocomplete="off" value="3">
                            <label class="btn btn-outline-primary" for="btnradio3">주문접수 지연</label>
                        </div>
                    </div>
                    <div class="container-fluid">
                        <div class="row">
                            <input type="radio" class="btn-check" name="orderNopeReason" id="btnradio4"
                                   autocomplete="off" value="4">
                            <label class="btn btn-outline-primary" for="btnradio4">기 타</label>
                        </div>
                    </div>


                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary" data-bs-dismiss="modal" aria-label="Close">취소</button>
                    <button class="btn btn-primary" data-bs-target="#exampleModalToggle2" data-bs-toggle="modal">다 음
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="exampleModalToggle2" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2"
         tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalToggleLabel2">Modal 2</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    정말로 주문취소 하나요??
                </div>
                <div class="modal-footer">

                    <button class="btn btn-primary" data-bs-dismiss="modal" aria-label="Close">취소</button>
                    <button class="btn btn-primary" onclick="cancelPay()">확인</button>
                </div>
            </div>
        </div>
    </div>




    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">영업모드</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <c:if test="${truckId.truckBusiStatus.equals('1')}">
                        영업종료하시겠습니까??
                    </c:if>
                    <c:if test="${truckId.truckBusiStatus.equals('0')}">
                        영업시작하시겠습니까??
                    </c:if>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" id="busiStatus">등록</button>
                </div>
            </div>
        </div>
    </div>


    <div class="container py-4">
        <header class="pb-4 mb-5 py-4 border-bottom">
            <span class="fs-1">주문내역</span>
        </header>

        <div class="container-fluid">
            <div class="row justify-content-evenly">

                <div class="col-5 p-3 mb-2  bg-light text-dark">

                    <div class="row ">
                        <div class="col-2">

                            <button class="btn btn-primary" id="ing" type="button">처리중</button>

                            <button class="btn btn-primary" id="end" type="button">픽업완료</button>

                            <button class="btn btn-primary" id="cancel" type="button">주문취소</button>
                        </div>
                        <div class="col-10">
                            <div class="row justify-content-between">
                                <div class="col-6 text-center"> 전체 :</div>
                                <div class="col-6">
                                    <div class="form-check form-switch">
                                        <c:if test="${truckId.truckBusiStatus.equals('1')}">
                                            <input class="form-check-input" type="checkbox" role="switch"
                                                   id="swCh" name="swCh"  data-bs-toggle="modal" data-bs-target="#staticBackdrop" checked>
                                            <label class="form-check-label" for="swCh">영업중</label>
                                        </c:if>
                                        <c:if test="${truckId.truckBusiStatus.equals('0')}">
                                            <input class="form-check-input" type="checkbox" role="switch"
                                                   id="swCh" name="swCh"  data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                                            <label class="form-check-label" for="swCh">영업종료</label>
                                        </c:if>

                                    </div>
                                </div>
                                <br><br>
                            </div>

                            <c:set var="i" value="0"/>
                            <c:forEach var="cart" items="${map.get('list')}">
                                <c:set var="i" value="${i+1}"/>

                                <hr class="my-2">
                                <div class="row">
                                    <div class="col-1">
                                            ${i}
                                    </div>
                                    <div class="col-9">
                                        <div class="row">
                                            <div class="col-4">
                                                <a href="#" class="text-break" id="orderUserId">${cart.orderUserId.userId}</a>
                                                <input type="hidden" id="orderNo" name="orderNo" value="${cart.orderNo}"/>

                                            </div>
                                            <div class="col-6" id="orderPickUp">
                                                픽업희망시간 : ${cart.orderPickUpTime}
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-4">
                                                <a href="#" class="text-break"><%--${cart.odMenuName}--%></a>

                                            </div>
                                            <div class="col-6">
                                                예상조리시간 : ${cart.orderCookingTime}
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-1">
                                            ${cart.orderStatus}
                                    </div>
                                </div>

                                <%--                                <input type="hidden" id="orderNo" name="orderNo" value="${cart.odOrderNo.orderNo}"/>--%>
                                <input type="hidden" id="userId" name="userId"
                                       value="${cart.orderUserId.userId}"/>
                                <input type="hidden" id="truckId" name="truckId"
                                       value="${cart.orderTruckId.truckId}"/>
                                <input type="hidden" id="orderStatus" name="orderStatus"
                                       value="${cart.orderStatus}"/>
                                <input type="hidden" id="odMenuPrice" name="orderPickUpTime"
                                       value="${cart.orderPickUpTime}"/>
                                <input type="hidden" id="orderCookingTime" name="orderCookingTime"
                                       value="${cart.orderCookingTime}"/>
                                <input type="hidden" name="searchCondition" value="${search.searchCondition}">

                                <%--<input type="hidden" id="odMenuName" name="odMenuName" value="${cart.odMenuName}"/>--%>

                            </c:forEach>
                        </div>
                    </div>


                </div>

                <div class="col-6 p-3 mb-2 bg-light  text-dark">
                    <c:if test="${check !=1}">
                    <div class="row " id="CookingTime">
                        <c:if test="${purchase.orderStatus == 1}">
                            <div class="col-2"> 상호 : ${purchase.orderTruckId.truckName}</div>
                            <div class="col-2">
                                <button class="btn btn-primary" data-bs-toggle="modal" href="#exampleModalToggle"
                                        type="button">주문거절
                                </button>
                            </div>
                            <div class="col-6">
                                <input type="radio" class="btn-check" name="cookingTime" id="cookingTimes" autocomplete="off" value="5" checked>
                                <label class="btn btn-outline-success" for="cookingTimes" >5분</label>

                                <input type="radio" class="btn-check" name="cookingTime" id="cookingTimes1" autocomplete="off" value="10">
                                <label class="btn btn-outline-success" for="cookingTimes1" >10분</label>

                                <input type="radio" class="btn-check" name="cookingTime" id="cookingTimes2" autocomplete="off"  value="15">
                                <label class="btn btn-outline-success" for="cookingTimes2">15분</label>

                                <input type="radio" class="btn-check" name="cookingTime" id="cookingTimes3" autocomplete="off"  value="20">
                                <label class="btn btn-outline-success" for="cookingTimes3">20분</label>

                                <input type="radio" class="btn-check" name="cookingTime" id="cookingTimes4" autocomplete="off"  value="30">
                                <label class="btn btn-outline-success" for="cookingTimes4">30분</label>

                                <input type="radio" class="btn-check" name="cookingTime" id="cookingTimes5" autocomplete="off"  value="40">
                                <label class="btn btn-outline-success" for="cookingTimes5">40분</label>


                            </div>
                            <div class="col-2">

                                <button class="btn btn-primary" type="button" name="updateTranCode">주문접수</button>

                            </div>
                        </c:if>
                        <c:if test="${purchase.orderStatus == 2}">
                            <div class="col-2"> 상호 : ${purchase.orderTruckId.truckName}</div>
                            <div class="col-5">
                                <button class="btn btn-primary" data-bs-toggle="modal" href="#exampleModalToggle"
                                        type="button">주문거절
                                </button>
                            </div>
                            <div class="col-5">

                                <button class="btn btn-primary" type="button" name="updateTranCode">픽업요청</button>

                            </div>
                        </c:if>
                        <c:if test="${purchase.orderStatus == 3}">
                            <div class="col-2"> 상호 : ${purchase.orderTruckId.truckName}</div>
                            <div class="col-5">

                            </div>
                            <div class="col-5">

                                <button class="btn btn-primary" type="button" name="updateTranCode">픽업완료</button>
                            </div>
                        </c:if>
                        <c:if test="${purchase.orderStatus == 4}">
                            <div class="col-2"> 상호 : ${purchase.orderTruckId.truckName}</div>
                            <div class="col-5">

                            </div>
                            <div class="col-5">

                                주문처리가 완료되었습니다
                            </div>
                        </c:if>
                        <c:if test="${purchase.orderStatus == 5}">
                            <div class="col-2"> 상호 : ${purchase.orderTruckId.truckName}</div>
                            <div class="col-5">

                            </div>
                            <div class="col-5">

                                주문취소된 메뉴 입니다
                            </div>
                        </c:if>

                    </div>
                    <hr class="my-2">
                    <div class="row">

                        <div class="col-7">

                            <div class="row">
                                <label for="orderRequest" class="col-form-label">주문요청사항 :</label>
                                <textarea class="form-control" id="orderRequest" name="orderRequest"
                                          value="${purchase.orderRequest}" disabled>${purchase.orderRequest}</textarea>
                            </div>
                            <br>
                            <div class="row">
                                <label for="orderRequest" class="col-form-label">픽업희망시간
                                    : ${purchase.orderPickUpTime}</label>
                            </div>
                            <hr class="my-2">
                            <div class="row" id="list">

                                <label for="orderRequest" class="col-form-label">주문내역 :</label>

                                <div id="order"></div>

                                <c:set var="list" value="${orderMap.get('list')}"/>
                                <c:set var="i" value="0"/>
                                <c:forEach var="order" items="#{list}">
                                    <c:set var="i" value="${i+1}"/>


                                    <input type="hidden" id="orderMenuName" name="orderMenuName"
                                           value="${order.odMenuName}"/>
                                    <input type="hidden" id="orderOptionGroupName" name="orderOptionGroupName"
                                           value="${order.odOptionGroupName}"/>
                                    <input type="hidden" id="orderOptionName" name="orderOptionName"
                                           value="${order.odOptionName}"/>
                                    <input type="hidden" id="orderMenuQty" name="orderMenuQty"
                                           value="${order.odMenuQty}"/>
                                    <input type="hidden" id="orderMenuPrice" name="orderMenuPrice"
                                           value="${order.odMenuPrice}"/>
                                    <input type="hidden" id="orderOptionPrice" name="orderOptionPrice"
                                           value="${order.odOptionPrice}"/>
                                    <input type="hidden" id="orderMenuImage" name="orderMenuImage"
                                           value="${order.odMenuImage}"/>
                                    <input type="hidden" id="orderMenuQtyFlag" name="orderMenuQtyFlag"
                                           value="${order.odMenuQtyFlag}"/>


                                </c:forEach>

                                <div id="total"><p class="text-end">결제금액 : ${purchase.payPrice}</p> </div>
                            </div>

                        </div>
                        <div class="col-1">
                            <div class="d-flex" style="height: 672px;">
                                <div class="vr"></div>
                            </div>
                        </div>

                        <div class="col-4">
                            <div class="row">
                                <label for="orderRequest" class="col-form-label">고객정보
                                    : </label>
                            </div>
                            <input type="hidden" name="payId" id="payId" value="${purchase.payId}">
                            <input type="hidden" name="purchaseOrder" id="purchaseOrder" value="${purchase.orderNo}">
                            <input type="hidden" name="truck" value="${purchase.orderTruckId.truckId}">
                            <input type="hidden" name="cookingTime" value="${purchase.orderCookingTime}">
                            <input type="hidden" name="truckBusiStatus" value="${truck.truckBusiStatus}">
                            <div class="row">

                                <img src="/resources/image/${purchase.orderUserId.userProImg}" width="90" height="120"
                                     alt="주문상품 이미지">


                            </div>

                            <br>
                            <div class="row" id="usId">
                                ${purchase.orderUserId.userId}
                            </div>
                            <br>
                            <div class="row" id="orNo">
                                주문번호 :${purchase.orderNo}
                            </div>
                            <br>
                            <div class="row" id="paDa">
                                주문일시 :${purchase.payDateTime}
                            </div>
                            <br>
                            <div class="row" id="usUN">
                                이름 : ${purchase.orderUserId.userName}
                            </div>
                            <br>
                            <div class="row" id="usUP">
                                연락처 : ${purchase.orderUserId.userPhone}
                            </div>
                            <br>

                            <div class="row" id="paOp">
                                <c:if test="${purchase.payOption == 0}">
                                    결제방법 : 휴대폰결제
                                </c:if>
                                <c:if test="${purchase.payOption == 1}">
                                    결제방법 : 카카오페이
                                </c:if>
                                <c:if test="${purchase.payOption == 2}">
                                    결제방법 : 신용카드
                                </c:if>
                                <c:if test="${purchase.payOption == 3}">
                                    결제방법 : 무통장입금
                                </c:if>
                            </div>

                        </div>

                    </div>
                    </c:if>
                    <c:if test="${check==1}">
                        <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAN0AAADlCAMAAADgMwLoAAAAflBMVEX///8AAAD6+voMDAx1dXV5eXnq6upra2uzs7OsrKyhoaHy8vKUlJQ8PDwxMTH5+flgYGDh4eHs7OzLy8u+vr5ubm6NjY3V1dVWVlZERESmpqbc3NzAwMAmJiZkZGSenp44ODiIiIhHR0cYGBgiIiKBgYFQUFArKysbGxsSEhLSQfC6AAAN1klEQVR4nN1d54LyKhB1LbHEFuMae9tVv33/F7xXBlIIwTAMkd3za4sSDmU6pNVyjFkQL0+XW3e9mR6+Oh+dr8N0M+/dVttlHIWuH+4Qwf7Uu3596PCz6Y7iX8cxjE9zLa0i5qd49u4u18QsXm0MmAlMLvG7e/4S0faOYCZwH0XvJlCNaPyo7nnncb6uj/35ffLQ7cXp2EuCi9FU1dvzcTWMd0H547t4OO5evxVfmQx9kzPLdbmX89Uyar/6YhhvPzvlr3q0B4NVaX3dluXpqka4X13lhTzyYwJ3faljvT2mY/+L2rPUjskAuUFSlJETK6kXDooLfJ6Q9RODeFOkZj/a4bAwXOv38UsKm+VCJcoXp3+5Zu/v4Rccc324LknbjvMrdN78/gt7ued36TVwkG//1rAVus09e+VGds9OuWdsnTxCjV3OLDk5fM420/PTncPnFHDJzZvjNZNbIxe3T+JIMonWa8CeyNbnTwPmWTZxm2as+bDb2PRFB/GkDq0O0D401asPpwOabYOVy8eUMGhAeLbTWMm5MQnGEaamw9HRE4J0VY4cPUGHfaobFi6aj9OJe49nMkutMweyM91yzegdFYaiC+QWRM/hwNVGIKJSPdp2hdO1eXM8QAiXNWGb4cHNmCEwErKFbJgXwpht0lKvghBuHSLRGYkt994oh0Aggr0kojsl50uQeDah69CON/XwI77IIGSLtcUkZm7zMqrcJHo0sxfwZq40vSLDjffLSrSEXFreqXpFhguXnBb7pX3wlVyrxXMX3/jQx8Zfcuni3GC/37f8vmNw0YJ0+PjcT2n7RAg++iinZWC/b12D2/ZD828mnlkoKrS/kSbijJPzKMWrgFDHpoKTu/kDJ52iQ4KS6mOLDdsohoiO8iGh9IBdoWu8g9pggHW8spyrMDXdekciB6MRLAyVOtd074jJYrA3EoDh79l0AG6S1TM71iYf9gLf9adj+RvUeBE8OlIj59aGT3bd94kQ47oyni/iX6EMMkAI/mUwmU/yvokuESKpp8MgiTtvpEuU6NWxN5e/Tl5ytOvIQjDBDPJji8AEr0Ztu54IHA2rDmBevnUfgQzLT+0mE02ZtxJzrTlYLLA1dFCgdlXjp89q6w3ATu78axw0zZ2kz5q53FywVH8A1Eb9GBjm7IFmcCfSRw0nD2z/Sut4ZjpkPwh2GjNBLvk3tCi4s1D1bwjxGVjP5VL71/isbs6SHdcKFSKRT52BV+cZO+3kwaY2UeSeseOTp3b0oEkTh9w3duCZ/lP9Czxyo9iZb+z45KmMZGjbSMd4xw4yxQq5CMpwYtSYd+x4XKGcHYCEilns2T92MEclM4CrA7O2MOw0FjoBO96G/FeIWBtWzGLYadwECnYgG2W5Aua5YTrLnF1H9wQKduDnSUobUkWmOWQlu8N4WAm9RKZgx/MKxRUCjp1pElPFzqJumYRdomACDZsm+RTsbLLsJOxarEiuoNkC1Wp9DQU7m6JeGnbj0tKEvxiH+RTsbJK1NOyi0tKcoBamih2i/iDFP6ktZDycxXpy1hg4RuZJHwU7C6GSyG0h2Y2lqRogF5VKZuKzK6W7BpDsIJaVbTM4AWMeolXqu1HYroD07TCPxbJ8KQI2U8O+fCv+iigHM7RVDuPcdxPltRAk7EChpw9iv411XyBhl9/apU1GyA5SzcLmg4AKomLd3M5Md4Mcu6RkBwEIIb3B5UNk7MzZid0we/1Riwwpqyvl0hvMakwRgDk70eHQKTsWmOUJE5CgGBPKV3aw8aAiHLQdRk/5yg5ah2QPhMkw1dO+sgObDqIrzC7TZZ5+Hzum8UCSsJZQZ8+8ZQdRoudPIFRQtr237OAY2/OQFyScUcavObtUMrtlB4P3NB3AYUAdqDFnlz6m9/qzNvVO32IoWUK2g2rDmF1m7bVr1BNYsGPm11OWsFoB3HkRNbvuuALLgrE3muehuG3Nhh2zVu7CDsM1pGJ3x1aYyRUPVuzY6fiH2IAI96elZFe/1qWEMSE7EJozRQipPhTscMMEIGQHam7BWeKiIcQxMemmOxt2M84KbGjcaR/iuZM9WpsKWNbAnmcQcEV9CnYoe5WDkh0rFBrwEhxcEyqZucZX5VKyY+75iR+wxDWh1ne9kQa6e00p2TEb5QLOAlKOY3KvGgFGyY7R6oHNgjzaimJXbdJSsrs8GzhCShlZB41jVylWKdkxcbKGJpG5DRy7flVzlOyYXXcFFVr5QD1w7CqHkpIdMzQ3kHn5e+yYkXJuscsONAVAOvjO7gFe7B9ld4B43x9lN/2rUoXF/M7Q5N9jx5yDjZU217+WowqVnSbXd3c4MYG0xOQb2uuh8qiK/EqMW9UHa4DbKqyHSK+sVkRZRnXltRxYsTkEyOKlXSsPqLU4yn1/CU0JaLv4Sauboj6fLdxaFxt2zy6ZQdtWmB8suzsD5zCSEEb05phrvWF4DaboRjwZ5PMdMSgwVgOeY/bjAkJCcLGUWIsnHxHwFQlS/bfcWFEXMGchj9raKE4fwVKuz1gYc/D8vO4ND6YJnsXRzNB8UDYdJvuBMeKI8mUETJk/rWcwVsiaXnZxtvVzrMdkt/GcQZmLa65p2o3qpMN1mNrkkDKAMHm2BeKF4uKw8NOS2xMdip6AQnjOGKgEgpvDBrpOG+Bqf8sEmCjsR/aT/S1GXV2PzWB9Lw/z7sCtm2dELWDzzsISbFcn6ww4GeAlWNrRmFdNuqPH2oCbyWOC9sy92BewMut3uSZArFjZYkNdR3Gw7w5X4Uz12SS8F/TksEFIBhYrEpEwUMEWl7qbvLm2NizWJisJEAEcqGHEb7w6JyfMgT+nCNtOqBXYePjYqKqCjQBorQdFKumvk+KvhnCx655AX/vFRjszTyBMil3o5eI8IiD9FgiLZtGGivsDaoJYkWdAvukLxEjOOmG/Iz3Y8pGen0HlEbxKzKJLqR2kCmb6IH+xGFjAOB+vdO0WVtjt5YZwoXYY7fxChIZx9XlLuVPoNzKUyk8t+lMQIuwvyitzXmIrdcki/k/CTuHyfJYJ14U84haxA7n8FPW+5tLCFH4CSqHLL8i2cDbkF2Vj2CnDRHCtGybzMpK6ZPFWQ4qVyaqLZMG2Qo+7HE7BV7WX5BOiDVDd8iu1oLQdkz+P5T5hPcWZHAjFqJZP9ZIGWxMRfygnz7sonZCU6kMQYgA6U64ZgWWBKTpSHIvfdHuGOJavCsDsExDgCu/iRz2nr3Ep94sGCH+afU+1ooE2QuK5cV5RQgAknErjcmsYoRQOmi5aALEwYf0p/wXiBpGFpQqxSzDvCMgO9fKLsI26mTzEayDhxGKF6ICyL8SlASWVRwCEsgNPp0rd8slD7DzbtJ0CCM0LSqVS6oPzgDEUTW/FfgnEuoQIdLWlxCcPofNQ1X4aIKy59svOg9jEOEKRpqvmwITZQV/rQl98CjABlgW6GKAMTHSOd10rNMARQpXatsmyXKhIHzxdv1354sX513uS6eujgrSglF4lsngmDhkGHuKq3HOYI0tLYGBfFvOBn4fOnsVdzNX0HJMTttyh7hXz9q9diZbjXt8U3cs2xldy8E7XcJn4m0a9qSWuAzB0a9mQwA55NOgtuLAe17NMuU2MzMC8ATVfBsRh9E6y96MN8rJ2FgTEntmd7e/D3GBdPsGn+neUE/PUr4HHtPo9W4/PhJHHdDUekDeBG89mFQT8Sx3KWmUngKTYl6F25mrB6hxVA8C+3ZQnHW3KtdyDdxKREOUHI20uu3ENHkhF5bLPCGnUKKx2j4gE+XoCiuuCb6TkE5Uofr4cVcSp0AUkscf0RObJ4piIyGRbVKY6QkIx8JiXozcBsaosa9/BRrV4L4ATCHK28tzmEkNnECX01ic+dxQLgBhjopkTcsWrt9SLA0cEh9lGdjqFHrM7HTnpTQrvRySi3SQWFBspfyIsaSkZzV75hzbCXYBHkj8ONFsFckI2L2giRCBqttA3/0qIPPIS0oNiZEsp9kYhZHev0BxrfgLqcD3ImKT1TP8I43RsG+Nq3SkRpgepSC1e6cDQm5CdNKJblU98Ve7iWdyU07dPC1PPtI9sV1qrz33QbSJLFGWn+yyq5ZUIKhSC2Acr1/ImyC5XmJJL7uwNGAXkjiifXPJb5KrrHAQeC0eb02cWrwVwxi/IcTu62AQrhUKQTzV9fFxcOEhJrnTp4CYox9KahexRIJ/VYfikvrFrn18frqLhrDQnHxDLDv18tpI80anuinJDBIVjYe5iOqz5TING2Q2XTI7GhSNla5JUbTgsrI6bO60DAbF00WdDehSCJi4u1N7eTsSEg+LZ9bHL7CgoBC4zomyi8pOUSGfpj0vsaO9G0ulnx24lGObwczZxc2lAg1uxUx/Ti3HJVzCQ71G9Oi9JYAqBBVV2WVm3IrbZ3spnOj+mvUFN22IRn+alws5VA/UIzAx65pYv6WPXFbMSrRRHLr77p2USVu2dMNpve6o7IubNxAL4He5JdnpM54EkVacSHpv5bTwaDgb7OIn3g8HwNO6tJxUHUO6EqkUPeF626u6vjJK4pzhGZ4D1oLniNPnyjVo2QzRE3iVzWMWNRjiKdxxs6ruOu21ffpu3HvexRWEtEoWTZ6bKJ4xPn3UozlfL4C1RqdzFKROkzx/Fp1X/ei5Xgj+u/fE2fmcdWuYXW1uyszCMkjje7+M42S3CmQcxRGFDTv0v9UOAqwLqYI0nYPvu4UOY3Qku3tUDGOI/P5WpBYaF8HcAAAAASUVORK5CYII=">
                    </c:if>
                </div>
            </div>

        </div>
        <%--</div>--%>
    </div>

</main>

<script>
    $(function () {
        var odMenuNameCount = $("input[name='orderMenuName']").length;


        var odMenuNameL;
        var odOptionGroupNameL;
        var odOptionNameL;
        var odMenuQtyL;
        var odMenuPriceL;
        var odOptionPriceL;
        var odMenuImageL;

        for (var i = 0; i < odMenuNameCount; i++) {
            var odMenuName = $("input[name='orderMenuName']").eq(i).val();
            var odOptionGroupName = $("input[name='orderOptionGroupName']").eq(i).val();
            var odOptionName = $("input[name='orderOptionName']").eq(i).val();
            var odMenuQty = $("input[name='orderMenuQty']").eq(i).val();
            var odMenuPrice = $("input[name='orderMenuPrice']").eq(i).val();
            var odOptionPrice = $("input[name='orderOptionPrice']").eq(i).val();
            var odMenuImage = $("input[name='orderMenuImage']").eq(i).val();
            var odMenuQtyFlag = $("input[name='orderMenuQtyFlag']").eq(i).val();


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



        }

        var sum = new Array() ;
        var test3 = new Array();

        odOptionPriceL = odOptionPriceCopy.split("/");

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


        var menuPrice = 0;
        for (var i = 0; i < odMenuNameL.length; i++) {


            menuPrice += (sum[i] + odMenuPriceL[i]);


            divElemApply1 = "<div class=\"card mb-3\" >" +
                " <div class=\"row g-0\">" +
                "<div class=\"col-md-12\">" +
                "<div class=\"card-body\">" +
                "<h6 class=\"card-title\">" + odMenuNameL[i] + "</h6>" +
                "<p class=\"card-text\"><small class=\"text-muted font-size 12px\">옵션 " + odOptionNameL[i] + " :" + odOptionGroupNameL[i] + "  :</small><br><small class=\"text-muted\">수량 :" + odMenuQtyL[i] + " 가격 :" + (sum[i] + odMenuPriceL[i]) + " </small></p>" +
                "</div>" +
                "</div>" +
                "</div>" +
                "</div>"


            $('#order').append(divElemApply1);

        }
        /*        divElemApply2 = "<input type=\"hidden\" name=\"orderPrice\" id=\"orderPrice\" value=\"" + menuPrice + "\">" +
                    "<h5 id='price'>합계 : " + menuPrice + "</h5>"


                $('#total').append(divElemApply2);*/

    });


    /*




                        <div class="card mb-3 h-10" style="width: 300px; height: 90px" >
                            <div class="row g-0">
                                <div class="col-md-4">
                                    <img src="/resources/image/1.jpg" class="img-fluid rounded-start" alt="image">
                                </div>
                                <div class="col-md-8">
                                    <div class="card-body">
                                        <h5 class="card-title">${cart.odMenuName}</h5>
                                        <p class="card-text"></p>
                                        <p class="card-text"><small class="text-muted">${cart.odMenuPrice + cart.odOptionPrice}</small></p>
                                    </div>
                                </div>
                            </div>
                        </div>


                                        <input type="hidden" id="odMenuName" name="odMenuName" value="${cart.odMenuName}"/>
                                    <input type="hidden" id="odOptionGroupName" name="odOptionGroupName" value="${cart.odOptionGroupName}"/>
                                    <input type="hidden" id="odOptionName" name="odOptionName" value="${cart.odOptionName}"/>
                                    <input type="hidden" id="odMenuQty" name="odMenuQty" value="${cart.odMenuQty}"/>
                                    <input type="hidden" id="odMenuPrice" name="odMenuPrice" value="${cart.odMenuPrice}"/>
                                    <input type="hidden" id="odOptionPrice" name="odOptionPrice" value="${cart.odOptionPrice}"/>
                                    <input type="hidden" id="odMenuImage" name="odMenuImage" value="${cart.odMenuImage}"/>



*/
    $("#busiStatus").on("click",function(){
        var truckId = $("input[name='truck']").val();
        var tb = $("input[name='swCh']:checked").val();


        if(tb == 'on'){
            tb=1;
        }else if(tb==undefined){
            tb=0;
        }

        $.ajax({
            url: "/purchase/json/updateBusiStatus",
            method: "POST",
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            data: {
                "truckId": truckId,
                "tb" : tb
            },
            success: function (data) {

                alert("영업모드 변경되었습니다!")

                window.location.reload();
            }
        });


    });

    $("#ing").on("click",function(){

        var truckId = $("input[name='truck']").val();
        var search = "0";
        self.location = "/purchase/getOrderList?truckId="+truckId+"&search="+search

    });
    $("#cancel").on("click",function(){
        var truckId = $("input[name='truck']").val();
        self.location = "/purchase/getOrderList?truckId="+truckId+"&search="+2
    })

    $("#end").on("click",function(){
        var truckId = $("input[name='truck']").val();
        self.location = "/purchase/getOrderList?truckId="+truckId+"&search="+1
    })

/*    $("#swCh").on("click",function(){

        var on = $("input[name='swCh']:checked").val();

    })*/



    /*이용자아이디 클릭시*/
    $("a#orderUserId.text-break").on("click", function () {
        var orderNo = $(this).parent().find("input[name='orderNo']").val();
        var truckId = $("input[name='truck']").val();
        var search = $("input[name='searchCondition']").val();

        self.location = "/purchase/getOrderList?truckId="+truckId+"&orderNo="+orderNo+"&search="+search;

    });

    /* $.ajax({
         url: "/purchase/json/getPurchase",
         method: "POST",
         contentType: "application/x-www-form-urlencoded; charset=UTF-8",
         data: {
             "orderNo": orderNo

         },
         success: function (data) {

             alert("상세보기선택하였습니다!")
             alert(data.purchase.orderNo)
                 var ordeerPickUp ="";

             var list = data.map;
             var usId = "";
             var orNo = "";
             var paDa = "";
             var usUN = "";
             var usUP = "";
             var paOp = "";
             var orderMenuName = "";
             var orderOptionGroupName ="";
             var orderOptionName ="";
             var orderMenuQty ="";
             var orderMenuPrice ="";
             var orderOptionPrice ="";
             var orderMenuImage ="";
             var orderMenuQtyFlag ="";
             var list = "";
           /!* orderPickUp =  "<div class="col-6" id="orderPickUp">"
                             "픽업희망시간 : cart.orderPickUpTime}"
                          "</div>"*!/


             usId = "<div class='row' id='usId'>"+data.purchase.orderUserId.userId+"</div>"
             orNo = "<div class='row' id='orNo'>주문번호 :"+data.purchase.orderNo+"</div>"
             paDa = "<div class='row' id='paDa'>주문일시 :"+data.purchase.payDateTime+"</div>"

             usUN = "<div class='row' id='usUN'>이름 : "+data.purchase.orderUserId.userName+"</div>"
             usUP = "<div class='row' id='usUP'>연락처 : "+data.purchase.orderUserId.userPhone+"</div>"
             paOp = "<div class='row' id='paOp'>결제방법 :"+data.purchase.payOption+"</div>"


<c:remove var="list"/>
                <% pageContext.setAttribute("list", "data.map");%>
                data.map.forEach(x=>{
                    alert(x.odMenuName)*/


    /*

                            orderMenuName =     "<input type='text' id='orderMenuName' name='orderMenuName' value='"+x.odMenuName+"'/>"
                            /!*orderOptionGroupName = "<input type='text' id='orderOptionGroupName' name='orderOptionGroupName' value='"+x.odOptionGroupName+"'/>"
                            orderOptionName =   "<input type='hidden' id='orderOptionName' name='orderOptionName' value='"+x.odOptionName+"'/>"
                            orderMenuQty =      "<input type='hidden' id='orderMenuQty' name='orderMenuQty' value='"+x.odMenuQty+"'/>"
                            orderMenuPrice =    "<input type='hidden' id='orderMenuPrice' name='orderMenuPrice' value='"+x.odMenuPrice+"'/>"
                            orderOptionPrice =  "<input type='hidden' id='orderOptionPrice' name='orderOptionPrice' value='"+x.odOptionPrice+"'/>"
                            orderMenuImage =    "<input type='hidden' id='orderMenuImage' name='orderMenuImage' value='"+x.odMenuImage+"'/>"
                            orderMenuQtyFlag =   "<input type='hidden' id='orderMenuQtyFlag' name='orderMenuQtyFlag' value='"+x.odMenuQtyFlag+"'/>"*!/

                })
    */


    /*
                            list =  "<label for='orderRequest' class='col-form-label'>주문내역 :</label>"+
                    "<div id='order'></div>"+
                   "<c:set var='i' value='0'/>"+
                "<c:forEach var='order' items='${data.map}'>"+
                "<c:set var='i' value='${i+1}'/>"+
                "<input type='hidden' id='orderMenuName' name='orderMenuName' value='"+order.odMenuName+"'/>"+
                "<input type='hidden' id='orderOptionGroupName' name='orderOptionGroupName' value='${order.odOptionGroupName}'/>"+
                "<input type='hidden' id='orderOptionName' name='orderOptionName'  value='${order.odOptionName}'/>"+
                "<input type='hidden' id='orderMenuQty' name='orderMenuQty' value='${order.odMenuQty}'/>"+
                "<input type='hidden' id='orderMenuPrice' name='orderMenuPrice' value='${order.odMenuPrice}'/>"+
                "<input type='hidden' id='orderOptionPrice' name='orderOptionPrice' value='${order.odOptionPrice}'/>"+
                "<input type='hidden' id='orderMenuImage' name='orderMenuImage' value='${order.odMenuImage}'/>"+
                "<input type='hidden' id='orderMenuQtyFlag' name='orderMenuQtyFlag' value='${order.odMenuQtyFlag}'/>"+
                "</c:forEach>"+
                "<div id='total'></div>"
*/
    /*

                    $('#orNo').html(orNo);
                    $('#paDa').html(paDa);
                    $('#usId').html(usId);
                    $('#usUN').html(usUN);
                    $('#usUP').html(usUP);
                    $('#paOp').html(paOp);
                   $('#orderMenuName').html(orderMenuName);
                     /!*$('#orderOptionGroupName').html(orderOptionGroupName);*!/
                   /!* $('#orderOptionName').html(orderOptionName);
                    $('#orderMenuQty').html(orderMenuQty);
                    $('#orderMenuPrice').html(orderMenuPrice);
                    $('#orderOptionPrice').html(orderOptionPrice);
                    $('#orderMenuImage').html(orderMenuImage);
                    $('#orderMenuQtyFlag').html(orderMenuQtyFlag);*!/

    */

    /*            /!*window.location.reload();*!/
            }
        });

    })
*/

    /*주문접수버튼*/
    $("button[name='updateTranCode']").on("click", function () {
        var userId = $("input[name='userId']").val();
        var orderCookingTime = $("input[name='cookingTime']:checked").val();
        if(orderCookingTime == undefined){
            orderCookingTime = $("input[name='cookingTime']").val();

        }
        alert(userId)
        $.ajax({
            url: "/purchase/json/updateTranCode",
            method: "POST",
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            data: {
                "orderNo": $("input[name='purchaseOrder']").val(),
                "orderCookingTime" : orderCookingTime
            },
            success: function (data) {

                alert("접수되었습니다!")

                window.location.reload();
            }
        });

    });





    /* Iamport 환불시스템*/
    function cancelPay() {

        var payId = $("input[name='payId']").val();
        var orderNo = $("input[name='purchaseOrder']").val();
        var orderNopeReason = $("input[name='orderNopeReason']:checked").val();
        alert(orderNopeReason)
        var orderCancelReason =0;
        $.ajax({
            url: "/purchase/json/payRefund", // 예: http://www.myservice.com/payments/cancel
            type: "POST",
            async: false,
            dataType: "json",
            data: {
                "payId": payId,
                "orderNo": orderNo,
                "orderNopeReason": orderNopeReason,
                "orderCancelReason": orderCancelReason,
            },

            success: function (map) {
                location.href = "http://127.0.0.1:8080/";
            },
            error: function (xhr, status, error) {
                alert("[Error]" + error);
                return;
            }

        });

    }


</script>
</body>
<%--<jsp:include page="/views/footer.jsp"/>--%>
</html>