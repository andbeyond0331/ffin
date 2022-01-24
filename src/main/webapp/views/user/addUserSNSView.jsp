<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">


<head>

	<title>F.FIN | 소셜계정 회원가입</title>
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


		/*정규식*/
		var empEx = /\s/g;
		var userPwEx = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
		var userBirthEx = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
		var userPhoneEx = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;


		/* V.C */
		var idExChk = false;
		var pwChk = false;
		var rePwChk = false;
		var pwExChk = false;
		var pwCorrectChk = false;
		var phoneChk = false;
		var phoneExChke = false;
		var phoneAuthChke = false;
		var birthChk = false;


		/* 가입하기 버튼 클릭 */
		$(function () {
			$("a[href='#' ]").click(function () {

				//alert(1234);

				var userPassword = $("#userPassword").val();
				var reUserPassword = $("#reUserPassword").val();
				var userPhone = $("#userPhone").val();
				var userBirth = $("#userBirth").val();


				/* password V.C */
				if(userPassword === ""){
					$(".pw_input_chk").css("display","block");
					$("#userPassword").css({
						"border-color" : "#f17228",
						"box-shadow" : "0 0 0 0.1rem rgb(241, 114, 40)"
					});
					pwChk = false;
				}else {
					$(".pw_input_chk").css("display","none");
					pwChk = true;
				}

				/* RePassword V.C */
				if(reUserPassword === ""){
					$(".rePw_input_chk").css("display","block");
					$("#reUserPassword").css({
						"border-color" : "#f17228",
						"box-shadow" : "0 0 0 0.1rem rgb(241, 114, 40)"
					});
					rePwChk = false;
				}else {
					$(".rePw_input_chk").css("display","none");
					rePwChk = true;
				}


				/* phone V.C */
				if(userPhone === ""){
					$(".phone_input_chk").css("display","block");
					$(".phone_auth_chk").css("display","none");
					$("#userPhone").css({
						"border-color" : "#f17228",
						"box-shadow" : "0 0 0 0.1rem rgb(241, 114, 40)"
					});
					phoneChk = false;
				}else {
					$(".phone_input_chk").css("display","none");
					$(".phone_auth_chk").css("display","block");
					$("#userPhone").css({
						"border-color": "#ffe537",
						"box-shadow": "0 0 0 0.1rem rgb(255, 229, 55)"
					});
					phoneChk = true;
				}

				if(userBirth === ""){
					$("#userBirth").css({
						"border-color" : "#f17228",
						"box-shadow" : "0 0 0 0.1rem rgb(241, 114, 40)"
					});
					birthChk = false;
				}else {
					birthChk = true;
				}

				//문자인증은 유료라서 빼놨음
				if(pwChk&&rePwChk&&pwExChk&&pwCorrectChk&&phoneChk&&phoneExChke&&birthChk){
					$("#user_join_form").attr("method", "POST").attr("action","/user/addUser").submit();
					//alert("가입 축하축하");
				}
				return false;
			});
		});


		/* ps Chk */
		$(function () {
			$("#reUserPassword").on("propertyChange change keyup paste input", function () {

				var pw = $("#userPassword").val();
				var rePw = $("#reUserPassword").val();
				$(".pw_input_chk").css("display","none");

					if (pw !== "") {

						//정규식
						if (userPwEx.test(pw) === false) {

							$(".pw_ex_chk").css("display", "block");
							$("#userPassword").css({
								"border-color": "#f17228",
								"box-shadow": "0 0 0 0.1rem rgb(241, 114, 40)"
							});
							pwExChk = false;

						} else {
							//비밀번호 확인
							if (pw === rePw) {
								$(".rePw_vc_chk").css("display", "none");
								$("#userPassword").css({
									"border-color": "#ffe537",
									"box-shadow": "0 0 0 0.1rem rgb(255, 229, 55)"
								});
								$("#reUserPassword").css({
									"border-color": "#ffe537",
									"box-shadow": "0 0 0 0.1rem rgb(255, 229, 55)"
								});
								pwCorrectChk = true;
							} else {
								$(".rePw_vc_chk").css("display", "block");
								$("#reUserPassword").css({
									"border-color": "#f17228",
									"box-shadow": "0 0 0 0.1rem rgb(241, 114, 40)"
								});
								pwCorrectChk = false;
							}

							$(".pw_ex_chk").css("display", "none");
							$(".rePw_input_chk").css("display", "none");
							$("#userPassword").css({
								"border-color": "#ffe537",
								"box-shadow": "0 0 0 0.1rem rgb(255, 229, 55)"
							});
							pwExChk = true;
						}
					} else {
						$(".pw_input_chk").css("display", "none");
						$(".pw_ex_chk").css("display", "none");
						$(".rePw_input_chk").css("display", "none");
					}
			});
		});


		/* birth Chk */
		$(function () {
			$("#userBirth").on("propertyChange change keyup paste input", function () {

				var userBirth = $("#userBirth").val();

				//정규식
				if (userBirthEx.test(userBirth) === true) {
					$(".brith_ex_chK").css("display", "none");
					$("#birthHelp").css("display", "block");
					$("#userBirth").css({
						"border-color": "#ffe537",
						"box-shadow": "0 0 0 0.1rem rgb(255, 229, 55)"
					});
				} else {
					$(".brith_ex_chK").css("display", "block");
					$("#birthHelp").css("display", "none");
					$("#userBirth").css({
						"border-color": "#f17228",
						"box-shadow": "0 0 0 0.1rem rgb(241, 114, 40)"
					});
				}

			});
		});

		/* phone chk */
		$(function () {
			$("#userPhone").on("propertyChange change keyup paste input", function () {

				var userPhone = $("#userPhone").val();

				//정규식
				if (userPhoneEx.test(userPhone) === true) {

					$(".phone_ex_chk").css("display", "none");
					$(".phone_input_chk").css("display", "none");
					$(".phone_auth_chk").css("display", "block");
					$("#userPhone").css({
						"border-color": "#ffe537",
						"box-shadow": "0 0 0 0.1rem rgb(255, 229, 55)"
					});

					phoneExChke = true;

				} else {
					$(".phone_ex_chk").css("display", "block");
					$(".phone_auth_chk").css("display", "none");
					$("#userPhone").css({
						"border-color": "#f17228",
						"box-shadow": "0 0 0 0.1rem rgb(241, 114, 40)"
					});

					phoneExChke = false;
				}
			});
		});

		/* 휴대폰 인증 */
		$(function () {

			var code2 = "";

			$(".auth-phone").click(function () {

				//alert(1234);

				var inputPhone = $("#userPhone").val();
				var authInputBox = $("#authNumPhone");
				alert(inputPhone);
				$.ajax({
					type : "GET",
					url : "/user/json/sendSMS/" + inputPhone,
					success : function (data){
						console.log(data);
						authInputBox.attr("disabled", false);
						$("#auth-email").text("인증번호 재전송")
						code2 = data;
					}
				});



			});

			//휴대폰 인증번호 대조
			$("#authNumPhone").on("keyup", function () {

				var inputCode = $("#authNumPhone").val();

				if (inputCode.length >= 4) {
					if (inputCode === code2) {
						console.log("SMS OK!!!")
						$(".phone_auth_chk_ok").css("display", "block");
						$(".phone_auth_chk").css("display", "none");
						$(".phone_auth_chk_fail").css("display", "none");
						$("#auth-email").css("disabled",true);
						$("#authNumPhone").css({
							"border-color": "#ffe537",
							"box-shadow": "0 0 0 0.1rem rgb(255, 229, 55)"
						});
						phoneAuthChke = true;
					} else {
						console.log("NOPE");
						$(".phone_auth_chk_fail").css("display", "block");
						$(".phone_auth_chk").css("display", "none");
						$("#authNumPhone").css({
							"border-color": "#f17228",
							"box-shadow": "0 0 0 0.1rem rgb(241, 114, 40)"
						});
						phoneAuthChke = false;
					}
				}
			});
		});


		/* Email Ex */
		$(function () {
			$("#userEmail").on("propertyChange change keyup paste input", function () {

				var userEmail = $("#userEmail").val();

				//정규식
				if (userMailEx.test(userEmail) === true) {

					$(".email_ex_chk").css("display", "none");
					$(".email_auth_chk").css("display", "block");
					$("#userEmail").css({
						"border-color": "#ffe537",
						"box-shadow": "0 0 0 0.1rem rgb(255, 229, 55)"
					});

				} else {

					$(".email_ex_chk").css("display", "block");
					$(".email_auth_chk").css("display", "none");
					$("#userEmail").css({
						"border-color": "#f17228",
						"box-shadow": "0 0 0 0.1rem rgb(241, 114, 40)"
					});
				}
			});
		});

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

	</script>
