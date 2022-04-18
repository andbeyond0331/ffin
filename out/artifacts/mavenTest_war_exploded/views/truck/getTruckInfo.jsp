<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>
    <style>
        div {
            margin-left: auto;
            margin-right: auto;
        }

        strong {
            font-size: 18px;
        }

        .col-sm-6 {
            font-size: 20px;
        }

        img {
            display: block;
            margin: 0px;
        }
        .join-layout{display: flex}

    </style>

    <title>F.FIN | 푸드트럭(사업자) 내정보보기</title>
    <jsp:include page="../../common/lib.jsp"/>

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <title>F.FIN | 푸드트럭(사업자) 정보조회</title>

    <!-- datepicker -->
    <!-- jQuery UI CSS 파일 -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css"/>
    <!-- jQuery 기본 js파일 -->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <!-- jQuery UI 라이브러리 js파일 -->
    <script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
    <!-- 구글 리캡차 -->
    <script src='https://www.google.com/recaptcha/api.js'></script>
    <!-- 이미지 확대 -->
    <link rel="stylesheet" href="/styles/vendor/jquery.fancybox.min.css">

    <script src="/scripts/vendor/jquery.fancybox.min.js"></script>
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


    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //============= "수정하러가기"  Event 연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-default.updateInfo").on("click", function () {
                self.location = "/truck/updateTruckInfo"
            });
        });

        //============= "마이페이지로"  Event 처리 및  연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-cancle.goMyPage").on("click", function () {
                //alert("수정을 취소하시겠습니까? 확인을 누르시면 홈화면으로 이동합니다.")
                self.location = "/views/truck/truckMyPage.jsp"
            });
        });

    </script>

</head>

<body id="page-top">

<jsp:include page="/views/navbar.jsp"/>
<br/><br/><br/><br/>
<div class="container">

    <div class="page-header" align="center">
        <label for="page-top" class="control-label"/>
        <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228; margin-top:30px "></i>
        <h4 style="margin-top: 10px;">
        푸드트럭(사업자) 정보조회</h4>
    </div>
    <br>

    <div class="form-horizontal" style="border-radius:10px ; border: 0; box-shadow: 0 2px 4px 0 rgba(0,0,0,0.2); max-width: 550px;
			transition: 0.3s;">

        <!-- 아이디 중복검사 -->
        <div class="form-group join-layout" align="center" style="padding-top:20px ">
            <strong class="col-sm-offset-1 col-sm-3 control-label" style="margin-top:5px ">ID</strong>
            <div class="col-sm-6">
                ${truck.truckId}
                <span class="point successIdChk"></span><br/>
                <%--                <span class="point">※ 아이디는 수정불가</span>--%>
                <%--                <input type="hidden" id="idDoubleChk"/>--%>
            </div>
        </div>

        <hr/>

        <!-- 비밀번호 확인 -->
        <div class="form-group join-layout" align="center">
            <strong for="tPassword" class="col-sm-offset-1 col-sm-3 control-label">Password</strong>
            <div class="col-sm-6">
                <input type="password" class="form-control" id="tPassword" name="truckPassword"
                       value="${truck.truckPassword}"
                       required maxlength="8"
                       autocomplete="off" readonly="true"/>
                <%--                <span class="point">※ Password를 변경하시려면 아래의 버튼을 클릭하세요</span><br/>--%>
                <%--                <button name="changePw" class="btn btn-dark" type="button">Password 변경</button>--%>
            </div>
        </div>

        <hr/>

        <!-- 트럭 대표자 이름 입력란 -->
        <div class="form-group join-layout" align="center">
            <strong for="truckCEOName" class="col-sm-offset-1 col-sm-3 control-label">이름</strong>
            <div class="col-sm-6">
                <input id="truckCEOName" class="form-control" name="truckCEOName" value="${truck.truckCEOName}"
                       placeholder="대표자이름" readonly/>
                <span id="result_id_msg" class="help-block"></span>
            </div>
        </div>

        <hr/>
        <!-- 트럭 대표자 생년월일 입력란 -->
        <div class="form-group join-layout" align="center">
            <strong for="truckCEOBirth" class="col-sm-offset-1 col-sm-3 control-label">생년월일</strong>
            <div class="col-sm-6">
                <input id="truckCEOBirth" class="form-control" name="truckCEOBirth" value="${truck.truckCEOBirth}"
                       placeholder="대표자 생년월일" readonly/>
            </div>
        </div>

        <hr/>

        <!-- 주소 -->
        <div class="form-group" align="center">
            <div class="join-layout">
                <strong for="truckAddr" class="col-sm-offset-1 col-sm-3 control-label">주소</strong>
                <div class="col-sm-6">
                    <input type="text" class="form-control" id="truckAddr" name="truckAddr" value="${truck.truckAddr}"
                           placeholder="사업자등록증에 등록된 주소" readonly/>
                </div>
            </div>
            <br>
            <div class="join-layout">
                <strong for="truckAddrDetail" class="col-sm-offset-1 col-sm-3 control-label">주소 상세</strong>
                <div class="col-sm-6">
                    <input type="text" class="form-control" id="truckAddrDetail" name="truckAddrDetail"
                           value="${truck.truckAddrDetail}" placeholder="주소 상세" readonly/>
                    <div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
                </div>
            </div>
        </div>

        <hr/>
        <!-- 핸드폰 문자 인증 -->
        <br/>
        <div class="form-group join-layout" align="center">
            <strong for="truckPhone" class="col-sm-offset-1 col-sm-3 control-label">연락처</strong>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="truckPhone" name="truckPhone" value="${truck.truckPhone}"
                       placeholder=" - 를 제외한 전화번호 입력" readonly/>
            </div>
