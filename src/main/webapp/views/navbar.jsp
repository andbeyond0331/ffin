<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">

<head>

    <!-- Basic -->
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />

    <title>F.FIN | FOODTRUCK FINDER</title>

    <!-- jQery -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <!-- bootstrap js -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    <!-- slick  slider -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.js"></script>
    <!-- nice select -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js" integrity="sha256-Zr3vByTlMGQhvMfgkQ5BtWRSKBGa2QlspKYJnkjZTmo=" crossorigin="anonymous"></script>
    <!-- custom js -->
    <script src="../resources/bootstrap/js/custom.js"></script>

    <!-- 카카오 로그인 -->
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

    <!-- 구글 로그인 -->
    <script src="https://apis.google.com/js/client:platform.js?onload=renderButton" async defer></script>
    <meta name="google-signin-client_id" content="548740743413-4o51iohu918i0ukg4s9tcqpdrr3bnroj.apps.googleusercontent.com"/>



    <!-- bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <!-- bootstrap core css -->
    <link rel="stylesheet" type="text/css" href="../resources/bootstrap/css/bootstrap.css" />


    <!-- fonts style -->
    <link href="https://fonts.googleapis.com/css?family=Poppins:400,600,700&display=swap" rel="stylesheet">

    <!-- font awesome style -->
    <link href="../resources/bootstrap/css/font-awesome.min.css" rel="stylesheet" />
    <!-- nice select -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" integrity="sha256-mLBIhmBvigTFWPSCtvdu6a76T+3Xyt+K571hupeFLg4=" crossorigin="anonymous" />
    <!-- slidck slider -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css" integrity="sha256-UK1EiopXIL+KVhfbFa8xrmAWPeBjMVdvYMYkTAEv/HI=" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css.map" integrity="undefined" crossorigin="anonymous" />
    <!-- Custom styles for this template -->
    <link href="../resources/bootstrap/css/style.css" rel="stylesheet" />
    <!-- responsive style -->
    <link href="../resources/bootstrap/css/responsive.css" rel="stylesheet" />

    <!-- Favicons -->
    <link rel="apple-touch-icon" sizes="180x180" href="../resources/bootstrap/assets/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="../resources/bootstrap/assets/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../resources/bootstrap/assets/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="../resources/bootstrap/assets/favicons/favicon.ico">
    <link rel="manifest" href="../resources/bootstrap/assets/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="../resources/bootstrap/assets/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">

    <!-- Favicons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.2.0/css/all.min.css" integrity="sha512-6c4nX2tn5KbzeBJo9Ywpa0Gkt+mzCzJBrE1RB6fmpcsoN+b/w/euwIMuQKNyUoU/nToKN3a8SgNOtPrbW12fug==" crossorigin="anonymous" />

    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css"/>

    <style>
        .nav-user{
            width: 0;
            margin-right: 100px;
        }
        .navbar.navbar-expand-md{
            background-color: #fff;
            box-shadow: 2px 2px 2px #f17228;
            padding-left: 100px;
        }

        .btn.btn-default{
            color: #fff;
            background-color: #ffe537;
            margin-left: 10px;
            padding: 10px 15px 10px 15px;
        }
        .btn.btn-default:hover{
            color: #ffe537;
            background-color: #ffffff;
            border-color: #ffe537;
            border-width: 2px;
        }

        .btn.btn-default.login{
            width:500px;
            margin-left: 0;
            background-color: #ffba49;
        }

        .btn.btn-default.login:hover{
            width:500px;
            margin-left: 0;
            background-color: #f17228;
            color: #ffe537;
            border: 0;
        }

       .navbar-toggler{
           color: #fff;
           background-color: #ffe537;
       }

       .navbar-toggler-icon{
           color: #fff;
       }

        .fas.fa-user-alt{
           margin-right: 8px;
           color: #ffffff;
       }

       .fas{
           margin-right: 8px;
           color: #ffba49;
       }
        .far{
            margin-right: 8px;
            color: #ffba49;
        }
        .nav-link{
            color: #110000;
        }

        .dropdown-item.user-menu:hover{
            background-color: #ecf0fd;
        }
