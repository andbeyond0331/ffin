<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="UTF-8">

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <title>게시물 작성</title>
    <!-- jQuery UI CSS 파일 -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css"/>
    <!-- jQuery 기본 js파일 -->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <!-- jQuery UI 라이브러리 js파일 -->
    <script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">
        function fncAddPost() {
            $("form").attr("method", "POST").attr("action", "/community/addPost").submit();
        }


        //============= "작 성 완 료"  Event 연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-primary").on("click", function () {
                fncAddPost();
            });
        });

        //============= "취소"  Event 처리 및  연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("a[href='#' ]").on("click", function () {
                self.location = "/views/community/getPostList.jsp"
            });
        });

    </script>

</head>

<body>
<div class="container">
    <div class="titleStyle">
        <h3 class=" text-info">게시물 작성</h3>
    </div>
    <form method="form-horizontal">


        <!-- 게시물 제목 입력란 -->
        <br/><br/>
        <div class="form-group">
            <label for="postTitle" class="col-sm-offset-1 col-sm-3 control-label">제목</label>

            <input id="postTitle" class="form-control" name="postTitle" placeholder="게시물 제목">
        </div>

        <!-- 게시물 내용 입력란 -->
        <br/><br/>
        <div class="form-group">
            <label for="postContent" class="col-sm-offset-1 col-sm-3 control-label">내용</label>

            <input id="postContent" class="form-control" name="postContent" placeholder="게시물 내용">
        </div>


        <!-- 게시물 파일 첨부란 -->
        <br/><br/>
        <div class="form-group">
            <label for="postFile1" class="col-sm-offset-1 col-sm-3 control-label">게시물 첨부파일</label>

            <input id="postFile1" class="form-control" name="postFile1" placeholder="게시물 첨부파일">
        </div>

        <br/>
        <h4>게시물 첨부파일 업로드</h4>
        업로드하실 파일을 선택하세요. <br/>
        <form action="./upload.jsp" method="post"
              enctype="multipart/form-data">
            <input type="file" name="file" size="50"/>
            <br/>
            <input type="submit" value="선택한 파일 업로드"/>
        </form>

        <br/><br/>
        <div class="form-group">
            <div class="col-sm-offset-4  col-sm-4 text-center">
                <button type="button" class="btn btn-primary">작 성 완 료</button>
                <a class="btn btn-primary btn" href="#" role="button">취 소</a>
            </div>
        </div>

    </form>

</div>
</body>
</html>