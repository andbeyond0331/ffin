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

	</style>

	<script type="text/javascript">

		$(function () {

			var userId = $("#userId").val();

			$('.user-info').click(function () {
				self.location = "./getUserInfo.jsp"
			});
			$('.user-profile').click(function () {
				self.location = "/user/getUserProfile/"+userId
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
			});
			$('.user-qna').click(function () {
				self.location = "/qna/getInquiryListByUser";
			});


		});

	</script>

</head>

<body>

<jsp:include page="/views/navbar.jsp" />
<div style="height: auto">
	<jsp:include page="/views/user/sidebar.jsp" />
</div>



<!-- client section -->
<section class="client_section layout_padding">

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
					<input type="hidden" id="userId" name ="userId" value="${user.userId}">
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
</section>
<jsp:include page="/views/footer.jsp" />
</body>
</html>