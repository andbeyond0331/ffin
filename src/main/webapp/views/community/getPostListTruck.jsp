<%@ page import="com.ffin.service.domain.Catering" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<style>
    .cards-box {
        display: flex;
        justify-content: flex-start;
        margin: 0 70px;
        margin-top: 65px;
        flex-wrap: wrap;

    }
    img{ max-width:100%;}
    body{
        background-size: cover;
    }
    html, body {
        margin: 0;
        padding: 0;
        font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
        font-size: 14px;
    }
    .container{
        margin-top: 132px
    }
</style>
<script type="text/javascript">

    // 사진 클릭했을 때, modal 호출

    function getCardDetail(postNo) {
        var role = '${sessionScope.role}';

        $.ajax({
            url:"/community/json/getCardDetail/"+postNo,
            method:"get",

            success: function (data) {
                var div="";
                var modalFooter = "";

                div += "<div class='row'>"+
                    "<div><strong>제목</strong> : "+data.post.postTitle+"</div></div>"
                      +"<div class='row'>"
                    +"<div ><strong></strong> <img src='../../../resources/image/"+data.post.postFile1+"'></div></div>";

                if (data.post.postFile2 != null){
                    div += "<div class='row'>"
                        +"<div ><strong></strong> <img src='../../../resources/image/"+data.post.postFile2+"'></div></div>";
                }
                if (data.post.postFile3 != null){
                    div += "<div class='row'>"
                        +"<div ><strong></strong> <img src='../../../resources/image/"+data.post.postFile3+"'></div></div>";
                }

                if (data.post.heartNo == '0'){

                    div +=" <a idx="+data.post.postNo+" href='javascript:' class='heart-click heart_icon"+data.post.postNo+"'>"
                                                +"<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart' viewBox='0 0 16 16'>"
                                                    + "<path d='M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z' />"
                                                +"</svg> </a> ";
                }else{

                    div +=  "<a idx="+data.post.postNo+" href='javascript:' class='heart-click heart_icon"+data.post.postNo+"'>"
                        +"<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'>"
                        +"<path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z' />"
                  + " </svg></a>";
                }
                div += " <span id='m_heart"+data.post.postNo+"'>"+data.post.heartCount+"</span>"
                    +"<span>"
                        +"<a idx='"+data.post.postNo+"' href='#reply_card"+data.post.postNo+"' role='button' class='open_reply_list' data-toggle='collapse'  aria-expanded='false' aria-controls='collapseExample'> "
                          +"<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-chat-dots' viewBox='0 0 16 16'>"
													+"<path d='M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z' />"
													+"<path d='M2.165 15.803l.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z' />"
                            +"</svg>"
                            +"</a>"
                       +" </span>"
+" <span id='m_reply"+data.post.postNo+"'>"+data.post.replyCount+"</span>"
                 +"<div class='collapse' id='reply_card"+data.post.postNo+"'>"
                   +"<section class='modal-section'>"
                        +"<div class='card card-body'>"
                            +"<div class='reply-list reply-list"+data.post.postNo+"'>"
                            +"</div>"
                                +"<div class='row reply_write'>"
                                    +"<div class='col-1'>"
                                        +"<a href='other_profile.do?other_nick='>"
                                           +"<img id='write_reply_profileImage' src='/resources/image/1.jpg' />"
                                       +" </a>"
                                    +"</div>"
                                    +"<div class='col-8' class='input_reply_div'>"
                                        +"<input class='w-100 form-control' id='input_reply"+data.post.postNo+"' type='text' placeholder='댓글입력...'>"
                                    +"</div>"
                                    +"<div class='col-3 '>"
                                        +"<button type='button' idx='"+data.post.postNo+"' class='btn btn-success mb-1 write_reply'>댓글&nbsp;달기</button>"
                                   +"</div>"
                               +" </div>"
                       +" </div>"
                   +" </section>"
                +"</div>"
                +"<div class='row'>"+
                    "<div>"+data.post.postContent+"</div></div>";


                if (role == "user"){

                    var userId = '${sessionScope.user.userId}'

                    if (data.post.postTruck == null && data.post.postUser.userId == userId){

                        modalFooter = "<div class='modal-footer'>"
                            +"<button type='button' class='btn btn-outline-info' id='updateCtServ' name='updateCtServ' onclick='updateCtServ();'>수정</button>"
                            +"<button type='button' class='btn btn-outline-danger' id='deleteCtServ' name='deleteCtServ' onclick='deleteCtServ();'>삭제</button>"
                            +"</div>";
                    }else {
                        modalFooter = "<div class='modal-footer'>"
                            + " <button type='button' class='btn btn-secondary' data-dismiss='modal'>Close</button></div>";
                    }

                }else if(role == "truck"){

                    var truckId = '${sessionScope.truck.truckId}'

                    if (data.post.postUser == null && data.post.postTruck.truckId == truckId){

                        modalFooter = "<div class='modal-footer'>"
                            +"<button type='button' class='btn btn-outline-info' id='updateCtServ' name='updateCtServ' onclick='updateCtServ();'>수정</button>"
                            +"<button type='button' class='btn btn-outline-danger' id='deleteCtServ' name='deleteCtServ' onclick='deleteCtServ();'>삭제</button>"
                            +"</div>";
                    }else {
                        modalFooter = "<div class='modal-footer'>"
                            + " <button type='button' class='btn btn-secondary' data-dismiss='modal'>Close</button></div>";
                    }
                }

                $('.modal-footer').remove();
                $('.modal-content').append(modalFooter);
                $('.modal-body').html(div);


                $('#staticBackdrop').modal('show');


            },
            error : function(err){
                console.log('에러')
            }
        });



    }





