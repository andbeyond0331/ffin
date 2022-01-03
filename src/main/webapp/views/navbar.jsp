<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">

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

    <!-- jQery -->
    <script src="../resources/bootstrap/js/jquery-3.4.1.min.js"></script>
    <!-- bootstrap js -->
    <script src="../resources/bootstrap/js/bootstrap.js"></script>
    <!-- slick  slider -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.js"></script>
    <!-- nice select -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js" integrity="sha256-Zr3vByTlMGQhvMfgkQ5BtWRSKBGa2QlspKYJnkjZTmo=" crossorigin="anonymous"></script>
    <!-- custom js -->
    <script src="../resources/bootstrap/js/custom.js"></script>


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

    <style>
        .nav-user{
            width: 0;
        }
        .navbar.navbar-expand-md{
            background-color: #fff;
            box-shadow: 2px 2px 2px #f17228;
            padding-left: 100px;
        }

        button.btn{
            color: #fff;
            background-color: #ffe537;
            margin-left: 10px;
            padding: 10px 15px 10px 15px;
        }
        button.btn:hover{
            color: #ffe537;
            background-color: #ffffff;
            border-color: #ffe537;
            border-width: 2px;
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
    </style>

    <script type="text/javascript">

        /*로그인 Modal*/
        function loginModal(){
           alert(1234);
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
                        </ul>
                    </div>
                    <div class="collapse navbar-collapse nav-user" id="navbarSupportedContent" >
                        <ul class="navbar-nav mr-auto">
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
        <c:if test="${ user.userId != null || truck.truckId != null }">
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
                        <c:if test="${user.userId != null}">
                        <li class="nav-item">
                            <a class="nav-link" id="goChat" href="#"><i class="fas fa-comments"></i>채팅방</a>
                        </li>
                        </c:if>
                    </ul>
                </div>
                <div class="collapse navbar-collapse nav-user" id="navbarSupportedContent" >
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item">
                            <a class="nav-link" id="goMsg" href="#" style="margin-top: 3px;"><i class="fas fa-envelope fa-lg" ></i></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" style="margin-top: 3px;"><i class="fas fa-shopping-cart fa-lg"></i></a>
                        </li>
                        <form class="form-inline my-2 my-lg-0">
                            <%--<input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" />
                            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>--%>
                            <c:if test="${user.userId != null}">
                                <button type="button" class="btn btn-default">
                                    <i class="fas fa-user-alt"></i>${user.userId}
                                </button>
                            </c:if>
                                <c:if test="${truck.truckId != null}">
                                    <button type="button" class="btn btn-default">
                                        <i class="fas fa-user-alt"></i>${truck.truckId}
                                    </button>
                                </c:if>
                        </form>
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
                    <form id = "modalForm" name="modalForm">
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
                                    <a class="findId" href="" style="color: #ffba49; margin-left: 5px; font-size: 14px;"> <strong style="float: right; stroke: #ffba49; margin-right: 5px; margin-top: 2px;">ID/PW 찾기</strong></a>
                                </div>
                                <div class="mb-3">
                                    <span style="color: #0b1727; margin-left: 5px; font-size: 14px">아직 회원이 아니신가요?</span>
                                    <a class="addChk" href="./user/addUserInfo.jsp" style="color: #ffba49; margin-left: 0; font-size: 14px;"> <strong style="float: right; stroke: #ffba49; margin-right: 5px;">회원가입</strong></a>
                                </div>
                            </div>
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
                                </div>
                                <div class="mb-3">
                                    <span style="color: #0b1727; margin-left: 5px; font-size: 14px">아직 회원이 아니신가요?</span>
                                    <a class="addChk" href="./truck/addTruckView.jsp" style="color: #ffba49; margin-left: 0; font-size: 14px;"> <strong style="float: right; stroke: #ffba49; margin-right: 5px;">사업자 회원가입</strong></a>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-warning btn-lg btn-block" id="modalLoginBtn" style="color: #ffffff">login</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>

</html>