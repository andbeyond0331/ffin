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

    <script type="text/javascript">

        /* Daum API */
        function addrApi(){
            new daum.Postcode({
                oncomplete: function(data) {

                    /*alert(data);
                    alert(data.roadAddress);*/

                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var addr = ''; // 주소 변수
                    var extraAddr = ''; // 참고항목 변수

                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }

                    // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                    if(data.userSelectedType === 'R'){
                        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                            extraAddr += data.bname;
                        }
                        // 건물명이 있고, 공동주택일 경우 추가한다.
                        if(data.buildingName !== '' && data.apartment === 'Y'){
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                        if(extraAddr !== ''){
                            extraAddr = ' (' + extraAddr + ')';
                        }
                        // 조합된 참고항목을 해당 필드에 넣는다.
                        // document.getElementById("sample6_extraAddress").value = extraAddr;
                        addr += extraAddr;
                    } else {
                        // document.getElementById("sample6_extraAddress").value = '';
                        addr = '';
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    // document.getElementById('sample6_postcode').value = data.zonecode;
                    // document.getElementById("sample6_address").value = addr;
                    //$(".userAddr").val(data.zonecode);
                    // 커서를 상세주소 필드로 이동한다.
                    // document.getElementById("sample6_detailAddress").focus();
                    $("#userAddr").val(addr);
                    $("#userAddrDetail").attr("readonly", false);
                    $("#userAddrDetail").focus();
                }
            }).open();
        }

        /* 수정 버튼 클릭 */
        $(function () {
            $("a[href='#' ]").click(function () {

                alert(1234);

                var userId = $("#userId").val();
                var userName = $("#userName").val();
                var userBirth = $("#userBitrh").val();
                var userAddr = $("#userAddr").val();
                var userAddrDetail = $("#userAddrDetail").val();
                var userPhone = $("#userPhone").val();
                var userEmail = $("#userEmail").val();

                console.log(userId+userName+userBirth+userAddr+userAddrDetail+userPhone+userEmail);

                $.ajax({
                    type:"POST",
                    url: "/user/json/updateUserInfo/"+userId,
                    dataType: "json",
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    data:{
                        userId : userId,
                        userName : userName,
                        userBirth : userBirth,
                        userAddr : userAddr,
                        userAddrDetail : userAddrDetail,
                        userPhone : userPhone,
                        userEmail : userEmail
                    },
                    success: function (data) {
                        alert("수정OK");
                    }
                });
            });
        });

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
                    내 정보
                </h4>
            </div>

            <form class="row justify-content-center" id="user_update_info">

                <div class="col-md-6 data-input-box">
                    <hr style="margin-top: 35px;"/>
                    <div class="data-input-box">
                        <label for="userId" class="form-label label-name">ID</label>
                        <input type="text" class="form-control" value="${user.userId}" id="userId" name="userId" placeholder="아이디" readonly>
                    </div>

                    <div class="data-input-box">
                        <label for="userName" class="form-label label-name">이름</label>
                        <input type="text" class="form-control" value="${user.userName}" id="userName" name="userName">
                        <span class="name_input_chk">이름을 입력해주세요.</span>
                        <span class="name_ex_chk">이름을 정확하게 입력해주세요.</span>
                    </div>

                    <div class="data-input-box">
                        <label for="userBirth" class="form-label label-name">생년월일</label>
                        <input type="text" class="form-control" value="${user.userBirth}" id="userBirth" name="userBirth">
                        <div id="birthHelp" class="form-text" style="font-size: 10pt; margin-left: 5px; color: grey">연 1회 생일 축하 쿠폰이 발급됩니다.</div>
                        <span class="brith_ex_chK">생년월일을 'YYYY-DD-MM' 형식으로 입력해주세요.</span>
                    </div>

                    <div class="data-input-box">
                        <label for="userPhone" class="form-label label-name">Phone</label>
                        <input type="text" class="form-control" value="${user.userPhone}" id="userPhone" name="userPhone" placeholder="전화번호를 입력하세요.">
                        <%--<div id="phoneHelp" class="form-text" style="font-size: 10pt; float:left; margin-right:10px; margin-top: 12px; margin-left: 5px;">인증번호를 요청하세요.</div>--%>
                        <span class="phone_input_chk">휴대폰번호를 입력해주세요.</span>
                        <span class="phone_ex_chk">휴대폰번호를 정확하게 입력해주세요</span>
                        <span class="phone_auth_chk">인증번호를 요청하세요.</span>

                        <button type="button" class="btn btn-outline-warning auth-phone" style="float: right; margin-bottom: 5px;" >인증번호 요청</button>
                        <input type="text" class="form-control auth-Num-Phone" id="authNumPhone" placeholder="인증번호 확인" disabled="disabled" hidden>
                        <span class="phone_auth_chk_ok">휴대폰번호 인증 완료</span>
                        <span class="phone_auth_chk_fail">인증번호가 일치하지 않습니다.</span>
                    </div>

                    <div class="data-input-box">
                        <label for="userAddr" class="form-label label-name">주소</label>
                        <div>
                            <input type="text" class="form-control" value="${user.userAddr}" id="userAddr" name="userAddr" placeholder="주소 검색" style="width: 80%; display: inline-block;">
                            <button type="button" class="btn btn-outline-warning addrApi" onclick="addrApi()" style="width: auto;">&nbsp;검색&nbsp;</button>
                        </div>
                        <input type="text" class="form-control" value="${user.userAddrDetail}" id="userAddrDetail" placeholder="상세주소" style="margin-top: 8px">
                    </div>

                    <div class="data-input-box">
                        <label for="userEmail" class="form-label label-name">Email</label>
                        <input type="text" class="form-control" value="${user.userEmail}" id="userEmail" name="userEmail" placeholder="이메일을 입력하세요.">
                        <span class="email_input_chk">이메일을 입력해주세요.</span>
                        <span class="email_ex_chk">이메일을 정확하게 입력해주세요</span>
                        <span class="email_auth_chk">인증번호를 요청하세요.</span>

                        <button type="button" class="btn btn-outline-warning auth-email" style="float: right; margin-bottom: 5px;" >인증번호 요청</button>
                        <label for="authEmail" class="form-label label-name"></label>
                        <input type="text" class="form-control" id="authEmail" placeholder="인증번호 확인" disabled="disabled" style="margin-top: 25px" hidden>
                        <span class="email_auth_chk_ok">이메일 인증 완료</span>
                        <span class="email_auth_chk_fail">인증번호가 일치하지 않습니다.</span>
                    </div>
                    <hr style="margin-top: 60px;"/>
                </div>
            </form>

            <div class="btn-box" style=" margin-top: -40px;">
                <a onClick="history.go(-1);" style="margin-right: 10px;  background-color: #ecf0fd; border-color: #ecf0fd">
                    취소
                </a>
                <a href="#">
                    수정
                </a>
            </div>
        </div>
    </div>
</section>

<jsp:include page="/views/footer.jsp" />

</body>
</html>