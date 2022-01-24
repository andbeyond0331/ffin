<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">


<head>

    <title>F.FIN | 푸드트럭 정보</title>
    <jsp:include page="../../common/lib.jsp"/>

    <!-- bootstrap core css -->
    <link rel="stylesheet" type="text/css" href="../../resources/bootstrap/css/bootstrap.css" />
    <!-- Custom styles for this template -->
    <link href="../../resources/bootstrap/css/style.css" rel="stylesheet" />

    <!--    Favicons-->
    <link rel="apple-touch-icon" sizes="180x180" href="../../resources/bootstrap/assets/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="../../resources/bootstrap/assets/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../../resources/bootstrap/assets/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="../../resources/bootstrap/assets/favicons/favicon.ico">
    <link rel="manifest" href="../../resources/bootstrap/assets/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="../../resources/bootstrap/assets/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">

    <%--주소API--%>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


    <style>
        .adminbox{
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 2px 4px 1px rgba(0,0,0,0.2);
            transition: 0.3s;
        }
        .info{
            display: grid;
        }
        .info img{
            height: auto;
            max-width: 400px;
            box-shadow: 0 1px 2px 1px rgba(0,0,0,0.2);
            transition: 0.2s;
        }
        .form-control:disabled, .form-control[readonly]{
            background-color: rgba(255, 229, 55, 0.16);
            width: auto;
            opacity: 1;
            border: 0;
            /*border-width: 2px;
            border-color: #ffe537;*/
        }
        .data-input-box{
            margin-top: 30px;
        }
        h5 span{
            margin-left: 10px;
        }
        #user_update_info{
            margin-top: 20px;
        }

        .wrapper {
            width: 40%;
            margin: 40px auto;
        }

        div.gallery {
            margin-top: 30px;
            border: 0;
        }

        div.gallery ul {
            list-style-type: none;
            margin-left: 35px;
            border: 0;
            display: contents;
        }

        /* animation */
        div.gallery ul li, div.gallery li img {
            -webkit-transition: all 0.1s ease-in-out;
            -moz-transition: all 0.1s ease-in-out;
            -o-transition: all 0.1s ease-in-out;
            transition: all 0.1s ease-in-out;
        }

        div.gallery ul li {
            position: relative;
            float: left;
            width: 180px;
            height: 180px;
            margin: 5px;
            padding: 5px;
            z-index: 0;
        }

        div.gallery ul li:hover {
            z-index: 5;
        }

        div.gallery ul li img {
            position: absolute;
            left: 0;
            top: 0;
            border: 1px solid #dddddd;
            padding: 5px;
            width: 180px;
            height: 180px;
            background: #f0f0f0;
        }

        div.gallery ul li img:hover {
            width: 300px;
            height: 300px;
            margin-top: -130px;
            margin-left: -130px;
            top: 65%;
            left: 65%;
        }

        p.attribution {
            font-family: 'Consolas';
            color: #000;
            clear: both;
            text-align: center;
            line-height: 25px;
            padding-top: 30px;
        }

        p.attribution a {
            color: #4c8d7c;
        }

        @media only screen and (min-width: 499px) and (max-width: 1212px) {
            .wrapper {
                width: 500px;
            }
        }

        @media only screen and (max-width: 498px) {
            .wrapper {
                width: 300px;
            }

            div.gallery ul {
                list-style-type: none;
                margin: 0;
            }
        }

        h5 span {
            margin: 0 5px 0 5px;
        }


    </style>


    <script type="text/javascript">

        $(function () {
           $(".gallery ul li img").click(function () {

           }) ;
        });

    </script>
</head>

<body id="page-top">

<jsp:include page="/views/navbar.jsp" />
<div style="height: auto">
    <jsp:include page="/views/user/sidebar.jsp" />
</div>


<!-- client section -->