<%--            <div class="col-sm-3">--%>
<%--                &lt;%&ndash;                <button id="phoneChk" type="button" class="btn btn-warning sms-auth">인증번호 요청</button>&ndash;%&gt;--%>
<%--            </div>--%>
        </div>
<%--        <div class="form-group phone-check-wrap">--%>
            <%--            <label for="truckPhone" class="col-sm-offset-1 col-sm-3 control-label"></label>--%>
            <%--            <div class="col-sm-4 phone-check-input-box" id="phone-check-input-box-fail">--%>
            <%--                <input type="text" class="form-control phone-check-input" id="truckPhoneAuth" name="truckPhoneAuth"--%>
            <%--                       placeholder="인증번호" disabled--%>
            <%--                       required/>--%>
            <%--                <span class="point successEmailChk">정보수정을 위해 문자인증을 진행해주세요.</span>--%>
            <%--                <span id="phone-check-input-box-warn"></span>--%>
            <%--                <div class="clearfix"></div>--%>
            <%--            </div>--%>
<%--        </div>--%>

        <hr/>
        <!-- 이메일 입력란 -->
        <div class="form-group join-layout" align="center">
            <strong for="truckEmail" class="col-sm-offset-1 col-sm-3 control-label">Email</strong>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="truckEmail" name="truckEmail"
                       value="${truck.truckEmail}" placeholder="인증번호 확인이 가능한 Email" readonly>
            </div>
