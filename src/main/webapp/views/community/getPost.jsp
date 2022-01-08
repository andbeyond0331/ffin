<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">

<head>

    <title>게시글 조회</title>
    <jsp:include page="../../common/lib.jsp"/>

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!-- ajax 모듈 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

    <!-- moment -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

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
            $("a[href='#' ]").on("click", function () {
                self.location = "/views/community/getPostList.jsp"
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

        //댓글 목록 출력 함수
        <%--function listReply() {--%>
        <%--    alert("listReply function excute");--%>
        <%--    $.ajax({--%>
        <%--        type   : "get", //get방식으로 자료를 전달한다--%>
        <%--        url    : "/community/getCommentList?commentPostNo="+${post.postNo},--%>
        <%--        data    : "commentList", //컨트롤러에 있는 list.do로 맵핑하고 게시판 번호도 같이 보낸다.--%>
        <%--        dataType : "json",--%>
        <%--        success: function (result) { //자료를 보내는것이 성공했을때 출력되는 메시지--%>
        <%--            //result : responseText 응답텍스트(html)--%>
        <%--            console.log(result);--%>
        <%--            alert(JSON.stringify(result));--%>
        <%--            $("#listReply").html(result);--%>
        <%--            alert("댓글 출력");--%>
        <%--        }--%>
        <%--    });--%>
        <%--}--%>

        //댓글 목록 출력 함수(댓글작성)
        function listReply() {
            //alert("listReply function excute");
            $.ajax({
                type    : "get", //get방식으로 자료를 전달한다
                url     : "/community/getCommentList?commentPostNo=" +${post.postNo},
                data    : "commentList", //컨트롤러에 있는 list.do로 맵핑하고 게시판 번호도 같이 보낸다.
                dataType: "json",
                success : function (result) { //자료를 보내는것이 성공했을때 출력되는 메시지
                    console.log(result);
                    //alert(JSON.stringify(result));
                    //$("#listReply").html(JSON.stringify(result));
                    //alert("댓글 출력");
                    //location.reload();
                    resultHtml(result);
                }
            });
        }

        function resultHtml(data) {
            var html = "<table class="+"\"table table-warning\""+">";
            html += "<thead>";
            html += "<tr align = 'center'>";
            html += "<th>댓글작성자</th>";
            html += "<th>댓글내용</th>";
            html += "<th>댓글작성일</th>";
            html += "<th></th>";
            html += "</tr>";
            $.each(data, function (key, value) {
                html += "<tr align = 'center'>";
                if(value.commentTruckId == null && value.commentUserId != null){
                    html += "<td>" + value.commentUserId+ "</td>";
                }else if(value.commentUserId == null && value.commentTruckId != null){
                    html += "<td>" + value.commentTruckId+ "</td>";
                }
                html += "<td>" + value.commentContent+ "</td>";
                html += "<td>" + value.commentDate+ "</td>";
                html += "<c:if test="${sessionScope.userId == value.commentUserId || sessionScope.truckId == value.commentTruckId}">";
                html += "<td>" + "<input type='button' class='btn-dark' id='commentU' value='수정'>";
                html += "<input type='button' class='btn-dark' id='commentD' value='삭제'>" + "</td>";
                html += "</c:if>";
                html += "</tr>";
            });
            html += "</thead>";
            html += "</table>";
            $("#listReply").empty();
            $("#listReply").append(html);
        }

        <!-- 댓글 작성 -->
        $(function () {
            //댓글 쓰기 (버튼을 눌러서 id값이 넘어와 실행되는 자바스크립트 구문)
            $("#btnReply").click(function () {
                //alert("댓글쓰기를 클릭했다");
                var replytext = $("#commentContent").val(); //댓글 내용
                <%--var bno = "${post.postNo}"; //게시물 번호--%>
                var param = {"commentContent": replytext};
                //var param="replytext="+replytext+"&bno="+bno;

                if (replytext == null || replytext.length < 1) {
                    alert("댓글 내용은 반드시 입력하셔야 합니다.");
                    return;
                }

                $.ajax({
                    type   : "post", //데이터를 보낼 방식
                    url    : "/community/addComment", //데이터를 보낼 url
                    data   : param, //보낼 데이터
                    success: function () { //데이터를 보내는것이 성공했을시 출력되는 메시지
                        //alert("댓글이 등록되었습니다.");
                        listReply(); //댓글 목록 출력
                    }
                });
            });
        })
        <!-- 댓글 보기 -->
        $(function () {
            //댓글 쓰기 (버튼을 눌러서 id값이 넘어와 실행되는 자바스크립트 구문)
            $("#btnReplyShow").click(function () {
                //alert("댓글보기를 클릭했다");
                $.ajax({
                    type    : "get", //get방식으로 자료를 전달한다
                    url     : "/community/getCommentList?commentPostNo=" +${post.postNo},
                    data    : "commentList", //컨트롤러에 있는 list.do로 맵핑하고 게시판 번호도 같이 보낸다.
                    dataType: "json",
                    success : function (result) { //자료를 보내는것이 성공했을때 출력되는 메시지
                        console.log(result);
                        //alert(JSON.stringify(result));
                        //$("#listReply").html(JSON.stringify(result));
                        //alert("댓글 출력");
                        //location.reload();
                        listReply();
                    }
                });
            });
        })



    </script>

</head>


<body id="page-top">

<jsp:include page="/views/navbar.jsp"/>
<br/><br/><br/><br/><br/>

<div class="container">
    <div class="page-header text-info">
        <h3> 게시글조회 </h3>
    </div>

    <br/>
    <div class="container">
        <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
            <tr>
                <td><h3>게시글</h3></td>
            </tr>
        </table>
    </div>
    <!-- 게시글 조회 -->
    <div class="container">
        <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">

            <tbody>
            <tr>
                <td style="width: 20%;">게시글 제목</td>
                <td colspan="2">${post.postTitle}</td>
            </tr>
            <tr>
                <td>게시글 작성자</td>
                <td colspan="2">${post.postUser.userId}${post.postTruck.truckId}</td>
            </tr>
            <tr>
                <td>게시글 작성일</td>
                <td colspan="2"><fmt:formatDate value="${post.postRegDate}" pattern="yyyy-MM-dd"/></td>
            </tr>
            <tr>
                <td>게시글 내용</td>
                <td colspan="2" style="min-height: 300px; text-align: center">${post.postContent}</td>
            </tr>

            <tr>

                <td align = 'center'>
                    첨부파일1<br/>
                    <img src="../resources/image/${post.postFile1}" width="300"
                         height="300"/>
                </td>

                <td align = 'center'>
                    첨부파일2<br/>
                    <img src="../resources/image/${post.postFile2}" width="300"
                         height="300"/>
                </td>

                <td align = 'center'>
                    첨부파일3<br/>
                    <img src="../resources/image/${post.postFile3}" width="300"
                         height="300"/>
                </td>

            </tr>
            </tbody>

        </table>

        <a href="getPostList" class="btn-secondary">게시글 목록으로</a>

        <c:if test="${sessionScope.user.userId.equals(post.postUser.userId) || sessionScope.truck.truckId.equals(post.postTruck.truckId)}">
            <a href="updatePost?postNo=${postNo}" class="btn-secondary">수정</a>
            <a href="deleteAction.jsp?postNo=${postNo}" class="btn-secondary">삭제</a>
        </c:if>
    </div>
    <!-- 게시판 글쓰기 양식 영역 끝 -->


    <br/>

    <form name="detailForm">
        <!-- 댓글 작성 -->
        <!-- 너비와 정렬방식 설정 -->
        <!-- 세션에 저장되어있는 userid가 null이 아닐때 -->
        <!-- 그러니까 로그인을 한 상태이어야만 댓글을 작성 할 수 있다.-->
        <c:if test="${sessionScope.user != null || sessionScope.truck != null}">

        <div class="input-group" role="group" aria-label="..." style="margin-top: 10px; width: 100%;">
            <div class="container">
                <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                    <tr>
                        <td><h3>댓글</h3></td>
                    </tr>
                </table>
            </div>

            <table class="table table-hover table-striped" id="writeComment">

                <textarea class="form-control" rows="3" id="commentContent" placeholder="댓글을 입력하세요."
                          style="width: 100%;"></textarea>
                <div class="btn-group btn-group-sm" role="group" aria-label="...">
                    <c:if test="${sessionScope.user.userId == null && sessionScope.truck.truckId == null}">
                        <input type="button" class="btn btn-default" value="댓글 쓰기" disabled="disabled">
                        <input type="button" class="btn btn-warning" value="댓글 보기" disabled="disabled">
                    </c:if>
                    <c:if test="${sessionScope.user.userId != null || sessionScope.truck.truckId != null}">
                        <input type="button" class="btn btn-default" value="댓글 쓰기" id="btnReply">
                        <input type="button" class="btn btn-warning" value="댓글 보기" id="btnReplyShow">
                    </c:if>
                </div>
            </table>

            <table class="table table-hover table-striped" id="listReply">

            </table>


            <!-- 댓글 -->
            <div class="collapse" id="comment_card{}">
                <section class="modal-section">
                    <div class="card card-body">
                        <!-- 댓글 목록 -->
                        <div class="comment-list comment-list">
                            <!-- 댓글 목록이 들어가는곳 -->
                        </div>
                    </div>
                </section>

        </div>

        <br/><br/>
        </c:if>
</div>

</form>

</div>


</div>
<jsp:include page="/views/footer.jsp"/>

</body>

</html>
