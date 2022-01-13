<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">

<head>

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
        .reply_list_profileImage{
            width: 40px;
            height: 40px;
            border: 0px;
            border-radius: 50%;
        }
        #write_reply_profileImage{
            width: 40px;
            height: 40px;
            border: 0px;
            border-radius: 50%;
        }

        ul.tabs{
            margin: 0px;
            padding: 0px;
            list-style: none;
        }
        ul.tabs li{
            background: none;
            color: #222;
            display: inline-block;
            padding: 10px 25px;
            cursor: pointer;
        }

        ul.tabs li.current{
            background: #ededed;
            color: #222;
        }

        .tab-content{
            display: none;
            padding: 15px 0;
            border-top:3px solid #eee;
        }

        .tab-content.current{
            display: inherit;
        }
    </style>

    <title>게시글 목록</title>
    <jsp:include page="../../common/lib.jsp"/>
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //=============    검색 / page 두가지 경우 모두  Event  처리 =============
        function fncGetUserList(currentPage) {
            $("#currentPage").val(currentPage)
            $("form").attr("method", "POST").attr("action", "/community/getPostList").submit();
        }


        //============= "검색"  Event  처리 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-default").on("click", function () {
                fncGetUserList(1);
            });
        });

        //============= "글쓰기"  Event  처리 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-primary").on("click", function () {
                self.location = "/views/community/addPostView.jsp";
            });
        });


        //============= userId 에 회원정보보기  Event  처리(Click) =============
        $(function () {

            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("td:nth-child(1)").on("click", function () {
                console.log($(this).text());
                self.location = "/community/getPost?postNo=" + $(this).text().trim();
            });

            //==> userId LINK Event End User 에게 보일수 있도록
            $("td:nth-child(1)").css("color", "orange");

        });



        //=============    검색 / page 두가지 경우 모두  Event  처리 =============
        function fncGetUserList(currentPage) {
            $("#currentPage").val(currentPage)
            $("form").attr("method" , "POST").attr("action" , "/community/getPostList2").submit();
        }

        var role =  '${sessionScope.role}';
        var proImg;
        var uId;
        if (role == 'user'){
            proImg = '${sessionScope.user.userProImg}';
            uId = '${sessionScope.user.userId}';
        }else if(role=='truck'){
            proImg = '${sessionScope.truck.truckProImg}';
            uId = '${sessionScope.truck.truckId}';
        }



        // 사진 클릭했을 때, modal 호출

        function getCardDetail(postNo) {
            //var role = '${sessionScope.role}';

            $.ajax({
                url:"/community/json/getCardDetail/"+postNo,
                method:"get",

                success: function (data) {
                    var div="";
                    var modalFooter = "";
                    let hit = data.post.postHit;
                    $('#hit'+postNo).text(hit);

                    div += "<div class='row'>"+
                        "</div>";
                    /*  +"<div id='carouselExampleInterval' class='carousel slide' data-ride='carousel'>"
                       +"<div class='carousel-inner'>"
                        +"<div class='carousel-item active'>"
                            +"<img class='d-block w-100' src='../../../resources/image/"+data.post.postFile1+"' alt='First slide'>"
                           +"</div>"
                        +"<div class='carousel-item' >"
                           +"<img class='d-block w-100' src='../../../resources/image/"+data.post.postFile2+"' alt='Second slide'>"
                       +"</div>"
                        +" <div class='carousel-item'>"
                        + " <img class='d-block w-100' src='../../../resources/image/"+data.post.postFile3+"' alt='Third slide'>"
                       +" </div></div>"
                        + " <a class='carousel-control-prev' href='#carouselExampleIndicators' role='button' data-slide='prev'>"
                      + "<span class='carousel-control-prev-icon' aria-hidden='true'></span> <span class='sr-only'>Previous</span>"
                       + "</a>"
                + " <a class='carousel-control-next' href='#carouselExampleIndicators' role='button' data-slide='next'>"
                      +"<span class='carousel-control-next-icon' aria-hidden='true'></span> <span class='sr-only'>Next</span>"
                    + " </a>"
                  +" </div>";*/

                    div+="<div id='carouselExampleInterval' class='carousel slide' data-ride='carousel'>"
                        +"<div class='carousel-inner'>"
                        +"<div class='carousel-item active' data-interval='10000'>"
                        +"<img src='...' class='d-block w-100' alt='...'>"
                        +" </div>"
                        +"<div class='carousel-item' data-interval='2000'>"
                        +"<img src='...' class='d-block w-100' alt='...'>"
                        + "</div>"
                        + " <div class='carousel-item'>"
                        + "<img src='...' class='d-block w-100' alt='...'>"
                        +"</div>"
                        +  "</div>"
                        + " <a class='carousel-control-prev' href='#carouselExampleInterval' role='button' data-slide='prev'>"
                        + "<span class='carousel-control-prev-icon' aria-hidden='true'></span>"
                        + "<span class='sr-only'>Previous</span>"
                        + "  </a>"
                        + " <a class='carousel-control-next' href='#carouselExampleInterval' role='button' data-slide='next'>"
                        +     "<span class='carousel-control-next-icon' aria-hidden='true'></span>"
                        +      "<span class='sr-only'>Next</span>"
                        +  "</a>"
                        + "</div>";




                    /* 슬라이드 해볼랫는데 안먹는당 */


                    /*        +"<div class='row'>"
                          +"<div ><strong></strong> <img src='../../../resources/image/"+data.post.postFile1+"'></div></div>";

                      if (data.post.postFile2 != null){
                          div += "<div class='row'>"
                              +"<div ><strong></strong> <img src='../../../resources/image/"+data.post.postFile2+"'></div></div>";
                      }
                      if (data.post.postFile3 != null){
                          div += "<div class='row'>"
                              +"<div ><strong></strong> <img src='../../../resources/image/"+data.post.postFile3+"'></div></div>";
                      }
      */
                    div += "<div class='row'>"+
                        "<div>"+data.post.postContent+"</div></div>";

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
                        +"<span> <svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-eye' viewBox='0 0 16 16'>"
                        +"<path d='M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z' />"
                        +"<path d='M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z' />"
                        +"</svg>"
                        +"</span> <span id='hit"+data.post.postNo+"'>"+data.post.postHit+"</span>"
                        +"<div class='collapse' id='reply_card"+data.post.postNo+"'>"
                        +"<section class='modal-section'>"
                        +"<div class='card card-body'>"
                        +"<div class='reply-list reply-list"+data.post.postNo+"'>"
                        +"</div>"
                        +"<div class='row reply_write'>"
                        +"<div class='col-1'>"
                        +"<a href='other_profile.do?other_nick='>"
                        +"<img id='write_reply_profileImage' src='/resources/image/"+proImg+"' />"
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
                        +"</div>";


                    if (role == "user"){

                        var userId = '${sessionScope.user.userId}'

                        if (data.post.postTruck == null && data.post.postUser.userId == userId){

                            modalFooter = "<div class='modal-footer'>"
                                +"<button class='button btn-warning' name='deletePostPic' onclick='deletePostPic("+data.post.postNo+");'>글 삭제"
                                +"<input type='hidden' name='postNo' value='"+data.post.postNo+"'/></button>"
                                +"<button class='button is-warning is-light' name='updatePostPicView'"
                                +"onclick='updatePostPicView("+data.post.postNo+");'>글 수정"
                                +"<input type='hidden' name='postNo' value='"+data.post.postNo+"'/>"
                                + "</button>"
                                +"</div>";
                        }else {
                            modalFooter = "<div class='modal-footer'>"
                                + " <button type='button' class='btn btn-secondary' data-dismiss='modal'>Close</button></div>";
                        }

                    }else if(role == "truck"){

                        var truckId = '${sessionScope.truck.truckId}'

                        if (data.post.postUser == null && data.post.postTruck.truckId == truckId){

                            modalFooter = "<div class='modal-footer'>"
                                +"<button class='button btn-warning' name='deletePostPic' onclick='deletePostPic("+data.post.postNo+");'>글 삭제"
                                +"<input type='hidden' name='postNo' value='"+data.post.postNo+"'/></button>"
                                +"<button class='button is-warning is-light' name='updatePostPicView'"
                                +"onclick='updatePostPicView("+data.post.postNo+");'>글 수정"
                                +"<input type='hidden' name='postNo' value='"+data.post.postNo+"'/>"
                                + "</button>"
                                +"</div>";

                        }else {
                            modalFooter = "<div class='modal-footer'>"
                                + " <button type='button' class='btn btn-secondary' data-dismiss='modal'>Close</button></div>";
                        }
                    }

                    $('.modal-footer').remove();
                    $('.modal-content').append(modalFooter);
                    $('.modal-body').html(div);

                    console.log("data.post.postHit: "+data.post.postHit);

                    $('#staticBackdrop').modal('show');







                },
                error : function(err){
                    console.log('에러')
                }
            });



        }

        $(document).ready(function() {
            $('ul.tabs li').click(function() {
                var activeTab = $(this).attr('data-tab');
                $('ul.tabs li').removeClass('current');
                $('.tab-content').removeClass('current');
                $(this).addClass('current');
                $('#' + activeTab).addClass('current');
            })
        });
    </script>


