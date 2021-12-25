<%@ page pageEncoding="EUC-KR"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="EUC-KR">

    <!-- 참조 : http://getbootstrap.com/css/   -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

    <title>HELLO</title>

    <script type="text/javascript">
        //============= 회원원가입 화면이동 =============
        $( function() {
            //==> 추가된부분 : "addUser"  Event 연결
            $("a[href='#' ]:contains('회원가입')").on("click" , function() {
                self.location = "views/user/addUser.jsp"
            });
        });

        //============= 로그인 화면이동 =============
        $( function() {
            //==> 추가된부분 : "addUser"  Event 연결
            $("a[href='#' ]:contains('로 그 인')").on("click" , function() {
                self.location = "views/user/login.jsp"
            });
        });
    </script>

</head>
<body>

    <div class="navbar  navbar-default">

        <div class="container">
            <a class="navbar-brand" href="#">F.FIN</a>
            <!-- toolBar Button Start //////////////////////// -->
            <div class="navbar-header">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
            </div>
            <!-- toolBar Button End //////////////////////// -->

            <div class="collapse navbar-collapse"  id="target">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#">회원가입</a></li>
                    <li><a href="#">로 그 인</a></li>
                </ul>
            </div>

        </div>
    </div>
</body>

</html>