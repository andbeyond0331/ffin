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

		/* 이미지 미리보기 css */
		#img-card img{
			max-width: 100%;
			height: auto;
			display: block;
			padding: 5px;
			margin-top: 10px;
			margin: auto;
		}
		#img-card {
			position: relative;
			margin-top: 15px;
		}
		.imgDeleteBtn{
			position: absolute;
			top: 0;
			right: 5%;
			color: #f17228;
			font-weight: 900;
			width: 20px;
			cursor: pointer;
		}

		.imgDeleteBtn ion-icon{
			text-align: center;
			width: 25px;
			height: 25px;
		}


	</style>

	<script type="text/javascript">

		var inquiryTypeChk = false;
		var inquiryTitleChk = false;
		var inquiryContentChk = false;

		/* 문의등록 */
		$(function () {
			$("a[href='#' ]").click(function () {

				alert("등록");

				var inquiryType = $('#inquiryType').val();
				var inquiryTitle = $('#inquiryTitle').val();
				var inquiryContent = $('#inquiryContent').val();

				/* V/C */
				if(inquiryType === ""){
					$(".inquiryTypeChk").css("display","block");
					$('#inquiryType').css({
						"border-color" : "#ffba49",
						"box-shadow" : "0 0 0 0.1rem rgb(241, 114, 40)"
					});
					inquiryTypeChk = false;
				}else {
					inquiryTypeChk = true;
				}

				if(inquiryTitle === ""){
					$(".inquiryTitleChk").css("display","block");
					$('#inquiryTitle').css({
						"border-color" : "#ffba49",
						"box-shadow" : "0 0 0 0.1rem rgb(241, 114, 40)"
					});
					inquiryTitleChk = false;
				} else {
					inquiryTitleChk = true;
				}

				if(inquiryContent === ""){
					$(".inquiryContentChk").css("display","block");
					$('#inquiryContent').css({
						"border-color" : "#ffba49",
						"box-shadow" : "0 0 0 0.1rem rgb(241, 114, 40)"
					});
					inquiryContentChk = false;
				} else {
					inquiryContentChk = true;
				}

				if(inquiryTypeChk&&inquiryTitleChk&&inquiryContentChk){
					$("#addInquiry").attr("method", "POST").attr("action","/qna/addInquiry").attr("enctype","multipart/form-data").submit();
				}


			});
		});


		/* upload img function */
		$(function () {

			/* 이미지 존재시 삭제 */
			if($(".imgDeleteBtn").length > 0){
				deleteFile();
			}

			/* 이미지 업로드 */
			$("input[type='file']").on("change", function(e){
				//alert("동작");

                let formData = new FormData();
                let fileInput = $('input[name="uploadFile"]');
                let fileList = fileInput[0].files;
                let fileObj = fileList[0];

				/* 이미지 파일 체크 */
                if(!fileCheck(fileObj.name, fileObj.size)){
                    return false;
                }

				//1 file
                formData.append("uploadFile", fileObj);
                //multi file
                for(let i = 0; i < fileList.length; i++){
                    formData.append("uploadFile", fileList[i]);
                }

                /*$.ajax({
                    url: '/qna/json/uploadInquiryFile',
                    processData : false,
                    contentType : false,
                    data : formData,
                    type : 'POST',
                    dataType : 'json'
                });*/

				$.ajax({
					url: '/qna/json/uploadInquiryFile',
					processData : false,
					contentType : false,
					data : formData,
					type : 'POST',
					dataType : 'json',
					success : function(result){
						console.log("Image View return :: "+result);
						showUploadImage(result);
					},
					error : function(result) {
						alert("이미지 파일이 아닙니다.");
					}
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

			/* 이미지 출력 */
			function showUploadImage(uploadResultArr){

				/* 전달받은 데이터 검증 */
				if(!uploadResultArr || uploadResultArr.length == 0){return}
				let uploadResult = $(".uploadImg");
				let obj = uploadResultArr[0];
				let str = "";
				let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);

				str += "<div id='img-card'>";
				str += "<img src='/qna/json/displayImg?fileName=" + fileCallPath +"'>";
				str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'><ion-icon name='"+"close-outline"+"'></ion-icon></div>";
				str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
				str += "</div>";

				uploadResult.append(str);
			}

			/* 이미지 삭제 */
			function deleteFile(){
				let targetFile = $(".imgDeleteBtn").data("file");

				let targetDiv = $("#img-card");

				$.ajax({
					url: '/qna/json/deleteFile',
					data : {fileName : targetFile},
					dataType : 'text',
					type : 'POST',
					success : function(result){
						console.log(result);

						targetDiv.remove();
						$("input[type='file']").val("");
					},
					error : function(result){
						console.log(result);

						alert("파일 삭제 X")
					}
				});
			}

			/* 이미지 삭제 클릭 */
			$(".uploadImg").on("click", ".imgDeleteBtn", function(e){
				deleteFile();
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
	<form class="row justify-content-center" id="addInquiry" >
		<c:if test="${user.userId != null && truck.truckId == null}">
			<input type="hidden" id="inquiryId" name="inquiryId" value="${user.userId}">
			<input type="hidden" id="role" name="role" value="user">
		</c:if>
		<c:if test="${user.userId == null && truck.truckId != null}">
			<input type="hidden" id="inquiryId" name="inquiryId" value="${truck.truckId}">
			<input type="hidden" id="role" name="role" value="truck">
		</c:if>

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
								<span class="inquiryTypeChk" style="display: none;">문의유형을 선택해주세요.</span>
							</div>
							<div class="data-input-box">
								<label for="inquiryTitle" class="form-label label-name">제목</label>
								<input type="text" class="form-control" id="inquiryTitle" name="inquiryTitle">
								<span class="inquiryTitleChk" style="display: none;">제목을 입력해주세요.</span>
							</div>
							<div class="data-input-box">
								<label for="inquiryContent">내용</label>
								<textarea class="form-control label-name" id="inquiryContent" name="inquiryContent" style="resize: none; height: 100px"></textarea>
								<span class="inquiryContentChk" style="display: none;">내용을 입력해주세요.</span>
							</div>
							<div class="data-input-box">
								<label for="uploadFile" class="form-label">첨부파일</label>
								<input class="form-control" type="file" id="uploadFile" name="uploadFile" multiple>
								<%-- 업로드 이미지 미리보기 --%>
								<div class="uploadImg">
									<%--<div id="img-card">
										<div class="imgDeleteBtn"><ion-icon name="close-outline"></ion-icon></div>
										<img src="/qna/displayImg?fileName=moma.png">
									</div>--%>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	<div class="btn-box" style="margin-top: 40px;">
		<a onClick="history.go(-1);" style="margin-right: 10px;  background-color: #ecf0fd; border-color: #ecf0fd">
			취소
		</a>
		<a href="#">
			문의 등록
		</a>
	</div>
</section>
<jsp:include page="/views/footer.jsp" />
</body>
</html>