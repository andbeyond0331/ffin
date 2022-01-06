<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">


<head>

	<title>F.FIN | MyPage</title>
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

		.card{
			margin: 15px;
			border-color: #ffffff;
			box-shadow: 0 2px 4px 0 rgba(0,0,0,0.2);
			transition: 0.3s;
		}
		.card:hover {
			border-color: #ffe537;
			box-shadow: 0 3px 5px 0 rgba(0,0,0,0.2);
		}

		.box-icon{
			background-color: #ffffff;
		}

		.fas.fa-user-alt.page-icon{
			margin-left: 6px;
			color: #ffba49;
		}

		.card-subtitle{
			margin-top: 15px;
			font-weight: bold;
		}

		.list{
			text-align: initial;
		}

		.sidebar-div{
			margin: 0;
			padding: 0;
			box-sizing: border-box;
			font-family: "Noto Sans CJK KR Regular", sans-serif;
		}

		.sidebar-user{
			min-height: 1vh;
			background: white;
		}

/*		.sidebar-div{
			position: fixed;
			top: 20px;
			left: 20px;
			bottom: 20px;
			width: 300px;
			background: #ecf0fd;
		}*/
	</style>

	<script type="text/javascript">

		$(function () {

			$('.user-info').click(function () {
				self.location = "./getUserInfo.jsp"
			});
			$('.user-profile').click(function () {
				self.location = "./getUserProfile.jsp"
			});
			$('.user-purchase').click(function () {
				self.location = ""
			});
			$('.user-point').click(function () {
				self.location = ""
			});
			$('.user-coupon').click(function () {
				self.location = ""
			});
			$('.user-heart').click(function () {
				self.location = ""
			});
			$('.user-review').click(function () {
				self.location = ""
			});
			$('.user-post').click(function () {
				self.location = ""
			});$('.user-qna').click(function () {
				self.location = ""
			});


		});

	</script>

</head>

<body>

<jsp:include page="/views/navbar.jsp" />






