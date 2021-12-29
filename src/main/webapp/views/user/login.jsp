<%--
  Created by IntelliJ IDEA.
  User: songs
  Date: 2021-12-29
  Time: 오전 1:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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



	<%-- kakao login--%>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>


	<style>

		h4{
			color : #fd7622;
		}

		body{
			background-size: cover;
		}
	</style>

	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

		$(function () {

			console.log("lalalalala");

			//kakao Login
			Kakao.init('b729adcc43707d7099ee5f895c968b62');
			var id = "";
			$("#kakao-login-btn").on("click", function () {

				Kakao.Auth.login({
					success: function (authObj) {
						//console.log(JSON.stringify(authObj));
						//console.log(Kakao.Auth.getAccessToken());

						//2. 로그인 성공시, API를 호출합니다.
						Kakao.API.request({
							url: '/v2/user/me',
							success: function (res) {
								//console.log(JSON.stringify(res));
								id = res.kakao_account.email;

								$.ajax({
									url: "/user/json/checkDuplication/" + res.kakao_account.email,
									type : "GET",
									headers: {
										"Accept": "application/json",
										"Content-Type": "application/json"
									},
									success: function (idChk) {
										console.log("hey kakao");
										console.log(idChk);
										if (idChk === id) { //DB에 아이디가 없을 경우 => 회원가입
											console.log("회원가입중...");
											$.ajax({
												url: "views/user/addUser.jsp",
												method: "POST",
												headers: {
													"Accept": "application/json",
													"Content-Type": "application/json"
												},
												data: JSON.stringify({
													userId: res.kakao_account.email,
													userName: res.properties.nickname
													/*userPassword: "kakao123",*/
												}),
												success: function (JSONData) {
													console.log(JSONData)
													alert("회원가입이 정상적으로 되었습니다.");
													$("form").attr("method", "POST").attr("action", "/user/snsLogin/" + res.id).attr("target", "_parent").submit();
												}
											})
										}
										if (!(idChk === id)) { //DB에 아이디가 존재할 경우 => 로그인
											console.log("로그인중...");
											$("form").attr("method", "POST").attr("action", "/user/snsLogin/" + res.kakao_account.email).attr("target", "_parent").submit();
										}
									}
								})
							},
							fail: function (error) {
								alert(JSON.stringify(error));
							}
						});
					},
					fail: function (err) {
						alert(JSON.stringify(err));
					}
				});
			});
		});


		// login check
		$( function() {

			$("#userId").focus();

			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("button").on("click" , function() {
				var id=$("input:text").val();
				var pw=$("input:password").val();

				if(id == null || id.length <1) {
					alert('ID 를 입력하지 않으셨습니다.');
					$("#userId").focus();
					return;
				}

				if(pw == null || pw.length <1) {
					alert('패스워드를 입력하지 않으셨습니다.');
					$("#userPassword").focus();
					return;
				}

				$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
			});
		});


		// addUser Nav
		$( function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				self.location = "/user/addUser"
			});
		});

	</script>



</head>



<body id="page-top">

<jsp:include page="/views/toolbar.jsp" />
<div class="container">

	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-6">
			<br/><br/>
			<div >
				<form class="form-horizontal">
					<div class="form-group">
						<label for="userId" class="col-sm-4 control-label">아 이 디</label>
						<div class="col-sm-6">
							<input type="text" class="form-control" name="userId" id="userId"  placeholder="아이디" >
						</div>
					</div>

					<div class="form-group">
						<label for="userPassword" class="col-sm-4 control-label">패 스 워 드</label>
						<div class="col-sm-6">
							<input type="password" class="form-control" name="userPassword" id="userPassword" placeholder="패스워드" >
						</div>
					</div>

					<!-- 카카오 로그인 추가 -->
					<div id="kakaoLogin"  class="col-sm-offset-4 col-sm-6 text-center">
						<a id="kakao-login-btn">
							<img src="../../resources/image/kakao_login_medium_wide.png" width="100%"/>
						</a>
						<a href="http://developers.kakao.com/logout"></a>
					</div>

					<br/><br/><br/>

					<div class="form-group">
						<div class="col-sm-offset-4 col-sm-6 text-center">
							<button type="button" class="btn btn-warning"  >로 &nbsp;그 &nbsp;인</button>
							<a class="btn btn-warning btn" href="#" role="button">회 &nbsp;원 &nbsp;가 &nbsp;입</a>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>


<jsp:include page="/views/footer.jsp" />

</body>

</html>
