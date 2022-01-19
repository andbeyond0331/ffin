<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">

<head>

    <title>F.FIN | 푸드트럭(사업자) Password 수정 전 확인</title>
    <jsp:include page="../../common/lib.jsp"/>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">
        //============= "확인"  Event 연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-primary").on("click", function () {
                fncAddTruck();
            });
        });
        //============= "취소"  Event 처리 및  연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("#beforeCancel").on("click", function () {
                alert("Password 변경을 취소하시겠습니까? 확인을 누르시면 메인화면으로 이동합니다.")
                window.location = "/catering/mainTruckList"
            });
        });
        function fncAddTruck() {
            // 유효성체크
            var passwordC = $("input[name='passwordC']").val();
            var originPassword = ${sessionScope.truck.truckPassword};
            if (passwordC == null || passwordC.length < 1) {
                alert("기존 Password를 반드시 입력하셔야 합니다.");
                return;
            }
            if(passwordC == originPassword) {
                $("form").attr("method", "POST").attr("action", "/truck/updateTruckPasswordB").submit();
                alert("Password 변경화면으로 이동합니다.");
            }else{
                alert("Password가 일치하지 않습니다");
                return;
            }
        }
    </script>

</head>



<body id="page-top">

<jsp:include page="/views/navbar.jsp" />
<br/><br/><br/><br/>
<form name="updateP" class="form-horizontal">
    <div class="container">
        <div class="area_inputs wow fadeIn">
            <div class="sub_title font-weight-bold">
                <h3>기존 Password 확인</h3>
            </div>
            <div class="form-group">
                <label class="font-weight-bold" for="passwordC">기존 Password 확인 후 변경이 가능합니다 :)</label>
                <div>
                    <input type="password" class="form-control" id="passwordC" name="passwordC"
                           placeholder="현재 사용중인 Password를 입력하세요">
                </div>
            </div>
            <div class="form-group">
                <button id="searchBtn" type="button" onclick="idSearch_click()" class="btn btn-primary">확인</button>

                <button class="btn btn-danger" id="beforeCancel">취소</button>
            </div>
        </div>
    </div>
</form>



<jsp:include page="/views/footer.jsp" />

</body>

</html>