<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">

<head>
    <style>
        li {
            list-style: none;
        }

        .btn-secondary {
            border-radius: 5px;
        }
    </style>

    <title>F.FIN | 게시글 조회</title>
    <jsp:include page="../../common/lib.jsp"/>

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!-- ajax 모듈 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

    <!-- moment -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script src="http://code.jquery.com/jquery-latest.js"></script>

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
                    //$("#listReply").text(JSON.stringify(result));
                    //alert("댓글 출력");
                }
            });
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
                        var postNo = ${post.postNo};
                        var userId = '${sessionScope.user.userId}${sessionScope.truck.truckId}';
                        var postUserId = '${post.postUser.userId}${post.postTruck.truckId}'

                        console.log("post.socket::::" + socket);
                        if(socket) {
                            // websocket에 보내기!!! (message, 보내는이, 받는이)
                            let socketMessage = "post,"+userId+","+postUserId+","+postNo;
                            console.log("socketM::::" + socketMessage);
                            socket.send(socketMessage);
                        }

                        listReply(); //댓글 목록 출력
                        location.reload();
                    }
                });
            });

        })
        // 게시물 비공개처리
        function fncBlind() {
            if(${post.secretKey == 1}){
                alert("이미 비공개 처리된 게시물입니다.")
                return;
            }else {
                self.location="/community/blindPost";
                alert("게시물 비공개처리가 완료되었습니다.");
            }
        }

        // 게시물 공개처리
        function fncSee() {
            console.log("fncSee");
            if(${post.secretKey == 0}){
                alert("이미 공개처리된 게시물입니다.");
                return;
            }else {
                self.location="/community/seePost";
                alert("게시물 공개처리가 완료되었습니다.");
            }
        }

        function fncDeleteC(commentNo){
            //let commentNo = $(this).parent().find("input[name='deleteCNO']").val();
            //alert("먹먹먹ㅁ "+commentNo);
            $.ajax({
                type   : "get", //데이터를 보낼 방식
                url    : "/community/json/deleteComment", //데이터를 보낼 url
                data   : {
                    commentNo : commentNo
                }, //보낼 데이터
                success: function () { //데이터를 보내는것이 성공했을시 출력되는 메시지
                    //alert("댓글이 삭제되었습니다.");
                    listReply(); //댓글 목록 출력
                    location.reload();
                }
            });
        }


        $(document).ready(function () {

            $('#goPostList').on('click', function () {
                self.location = "/community/getPostList";
            });

            $('#goBlindPost').on('click', function () {
                alert("해당 게시물을 비공개처리합니다.");
                fncBlind();
                self.location = "/community/getPostList";
            });
            $('#goSeePost').on('click', function () {
                alert("해당 게시물을 공개처리합니다.");
                fncSee();
                self.location = "/community/getPostList";
            });

            /////////모///달///기///능///////////
            // 1. 모달창 히든 불러오기 수정
            $('#postU').on('click', function () {
                $('#updateModal').modal('show');
            });

            // 2. 모달창 히든 불러오기 삭제
            $('#postD').on('click', function () {
                $('#deleteModal').modal('show');
            });

            $(function () {
                $(updateC).click(function (){
                    var data_var = $(this).data('id');
                    $(".modal-body #commentContentU").val(data_var);
                })
            });

        });


    </script>

</head>


<body id="page-top">

<jsp:include page="/views/navbar.jsp"/>
<br/><br/><br/><br/><br/>

