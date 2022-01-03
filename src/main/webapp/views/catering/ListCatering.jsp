<%@ page import="com.ffin.service.domain.Catering" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <!-- Basic -->
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <!-- Mobile Metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <!-- Site Metas -->
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <title>F.FIN | FOODTRUCK FINDER</title>

    <!-- bootstrap core css -->
    <link rel="stylesheet" type="text/css" href="../../resources/bootstrap/css/bootstrap.css" />

    <!-- fonts style -->
    <link href="https://fonts.googleapis.com/css?family=Poppins:400,600,700&display=swap" rel="stylesheet">

    <!-- font awesome style -->
    <link href="../../resources/bootstrap/css/font-awesome.min.css" rel="stylesheet" />
    <!-- nice select -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" integrity="sha256-mLBIhmBvigTFWPSCtvdu6a76T+3Xyt+K571hupeFLg4=" crossorigin="anonymous" />
    <!-- slidck slider -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css" integrity="sha256-UK1EiopXIL+KVhfbFa8xrmAWPeBjMVdvYMYkTAEv/HI=" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css.map" integrity="undefined" crossorigin="anonymous" />

    <!-- Custom styles for this template -->
    <link href="../../resources/bootstrap/css/style.css" rel="stylesheet" />
    <!-- responsive style -->
    <link href="../../resources/bootstrap/css/responsive.css" rel="stylesheet" />

    <!--    Favicons-->
    <link rel="apple-touch-icon" sizes="180x180" href="../../resources/bootstrap/assets/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="../../resources/bootstrap/assets/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../../resources/bootstrap/assets/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="../../resources/bootstrap/assets/favicons/favicon.ico">
    <link rel="manifest" href="../../resources/bootstrap/assets/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="../../resources/bootstrap/assets/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">

    <!-- jQery -->
    <script src="../../resources/bootstrap/js/jquery-3.4.1.min.js"></script>
    <!-- bootstrap js -->
    <script src="../../resources/bootstrap/js/bootstrap.js"></script>
    <!-- slick  slider -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.js"></script>
    <!-- nice select -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js" integrity="sha256-Zr3vByTlMGQhvMfgkQ5BtWRSKBGa2QlspKYJnkjZTmo=" crossorigin="anonymous"></script>
    <!-- custom js -->
    <script src="../../resources/bootstrap/js/custom.js"></script>


    <%--주소API--%>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
    <link href='../../resources/fullcalendar/core/main.css' rel='stylesheet' />
    <link href='../../resources/fullcalendar/daygrid/main.css' rel='stylesheet' />
    <link href='../../resources/fullcalendar/timegrid/main.min.css' rel='stylesheet' />
    <script src='../../resources/fullcalendar/core/main.js'></script>
    <script src='../../resources/fullcalendar/daygrid/main.js'></script>
    <script src="../../resources/fullcalendar/interaction/main.min.js"></script>
    <script src="../../resources/fullcalendar/timegrid/main.min.js"></script>
    <script src='../../resources/fullcalendar/core/locales/ko.js'></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>


    <%
        List<Catering> list = (List<Catering>) request.getAttribute("list");
    %>





    <style>
        h4{
            color : #fd7622;
        }

        body{
            background-size: cover;
        }
        html, body {
            margin: 0;
            padding: 0;
            font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
            font-size: 14px;
        }

        #calendar-container {
            position: relative;
            z-index: 1;

        }

        #calendar {
            max-width: 900px;
            margin: 20px auto;
        }
        img{ max-width:100%;}
        .allCT{
            background-color : #ced4da;
        }

        .cards-box {
            display: flex;
            justify-content: flex-start;
            margin: 0 70px;
            margin-top: 65px;
            flex-wrap: wrap;

        }
        .container{
            margin-top: 132px
        }

    </style>

</head>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=51615d81a030d0475e576eb41e443c14&libraries=services"></script>

<body id="page-top">
<jsp:include page="/views/navbar.jsp" />
<%--


