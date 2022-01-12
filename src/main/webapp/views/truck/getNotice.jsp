<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>
    <style>
        .btn-secondary {
            border-radius: 5px;
        }

        img {
            display: block;
            margin: 0px auto;
        }

    </style>

    <title>F.FIN | 공지 작성</title>
    <jsp:include page="../../common/lib.jsp"/>
    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!-- ajax 모듈 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

    <!-- moment -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //============= "수정하기"  Event 연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-secondary").on("click", function () {
                self.location = "/views/truck/updateNotice.jsp"
            });
        });

        //============= "메인화면으로"  Event 처리 및  연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("#goMain").on("click", function () {
                self.location = "/views/home.jsp"
            });
        });

        function fncUpdateNotice() {
            // 유효성체크
            var title = $("input[name='truckNoticeTitle']").val();
            var content = $("textarea[name='truckNoticeContent']").val();

            if (title == null || title.length < 1) {
                alert("제목은 반드시 입력하셔야 합니다.");
                return;
            }
            if (content == null || content.length < 1) {
                alert("내용은 반드시 입력하셔야 합니다.");
                return;
            }
            $("form").attr("method", "POST").attr("action", "/truck/updateNotice").attr("enctype", "multipart/form-data").submit();
            alert("공지 작성이 완료되었습니다.");
        }


        $(document).ready(function () {

            $('#goPostList').on('click', function () {
                self.location = "/community/getPostList";
            });
            /////////모///달///기///능///////////
            // 1. 모달창 히든 불러오기 수정
            $('#noticeU').on('click', function () {
                $('#updateNModal').modal('show');
            });

            // // 2. 모달창 히든 불러오기 삭제
            // $('#postD').on('click', function () {
            //     $('#deleteModal').modal('show');
            // });

            // $(function () {
            //     $(updateC).click(function (){
            //         var data_var = $(this).data('id');
            //         $(".modal-body #commentContentU").val(data_var);
            //     })
            // });

        });


    </script>

</head>


<body id="page-top">

<jsp:include page="/views/navbar.jsp"/>
<br/><br/><br/><br/>
<c:if test="${sessionScope.truck != null || sessionScope.user != null}">
<div class="container">
    <div class="page-header text-info" align="center">
        <h3 class="text-info"> 공지 조회 </h3>
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
        <div class="panel-heading" style="border-radius:10px ; border: 2px solid orange; ">

            <div class="panel-body">
                <ul class="chat_list_box" style="font-size:20px ">
                    <strong class="primary-font pull-left" style="padding-top:10px ">작성자</strong>
                        <%--                    <strong class="pull-right text-dark" style="padding-top:10px; padding-right:10px "><fmt:formatDate--%>
                        <%--                            value="${post.postRegDate}" pattern="yyyy-MM-dd"/></strong>--%>
                    <img style="border-radius:70px; margin-left:20px; padding-top:10px"
                         src="../resources/image/${truck.truckProImg}" width="100"
                         height="100" class="pull-left"/>

                    <br/>
                    <strong id="postingId" class="pull-left"
                            style="padding-top:10px ">${truck.truckId}</strong>
                    <br/>
                </ul>
                    <%--                <ul style="font-size:20px ">--%>
                    <%--                    &lt;%&ndash;                <strong>게시글 작성일</strong>&ndash;%&gt;--%>
                    <%--                    <small class="pull-right text-dark" colspan="2"><fmt:formatDate value="${post.postRegDate}" pattern="yyyy-MM-dd"/></small>--%>
                    <%--                </ul>--%>
                <br/>
                <hr style="border:1px dashed orange "/>

                <ul class="chat_list" style="font-size:30px ">
                    <strong class="primary-font pull-left" style="font-size: 20px">제목</strong>
                    <midium class="col-sm-4 align-content-center">${truck.truckNoticeTitle}</midium>
                        <%--                <td class="center" colspan="2">${post.postTitle}</td>--%>
                </ul>
                <hr style="border:1px dashed orange "/>

                <ul>
                    <strong class="pull-left" style="font-size:20px ">내용</strong>
                    <midium class="primary-font"
                            style="margin-left: 200px; font-size:20px ">${truck.truckNoticeContent}</midium>
                </ul>

                <ul>
                    <td style="text-align: center;">
                        <br/>
                        <img class="notiImg" src="../resources/image/${truck.truckNoticeImg}" width="300"
                             height="300"/>
                    </td>
                </ul>


                <!-- 공지 수정 Modal -->
                <div class="modal fade" id="updateNModal" tabindex="-1" role="dialog"
                     aria-labelledby="updateNModalLabel" aria-hidden="true"
                >
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="updateNModalLabel">공지 수정</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">공지를 수정하시겠습니까?</div>
                            <div class="modal-footer">
                                <a type="button" class="btn btn-primary"
                                   href="/truck/updateNotice">수정하러가기</a>
                                <a type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</a>
                            </div>
                        </div>
                    </div>
                </div>

                <c:if test="${sessionScope.truck.truckId.equals(truck.truckId)}">
                    <button id="noticeU" type="button" class="btn-secondary pull-right" data-toggle="modal"
                            data-target="#updateNModal">수정하기
                    </button>
                </c:if>
                <button type="button" id="goMain" class="btn-secondary pull-right">메인화면으로</button>
            </div>
        </div>
        <br/><br/><br/><br/>


        <c:if test="${sessionScope.user == null && sessionScope.truck == null}">
            <div class="col-sm-offset-6 text-center">
                <h3>회원가입 이후 공지사항을 열람하실 수 있습니다</h3>
                <br/><br/>
                <a href="/views/user/addUserInfo.jsp" class="btn-warning">일반회원가입</a>
                <a href="/views/truck/addTruckView.jsp" class="btn-warning">사업자회원가입</a>
                <a href="/views/home.jsp" class="btn-warning">메인화면으로</a>
            </div>
        </c:if>

        </c:if>
    </div>
</div>

<jsp:include page="/views/footer.jsp"/>

</body>

</html>
