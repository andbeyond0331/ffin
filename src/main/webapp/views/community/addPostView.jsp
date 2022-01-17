<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>

    <title>게시글 작성</title>
    <jsp:include page="../../common/lib.jsp"/>
    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //============= "작성완료"  Event 연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-secondary").on("click", function () {
                fncAddPost();
            });
        });

        //============= "취소"  Event 처리 및  연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-warning").on("click", function () {
                self.location = "/community/getPostList"
            });
        });

        function fncAddPost() {
            // 유효성체크
            var title = $("input[name='postTitle']").val();
            var content = $("textarea[name='postContent']").val();

            if (title == null || title.length < 1) {
                alert("게시물 제목은 반드시 입력하셔야 합니다.");
                return;
            }
            if (content == null || content.length < 1) {
                alert("게시물 내용은 반드시 입력하셔야 합니다.");
                return;
            }
            $("form").attr("method", "POST").attr("action", "/community/addPost").attr("enctype", "multipart/form-data").submit();
            alert("게시물 작성이 완료되었습니다.");
        }


    </script>

</head>


<body id="page-top">

<jsp:include page="/views/navbar.jsp"/>
<br/><br/><br/><br/>
<c:if test="${sessionScope.user != null || sessionScope.truck != null}">
<div class="container">

<div class="page-header">
    <label for="page-top" class="col-sm-offset-4 control-label"/>
    <h3 class="text-info">게시글 작성</h3>

</div>

<form class="form-horizontal">
<!-- 게시판 글쓰기 양식 영역 시작 -->
<div class="form-group">
    <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
        <tbody>
        <tr>
            <td><input id="postTitle" type="text" class="form-control" placeholder="게시글 제목" name="postTitle"
                       maxlength="50"></td>
        </tr>
        <tr>
            <td><textarea id="postContent" class="form-control" placeholder="게시글 내용" name="postContent" maxlength="3000"
                          style="height: 350px;"></textarea></td>
        </tr>
        <!-- 푸드트럭 사업자등록증 파일업로드란 -->
        <td>
            <label for="inputFile" class="col-sm-2 col-form-label"><strong>첨부 파일</strong></label>
            <input id="file1" type="file" name="file1" class="form-control-file"/>
            <input id="file2" type="file" name="file2" class="form-control-file"/>
            <input id="file3" type="file" name="file3" class="form-control-file"/></td>


        </tbody>
    </table>
</div>
<!-- 게시판 글쓰기 양식 영역 끝 -->

    <br/>
    <div class="form-group">
    <div class="col-sm-offset-6 col-sm-6 text-center">
    <button type="button" class="btn btn-secondary">작 성 완 료</button>
    <button class="btn btn-warning" type="button">취 소</button>
    </div>
    </div>
    </form>

    </div>
</c:if>
<c:if test="${sessionScope.user == null && sessionScope.truck == null}">
<div class="col-sm-offset-6 text-center">
    <h3>회원가입 이후 게시판을 이용하실 수 있습니다</h3>
    <br/><br/>
    <a href="/views/user/addUserInfo.jsp" class="btn-warning">일반회원가입</a>
    <a href="/views/truck/addTruckView.jsp" class="btn-warning">사업자회원가입</a>
    <a href="/catering/mainTruckList" class="btn-warning">메인화면으로</a>
</div>
</c:if>
    <jsp:include page="/views/footer.jsp"/>

    </body>

    </html>