<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">

    <div class="page-header text-info">
        <h3>예약목록조회</h3>
    </div>

    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
    <div class="row">

        <div class="col-md-6 text-left">

        </div>

    </div>
    <!-- table 위쪽 검색 Start /////////////////////////////////////-->


    <!--  table Start /////////////////////////////////////-->
    <table class="table table-hover table-striped" >

        <thead>
        <tr>
            <th align="center">서비스 No</th>
            <c:if test="${sessionScope.role eq 'user'}">
                <th align="center" >푸드트럭 상호</th>
            </c:if>
            <c:if test="${sessionScope.role eq 'truck'}">
                <th align="center" >이용자 이름</th>
            </c:if>
            <th align="center">견적</th>
            <th align="center">서비스 일자</th>
            <th align="center">상태코드</th>
        </tr>
        </thead>

        <tbody>

        <c:set var="i" value="0" />
        <c:forEach var="catering" items="${list}">
            <c:set var="i" value="${ i+1 }" />
            <tr>
                <td align="center">${catering.ctTruck.truckName}</td>
                <c:if test="${sessionScope.role eq 'user'}">
                     <td align="center" >${catering.ctTruck.truckName}</td>
                </c:if>
                <c:if test="${sessionScope.role eq 'truck'}">
                    <td align="center" >${catering.ctUser.userName}</td>
                </c:if>
                <td align="center">${catering.ctQuotation}</td>
                <td align="center">${catering.ctDate}</td>
                <c:if test="${catering.ctStatusCode eq '1'}">
                 <td align="center">수락 대기</td>
                </c:if>
                <c:if test="${catering.ctStatusCode eq '2'}">
                    <td align="center">이용자 취소</td>
                </c:if>
                <c:if test="${catering.ctStatusCode eq '3'}">
                    <td align="center">사업자 거절</td>
                </c:if>
                <c:if test="${catering.ctStatusCode eq '4'}">
                    <td align="center">결제 대기</td>
                </c:if>
                <c:if test="${catering.ctStatusCode eq '5'}">
                    <td align="center">예약 완료</td>
                </c:if>
            </tr>
        </c:forEach>

        </tbody>

    </table>
    <!--  table End /////////////////////////////////////-->

</div>
<!--  화면구성 div End /////////////////////////////////////-->


--%>

<div class="card-colums" id="all_posting">
    <div class="container">

        <div class="detail-box" >
            <h4 style="margin-top: 10px; align: center">
                예약목록조회
            </h4>
            <a href="/catering/getCtServAllList?cate=list">예약가능 서비스 조회</a>
        </div>


    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
    <div class="row">

        <div class="col-md-6 text-left">
            <div id="calStatus"> <a href="/catering/listCatering"> 전체 </a>
                <a href="/catering/getCtServAllList?cate=list" style=" background-color : #008d62;"> 예약가능 </a>
                <a href="/catering/getCtStatusList?ctStatusCode=1&cate=list" style=" background-color : #bcb5f3;"> 수락대기 </a>
                <a href="/catering/getCtStatusList?ctStatusCode=4&cate=list" style=" background-color : #fcab31;"> 수락완료(결제대기) </a>
                <a href="/catering/getCtStatusList?ctStatusCode=5&cate=list" style=" background-color : #f81f59;"> 예약완료 </a>
            </div>
        </div>

    </div>
    <div id="card-box" class="cards-box">
        <c:forEach var="catering" items="${list}">
        <div class="card" style="width: 23rem; margin-bottom:15px; margin-left: 10px;">
            <img class="card-img-top" src="../../resources/image/${catering.ctMenu.menuImg1}" alt="Card image cap"
                 style="border-bottom: 1px solid #eee; height: 300px;">
            <div class="card-body">
                <ul class='card-body-ul'>






                    <c:if test="${sessionScope.role eq 'user'}">
                    <li> 푸드트럭 상호명 :${catering.ctTruck.truckName}</li>
                    </c:if>
                    <c:if test="${sessionScope.role eq 'truck'}">
                        <li> 이용자 이름 :${catering.ctUser.userName}</li>
                    </c:if>
                    <li> 서비스 날짜 : ${catering.ctDate}</li>
                    <li> 견적 : ${catering.ctQuotation}</li>
                    <li> 상태코드 :
                    <c:if test="${catering.ctStatusCode eq '0'}">예약가능</c:if>
                    <c:if test="${catering.ctStatusCode eq '1'}">수락 대기</c:if>
                    <c:if test="${catering.ctStatusCode eq '2'}">이용자 취소</c:if>
                    <c:if test="${catering.ctStatusCode eq '3'}">사업자 거절</c:if>
                    <c:if test="${catering.ctStatusCode eq '4'}">결제 대기</c:if>
                    <c:if test="${catering.ctStatusCode eq '5'}">예약 완료</c:if>
                    </li>
                </ul>
                <div class="btn-detail">
                    <button class="button is-warning is-light"
                            style='margin-left: 100px; margin-bottom: 13px; height: 25px'
                            onclick="">자세히
                    </button>
                </div>
            </div>
        </div>
        </c:forEach>
    </div>
</div>
</div>

<jsp:include page="/views/footer.jsp" />

</body>
</html>