</script>


<head>
    <title>트럭 게시판</title>
    <jsp:include page="../../common/lib.jsp"/>


</head>

<body id="page-top">
<jsp:include page="/views/navbar.jsp" />

<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"></span>
                </button>
            </div>
            <div class="modal-body"></div>

            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>


<div class="card-colums" id="all_posting">
    <div class="container">
        <div id="card-box" class="cards-box">
            <c:forEach var="post" items="${list}">
                <div class="card" name ="card" id="card${post.postNo}" style="width: 23rem; margin-bottom:15px; margin-left: 10px;" >
                    <img class="card-img-top" src="../../resources/image/${post.postFile1}" alt="Card image cap"
                         style="border-bottom: 1px solid #eee; height: 300px;" onclick="getCardDetail(${post.postNo})">
                    <div class="card-body">
                        <ul class='card-body-ul'>

                            <%--<c:if test="${sessionScope.role eq 'user'}">--%>
                                <li> ${post.postUser.userId} ${post.postTruck.truckId}</li>
                            <%--</c:if>
                            <c:if test="${sessionScope.role eq 'truck'}">--%>
                               <%-- <li> ${post.postTruck.truckId}</li>--%>
                            <%--</c:if>--%>
                            <li>${post.postTitle}</li>
                            <li>${post.postContent}</li>
                            <li>${post.postRegDate}</li>
                        </ul>


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
                        <span id="reply${post.postNo }">${post.heartCount }</span>
                    </div>
                </div>
            </c:forEach>
        </div>


    </div>
