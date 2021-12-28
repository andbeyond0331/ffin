<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="EUC-KR">

	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

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
					$("#password").focus();
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

<body>

<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-default">
	<div class="container">
		<a class="navbar-brand" href="/home.jsp">F.FIN</a>
	</div>
</div>
<!-- ToolBar End /////////////////////////////////////-->

<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">
	<!--  row Start /////////////////////////////////////-->



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
						<label for="password" class="col-sm-4 control-label">패 스 워 드</label>
						<div class="col-sm-6">
							<input type="password" class="form-control" name="password" id="password" placeholder="패스워드" >
						</div>
					</div>

					<!-- 카카오 로그인 추가 -->
					<div id="kakaoLogin"  class="col-sm-offset-4 col-sm-6 text-center">
						<a id="kakao-login-btn">
							<img src="/resources/image/kakao_login_medium_wide.png" width="100%"/>
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
	<!--  row Start /////////////////////////////////////-->

</div>
<!--  화면구성 div end /////////////////////////////////////-->

</body>

</html>