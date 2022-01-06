<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">


<head>

	<title>F.FIN | 프로필</title>
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

	<%--주소API--%>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

	<style>


		#img_container > img{
			width: 100px;
			height: 100px;
		}

		.card-img{
			width: 100px;
			height: 100px;
		}
	</style>


	<script type="text/javascript">

		/* 수정 */
		$(function () {
			$("a[href='#' ]").click(function () {

				//alert(1234);

				var userId = $("#userId").val();
				var userFavMenu = $("#userFavMenu").val();
				var userFavPlace = $("#userFavPlace").val();
				var userFavPlaceDetail = $("#userFavPlaceDetail").val();
				var userIntro = $("#userIntro").val();

				console.log(userFavMenu+userFavPlace+userFavPlaceDetail+userIntro);

				$.ajax({
					type:"POST",
					url: "/user/json/updateUserProfile/"+userId,
					dataType: "json",
					contentType: "application/x-www-form-urlencoded; charset=UTF-8",
					data:{
						userId : userId,
						userFavMenu : userFavMenu,
						userFavPlace : userFavPlace,
						userFavPlaceDetail : userFavPlaceDetail,
						userIntro : userIntro
					},
					success: function (data) {
						alert("수정OK");
					}
				});
			});
		});

		/*프로필 수정*/
		$(function () {
			$(".pro-img").change(function () {
				alert(1234);

				$(".pro-img").attr("method", "POST").attr("action","/user/updateProImg").attr("enctype", "multipart/form-data").submit();

			});
		});


		/* Daum API */
		function addrApi(){
			new daum.Postcode({
				oncomplete: function(data) {

					/*alert(data);
					alert(data.roadAddress);*/

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
					$("#userFavPlace").val(addr);
					$("#userFavPlaceDetail").attr("readonly", false);
					$("#userFavPlaceDetail").focus();
				}
			}).open();
		}

	</script>
</head>

<body id="page-top">
<div>
<jsp:include page="/views/navbar.jsp" />
</div>
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
								프로필
							</h4>
						</div>
						<form class="row justify-content-center" id="user_pro_form" >
							<input type="hidden" id="userId" name="userId" value="${user.userId}">
							<div class="col-md-6 data-input-box">

									<div class="data-input-box">
										<%--<input type="text" class="form-control" id="userId" name="userId" placeholder="아이디">--%>
										<div class="mb-3">
											<%--<label for="fileName1" class="form-label">프로필 이미지</label>
											<div class="pro-img" style="margin-top: 5px; margin-bottom: 10px">
												<img src="../../resources/image/${user.userProImg}" class="img-thumbnail" alt="...">
											</div>
											<input class="form-control pro-img" type="file" id="fileName1" name="fileName1">--%>
											<button type="button" class="btn btn-outline-warning" id="update-img"><i class="fas fa-camera"></i></button>
										</div>
									</div>

								<div class="data-input-box">
									<label for="userFavPlace" class="form-label label-name">자주찾는 장소</label>
									<div>
										<input type="text" class="form-control" value="${user.userFavPlace}" id="userFavPlace" name="userFavPlace" placeholder="주소 검색" style="width: 80%; display: inline-block;">
										<button type="button" class="btn btn-outline-warning addrApi" onclick="addrApi()" style="width: auto;">&nbsp;검색&nbsp;</button>
									</div>
									<input type="text" class="form-control" value="${user.userFavPlaceDetail}" id="userFavPlaceDetail" placeholder="상세주소" style="margin-top: 8px">
								</div>

								<div class="data-input-box">
									<label for="userFavMenu" class="form-label label-name">좋아하는 메뉴</label>
									<select class="form-select form-control" id="userFavMenu" value="${user.userFavMenu}" name="userFavMenu" aria-label="Default select example" style="padding-left: 0;">
										<option selected>Menu Category</option>
										<option value="1">고기???</option>
										<option value="2">한식</option>
										<option value="3">분식</option>
										<option value="4">양식</option>
										<option value="5">일식</option>
										<option value="6">음료</option>
										<option value="7">디저트</option>
										<option value="8">기타</option>
									</select>
									<%--<div id="img_container">
										<img src="../../resources/image/menu1.jpg" id="menu1"/>
									</div>--%>
								</div>

								<div class="data-input-box">
									<label for="userIntro">한줄 소개</label>
									<textarea class="form-control label-name" id="userIntro" value="${user.userIntro}" style="resize: none; height: 100px"></textarea>
								</div>
							</div>
						</form>

						<div class="btn-box" style="margin-top: -40px;">
							<a onClick="history.go(-1);" style="margin-right: 10px;  background-color: #ecf0fd; border-color: #ecf0fd">
								취소
							</a>
							<a href="#">
								수정
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