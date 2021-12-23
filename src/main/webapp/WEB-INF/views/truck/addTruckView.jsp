<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>


<!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="utf-8">

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

</head>

<body>
<p>카카오(다음) 주소찾기</p>
<div>Company Address</div>
<input id="member_post"  type="text" placeholder="Zip Code" readonly onclick="findAddr()">
<input id="member_addr" type="text" placeholder="Address" readonly> <br>
<input type="text" placeholder="Detailed Address">
</body>
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
</html>
<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">

    <div class="page-header">
        <h3 class=" text-info">트럭회원가입</h3>
    </div>

    <form name="join">
        비밀번호 : <input type="password" id="password1">
        비밀번호확인 : <input type="password" id="password2">
        <input type="button" onclick="test()" value="회원가입">
    </form>

    <script type="text/javascript">
        function test() {
            var p1 = document.getElementById('password1').value;
            var p2 = document.getElementById('password2').value;

            if(p1.length < 6) {
                alert('입력한 글자가 6글자 이상이어야 합니다.');
                return false;
            }

            if( p1 != p2 ) {
                alert("비밀번호불일치");
                return false;
            } else{
                alert("비밀번호가 일치합니다");
                return true;
            }
        }
    </script>

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