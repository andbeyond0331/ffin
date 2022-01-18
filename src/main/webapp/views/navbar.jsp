<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/cart.jsp"/>




<header class="header">
    <%-- 로그인 X --%>
    <c:if test="${ sessionScope.user.userId == null && sessionScope.truck.truckId == null }">
        <div class="container-fluid">
            <nav class="navbar navbar-expand-md fixed-top">
                <!-- navbar-brand의 content 변경 -->
                    <%--<a class="navbar-brand" href="#">F.Fin</a>--%>
                <div class="logo">
                    <a class="navbar-brand" href="/catering/mainTruckList">
                        <img class="d-inline-block" src="/resources/bootstrap/assets/logo.svg" alt="logo" />
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
    <c:if test="${ (sessionScope.user.userId != null && (sessionScope.role == 'user' || sessionScope.role == 'admin')) || (sessionScope.truck.truckId != null && sessionScope.role == 'truck') }">
        <div class="container-fluid">
            <nav class="navbar navbar-expand-md fixed-top">
                <!-- navbar-brand의 content 변경 -->
                    <%--<a class="navbar-brand" href="#">F.Fin</a>--%>
                <div class="logo">
                    <a class="navbar-brand" href="/catering/mainTruckList">
                        <img class="d-inline-block" src="/resources/bootstrap/assets/logo.svg" alt="logo" />
                        <span style="color: #ffba49; ">F.FIN</span>
                    </a>
                </div>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent" style="margin-left: 20px">
                    <ul class="navbar-nav mr-auto">
                        <li class="dropdown" style="color: black">
                            <a class="dropbtn" id="goTruck">푸드트럭</a>
                        </li>
                        <li class="dropdown">
                            <a class="dropbtn" id="goCatering">케이터링</a>
                            <div class="dropdown-content">
                                <a href="/catering/mainCalendar">캘린더</a>
                                <a href="/catering/listCatering">리스트</a>
                            </div>
                        </li>
                        <li class="dropdown">
                            <a class="dropbtn" id="goPost">게시판</a>
                            <div class="dropdown-content">
                                <a href="/community/getPostList2">썸네일게시판</a>
                                <a href="/community/getPostList">일반게시판</a>
                            </div>
                        </li>
                        <c:if test="${sessionScope.user.userId != null && (sessionScope.role == 'user' || sessionScope.role == 'admin')}">
                            <li class="dropdown" style="color: black">
                                <a class="dropbtn" id="goChat">채팅방</a>
                            </li>
                        </c:if>
                    </ul>
                </div>
                <div class="collapse navbar-collapse justify-content-end nav-user" id="navbarSupportedContent" >

                    <ul class="navbar-nav">
                        <c:choose>
                            <c:when test="${sessionScope.user.userId != null && sessionScope.role eq 'user' }">
                                <li class="nav-item">
                                    <a class="nav-link" id="goMsg" href="#" style="margin-top: 3px;"><i class="fas fa-envelope fa-lg" ></i></a>
                                </li>
                                <li class="nav-item">
                                    <a class="pull-bs-canvas-right d-block text-primary text-decoration-none" href="#" style="margin-top: 10px;"><i class="fas fa-shopping-cart fa-lg"></i></a>
                                </li>
                            </c:when>
                            <c:when test="${sessionScope.truck.truckId != null && sessionScope.role eq 'truck' }">
                                <li class="nav-item">
                                    <a class="nav-link" href="/purchase/getOrderList?truckId=${truck.truckId}&search=0" style="margin-top: 3px;"><i class="fas fa-shopping-cart fa-lg"></i></a>
                                </li>
                            </c:when>
                        </c:choose>
                        <li class="form-inline my-2 my-lg-0" style="position: relative;">
                                <%--<input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" />
                                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>--%>
                            <c:choose>

                                <%-- User --%>
                                <c:when test="${sessionScope.user.userId != null && sessionScope.role eq 'user' }">
                                    <button type="button" class="btn btn-default dropdown-toggle" id="user-dropdown" data-toggle="dropdown"  aria-expanded="false">
                                        <i class="fas fa-user-alt"></i>${sessionScope.user.userId}
                                    </button>
                                    <ul class="dropdown-menu" aria-labelledby="user-dropdown">
                                        <li><a class="dropdown-item user-menu" href="/views/user/userMyPage.jsp"><i class="fas fa-user-circle"></i>MyPage</a></li>
                                        <li><a class="dropdown-item user-menu" href="/views/qna/addInquiryView.jsp"><i class="fas fa-question-circle"></i>문의</a></li>
                                        <li><a class="dropdown-item user-menu" href="/purchase/getOrderUserList?userId=${sessionScope.user.userId}"><i class="fas fa-question-circle"></i>현재주문목록</a></li>
                                        <c:if test="${sessionScope.sns eq 'kakao'}">
                                            <li><a class="dropdown-item user-menu" href="https://kauth.kakao.com/oauth/logout?client_id=c5cd6068fce64f5187211674e3872ec7&logout_redirect_uri=http://localhost:8080/user/kakaoLogout"><i class="fas fa-sign-out-alt"></i>로그아웃</a></li>
                                        </c:if>
                                        <c:if test="${sessionScope.sns == null }">
                                            <li><a class="dropdown-item user-menu" href="/user/logout"><i class="fas fa-sign-out-alt"></i>로그아웃</a></li>
                                        </c:if>
                                    </ul>
                                </c:when>

                                <%-- Admin --%>
                                <c:when test="${sessionScope.user.userId != null && sessionScope.role eq 'admin'}">
                                    <button type="button" class="btn btn-default dropdown-toggle" id="user-dropdown" data-toggle="dropdown"  aria-expanded="false">
                                        <i class="fas fa-user-alt"></i>${sessionScope.user.userId}
                                    </button>
                                    <ul class="dropdown-menu" aria-labelledby="user-dropdown">
                                        <li><a class="dropdown-item user-menu" href="/views/user/adminMyPage.jsp"><i class="fas fa-user-circle"></i>사이트 관리</a></li>
                                        <li><a class="dropdown-item user-menu" href="/truck/getNewTruckListByAdmin"><i class="fas fa-question-circle"></i>가입승인</a></li>
                                        <li><a class="dropdown-item user-menu" href="/user/logout"><i class="fas fa-sign-out-alt"></i>로그아웃</a></li>
                                    </ul>
                                </c:when>

                                <%-- Truck --%>
                                <c:when test="${sessionScope.truck.truckId != null && sessionScope.role eq 'truck' }">
                                    <button type="button" class="btn btn-default dropdown-toggle" id="truck-dropdown" data-toggle="dropdown"  aria-expanded="false">
                                        <i class="fas fa-user-alt"></i>${sessionScope.truck.truckId}
                                    </button>
                                    <ul class="dropdown-menu" aria-labelledby="truck-dropdown">
                                        <li><a class="dropdown-item user-menu" href="/views/truck/truckMyPage.jsp"><i class="fas fa-user-circle"></i>MyPage</a></li>
                                        <li><a class="dropdown-item user-menu" href="/views/truck/updateBusiStatus.jsp"><i class="fas fa-power-off"></i>영업상태변경</a></li>
                                        <li><a class="dropdown-item user-menu" href="/views/qna/addInquiryView.jsp"><i class="fas fa-question-circle"></i>문의</a></li>
                                        <li><a class="dropdown-item user-menu" href="/truck/logoutTruck"><i class="fas fa-sign-out-alt"></i>로그아웃</a></li>
                                    </ul>
                                </c:when>
                            </c:choose>
                        </li>
                    </ul>
                </div>

            </nav>
            <!-- socket alert -->
            <div id="socketAlert" class="alert alert-warning" role="alert" style="display:none; margin-top:75px; z-index:999999"></div>

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
                        <a class="nav-link active" data-toggle="tab" href="#user" style="margin-left: 0; border-radius: 50px;">User</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#CEO" style="border-radius: 50px;">CEO</a>
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
                                <input type="checkbox" class="form-check-input" id="autoLoginUser" name="autoLoginUser">
                                <label class="form-check-label" for="autoLoginUser">자동로그인</label>
                                <a class="findUserId" style="color: #ffba49; margin-left: 5px; font-size: 14px;" onclick="findUser()"> <strong style="float: right; stroke: #ffba49; margin-right: 5px; margin-top: 2px;">ID/PW 찾기</strong></a>
                            </div>
                            <div class="mb-3">
                                <span style="color: #0b1727; margin-left: 5px; font-size: 14px">아직 회원이 아니신가요?</span>
                                <a class="addChk" href="/views/user/addUserInfo.jsp" style="color: #ffba49; margin-left: 0; font-size: 14px;"> <strong style="float: right; stroke: #ffba49; margin-right: 5px;">회원가입</strong></a>
                            </div>
                            <%--                            <hr style="margin-top: 30px; margin-bottom: 20px; border-width: 2px;"/>--%>
                            <div class="mb-3 d-grid gap-2 mx-auto">
                                <button type="button" class="btn btn-default login" id="modalLoginBtn" style="margin-bottom: 10px; margin-top: 40px;">login</button>
                            </div>
                            <hr style="margin-bottom: 20px; border-width: 2px;"/>
                            <div class="d-grid gap-10 mx-auto">
                                <input type="hidden" name="kakaoEmail" id="kakaoEmail">
                                <input type="hidden" name="kakaoName" id="kakaoName">
                                <a href="#" id="kakaoLogin" class="btn btn-kakao btn-user btn-block">
                                    <i class="xi-2x xi-kakaotalk"></i> Login with kakao
                                </a>
                            </div>
                            <%--<div class="mb-3 d-grid gap-2 mx-auto">
                                <a href="#" class="btn btn-google btn-user btn-block">
                                    <i class="fab fa-google fa-fw"></i> Login with Google
                                </a>
                            </div>--%>
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
                                <a class="findTruckId" style="color: #ffba49; margin-left: 5px; font-size: 14px;" onclick="findTruck()">
                                    <strong style="float: right; stroke: #ffba49; margin-right: 5px; margin-top: 2px;">ID/PW 찾기</strong>
                                </a>
                            </div>
                            <div class="mb-3">
                                <span style="color: #0b1727; margin-left: 5px; font-size: 14px">아직 회원이 아니신가요?</span>
                                <a class="addChk" href="/views/truck/addTruckView.jsp" style="color: #ffba49; margin-left: 0; font-size: 14px;"> <strong style="float: right; stroke: #ffba49; margin-right: 5px;">사업자 회원가입</strong></a>
                            </div>
                            <div class="mb-3 d-grid gap-2 mx-auto">
                                <button type="button" class="btn btn-default login" id="modalLoginTBtn" style="margin-bottom: 10px; margin-top: 40px;">login</button>
                            </div>
                        </div>
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
                        <a class="nav-link active" id="findIdBtn" data-toggle="tab" href="#findId" style="margin-left: 0;">ID 찾기</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="findPwBtn" data-toggle="tab" href="#findPw">PW 찾기</a>
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
                            <hr/>
                            <div class="d-grid gap-2 col-6 mx-auto">
                                <button class="btn findIdBtn" type="button" onclick="getUserId()">아이디 찾기</button>
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
                            <hr/>
                            <div class="d-grid gap-2 col-6 mx-auto">
                                <button class="btn findPwBtn" type="button">비밀번호 찾기</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<%-- 아이디 / 비밀번호 찾기 Modal Truck!!!!!!!!!!!!1 --%>