/*        li.form-inline.my-2.my-lg-0.show > ul:before{
            content: "";
            border-bottom: 10px solid #fff;
            border-right: 10px solid transparent;
            border-left: 10px solid transparent;
            position: absolute;
            top: -10px;
            right: 16px;
            z-index: 10;
        }*/

        .btn-social-login {
            transition: all .2s;
            outline: 0;
            border: 1px solid transparent;
            padding: .5rem !important;
            border-radius: 50%;
            color: #fff;
        }
        .btn-social-login:focus {
            box-shadow: 0 0 0 .2rem rgba(0,123,255,.25);
        }
        .text-dark { color: #343a40!important; }

    </style>

    <script type="text/javascript">

        /*카카오 로그인*/
        $(function () {

            Kakao.init('b729adcc43707d7099ee5f895c968b62');
            var id = "";

            $("#kakaoLogin").on("click", function () {

                alert("카카오로그인");
                console.log("카카오 로그인");

                Kakao.Auth.login({
                    success: function (authObj) { //성공시
                        console.log("카카오 token :: "+Kakao.Auth.getAccessToken());

                        Kakao.API.request({ //로그인 성공시
                            url: '/v2/user/me',
                            success: function (response) {
                                const id = response.kakao_account.email;
                                console.log(id);

                                $.ajax({
                                   url : "/user/json/checkDuplication/"+id,
                                   method : "GET",
                                    headers : {
                                        "Accept" : "application/json",
                                        "Content-Type" : "application/json"
                                    },
                                    success : function (data) {
                                       console.log("중복체크 성공 :: "+data);

                                       if( data === id ){
                                           console.log("--------------------------");
                                           console.log("여기 오니?");
                                           console.log("카카오로그인 data :: "+data);
                                           console.log("카카오로그인 id :: "+id);

                                           $.ajax({
                                              url : "/user/json/addUser",
                                              method : "POST",
                                               headers : {
                                                   "Accept" : "application/json",
                                                   "Content-Type" : "application/json"
                                               },
                                               data : JSON.stringify({
                                                   userId : id,
                                                   userName : response.properties.nickname,
                                                   userPassword : "1234kakao",
                                                   userRegDate : "2021-02-02",
                                                   userPhone : "010-0000-0000"
                                               }),
                                               success: function (JSONData){
                                                  alert("가입 완료");
                                                  $("form").attr("method","POST").attr("action","/user/kakaoLogin/"+id).attr("target","_parent").submit();
                                               }
                                           });
                                       }
                                       if( data !== id ){
                                           console.log("로그인ing...");
                                           $("form").attr("method","post").attr("action","/user/kakaoLogin/"+id).attr("target","_parent").submit();
                                       }
                                    },
                                    fail: function (error){
                                       console.log("중복체크 실패 :: "+error);
                                    }
                                });
                            },
                            fail: function (error) {
                                console.log(error);
                            },
                        });
                    },
                    fail: function (error){
                        console.log(error);
                    }
                });
            });
        });

        /* 구글 로그인 */
/*        $(function () {

            $(".g-signin2").click(function () {
                alert("구글 로그인");

                gapi.client.load('plus', 'v1', function () {
                    gapi.client.plus.people.get({
                        'userId': 'me'
                    }).execute(function (res) {

                        console.log("reponse data :: "+JSON.stringify(res));

                        //res.id += "@g";
                    })
                });
            })
        });*/



        /*로그인 Modal*/
        function loginModal(){
            $('#openLoginModal').modal('show');
        }

        /*로그인*/
        $(function () {

            $("#modalLoginBtn").click(function () {

                console.log("user")

                var userIdModal = $("#userIdModal").val();
                var userPasswordModal = $("#userPasswordModal").val();

                console.log(userIdModal);
                console.log(userPasswordModal);

                $.ajax({
                    type: "POST",
                    url: "/user/json/login/"+userIdModal,
                    data: {userId : userIdModal,
                        userPassword : userPasswordModal},
                    success: function (data) {
                        /*javascript redirect 방법*/
                        location.replace("http://localhost:8080/views/homeTest.jsp");
                    }
                });
            });

            $("#roleTab a[href='#CEO']").click(function (){
                /*alert("나와라 CEO");*/

                $("#modalLoginBtn").click(function () {

                    console.log("truck")

                    var truckId=$("#truckId").val();
                    var truckPassword=$("#truckPassword").val();

                    console.log(truckId);
                    console.log(truckPassword);

                    $.ajax({
                        type   : "POST",
                        url    : "/truck/json/login/" + truckId,
                        data   : {truckId, truckPassword},
                        success: function (data) {
                            alert(truckId+" 사장님 환영합니다.");
                            /*javascript redirect 방법*/
                            location.replace("http://localhost:8080/views/homeTest.jsp");
                        }
                    })
                });
            });
        });

        //왜때문에 경로에 user가 자꾸 붙는지...ㅠ
        $( function() {
            $(".navbar-brand").on("click" , function() {
                alert(1234);
                location.replace("http://localhost:8080/views/homeTest.jsp");
            });
        });


        // 혜지 추가
        // ============= 쪽지 ===============
        $( function() {
            $("#goMsg").on("click" , function() {
                self.location = "/msg/message_list"
            });
        });
        // ============= 채팅 ===============
        $( function() {
            $("#goChat").on("click" , function() {
                self.location = "/room"
            });
        });
        // ============= 케이터링 ===============
        $( function() {
            $("#goCatering").on("click" , function() {
                self.location = "/catering/mainCalendar"
            });
        });

        // 진석 추가
        // ============= 게시판 ===============
        $( function() {
            $("#goPost").on("click" , function() {
                self.location = "/community/getPostList"
            });
        });

        /* userId 찾기 */
        $(function () {
           $(".findUserId").click(function () {

               alert("id찾으러가자");

               $('#openLoginModal').modal('hide');
               $('#findUserModal').modal('show');

           });
        });


    </script>





</head>

<body id="page-top">
    <!-- header section strats -->

    <header class="header">
        <%-- 로그인 X --%>
        <c:if test="${ user.userId == null && truck.truckId == null }">
            <div class="container-fluid">
                <nav class="navbar navbar-expand-md fixed-top">
                    <!-- navbar-brand의 content 변경 -->
                        <%--<a class="navbar-brand" href="#">F.Fin</a>--%>
                    <div class="logo">
                        <a class="navbar-brand" href="">
                            <img class="d-inline-block" src="../resources/bootstrap/assets/logo.svg" alt="logo" />
                            <span style="color: #ffba49; ">F.FIN</span>
                        </a>
                    </div>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent" style="margin-left: 20px">
                        <ul class="navbar-nav mr-auto">
                        </ul>
                    </div>
                    <div class="collapse navbar-collapse justify-content-end nav-user" id="navbarSupportedContent" >
                        <ul class="navbar-nav">
                            <form class="form-inline my-2 my-lg-0">
                                    <%--<input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" />
                                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>--%>
                                <button type="button" class="btn btn-default" onclick="loginModal()"><i class="fas fa-user-alt"></i>Login</button>

                            </form>
                        </ul>
                    </div>
                </nav>
            </div>
        </c:if>
        <%-- 로그인 O --%>
        <c:if test="${ (user.userId != null && sessionScope.role == 'user') || (truck.truckId != null && sessionScope.role == 'truck') }">
        <div class="container-fluid">
            <nav class="navbar navbar-expand-md fixed-top">
                <!-- navbar-brand의 content 변경 -->
                <%--<a class="navbar-brand" href="#">F.Fin</a>--%>
                <div class="logo">
                    <a class="navbar-brand" href="homeTest.jsp">
                        <img class="d-inline-block" src="../resources/bootstrap/assets/logo.svg" alt="logo" />
                        <span style="color: #ffba49; ">F.FIN</span>
                    </a>
                </div>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent" style="margin-left: 20px">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item">
                            <a class="nav-link" id="goTruck" href="#"><i class="fas fa-truck"></i>푸드트럭</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="goCatering" href="#"><i class="far fa-calendar-alt"></i>케이터링</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="goPost" href="#"><i class="fas fa-globe"></i>게시판</a>
                        </li>
                        <c:if test="${user.userId != null && sessionScope.role == 'user'}">
                        <li class="nav-item">
                            <a class="nav-link" id="goChat" href="#"><i class="fas fa-comments"></i>채팅방</a>
                        </li>
                        </c:if>
                    </ul>
                </div>
                <div class="collapse navbar-collapse justify-content-end nav-user" id="navbarSupportedContent" >
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" id="goMsg" href="#" style="margin-top: 3px;"><i class="fas fa-envelope fa-lg" ></i></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" style="margin-top: 3px;"><i class="fas fa-shopping-cart fa-lg"></i></a>
                        </li>
                        <li class="form-inline my-2 my-lg-0" style="position: relative;">
                            <%--<input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" />
                            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>--%>
                            <c:if test="${user.userId != null && sessionScope.role == 'user'}">
                                <button type="button" class="btn btn-default dropdown-toggle" id="user-dropdown" data-toggle="dropdown"  aria-expanded="false">
                                    <i class="fas fa-user-alt"></i>${user.userId}
                                </button>
                                <ul class="dropdown-menu" aria-labelledby="user-dropdown">
                                    <li><a class="dropdown-item user-menu" href="./user/userMyPage.jsp"><i class="fas fa-user-circle"></i>MyPage</a></li>
                                    <li><a class="dropdown-item user-menu" href="#"><i class="fas fa-question-circle"></i>문의</a></li>
                                    <li><a class="dropdown-item user-menu" href="user/logout"><i class="fas fa-sign-out-alt"></i>로그아웃</a></li>
                                </ul>
                            </c:if>
                            <c:if test="${truck.truckId != null && sessionScope.role == 'truck' }">
                                <button type="button" class="btn btn-default dropdown-toggle" id="truck-dropdown" data-toggle="dropdown"  aria-expanded="false">
                                    <i class="fas fa-user-alt"></i>${truck.truckId}
                                </button>
                                <ul class="dropdown-menu" aria-labelledby="user-dropdown">
                                    <li><a class="dropdown-item user-menu" href="#"><i class="fas fa-user-circle"></i>MyPage</a></li>
                                    <li><a class="dropdown-item user-menu" href="#"><i class="fas fa-power-off"></i>장사모드?</a></li>
                                    <li><a class="dropdown-item user-menu" href="#"><i class="fas fa-question-circle"></i>문의</a></li>
                                    <li><a class="dropdown-item user-menu" href="/truck/logoutTruck"><i class="fas fa-sign-out-alt"></i>로그아웃</a></li>
                                </ul>
                            </c:if>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
        </c:if>
    </header>
    <!-- end header section -->

    <!-- Modal -->
    <div class="modal fade" id="openLoginModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalCenterTitle">Login</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <ul class="nav nav-pills nav-fill" id="roleTab">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#user" style="margin-left: 0;">User</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#CEO">CEO</a>
                        </li>
                    </ul>
                    <form id = "modalForm" name="modalFormmodalFormmodalForm">
                        <div class="tab-content">
                            <div class="tab-pane fade show active" id="user">
                                <div class="mb-3">
                                    <label for="userIdModal" class="form-label" style="margin-top: 12px;">ID</label>
                                    <input type="text" class="form-control" id="userIdModal" >
                                    <%--<div id="userIdInfo" class="form-text">User!</div>--%>
                                </div>
                                <div class="mb-3">
                                    <label for="userPasswordModal" class="form-label">Password</label>
                                    <input type="password" class="form-control" id="userPasswordModal">
                                </div>
                                <div class="mb-3 form-check">
                                    <input type="checkbox" class="form-check-input" id="autoLoginUser">
                                    <label class="form-check-label" for="autoLoginUser">자동로그인</label>
                                    <a class="findUserId" href="" style="color: #ffba49; margin-left: 5px; font-size: 14px;"> <strong style="float: right; stroke: #ffba49; margin-right: 5px; margin-top: 2px;">ID/PW 찾기</strong></a>
                                </div>
                                <div class="mb-3">
                                    <span style="color: #0b1727; margin-left: 5px; font-size: 14px">아직 회원이 아니신가요?</span>
                                    <a class="addChk" href="./user/addUserInfo.jsp" style="color: #ffba49; margin-left: 0; font-size: 14px;"> <strong style="float: right; stroke: #ffba49; margin-right: 5px;">회원가입</strong></a>
                                </div>
                            </div>
                            <%-- CEO modal --%>
                            <div class="tab-pane fade" id="CEO">
                                <div class="mb-3">
                                    <label for="truckId" class="form-label">ID</label>
                                    <input type="text" class="form-control" id="truckId">
                                    <%--<div id="truckIdInfo" class="form-text">CEO!</div>--%>
                                </div>
                                <div class="mb-3">
                                    <label for="truckPassword" class="form-label">Password</label>
                                    <input type="password" class="form-control" id="truckPassword">
                                </div>
                                <div class="mb-3 form-check">
                                    <input type="checkbox" class="form-check-input" id="autoLoginTruck">
                                    <label class="form-check-label" for="autoLoginTruck">자동로그인</label>
                                    <a class="findId" href="/views/truck/findTruckId.jsp" style="color: #ffba49; margin-left: 5px; font-size: 14px;">
                                        <strong style="float: right; stroke: #ffba49; margin-right: 5px; margin-top: 2px;">ID/PW 찾기</strong>
                                    </a>
                                </div>
                                <div class="mb-3">
                                    <span style="color: #0b1727; margin-left: 5px; font-size: 14px">아직 회원이 아니신가요?</span>
                                    <a class="addChk" href="./truck/addTruckView.jsp" style="color: #ffba49; margin-left: 0; font-size: 14px;"> <strong style="float: right; stroke: #ffba49; margin-right: 5px;">사업자 회원가입</strong></a>
                                </div>
                            </div>
                        </div>

                        <div class="d-grid gap-2 mx-auto modal-footer" style="padding-bottom: 5px;">
                            <button type="submit" class="btn btn-default login" id="modalLoginBtn" style="color: #ffffff; margin-bottom: 10px;">login</button>
                        </div>
                        <div class="d-grid gap-10 mx-auto" style="margin-bottom: 5px; padding: 0 15px; text-align: center;">
                            <input type="hidden" name="kakaoEmail" id="kakaoEmail">
                            <input type="hidden" name="kakaoName" id="kakaoName">
                            <a id="kakaoLogin">
                                <img src="../resources/image/kakao_login_medium_wide.png">
                            </a>
<%--
                            <button class='btn-social-login google' style='background:#D93025'><i class="xi-3x xi-google"></i></button>
                            <button class='btn-social-login kakao' style='background:#FFEB00'><i class="xi-3x xi-kakaotalk text-dark"></i></button>
--%>
                            <a class="g-signin2" >Google Login</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%-- 아이디 / 비밀번호 찾기 Modal --%>
    <div class="modal fade" id="findUserModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="findUserModalTitle">ID/PW 찾기</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <ul class="nav nav-pills nav-fill" id="id-pw-tab">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#user" style="margin-left: 0;">ID</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#CEO">PW</a>
                        </li>
                    </ul>
                    <form id = "fineUsermodalForm" name="fineUsermodalForm">
                        <div class="tab-content">
                            <%-- ID modal --%>
                            <div class="tab-pane fade show active" id="findId">
                                <div class="mb-3">
                                    <label for="userIdforId" class="form-label" style="margin-top: 12px;">이름</label>
                                    <input type="text" class="form-control" id="userIdforId" >
                                </div>
                                <div class="mb-3">
                                    <label for="userPhoneForId" class="form-label">연락처</label>
                                    <input type="text" class="form-control" id="userPhoneForId">
                                </div>
                            </div>
                            <%-- PW modal --%>
                            <div class="tab-pane fade" id="findPw">
                                <div class="mb-3">
                                    <label for="userNameforPw" class="form-label">이름</label>
                                    <input type="text" class="form-control" id="userNameforPw">
                                </div>
                                <div class="mb-3">
                                    <label for="userIdforPw" class="form-label">Id</label>
                                    <input type="text" class="form-control" id="userIdforPw">
                                </div>
                                <div class="mb-3">
                                    <label for="userPhoneforPw" class="form-label">연락처</label>
                                    <input type="text" class="form-control" id="userPhoneforPw">
                                </div>
                            </div>
                        </div>

                        <div class="d-grid gap-2 mx-auto modal-footer" style="padding-bottom: 5px;">
                            <button type="submit" class="btn btn-default login" id="modalFindBtn" style="color: #ffffff; margin-bottom: 10px;">찾아보아요</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</body>

</html>