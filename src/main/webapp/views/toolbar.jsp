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

    <!--    Favicons-->
    <link rel="apple-touch-icon" sizes="180x180" href="../resources/bootstrap/assets/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="../resources/bootstrap/assets/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../resources/bootstrap/assets/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="../resources/bootstrap/assets/favicons/favicon.ico">
    <link rel="manifest" href="../resources/bootstrap/assets/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="../resources/bootstrap/assets/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">


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

    <script type="text/javascript">

        function loginModal(){
            $('#openLoginModal').modal('show');
        }

        $(function () {

               $("#modalLoginBtn").click(function () {

                   console.log("user")

                   var userId = $("#userId").val();
                   var userPassword = $("#userPassword").val();

                   console.log(userId);
                   console.log(userPassword);

                   $.ajax({
                       type: "POST",
                       url: "/user/json/login/" + userId,
                       data: {userId, userPassword},
                       success: function (data) {
                           self.location = "redirect : ./views/home.jsp"
                       }
                   });
           });

            $("#roleTab a[href='#CEO']").click(function (){
                alert("나와라 CEO");

                $("#modalLoginBtn").click(function () {

                    console.log("truck")

                    var truckId=$("#truckId").val();
                    var truckPassword=$("#truckPassword").val();

                    console.log(truckId);
                    console.log(truckPassword);

                });
            });
        });



/*
        $(function () {
            $("#modalLoginBtn").click(function () {

                console.log("login button");

                var userId=$("input:text").val();
                var userPassword=$("input:password").val();
                $.ajax({
                    type:"POST",
                    url:"/user/json/login/"+userId,
                    data:{userId, userPassword},
                    success:function (data) {
                        self.location = "redirect:/views/home.jsp"
                    }
                });
            });
        });
*/


    </script>
    <!-- javascript -->





</head>

<body id="page-top">

<div class="hero_area">

    <!-- header section strats -->
    <header class="header_section">
        <div class="container-fluid" >
            <nav class="navbar navbar-expand-lg custom_nav-container">
                <a class="navbar-brand" href="homeTest.jsp">
                    <img class="d-inline-block" src="../resources/bootstrap/assets/logo.svg" alt="logo" />
                    <span>F.FIN</span>
                </a>
                <div class="" id="">
                    <div class="User_option">
                        <a href="#login">
                            <i class="fa fa-user" aria-hidden="true"></i>
                            <span data-toggle="modal" data-target=".bd-example-modal-lg" id="loginModal"  onclick=loginModal()>Login</span>
                        </a>
                        ${user.userId}
                        ${truck.truckId}
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
                                                <a class="nav-link active" data-toggle="tab" href="#user">User</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" data-toggle="tab" href="#CEO">CEO</a>
                                            </li>
                                        </ul>
                                        <form id = "modalForm" name="modalForm">
                                            <div class="tab-content">
                                                <div class="tab-pane fade show active" id="user">
                                                    <div class="mb-3">
                                                        <label for="userId" class="form-label">ID</label>
                                                        <input type="text" class="form-control" id="userId" >
                                                        <%--<div id="userIdInfo" class="form-text">User!</div>--%>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="userPassword" class="form-label">Password</label>
                                                        <input type="password" class="form-control" id="userPassword">
                                                    </div>
                                                    <div class="mb-3 form-check">
                                                        <input type="checkbox" class="form-check-input" id="autoLoginUser">
                                                        <label class="form-check-label" for="autoLoginUser">자동로그인</label>
                                                    </div>
                                                    <div class="mb-3">
                                                        <span style="color: #0b1727; margin-left: 0;">아직 회원이 아니신가요?</span>
                                                        <a class="addChk" href="./user/addUser.jsp" style="color: #0b1727; margin-left: 0;"> <strong style="float: right; stroke: #000000">회원가입</strong></a>
                                                    </div>
                                                </div>
                                                <div class="tab-pane fade" id="CEO">
                                                    <div class="mb-3">
                                                        <label for="truckId" class="form-label">ID</label>
                                                        <input type="text" class="form-control" id="truckId">
                                                        <div id="truckIdInfo" class="form-text">CEO!</div>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="truckPassword" class="form-label">Password</label>
                                                        <input type="password" class="form-control" id="truckPassword">
                                                    </div>
                                                    <div class="mb-3 form-check">
                                                        <input type="checkbox" class="form-check-input" id="autoLoginTruck">
                                                        <label class="form-check-label" for="autoLoginTruck">자동로그인</label>
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
                        <form class="form-inline ">
                            <input type="search" placeholder="Search" />
                            <button class="btn  nav_search-btn" type="submit">
                                <i class="fa fa-search" aria-hidden="true"></i>
                            </button>
                        </form>
                    </div>
                    <div class="custom_menu-btn">
                        <button onclick="openNav()">
                            <img src="../resources/bootstrap/images/menu.png" alt="">
                        </button>
                    </div>
                    <span class="glyphicon glyphicon-menu-hamburger" aria-hidden="true" onclick="openNav()"></span>
                    <div id="myNav" class="overlay">
                        <div class="overlay-content">
                            <a href="homeTest.jsp">Home</a>
                            <a href="about.html">About</a>
                            <a href="blog.html">Blog</a>
                            <a href="testimonial.html">Testimonial</a>
                        </div>
                    </div>
                </div>
            </nav>
        </div>
    </header>

</div>


</body>

</html>