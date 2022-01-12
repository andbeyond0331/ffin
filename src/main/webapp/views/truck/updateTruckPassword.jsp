<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">


<head>

    <title>F.FIN | 푸드트럭(사업자) Password 수정</title>
    <jsp:include page="../../common/lib.jsp"/>
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">


        //============= "변경완료"  Event 연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-primary").on("click", function () {
                fncAddTruck();
            });
        });

        //============= "취소"  Event 처리 및  연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-danger").on("click", function () {
                alert("Password 변경을 취소하시겠습니까? 확인을 누르시면 이전화면으로 이동합니다.")
                self.location = "/truck/updateTruckInfo"
            });
        });


        function fncAddTruck() {
            // 유효성체크
            var pw = $("input[name='truckPassword']").val();
            var pw_confirm = $("input[name='truckPasswordChk']").val();

            if (pw == null || pw.length < 1) {
                alert("패스워드는 반드시 입력하셔야 합니다.");
                return;
            }
            if (pw_confirm == null || pw_confirm.length < 1) {
                alert("패스워드 확인은 반드시 입력하셔야 합니다.");
                return;
            }

            $("form").attr("method", "POST").attr("action", "/truck/updateTruckPassword").submit();
            alert("Password 변경이 완료되었습니다. 변경된 Password로 다시 로그인 해주세요.");
        }

        // <!-- 푸드트럭 비밀번호 체크 -->
        $(function () {
            $("#truckPasswordChk").keyup(function () {
                if ($("#tPassword").val() == $("#truckPasswordChk").val()) {
                    $(".successPwChk").text("비밀번호가 일치합니다.");
                    $(".successPwChk").css("color", "blue");
                    $("#pwDoubleChk").val("true");
                } else {
                    $(".successPwChk").text("비밀번호가 일치하지 않습니다.");
                    $(".successPwChk").css("color", "red");
                    $("#pwDoubleChk").val("false");
                }
            })
        });




    </script>

</head>



<body id="page-top">

<jsp:include page="/views/navbar.jsp" />
<br/><br/><br/><br/>
<form name="updatePasswored" class="form-horizontal">
<div class="container">
    <div class="area_inputs wow fadeIn">
        <div class="sub_title font-weight-bold">
            <h3>Password 변경</h3>
        </div>
        <!-- 비밀번호 확인 -->
        <div class="form-group">
            <label for="tPassword" class="col-sm-offset-1 col-sm-3 control-label">Password</label>
            <div class="col-sm-4">
                <input type="password" class="form-control" id="tPassword" name="truckPassword" placeholder="Password"
                       required maxlength="8"
                       autocomplete="off"/>
                <span class="point">※ 비밀번호는 총 8자 까지 입력가능</span><br/>
            </div>
        </div>

        <hr/>

        <div class="form-group">
            <label for="truckPasswordChk" class="col-sm-offset-1 col-sm-3 control-label">Password 확인</label>
            <div class="col-sm-4">
                <input id="truckPasswordChk" type="password" class="form-control" name="truckPasswordChk"
                       placeholder="동일하게 입력해주세요." required
                       maxlength="8" autocomplete="off"/>
                <span class="point successPwChk"></span>
                <input type="hidden" id="pwDoubleChk"/>
            </div>
        </div>
        <div class="form-group">
            <button id="searchBtn" type="button" onclick="idSearch_click()" class="btn btn-primary">변경완료</button>

            <button class="btn btn-danger">취소</button>
        </div>
    </div>
</div>
</form>

<jsp:include page="/views/footer.jsp" />

</body>

</html>
