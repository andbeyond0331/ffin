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
                    location.reload();
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
                        listReply(); //댓글 목록 출력
                    }
                });
            });
        })


        $(document).ready(function () {

            $('#goPostList').on('click', function () {
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

<div class="container">
    <div class="page-header text-info">
        <h3> 게시글조회 </h3>
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
        <div class="panel-heading" style="text-align: center; border: 3px solid #dddddd; border-radius:10px ">

            <div class="panel-body">
                <ul class="chat_list_box" style="font-size:20px ">
                    <strong class="primary-font pull-left" style="padding-top:10px ">작성자</strong>
                    <strong class="pull-right text-dark" style="padding-top:10px; padding-right:10px "><fmt:formatDate
                            value="${post.postRegDate}" pattern="yyyy-MM-dd"/></strong>
                    <img style="border-radius:70px; margin-left:20px; padding-top:10px"
                         src="../resources/image/${userProImg}${truckProImg}" width="100"
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
                    <c:choose>
                        <c:when test="${ post.heartNo eq 0}">
                            <%-- 빈 하트일때 --%>
                            <span>
                                            <a idx="${post.postNo }" href="javascript:" class="heart-click heart_icon${post.postNo }">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16">
                                                     <path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" />
                                                </svg>
                                            </a>
                                        </span>
                        </c:when>
                        <c:otherwise>
                            <%-- 꽉찬 하트일때 --%>
                            <span>
                                            <a idx="${post.postNo}" href="javascript:" class="heart-click heart_icon${post.postNo}">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart-fill" viewBox="0 0 16 16">
                                                 <path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z" />
                                             </svg>
                                        </a>
                                        </span>
                        </c:otherwise>
                    </c:choose>



                    <span id="heart${post.postNo }">${post.heartCount }</span>
                    <span>
                                <a idx="${post.postNo }" href="javascript:" class="reply-click reply-icon${post.postNo }">
                                   <i class="fas fa-beer"></i>
                                </a>
                        </span>
                    <span id="reply${post.postNo }">${post.replyCount }</span>

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

        <c:if test="${sessionScope.user.userId.equals(post.postUser.userId) || sessionScope.truck.truckId.equals(post.postTruck.truckId)}">
            <button id="postD" type="button" class="btn-secondary pull-right" data-toggle="modal"
                    data-target="#deleteModal">삭제
            </button>
            <button id="postU" type="button" class="btn-secondary pull-right" data-toggle="modal"
                    data-target="#updateModal">수정
            </button>
        </c:if>
        <button type="button" id="goPostList" class="btn-secondary pull-right">게시글 목록으로</button>
    </div>
    <!-- 게시판 글쓰기 양식 영역 끝 -->


    <!-- 댓글 수정 Modal -->
    <div class="modal fade" id="updateCModal" tabindex="-1" role="dialog"
         aria-labelledby="updateCModalLabel" aria-hidden="true"
    >
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateCModalLabel">댓글수정</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body"><textarea class="form-control" rows="3" id="commentContentU"
                                                  style="width: 100%;" value=""></textarea></div>
                <div class="modal-footer">
                    <a type="button" class="btn btn-primary" href="/community/updateComment?commentNo=${comment.commentNo}">수정완료</a>
                    <a type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</a>
                </div>
            </div>
        </div>
    </div>

    <br/>

    <form name="detailForm">
        <!-- 댓글 작성 -->
        <!-- 너비와 정렬방식 설정 -->
        <!-- 세션에 저장되어있는 userid가 null이 아닐때 -->
        <!-- 그러니까 로그인을 한 상태이어야만 댓글을 작성 할 수 있다.-->
        <c:if test="${sessionScope.user != null || sessionScope.truck != null}">

        <div class="panel panel-default" role="group" aria-label="..." style="margin-top: 10px; width: 100%;">

            <br/><br/>
            <div class='row'>
                <div class="col-lg-12">
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
                <!-- ./end row -->
            </div>

            <table class="table table-hover table-striped" id="writeComment">

                <textarea class="form-control" rows="3" id="commentContent" placeholder="reply.."
                          style="width: 100%;"></textarea>
                <div class="btn-group btn-group-sm pull-right" role="group" aria-label="...">
                    <c:if test="${sessionScope.user.userId == null && sessionScope.truck.truckId == null}">
                        <input type="button" class="btn btn-default pull-right" value="댓글 쓰기" disabled="disabled">
                    </c:if>
                    <c:if test="${sessionScope.user.userId != null || sessionScope.truck.truckId != null}">
                        <input type="button" class="btn btn-secondary pull-right" value="댓글 쓰기" id="btnReply">
                    </c:if>
                </div>
            </table>

            <table class="table table-hover table-striped" id="list">
                <br/>
                <hr>

                <c:forEach var="comment" items="${list}">

                    <c:set var="i" value="${ i+1 }"/>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <ul class="chat">

                            <!-- start reply -->
                            <li class="left clearfix" data-rno='12'>
                                <div>
                                    <div class="header">
                                        <img style="border-radius:70px; margin-left:5px"
                                             src="../resources/image/${user.userProImg}${truck.truckProImg}" width="60"
                                             height="55" class="pull-left"/>
                                        <strong style="padding-top:10px"
                                                class="primary-font">${comment.commentUserId}${comment.commentTruckId}</strong>
                                        <small class="pull-right text-muted">${comment.commentDate}</small>
                                        <br>
                                        <c:if test="${sessionScope.user.userId.equals(comment.commentUserId) || sessionScope.truck.truckId.equals(comment.commentTruckId)}">
                                            <a class="btn-outline-dark pull-right"
                                               href="/community/deleteComment?commentNo=${comment.commentNo}">삭제</a>
                                            <input type="hidden" value="${comment.commentNo}">
                                            <input type="hidden" value="${comment.commentPostNo}">
                                            <a name="updateC" class="btn-outline-dark pull-right" data-toggle="modal"
                                               data-target="#updateCModal">수정</a>
                                            <input type="hidden" value="${comment.commentNo}">
                                            <input type="hidden" value="${comment.commentPostNo}">
                                        </c:if>
                                    </div>
                                    <p>${comment.commentContent}</p>
                                    <hr/>
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
<script>

    $("body").on("click", ".heart-click", function() {
        // $(".heart-click").click(function () {

        // 게시물 번호(no)를 idx로 전달받아 저장
        let postNo = $(this).attr('idx');
        console.log("postNo: " + postNo);

        // 빈하트를 눌렀을때
        if ($(this).children('svg').attr('class') == "bi bi-suit-heart") {
            console.log("빈하트 클릭" + postNo);

            $.ajax({
                url: 'json/addHeart',
                type: 'get',
                data: {
                    postNo: postNo,
                },
                success: function (pto) {
                    //페이지 새로고침
                    //document.location.reload(true);
                    console.log("pto: "+pto.heartCount)
                    let heart = pto.heartCount;


                    $('#heart'+postNo).text(heart);

                    console.log("하트 추가!!!!!!!!!!");
                },
                error: function () {
                    alert('서버 에러');
                }
            });
            console.log("하트채워");

            // 꽉찬하트로 바꾸기
            $(this).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
            $('.heart_icon' + postNo).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");

            // 꽉찬 하트를 눌렀을 때
        } else if ($(this).children('svg').attr('class') == "bi bi-suit-heart-fill") {
            console.log("꽉찬거 하트 클릭 " + postNo);

            $.ajax({
                url: 'json/removeHeart',
                type: 'get',
                data: {
                    postNo: postNo,
                },
                success: function (pto) {
                    //페이지 새로고침
                    //document.location.reload(true);
                    console.log("pto: "+pto)
                    let heart = pto.heartCount;
                    // 페이지에 하트수 갱신
                    //

                    $('#heart'+postNo).text(heart);

                    console.log("하트삭제!!!!!!!!!");
                },
                error: function () {
                    alert('서버 에러');
                }
            });
            console.log("빈하트!!!!!!!!!");

            // 빈하트로 바꾸기
            $(this).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');

            $('.heart_icon' + postNo).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
        }


    });
</script>
</body>

</html>
