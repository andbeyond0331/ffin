<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">


<head>

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
            $("button.btn.btn-danger").on("click", function () {
                alert("Password 변경을 취소하시겠습니까? 확인을 누르시면 이전화면으로 이동합니다.")
                self.location = "/truck/updateTruckInfo"
            });
        });


        function fncAddTruck() {
            // 유효성체크
            var passwordC = $("input[name='passwordC']").val();


            if (passwordC == null || passwordC.length < 1) {
                alert("기존 Password를 반드시 입력하셔야 합니다.");
                return;
            }

            $("form").attr("method", "GET").attr("action", "/views/truck/updateTruckPassword.jsp").submit();
            alert("Password 변경화면으로 이동합니다.");
        }









    </script>

</head>



<body id="page-top">

<jsp:include page="/views/navbar.jsp" />
<br/><br/><br/><br/>

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

                <button class="btn btn-danger">취소</button>
            </div>
        </div>
    </div>



<jsp:include page="/views/footer.jsp" />

</body>

</html>