</head>

<body id="page-top">

<jsp:include page="/views/navbar.jsp" />

<!-- client section -->

<section class="client_section layout_padding">
	<div class="container">
		<div class="col-md-11 col-lg-10 mx-auto">
			<div id="customCarousel1" class="carousel slide">
				<div class="carousel-inner">
					<div class="carousel-item active">
						<div class="detail-box">
							<i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
							<h4 style="margin-top: 10px;">
								소셜 로그인 회원가입
							</h4>
						</div>
						<form class="row justify-content-center" id="user_join_form">

							<div class="col-md-6 data-input-box">

								<div class="data-input-box">
									<label for="userId" class="form-label label-name">ID</label>
									<input type="text" class="form-control" id="userId" name="userId" value="${user.userId}" placeholder="아이디" readonly>
								</div>

								<div class="data-input-box">
									<label for="userPassword" class="form-label label-name">Password</label>
									<input type="password" class="form-control" id="userPassword" name="userPassword" placeholder="비밀번호">
									<span class="pw_input_chk">비밀번호를 입력해주세요.</span>
									<span class="pw_ex_chk">대소문자, 숫자를 포함하여 8자 이상으로 입력해주세요.</span>
									<input type="password" class="form-control" id="reUserPassword" placeholder="비밀번호 확인" style="margin-top: 10px">
									<span class="rePw_input_chk">비밀번호를 확인해주세요.</span>
									<span class="rePw_vc_chk">비밀번호가 일치하지 않습니다.</span>
								</div>

								<div class="data-input-box">
									<label for="userName" class="form-label label-name">이름</label>
									<input type="text" class="form-control" id="userName" value="${user.userName}" name="userName" readonly>
								</div>

								<div class="data-input-box">
									<label for="userBirth" class="form-label label-name">생년월일</label>
									<input type="text" class="form-control" id="userBirth" value="${user.userBirth}" name="userBirth">
									<div id="birthHelp" class="form-text" style="font-size: 10pt; margin-left: 5px; color: grey">연 1회 생일 축하 쿠폰이 발급됩니다.</div>
									<span class="brith_ex_chK">생년월일을 'YYYY-DD-MM' 형식으로 입력해주세요.</span>
								</div>

								<div class="data-input-box">
									<label for="userPhone" class="form-label label-name">Phone</label>
									<input type="text" class="form-control" id="userPhone" name="userPhone" placeholder="전화번호를 입력하세요.">
									<%--<div id="phoneHelp" class="form-text" style="font-size: 10pt; float:left; margin-right:10px; margin-top: 12px; margin-left: 5px;">인증번호를 요청하세요.</div>--%>
									<span class="phone_input_chk">휴대폰번호를 입력해주세요.</span>
									<span class="phone_ex_chk">휴대폰번호를 정확하게 입력해주세요</span>
									<span class="phone_auth_chk">인증번호를 요청하세요.</span>

									<button type="button" class="btn btn-outline-warning auth-phone" style="float: right; margin-bottom: 5px;" >인증번호 요청</button>
									<input type="text" class="form-control auth-Num-Phone" id="authNumPhone" placeholder="인증번호 확인" disabled="disabled" >
									<span class="phone_auth_chk_ok">휴대폰번호 인증 완료</span>
									<span class="phone_auth_chk_fail">인증번호가 일치하지 않습니다.</span>
								</div>

								<div class="data-input-box">
									<label for="userAddr" class="form-label label-name">주소</label>
									<div>
										<input type="text" class="form-control" id="userAddr" name="userAddr" placeholder="주소 검색" style="width: 80%; display: inline-block;">
										<button type="button" class="btn btn-outline-warning addrApi" onclick="addrApi()" style="width: auto;">검색</button>
									</div>
									<input type="text" class="form-control" id="userAddrDetail" placeholder="상세주소" style="margin-top: 8px">
								</div>

							</div>
						</form>

						<div class="btn-box">
							<a href="#">
								가입하기
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<jsp:include page="/views/footer.jsp" />

</body>
</html>