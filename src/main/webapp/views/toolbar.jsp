<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">

<head>

    <!-- Basic -->
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <!-- Mobile Metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <!-- Site Metas -->
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>

    <title>F.FIN | FOODTRUCK FINDER</title>

    <!-- jQery -->
    <script src="../resources/bootstrap/js/jquery-3.4.1.min.js"></script>
    <!-- bootstrap js -->
    <script src="../resources/bootstrap/js/bootstrap.js"></script>
    <!-- slick  slider -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.js"></script>
    <!-- nice select -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"
            integrity="sha256-Zr3vByTlMGQhvMfgkQ5BtWRSKBGa2QlspKYJnkjZTmo=" crossorigin="anonymous"></script>
    <!-- custom js -->
    <script src="../resources/bootstrap/js/custom.js"></script>


    <!-- bootstrap core css -->
    <link rel="stylesheet" type="text/css" href="../resources/bootstrap/css/bootstrap.css"/>

    <!-- fonts style -->
    <link href="https://fonts.googleapis.com/css?family=Poppins:400,600,700&display=swap" rel="stylesheet">

    <!-- font awesome style -->
    <link href="../resources/bootstrap/css/font-awesome.min.css" rel="stylesheet"/>
    <!-- nice select -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css"
          integrity="sha256-mLBIhmBvigTFWPSCtvdu6a76T+3Xyt+K571hupeFLg4=" crossorigin="anonymous"/>
    <!-- slidck slider -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css"
          integrity="sha256-UK1EiopXIL+KVhfbFa8xrmAWPeBjMVdvYMYkTAEv/HI=" crossorigin="anonymous"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css.map"
          integrity="undefined" crossorigin="anonymous"/>

    <!-- Custom styles for this template -->
    <link href="../resources/bootstrap/css/style.css" rel="stylesheet"/>
    <!-- responsive style -->
    <link href="../resources/bootstrap/css/responsive.css" rel="stylesheet"/>

    <!-- Favicons -->
    <link rel="apple-touch-icon" sizes="180x180" href="../resources/bootstrap/assets/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="../resources/bootstrap/assets/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../resources/bootstrap/assets/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="../resources/bootstrap/assets/favicons/favicon.ico">
    <link rel="manifest" href="../resources/bootstrap/assets/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="../resources/bootstrap/assets/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">

    <!-- Favicons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.2.0/css/all.min.css"
          integrity="sha512-6c4nX2tn5KbzeBJo9Ywpa0Gkt+mzCzJBrE1RB6fmpcsoN+b/w/euwIMuQKNyUoU/nToKN3a8SgNOtPrbW12fug=="
          crossorigin="anonymous"/>


    <script type="text/javascript">

        function loginModal() {
            $('#openLoginModal').modal('show');
        }

        $(function () {

            $("#modalLoginBtn").click(function () {

                console.log("user")

                var userIdModal = $("#userIdModal").val();
                var userPasswordModal = $("#userPasswordModal").val();

                console.log(userIdModal);
                console.log(userPasswordModal);

                $.ajax({
                    type: "POST",
                    url: "/user/json/login/" + userIdModal,
                    data: {
                        userId: userIdModal,
                        userPassword: userPasswordModal
                    },
                    success: function (data) {
                        /*javascript redirect 방법*/
                        location.replace("http://localhost:8080/views/homeTest.jsp");
                    }
                });
            });

            $("#roleTab a[href='#CEO']").click(function () {
                /*alert("나와라 CEO");*/

                $("#modalLoginBtn").click(function () {

                    console.log("truck")

                    var truckId = $("#truckId").val();
                    var truckPassword = $("#truckPassword").val();

                    console.log(truckId);
                    console.log(truckPassword);

                    $.ajax({
                        type: "POST",
                        url: "/truck/json/login/" + truckId,
                        data: {truckId, truckPassword},
                        success: function (data) {
                            alert(truckId + " 사장님 환영합니다.");
                            /*javascript redirect 방법*/
                            location.replace("http://localhost:8080/views/homeTest.jsp");
                        }
                    })
                });
            });
        });

        // 혜지 추가
        // ============= 쪽지 ===============
        $(function () {
            $("#goMsg").on("click", function () {
                self.location = "/msg/message_list"
            });
        });
        // ============= 채팅 ===============
        $(function () {
            $("#goChat").on("click", function () {
                self.location = "/room"
            });
        });
        // ============= 케이터링 ===============
        $(function () {
            $("#goCatering").on("click", function () {
                self.location = "/catering/mainCalendar"
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
        $(function () {
            $("button.btn.btn-primary:Contains('확인')").click(function () {
                var order = to_ajax()
                alert(order)
                append = "<input type=\"hidden\" id=\"orderNo\" name=\"orderNo\" value=\"" + order + "\">";
                $('#app').append(append);
                alert(append)
                self.location = "/purchase/addCart?orderNo=" + order
                /* $("form").attr("method" , "POST").attr("action" , "/purchase/addCart").submit();*/

            });
        });
        $(function () {
            $("button.btn.btn-primary:Contains('json')").click(function () {
                alert("ddk");
                to_ajax();
                $("form").attr("method", "POST").attr("action", "/purchase/addCart").submit();
            });
        });

        function to_ajax() {
            var reOrderNo;
            var odMenuName = [];
            var odOptionGroupName = [];
            var odOptionName = [];
            var odMenuQty = [];
            var odMenuPrice = [];
            var odOptionPrice = [];
            var odMenuImage = [];
            var orderPickUpTime = $('input[name="orderPickUpTime"]:checked').val();
            var orderTotalPrice = $('#orderTotalPrice').val();
            var orderUserId = $('#orderUserId').val();
            var orderTruckId = $('#orderTruckId').val();
            var orderRequest = $('#orderRequest').val();
            var orderQty = $('#orderQty').val();

            $('input[name="odMenuName"]').each(function (i) {
                odMenuName.push($(this).val());
            });

            $('input[name="odOptionGroupName"]').each(function (i) {
                odOptionGroupName.push($(this).val());
            });

            $('input[name="odOptionName"]').each(function (i) {
                odOptionName.push($(this).val());
            });

            $('input[name="odMenuQty"]').each(function (i) {
                odMenuQty.push($(this).val());
            });

            $('input[name="odMenuPrice"]').each(function (i) {
                odMenuPrice.push($(this).val());
            });

            $('input[name="odOptionPrice"]').each(function (i) {
                odOptionPrice.push($(this).val());
            });

            $('input[name="odMenuImage"]').each(function (i) {
                odMenuImage.push($(this).val());
            });
            alert(orderPickUpTime)
            alert(orderTotalPrice)
            alert(orderUserId)
            alert(orderTruckId)
            alert(orderRequest)
            alert(orderQty)

            var data = {
                "odMenuName": odMenuName,
                "odOptionGroupName": odOptionGroupName,
                "odOptionName": odOptionName,
                "odMenuQty": odMenuQty,
                "odMenuPrice": odMenuPrice,
                "odOptionPrice": odOptionPrice,
                "odMenuImage": odMenuImage,
                "orderPickUpTime": orderPickUpTime,
                "orderTotalPrice": orderTotalPrice,
                "orderUserId": orderUserId,
                "orderTruckId": orderTruckId,
                "orderRequest": orderRequest,
                "orderQty": orderQty,
            }
            $.ajax({
                type: "post",
                url: '/purchase/json/addCartList',
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                data: data,
                async: false,
                dataType: 'json',
                success: function (retVal) {
                    reOrderNo = retVal.orderNo;
                },
                error: function (xhr, status, error) {
                    alert("[Error]" + error);
                    return;
                }


            });
            return reOrderNo;
        }


    </script>
    <!-- javascript -->


</head>

<body id="page-top">
<form>

    <div class="hero_area">

        <!-- header section strats -->
        <header class="header_section">
            <div class="container-fluid">
                <nav class="navbar navbar-expand-lg custom_nav-container">
                    <div>
                        <div class="logo" style="float: left;">
                            <a class="navbar-brand" href="homeTest.jsp">
                                <img class="d-inline-block" src="../resources/bootstrap/assets/logo.svg" alt="logo"/>
                                <span>F.FIN</span>
                            </a>
                        </div>
                        <div class="menuTab">
                            <ul class="nav menu_tab">
                                <li class="nav-item">
                                    <a class="nav-link" aria-current="page" id="goTruck">푸드트럭</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" aria-current="page" id="goCatering">케이터링</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" aria-current="page" id="goPost">게시판</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" aria-current="page" id="goChat">채팅방</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" aria-current="page" id="goMsg">쪽지</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="user_option_wrap" id="">
                        <c:choose>
                            <c:when test="${ user.userId == null && truck.truckId == null}">
                                <%-- 로그인 전 --%>
                                <div class="User_option">
                                    <a href="#login">
                                        <i class="fa fa-user" aria-hidden="true"></i>
                                        <span data-toggle="modal" data-target=".bd-example-modal-lg" id="loginModal"
                                              onclick=loginModal()>Login</span>
                                    </a>
                                    <!-- Modal -->
                                    <div class="modal fade" id="openLoginModal" tabindex="-1" role="dialog"
                                         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered" role="document">
                                            <!-- Modal content-->
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="exampleModalCenterTitle">Login</h5>
                                                    <button type="button" class="close" data-dismiss="modal"
                                                            aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <ul class="nav nav-pills nav-fill" id="roleTab">
                                                        <li class="nav-item">
                                                            <a class="nav-link active" data-toggle="tab" href="#user"
                                                               style="margin-left: 0;">User</a>
                                                        </li>
                                                        <li class="nav-item">
                                                            <a class="nav-link" data-toggle="tab" href="#CEO">CEO</a>
                                                        </li>
                                                    </ul>
                                                    <form id="modalForm" name="modalForm">
                                                        <div class="tab-content">
                                                            <div class="tab-pane fade show active" id="user">
                                                                <div class="mb-3">
                                                                    <label for="userIdModal" class="form-label"
                                                                           style="margin-top: 12px;">ID</label>
                                                                    <input type="text" class="form-control"
                                                                           id="userIdModal">
                                                                        <%--<div id="userIdInfo" class="form-text">User!</div>--%>
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label for="userPasswordModal" class="form-label">Password</label>
                                                                    <input type="password" class="form-control"
                                                                           id="userPasswordModal">
                                                                </div>
                                                                <div class="mb-3 form-check">
                                                                    <input type="checkbox" class="form-check-input"
                                                                           id="autoLoginUser">
                                                                    <label class="form-check-label" for="autoLoginUser">자동로그인</label>
                                                                    <a class="findId" href=""
                                                                       style="color: #ffba49; margin-left: 5px; font-size: 14px;">
                                                                        <strong style="float: right; stroke: #ffba49; margin-right: 5px; margin-top: 2px;">ID/PW
                                                                            찾기</strong></a>
                                                                </div>
                                                                <div class="mb-3">
                                                                    <span style="color: #0b1727; margin-left: 5px; font-size: 14px">아직 회원이 아니신가요?</span>
                                                                    <a class="addChk" href="./user/addUserInfo.jsp"
                                                                       style="color: #ffba49; margin-left: 0; font-size: 14px;">
                                                                        <strong style="float: right; stroke: #ffba49; margin-right: 5px;">회원가입</strong></a>
                                                                </div>
                                                            </div>
                                                            <div class="tab-pane fade" id="CEO">
                                                                <div class="mb-3">
                                                                    <label for="truckId" class="form-label">ID</label>
                                                                    <input type="text" class="form-control"
                                                                           id="truckId">
                                                                        <%--<div id="truckIdInfo" class="form-text">CEO!</div>--%>
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label for="truckPassword" class="form-label">Password</label>
                                                                    <input type="password" class="form-control"
                                                                           id="truckPassword">
                                                                </div>
                                                                <div class="mb-3 form-check">
                                                                    <input type="checkbox" class="form-check-input"
                                                                           id="autoLoginTruck">
                                                                    <label class="form-check-label"
                                                                           for="autoLoginTruck">자동로그인</label>
                                                                </div>
                                                                <div class="mb-3">
                                                                    <span style="color: #0b1727; margin-left: 5px; font-size: 14px">아직 회원이 아니신가요?</span>
                                                                    <a class="addChk" href="./truck/addTruckView.jsp"
                                                                       style="color: #ffba49; margin-left: 0; font-size: 14px;">
                                                                        <strong style="float: right; stroke: #ffba49; margin-right: 5px;">사업자
                                                                            회원가입</strong></a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="submit"
                                                                    class="btn btn-warning btn-lg btn-block"
                                                                    id="modalLoginBtn" style="color: #ffffff">login
                                                            </button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <form class="form-inline ">
                                        <input type="search" placeholder="Search"/>
                                        <button class="btn  nav_search-btn" type="submit">
                                            <i class="fa fa-search" aria-hidden="true"></i>
                                        </button>
                                    </form>
                                </div>
                            </c:when>
                            <%-- 로그인 전 End --%>

                            <%-- user 로그인 --%>
                            <c:when test="${user.userId != null && truck.turckId == null}">
                                <div class="User_option">
                                        <%--                                <a href="#userLoginOK">
                                                                            <i class="fa fa-user" aria-hidden="true"></i>
                                                                            <span data-toggle="modal" data-target=".bd-example-modal-lg" onclick=userModal()>${user.userId}</span>
                                                                        </a>--%>
                                        <%--<button type="button" class="btn btn-secondary" data-bs-toggle="tooltip" data-bs-placement="bottom" title="왜 안나와">
                                            ${user.userId}
                                        </button>--%>
                                    <div class="dropdown">
                                        <button class="btn btn-secondary btn-sm dropdown-toggle" type="button"
                                                id="dropdownMenu2" data-bs-toggle="dropdown" aria-expanded="false">
                                                ${user.userId}
                                        </button>
                                        <ul class="dropdown-menu" aria-labelledby="dropdownMenu2">
                                            <li>
                                                <button class="dropdown-item" type="button">Action</button>
                                            </li>
                                            <li>
                                                <button class="dropdown-item" type="button">Another action</button>
                                            </li>
                                            <li>
                                                <button class="dropdown-item" type="button">Something else here</button>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </c:when>
                            <%--truck 로그인--%>
                            <c:when test="${truck.truckId != null && user.userId == null}">
                                <div class="User_option">
                                    <a href="#truckLoginOK">
                                        <i class="fa fa-user" aria-hidden="true"></i>
                                        <span data-toggle="modal" data-target=".bd-example-modal-lg"
                                              onclick=truckModal()>${truck.truckId}</span>
                                    </a>
                                </div>
                            </c:when>
                        </c:choose>

                        <div class="custom_menu-btn">
                            <button class="push_bell">
                                <i class="far fa-bell fa-lg"></i>
                            </button>
                        </div>

                        <div class="custom_menu-btn">
                            <button class="btn btn-primary" type="button" data-bs-toggle="offcanvas"
                                    data-bs-target="#offcanvasScrolling" aria-controls="offcanvasScrolling">
                                <i class="fas fa-shopping-basket fa-lg" style="color: #ffffff;"></i>
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
            <div class="offcanvas offcanvas-end" data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1"
                 id="offcanvasScrolling" aria-labelledby="offcanvasScrollingLabel" style="margin-top: 80px">
                <div class="offcanvas-header" id="add">
                    <h5 class="offcanvas-title" id="offcanvasScrollingLabel">장바구니</h5>
                    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas"
                            aria-label="Close"></button>
                </div>
                <div class="offcanvas-body">
                    <div class="content">

                        <div id="order"></div>
                        <c:set var="i" value="0"/>
                        <c:forEach var="cart" items="${map.get('list')}">
                            <c:set var="i" value="${i+1}"/>





                            <input type="hidden" id="odMenuName" name="odMenuName" value="${cart.odMenuName}"/>
                            <input type="hidden" id="odOptionGroupName" name="odOptionGroupName"
                                   value="${cart.odOptionGroupName}"/>
                            <input type="hidden" id="odOptionName" name="odOptionName" value="${cart.odOptionName}"/>
                            <input type="hidden" id="odMenuQty" name="odMenuQty" value="${cart.odMenuQty}"/>
                            <input type="hidden" id="odMenuPrice" name="odMenuPrice" value="${cart.odMenuPrice}"/>
                            <input type="hidden" id="odOptionPrice" name="odOptionPrice" value="${cart.odOptionPrice}"/>
                            <input type="hidden" id="odMenuImage" name="odMenuImage" value="${cart.odMenuImage}"/>
                            <input type="hidden" id="odMenuQtyFlag" name="odMenuQtyFlag" value="${cart.odMenuQtyFlag}"/>


                        </c:forEach>

                        <div id="total"></div>
                        <div class="row">
                        <div class="col-6">
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                data-bs-target="#exampleModal">주문하기
                        </button></div>
                        <div class="col-2">

                        </div>
                        <div class="col-4">
                        <button type="button" class="btn btn-primary">삭제</button>
                    </div></div></div>
                </div>
            </div>
        </header>

    </div>


    <%--modal--%>
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">New message</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="orderPickUpTime" class="col-form-label">픽업희망시간:</label>
                        <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
                            <input type="radio" class="btn-check" id="orderPickUpTime" name="orderPickUpTime" value="5"
                                   id="btnradio1" autocomplete="off" checked>
                            <label class="btn btn-outline-primary" for="btnradio1">5분</label>

                            <input type="radio" class="btn-check" name="orderPickUpTime" value="10" id="btnradio2"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="btnradio2">10분</label>

                            <input type="radio" class="btn-check" name="orderPickUpTime" value="15" id="btnradio3"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="btnradio3">15분</label>

                            <input type="radio" class="btn-check" name="orderPickUpTime" value="20" id="btnradio4"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="btnradio4">20분</label>

                            <input type="radio" class="btn-check" name="orderPickUpTime" value="30" id="btnradio5"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="btnradio5">30분</label>

                            <input type="radio" class="btn-check" name="orderPickUpTime" value="40" id="btnradio6"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="btnradio6">40분</label>

                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="orderRequest" class="col-form-label">주문요청사항:</label>
                        <textarea class="form-control" id="orderRequest" name="orderRequest"
                                  value="${purchase.orderRequest}"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary">확인</button>


                    <input type="hidden" id="orderUserId" name="orderUserId.userId" value="user01"/>
                    <input type="hidden" id="orderTruckId" name="orderTruckId.truckId" value="truck01"/>
                    <input type="hidden" id="orderQty" name="orderQty" value="3"/>
                    <input type="hidden" id="orderTotalPrice" name="orderTotalPrice" value="3000"/>
                </div>
            </div>
        </div>
    </div>
</form>
<script>
    $(function () {
        var odMenuNameCount = $("input[name='odMenuName']").length;


        var odMenuNameL;
        var odOptionGroupNameL;
        var odOptionNameL;
        var odMenuQtyL;
        var odMenuPriceL;
        var odOptionPriceL;
        var odMenuImageL;
        var odMenuQtyFlagL;
        var menuList = [];

        for (var i = 0; i < odMenuNameCount; i++) {
            var odMenuName = $("input[name='odMenuName']").eq(i).val();
            var odOptionGroupName = $("input[name='odOptionGroupName']").eq(i).val();
            var odOptionName = $("input[name='odOptionName']").eq(i).val();
            var odMenuQty = $("input[name='odMenuQty']").eq(i).val();
            var odMenuPrice = $("input[name='odMenuPrice']").eq(i).val();
            var odOptionPrice = $("input[name='odOptionPrice']").eq(i).val();
            var odMenuImage = $("input[name='odMenuImage']").eq(i).val();
            var odMenuQtyFlag = $("input[name='odMenuQtyFlag']").eq(i).val();


            var odMenuImageCopy;
            var odMenuNameCopy;
            var odOptionGroupNameCopy;
            var odOptionNameCopy;
            var odMenuQtyCopy;
            var odMenuPriceCopy;
            var odOptionPriceCopy;
            var odMenuQtyFlagCopy;
            var test;
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

/*            let last_cart = test.substring(test.length-1,test.length);*/

            if(odOptionNameCopy == undefined){
                odOptionNameCopy = odOptionName;
                test2 = odMenuName;
                odOptionGroupNameCopy = odOptionGroupName;

                    odOptionPriceCopy = odOptionPrice;


            }else if(test2 != odMenuName &&  odOptionNameCopy.substring(odOptionNameCopy.length-1,odOptionNameCopy.length) != "/"){
                odOptionNameCopy = odOptionNameCopy +"/"+odOptionName;
                odOptionGroupNameCopy = odOptionGroupNameCopy +"/"+odOptionGroupName;
                odOptionPriceCopy = odOptionPriceCopy +"/"+odOptionPrice;

            }else if(odOptionNameCopy != undefined){

                odOptionNameCopy = odOptionNameCopy +","+odOptionName;
                test2 = odMenuName;
                odOptionGroupNameCopy = odOptionGroupNameCopy +","+odOptionGroupName;
                odOptionPriceCopy = odOptionPriceCopy+odOptionPrice;
            }

            odOptionNameL = odOptionNameCopy.split("/");
            odOptionGroupNameL = odOptionGroupNameCopy.split("/");
            odOptionPriceL = odOptionPriceCopy.split("/").map(Number);


/*            alert("total"+odMenuPriceL)
            alert("price"+odOptionPriceL)*/

            /*  if (odOptionGroupNameCopy == undefined || odOptionGroupNameCopy != odOptionGroupName) {
                  odOptionGroupNameCopy = odOptionGroupNameCopy+","+odOptionGroupName;
              }else{
                  odOptionGroupNameCopy = odOptionGroupName;
              }

              if (odOptionNameCopy == undefined || odOptionNameCopy != odOptionName) {
                  odOptionNameCopy = odOptionNameCopy+","+odOptionName;
              }else{
                  odOptionNameCopy = odOptionName;
              }

              if (odMenuQtyCopy == undefined || odMenuQtyCopy != odMenuQty) {
                  odMenuQtyCopy = odMenuQtyCopy+","+odMenuQty;
              }else{
                  odMenuQtyCopy = odMenuQty;
              }

              if (odMenuPriceCopy == undefined || odMenuPriceCopy != odMenuPrice) {
                  odMenuPriceCopy = odMenuPriceCopy+","+odMenuPrice;
              }else{
                  odMenuNameCopy = odMenuName;
              }

              if (odOptionPriceCopy == undefined || odOptionPriceCopy != odOptionPrice) {
                  odOptionPriceCopy = odOptionPriceCopy+","+odOptionPrice;
              }else{
                  odOptionPriceCopy = odOptionPrice;
              }

              if (odMenuImageCopy != undefined && odMenuImageCopy != odMenuImage) {
                      odMenuImageCopy = odMenuImageCopy+","+odMenuImage;
              } else{
                  odMenuImageCopy = odMenuImage;
              }

              if (odMenuQtyFlagCopy == undefined && odMenuQtyFlagCopy != odMenuQtyFlag) {
                  odMenuQtyFlagCopy = odMenuQtyFlagCopy+","+odMenuQtyFlag;
              }else{
                  odMenuQtyFlagCopy = odMenuQtyFlag;
              }*/


        }



        /*    var arr = new Array(10);
            for(var i=0; i<odMenuNameCount; i++){
                var odMenuName = $("input[name='odMenuName']").eq(i).val();
                var odOptionGroupName = $("input[name='odOptionGroupName']").eq(i).val();
                var odOptionName = $("input[name='odOptionName']").eq(i).val();
                var odMenuQty = $("input[name='odMenuQty']").eq(i).val();
                var odMenuPrice = $("input[name='odMenuPrice']").eq(i).val();
                var odOptionPrice = $("input[name='odOptionPrice']").eq(i).val();
                var odMenuImage = $("input[name='odMenuImage']").eq(i).val();
                var odMenuQtyFlag = $("input[name='odMenuQtyFlag']").eq(i).val();


            for(var j=0; j<odMenuNameL.length; j++){
              if(odMenuNameL[j] == odMenuName){
                     arr[j] = new Array();
                     arr[j][i]=(odMenuName);


                 /!* menuList[j] = push(odMenuName);*!/
              /!*    menuList[j].push(odOptionGroupName);*!/


              }

            }

            }
            for(var j=0; j<odMenuNameL.length; j++) {
                alert("12414" + arr[j])
            }*/
        /* odOptionGrouNameL = odOptionGroupNameCopy.split(",");
         odOptionNameL = odOptionNameCopy.split(",");
         odMenuQtyL = odMenuQtyCopy.split(",");
         odMenuPriceL = odMenuPriceCopy.split(",");
         odOptionPriceL = odOptionPriceCopy.split(",");
         odMenuImageL = odMenuImageCopy.split(",");
         odMenuQtyFlagL = odMenuQtyFlagCopy.split(",");

         alert("ddd"+odMenuNameL)
         for(var i=0; i<odMenuNameL.length; i++){

         }*/
        var menuPrice = 0;
        for (var i = 0; i < odMenuNameL.length; i++) {
/*
            alert(odMenuNameL[i]);
            alert(odOptionNameL[i]);*/

            menuPrice += (odOptionPriceL[i]+odMenuPriceL[i]);




            divElemApply1 =
                "<div class=\"form-check\">" +
                "<input class=\"form-check-input\" type=\"checkbox\" value=\"\" id=\"flexCheckChecked\" checked>" +
                "<label class=\"form-check-label\" for=\"flexCheckChecked\">" +
                "<div class=\"card mb-3\" style=\"max-width: 540px;\">" +
                " <div class=\"row g-0\">" +
                "<div class=\"col-md-4\">" +
                "<img src=\"/resources/image/1.jpg\" class=\"img-fluid rounded-start\" alt=\"image\">" +
                "</div>" +
                "<div class=\"col-md-8\">" +
                "<div class=\"card-body\">" +
                "<h5 class=\"card-title\">" + odMenuNameL[i] + "</h5>" +
                "<p class=\"card-text\"><small class=\"text-muted\">옵션 "+odOptionNameL[i]+" :"+odOptionGroupNameL[i]+"  :</small></p>" +
                "<p class=\"card-text\"><small class=\"text-muted\">수량 :"+odMenuQtyL[i]+" 가격 :"+(odOptionPriceL[i]+odMenuPriceL[i])+" </small></p>" +
                "</div>" +
                "</div>" +
                "</div>" +
                "</div>" +
                "</div>" ;



            $('#order').append(divElemApply1);

        }
/*        alert(menuPrice)*/

        divElemApply2 = "<input type=\"hidden\" name=\"orderPrice\" id=\"orderPrice\" value=\""+menuPrice+"\">"+
            "<h3>합계 : "+menuPrice+"</h3>"

        $('#total').append(divElemApply2);


    });
    <%--                     <div class="card mb-3" style="max-width: 540px;">
                                     <div class="row g-0">
                                         <div class="col-md-4">
                                                 ${i}
                                             <img src="/resources/image/1.jpg" class="img-fluid rounded-start" alt="image">
                                         </div>
                                         <div class="col-md-8">
                                             <div class="card-body">
                                                 <h5 class="card-title">${cart.odMenuName}</h5>
                                                 <p class="card-text"><small class="text-muted">옵션 : ${cart.odOptionGroupName} : ${cart.odOptionName}</small></p>
                                                 <p class="card-text"><small class="text-muted">수량 : ${cart.odMenuQty} 가격 : ${cart.odMenuPrice + cart.odOptionPrice}</small></p>
                                             </div>
                                         </div>
                                     </div>
                                 </div>--%>

    /*

                                        <input type="hidden" id="odMenuName" name="odMenuName" value="${cart.odMenuName}"/>
                                    <input type="hidden" id="odOptionGroupName" name="odOptionGroupName" value="${cart.odOptionGroupName}"/>
                                    <input type="hidden" id="odOptionName" name="odOptionName" value="${cart.odOptionName}"/>
                                    <input type="hidden" id="odMenuQty" name="odMenuQty" value="${cart.odMenuQty}"/>
                                    <input type="hidden" id="odMenuPrice" name="odMenuPrice" value="${cart.odMenuPrice}"/>
                                    <input type="hidden" id="odOptionPrice" name="odOptionPrice" value="${cart.odOptionPrice}"/>
                                    <input type="hidden" id="odMenuImage" name="odMenuImage" value="${cart.odMenuImage}"/>



*/


</script>
</body>

</html>