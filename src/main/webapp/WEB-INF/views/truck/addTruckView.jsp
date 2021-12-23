<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>


<!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="utf-8">

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>푸드트럭(사업자) 회원가입</title>

    <!-- datepicker -->
    <!-- jQuery UI CSS 파일 -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
    <!-- jQuery 기본 js파일-->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <!-- jQuery UI 라이브러리 js파일 -->
    <script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>


    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script>
        $("#truckId").blur(function(){
            var sm_id = $("#truckId").val();
            if(sm_id == "" || sm_name.length < 2){
                $(".successIdChk").text("아이디를 입력해주세요.");
                $(".successIdChk").css("color", "red");
                $("#idDoubleChk").val("false");
            }else{
                $.ajax({
                    url : '${pageContext.request.contextPath}/idCheck?sm_id='+ sm_id,
                    type : 'post',
                    cache : false,
                    success : function(data) {
                        if (data == 0) {
                            $(".successIdChk").text("사용가능한 아이디입니다.");
                            $(".successIdChk").css("color", "green");
                            $("#idDoubleChk").val("true");
                        } else {
                            $(".successIdChk").text("사용중인 아이디입니다.");
                            $(".successIdChk").css("color", "red");
                            $("#idDoubleChk").val("false");
                        }
                    }, error : function() {
                        console.log("실패");
                    }
                });
            }
        });
    </script>



    <script>
        function findAddr(){
            new daum.Postcode({
                oncomplete: function(data) {

                    console.log(data);

                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                    // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var roadAddr = data.roadAddress; // 도로명 주소 변수
                    var jibunAddr = data.jibunAddress; // 지번 주소 변수
                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('member_post').value = data.zonecode;
                    if(roadAddr !== ''){
                        document.getElementById("member_addr").value = roadAddr;
                    }
                    else if(jibunAddr !== ''){
                        document.getElementById("member_addr").value = jibunAddr;
                    }
                }
            }).open();
        }
    </script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <script >

        $( function() {
            $( "#truckCEOBirth" ).datepicker({
                changeMonth : true,
                changeYear : true,
                nextText : '다음 달',
                prevText : '이전 달',
                dateFormat : "yy-mm-dd"
            });
        });

    </script>

</head>

<body>

<div class="page-header">
    <h3 class=" text-info">푸드트럭(사업자) 회원가입</h3>
</div>

<!-- 아이디 중복검사 -->
<br/>
<tr>
    <th>
        <label for="truckid">아이디</label>
    </th>
    <td>
        <input id="sm_id" type="text" name="sm_id" placeholder="아이디를 입력해주세요." required maxlength="10"/>
        <span class="point successIdChk"></span><br/>
        <span class="point">※ 영문자, 소문자 입력가능, 최대 10자 까지 입력</span>
        <input type="hidden" id="idDoubleChk"/>
    </td>
<tr/>

<!-- 비밀번호 확인 -->
<br/><br/>
<tr>
    <th>
        <label for="truckPassword">비밀번호</label>
    </th>
    <td>
        <input id="truckPassword" type="password" name="sm_pw"  required maxlength="8" autocomplete="off"/>
        <span class="point">※ 비밀번호는 총 8자 까지 입력가능</span>
    </td>
</tr>
<br/><br/>
<tr>
    <th>
        <label for="truckPasswordChk">비밀번호 확인</label>
    </th>
    <td>
        <input id="truckPasswordChk" type="password" name="sm_pw_chk" placeholder="동일하게 입력해주세요." required maxlength="8" autocomplete="off"/>
        <span class="point successPwChk"></span>
        <input type="hidden" id="pwDoubleChk"/>
    </td>
</tr>

<!-- 트럭 대표자 이름 입력란 -->
<br/><br/>
<tr>
    <th>
        <label for="truckCEOName" class="col-sm-offset-1 col-sm-3 control-label">이름</label>
    </th>
    <td>
        <input id="truckCEOName" class="form-control" id="truckCEOName" name="truckCEOName" placeholder="대표자이름">
        </div>
    </td>
</tr>

<!-- 트럭 대표자 생년월일 입력란 -->
<br/><br/>
<div class="form-group">
    <label for="truckCEOBirth" class="col-sm-offset-1 col-sm-3 control-label">생년월일</label>

        <input id="truckCEOBirth" class="form-control" id="truckCEOBirth" name="truckCEOBirth" placeholder="대표자 생년월일">
        &nbsp;

</div>

<br/>

<!-- 카카오(다음) 주소찾기 -->
<p>주소찾기</p>
<div>우편번호 입력란을 클릭하세요.</div>
<input id="member_post"  type="text" placeholder="우편번호 5자리" readonly onclick="findAddr()">
<input id="member_addr" type="text" placeholder="주소" readonly> <br>
<input type="text" placeholder="주소 상세">
</body>






</html>
<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">





    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>아 이 디</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckId}</div>



        <div class="col-xs-4 col-md-2"><strong>상 호</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckName}</div>
        <div class="col-xs-4 col-md-2"><strong>별 점</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckAVGStar}</div>
        <div class="col-xs-4 col-md-2"><strong>프 로 필 이 미 지</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckProImg}</div>
        <div class="col-xs-4 col-md-2"><strong>영 업 상 태</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckBusiStatus}</div>
        <div class="col-xs-4 col-md-2"><strong>전 화 번 호</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckPhone}</div>
        <div class="col-xs-4 col-md-2"><strong>위 도</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckMapLa}</div>
        <div class="col-xs-4 col-md-2"><strong>경 도</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckMapLo}</div>
        <div class="col-xs-4 col-md-2"><strong>공 지 내 용</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckNoticeContent}</div>
        <div class="col-xs-4 col-md-2"><strong>공 지 사 진</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckNoticeImg}</div>
    </div>

    <hr/>