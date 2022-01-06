<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">


<head>

	<title>F.FIN | FOODTRUCK FINDER | MyPage</title>
	<jsp:include page="../../common/lib.jsp"/>


	<style>

		.card{
			margin: 15px;
			border-color: #ffffff;
			box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
			transition: 0.3s;
		}
		.card:hover {
			border-color: #ffe537;
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

</head>

<body>

<jsp:include page="/views/navbar.jsp" />

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
			<div class="row justify-content-center" id="user-my-page">

				<div class="col-sm-4 data-input-box">
					<div class="card" style="width: 14rem;">
						<div class="card-body">
							<span class="box-icon"><i class="fas fa-user-alt page-icon fa-2x"></i></span>
							<h6 class="card-subtitle mb-2 text-muted">내정보</h6>
							<a href="./getUserInfo.jsp" class="card-link" style="float: right"><i class="fas fa-angle-double-right"></i></a>
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
							<h6 class="card-subtitle mb-2 text-muted">프로필</h6>
							<a href="./getUserProfile.jsp" class="card-link" style="float: right"><i class="fas fa-angle-double-right"></i></a>
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
							<span class="box-icon"><i class="fas fa-edit fa-2x"></i></span>
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
							<span class="box-icon"><i class="fas fa-question-circle fa-2x"></i></span>
							<h6 class="card-subtitle mb-2 text-muted">문의•신고</h6>
							<a href="#" class="card-link" style="float: right"><i class="fas fa-angle-double-right"></i></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

</body>
</html>