<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<header class="header">
    <%-- 로그인 X --%>
    <c:if test="${ user.userId == null && truck.truckId == null }">
        <div class="container-fluid">
            <nav class="navbar navbar-expand-md fixed-top">
                <!-- navbar-brand의 content 변경 -->
                    <%--<a class="navbar-brand" href="#">F.Fin</a>--%>
                <div class="logo">
                    <a class="navbar-brand" href="/">
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
    <c:if test="${ (user.userId != null && sessionScope.role == 'user') || (truck.truckId != null && sessionScope.role == 'truck') }">
    <div class="container-fluid">
        <nav class="navbar navbar-expand-md fixed-top">
            <!-- navbar-brand의 content 변경 -->
            <%--<a class="navbar-brand" href="#">F.Fin</a>--%>
            <div class="logo">
                <a class="navbar-brand" href="/">
                    <img class="d-inline-block" src="/resources/bootstrap/assets/logo.svg" alt="logo" />
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
                                <li><a class="dropdown-item user-menu" href="/views/user/userMyPage.jsp"><i class="fas fa-user-circle"></i>MyPage</a></li>
                                <li><a class="dropdown-item user-menu" href="#"><i class="fas fa-question-circle"></i>문의</a></li>
                                <li><a class="dropdown-item user-menu" href="/user/logout"><i class="fas fa-sign-out-alt"></i>로그아웃</a></li>
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
                                <a class="findUserId" style="color: #ffba49; margin-left: 5px; font-size: 14px;" onclick="findUser()"> <strong style="float: right; stroke: #ffba49; margin-right: 5px; margin-top: 2px;">ID/PW 찾기</strong></a>
                            </div>
                            <div class="mb-3">
                                <span style="color: #0b1727; margin-left: 5px; font-size: 14px">아직 회원이 아니신가요?</span>
                                <a class="addChk" href="/views/user/addUserInfo.jsp" style="color: #ffba49; margin-left: 0; font-size: 14px;"> <strong style="float: right; stroke: #ffba49; margin-right: 5px;">회원가입</strong></a>
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
                        <button type="button" class="btn btn-default login" id="modalLoginBtn" style="margin-bottom: 10px;">login</button>
                    </div>
                    <div class="d-grid gap-10 mx-auto" style="margin-bottom: 5px; padding: 0 15px; text-align: center;">
                        <input type="hidden" name="kakaoEmail" id="kakaoEmail">
                        <input type="hidden" name="kakaoName" id="kakaoName">
                        <a id="kakaoLogin">
                            <img src="/resources/image/kakao_login_medium_wide.png">
                        </a>
<%--
                        <button class='btn-social-login google' style='background:#D93025'><i class="xi-3x xi-google"></i></button>
                        <button class='btn-social-login kakao' style='background:#FFEB00'><i class="xi-3x xi-kakaotalk text-dark"></i></button>
--%>
                        <%--<a class="g-signin2" >Google Login</a>--%>
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
