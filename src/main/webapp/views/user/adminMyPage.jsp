<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">


<head>

	<title>F.FIN | 회원관리</title>
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

		.box-icon ion-icon{
			height: 40px;
			width: 40px;
			color: #ffba49;
		}

	</style>

	<script type="text/javascript">

		$(function () {

			$('.userList').click(function () {
				self.location = "/user/getUserList"
			});
			$('.truckList').click(function () {
				self.location = "/truck/getTruckList"
			});
			$('.postList').click(function () {
				self.location = ""
			});
			$('.blackList').click(function () {
				self.location = "/user/getBlackList"
			});
			$('.truckAddList').click(function () {
				self.location = ""
			});
			$('.qnaList').click(function () {
				self.location = "/qna/getInquiryList"
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
					<div class="card userList" style="width: 12rem;">
						<div class="card-body" style="display: inline-grid;">
							<span class="box-icon"  style="text-align: initial;"><ion-icon name="accessibility-outline"></ion-icon></span>
							<h6 class="card-subtitle mb-2 text-muted" style="text-align: initial;">일반회원</h6>
							<p class="card-text" style="text-align: end;"><i class="fas fa-angle-double-right"></i></p>
						</div>
					</div>
					<div class="card truckList" style="width: 12rem;">
						<div class="card-body" style="display: inline-grid;">
							<span class="box-icon"  style="text-align: initial;"><ion-icon name="fast-food-outline"></ion-icon></span>
							<h6 class="card-subtitle mb-2 text-muted" style="text-align: initial;">사업자회원</h6>
							<p class="card-text" style="text-align: end;"><i class="fas fa-angle-double-right"></i></p>
						</div>
					</div>
					<div class="card postList" style="width: 12rem;">
						<div class="card-body" style="display: inline-grid;">
							<span class="box-icon"  style="text-align: initial;"><ion-icon name="desktop-outline"></ion-icon></span>
							<h6 class="card-subtitle mb-2 text-muted" style="text-align: initial;">게시글 관리</h6>
							<p class="card-text" style="text-align: end;"><i class="fas fa-angle-double-right"></i></p>
						</div>
					</div>
				</div>
				<div class="row justify-content-center">
					<div class="card blackList" style="width: 12rem;">
						<div class="card-body" style="display: inline-grid;">
							<span class="box-icon"  style="text-align: initial;"><ion-icon name="skull-outline"></ion-icon></span>
							<h6 class="card-subtitle mb-2 text-muted" style="text-align: initial;">블랙리스트</h6>
							<p class="card-text" style="text-align: end;"><i class="fas fa-angle-double-right"></i></p>
						</div>
					</div>
					<div class="card truckAddList" style="width: 12rem;">
						<div class="card-body" style="display: inline-grid;">
							<span class="box-icon"  style="text-align: initial;"><ion-icon name="receipt-outline"></ion-icon></span>
							<h6 class="card-subtitle mb-2 text-muted" style="text-align: initial;">가입승인</h6>
							<p class="card-text" style="text-align: end;"><i class="fas fa-angle-double-right"></i></p>
						</div>
					</div>
					<div class="card qnaList" style="width: 12rem;">
						<div class="card-body" style="display: inline-grid;">
							<span class="box-icon"  style="text-align: initial;"><ion-icon name="warning-outline"></ion-icon></span>
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