<!-- client section -->
<section class="client_section layout_padding">
	<div style="display: flex;">
	<!-- sidebar -->
	<div class="navigation col-sm sidebar-div">
		<ul class="sidebar-user">
			<li class="list">
				<a href="#">
					<span class="icon"><ion-icon name="home-outline"></ion-icon></span>
					<span class="title">Home</span>
				</a>
			</li>
			<li class="list">
				<a href="#">
					<span class="icon"><ion-icon name="person-circle-outline"></ion-icon></span>
					<span class="title">내정보</span>
				</a>
			</li>
			<li class="list">
				<a href="#">
					<span class="icon"><ion-icon name="chatbubbles-outline"></ion-icon></span>
					<span class="title">채팅</span>
				</a>
			</li>
			<li class="list">
				<a href="#">
					<span class="icon"><ion-icon name="cart-outline"></ion-icon></span>
					<span class="title">구매</span>
				</a>
			</li>
			<li class="list">
				<a href="#">
					<span class="icon"><ion-icon name="heart-outline"></ion-icon></span>
					<span class="title">좋아요</span>
				</a>
			</li>
			<li class="list">
				<a href="#">
					<span class="icon"><ion-icon name="star-half-outline"></ion-icon></span>
					<span class="title">리뷰</span>
				</a>
			</li>
			<li class="list">
				<a href="#">
					<span class="icon"><ion-icon name="reader-outline"></ion-icon></span>
					<span class="title">글•댓글</span>
				</a>
			</li>
			<li class="list">
				<a href="#">
					<span class="icon"><ion-icon name="help-outline"></ion-icon></span>
					<span class="title">문의•신고</span>
				</a>
			</li>
		</ul>
	</div>
	<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
	<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>


	<div class="container">
		<div class="col-md-11 col-lg-10 mx-auto">
			<div class="detail-box">
				<i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
				<h4 style="margin-top: 10px;">
					활동내역
				</h4>
			</div>
			<div style="margin-top: 50px;">
				<div class="row justify-content-center">
					<div class="card user-info" style="width: 12rem;">
						<div class="card-body" style="display: inline-grid;">
							<span class="box-icon"  style="text-align: initial;"><i class="fas fa-smile page-icon fa-2x"></i></span>
							<h6 class="card-subtitle mb-2 text-muted" style="text-align: initial;">내정보</h6>
							<p class="card-text" style="text-align: end;"><i class="fas fa-angle-double-right"></i></p>
						</div>
					</div>
					<div class="card user-profile" style="width: 12rem;">
						<div class="card-body" style="display: inline-grid;">
							<span class="box-icon"  style="text-align: initial;"><i class="fas fa-robot page-icon fa-2x"></i></span>
							<h6 class="card-subtitle mb-2 text-muted" style="text-align: initial;">프로필</h6>
							<p class="card-text" style="text-align: end;"><i class="fas fa-angle-double-right"></i></p>
						</div>
					</div>
					<div class="card user-purchase" style="width: 12rem;">
						<div class="card-body" style="display: inline-grid;">
							<span class="box-icon"  style="text-align: initial;"><i class="fas fa-shopping-basket fa-2x"></i></span>
							<h6 class="card-subtitle mb-2 text-muted" style="text-align: initial;">구매</h6>
							<p class="card-text" style="text-align: end;"><i class="fas fa-angle-double-right"></i></p>
						</div>
					</div>
				</div>
				<div class="row justify-content-center">
					<div class="card user-point" style="width: 12rem;">
						<div class="card-body" style="display: inline-grid;">
							<span class="box-icon"  style="text-align: initial;"><i class="fas fa-donate fa-2x"></i></span>
							<h6 class="card-subtitle mb-2 text-muted" style="text-align: initial;">적립금</h6>
							<p class="card-text" style="text-align: end;"><i class="fas fa-angle-double-right"></i></p>
						</div>
					</div>
					<div class="card user-coupon" style="width: 12rem;">
						<div class="card-body" style="display: inline-grid;">
							<span class="box-icon"  style="text-align: initial;"><i class="far fa-money-bill-alt fa-2x"></i></span>
							<h6 class="card-subtitle mb-2 text-muted" style="text-align: initial;">쿠폰</h6>
							<p class="card-text" style="text-align: end;"><i class="fas fa-angle-double-right"></i></p>
						</div>
					</div>
					<div class="card user-heart" style="width: 12rem;">
						<div class="card-body" style="display: inline-grid;">
							<span class="box-icon"  style="text-align: initial;"><i class="fas fa-heart fa-2x"></i></span>
							<h6 class="card-subtitle mb-2 text-muted" style="text-align: initial;">좋아요</h6>
							<p class="card-text" style="text-align: end;"><i class="fas fa-angle-double-right"></i></p>
						</div>
					</div>
				</div>
				<div class="row justify-content-center">
					<div class="card user-review" style="width: 12rem;">
						<div class="card-body" style="display: inline-grid;">
							<span class="box-icon"  style="text-align: initial;"><i class="fas fa-star-half-alt fa-2x"></i></span>
							<h6 class="card-subtitle mb-2 text-muted" style="text-align: initial;">리뷰</h6>
							<p class="card-text" style="text-align: end;"><i class="fas fa-angle-double-right"></i></p>
						</div>
					</div>
					<div class="card user-post" style="width: 12rem;">
						<div class="card-body" style="display: inline-grid;">
							<span class="box-icon"  style="text-align: initial;"><i class="fas fa-edit fa-2x"></i></span>
							<h6 class="card-subtitle mb-2 text-muted" style="text-align: initial;">글•댓글</h6>
							<p class="card-text" style="text-align: end;"><i class="fas fa-angle-double-right"></i></p>
						</div>
					</div>
					<div class="card user-qna" style="width: 12rem;">
						<div class="card-body" style="display: inline-grid;">
							<span class="box-icon"  style="text-align: initial;"><i class="fas fa-question-circle fa-2x"></i></span>
							<h6 class="card-subtitle mb-2 text-muted" style="text-align: initial;">문의•신고</h6>
							<p class="card-text" style="text-align: end;"><i class="fas fa-angle-double-right"></i></p>
						</div>
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