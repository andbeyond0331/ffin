<%@ page contentType="text/html; charset=euc-kr" %>
    
    
    
<!DOCTYPE html>


<html lang="ko">

<head>
	<meta charset="EUC-KR">
	
	<title>회원가입</title>

	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
        
        div h3, div h5 {text-align: center;}
        
        label {
        	color : #6593A6;
        }

		.correct{
			color : greenyellow;
		}
		.incorrect{
			color: #d00000;
		}

        
     </style>

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<%--주소API--%>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


	<script type="text/javascript">

		$( function() {

			var code = "";
``
			/* 인증번호 이메일 전송 */
			$(".email-auth").click(function () {

				var inputEmail = $("#userEmail").val();
				var authInputBox = $(".mail-check-input");
				var boxWrap = $(".mail-check-input-box");

				alert(inputEmail);
				$.ajax({
					type:"GET",
					url:"/auth/json/emailAuth/"+inputEmail,
					success:function (data){
						//console.log("data : "+data);
						/*$("#userEmailAuth").attr("disabled",false);*/
						authInputBox.attr("disabled",false);
						boxWrap.attr("id", "mail-check-input-box-ture")
						code = data;
					}
				});
			});

			/* email 인증번호 비교 */
			$(".mail-check-input").on("keyup",function (){

				var inputCode = $(".mail-check-input").val();
				var checkResult = $("#mail-check-input-box-warn");
				/*console.log("inputCode"+inputCode);
				console.log("code"+code);*/
				if(inputCode.length >= 6){
					if(inputCode == code){
						checkResult.html("OK");
						checkResult.attr("class", "correct");
					}else {
						checkResult.html("NOPE");
						checkResult.attr("class","incorrect");
					}
				}

			});


			/* coolSMS */
			// $(".sms-auth").click(function (){
			//
			// 	alert("zzz...");
			// 	/*var code = "";*/
			// 	var userPhone = $("#userPhone").val();
			// 	$("form").attr("method","POST").attr("action", "/auth/sendSMS").submit();
			//
			// 	alert("인증번호가 전송되었습니다.");
			// });

		});

		/* Daum API */
		function addrApi(){
			new daum.Postcode({
				oncomplete: function(data) {

					alert(data);
					alert(data.roadAddress);

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
					$("#userAddr").val(addr);
					$("#userAddrDetail").attr("readonly", false);
					$("#userAddrDetail").focus();
				}
			}).open();
		}





</script>
</head>

<body>


 	<div class="container">
	
		<div class="page-header" >
	       <h3 class="text-info">회 원 가 입</h3>
	       <h5 class="text-muted">회원정보를 <strong class="text-danger">정확하게 입력</strong>해 주세요.</h5>
	    </div>
		
		<form class="form-horizontal">

			<div class="form-group">
			    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">ID</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="userId" name="userId" placeholder="ID">
			    </div>
			  </div>
			
			<hr/>
			
			<div class="form-group">
			    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">Password</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="userPassword" name="userPassword" placeholder="Password">
			    </div>
			  </div>
			
			<hr/>
			
			<div class="form-group">
			    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">이름</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="userName" name="userName" placeholder="이름">
			    </div>
			  </div>

			<hr/>
            <div class="form-group">
                <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">Phone</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="userPhone" name="userAddr" placeholder="핸드폰번호">
                </div>
                <div class="col-sm-3">
                    <button type="button" class="btn btn-warning sms-auth" >인증번호</button>
                </div>
            </div>
            <div class="form-group">
                <label for="userName" class="col-sm-offset-1 col-sm-3 control-label"></label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="userPhoneAuth" name="userPhoneAuth" placeholder="인증번호" disabled required>
                    <input type="hidden" name="text" id="authNum"><%--인증번호 hidden으로 전송--%>
                </div>
                <div class="col-sm-3">
                    <button type="button" class="btn btn-group-xs" id="userPhoneAuthNum">인 증</button>
                    <br/>
                    <span class="point successPhoneChk">휴대폰 번호를 먼저 입력해주세요.</span>
                </div>
            </div>
			<hr/>

			<div class="form-group">
				<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">주소</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="userAddr" name="userAddr" placeholder="주소검색" readonly="readonly">
				</div>
				<div class="col-sm-3">
					<button type="button" class="btn btn-success" onclick="addrApi()">주소검색</button>
				</div>
			</div>
			<div class="form-group">
				<label for="userName" class="col-sm-offset-1 col-sm-3 control-label"></label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="userAddrDetail" name="userAddrDetail" placeholder="상세주소를 입력해주세요" readonly="readonly">				</div>
			</div>

			<hr/>

			<div class="form-group">
				<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">Email</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="userEmail" name="userEmail" placeholder="Email" >
				</div>
				<div class="col-sm-3">
					<button type="button" class="btn btn-info email-auth">email인증</button>
				</div>
			</div>
			<div class="form-group mail-check-wrap">
				<label for="userName" class="col-sm-offset-1 col-sm-3 control-label"></label>
				<div class="col-sm-4 mail-check-input-box" id="mail-check-input-box-fail">
					<input type="text" class="form-control mail-check-input" id="userEmailAuth" name="userEmailAuth" placeholder="인증번호" disabled="disabled">
					<span id="mail-check-input-box-warn"></span>
					<div class="clearfix"></div>
				</div>
			</div>


			
			<hr/>


 		<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >가&nbsp;입</button>
			  <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
		    </div>
		</div>
		  
	</form>
	</div>
</body>
</html>