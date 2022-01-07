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

		#inquiryType{
			padding: inherit;
		}
		#inquiryFile{
			padding-top: 4px;
			padding-left: 4px;
		}

	</style>

	<script type="text/javascript">

		$(function () {

			/* 이미지 업로드 */
			$("input[type='file']").on("change", function(e){
				//alert("동작");

                let formData = new FormData();
                let fileInput = $('input[name="uploadFile"]');
                let fileList = fileInput[0].files;
                let fileObj = fileList[0];

                if(!fileCheck(fileObj.name, fileObj.size)){
                    return false;
                }

                formData.append("uploadFile", fileObj);
                //multi file
                // for(let i = 0; i < fileList.length; i++){
                //     formData.append("uploadFile", fileList[i]);
                // }

                $.ajax({
                    url: '/qna/json/uploadInquiryFile',
                    processData : false,
                    contentType : false,
                    data : formData,
                    type : 'POST',
                    dataType : 'json'
                });

                //alert("통과");

                console.log("fileList : " + fileList);
                console.log("fileObj : " + fileObj);

                console.log("fileName : " + fileObj.name);
                console.log("fileSize : " + fileObj.size);
                console.log("fileType(MimeType) : " + fileObj.type);

			});

            /* var, method related with attachFile */
            let regex = new RegExp("(.*?)\.(jpg|png)$");
            let maxSize = 1048576; //1MB

            function fileCheck(fileName, fileSize){

                if(fileSize >= maxSize){
                    alert("파일 사이즈 초과");
                    return false;
                }

                if(!regex.test(fileName)){
                    alert("해당 종류의 파일은 업로드할 수 없습니다.");
                    return false;
                }

                return true;
            }

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
	<form class="row justify-content-center" id="user_pro_form" >
		<input type="hidden" id="userId" name="userId" value="${user.userId}">
<%--		<input type="hidden" id="truckId" name="truckId" value="${truck.truckId}">--%>

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
						<div class="col-md-8 data-input-box">

							<div class="data-input-box">
								<label for="inquiryType" class="form-label label-name">문의유형</label>
								<select class="form-select form-control" id="inquiryType" name="inquiryType" aria-label="Default select example">
									<option selected style="color: grey">문의유형을 선택해주세요</option>
									<option value="1">사이트 이용</option>
									<option value="2">푸드트럭</option>
									<option value="3">주문</option>
									<option value="4">기타</option>
								</select>
							</div>
							<div class="data-input-box">
								<label for="inquiryTitle" class="form-label label-name">제목</label>
								<input type="text" class="form-control" id="inquiryTitle" name="inquiryTitle">
							</div>
							<div class="data-input-box">
								<label for="inquiryContent">내용</label>
								<textarea class="form-control label-name" id="inquiryContent" name="inquiryContent" style="resize: none; height: 100px"></textarea>
							</div>
							<div class="data-input-box">
								<label for="inquiryFile" class="form-label">첨부파일</label>
								<input class="form-control" type="file" id="inquiryFile" name="uploadFile" multiple>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</form>
</section>
<jsp:include page="/views/footer.jsp" />
</body>
</html>