<%--            <div class="col-sm-3">--%>
<%--                &lt;%&ndash;                <button type="button" id="emailChk" class="btn btn-warning email-auth">인증번호 요청</button>&ndash;%&gt;--%>
<%--            </div>--%>
        </div>
        <%--        <div class="form-group mail-check-wrap">--%>
        <%--            <label for="truckEmail" class="col-sm-offset-1 col-sm-3 control-label"></label>--%>
        <%--            <div class="col-sm-4 mail-check-input-box" id="mail-check-input-box-fail">--%>
        <%--                <input type="text" class="form-control mail-check-input" id="truckEmailAuth" name="truckEmailAuth"--%>
        <%--                       placeholder="인증번호" disabled required>--%>
        <%--                <span class="point successEmailChk">정보수정을 위해 메일인증을 진행해주세요.</span>--%>
        <%--                <span id="mail-check-input-box-warn"></span>--%>
        <%--                <div class="clearfix"></div>--%>
        <%--            </div>--%>
        <%--        </div>--%>

        <hr/>

        <!-- 푸드트럭상호 중복검사 -->
        <br/>
        <div class="form-group join-layout" align="center">
            <strong for="truckName" class="col-sm-offset-1 col-sm-3 control-label">푸드트럭 상호</strong>
            <div class="col-sm-6">
                <input id="truckName" type="text" name="truckName" value="${truck.truckName}" placeholder="푸드트럭 상호 입력"
                       class="form-control" readonly>
                <%--                <span class="point successNameChk"></span><br/>--%>
                <%--                <span class="point">※ 한글, 영문 입력가능, 최대 10자 까지 입력</span>--%>
                <%--                <input type="hidden" id="nameDoubleChk"/>--%>
            </div>
        </div>

        <hr/>
        <!-- 푸드트럭 사업자등록증 파일업로드란 -->
        <br/>
        <div class="form-group" align="center">
            <strong class="col-sm-offset-1 col-sm-3 control-label">사업자등록증</strong>
            <c:if test="${truck.truckBusiLice ne '' and truck.truckBusiLice ne null}">
            <div><a href="../../../resources/image/${truck.truckBusiLice}" data-fancybox
                                              data-caption="캡션"><img src="../../../resources/image/${truck.truckBusiLice}"
                                                                     style="border-bottom: 1px solid #eee; height: 200px;"
                                                                     alt="${truck.truckName}의 사업자등록증 이미지"
                                                                     title="트럭사업자등록증"></a></div>
            </c:if>
        </div>
        <input type="hidden" id="checkL"/>

        <br/>

        <hr/>

        <!-- 푸드트럭 카테고리 -->
        <div class="form-group" align="center">
            <strong for="truckCate" class="col-sm-offset-1 col-sm-3 control-label">카테고리</strong>
            <%--            <select name="truckCate" class="col-sm-offset-4 col-sm-4 ct_input_g"--%>
            <%--                    style="width: 120px; height: 24px" maxLength="30">--%>
            <%--                <option value="0" selected="selected">카테고리 선택</option>--%>
            <%--                <option value="1">고기</option>--%>
            <%--                <option value="2">분식</option>--%>
            <%--                <option value="3">음료</option>--%>
            <%--                <option value="4">양식</option>--%>
            <%--                <option value="5">디저트</option>--%>
            <%--                <option value="6">한식</option>--%>
            <%--                <option value="7">일식</option>--%>
            <%--                <option value="8">기타</option>--%>
            <%--            </select>--%>
            <input type="hidden" id="truckCate" name="truckCate" value="${truck.truckCate}">
            <c:if test="${truck.truckCate == 0}">
                <h5>카테고리 미선택</h5>
            </c:if>
            <c:if test="${truck.truckCate == 1}">
                <h5>고기</h5>
            </c:if>
            <c:if test="${truck.truckCate == 2}">
                <h5>분식</h5>
            </c:if>
            <c:if test="${truck.truckCate == 3}">
                <h5>음료</h5>
            </c:if>
            <c:if test="${truck.truckCate == 4}">
                <h5>양식</h5>
            </c:if>
            <c:if test="${truck.truckCate == 5}">
                <h5>디저트</h5>
            </c:if>
            <c:if test="${truck.truckCate == 6}">
                <h5>한식</h5>
            </c:if>
            <c:if test="${truck.truckCate == 7}">
                <h5>일식</h5>
            </c:if>
            <c:if test="${truck.truckCate == 8}">
                <h5>기타</h5>
            </c:if>
        </div>

        <hr/>

        <!-- 푸드트럭 프로필이미지 파일업로드란 -->
        <div class="form-group" align="center">
            <strong class="col-sm-offset-1 col-sm-3 control-label">프로필 이미지</strong>
            <c:if test="${truck.truckProImg ne '' and truck.truckProImg ne null}">
            <div><a href="../../../resources/image/${truck.truckProImg}" data-fancybox
                                              data-caption="캡션"><img src="../../../resources/image/${truck.truckProImg}"
                                                                     style="border-bottom: 1px solid #eee; height: 200px; width:200px "
                                                                     alt="${truck.truckName}의 프로필 이미지"
                                                                     title="트럭프로필"></a></div>
            </c:if>
        </div>
        <input type="hidden" id="checkP"/>

        <br/>
        <hr/>
        <!-- 푸드트럭 사장님 한마디 -->
        <div class="form-group join-layout" align="center">
            <strong for="truckCEOIntro" class="col-sm-offset-1 col-sm-3 control-label">사장님 한마디</strong>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="truckCEOIntro" name="truckCEOIntro"
                       value="${truck.truckCEOIntro}" placeholder="사장님 한마디" readonly>
            </div>
        </div>

        <hr/>

        <%--        <div class="form-group">--%>
        <%--            <div id="google_recaptha">--%>
        <%--                <label for="google_recaptha" class="col-sm-offset-4 control-label"/>--%>
        <%--                <div class="g-recaptcha" data-sitekey="6LcPg8gdAAAAAO5xlPExdNehovl0HGgHL8veP0OR"></div>--%>
        <%--            </div>--%>
        <%--        </div>--%>

        <%--        <hr/>--%>
        <div class="form-group" align="center">
            <div class="col-sm-offset-1  col-sm-10 text-center">
                <button type="button" class="btn btn-default updateInfo">수정하러가기</button>
                <button type="button" class="btn btn-cancle goMyPage">마이페이지로</button>
            </div>
            <hr/>
            <div class="col-sm-offset-1 text-center">
                <a href="byeTruck.jsp" class="text-dark pull-right">회원탈퇴하기</a>
            </div>
        </div>

    </div>


</div>
<br/>
<br/>
<br/>
<jsp:include page="/views/footer.jsp"/>
</body>

</html>