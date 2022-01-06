<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>

    <title>푸드트럭(사업자) 내정보보기</title>
    <jsp:include page="../../common/lib.jsp"/>

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <title>푸드트럭(사업자) 정보조회</title>

    <!-- datepicker -->
    <!-- jQuery UI CSS 파일 -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css"/>
    <!-- jQuery 기본 js파일 -->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <!-- jQuery UI 라이브러리 js파일 -->
    <script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
    <!-- 구글 리캡차 -->
    <script src='https://www.google.com/recaptcha/api.js'></script>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //============= "수정하러가기"  Event 연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-primary").on("click", function () {
                self.location = "/truck/updateTruckInfo"
            });
        });

        //============= "메인화면으로"  Event 처리 및  연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-warning").on("click", function () {
                //alert("수정을 취소하시겠습니까? 확인을 누르시면 홈화면으로 이동합니다.")
                self.location = "/views/home.jsp"
            });
        });

    </script>

</head>

<body id="page-top">

<jsp:include page="/views/navbar.jsp"/>
<br/><br/><br/><br/>
<div class="container">

    <div class="page-header">
        <label for="page-top" class="col-sm-offset-4 control-label"/>
        <h3 class="text-info">푸드트럭(사업자) 정보조회</h3>
    </div>

    <form class="form-horizontal">

        <!-- 아이디 중복검사 -->
        <div class="form-group">
            <label for="tId" class="col-sm-offset-1 col-sm-3 control-label">ID</label>
            <div class="col-sm-4">
                ${truck.truckId}
                <span class="point successIdChk"></span><br/>
                <%--                <span class="point">※ 아이디는 수정불가</span>--%>
                <%--                <input type="hidden" id="idDoubleChk"/>--%>
            </div>
        </div>

        <hr/>

        <!-- 비밀번호 확인 -->
        <div class="form-group">
            <label for="tPassword" class="col-sm-offset-1 col-sm-3 control-label">Password</label>
            <div class="col-sm-4">
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
        <br/>
        <div class="form-group">
            <label for="truckCEOName" class="col-sm-offset-1 col-sm-3 control-label">이름</label>
            <div class="col-sm-4">
                <input id="truckCEOName" class="form-control" name="truckCEOName" value="${truck.truckCEOName}"
                       placeholder="대표자이름" readonly/>
                <span id="result_id_msg" class="help-block"></span>
            </div>
        </div>

        <hr/>

        <!-- 트럭 대표자 생년월일 입력란 -->
        <br/>
        <div class="form-group">
            <label for="truckCEOBirth" class="col-sm-offset-1 col-sm-3 control-label">생년월일</label>
            <div class="col-sm-4">
                <input id="truckCEOBirth" class="form-control" name="truckCEOBirth" value="${truck.truckCEOBirth}"
                       placeholder="대표자 생년월일" readonly/>
            </div>
        </div>

        <hr/>

        <br/>
        <!-- 주소 -->
        <div class="form-group">
            <label for="truckAddr" class="col-sm-offset-1 col-sm-3 control-label">주소</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="truckAddr" name="truckAddr" value="${truck.truckAddr}"
                       placeholder="사업자등록증에 등록된 주소" readonly/>
            </div>
            <div>
                <%--                <input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"><br>--%>
                <br/>
            </div>
            <br/>
            <label for="truckAddrDetail" class="col-sm-offset-1 col-sm-3 control-label">주소 상세</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="truckAddrDetail" name="truckAddrDetail"
                       value="${truck.truckAddrDetail}" placeholder="주소 상세" readonly/>
                <div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
            </div>
        </div>

        <hr/>

        <!-- 핸드폰 문자 인증 -->
        <br/>
        <div class="form-group">
            <label for="truckPhone" class="col-sm-offset-1 col-sm-3 control-label">연락처</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="truckPhone" name="truckPhone" value="${truck.truckPhone}"
                       placeholder=" - 를 제외한 전화번호 입력" readonly/>
            </div>
            <div class="col-sm-3">
                <%--                <button id="phoneChk" type="button" class="btn btn-warning sms-auth">인증번호 요청</button>--%>
            </div>
        </div>
        <div class="form-group phone-check-wrap">
            <%--            <label for="truckPhone" class="col-sm-offset-1 col-sm-3 control-label"></label>--%>
            <%--            <div class="col-sm-4 phone-check-input-box" id="phone-check-input-box-fail">--%>
            <%--                <input type="text" class="form-control phone-check-input" id="truckPhoneAuth" name="truckPhoneAuth"--%>
            <%--                       placeholder="인증번호" disabled--%>
            <%--                       required/>--%>
            <%--                <span class="point successEmailChk">정보수정을 위해 문자인증을 진행해주세요.</span>--%>
            <%--                <span id="phone-check-input-box-warn"></span>--%>
            <%--                <div class="clearfix"></div>--%>
            <%--            </div>--%>
        </div>

        <hr/>

        <!-- 이메일 입력란 -->
        <div class="form-group">
            <label for="truckEmail" class="col-sm-offset-1 col-sm-3 control-label">Email</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="truckEmail" name="truckEmail"
                       value="${truck.truckEmail}" placeholder="인증번호 확인이 가능한 Email" readonly>
            </div>
            <div class="col-sm-3">
                <%--                <button type="button" id="emailChk" class="btn btn-warning email-auth">인증번호 요청</button>--%>
                <br/>
            </div>
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
        <div class="form-group">
            <label for="truckName" class="col-sm-offset-1 col-sm-3 control-label">푸드트럭 상호</label>
            <div class="col-sm-4">
                <input id="truckName" type="text" name="truckName" value="${truck.truckName}" placeholder="푸드트럭 상호 입력"
                       readonly/>
                <%--                <span class="point successNameChk"></span><br/>--%>
                <%--                <span class="point">※ 한글, 영문 입력가능, 최대 10자 까지 입력</span>--%>
                <%--                <input type="hidden" id="nameDoubleChk"/>--%>
            </div>
        </div>

        <hr/>

        <!-- 푸드트럭 사업자등록증 파일업로드란 -->
        <br/>
        <div class="form-group">
            <label for="busiLice" class="col-sm-offset-1 col-sm-3 control-label">사업자등록증</label>
            <div class="col-sm-4">
                <%--                <input id="busiLice" type="file" name="busiLice" class="form-control" value="${truck.truckBusiLice}" readonly/>--%>
                ${truck.truckBusiLice}
            </div>
            <div class="col-xs-8 col-md-4"><img src="../../resources/image/${truck.truckBusiLice}" style="border-bottom: 1px solid #eee; height: 200px;" alt="${truck.truckName}의 사업자등록증 이미지" title="트럭사업자등록증"></div>
        </div>
        <input type="hidden" id="checkL"/>

        <br/>
        <hr/>
        <!-- 푸드트럭 카테고리 -->
        <div class="form-group">
            <label for="truckCate" class="col-sm-offset-1 col-sm-3 control-label">푸드트럭 카테고리</label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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

        <br/>
        <hr/>

        <!-- 푸드트럭 프로필이미지 파일업로드란 -->
        <br/>
        <div class="form-group">
            <label for="proImg" class="col-sm-offset-1 col-sm-3 control-label">프로필 이미지</label>

            <div class="col-xs-8 col-md-4"><img src="../../resources/image/${truck.truckProImg}" style="border-bottom: 1px solid #eee; height: 200px;" alt="${truck.truckName}의 프로필 이미지" title="트럭프로필"></div>
        </div>
        <input type="hidden" id="checkP"/>

        <br/>
        <hr/>

        <!-- 푸드트럭 사장님 한마디 -->
        <div class="form-group">
            <label for="truckCEOIntro" class="col-sm-offset-1 col-sm-3 control-label">사장님 한마디</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="truckCEOIntro" name="truckCEOIntro"
                       value="${truck.truckCEOIntro}" placeholder="사장님 한마디" readonly>
            </div>
        </div>

        <hr/>

        <br/>
        <%--        <div class="form-group">--%>
        <%--            <div id="google_recaptha">--%>
        <%--                <label for="google_recaptha" class="col-sm-offset-4 control-label"/>--%>
        <%--                <div class="g-recaptcha" data-sitekey="6LcPg8gdAAAAAO5xlPExdNehovl0HGgHL8veP0OR"></div>--%>
        <%--            </div>--%>
        <%--        </div>--%>

        <%--        <hr/>--%>

        <br/>
        <div class="form-group">
            <div class="col-sm-offset-1  col-sm-4 text-center">
                <button type="button" class="btn btn-primary">수정하러가기</button>
                <button type="button" class="btn btn-warning">메인화면으로</button>
            </div>
        </div>
    </form>


</div>
<jsp:include page="/views/footer.jsp"/>
</body>

</html>