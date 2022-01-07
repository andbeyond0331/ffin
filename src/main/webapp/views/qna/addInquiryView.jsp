<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">


<head>

	<title>F.FIN | 문의하기 </title>
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
					문의하기
				</h4>
			</div>
			<div style="margin-top: 50px;">
				<div class="row justify-content-center">

					<div class="col-md-6 data-input-box">

						<div class="data-input-box">
							<label for="inquiry-type" class="form-label label-name">문의유형</label>
							<select class="form-select form-control" id="inquiry-type" name="inquiry-type" aria-label="Default select example">
								<option selected>사이트 이용</option>
								<option value="1">푸드트럭</option>
								<option value="2">주문</option>
								<option value="3">기타</option>
							</select>
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