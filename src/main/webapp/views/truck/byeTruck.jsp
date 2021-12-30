<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">


<head>
    <!-- Basic -->
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <!-- Mobile Metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <!-- Site Metas -->
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>

    <title>F.FIN | FOODTRUCK FINDER</title>

    <!-- bootstrap core css -->
    <link rel="stylesheet" type="text/css" href="../../resources/bootstrap/css/bootstrap.css"/>

    <!-- fonts style -->
    <link href="https://fonts.googleapis.com/css?family=Poppins:400,600,700&display=swap" rel="stylesheet">

    <!-- font awesome style -->
    <link href="../../resources/bootstrap/css/font-awesome.min.css" rel="stylesheet"/>
    <!-- nice select -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css"
          integrity="sha256-mLBIhmBvigTFWPSCtvdu6a76T+3Xyt+K571hupeFLg4=" crossorigin="anonymous"/>
    <!-- slidck slider -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css"
          integrity="sha256-UK1EiopXIL+KVhfbFa8xrmAWPeBjMVdvYMYkTAEv/HI=" crossorigin="anonymous"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css.map"
          integrity="undefined" crossorigin="anonymous"/>

    <!-- Custom styles for this template -->
    <link href="../../resources/bootstrap/css/style.css" rel="stylesheet"/>
    <!-- responsive style -->
    <link href="../../resources/bootstrap/css/responsive.css" rel="stylesheet"/>

    <!--    Favicons-->
    <link rel="apple-touch-icon" sizes="180x180" href="../../resources/bootstrap/assets/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="../../resources/bootstrap/assets/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../../resources/bootstrap/assets/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="../../resources/bootstrap/assets/favicons/favicon.ico">
    <link rel="manifest" href="../../resources/bootstrap/assets/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="../../resources/bootstrap/assets/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">

    <!-- jQery -->
    <script src="../../resources/bootstrap/js/jquery-3.4.1.min.js"></script>
    <!-- bootstrap js -->
    <script src="../../resources/bootstrap/js/bootstrap.js"></script>
    <!-- slick  slider -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.js"></script>
    <!-- nice select -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"
            integrity="sha256-Zr3vByTlMGQhvMfgkQ5BtWRSKBGa2QlspKYJnkjZTmo=" crossorigin="anonymous"></script>
    <!-- custom js -->
    <script src="../../resources/bootstrap/js/custom.js"></script>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //============= "탈 퇴"  Event 연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-primary").on("click", function () {
                fncByeTruck();
            });
        });

        function fncByeTruck() {
            // 유효성체크
            var pw = $("input[name='tPassword']").val();

            if (pw == null || pw.length < 4) {
                alert("패스워드를 반드시 확인받으셔야 합니다.");
                return;
            }
            $("form").attr("method", "POST").attr("action", "/truck/byeTruck").submit();
            alert("회원탈퇴 완료되었습니다. 그동안 저희 사이트를 이용해주셔서 감사합니다.");
                }

        // <!-- 회원탈퇴 전 Password 체크 -->
        $(function () {
            $("#tPassword").keyup(function () {
                var truckPassword = $("#tPassword").val();
                if (truckPassword == "" || truckPassword.length < 1) {
                    $(".successPwChk").text("본인확인을 위해 패스워드를 입력해주세요 :)");
                    $(".successPwChk").css("color", "red");
                    $("#pwDoubleChk").val("false");
                } else {
                    $.ajax({
                        url     : '/truck/checkDuPw/' + truckPassword,
                        type    : 'post',
                        data    : {},
                        success : function (data) {
                            //console.log("1::: "+data)
                            if (data == 'n') {
                                $(".successPwChk").text("패스워드가 일치합니다 :)");
                                $(".successPwChk").css("color", "blue");
                                $("#pwDoubleChk").val("true");
                            } else {
                                $(".successPwChk").text("패스워드가 일치하지 않습니다 :p");
                                $(".successPwChk").css("color", "red");
                                $("#pwDoubleChk").val("false");
                            }
                        }, error: function () {
                            console.log("실패");
                        }
                    });
                }
            })
        })


    </script>
</head>


<body id="page-top">

<jsp:include page="/views/toolbar.jsp"/>
<br/><br/>

<b><font size="6" color="gray">사업자 회원탈퇴</font></b>
<br><br><br>

<form name="deleteform" method="post" action="/truck/byeTruck?truckId=testTruckId"
      onsubmit="return checkValue()">

    <!-- 회원탈퇴 전 Password 체크 -->
    <div class="form-group">
        <label for="tPassword" class="col-sm-offset-1 col-sm-3 control-label">Password</label>
        <div class="col-sm-4">
            <input id="tPassword" type="password" name="tPassword" placeholder="패스워드를 입력해주세요." required maxlength="10"/>
            <span class="point successPwChk"></span><br/>
            <span class="point"></span>
            <input type="hidden" id="pwDoubleChk"/>
        </div>
    </div>

    <br>
    <button type="button" class="btn btn-primary">탈 퇴</button>
    <input type="button" value="취소" onclick="javascript:window.location='../home.jsp'">
</form>


<jsp:include page="/views/footer.jsp"/>

</body>

</html>