<div class="modal fade" id="findTruckModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="findTruckModalTitle">ID/PW 찾기</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <ul class="nav nav-pills nav-fill" id="id-pw-tab-T">
                    <li class="nav-item">
                        <a class="nav-link active" id="findIdBtn-T" data-toggle="tab" href="#findIdT" style="margin-left: 0;">ID 찾기</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="findPwBtn-T" data-toggle="tab" href="#findPwT">PW 찾기</a>
                    </li>
                </ul>
                <form id = "fineTruckmodalForm" name="fineTruckmodalForm">
                    <div class="tab-content">
                        <%-- ID modal --%>
                        <div class="tab-pane fade show active" id="findIdT">
                            <div class="mb-3">
                                <label for="truckIdforId" class="form-label" style="margin-top: 12px;">푸드트럭 상호</label>
                                <input type="text" class="form-control" id="truckIdforId" >
                            </div>
                            <div class="mb-3">
                                <label for="truckPhoneForId" class="form-label">연락처</label>
                                <input type="text" class="form-control" id="truckPhoneForId">
                            </div>
                            <hr/>
                            <div class="d-grid gap-2 col-6 mx-auto">
                                <button class="btn findIdBtnT" type="button" onclick="getTruckId()">아이디 찾기</button>
                            </div>
                        </div>
                        <%-- PW modal --%>
                        <div class="tab-pane fade" id="findPwT">
                            <div class="mb-3">
                                <label for="truckNameforPw" class="form-label">푸드트럭 상호</label>
                                <input type="text" class="form-control" id="truckNameforPw">
                            </div>
                            <div class="mb-3">
                                <label for="truckIdforPw" class="form-label">Id</label>
                                <input type="text" class="form-control" id="truckIdforPw">
                            </div>
                            <div class="mb-3">
                                <label for="truckPhoneforPw" class="form-label">연락처</label>
                                <input type="text" class="form-control" id="truckPhoneforPw">
                            </div>
                            <hr/>
                            <div class="d-grid gap-2 col-6 mx-auto">
                                <button class="btn findPwBtnT" type="button">비밀번호 찾기</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 아이디 출력 Modal -->
