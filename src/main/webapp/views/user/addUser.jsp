<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	<link rel="stylesheet" type="text/css" href="../../resources/bootstrap/css/bootstrap.css" />

	<!-- fonts style -->
	<link href="https://fonts.googleapis.com/css?family=Poppins:400,600,700&display=swap" rel="stylesheet">

	<!-- font awesome style -->
	<link href="../../resources/bootstrap/css/font-awesome.min.css" rel="stylesheet" />
	<!-- nice select -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" integrity="sha256-mLBIhmBvigTFWPSCtvdu6a76T+3Xyt+K571hupeFLg4=" crossorigin="anonymous" />
	<!-- slidck slider -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css" integrity="sha256-UK1EiopXIL+KVhfbFa8xrmAWPeBjMVdvYMYkTAEv/HI=" crossorigin="anonymous" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css.map" integrity="undefined" crossorigin="anonymous" />

	<!-- Custom styles for this template -->
	<link href="../../resources/bootstrap/css/style.css" rel="stylesheet" />
	<!-- responsive style -->
	<link href="../../resources/bootstrap/css/responsive.css" rel="stylesheet" />

	<!--    Favicons-->
	<link rel="apple-touch-icon" sizes="180x180" href="../../resources/bootstrap/assets/favicons/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="../../resources/bootstrap/assets/favicons/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="../../resources/bootstrap/assets/favicons/favicon-16x16.png">
	<link rel="shortcut icon" type="image/x-icon" href="../../resources/bootstrap/assets/favicons/favicon.ico">
	<link rel="manifest" href="../../resources/bootstrap/assets/favicons/manifest.json">
	<meta name="msapplication-TileImage" content="../../resources/bootstrap/assets/favicons/mstile-150x150.png">
	<meta name="theme-color" content="#ffffff">

	<!-- jQery -->
	<script src="../../resources/bootstrap/js/jquery-3.4.1.min.js"></script>
	<!-- bootstrap js -->
	<script src="../../resources/bootstrap/js/bootstrap.js"></script>
	<!-- slick  slider -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.js"></script>
	<!-- nice select -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js" integrity="sha256-Zr3vByTlMGQhvMfgkQ5BtWRSKBGa2QlspKYJnkjZTmo=" crossorigin="anonymous"></script>
	<!-- custom js -->
	<script src="../../resources/bootstrap/js/custom.js"></script>

	<%--주소API--%>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


	<script type="text/javascript">

		/* 필수입력사항 check */
		$(function () {
			$("a[href='#' ]").on("click" , function() {

				var userId = $("input[name='userId']").val();
				var userPassword = $("input[name='userPassword']").val();
				var userName = $("input[name='userName']").val();
				var userPhone = $("input[name='userPhone']").val();

				if(userId == null || id.length < 1 ){
					$("input[name='userId']").focus();
				}

				$("form").attr("method" , "POST").attr("action" , "/user/addUser").submit();
			});
		});


		/* 이메일 인증 */
		$( function() {

			var code = "";
``
			/* 인증번호 이메일 전송 */
			$(".auth-email").click(function () {

				var inputEmail = $("#userEmail").val();
				var authInputBox = $(".mail-check-input");
				var boxWrap = $(".mail-check-input-box");

				alert(inputEmail);
				$.ajax({
					type:"GET",
					url:"/auth/json/emailAuth/"+inputEmail,
					success:function (data){
						//console.log("data : "+data);
						/*$("#userEmailAuth").attr("disabled",false);*/
						authInputBox.attr("disabled",false);
						boxWrap.attr("id", "mail-check-input-box-ture")
						code = data;
					}
				});
			});

			/* email 인증번호 비교 */
			$(".mail-check-input").on("keyup",function (){

				var inputCode = $(".mail-check-input").val();
				var checkResult = $("#mail-check-input-box-warn");

				if(inputCode.length >= 6){
					if(inputCode == code){
						checkResult.html("OK");
						checkResult.attr("class", "correct");
					}else {
						checkResult.html("NOPE");
						checkResult.attr("class","incorrect");
					}
				}

			});


			/* coolSMS */
			// $(".sms-auth").click(function (){
			//
			// 	alert("zzz...");
			// 	/*var code = "";*/
			// 	var userPhone = $("#userPhone").val();
			// 	$("form").attr("method","POST").attr("action", "/auth/sendSMS").submit();
			//
			// 	alert("인증번호가 전송되었습니다.");
			// });

		});

		/* Daum API */
		function addrApi(){
			new daum.Postcode({
				oncomplete: function(data) {

					alert(data);
					alert(data.roadAddress);

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

<jsp:include page="/views/toolbar.jsp" />

<!-- client section -->

<section class="client_section layout_padding">
	<div class="container">
		<div class="col-md-11 col-lg-10 mx-auto">
			<div id="customCarousel1" class="carousel slide">
				<div class="carousel-inner">
					<div class="carousel-item active">
						<div class="detail-box">
							<i class="fa fa-quote-left" aria-hidden="true"></i>
							<h4 style="margin-top: 10px;">
								회원가입
							</h4>
						</div>
						<form class="row justify-content-center">

							<div class="col-md-6 data-input-box">

								<div class="data-input-box">
									<label for="userId" class="form-label label-name">ID</label>
									<input type="text" class="form-control" id="userId" placeholder="아이디">
								</div>

								<div class="data-input-box">
									<label for="userPassword" class="form-label label-name">Password</label>
									<input type="password" class="form-control" id="userPassword" placeholder="비밀번호">
									<input type="password" class="form-control" id="userPasswordChk" placeholder="비밀번호 확인" disabled="disabled" style="margin-top: 10px">
								</div>

								<div class="data-input-box">
									<label for="userdName" class="form-label label-name">이름</label>
									<input type="text" class="form-control" id="userdName">
								</div>

								<div class="data-input-box">
									<label for="userBirth" class="form-label label-name">생년월일</label>
									<input type="text" class="form-control" id="userBirth">
									<%--<span style="font-size: 10pt;">연 1회 생일 축하 쿠폰이 발급됩니다.</span>--%>
									<div id="birthHelp" class="form-text" style="font-size: 10pt;">연 1회 생일 축하 쿠폰이 발급됩니다.</div>
								</div>

								<div class="data-input-box">
									<label for="userPhone" class="form-label label-name">Phone</label>
									<input type="text" class="form-control" id="userPhone" placeholder="전화번호를 입력하세요.">
									<%--<span style="font-size: 10pt;">인증번호를 요청하세요.</span>--%>
									<div id="phoneHelp" class="form-text" style="font-size: 10pt;">인증번호를 요청하세요.</div>
									<button type="button" class="btn btn-outline-warning auth-phone" >인증번호 요청</button>
									<input type="authPhone" class="form-control" id="authPhone" placeholder="인증번호 확인" disabled="disabled" style="margin-top: 25px">
								</div>

								<div class="data-input-box">
									<label for="userAddr" class="form-label label-name">주소</label>
									<input type="text" class="form-control" id="userAddr" placeholder="주소 검색" style="width: 80%;">
									<button type="button" class="btn btn-outline-warning addrApi" onclick="addrApi()">검색</button>
									<input type="text" class="form-control" id="userAddrDetail" placeholder="상세주소" style="margin-top: 25px">
								</div>

								<div class="data-input-box">
									<label for="userEmail" class="form-label label-name">Email</label>
									<input type="text" class="form-control" id="userEmail" name="userEmail" placeholder="이메일을 입력하세요.">
									<%--<span style="font-size: 10pt;">인증번호를 요청하세요.</span>--%>
									<div id="emailHelp" class="form-text" style="font-size: 10pt;">인증번호를 요청하세요.</div>
									<button type="button" class="btn btn-outline-warning auth-email" >인증번호 요청</button>
									<input type="authEmail" class="form-control" id="authEmail" placeholder="인증번호 확인" disabled="disabled" style="margin-top: 25px">
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