</head>


<body id="page-top">

<jsp:include page="/views/navbar.jsp"/>
<br/><br/><br/><br/>

<div class="container">

    <ul class="tabs">
        <li class="tab-link current" data-tab="tabs-1">일반게시판</li>
        <li class="tab-link" data-tab="tabs-2">썸네일게시판</li>
    </ul>


    <div id="tabs-1" class="tab-content current" >

        <!--  화면구성 div Start /////////////////////////////////////-->

        <div class="page-header text-info">
            <h3>일반게시판</h3>
        </div>

        <!-- table 위쪽 검색 Start /////////////////////////////////////-->
        <div class="row">

            <div class="col-md-6 text-left">
                <p class="text-primary">
                    전체 ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage} 페이지
                </p>
            </div>

            <div class="col-md-6 text-right">
                <button type="button" class="btn btn-primary">게시글 작성</button>
            </div>

            <div class="col-md-8 text-right">
                <form class="form-inline" name="detailForm">

                    <div class="form-group">
                        <select class="form-control" name="searchCondition">
                            <option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>
                                작성자ID
                            </option>
                            <option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>
                                게시물제목
                            </option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="sr-only" for="searchKeyword">검색어</label>
                        <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"
                               placeholder="검색어"
                               value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
                        <button type="button" class="btn btn-default">검색</button>
                    </div>


                    <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
                    <input type="hidden" id="currentPage" name="currentPage" value=""/>

                </form>
            </div>

        </div>
        <!-- table 위쪽 검색 Start /////////////////////////////////////-->


        <!--  table Start /////////////////////////////////////-->
        <table class="table table-hover table-striped">

            <thead>
            <tr>
                <th align="center" class="text-center">No</th>
                <th align="left">제목</th>
                <th align="left">작성자 ID</th>
                <th align="left">작성일</th>
                <th align="center">좋아요</th>
            </tr>
            </thead>

            <tbody>

            <c:set var="i" value="0"/>
            <c:forEach var="post" items="${list}">
                <c:set var="i" value="${ i+1 }"/>
                <tr>
                    <td align="center">${post.postNo}</td>
                    <td align="left">${post.postTitle}</td>
                    <td align="left">${post.postUser.userId}${post.postTruck.truckId}</td>
                    <td align="left"><fmt:formatDate value="${post.postRegDate}" pattern="yyyy-MM-dd"/></td>
                    <td align="left" id="heart${post.postNo }" style="padding-left: 25px">
                            ${post.heartCount }
                    </td>
                </tr>
            </c:forEach>

            </tbody>

        </table>
        <!--  table End /////////////////////////////////////-->


        <!-- PageNavigation Start... -->
        <jsp:include page="../../common/pageNavigator.jsp"/>
        <!-- PageNavigation End... -->
    </div>









    <!--///////////////////// 썸네일형 게시판 ////////////////////////-->
    <!--  화면구성 div End /////////////////////////////////////-->
