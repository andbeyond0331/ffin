<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">

<head>

    <title>F.FIN | 푸드트럭(사업자) Password 수정 전 확인</title>
    <jsp:include page="../../common/lib.jsp"/>

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <!-- bootstrap core css -->
    <link rel="stylesheet" type="text/css" href="../../resources/bootstrap/css/bootstrap.css"/>
    <!-- Custom styles for this template -->
    <link href="../../resources/bootstrap/css/style.css" rel="stylesheet"/>

    <!--    Favicons-->
    <link rel="apple-touch-icon" sizes="180x180" href="../../resources/bootstrap/assets/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="../../resources/bootstrap/assets/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../../resources/bootstrap/assets/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="../../resources/bootstrap/assets/favicons/favicon.ico">
    <link rel="manifest" href="../../resources/bootstrap/assets/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="../../resources/bootstrap/assets/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">
        //============= "확인"  Event 연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("#checkP").on("click", function () {
                fncAddTruck();
            });
        });
        //============= "취소"  Event 처리 및  연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("#cp").on("click", function () {
                alert("Password 변경을 취소하시겠습니까? 확인을 누르시면 마이페이지로 이동합니다.")
                window.location = "/views/truck/truckMyPage.jsp"
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
            if (passwordC == originPassword) {
                $("form").attr("method", "POST").attr("action", "/truck/updateTruckPasswordB").submit();
                alert("Password 변경화면으로 이동합니다.");
            } else {
                alert("Password가 일치하지 않습니다");
                return;
            }
        }
    </script>

</head>


<body id="page-top">

<jsp:include page="/views/navbar.jsp"/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/>

<div class="container">
    <div class="page-header" style="text-align: center">
        <label for="page-top"/>
        <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
        <h4 style="margin-top: 10px;">기존 Password 확인</h4>
    </div>
    <br/>
    <form name="updateP" class="form-horizontal" style="text-align: center">
        <div class="form-group">
            <label class="font-weight-bold" for="passwordC">기존 Password 확인 후 변경이 가능합니다 :)</label>
            <div class="col-md-8 offset-4">
                <input type="password" class="form-control w-50" id="passwordC" name="passwordC"
                       placeholder="현재 사용중인 Password를 입력하세요">
            </div>
        </div>
        <br/>
        <div class="form-group">
            <button id="checkP" type="button" class="btn btn-default">확인</button>

            <button class="btn btn-cancle" type="button" id="cp">취소</button>
        </div>
    </form>
</div>

<br/><br/><br/><br/>
<jsp:include page="/views/footer.jsp"/>

</body>

</html>