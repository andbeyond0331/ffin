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

	<style>

		.card{
			margin: 15px;
			border-color: #ffffff;
			box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
			transition: 0.3s;
		}
		.card:hover {
			border-color: #ffe537;
			border-width: 3px;
			box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
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
								활동내역
							</h4>
						</div>
						<div class="row justify-content-center" id="user-my-page">

							<div class="col-sm-4 data-input-box">
								<div class="card" style="width: 14rem;">
									<div class="card-body">
										<span class="box-icon"><i class="fas fa-user-alt page-icon fa-2x"></i></span>
										<h6 class="card-subtitle mb-2 text-muted">프사</h6>
										<a href="#" class="card-link" style="float: right"><i class="fas fa-angle-double-right"></i></a>
									</div>
								</div>
								<div class="card" style="width: 14rem;">
									<div class="card-body">
										<span class="box-icon"><i class="fas fa-donate fa-2x"></i></span>
										<h6 class="card-subtitle mb-2 text-muted">적립금</h6>
										<a href="#" class="card-link" style="float: right"><i class="fas fa-angle-double-right"></i></a>
									</div>
								</div>
								<div class="card" style="width: 14rem;">
									<div class="card-body">
										<span class="box-icon"><i class="fas fa-star-half-alt fa-2x"></i></span>
										<h6 class="card-subtitle mb-2 text-muted">리뷰</h6>
										<a href="#" class="card-link" style="float: right"><i class="fas fa-angle-double-right"></i></a>
									</div>
								</div>
							</div>
							<div class="col-sm-4 data-input-box">
								<div class="card" style="width: 14rem;">
									<div class="card-body">
										<span class="box-icon"><i class="fas fa-user-alt page-icon fa-2x"></i></span>
										<h6 class="card-subtitle mb-2 text-muted">내정보</h6>
										<a href="#" class="card-link" style="float: right"><i class="fas fa-angle-double-right"></i></a>
									</div>
								</div>
								<div class="card" style="width: 14rem;">
									<div class="card-body">
										<span class="box-icon"><i class="far fa-money-bill-alt fa-2x"></i></span>
										<h6 class="card-subtitle mb-2 text-muted">쿠폰</h6>
										<a href="#" class="card-link" style="float: right"><i class="fas fa-angle-double-right"></i></a>
									</div>
								</div>
								<div class="card" style="width: 14rem;">
									<div class="card-body">
										<span class="box-icon"><i class="fas fa-angle-down fa-2x"></i></span>
										<h6 class="card-subtitle mb-2 text-muted">글•댓글</h6>
										<a href="#" class="card-link" style="float: right"><i class="fas fa-angle-double-right"></i></a>
									</div>
								</div>
							</div>
							<div class="col-sm-4 data-input-box">
								<div class="card" style="width: 14rem;">
									<div class="card-body">
										<span class="box-icon"><i class="fas fa-shopping-basket fa-2x"></i></span>
										<h6 class="card-subtitle mb-2 text-muted">구매내역</h6>
										<a href="#" class="card-link" style="float: right"><i class="fas fa-angle-double-right"></i></a>
									</div>
								</div>
								<div class="card" style="width: 14rem;">
									<div class="card-body">
										<span class="box-icon"><i class="fas fa-heart fa-2x"></i></span>
										<h6 class="card-subtitle mb-2 text-muted">좋아요</h6>
										<a href="#" class="card-link" style="float: right"><i class="fas fa-angle-double-right"></i></a>
									</div>
								</div>
								<div class="card" style="width: 14rem;">
									<div class="card-body">
										<span class="box-icon"><i class="fas fa-angle-down fa-2x"></i></span>
										<h6 class="card-subtitle mb-2 text-muted">문의•신고</h6>
										<a href="#" class="card-link" style="float: right"><i class="fas fa-angle-double-right"></i></a>
									</div>
								</div>
							</div>


						</div>

						<%--<div class="btn-box">
							<a href="#">
								가입하기
							</a>
						</div>--%>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<jsp:include page="/views/footer.jsp" />

</body>
</html>