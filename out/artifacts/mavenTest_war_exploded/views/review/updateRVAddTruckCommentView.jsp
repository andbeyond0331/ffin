<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="x-UTF-16LE-BOM">

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>


    <!-- //////////cdn 옵션그룹추가////////////////-->

    <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>


    <!--  ///////////////////////// CSS ////////////////////////// -->
    <style>
        body {
            padding-top : 50px;
        }
    </style>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //============= "추가"  Event 연결 =============
        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $( "#updateRVAddTruckComment" ).on("click" , function() {
                fncUpdateRVAddTruckComment();
            });
        });

        //============= "취소"  Event 처리 및  연결 =============
        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("a[href='#' ]").on("click" , function() {
                $("form")[0].reset();
            });
        });

        function fncUpdateRVAddTruckComment(){

            var rvNo = $("input[name='rvNo']").val();

            $(".form-horizontal").attr("method", "POST").attr("action","/review/updateRVAddTruckComment?rvNo="+rvNo).submit();
        }

    </script>

</head>

<body>

<!-- ToolBar Start /////////////////////////////////////-->
<!-- ToolBar End /////////////////////////////////////-->

<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">
    <input type="hidden" id = "rvNo" name="rvNo" value="${review.rvNo}">

    <div class="page-header text-center">
        <h3 class=" text-info">${userId}님의 리뷰에 대한 사장님 댓글 등록</h3>
    </div>


        <div class="row">
            <div class="col-xs-4 col-md-2"><strong>고객 아이디</strong></div>
            <div class="col-xs-8 col-md-4">${userId}</div>
        </div>

        <hr/>

        <div class="row">
            <div class="col-xs-4 col-md-2 "><strong>리뷰 별점</strong></div>
            <div class="col-xs-8 col-md-4">${review.rvStar}</div>
        </div>

        <hr/>

        <div class="row">
            <div class="col-xs-4 col-md-2 "><strong>리뷰 내용</strong></div>
            <div class="col-xs-8 col-md-4">${review.rvContent}</div>
        </div>

        <hr/>

        <hr/>

    <!-- form Start /////////////////////////////////////-->
    <form class="form-horizontal">

        <div class="form-group">
            <label for="rvTruckCmtContent" class="col-sm-offset-1 col-sm-3 control-label">사장님 댓글 작성</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="rvTruckCmtContent" name="rvTruckCmtContent" value="${review.rvTruckCmtContent }" placeholder="사장님 댓글을 등록하세요.">

            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-4  col-sm-4 text-center">
                <button type="submit" class="btn btn-primary"  id="updateRVAddTruckComment">수 &nbsp;정</button>
                <a class="btn btn-primary btn" href="#" role="button">취 &nbsp;소</a>
            </div>
        </div>
    </form>


</div>


</body>



</html>