<div class="container" align="center">
    <div class="page-header text-info">
        <h3 class="text-info"> 게시글조회 </h3>
    </div>

    <br/>
    <%--    <div class="container">--%>
    <%--        <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">--%>
    <%--            <tr>--%>
    <%--                <td><h3>게시글</h3></td>--%>
    <%--            </tr>--%>
    <%--        </table>--%>
    <%--    </div>--%>
    <!-- 게시글 조회 -->
    <div class="panel panel-default">
        <div class="panel-heading" style="border-radius:10px ; border: 0; box-shadow: 0 2px 4px 0 rgba(0,0,0,0.2); max-width: 550px;
			transition: 0.3s;">

            <div class="panel-body">
                <ul class="chat_list_box" style="font-size:20px ">
                    <strong class="primary-font pull-left" style="padding-top:10px ">작성자</strong>
                    <strong class="pull-right text-dark" style="padding-top:10px; padding-right:10px "><fmt:formatDate
                            value="${post.postRegDate}" pattern="yyyy-MM-dd"/></strong>
                    <img style="border-radius:70px; margin-left:20px; padding-top:10px"
                         src="../resources/image/${post.postUser.userProImg}${post.postTruck.truckProImg}" width="100"
                         height="100" class="pull-left"/>

                    <br/>
                    <strong id="postingId" class="pull-left"
                            style="padding-top:10px ">${post.postUser.userId}${post.postTruck.truckId}</strong>
                    <br/>
                </ul>
                <%--                <ul style="font-size:20px ">--%>
                <%--                    &lt;%&ndash;                <strong>게시글 작성일</strong>&ndash;%&gt;--%>
                <%--                    <small class="pull-right text-dark" colspan="2"><fmt:formatDate value="${post.postRegDate}" pattern="yyyy-MM-dd"/></small>--%>
                <%--                </ul>--%>
                <br/>
                <hr>

                <ul class="chat_list" style="font-size:30px ">
                    <strong class="primary-font pull-left" style="font-size: 20px">제목</strong>
                    <strong class="primary-font" style="width: 20%;">${post.postTitle}</strong>
                    <%--                <td class="center" colspan="2">${post.postTitle}</td>--%>
                </ul>
                <hr>

                <ul>
                    <strong class="pull-left" style="font-size:20px ">내용</strong>
                    <midium colspan="2" style="font-size: 28px">${post.postContent}</midium>
                </ul>

                <ul>
                    <td colspan="1">
                        <br/>
                        <img src="../resources/image/${post.postFile1}" width="300"
                             height="300"/>
                        <img src="../resources/image/${post.postFile2}" width="300"
                             height="300"/>
                        <img src="../resources/image/${post.postFile3}" width="300"
                             height="300"/>
                    </td>
                </ul>
                <ul class="chat_list" style="font-size:30px ">

                    <span> <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
											<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z" />
											<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z" />
										</svg>
						</span> <span id="hit${post.postNo }">${post.postHit }</span>


                </ul>

            </div>

        </div>

        <!-- 게시물 수정 Modal -->
        <div class="modal fade" id="updateModal" tabindex="-1" role="dialog"
             aria-labelledby="updateModalLabel" aria-hidden="true"
        >
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="updateModalLabel">게시물 수정</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">게시물을 수정하시겠습니까?</div>
                    <div class="modal-footer">
                        <a type="button" class="btn btn-primary"
                           href="/community/updatePost?postNo=${postNo}">수정하러가기</a>
                        <a type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- 게시물 삭제 Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog"
             aria-labelledby="deleteModalLabel" aria-hidden="true"
        >
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteModalLabel">게시물 삭제</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">게시물을 삭제하시겠습니까?</div>
                    <div class="modal-footer">
                        <a type="button" class="btn btn-primary" href="/community/deletePost?postNo=${postNo}">삭제하기</a>
                        <a type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</a>
                    </div>
                </div>
            </div>
        </div>
        <c:if test="${sessionScope.role.equals(admin)}">
            <button type="button" id="goBlindPost" class="btn-secondary">비공개처리</button>
            <button type="button" id="goSeePost" class="btn-secondary">공개처리</button>
        </c:if>
        <button type="button" id="goPostList" class="btn-secondary">게시글 목록으로</button>
        <c:if test="${sessionScope.user.userId.equals(post.postUser.userId) || sessionScope.truck.truckId.equals(post.postTruck.truckId)}">
            <button id="postU" type="button" class="btn-secondary" data-toggle="modal"
                    data-target="#updateModal">수정
            </button>
            <button id="postD" type="button" class="btn-secondary" data-toggle="modal"
                    data-target="#deleteModal">삭제
            </button>
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

        <div class="panel panel-default" role="group" aria-label="..." style="margin-top: 10px; width: 100%;">

            <br/><br/>
            <div class='row' style="max-width:770px ">
                <div class="col-md-2">
                    <!-- /.panel -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-comments fa-2x"></i> Reply
                        </div>

                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <ul class="chat">
                            </ul>
                            <!-- ./ end ul -->
                        </div>
                        <!-- /.panel .chat-panel -->
                    </div>
                </div>
                <div class="col-md-8">
                    <textarea class="form-control" rows="3" id="commentContent" placeholder="reply.."
                              style="width: 100%; max-width:770px "></textarea>
                </div>
                <div class="text-right col-md-2 pr-0">
                    <div class="btn-group btn-group-sm text-right" role="group" aria-label="...">
                        <c:if test="${sessionScope.user.userId == null && sessionScope.truck.truckId == null}">
                            <input type="button" class="btn btn-default" value="댓글 쓰기" disabled="disabled">
                        </c:if>
                        <c:if test="${sessionScope.user.userId != null || sessionScope.truck.truckId != null}">
                            <input type="button" class="btn btn-secondary" value="댓글 쓰기" id="btnReply">
                        </c:if>
                    </div>
                </div>
                <!-- ./end row -->
            </div>




            <table class="table table-hover table-striped" id="list">
                <br/>
                <hr style="max-width: 770px">

                <c:forEach var="comment" items="${list}">

                    <c:set var="i" value="${ i+1 }"/>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <ul class="chat" style="padding: 0px">

                            <!-- start reply -->
                            <li class="left clearfix" data-rno='12' style="max-width: 770px">
                                <div>
                                    <div class="header">
                                        <img style="border-radius:70px; margin-left:5px"
                                             src="../resources/image/${comment.userProImg}${comment.truckProImg}" width="60"
                                             height="55" class="pull-left"/>
                                        <strong style="padding-top:10px"
                                                class="primary-font pull-left">${comment.commentUserId}${comment.commentTruckId}</strong>
                                        <small class="pull-right text-muted">${comment.commentDate}</small>
                                        <br>
                                        <c:if test="${sessionScope.user.userId.equals(comment.commentUserId) || sessionScope.truck.truckId.equals(comment.commentTruckId)}">
                                            <a class="btn-outline-dark pull-right"
                                               href="javascript:void(0)" onclick="fncDeleteC('${comment.commentNo}')">삭제</a>
                                            <input type="hidden" name="deleteCNO" value="${comment.commentNo}">
                                            <input type="hidden" value="${comment.commentPostNo}">
                                        </c:if>
                                    </div>
                                    <p class="col-sm-8">${comment.commentContent}</p>
                                    <hr style="margin:0 "/>
                                </div>

                            </li>
                            <!-- end reply -->
                        </ul>
                        <!-- ./ end ul -->
                    </div>
                    <!-- /.panel .chat-panel -->
                </c:forEach>
            </table>

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
