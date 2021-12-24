<%@ page contentType="text/html;charset=UTF-8" language="java"   pageEncoding="UTF-8"%>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script
        src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">



<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<script type="text/javascript">

    function scrollUpDown(_document, _window){
        var scrollHeight = $(_document).height() - $(_window).height();

        $(_document.body).stop().animate({
            scrollTop: 0
        }, 500).animate({
            scrollTop: scrollHeight
        }, 2000).delay(200).animate({
            scrollTop: 0
        }, 2000);
    }

    window.scrollUpDown;

    $(document).ready(function(){

        $('.box-demo-button-wrapper button').on('click', function(){
            var iframe = $(this).parent().find('+ .box-demo').find('iframe')[0];

            scrollUpDown(iframe.contentDocument, iframe.contentWindow);
        });

    });

</script>
<style type="text/css">

    html,
    body {
        margin: 0; }
    .header {
        height: 80px;
        position: sticky;
        top: 0;
        background: burlywood; }
    .container {
        display: flex;
        flex-flow: row nowrap; }
    .content {
        width: 100%;
        height: 3000px;
        background: #f5f5f5; }
    .sidebar {
        width: 20%;
        height: 400px;
        position: sticky;
        top: 80px;
        background: yellowgreen; }
    .footer {
        background: #333;
        height: 200px; }



</style>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="header">Header</div>
<div class="container">
    <div class="content">Main content</div>
    <div class="sidebar">
        <table border=1>
            <tr>
                <td>메뉴이름</td>
                <td>${cart.odMenuName}</td>
                <td></td>
            </tr>
            <tr>
                <td>옵션그룹이름</td>
                <td>${cart.odOptionGroupName}</td>
                <td></td>
            </tr>
            <tr>
                <td>옵션이름</td>
                <td>${cart.odOptionName}</td>
                <td></td>
            </tr>
            <tr>
                <td>메뉴수량</td>
                <td>${cart.odMenuQty}</td>
                <td></td>
            </tr>
            <tr>
                <td>메뉴가격</td>
                <td>${cart.odMenuPrice}</td>
                <td></td>
            </tr>
            <tr>
                <td>옵션가격</td>
                <td>${cart.odOptionPrice}</td>
                <td></td>
            </tr>
            <tr>
                <td>메뉴이미지</td>
                <td>${cart.odMenuImage}</td>
                <td></td>
            </tr>
        </table>
    </div>
</div>
<div class="footer">Footer</div>

</body>



</html>