<section class="client_section layout_padding">
    <div class="container">
        <div class="col-md-11 col-lg-10 mx-auto">
            <div class="detail-box">
                <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
                <h4 style="margin-top: 10px;">
                    푸드트럭 정보
                </h4>
            </div>

            <form class="row justify-content-center" id="user_update_info">

                <div class="col-md-12 data-input-box adminbox">

                    <div style="display: flex; justify-content: center;">
                        <div class="col-md-6 data-input-box" style="display: flex; justify-content: center;">
                            <div class="col-md-12">

                                <div style="margin-top: 15px;">
                                    <h4 style="text-align: center;">${truck.truckName}</h4>
                                </div>

                                <div>
                                    <div style="margin-top: 5px;">
                                        <div style="display: flex; justify-content: center;">

                                            <c:choose>
                                                <c:when test="${truck.truckCate eq 1}">
                                                    <h5><span class="badge" style="background-color: #65bf96; color: #110000">고기</span></h5>
                                                </c:when>
                                                <c:when test="${truck.truckCate eq 2}">
                                                    <h5><span class="badge" style="background-color: #65bf96; color: #110000">분식</span></h5>
                                                </c:when>
                                                <c:when test="${truck.truckCate eq 3}">
                                                    <h5><span class="badge" style="background-color: #65bf96; color: #110000">음료</span></h5>
                                                </c:when>
                                                <c:when test="${truck.truckCate eq 4}">
                                                    <h5><span class="badge" style="background-color: #65bf96; color: #110000">양식</span></h5>
                                                </c:when>
                                                <c:when test="${truck.truckCate eq 5}">
                                                    <h5><span class="badge" style="background-color: #65bf96; color: #110000">디저트</span></h5>
                                                </c:when>
                                                <c:when test="${truck.truckCate eq 6}">
                                                    <h5><span class="badge" style="background-color: #65bf96; color: #110000">한식</span></h5>
                                                </c:when>
                                                <c:when test="${truck.truckCate eq 7}">
                                                    <h5><span class="badge" style="background-color: #65bf96; color: #110000">일식</span></h5>
                                                </c:when>
                                                <c:when test="${truck.truckCate eq 8}">
                                                    <h5><span class="badge" style="background-color: #65bf96; color: #110000">기타</span></h5>
                                                </c:when>
                                            </c:choose>

                                            <c:if test="${truck.truckByeStatus eq 0}">
                                                <h5><span class="badge" style="background-color: #ffe537; color: #110000">활동중</span></h5>
                                            </c:if>
                                            <c:if test="${truck.truckByeStatus eq 1}">
                                                <h5><span class="badge" style="background-color: #f17228; color: #ffffff">탈퇴</span></h5>
                                            </c:if>


                                            <c:choose>
                                                <c:when test="${truck.role eq 0 }">
                                                    <h5><span class="badge" style="background-color: #f17228; color: white">승인대기</span></h5>
                                                </c:when>
                                                <c:when test="${truck.role eq 1}">
                                                    <h5><span class="badge" style="background-color: #ffe537; color: #110000">가입승인완료</span></h5>
                                                </c:when>
                                            </c:choose>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <hr style="margin-top: 15px;"/>

                    <div class="data-input-box info" style="display: flex; justify-content: center;">
                        <div class="gallery">
                            <ul>
                                <c:if test="${truck.truckProImg == null}">
                                    <li><img src="/resources/image/nothing.jpg"></li>
                                </c:if>
                                <c:if test="${truck.truckProImg != null}">
                                    <li><img src="/resources/image/${truck.truckProImg}"></li>
                                </c:if>

                                <c:if test="${truck.truckBusiLice == null}">
                                    <li><img src="/resources/image/nothing.jpg"></li>
                                </c:if>
                                <c:if test="${truck.truckBusiLice != null}">
                                    <li><img src="/resources/image/${truck.truckBusiLice}"></li>
                                </c:if>

                                <c:if test="${truck.truckSigMenuImg1 == null}">
                                <li><img src="/resources/image/nothing.jpg"></li>
                                </c:if>
                                <c:if test="${truck.truckSigMenuImg1 != null}">
                                    <li><img src="/resources/menu/${truck.truckSigMenuImg1}"></li>
                                </c:if>

                                <c:if test="${truck.truckNoticeImg == null}">
                                <li><img src="/resources/image/nothing.jpg"></li>
                                </c:if>
                                <c:if test="${truck.truckNoticeImg != null}">
                                    <li><img src="/resources/image/${truck.truckNoticeImg}"></li>
                                </c:if>
                            </ul>
                        </div>
                    </div>

                    <hr style="margin-top: 15px;"/>

                    <div style="display: flex; justify-content: center;">
                        <div class="col-md-6 data-input-box" style="display: flex; justify-content: center;">
                            <div class="data-input-box user-info">
                                <div>
                                    <div style="margin-bottom: 30px;">
                                        <label for="truckCEOName" class="form-label label-name">대표자 성명</label>
                                        <input type="text" class="form-control" value="${truck.truckCEOName}" id="truckCEOName" name="truckCEOName" readonly style="width: 340px;">
                                    </div>
                                    <div style="margin-bottom: 30px;">
                                        <label for="truckCEOBirth" class="form-label label-name">대표자 생년월일</label>
                                        <input type="text" class="form-control" value="${truck.truckCEOBirth}" id="truckCEOBirth" name="truckCEOBirth" readonly style="width: 340px;">
                                    </div>
                                    <div style="margin-bottom: 30px;">
                                        <label for="truckAddr" class="form-label label-name">대표자 주소</label>
                                        <input type="text" class="form-control" value="${truck.truckAddr}" id="truckAddr" name="truckAddr" readonly style="width: 340px; margin-bottom: 5px;">
                                        <input type="text" class="form-control" value="${truck.truckAddrDetail}" id="truckAddrDetail" name="truckAddrDetail" readonly style="width: 340px;">
                                    </div>
                                    <div style="margin-bottom: 30px;">
                                        <label for="truckPhone" class="form-label label-name">대표자 연락처</label>
                                        <input type="text" class="form-control" value="${truck.truckPhone}" id="truckPhone" name="truckPhone" readonly style="width: 340px;">
                                    </div>
                                    <div style="margin-bottom: 30px;">
                                        <label for="truckEmail" class="form-label label-name">대표자 Email</label>
                                        <input type="text" class="form-control" value="${truck.truckEmail}" id="truckEmail" name="truckEmail" readonly style="width: 340px;">
                                    </div>
                                    <div style="margin-bottom: 30px;">
                                        <label for="truckCEOIntro" class="form-label label-name">한줄소개</label>
                                        <input type="text" class="form-control" value="${truck.truckCEOIntro}" id="truckCEOIntro" name="truckCEOIntro" readonly style="width: 340px;">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 data-input-box" style="display: flex; justify-content: center;">
                            <div class="data-input-box user-profile">
                                <div>
                                    <div style="margin-bottom: 30px;">
                                        <label for="truckBusiNo" class="form-label label-name">사업자등록번호</label>
                                        <input type="text" class="form-control" value="${truck.truckBusiNo}" id="truckBusiNo" name="truckBusiNo" readonly style="width: 340px;">
                                    </div>
                                    <div style="margin-bottom: 30px;">
                                        <label for="truckRegDate" class="form-label label-name">푸드트럭 등록일</label>
                                        <input type="text" class="form-control" value="${truck.truckRegDate}" id="truckRegDate" name="truckRegDate" readonly style="width: 340px;">
                                    </div>
                                    <div style="margin-bottom: 30px;">
                                        <label for="truckSigMenuName" class="form-label label-name">푸드트럭 대표메뉴</label>
                                        <input type="text" class="form-control" value="${truck.truckSigMenuName}" id="truckSigMenuName" name="truckSigMenuName" readonly style="width: 340px;">
                                    </div>
                                    <div style="margin-bottom: 30px;">
                                        <label for="userFavPlace" class="form-label label-name">푸드트럭 위치</label>
                                        <input type="text" class="form-control" value="${truck.truckMapLa}" id="userFavPlace" name="userFavPlace" readonly style="width: 340px; margin-bottom: 5px;">
                                        <input type="text" class="form-control" value="${truck.truckMapLo}" id="userFavPlaceDetail" name="userFavPlaceDetail" readonly style="width: 340px;">
                                    </div>
                                    <div style="margin-bottom: 30px;">
                                        <label for="truckNoticeTitle" class="form-label label-name">푸드트럭 공지</label>
                                        <input type="text" class="form-control" value="${truck.truckNoticeTitle}" id="truckNoticeTitle" name="truckNoticeTitle" readonly style="width: 340px; margin-bottom: 5px;">
                                        <input type="text" class="form-control" value="${truck.truckNoticeContent}" id="truckNoticeContent" name="truckNoticeContent" readonly style="width: 340px; height: 100px;}">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <hr style="margin-bottom: 35px;"/>

                </div>
        </form>

            <div class="btn btn-default">
                <a href="/truck/getTruckList" style="color: #000">
                    확인
                </a>
            </div>
        </div>
    </div>
</section>

<jsp:include page="/views/footer.jsp" />

</body>
</html>