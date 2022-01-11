<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">


<head>

    <title>F.FIN | 내정보</title>
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



    </style>


    <script type="text/javascript">

    </script>
</head>

<body id="page-top">

<jsp:include page="/views/navbar.jsp" />


<!-- client section -->

<section class="client_section layout_padding">
    <div class="container">
        <div class="col-md-11 col-lg-10 mx-auto">
            <div class="detail-box">
                <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
                <h4 style="margin-top: 10px;">
                    회원정보
                </h4>
            </div>

            <form class="row justify-content-center" id="user_update_info">

                <div class="col-md-12 data-input-box adminbox">
                    <hr style="margin-top: 35px;"/>
                    <div class="data-input-box info" style="display: flex;">
                        <div>
                            <c:if test="${user.userProImg == null}">
                                <img src="../../resources/image/user_img.jpg" class="rounded float-start" alt="userProImg">
                            </c:if>
                            <c:if test="${user.userProImg != null}">
                                <img src="../../resources/image/${user.userProImg}" class="rounded float-start" alt="userProImg">
                            </c:if>
                        </div>
                        <div>
                            <div style="margin-left: 40px; margin-top: 20px; float: left;">
                                <label for="userId" class="form-label label-name">ID</label>
                                <input type="text" class="form-control" value="${user.userId}" id="userId" name="userId" readonly style="width: 400px;">
                            </div>
                            <div style="margin-left: 40px; margin-top: 20px; float: left;">
                                <label for="userName" class="form-label label-name">성명</label>
                                <input type="text" class="form-control" value="${user.userName}" id="userName" name="userName" readonly style="width: 400px;">
                            </div>
                            <div style="margin-left: 40px; margin-top: 20px; float: left;">
                                <label for="userPhone" class="form-label label-name">회원유형</label>

                                <div style="display: flex;">
                                <c:if test="${user.userByeStatus eq 0}">
                                    <h5><span class="badge" style="background-color: #ffe537; color: #110000">활동중</span></h5>
                                </c:if>
                                <c:if test="${user.userByeStatus eq 1}">
                                    <h5><span class="badge" style="background-color: #f17228; color: #ffffff">탈퇴</span></h5>
                                </c:if>

                                <c:if test="${user.reportCount % 3 == 0 && user.reportCount != 0 }">
                                    <h5><span class="badge" style="background-color: #f17228; color: white">블랙리스트</span></h5>
                                </c:if>
                                <c:if test="${user.reportCount % 3 != 0 || user.reportCount == 0}">
                                    <h5><span class="badge" style="background-color: #ffe537; color: #110000">일반회원</span></h5>
                                </c:if>
                                </div>
                            </div>
                        </div>
                    </div>

                    <hr style="margin-top: 60px;"/>

                    <div style="display: flex; justify-content: center;">
                        <div class="col-md-6 data-input-box" style="display: flex; justify-content: center;">
                            <div class="data-input-box user-info">
                                <div>
                                    <div style="margin-bottom: 30px;">
                                        <label for="userPhone" class="form-label label-name">연락처</label>
                                        <input type="text" class="form-control" value="${user.userPhone}" id="userPhone" name="userPhone" readonly style="width: 340px;">
                                    </div>
                                    <div style="margin-bottom: 30px;">
                                        <label for="userBirth" class="form-label label-name">생년월일</label>
                                        <input type="text" class="form-control" value="${user.userBirth}" id="userBirth" name="userId" readonly style="width: 340px;">
                                    </div>
                                    <div style="margin-bottom: 30px;">
                                        <label for="userAddr" class="form-label label-name">주소</label>
                                        <input type="text" class="form-control" value="${user.userAddr}" id="userAddr" name="userAddr" readonly style="width: 340px; margin-bottom: 5px;">
                                        <input type="text" class="form-control" value="${user.userAddrDetail}" id="userAddrDetail" name="userAddrDetail" readonly style="width: 340px;">
                                    </div>
                                    <div style="margin-bottom: 30px;">
                                        <label for="userEmail" class="form-label label-name">Email</label>
                                        <input type="text" class="form-control" value="${user.userEmail}" id="userEmail" name="userEmail" readonly style="width: 340px;">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 data-input-box" style="display: flex; justify-content: center;">
                            <div class="data-input-box user-profile">
                                <div>
                                    <div style="margin-bottom: 30px;">
                                        <label for="userTotalPoint" class="form-label label-name">적립금</label>
                                        <input type="text" class="form-control" value="${user.userTotalPoint}&nbsp;P" id="userTotalPoint" name="userTotalPoint" readonly style="width: 340px;">
                                    </div>
                                    <div style="margin-bottom: 30px;">
                                        <label for="userFavMenu" class="form-label label-name">좋아하는 메뉴</label>
                                        <input type="text" class="form-control" value="${user.userFavMenu}" id="userFavMenu" name="userFavMenu" readonly style="width: 340px;">
                                    </div>
                                    <div style="margin-bottom: 30px;">
                                        <label for="userFavPlace" class="form-label label-name">자주 찾는 장소</label>
                                        <input type="text" class="form-control" value="${user.userFavPlace}" id="userFavPlace" name="userFavPlace" readonly style="width: 340px; margin-bottom: 5px;">
                                        <input type="text" class="form-control" value="${user.userFavPlaceDetail}" id="userFavPlaceDetail" name="userFavPlaceDetail" readonly style="width: 340px;">
                                    </div>
                                    <div style="margin-bottom: 30px;">
                                        <label for="userIntro" class="form-label label-name">한줄소개</label>
                                        <input type="text" class="form-control" value="${user.userIntro}" id="userIntro" name="userIntro" readonly style="width: 340px;">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <hr style="margin-bottom: 35px;"/>
                </div>

            </form>

            <div class="btn-box" style=" margin-top: 20px;">
                <a onClick="history.go(-1);" style="margin-right: 10px;  background-color: #ecf0fd; border-color: #ecf0fd">
                    확인
                </a>
            </div>
        </div>
    </div>
</section>

<jsp:include page="/views/footer.jsp" />

</body>
</html>