<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>
    <style>
        strong {
            font-size: 17px;
            text-align: left;
        }

        .col-sm-6 {
            font-size: 17px;
            text-align: left;
        }

        img {
            display: block;
            margin: 0px;
        }

        .join-layout {
            display: flex;
            padding-top:20px ;
            justify-content:center ;
        }


    </style>

    <title>F.FIN | 푸드트럭(사업자) 회원탈퇴</title>
    <jsp:include page="../../common/lib.jsp"/>
    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
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
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //============= "탈 퇴"  Event 연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-secondary").on("click", function () {
                fncByeTruckChk();
            });
            $("button.btn.btn-primary").on("click", function () {
                fncByeTruck();
            });
            $("button.btn.btn-warning").on("click", function () {
                $('#exampleModal').modal('hide');
            });
            $("button.btn-close").on("click", function () {
                $('#exampleModal').modal('hide');
            });
            // <!-- 회원탈퇴 전 Password 체크 -->
            $("#tPassword").keyup(function () {

                if ($("#tPassword").val() == $("#truckPasswordS").val()) {
                    $(".successPw").text("비밀번호가 일치합니다.");
                    $(".successPw").css("color", "blue");
                    $("#pwDouble").val("true");
                } else {
                    $(".successPw").text("비밀번호가 일치하지 않습니다.");
                    $(".successPw").css("color", "red");
                    $("#pwDouble").val("false");
                }
            })

        });

        function fncByeTruckChk() {
            // 유효성체크
            var pw = $("input[name='tPassword']").val();

            if (pw == null || pw.length < 4) {
                alert("패스워드를 반드시 확인받으셔야 합니다.");
                return;
            }
            if ($("#pwDouble").val() == "true") {
                $('#exampleModal').modal('show');
            } else {
                alert("패스워드를 확인이 완료되어야 합니다.");
                return;
            }
        }

        function fncByeTruck() {

            $("form").attr("method", "POST").attr("action", "/truck/byeTruck").submit();
            alert("회원탈퇴 완료되었습니다. 그동안 저희 사이트를 이용해주셔서 감사합니다.");
        }

        function getValue(){

            console.log( '탈퇴사유 : '+$(":input:radio[name=truckByeReason]:checked").val() );
            session.set
            $("input[name=truckByeReason]:checked").each(function() {
                console.log( '탈퇴사유 : '+$(this).val() );
            });

        }

    </script>
</head>


<body id="page-top">

<jsp:include page="/views/navbar.jsp"/>
<br/><br/><br/><br/>


<div class="container">

    <div class="page-header" style="text-align: center">
        <label for="page-top"/>
        <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
        <h4 style="margin-top: 10px;">사업자 회원탈퇴</h4>
    </div>
    <br>
    <!-- 회원탈퇴 전 Password 체크 -->
    <form class="form-horizontal" style="border-radius:10px ; border: 0; box-shadow: 0 2px 4px 0 rgba(0,0,0,0.2); transition: 0.3s;">
        <div class="form-group join-layout">
            <div class="col-md-3" style="text-align: end; margin-top: 8px">
                <strong for="tPassword" class="col-sm-offset-1 col-sm-3 control-label">Password</strong>
            </div>
            <div class="col-sm-6">
                <input id="tPassword" type="password" name="tPassword" placeholder="패스워드를 입력해주세요." required
                       maxlength="10" class="form-control w-50"/>
                <span class="point successPw"></span><br/>
                <input type="hidden" id="truckPasswordS" name="truckPasswordS" value="${truck.truckPassword}"/>
                <input type="hidden" id="pwDouble"/>
            </div>
        </div>

        <hr/>

        <!-- 회원탈퇴사유 선택 -->
        <div class="form-group join-layout" align="center">
            <div class="col-md-3" style="text-align: end; margin-top: 8px">
            <strong for="truckByeReason" class="col-sm-offset-1 col-sm-3 control-label">탈퇴사유선택</strong>
            </div>
            <div class="col-sm-6">
            <input type="radio" name="truckByeReason" value="1">개인정보 유출 우려<br>
            <input type="radio" name="truckByeReason" value="2">수익 불만족<br>
            <input type="radio" name="truckByeReason" value="3">사이트를 통한 손님 유입 없음<br>
            <input type="radio" name="truckByeReason" value="4">방문 빈도가 낮음<br>
            <input type="radio" name="truckByeReason" value="5">기타<br>
            <input type="hidden" id="truckByeReason" name="truckByeReason">
            <button type="button" class="btn-dark" onclick="getValue()">탈퇴사유선택완료</button>
            </div>
        </div>
        <hr/>

        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">회원탈퇴 확인사항</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        탈퇴하시면 계정복구가 불가능합니다.
                        그래도 탈퇴하시겠습니까?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-warning" data-bs-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-primary">탈퇴</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Button trigger modal -->
        <div class="form-group" align="center">
            <div class="col-sm-offset-1  col-sm-10 text-center">
        <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#exampleModal">
            탈퇴하기
        </button>
        <input type="button" class="btn btn-dark" value="취소"
               onclick="javascript:window.location='/catering/mainTruckList'">
            </div>
        </div>
        <br/>
    </form>
</div>


    <jsp:include page="/views/footer.jsp"/>

</body>

</html>
