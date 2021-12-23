<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="euc-kr"%>


<!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="euc-kr">

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
    <script type="text/javascript">

        //============= "가입"  Event 연결 =============
        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $( "button.btn.btn-primary" ).on("click" , function() {
                fncAddTruck();
            });
        });

        //============= "취소"  Event 처리 및  연결 =============
    $(function() {
    //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
    $("a[href='#' ]").on("click" , function() {
        self.location = "/truck/loginTruck"
    });
    });


        function fncAddTruck() {

            var id=$("input[name='truckId']").val();
            var pw=$("input[name='truckPassword']").val();
            var pw_confirm=$("input[name='truckPasswordChk']").val();
            var name=$("input[name='truckCEOName']").val();


            if(id == null || id.length <1){
                alert("아이디는 반드시 입력하셔야 합니다.");
                return;
            }
            if(pw == null || pw.length <1){
                alert("패스워드는  반드시 입력하셔야 합니다.");
                return;
            }
            if(pw_confirm == null || pw_confirm.length <1){
                alert("패스워드 확인은  반드시 입력하셔야 합니다.");
                return;
            }
            if(name == null || name.length <1){
                alert("이름은  반드시 입력하셔야 합니다.");
                return;
            }

            if( pw != pw_confirm ) {
                alert("비밀번호 확인이 일치하지 않습니다.");
                $("input:text[name='truckPasswordChk']").focus();
                return;
            }

            // var value = "";
            // if( $("input:text[name='phone2']").val() != ""  &&  $("input:text[name='phone3']").val() != "") {
            //     var value = $("option:selected").val() + "-"
            //         + $("input[name='phone2']").val() + "-"
            //         + $("input[name='phone3']").val();
            // }
            //
            // $("input:hidden[name='phone']").val( value );

            $("form").attr("method" , "POST").attr("action" , "/truck/addTruck").submit();
        }
    </script>
    <!-- 푸드트럭 아이디 중복체크 -->
    <script type="text/javascript">
        $("#truckId").blur(function(){

            var truckId = $("#truckId").val();
            $.ajax({
                url : '${pageContext.request.contextPath}/truck/checkDuId?truckId='+ truckId,
                type : 'get',
                //cache : false,
                success : function(data) {

            if(truckId == "" || truckId.length < 2){
                $(".successIdChk").text("아이디는 2자 이상 입력해주세요.");
                $(".successIdChk").css("color", "red");
                $("#idDoubleChk").val("false");
            }else{

                        if (data == 0) {
                            $("#id_check").text("사용가능한 아이디입니다.");
                            $("#id_check").css("color", "green");
                            $("#idDoubleChk").val("true");
                        } else {
                            $("#id_check").text("사용중인 아이디입니다.");
                            $("#id_check").css("color", "red");
                            $("#idDoubleChk").val("false");
                        }
                    }, error : function() {
                        console.log("실패");
                    }
                }
            });
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

<div class="container">
    <div class="titleStyle">
        <h3 class=" text-info">푸드트럭(사업자) 회원가입</h3>
    </div>
<form method="POST">

<!-- 아이디 중복검사 -->
<div class="form-group">
    <label for = "truckId">아이디</label>
    <input type="text" class="form-control" id="truckId" name="truckId" placeholder="아이디를 입력하세요." required maxlength="10">
    <span class="point">※ 영문자, 소문자 입력가능, 최대 10자 까지 입력</span>
    <div class="check_font" id="id_check"></div>
</div>


<!-- 비밀번호 확인 -->
<br/><br/>
<tr>
    <th>
        <label for="truckPassword">비밀번호</label>
    </th>
    <td>
        <input id="truckPassword" type="password" name="truckPassword"  required maxlength="8" autocomplete="off"/>
        <span class="point">※ 비밀번호는 총 8자 까지 입력가능</span>
    </td>
</tr>
<br/><br/>
<tr>
    <th>
        <label for="truckPasswordChk">비밀번호 확인</label>
    </th>
    <td>
        <input id="truckPasswordChk" type="password" name="truckPasswordChk" placeholder="동일하게 입력해주세요." required maxlength="8" autocomplete="off"/>
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
        <input id="truckCEOName" class="form-control"  name="truckCEOName" placeholder="대표자이름">
        </div>
    </td>
</tr>

<!-- 트럭 대표자 생년월일 입력란 -->
<br/><br/>
<div class="form-group">
    <label for="truckCEOBirth" class="col-sm-offset-1 col-sm-3 control-label">생년월일</label>

        <input id="truckCEOBirth" class="form-control"  name="truckCEOBirth" placeholder="대표자 생년월일">
        &nbsp;

</div>

<br/>

<!-- 카카오(다음) 주소찾기 -->
<p>주소찾기</p>
<div>우편번호 입력란을 클릭하세요.</div>
<input id="member_post"  type="text" placeholder="우편번호 5자리" readonly onclick="findAddr()">
<input id="member_addr" type="text" placeholder="주소" readonly> <br>
<input type="text" placeholder="주소 상세">


<!-- 휴대폰번호 입력란 -->
<br/><br/>
<div class="form-group">
    <label for="truckPhone" class="col-sm-offset-1 col-sm-3 control-label">휴대폰번호</label>

    <input id="truckPhone" class="form-control"  name="truckPhone" placeholder="휴대폰번호">
</div>

<!-- 이메일 입력란 -->
<br/><br/>
<div class="form-group">
    <label for="truckEmail" class="col-sm-offset-1 col-sm-3 control-label">이메일</label>
    <div class="col-sm-4">
        <input type="text" class="form-control" id="truckEmail" name="truckEmail" placeholder="이메일">
    </div>
</div>

<!-- 푸드트럭 상호 입력란 -->
<br/><br/>
<div class="form-group">
    <label for="truckName" class="col-sm-offset-1 col-sm-3 control-label">푸드트럭상호</label>
    <div class="col-sm-4">
        <input type="text" class="form-control" id="truckName" name="truckName" placeholder="푸드트럭상호">
    </div>
</div>

<!-- 푸드트럭 사업자등록증 파일업로드란 -->
<br/><br/>
<div class="form-group">
    <label for="truckBusiLice" class="col-sm-offset-1 col-sm-3 control-label">사업자등록증</label>
    <div class="col-sm-4">
        <input type="text" class="form-control" id="truckBusiLice" name="truckBusiLice" placeholder="사업자등록증 파일업로드">
    </div>
</div>


<!-- 푸드트럭 카테고리 -->
<br/><br/>
<div class="form-group">
    <label for="truckCate" class="col-sm-offset-1 col-sm-3 control-label">푸드트럭 카테고리</label>
    <div class="col-sm-4">
        <input type="text" class="form-control" id="truckCate" name="truckCate" placeholder="푸드트럭 카테고리">
    </div>
</div>

<!-- 푸드트럭 프로필이미지 파일업로드란 -->
<br/><br/>
<div class="form-group">
    <label for="truckProImg" class="col-sm-offset-1 col-sm-3 control-label">프로필 이미지</label>
    <div class="col-sm-4">
        <input type="text" class="form-control" id="truckProImg" name="truckProImg" placeholder="프로필 이미지 파일업로드">
    </div>
</div>


<!-- 푸드트럭 사장님 한마디 -->
<br/><br/>
<div class="form-group">
    <label for="truckCEOIntro" class="col-sm-offset-1 col-sm-3 control-label">사장님 한마디</label>
    <div class="col-sm-4">
        <input type="text" class="form-control" id="truckCEOIntro" name="truckCEOIntro" placeholder="사장님 한마디">
    </div>
</div>




<br/><br/>
<div class="form-group">
    <div class="col-sm-offset-4  col-sm-4 text-center">
        <button type="button" class="btn btn-primary" >가 입</button>
        <a class="btn btn-primary btn" href="#" role="button">취 소</a>
    </div>
</div>


</form>
</form>
</div>
</body>






</html>

    <hr/>