<div class="modal modal-child" id="background_modal" aria-hidden="true" style="display: none; z-index: 1060;" data-modal-parent="#findUserModal">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">아이디 찾기</h5>
                <span class="close">&times;</span>
            </div>
            <div class="modal-body" style="float: left;">
                <span id="id_value"></span>
            </div>
            <div class="modal-footer">
                <button type="button" id="longinGoBtn" class="btn peach-gradient btn-rounded waves-effect" onclick="longinGoBtn()">
                    로그인
                </button>
                <button type="button" id="findUserPw" class="btn peach-gradient btn-rounded waves-effect" onclick="findUserPw()">
                    비밀번호 찾기
                </button>
            </div>
        </div>
    </div>
</div>


<!-- 아이디 출력 Modal 트럭!!!!-->
<div class="modal modal-child" id="background_modalT" aria-hidden="true" style="display: none; z-index: 1060;" data-modal-parent="#findTruckModal">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabelT">아이디 찾기</h5>
                <span class="close">&times;</span>
            </div>
            <div class="modal-body" style="float: left;">
                <span id="id_valueT"></span>
            </div>
            <div class="modal-footer">
                <button type="button" id="longinGoBtnT" class="btn peach-gradient btn-rounded waves-effect" onclick="longinGoBtnT()">
                    로그인
                </button>
                <button type="button" id="findTruckPw" class="btn peach-gradient btn-rounded waves-effect" onclick="findTruckPw()">
                    비밀번호 찾기
                </button>
            </div>
        </div>
    </div>
</div>

<!-- websocket -->
<script>
    var socket = null; //전역변수.다른 페이지 어디서든 접근


    $(document).ready(function(){
        connectWS();
    });

    function connectWS(){
        var ws = new WebSocket("ws://localhost:8080/push");
        // servlet-context에 선언한 path와 일치시키도록...
        socket = ws;

        ws.onopen = function(){
            console.log('Info : connection opened. ');


        };
        ws.onmessage = function(event){
            console.log("ReceiveMessage: ", event.data+'\n');
            let $socketAlert =  $('div#socketAlert');
            $socketAlert.html(event.data);
            $socketAlert.css('display', 'block');
            setTimeout( function(){
                $socketAlert.css('display', 'none')
            }, 3000)

        }

        ws.onclose = function(event){
            console.log('info: connection closed.');
            // 원래 이거 해야하는데 계속 끊기는데 연결을 시도해서.. 일단 주석처리
            // setTimeout( function(){connectWS();}, 1000);
        };
        ws.onerror = function(err){console.log('error: connection error.', err);};

    }



</script>