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

        .reply_list_profileImage {
            width: 40px;
            height: 40px;
            border: 0px;
            border-radius: 50%;
            max-width: fit-content;
        }

        #write_reply_profileImage {
            width: 40px;
            height: 40px;
            border: 0px;
            border-radius: 50%;
            max-width: fit-content;
        }

        .row.postContent {
            font-weight: bold;
            font-size: 14px;
        }

        .slider-pagination {
            border-radius: 10px;
        }

        .modal-body.align-test span a svg {
            color: #ffd03c;
        }

        .rereply-content.col-8 {
            display: flex;
            align-items: center;
        }

        .reply_arrow {
            display: flex;
            align-items: center;
            justify-content: flex-end;
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

    <!-- icon -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script src="http://code.jquery.com/jquery-latest.js"></script>

    <script type="text/javascript">
        var role = '${sessionScope.role}';
        var proImg;
        var uId;
        if (role == 'user') {
            proImg = '${sessionScope.user.userProImg}';
            uId = '${sessionScope.user.userId}';
        } else if (role == 'truck') {
            proImg = '${sessionScope.truck.truckProImg}';
            uId = '${sessionScope.truck.truckId}';
        }

        console.log("role: " + role);
        console.log("proImg : " + proImg);
        console.log("uId: " + uId);
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
                        if (socket) {
                            // websocket에 보내기!!! (message, 보내는이, 받는이)
                            let socketMessage = "post," + userId + "," + postUserId + "," + postNo;
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
            if (${post.secretKey == 1}) {
                alert("이미 비공개 처리된 게시물입니다.")
                return;
            } else {
                self.location = "/community/blindPost";
                alert("게시물 비공개처리가 완료되었습니다.");
            }
        }

        // 게시물 공개처리
        function fncSee() {
            console.log("fncSee");
            if (${post.secretKey == 0}) {
                alert("이미 공개처리된 게시물입니다.");
                return;
            } else {
                self.location = "/community/seePost";
                alert("게시물 공개처리가 완료되었습니다.");
            }
        }

        function fncDeleteC(commentNo) {
            //let commentNo = $(this).parent().find("input[name='deleteCNO']").val();
            //alert("먹먹먹ㅁ "+commentNo);
            $.ajax({
                type   : "get", //데이터를 보낼 방식
                url    : "/community/json/deleteComment", //데이터를 보낼 url
                data   : {
                    commentNo: commentNo
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

            /*$(function () {
                $(updateC).click(function () {
                    var data_var = $(this).data('id');
                    $(".modal-body #commentContentU").val(data_var);
                })
            });*/

            ReplyList('${post.postNo}')

        });

        const ReplyList = function (no) {
            console.log("no: " + no)
            let postNo = no;
            $.ajax({
                url    : '/community/json/replyList',
                type   : 'get',
                data   : {
                    postNo: postNo
                },
                success: function (data) {

                    console.log("댓글 리스트 가져오기 성공");
                    console.log("data: " + data);


                    // 댓글 목록을 html로 담기
                    let listHtml = "";
                    for (const i in data.replyList) {

                        let commentNo = data.replyList[i].commentNo;
                        let commentPostNo = data.replyList[i].commentPostNo;
                        let grp = data.replyList[i].grp;
                        let grps = data.replyList[i].grps;
                        let grpl = data.replyList[i].grpl;
                        let commentUser = data.replyList[i].commentUserId;
                        let commentTruck = data.replyList[i].commentTruckId;
                        let commentContent = data.replyList[i].commentContent;
                        let commentDate = data.replyList[i].commentDate;
                        let wgap = data.replyList[i].wgap;
                        let userPro = data.replyList[i].userProImg;
                        let truckPro = data.replyList[i].truckProImg;
                        let commentUserId = "";
                        let userProImg = "";

                        console.log("userPro:: " + userPro)
                        if (commentUser == "" || !commentUser) {
                            commentUserId = commentTruck;
                            userProImg = truckPro;
                        } else {
                            commentUserId = commentUser;
                            userProImg = userPro;
                        }

                        console.log(grpl);	// 모댓글일땐 0, 답글일땐 1
                        console.log("commentUserId: " + commentUserId)
                        console.log("userProImg: " + userProImg)

                        listHtml += "<div style='display: -webkit-box; align-items: center; justify-content: space-between; margin-top: 10px; padding: 5px; background-color: rgb(0 0 0 / 4%); border-radius: 50px;' class='row replyrow reply" + commentNo + "'>";

                        if (commentContent == "") {		// 삭제된 댓글일때
                            listHtml += "	<div>";
                            listHtml += "		(삭제된 댓글입니다)";
                            listHtml += "	</div>";
                        } else {
                            if (grpl == 0) {	// 모댓글일때
                                listHtml += "	<div class='col-1'>";
                                listHtml += "		<a href='other_profile.do?other_nick=" + commentUserId + "'> ";
                                listHtml += "			<img class='reply_list_profileImage' style=' box-shadow: 0 2px 4px 2px rgb(0 0 0 / 15%); border-radius: 2rem' src='../../../resources/image/" + userProImg + "'/>";
                                listHtml += "		</a> ";
                                listHtml += "	</div>";
                                listHtml += "	<div class='rereply-content col-8'>";
                                listHtml += "		<div>";
                                listHtml += "			<span>";
                                listHtml += "				<b style='margin-left: 5px;'>" + commentUserId + "</b>";
                                listHtml += "			</span>";
                                listHtml += "			<span>";
                                listHtml += commentContent;
                                listHtml += "			</span>";
                                listHtml += "		</div>";
                                // 현재 로그인 상태일때 답글작성 버튼이 나온다.

                                listHtml += "		<div>";
                                // 함수에 게시글번호(bno), 모댓글번호(no), 모댓글 작성자(writer)를 인자로 담아서 넘긴다.
                                // 이때 모댓글 작성자 writer는 string인데 string을 인자에 넣기 위해선''나""로 감싸줘야한다.
                                // 여기선 ''와 ""가 이미 둘다 쓰이고 있는데  href를 감싸고 있는 ''와 겹치지 않는 ""를 \" 처리해서 넣어줬다.
                                //listHtml += "			<a href='#re_reply"+ commentNo +"' class='write_reply_start' role='button' data-bs-toggle='collapse' aria-expanded='false' aria-controls='re_reply"+ commentNo +"'>답글1&nbsp;달기</a>";
                                //listHtml += "			<button type='button' class='write_reply_start' no='" + commentNo + "' bno='" + commentPostNo + "' data-bs-toggle='collapse' data-bs-target='#re_reply"+ commentNo +"' aria-expanded='false' aria-controls='re_reply"+ commentNo +"'>답글&nbsp;달기</button>";
                                listHtml += "        <a class='btn btn-default' role='button' data-toggle='collapse' href='#re_reply" + commentNo + "' aria-expanded='false' aria-controls='collapseExample' style='zoom: 80%; padding: 3px 5px; font-size: 12px;' >" + "<ion-icon name='chatbubble-outline'></ion-icon>" + "</a>"
                                listHtml += "		</div>";

                                listHtml += "	</div>";

                            } else {	// 답글일때
                                listHtml += "	<div class='col-1 reply_arrow' style='padding: 0;'><ion-icon name='return-down-forward-outline'></ion-icon>"
                                listHtml += "	</div>"
                                listHtml += "	<div class='col-1'>";
                                listHtml += "		<img class='reply_list_profileImage' style='box-shadow: 0 2px 4px 2px rgb(0 0 0 / 15%); border-radius: 2rem' src='../../../resources/image/" + userProImg + "'/>";
                                listHtml += "	</div>";
                                listHtml += "	<div class='rereply-content" + commentNo + " col-7' style='display: flex; align-items: center;'>";
                                listHtml += "		<div>";
                                listHtml += "			<span>";
                                listHtml += "				<b style='margin-left: 5px;'>" + commentUserId + "</b>";
                                listHtml += "			</span>";
                                listHtml += "			<span>";
                                listHtml += commentContent;
                                listHtml += "			</span>";
                                listHtml += "		</div>";

                                listHtml += "	</div>";
                            }

                            listHtml += "	<div class='col-3 reply-right' style='display: flex; justify-content: flex-end; align-items: center; padding-right: 20px;'>";
                            listHtml += "		<div>";
                            listHtml += "<small class='pull-right text-muted'>" + commentDate + "</small>";
                            listHtml += "		</div>";
                            // 책갈피
                            // 현재 로그인 상태이고..


                            //현재 사용자가 이 댓글의 작성자일때 삭제 버튼이 나온다.
                            if (uId == commentUserId) {
                                listHtml += "		<div>";
                                // 수정할 댓글의 no를 grpl과 함께 넘긴다.
                                // 모댓글 수정칸과 답글 수정칸을 화면에 다르게 나타내야하기 때문에 모댓글과 답글을 구분하는 grpl을 함께 넘겨주어야한다.
                                //listHtml += "			<a href='javascript:' no='"+ no +"' grpl='"+ grpl +"' class='reply_modify'>수정</a>";
                                //listHtml += "			&nbsp;|&nbsp;";
                                // 삭제는 no만 넘겨주면 된다.
                                listHtml += "			<a href='javascript:' no='" + commentNo + "' grpl='" + grpl + "' bno='" + commentPostNo + "' grp='" + grp + "' class='reply_delete' style='font-size: 13px; float: right;'>" + "<ion-icon name='trash-outline'></ion-icon>" + "</a>";
                                /*
                                                                listHtml += '			<a class="btn btn-primary" role="button" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample">삭제</a>'
                                */
                                listHtml += "		</div>";
                            }


                            listHtml += "	</div>";
                            // 댓글에 답글달기를 누르면 답글입력란이 나온다.
                            // ---- 답글입력란
                            //listHtml += "	<div class='collapse row rereply_write' id='re_reply"+ commentNo +"'>";
                            listHtml += "<div class='collapse row rereply_write' id='re_reply" + commentNo + "'>";
                            listHtml += "		<div class='col-1'>"
                            listHtml += "		</div>"
                            listHtml += "		<div class='col-1'>"
                            listHtml += "			<a href='other_profile.do?other_nick=" + uId + "'> ";
                            listHtml += "				<img id='write_reply_profileImage' src='../../../resources/image/" + proImg + "'/>"
                            listHtml += "			</a> ";
                            listHtml += "		</div>"
                            listHtml += "		<div class='col-8' style='display:flex; text-align: center; align-items: center;'>"
                            listHtml += "  		<input class='w-100 input_rereply_div form-control' style='zoom: 90%; height: 35px; border-radius: 50px; margin-left: 15px;' id='input_rereply" + commentNo + "' type='text' placeholder='댓글입력...'>"
                            listHtml += "		</div>"
                            listHtml += "		<div class='col-2' style='display:flex; align-items: center; padding: 0;'>"
                            // 답글달기 버튼이 눌리면 모댓글 번호(no)와 게시물번호(bno)를 함수에 전달한다.

                            // 동적으로 넣은 html태그에서 발생하는 이벤트는 동적으로 처리해줘야한다 !!!!!
                            // 예를들어, 동적으로 넣은 html태그에서 발생하는 click 이벤트는 html태그 안에서 onclick으로 처리하면 안되고, jquery에서 클래스명이나 id값으로 받아서 처리하도록 해야한다.
                            // 아래코드를 보자~~~~
                            // listHtml += "			<button onclick='javascript:WriteReReply("+ no +","+ bno +")' type='button' class='btn btn-success mb-1 write_rereply' >답글&nbsp;달기</button>"
                            // 위 코드는 클릭되어도 값이 넘겨지지 않는다. 값이 undefined가 된다.
                            // 아래코드처럼 짜야한다. click이벤트를 처리하지 않고 데이터(no, bno)만 속성으로 넘겨주도록 작성한다.<button type='button' class='btn btn-success mb-1 write_rereply' no='" + commentNo + "' bno='" + commentPostNo + "'>답글&nbsp;달기</button>"
                            listHtml += "<a href='javascript:' no='" + commentNo + "' bno='" + commentPostNo + "' class='write_rereply' style='font-size: 13px; float: right;'>등록</a>";
                            listHtml += "		</div>";
                            listHtml += "	</div>";
                            // ---- 답글입력란 끝
                        }

                        listHtml += "</div>";


                    }
                    ;

                    ///////////// 동적으로 넣어준 html에 대한 이벤트 처리는 같은 함수내에서 다 해줘야한다.
                    ///////////// $(document).ready(function(){}); 안에 써주면 안된다.
                    //var modal = $('#staticBackdrop');
                    //modal.find("span[id='m_heart'"+postNo+"]").text(heart);
                    // 페이지에 하트수 갱신
                    // console.log("listHtml: "+listHtml);
                    // 댓글 리스트 부분에 받아온 댓글 리스트를 넣기
                    $(".reply-list" + postNo).html(listHtml);

                    // 답글에서 답글달기를 누르면 input란에 "@답글작성자"가 들어간다.
                    //$('.write_re_reply_start').on('click', function(){
                    //	$('#input_rereply'+ $(this).attr('no')).val("@"+$(this).attr('writer')+" ");
                    //});

                    //답글을 작성한 후 답글달기 버튼을 눌렀을 때 그 click event를 아래처럼 jquery로 처리한다.
                    $('.write_rereply').on('click', function () {
                        console.log('no', $(this).attr('no'));
                        console.log('bno', $(this).attr('bno'));

                        // 답글을 DB에 저장하는 함수를 호출한다. bno와 no를 같이 넘겨주어야한다.
                        WriteReReply($(this).attr('bno'), $(this).attr('no'));
                    })

                    // 삭제버튼을 클릭했을 때
                    $('.reply_delete').on('click', function () {
                        // 모댓글 삭제일때
                        if ($(this).attr('grpl') == 0) {
                            DeleteReply($(this).attr('no'), $(this).attr('bno'));

                            // 답글 삭제일때
                        } else {

                            DeleteReReply($(this).attr('no'), $(this).attr('bno'), $(this).attr('grp'));
                        }

                    })


                },
                error  : function () {
                    alert('서버 에러');
                }
            });


        };

        // 답글 달기 버튼 클릭시  실행 - 답글 저장, 댓글 갯수 가져오기
        const WriteReReply = function (bno, no) {


            console.log(bno);
            console.log(no);

            console.log($("#input_rereply" + no).val());

            // 댓글 입력란의 내용을 가져온다.
            // ||"" 를 붙인 이유  => 앞뒤 공백을 제거한다.(띄어쓰기만 입력했을때 댓글작성안되게 처리하기위함)
            let content = $("#input_rereply" + no).val();
            content = content.trim();


            if (content == "") {	// 입력된게 없을때
                alert("글을 입력하세요!");
            } else {
                // 입력란 비우기
                $("#input_rereply" + no).val("");

                // reply+1 하고 그 값을 가져옴
                $.ajax({
                    url    : '/community/json/write_rereply',
                    type   : 'get',
                    data   : {
                        commentNo     : no,
                        commentPostNo : bno,
                        commentContent: content
                    },
                    success: function (pto) {

                        let reply = pto.replyCount;
                        // 페이지에 댓글수 갱신

                        $('#reply' + bno).text(reply);

                        console.log("답글 작성 성공");

                        // 게시물 번호(bno)에 해당하는 댓글리스트를 새로 받아오기
                        ReplyList(bno);
                    },
                    error  : function () {
                        alert('서버 에러');
                    }
                });

            }
            ;
        };

        // 모댓글 삭제일때
        const DeleteReply = function (no, bno) {
            // grp이 no인 댓글이 있는 경우 content에 null을 넣고 없으면 삭제한다.
            $.ajax({
                url    : '/community/json/delete_reply',
                type   : 'get',
                data   : {
                    commentNo    : no,
                    commentPostNo: bno
                },
                success: function (pto) {

                    let reply = pto.replyCount;

                    $('#reply' + bno).text(reply);

                    console.log("모댓글 삭제 성공");

                    // 게시물 번호(bno)에 해당하는 댓글리스트를 새로 받아오기
                    ReplyList(bno);
                },
                error  : function () {
                    alert('서버 에러');
                }
            });
        };

        // 답글 삭제일때
        const DeleteReReply = function (no, bno, grp) {

            //console.log("grp : " + grp);
            console.log("no: " + no + ", bno: " + bno + ", grp: " + grp)
            // 답글을 삭제한다.
            $.ajax({
                url    : '/community/json/delete_rereply',
                type   : 'get',
                data   : {
                    commentNo    : no,
                    commentPostNo: bno,
                    grp          : grp
                },
                success: function (pto) {
                    //alert("!!!!!!!!!!!!!!!!!")
                    let reply = pto.replyCount;


                    $('#reply' + bno).text(reply);

                    console.log("답글 삭제 성공");

                    // 게시물 번호(bno)에 해당하는 댓글리스트를 새로 받아오기
                    ReplyList(bno);
                },
                error  : function () {
                    alert('서버 에러');
                }
            });

        };


    </script>

</head>


<body id="page-top">

<jsp:include page="/views/navbar.jsp"/>
<br/><br/><br/><br/><br/>

<div class="container" align="center">
    <div class="page-header" style="margin-top: 50px; margin-bottom: 50px;">
        <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
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

    <div class="col-md-10" style="display: flex; justify-content: flex-end; margin-bottom: 10px;">
        <c:if test="${sessionScope.role eq 'admin'}">
            <c:if test="${post.secretKey == 0}">
                <button type="button" id="goBlindPost" class="btn btn-default"
                        style="padding: 5px; height: fit-content;">비공개처리
                </button>
            </c:if>
            <c:if test="${post.secretKey == 1}">
                <button type="button" id="goSeePost" class="btn btn-default" style="padding: 5px; height: fit-content;">
                    공개처리
                </button>
            </c:if>
        </c:if>
        <button type="button" id="goPostList" class="btn btn-cancle"
                style="display: flex; align-items: center; padding: 5px; height: fit-content;">
            <ion-icon name="reorder-three-outline"></ion-icon>&nbsp;목록
        </button>
        <c:if test="${sessionScope.user.userId.equals(post.postUser.userId) || sessionScope.truck.truckId.equals(post.postTruck.truckId)}">
            <button id="postU" type="button" class="btn btn-default" data-toggle="modal"
                    data-target="#updateModal" style="padding: 5px; height: fit-content;">수정
            </button>
            <button id="postD" type="button" class="btn btn-default" data-toggle="modal"
                    data-target="#deleteModal" style="padding: 5px; height: fit-content;">삭제
            </button>
        </c:if>
    </div>

    <div class="panel panel-default">
        <div class="col-md-10 panel-heading"
             style="border-radius:10px ; border: 0; box-shadow: 0 2px 4px 0 rgba(0,0,0,0.2); transition: 0.3s;">

            <div class="panel-body">
                <ul class="chat_list_box" style="font-size:20px; padding: 0;">
                    <strong class="pull-right text-dark" style="padding-top:10px; padding-right:10px "><fmt:formatDate
                            value="${post.postRegDate}" pattern="yyyy-MM-dd"/></strong>
                    <img style="border-radius:70px; margin-left:20px; padding-top:10px"
                         src="../resources/image/${post.userProImg}${post.truckProImg}" width="100"
                         height="100" class="pull-left"/>

                    <br/>
                    <strong id="postingId" class="pull-left"
                            style="padding-top:10px ">${post.postUser.userId}${post.postTruck.truckId}</strong>
                    <br/>
                    <ul class="chat_list" style="font-size:30px; float: right;">
                        <c:choose>
                            <c:when test="${ post.heartNo eq 0}">
                                <%-- 빈 하트일때 --%>
                                <span>
                                            <a idx="${post.postNo }" href="javascript:"
                                               class="heart-click heart_icon${post.postNo }">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                     fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16" style="color: #ffba49">
                                                     <path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z"/>
                                                </svg>
                                            </a>
                                        </span>
                            </c:when>
                            <c:otherwise>
                                <%-- 꽉찬 하트일때 --%>
                                <span>
                                            <a idx="${post.postNo}" href="javascript:"
                                               class="heart-click heart_icon${post.postNo}">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                 fill="currentColor" class="bi bi-suit-heart-fill" viewBox="0 0 16 16" style="color: #ffba49">
                                                 <path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z"/>
                                             </svg>
                                        </a>
                                        </span>
                            </c:otherwise>
                        </c:choose>


                        <span id="heart${post.postNo }">${post.heartCount }</span>
                        <span>
                                <a idx="${post.postNo }" href="javascript:"
                                   class="reply-click reply-icon${post.postNo }">
                                    <i class="fa fa-comments-o fa-lg" aria-hidden="true" style="color: #ffba49"></i>
                                </a>
                        </span>
                        <span id="reply${post.postNo }">${post.replyCount }</span>

                        <span>
                            <i class="fa fa-mouse-pointer" aria-hidden="true" style="color: #ffba49"></i>
						</span> <span id="hit${post.postNo }">${post.postHit }</span>


                    </ul>
                </ul>
                <%--                <ul style="font-size:20px ">--%>
                <%--                    &lt;%&ndash;                <strong>게시글 작성일</strong>&ndash;%&gt;--%>
                <%--                    <small class="pull-right text-dark" colspan="2"><fmt:formatDate value="${post.postRegDate}" pattern="yyyy-MM-dd"/></small>--%>
                <%--                </ul>--%>
                <br/>
                <hr>

                <ul class="chat_list col-11" style="font-size:30px; display: flex;">
                    <strong class="primary-font pull-left" style="font-size: 16px">제목</strong>
                    <strong class="primary-font col-8" style="width: 20%; display: flex;">${post.postTitle}</strong>
                    <%--                <td class="center" colspan="2">${post.postTitle}</td>--%>
                </ul>
                <hr>

                <ul class="col-11" style="display: flex;">
                    <strong class="pull-left" style="font-size:16px ">내용</strong>
                    <midium class="col-8" colspan="2"
                            style="font-size: 14px; display: flex;">${post.postContent}</midium>
                </ul>

                <ul style="padding-left:0; ">
                    <td colspan="1">
                        <br/>
                        <c:if test="${post.postFile1 ne '' and post.postFile1 ne null}">
                            <img src="../../../resources/image/${post.postFile1}" width="500"
                                 height="400" style="border-radius:20px; "/>
                        </c:if>
                    </td>
                </ul>
                <br/>
                <ul style="padding-left:0; ">
                    <td colspan="1">
                        <br/>
                        <c:if test="${post.postFile2 ne '' and post.postFile2 ne null}">
                            <img src="../resources/image/${post.postFile2}" width="500"
                                 height="400" style="border-radius:20px; "/>
                        </c:if>
                    </td>
                </ul>
                <br/>
                <ul style="padding-left:0; ">
                    <td colspan="1">
                        <br/>
                        <c:if test="${post.postFile3 ne '' and post.postFile3 ne null}">
                            <img src="../resources/image/${post.postFile3}" width="500"
                                 height="400" style="border-radius:20px; "/>
                        </c:if>
                    </td>
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
    </div>
    <!-- 게시판 글쓰기 양식 영역 끝 -->


    <br/>
    <hr style="width: 880px; margin-bottom: 30px;"/>
    <%-- 댓글 리스트 --%>
    <div class="reply-list col-8 reply-list${post.postNo }"></div>

    <hr style="width: 880px; margin-top: 30px"/>
    <%-- 댓글 쓰기 --%>
    <div class="col-12 row reply_write"
         style="display: flex; align-items: center; margin-top: 25px; justify-content: center;">
        <div style="padding: 0; display: flex; justify-content: center;">
            <a href="other_profile.do?other_nick=">
                <img id="write_reply_profileImage"
                     style="margin: 0; box-shadow: 0 2px 4px 2px rgb(0 0 0 / 15%); border-radius: 2rem"
                     src="../../../resources/image/${sessionScope.user.userProImg}${sessionScope.truck.truckProImg}"/>
            </a>
        </div>
        <div class="col-sm-6" class="input_reply_div">
            <input class="w-100 form-control" style="height: 35px; border-radius: 50px; padding-left: 10px;"
                   id="input_reply${post.postNo }" type="text" placeholder="댓글입력...">
        </div>
        <div class="col-1" style="padding: 0; text-align: end;">
            <button type="button" idx="${post.postNo }" class="btn btn-default mb-1 write_reply"
                    style="height: 35px; font-size: 12px; padding: 4px 8px 4px 8px; margin: 0; text-align: center; width: 75px;">
                댓글달기
            </button>
        </div>

        <%--
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


                   <%-- <table class="table table-hover table-striped" id="list">
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
                                                     src="../resources/image/${comment.userProImg}${comment.truckProImg}"
                                                     width="60"
                                                     height="55" class="pull-left"/>
                                                <strong style="padding-top:10px"
                                                        class="primary-font pull-left">${comment.commentUserId}${comment.commentTruckId}</strong>
                                                <small class="pull-right text-muted">${comment.commentDate}</small>
                                                <br>
                                                <c:if test="${sessionScope.user.userId.equals(comment.commentUserId) || sessionScope.truck.truckId.equals(comment.commentTruckId)}">
                                                    <a class="btn-outline-dark pull-right"
                                                       href="javascript:void(0)"
                                                       onclick="fncDeleteC('${comment.commentNo}')">삭제</a>
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
    --%>
    </div>

</div>
<jsp:include page="/views/footer.jsp"/>
<script>

    $("body").on("click", ".heart-click", function () {
        // $(".heart-click").click(function () {

        // 게시물 번호(no)를 idx로 전달받아 저장
        let postNo = $(this).attr('idx');
        console.log("postNo: " + postNo);

        // 빈하트를 눌렀을때
        if ($(this).children('svg').attr('class') == "bi bi-suit-heart") {
            console.log("빈하트 클릭" + postNo);

            $.ajax({
                url    : 'json/addHeart',
                type   : 'get',
                data   : {
                    postNo: postNo,
                },
                success: function (pto) {
                    //페이지 새로고침
                    //document.location.reload(true);
                    console.log("pto: " + pto.heartCount)
                    let heart = pto.heartCount;


                    $('#heart' + postNo).text(heart);

                    console.log("하트 추가!!!!!!!!!!");
                },
                error  : function () {
                    alert('서버 에러');
                }
            });
            console.log("하트채워");

            // 꽉찬하트로 바꾸기
            $(this).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
            $('.heart_icon' + postNo).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16' style='color: #ffba49'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");

            // 꽉찬 하트를 눌렀을 때
        } else if ($(this).children('svg').attr('class') == "bi bi-suit-heart-fill") {
            console.log("꽉찬거 하트 클릭 " + postNo);

            $.ajax({
                url    : 'json/removeHeart',
                type   : 'get',
                data   : {
                    postNo: postNo,
                },
                success: function (pto) {
                    //페이지 새로고침
                    //document.location.reload(true);
                    console.log("pto: " + pto)
                    let heart = pto.heartCount;
                    // 페이지에 하트수 갱신
                    //

                    $('#heart' + postNo).text(heart);

                    console.log("하트삭제!!!!!!!!!");
                },
                error  : function () {
                    alert('서버 에러');
                }
            });
            console.log("빈하트!!!!!!!!!");

            // 빈하트로 바꾸기
            $(this).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');

            $('.heart_icon' + postNo).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16" style="color: #ffba49"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
        }


    });


    $("body").on("click", ".write_reply", function () {
        alert("!")
        // 게시물 번호
        let postNo = $(this).attr('idx');
        console.log("postNo: " + postNo)
        //책갈피
        // 댓글 입력란의 내용을 가져온다.
        let commentContent = $("#input_reply" + postNo).val();
        console.log("commentContent : " + commentContent)
        // 앞뒤 공백을 제거한다.(띄어쓰기만 입력했을때 댓글작성안되게 처리하기위함)
        commentContent = commentContent.trim();

        console.log(commentContent);

        if (commentContent == "") {	// 입력된게 없을때
            alert("글을 입력하세요!");
        } else {
            // 입력란 비우기
            $("#input_reply" + postNo).val("");

            // reply+1 하고 그 값을 가져옴
            $.ajax({
                url    : '/community/json/write_reply',
                type   : 'get',
                data   : {
                    postNo        : postNo,
                    commentContent: commentContent
                },
                success: function (pto) {

                    let reply = pto.replyCount;
                    // 페이지, 모달창에 댓글수 갱신

                    $('#reply' + postNo).text(reply);

                    console.log("댓글 작성 성공");

                    // 댓글리스트를 새로 받아오기
                    ReplyList(postNo);
                },
                error  : function () {
                    alert('서버 에러');
                }
            });

        }

    });


</script>

</body>

</html>