</div>
<script>

    $("body").on("click", ".open_reply_list", function() {
        let postNo = $(this).attr('idx');
        console.log("postNo: " + postNo);
        ReplyList(postNo)
    });

    const ReplyList = function(no) {
        console.log("no: "+no)
        let postNo = no;
        $.ajax({
            url : '/community/json/replyList',
            type : 'get',
            data : {
                postNo : postNo
            },
            success : function(data) {

                console.log("댓글 리스트 가져오기 성공");
                console.log("data: "+data);



                // 댓글 목록을 html로 담기
                let listHtml = "";
                for(const i in data.replyList){

                    let commentNo = data.replyList[i].commentNo;
                    let commentPostNo = data.replyList[i].commentPostNo;
                    let grp = data.replyList[i].grp;
                    let grps = data.replyList[i].grps;
                    let grpl = data.replyList[i].grpl;
                    let commentUserId = data.replyList[i].commentUserId;
                    let commentTruckId = data.replyList[i].commentTruckId;
                    let commentContent =data.replyList[i].commentContent;
                    let commentDate = data.replyList[i].commentDate;
                    let wgap = data.replyList[i].wgap;
                    let userProImg = data.replyList[i].userProImg;

                    console.log(grpl);	// 모댓글일땐 0, 답글일땐 1
                    console.log("commentNo : "+commentNo)
                    listHtml += "<div class='row replyrow reply" + commentNo + "'>";

                    if(commentContent == ""){		// 삭제된 댓글일때
                        listHtml += "	<div>";
                        listHtml += "		(삭제된 댓글입니다)";
                        listHtml += "	</div>";
                    }else{
                        if(grpl == 0){	// 모댓글일때
                            listHtml += "	<div class='col-1'>";
                            listHtml += "		<a href='other_profile.do?other_nick="+commentUserId+"'> ";
                            listHtml += "			<img class='reply_list_profileImage' src='/resources/image/1.jpg'/>";
                            listHtml += "		</a> ";
                            listHtml += "	</div>";
                            listHtml += "	<div class='rereply-content col-8'>";
                            listHtml += "		<div>";
                            listHtml += "			<span>";
                            listHtml += "				<b>"+ commentUserId +"</b>";
                            listHtml += "			</span>";
                            listHtml += "			<span>";
                            listHtml += 				commentContent;
                            listHtml += "			</span>";
                            listHtml += "		</div>";
                            // 현재 로그인 상태일때 답글작성 버튼이 나온다.
                            if("${sessionScope.user.userId}" != ""){
                                listHtml += "		<div>";
                                // 함수에 게시글번호(bno), 모댓글번호(no), 모댓글 작성자(writer)를 인자로 담아서 넘긴다.
                                // 이때 모댓글 작성자 writer는 string인데 string을 인자에 넣기 위해선''나""로 감싸줘야한다.
                                // 여기선 ''와 ""가 이미 둘다 쓰이고 있는데  href를 감싸고 있는 ''와 겹치지 않는 ""를 \" 처리해서 넣어줬다.
                                //listHtml += "			<a href='#re_reply"+ commentNo +"' class='write_reply_start' role='button' data-bs-toggle='collapse' aria-expanded='false' aria-controls='re_reply"+ commentNo +"'>답글1&nbsp;달기</a>";
                                //listHtml += "			<button type='button' class='write_reply_start' no='" + commentNo + "' bno='" + commentPostNo + "' data-bs-toggle='collapse' data-bs-target='#re_reply"+ commentNo +"' aria-expanded='false' aria-controls='re_reply"+ commentNo +"'>답글&nbsp;달기</button>";
                                listHtml +="        <a class='btn btn-primary' role='button' data-toggle='collapse' href='#re_reply"+ commentNo +"' aria-expanded='false' aria-controls='collapseExample'>답글달기</a>"
                                listHtml += "		</div>";
                            }
                            listHtml += "	</div>";

                        }else{	// 답글일때
                            listHtml += "	<div class='col-1'>"
                            listHtml += "	</div>"
                            listHtml += "	<div class='col-1'>";
                            listHtml += "		<img class='reply_list_profileImage' src='/resources/image/1.jpg'/>";
                            listHtml += "	</div>";
                            listHtml += "	<div class='rereply-content"+ commentNo +" col-7'>";
                            listHtml += "		<div>";
                            listHtml += "			<span>";
                            listHtml += "				<b>"+ commentUserId +"</b>";
                            listHtml += "			</span>";
                            listHtml += "			<span>";
                            listHtml += 				commentContent;
                            listHtml += "			</span>";
                            listHtml += "		</div>";

                            listHtml += "	</div>";
                        }

                        listHtml += "	<div class='col-3 reply-right'>";
                        listHtml += "		<div>";
                        listHtml += 			commentDate;
                        listHtml += "		</div>";
                        // 책갈피
                        // 현재 로그인 상태이고..
                        if("${sessionScope.user.userId}" != ""){

                            //현재 사용자가 이 댓글의 작성자일때 삭제 버튼이 나온다.
                            if("${sessionScope.user.userId}" == commentUserId){
                                listHtml += "		<div>";
                                // 수정할 댓글의 no를 grpl과 함께 넘긴다.
                                // 모댓글 수정칸과 답글 수정칸을 화면에 다르게 나타내야하기 때문에 모댓글과 답글을 구분하는 grpl을 함께 넘겨주어야한다.
                                //listHtml += "			<a href='javascript:' no='"+ no +"' grpl='"+ grpl +"' class='reply_modify'>수정</a>";
                                //listHtml += "			&nbsp;|&nbsp;";
                                // 삭제는 no만 넘겨주면 된다.
                                listHtml += "			<a href='javascript:' no='"+ commentNo +"' grpl='"+ grpl + "' bno='"+ commentPostNo +"' grp='"+ grp +"' class='reply_delete'>삭1제</a>";
/*
                                listHtml += '			<a class="btn btn-primary" role="button" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample">삭제</a>'
*/
                                listHtml += "		</div>";
                            }
                        }

                        listHtml += "	</div>";
                        // 댓글에 답글달기를 누르면 답글입력란이 나온다.
                        // ---- 답글입력란
                        //listHtml += "	<div class='collapse row rereply_write' id='re_reply"+ commentNo +"'>";
                        listHtml += "<div class='collapse row rereply_write' id='re_reply"+ commentNo +"'>";
                        listHtml += "		<div class='col-1'>"
                        listHtml += "		</div>"
                        listHtml += "		<div class='col-1'>"
                        listHtml += "			<a href='other_profile.do?other_nick="+commentUserId+"'> ";
                        listHtml += "				<img id='write_reply_profileImage' src='/resources/image/1.jpg'/>"
                        listHtml += "			</a> ";
                        listHtml += "		</div>"
                        listHtml += "		<div class='col-7'>"
                        listHtml +=  "  		<input class='w-100 input_rereply_div form-control' id='input_rereply"+ commentNo +"' type='text' placeholder='댓글입력...'>"
                        listHtml += "		</div>"
                        listHtml += "		<div class='col-3'>"
                        // 답글달기 버튼이 눌리면 모댓글 번호(no)와 게시물번호(bno)를 함수에 전달한다.

                        // 동적으로 넣은 html태그에서 발생하는 이벤트는 동적으로 처리해줘야한다 !!!!!
                        // 예를들어, 동적으로 넣은 html태그에서 발생하는 click 이벤트는 html태그 안에서 onclick으로 처리하면 안되고, jquery에서 클래스명이나 id값으로 받아서 처리하도록 해야한다.
                        // 아래코드를 보자~~~~
                        // listHtml += "			<button onclick='javascript:WriteReReply("+ no +","+ bno +")' type='button' class='btn btn-success mb-1 write_rereply' >답글&nbsp;달기</button>"
                        // 위 코드는 클릭되어도 값이 넘겨지지 않는다. 값이 undefined가 된다.
                        // 아래코드처럼 짜야한다. click이벤트를 처리하지 않고 데이터(no, bno)만 속성으로 넘겨주도록 작성한다.<button type='button' class='btn btn-success mb-1 write_rereply' no='" + commentNo + "' bno='" + commentPostNo + "'>답글&nbsp;달기</button>"
                        listHtml += "<a href='javascript:' no='"+ commentNo + "' bno='"+ commentPostNo +"' class='write_rereply'>답글&nbsp;달기</a>";
                        listHtml += "		</div>";
                        listHtml += "	</div>";
                        // ---- 답글입력란 끝
                    }

                    listHtml += "</div>";


                };

                ///////////// 동적으로 넣어준 html에 대한 이벤트 처리는 같은 함수내에서 다 해줘야한다.
                ///////////// $(document).ready(function(){}); 안에 써주면 안된다.
                var modal = $('#staticBackdrop');
                //modal.find("span[id='m_heart'"+postNo+"]").text(heart);
                // 페이지에 하트수 갱신
                // console.log("listHtml: "+listHtml);
                // 댓글 리스트 부분에 받아온 댓글 리스트를 넣기
                modal.find(".reply-list"+postNo).html(listHtml);

                // 답글에서 답글달기를 누르면 input란에 "@답글작성자"가 들어간다.
                //$('.write_re_reply_start').on('click', function(){
                //	$('#input_rereply'+ $(this).attr('no')).val("@"+$(this).attr('writer')+" ");
                //});

                //답글을 작성한 후 답글달기 버튼을 눌렀을 때 그 click event를 아래처럼 jquery로 처리한다.
                $('.write_rereply').on( 'click', function() {
                    console.log( 'no', $(this).attr('no') );
                    console.log( 'bno', $(this).attr('bno') );

                    // 답글을 DB에 저장하는 함수를 호출한다. bno와 no를 같이 넘겨주어야한다.
                    WriteReReply($(this).attr('bno'), $(this).attr('no') );
                })

                // 삭제버튼을 클릭했을 때
                $('.reply_delete').on('click', function(){
                    // 모댓글 삭제일때
                    if($(this).attr('grpl') == 0){
                        DeleteReply($(this).attr('no'), $(this).attr('bno'));

                        // 답글 삭제일때
                    }else{

                        DeleteReReply($(this).attr('no'), $(this).attr('bno'), $(this).attr('grp'));
                    }

                })


            },
            error : function() {
                alert('서버 에러');
            }
        });


    };

    // 답글 달기 버튼 클릭시  실행 - 답글 저장, 댓글 갯수 가져오기
    const WriteReReply = function(bno,no) {


        console.log(bno);
        console.log(no);

        console.log($("#input_rereply" + no).val());

        // 댓글 입력란의 내용을 가져온다.
        // ||"" 를 붙인 이유  => 앞뒤 공백을 제거한다.(띄어쓰기만 입력했을때 댓글작성안되게 처리하기위함)
        let content = $("#input_rereply" + no).val();
        content = content.trim();


        if(content == ""){	// 입력된게 없을때
            alert("글을 입력하세요!");
        }else{
            // 입력란 비우기
            $("#input_rereply" + no).val("");

            // reply+1 하고 그 값을 가져옴
            $.ajax({
                url : '/community/json/write_rereply',
                type : 'get',
                data : {
                    commentNo : no,
                    commentPostNo : bno,
                    commentContent: content
                },
                success : function(pto) {
                    alert("여기!!!!!!")
                    let reply = pto.replyCount;
                    // 페이지, 모달창에 댓글수 갱신

                    $('#m_reply'+bno).text(reply);//
                    $('#reply'+bno).text(reply);

                    console.log("답글 작성 성공");

                    // 게시물 번호(bno)에 해당하는 댓글리스트를 새로 받아오기
                    ReplyList(bno);
                },
                error : function() {
                    alert('서버 에러');
                }
            });

        };
    };

    // 모댓글 삭제일때
    const DeleteReply = function(no, bno){
        // grp이 no인 댓글이 있는 경우 content에 null을 넣고 없으면 삭제한다.
        $.ajax({
            url : '/community/json/delete_reply',
            type : 'get',
            data : {
                commentNo : no,
                commentPostNo : bno
            },
            success : function(pto) {

                let reply = pto.replyCount;

                // 페이지, 모달창에 댓글수 갱신
                $('#m_reply'+bno).text(reply);
                $('#reply'+bno).text(reply);

                console.log("모댓글 삭제 성공");

                // 게시물 번호(bno)에 해당하는 댓글리스트를 새로 받아오기
                ReplyList(bno);
            },
            error : function() {
                alert('서버 에러');
            }
        });
    };

    // 답글 삭제일때
    const DeleteReReply = function(no, bno, grp){

        //console.log("grp : " + grp);
        console.log("no: "+no+", bno: "+bno+", grp: "+grp)
        // 답글을 삭제한다.
        $.ajax({
            url : '/community/json/delete_rereply',
            type : 'get',
            data : {
                commentNo : no,
                commentPostNo : bno,
                grp : grp
            },
            success : function(pto) {
                alert("!!!!!!!!!!!!!!!!!")
                let reply = pto.replyCount;

                // 페이지, 모달창에 댓글수 갱신
                $('#m_reply'+bno).text(reply);
                $('#reply'+bno).text(reply);

                console.log("답글 삭제 성공");

                // 게시물 번호(bno)에 해당하는 댓글리스트를 새로 받아오기
                ReplyList(bno);
            },
            error : function() {
                alert('서버 에러');
            }
        });

    };


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

                    var modal = $('#staticBackdrop');
                    //modal.find("span[id='m_heart'"+postNo+"]").text(heart);
                     // 페이지에 하트수 갱신
                     modal.find('#m_heart'+postNo).text(heart);
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
                    var modal = $('#staticBackdrop');

                    modal.find('#m_heart'+postNo).text(heart);
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

    $("body").on("click", ".write_reply", function() {
        var modal = $('#staticBackdrop');
        // 게시물 번호
        let postNo = $(this).attr('idx');
        console.log("postNo: "+postNo)
        //책갈피
        // 댓글 입력란의 내용을 가져온다.
        let commentContent =  modal.find("#input_reply" + postNo).val();
        console.log("commentContent : "+commentContent)
        // 앞뒤 공백을 제거한다.(띄어쓰기만 입력했을때 댓글작성안되게 처리하기위함)
        commentContent = commentContent.trim();

        console.log(commentContent);

        if(commentContent == ""){	// 입력된게 없을때
            alert("글을 입력하세요!");
        }else{
            // 입력란 비우기
            modal.find("#input_reply" + postNo).val("");

            // reply+1 하고 그 값을 가져옴
            $.ajax({
                url : '/community/json/write_reply',
                type : 'get',
                data : {
                    postNo : postNo,
                    commentContent: commentContent
                },
                success : function(pto) {

                    let reply = pto.replyCount;
                    // 페이지, 모달창에 댓글수 갱신
                    $('#m_reply'+postNo).text(reply);
                    $('#reply'+postNo).text(reply);

                    console.log("댓글 작성 성공");

                    // 댓글리스트를 새로 받아오기
                    ReplyList(postNo);
                },
                error : function() {
                    alert('서버 에러');
                }
            });

        }

    });


</script>



</body>
</html>