<div id="tabs-2" class="tab-content">
    <div class="page-header text-info">
        <h3>썸네일게시판</h3>
    </div>

    <input type="hidden" id="currentPage" name="currentPage" value=""/>

    <!-- 등록/ 수정 모달 -->
    <div class="modal fade" id="modaladdPostPic" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="modaladdPostPic" aria-hidden="true" style=" display: none; ">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"></span>
                    </button>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <span> 아이디 </span>
                            <c:if test="${sessionScope.role eq 'user'}">
                                <span id="postUser.userId">${sessionScope.user.userId}</span>
                            </c:if>
                            <c:if test="${sessionScope.role eq 'truck'}">
                                <span id="postTruck.truckId">${sessionScope.truck.truckId}</span>
                            </c:if>
                        </div>
                        <div class="form-group">
                            <label for="postFile1" class="col-sm-offset-1 col-sm-10 control-label">파일 이미지1</label>
                            <div class="col-sm-10">
                                <input type="file" class="form-control" id="postFile1" name="postFile11"
                                       value="${post.postFile1}" placeholder="파일 이미지1"
                                       onchange="setImage1Preview(event, '#image1preview');">
                            </div>
                            <div id="image1preview" class="col-sm-10"></div>
                        </div>

                        <div class="form-group">
                            <label for="postFile2" class="col-sm-offset-1 col-sm-10 control-label">파일 이미지2</label>
                            <div class="col-sm-10">
                                <input type="file" class="form-control" id="postFile2" name="postFile22"
                                       value="${post.postFile2}" placeholder="파일 이미지1"
                                       onchange="setImage2Preview(event);">
                            </div>
                            <div id="image2preview" class="col-sm-10"></div>
                        </div>

                        <div class="form-group">
                            <label for="postFile3" class="col-sm-offset-1 col-sm-10 control-label">파일 이미지3</label>
                            <div class="col-sm-10">
                                <input type="file" class="form-control" id="postFile3" name="postFile33"
                                       value="${post.postFile3}" placeholder="파일 이미지3"
                                       onchange="setImage3Preview(event);">
                            </div>
                            <div id="image3preview" class="col-sm-10"></div>
                        </div>

                        <script>


                            function setImage1Preview(event, tag) {
                                var DIVimage1preview = $(tag);

                                if (tag == "0") {
                                    DIVimage1preview = $("#m_image1preview");
                                }

                                var isTherePreview = DIVimage1preview.find('img').length;
                                alert("isTherePreview : " + isTherePreview);
                                //이미지파일미리보기 이미 있으면 바꾸기 구현 중-  점심먹고 왔다! 다시 시작!
                                var reader = new FileReader();

                                if (isTherePreview == 0) {

                                } else {

                                    DIVimage1preview.find('img').remove();

                                }

                                reader.onload = function (event) {

                                    var div = "<img src='" + event.target.result + "' style='width:50%;'>";
                                    var img = document.createElement("img");

                                    img.setAttribute("src", event.target.result);
                                    img.setAttribute("style", "width:50%");
                                    if (tag == "0") {
                                        //$("#modaladdPostPic").find("#m_image1preview").append(div);
                                        document.querySelector("#m_image1preview").appendChild(div);
                                    } else {

                                        document.querySelector("div#image1preview").appendChild(img);
                                    }

                                };

                                reader.readAsDataURL(event.target.files[0]);


                            }

                            function setImage2Preview(event) {
                                var DIVimage2preview = $('#image2preview');
                                var reader = new FileReader();
                                var isTherePreview = DIVimage2preview.find('img').length;
                                alert("isTherePreview : " + isTherePreview);

                                var reader = new FileReader();

                                if (isTherePreview == 0) {

                                } else {

                                    DIVimage2preview.find('img').remove();

                                }

                                reader.onload = function (event) {
                                    var img = document.createElement("img");
                                    img.setAttribute("src", event.target.result);
                                    img.setAttribute("style", "width:50%");
                                    document.querySelector("div#image2preview").appendChild(img);

                                };

                                reader.readAsDataURL(event.target.files[0]);

                            }

                            function setImage3Preview(event) {
                                var DIVimage3preview = $('#image3preview');
                                var reader = new FileReader();
                                var isTherePreview = DIVimage3preview.find('img').length;
                                alert("isTherePreview : " + isTherePreview);
                                //이미지파일미리보기 이미 있으면 바꾸기 구현 중-  점심먹고 왔다! 다시 시작!
                                var reader = new FileReader();

                                if (isTherePreview == 0) {

                                } else {

                                    DIVimage3preview.find('img').remove();

                                }

                                reader.onload = function (event) {
                                    var img = document.createElement("img");
                                    img.setAttribute("src", event.target.result)
                                    img.setAttribute("style", "width:50%");
                                    document.querySelector("div#image3preview").appendChild(img);

                                };

                                reader.readAsDataURL(event.target.files[0]);

                            }

                        </script>
                        <div id="here"></div>

                        <div class="form-group">
                            <textarea id="postContent" name="postContent" style="resize:none;" rows="5" cols="55"
                                      title="내용을 입력해 주세요.">${post.postContent}</textarea>
                        </div>
                    </form>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="add-post-p">글쓰기</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="staticBackdropLabel" aria-hidden="true">
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

    <form class="form-inline" name="detailForm">
        <div class="card-colums" id="all_posting">
            <div class="container">
                <div>
                    <a class='btn btn-warning' id='modaladdPostPicbt' role='button' data-toggle='collapse'
                       href='#modaladdPostPic' aria-expanded='false' aria-controls='modaladdPostPic'>등록</a>
                </div>
                <div id="card-box" class="cards-box">

                    <c:forEach var="post" items="${list}">
                        <div class="card" name="card" id="card${post.postNo}"
                             style="width: 23rem; margin-bottom:15px; margin-left: 10px;">
                            <img class="card-img-top" src="../../resources/image/${post.postFile1}" alt="Card image cap"
                                 style="border-bottom: 1px solid #eee; height: 300px;"
                                 onclick="getCardDetail(${post.postNo})">
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
                                            <a idx="${post.postNo }" href="javascript:"
                                               class="heart-click heart_icon${post.postNo }">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                     fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16">
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
                                                 fill="currentColor" class="bi bi-suit-heart-fill" viewBox="0 0 16 16">
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
                                   <i class="fas fa-beer"></i>
                                </a>
                        </span>
                                <span id="reply${post.postNo }">${post.replyCount }</span>

                                <span> <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                            fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
											<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
											<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
										</svg>
						</span> <span id="hit${post.postNo }">${post.postHit }</span>


                            </div>
                        </div>
                    </c:forEach>
                </div>


            </div>
        </div>
    </form>
    <!-- PageNavigation Start... -->
    <jsp:include page="../../common/pageNavigator.jsp"/>
    <!-- PageNavigation End... -->
    <script>
        $(function () {

            $("#modaladdPostPic").on('hide.bs.modal', function (e) {
                // self.location = "/catering/listCatering"
                window.location.reload();
                e.stopImmediatePropagation();
            });


        });


        $("body").on("click", ".open_reply_list", function () {
            let postNo = $(this).attr('idx');
            console.log("postNo: " + postNo);
            ReplyList(postNo)
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

                        listHtml += "<div class='row replyrow reply" + commentNo + "'>";

                        if (commentContent == "") {		// 삭제된 댓글일때
                            listHtml += "	<div>";
                            listHtml += "		(삭제된 댓글입니다)";
                            listHtml += "	</div>";
                        } else {
                            if (grpl == 0) {	// 모댓글일때
                                listHtml += "	<div class='col-1'>";
                                listHtml += "		<a href='other_profile.do?other_nick=" + commentUserId + "'> ";
                                listHtml += "			<img class='reply_list_profileImage' src='/resources/image/" + userProImg + "'/>";
                                listHtml += "		</a> ";
                                listHtml += "	</div>";
                                listHtml += "	<div class='rereply-content col-8'>";
                                listHtml += "		<div>";
                                listHtml += "			<span>";
                                listHtml += "				<b>" + commentUserId + "</b>";
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
                                listHtml += "        <a class='btn btn-primary' role='button' data-toggle='collapse' href='#re_reply" + commentNo + "' aria-expanded='false' aria-controls='collapseExample'>답글달기</a>"
                                listHtml += "		</div>";

                                listHtml += "	</div>";

                            } else {	// 답글일때
                                listHtml += "	<div class='col-1'>"
                                listHtml += "	</div>"
                                listHtml += "	<div class='col-1'>";
                                listHtml += "		<img class='reply_list_profileImage' src='/resources/image/" + userProImg + "'/>";
                                listHtml += "	</div>";
                                listHtml += "	<div class='rereply-content" + commentNo + " col-7'>";
                                listHtml += "		<div>";
                                listHtml += "			<span>";
                                listHtml += "				<b>" + commentUserId + "</b>";
                                listHtml += "			</span>";
                                listHtml += "			<span>";
                                listHtml += commentContent;
                                listHtml += "			</span>";
                                listHtml += "		</div>";

                                listHtml += "	</div>";
                            }

                            listHtml += "	<div class='col-3 reply-right'>";
                            listHtml += "		<div>";
                            listHtml += commentDate;
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
                                listHtml += "			<a href='javascript:' no='" + commentNo + "' grpl='" + grpl + "' bno='" + commentPostNo + "' grp='" + grp + "' class='reply_delete'>삭제</a>";
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
                            listHtml += "				<img id='write_reply_profileImage' src='/resources/image/" + proImg + "'/>"
                            listHtml += "			</a> ";
                            listHtml += "		</div>"
                            listHtml += "		<div class='col-7'>"
                            listHtml += "  		<input class='w-100 input_rereply_div form-control' id='input_rereply" + commentNo + "' type='text' placeholder='댓글입력...'>"
                            listHtml += "		</div>"
                            listHtml += "		<div class='col-3'>"
                            // 답글달기 버튼이 눌리면 모댓글 번호(no)와 게시물번호(bno)를 함수에 전달한다.

                            // 동적으로 넣은 html태그에서 발생하는 이벤트는 동적으로 처리해줘야한다 !!!!!
                            // 예를들어, 동적으로 넣은 html태그에서 발생하는 click 이벤트는 html태그 안에서 onclick으로 처리하면 안되고, jquery에서 클래스명이나 id값으로 받아서 처리하도록 해야한다.
                            // 아래코드를 보자~~~~
                            // listHtml += "			<button onclick='javascript:WriteReReply("+ no +","+ bno +")' type='button' class='btn btn-success mb-1 write_rereply' >답글&nbsp;달기</button>"
                            // 위 코드는 클릭되어도 값이 넘겨지지 않는다. 값이 undefined가 된다.
                            // 아래코드처럼 짜야한다. click이벤트를 처리하지 않고 데이터(no, bno)만 속성으로 넘겨주도록 작성한다.<button type='button' class='btn btn-success mb-1 write_rereply' no='" + commentNo + "' bno='" + commentPostNo + "'>답글&nbsp;달기</button>"
                            listHtml += "<a href='javascript:' no='" + commentNo + "' bno='" + commentPostNo + "' class='write_rereply'>답글&nbsp;달기</a>";
                            listHtml += "		</div>";
                            listHtml += "	</div>";
                            // ---- 답글입력란 끝
                        }

                        listHtml += "</div>";


                    }
                    ;

                    ///////////// 동적으로 넣어준 html에 대한 이벤트 처리는 같은 함수내에서 다 해줘야한다.
                    ///////////// $(document).ready(function(){}); 안에 써주면 안된다.
                    var modal = $('#staticBackdrop');
                    //modal.find("span[id='m_heart'"+postNo+"]").text(heart);
                    // 페이지에 하트수 갱신
                    // console.log("listHtml: "+listHtml);
                    // 댓글 리스트 부분에 받아온 댓글 리스트를 넣기
                    modal.find(".reply-list" + postNo).html(listHtml);

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
                        // 페이지, 모달창에 댓글수 갱신
                        var modal = $('#staticBackdrop');

                        // 페이지에 하트수 갱신

                        // 페이지, 모달창에 댓글수 갱신
                        modal.find('#m_reply' + bno).text(reply);//
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
        // 글 수정
        const updatePostPicView = function (postNo) {

            $.ajax({
                url    : '/community/json/getPostPic',
                type   : 'get',
                data   : {
                    postNo: postNo
                },
                success: function (pto) {
                    //$('#modaladdPostPic').modal('hide');
                    var modalPic = $("#modaladdPostPic");
                    var div = "";


                    div += " <form class='form-horizontal'>"
                        + "<div class='form-group'>"
                        + "<span> 아이디 </span>"
                        + "<span id='postId'>" + uId + "</span>"
                        + "  </div>"
                        + "<div class='form-group'>"
                        + " <label for='postFile1' class='col-sm-offset-1 col-sm-10 control-label'>파일 이미지1</label>"
                        + "<div class='col-sm-10'>"
                        + "<input type='file' class='form-control' id='postFile1' name='postFile11'  value='" + pto.post.postFile1 + "' placeholder='파일 이미지1' onchange='setImage1Preview(event, 0);'>"
                        + "</div>"
                        + "<div id='m_image1preview' class='col-sm-10'><img src='../../../resources/image/" + pto.post.postFile1 + "'></div>"
                        + "</div>"
                        + "<div class='form-group'>"
                        + " <label for='postFile2' class='col-sm-offset-1 col-sm-10 control-label'>파일 이미지2</label>"
                        + " <div class='col-sm-10'>"
                        + "<input type='file' class='form-control' id='postFile2' name='postFile22'  value='" + pto.post.postFile2 + "' placeholder='파일 이미지2' onchange='setImage2Preview(event, 0);'>"
                        + "</div>"
                        + "<div id='m_image2preview' class='col-sm-10'></div>"
                        + "</div>"
                        + "<div class='form-group'>"
                        + "<label for='postFile3' class='col-sm-offset-1 col-sm-10 control-label'>파일 이미지3</label>"
                        + " <div class='col-sm-10'>"
                        + " <input type='file' class='form-control' id='postFile3' name='postFile33'  value='" + pto.post.postFile3 + "' placeholder='파일 이미지3' onchange='setImage3Preview(event);'>"
                        + "</div>"
                        + "<div id='m_image3preview' class='col-sm-10'><img src='../../../resources/image/" + pto.post.postFile3 + " '></div>"
                        + " </div>"
                        + "<div id='here'></div>"
                        + "<div class='form-group'>"
                        + "<textarea id='postContent' name = 'postContent' style='resize:none;' rows='5' cols='55' title='내용을 입력해 주세요.'>" + pto.post.postContent + "</textarea>"
                        + "<input name='postNo' type='hidden' value='" + postNo + "'>"
                        + " </div>"
                        + "</form>";
                    div2 = "";
                    div2 +=
                        "<button class='button btn-warning' name='updatePostPic' onclick='fncUpdatePostPic();'>수정"
                        + "</button>"
                        + "<button class='btn btn-secondary' data-dismiss='modal'>취소"
                        + "</button>";
                    $('.modal-body').html(div);
                    $('.modal-footer').html(div2);
                    //$('#modaladdPostPic').modal('show');


                },
                error  : function () {
                    alert('서버 에러');
                }
            });
        }

        function fncUpdatePostPic() {

            $("form").attr("method", "POST").attr("action", "/community/updatePostPic").attr("enctype", "multipart/form-data").submit();

        }

        const updatePostPic = function (postNo) {
            var modalPic = $("#modaladdPostPic");


        }
        // 글 삭제
        const deletePostPic = function (postNo) {
            $.ajax({
                url    : '/community/json/deletePostPic',
                type   : 'get',
                data   : {
                    postNo: postNo
                },
                success: function (pto) {

                    alert("게시물이 삭제되었습니다.")
                    // 삭제 완료 후 reload
                    window.location.reload();
                },
                error  : function () {
                    alert('서버 에러');
                }
            });
        }
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
                    var modal = $('#staticBackdrop');

                    // 페이지에 하트수 갱신

                    // 페이지, 모달창에 댓글수 갱신
                    modal.find('#m_reply' + bno).text(reply);
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
                    alert("!!!!!!!!!!!!!!!!!")
                    let reply = pto.replyCount;

                    var modal = $('#staticBackdrop');

                    // 페이지에 하트수 갱신

                    // 페이지, 모달창에 댓글수 갱신
                    modal.find('#m_reply' + bno).text(reply);
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

                        var modal = $('#staticBackdrop');
                        //modal.find("span[id='m_heart'"+postNo+"]").text(heart);
                        // 페이지에 하트수 갱신
                        modal.find('#m_heart' + postNo).text(heart);
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
                $('.heart_icon' + postNo).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");

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
                        var modal = $('#staticBackdrop');

                        modal.find('#m_heart' + postNo).text(heart);
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

                $('.heart_icon' + postNo).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
            }


        });

        $("body").on("click", ".write_reply", function () {
            var modal = $('#staticBackdrop');
            // 게시물 번호
            let postNo = $(this).attr('idx');
            console.log("postNo: " + postNo)
            //책갈피
            // 댓글 입력란의 내용을 가져온다.
            let commentContent = modal.find("#input_reply" + postNo).val();
            console.log("commentContent : " + commentContent)
            // 앞뒤 공백을 제거한다.(띄어쓰기만 입력했을때 댓글작성안되게 처리하기위함)
            commentContent = commentContent.trim();

            console.log(commentContent);

            if (commentContent == "") {	// 입력된게 없을때
                alert("글을 입력하세요!");
            } else {
                // 입력란 비우기
                modal.find("#input_reply" + postNo).val("");

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
                        var modal = $('#staticBackdrop');

                        modal.find('#m_reply' + postNo).text(reply);
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

        ////// 등록할 모달창 show
        $("body").on("click", "a[id='modaladdPostPicbt']", function () {
            $('#modaladdPostPic').modal('show');
        });

        /////////// 글등록
        $(function () {

            $('#add-post-p').on("click", function () {

                fncAddPostPic();

            });

        });

        function fncAddPostPic() {

            $("form").attr("method", "POST").attr("action", "/community/addPostPic").attr("enctype", "multipart/form-data").submit();

        }
    </script>
</div>
</div>

<jsp:include page="/views/footer.jsp"/>

</body>

</html>
