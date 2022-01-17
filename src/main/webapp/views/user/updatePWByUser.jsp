<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">


<head>

	<title>F.FIN | 비밀번호 변경</title>
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

	<style>
		span {
			font-size: 12px;
			margin-top: 5px;
			margin-left: 15px;
			color: #f17228;
		}
	</style>


	<script type="text/javascript">

		var userPwEx = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;

		nowPwChk = false;			// 현재비밀번호 입력
		nowPwCorrectChk = false;	// 현재비밀번호 확인
		newPwChk = false;			// 새로운 비밀번호 입력
		newRePwChk = false;			// 새로운 비밀번호 재입력
		newPwCorrectChk = false;	// 새로운 비밀번호 확인
		pwExChk = false;			// 비밀번호 형식 확인

		$(function () {
			$("a[href='#' ]").click(function () {

				var nowPassword = $("#userPassword_now").val();
				var newPassword = $("#userPassword_new").val();
				var newRePassword = $("#userPassword_new_re").val();

				/* 현재비밀번호 입력 확인 */
				if( nowPassword == ""){
					$(".now_pw_input_chk").css("display","block");
					$(".now_pw_vc_chk").css("display","none");
					$(".now_pw_vc_chk_OK").css("display","none");
					$("#userPassword_now").css({
						"border-color" : "#f17228",
						"box-shadow" : "0 0 0 0.1rem rgb(241, 114, 40)"
					});
					nowPwChk = false;

				} else {
					$(".now_pw_input_chk").css("display","none");
					$("#userPassword_now").css({
						"border-color" : "#fae100",
						"box-shadow" : "0 0 0 0.1rem rgb(241, 114, 40)"
					});
					nowPwChk = true;
				}

				/* 새로운 비밀번호 입력확인 */
				if( newPassword == ""){
					$(".pw_input_chk").css("display","block");
					$("#userPassword_new").css({
						"border-color" : "#f17228",
						"box-shadow" : "0 0 0 0.1rem rgb(241, 114, 40)"
					});
					$("#userPassword_now").css({
						"border-color" : "#fae100",
						"box-shadow" : "0 0 0 0.1rem rgb(241, 114, 40)"
					});
					newPwChk = false;
				}else {
					$(".pw_input_chk").css("display","none");
					$("#userPassword_new").css({
						"border-color" : "#fae100",
						"box-shadow" : "0 0 0 0.1rem rgb(241, 114, 40)"
					});
					newPwChk = ture;
				}

				/* 새로운 비밀번호 재입력 확인 */
				if(newRePassword == ""){
					$(".rePw_input_chk").css("display","block");
					$("#userPassword_new_re").css({
						"border-color" : "#f17228",
						"box-shadow" : "0 0 0 0.1rem rgb(241, 114, 40)"
					});
					$("#userPassword_now").css({
						"border-color" : "#fae100",
						"box-shadow" : "0 0 0 0.1rem rgb(241, 114, 40)"
					});
					newRePwChk = false;
				} else {
					$(".rePw_input_chk").css("display","none");
					newRePwChk = true;
				}
			});
		});

		/* 현재비밀번호 확인 */
		$(function () {
			$("#userPassword_now").on("propertyChange change keyup paste input", function () {

				var userPassword_now = $("#userPassword_now").val();
				var userIdForPW = $("#userIdForPW").val();

				$.ajax({
					type : "POST",
					url : "/user/json/nowPwCheck",
					data : {
						userId : userIdForPW,
						userPassword : userPassword_now
					},
					success : function(pwResult){
						console.log(pwResult);

						if( pwResult == userPassword_now){
							$(".now_pw_vc_chk_OK").css("display","block");
							$(".now_pw_vc_chk").css("display","none");
							$(".now_pw_input_chk").css("display","none");
							$("#userPassword_now").css({
								"border-color": "#ffe537",
								"box-shadow": "0 0 0 0.1rem rgb(255, 229, 55)"
							});
							$("#userPassword_now").attr("disabled", true);
							$(".label-newPw").css("display","block");
							$("#userPassword_new").css("display","block");
							$("#userPassword_new_re").css("display","block");


							nowPwCorrectChk = true;

						}else {
							$(".now_pw_vc_chk").css("display","block");
							$(".now_pw_input_chk").css("display","none");
							$(".now_pw_vc_chk_OK").css("display","none");
							$("#userPassword_now").css({
								"border-color" : "#f17228",
								"box-shadow" : "0 0 0 0.1rem rgb(241, 114, 40)"
							});

							nowPwCorrectChk = false;
						}

						if(userPassword_now == ""){
							$(".now_pw_input_chk").css("display","none");
							$(".now_pw_vc_chk").css("display","none");
							$(".now_pw_vc_chk_OK").css("display","none");
							$(".label-newPw").css("display","none");
							$("#userPassword_new").css("display","none");
							$("#userPassword_new_re").css("display","none");
							$("#userPassword_now").css({
								"border-color" : "#f17228",
								"box-shadow" : "0 0 0 0.1rem rgb(241, 114, 40)"
							});
							$("#userPassword_now").attr("disabled", false);
						}
					}
				})
			});
		});

		/* 새로운 비밀번호 확인 */
		$(function () {
			$("#userPassword_new_re").on("propertyChange change keyup paste input", function () {

				var newPw = $("#userPassword_new").val();
				var newRePw = $("#userPassword_new_re").val();
				$(".pw_input_chk").css("display","none");

				if (newPw !== "") {

					//정규식
					if (userPwEx.test(newPw) === false) {

						$(".pw_ex_chk").css("display", "block");
						$("#userPassword_new").css({
							"border-color": "#f17228",
							"box-shadow": "0 0 0 0.1rem rgb(241, 114, 40)"
						});
						pwExChk = false;

					} else {
						//비밀번호 확인
						if (newPw === newRePw) {
							$(".rePw_vc_chk").css("display", "none");
							$("#userPassword_new").css({
								"border-color": "#ffe537",
								"box-shadow": "0 0 0 0.1rem rgb(255, 229, 55)"
							});
							$("#userPassword_new_re").css({
								"border-color": "#ffe537",
								"box-shadow": "0 0 0 0.1rem rgb(255, 229, 55)"
							});
							newPwCorrectChk = true;
						} else {
							$(".rePw_vc_chk").css("display", "block");
							$("#userPassword_new_re").css({
								"border-color": "#f17228",
								"box-shadow": "0 0 0 0.1rem rgb(241, 114, 40)"
							});
							newPwCorrectChk = false;
						}

						$(".pw_ex_chk").css("display", "none");
						$(".rePw_input_chk").css("display", "none");
						$("#userPassword_new").css({
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

				if( newRePw == "" || newPw == "" ){
					$(".pw_input_chk").css("display", "none");
					$(".pw_ex_chk").css("display", "none");
					$(".rePw_vc_chk").css("display", "none");
					$(".rePw_input_chk").css("display", "none");
				}
			});
		});


	</script>
</head>

<body id="page-top">

<!-- toolbar -->
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
								비밀번호 변경
							</h4>
						</div>
						<form class="row justify-content-center" id="user_updatePW_form" style="margin-top: 40px;">
							<div class="col-md-6 data-input-box">
							<input type="hidden" id="userIdForPW" name="userIdForPW" value="${user.userId}"/>

								<div class="data-input-box">
									<label for="userPassword_now" class="form-label label-name">현재 비밀번호</label>
									<input type="password" class="form-control" id="userPassword_now" name="userPassword" placeholder="현재 비밀번호를 입력하세요.">
									<span class="now_pw_input_chk" style="display: none;">비밀번호를 입력해주세요.</span>
									<span class="now_pw_vc_chk" style="display: none;">비밀번호가 일치하지 않습니다.</span>
									<span class="now_pw_vc_chk_OK" style="display: none; color: #65bf96">비밀번호가 일치합니다.</span>
								</div>

								<div class="data-input-box">
									<label for="userPassword_new" class="form-label label-newPw" style="display: none;">새로운 비밀번호</label>
									<input type="password" class="form-control" id="userPassword_new" name="userPassword" placeholder="새로운 비밀번호를 입력하세요." style="display: none;">
									<span class="pw_input_chk">비밀번호를 입력해주세요.</span>
									<span class="pw_ex_chk">대소문자, 숫자를 포함하여 8자 이상으로 입력해주세요.</span>
									<input type="password" class="form-control" id="userPassword_new_re" placeholder="새로운 비밀번호를 비밀번호 확인해주세요." style="margin-top: 10px; display: none;">
									<span class="rePw_input_chk">비밀번호를 확인해주세요.</span>
									<span class="rePw_vc_chk">비밀번호가 일치하지 않습니다.</span>
								</div>


							</div>
						</form>

						<div class="btn-box">
							<a href="#">
								비밀번호 변경
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