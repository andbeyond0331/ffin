<%@ page contentType="text/html;charset=UTF-8" language="java"   pageEncoding="UTF-8"%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
<script type="text/javascript">
    $(function () {
        $(window).scroll(function () { //브라우저에 스크롤이 발생하는 순간부터
            var curpos = $(window).scrollTop()+20; //스크롤바의 상단 위치값+20 보관
            $(".sky").stop().animate({"top":curpos}); //스카이메뉴의 상단위치값 애니
        });
    });
</script>
<style type="text/css">
    * {
        padding:0;
        margin:0;
    }
    .box {
        position:relative;
        width:400px;
        margin:auto;
        background:#ccc;
        height:3000px;
    }
    .sky {
        position:absolute;
        width:100px;
        left:100%;
        top:20px;
        background:#f00;
        height:200px;
    }
</style>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="box">
    <p class="sky"></p>
</div>
</body>
</html>
