<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">

<head>

    <title>F.FIN | 게시글 목록</title>
    <jsp:include page="../../common/lib.jsp"/>

    <!-- bootstrap core css -->
    <link rel="stylesheet" type="text/css" href="../../resources/bootstrap/css/bootstrap.css"/>
    <!-- Custom styles for this template -->
    <link href="../../resources/bootstrap/css/style.css" rel="stylesheet"/>

    <!--    Favicons-->
    <link rel="apple-touch-icon" sizes="180x180" href="../../resources/bootstrap/assets/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="../../resources/bootstrap/assets/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../../resources/bootstrap/assets/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="../../resources/bootstrap/assets/favicons/favicon.ico">
    <link rel="manifest" href="../../resources/bootstrap/assets/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="../../resources/bootstrap/assets/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">

    <style>

        .search {
            margin-top: 100px;
        }

        #dataTable thead tr th, #dataTable tbody tr td {
            text-align: center;
        }

        #dataTable tbody tr:hover {
            color: #ffba49;
        }

        .form-inline {
            float: right;
            padding-right: 20px;
        }

        .card.mb-12 {
            width: auto;
            min-height: 50px;
            box-shadow: 0 1px 2px 1px rgba(0, 0, 0, 0.1);
            transition: 0.2s;
            margin-top: 5px;
            display: flex;
            justify-content: center;
            font-size: 18px;
        }

        .card.mb-12:hover {
            background-color: rgba(255, 229, 55, 0.16);
        }

        .card.mb-12.sub-title:hover {
            background-color: rgb(255, 255, 255);
        }

        .card.mb-11 {
            width: auto;
            min-height: 50px;
            box-shadow: 0 1px 2px 1px rgba(0, 0, 0, 0.1);
            transition: 0.2s;
            margin-top: 5px;
            display: flex;
            justify-content: center;
            font-size: 18px;
        }

        .card-ans {
            box-shadow: 0 1px 2px 1px rgba(0, 0, 0, 0.2);
            transition: 0.2s;
            margin-top: 5px;
            /*display: flex;
            justify-content: flex-start;*/
            text-align: left;
            font-size: 14px;
            padding: 30px;
        }

        .card-body {
            padding: 0;
        }

        .card-text {
            padding: 0;
        }

        .inquiry-card {
            display: flex;
            justify-content: space-around;
        }

        .inquiry-con {
            padding: 0;
        }

        .d-grid.gap-2.col-6.mx-auto {
            display: flex;
            justify-content: center;
        }

        #inquiryAnsContent {
            min-height: 150px;
        }
    </style>

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
            $("button.btn.btn-dark").on("click", function () {
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
        // $(function () {

            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            // $("td:nth-child(1)").on("click", function () {
            //     console.log($(this).text());
            //     if ($(this).text() == "Blind") {
            //         alert("비공개 처리된 게시물입니다!!")
            //         return;
            //     }
            //     self.location = "/community/getPost?postNo=" + $(this).text().trim();
            // });

            $(function () {

                $('.mb-12').click(function () {

                    var postNo = $(this).find("input[name='postNo']").val();

                    if (postNo == "Blind") {
                        alert("비공개 처리된 게시물입니다!!")
                        return;
                    }
                    self.location = "/community/getPost?postNo=" + postNo;
                });
                //==> userId LINK Event End User 에게 보일수 있도록
                $('.mb-12').css("color", "orange");

            });

    </script>


</head>


<body id="page-top">

<jsp:include page="/views/navbar.jsp"/>
<br/><br/><br/><br/>

<!--  화면구성 div Start /////////////////////////////////////-->
<section class="client_section layout_padding">

    <div class="container">

        <div class="col-md-15 col-lg-15 mx-auto">

            <div class="detail-box">
                <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
                <h4 style="margin-top: 10px;">
                    게시판 목록조회
                </h4>
            </div>

            <!-- table 위쪽 검색 Start /////////////////////////////////////-->

            <div class="row search">
                <div class="col-md-3 text-left" style="display: flex; align-items: center;">
                    <p style="margin: 0; font-size: 14px;">
                        전체 ${resultPage.totalCount } 건, 현재 ${resultPage.currentPage} 페이지
                    </p>
                </div>

                <div class="col-sm-7 text-right">
                    <form class="form-inline" name="detailForm" style="padding-top: 10px;">

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

                        <div class="form-group pull-left">
                            <label class="sr-only" for="searchKeyword">검색어</label>
                            <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"
                                   placeholder="검색어"
                                   value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
                            <button type="button" class="btn btn-dark">검색</button>
                        </div>


                        <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
                        <input type="hidden" id="currentPage" name="currentPage" value=""/>

                    </form>
                </div>
                    <div class="col-md-2 button-pull-right" style="display: flex; align-items: center ">
                        <button type="button" class="btn btn-primary" style="margin-bottom:5px ">게시글 작성</button>
                    </div>

            </div>
            <!-- table 위쪽 검색 Start /////////////////////////////////////-->


            <!--  table Start /////////////////////////////////////-->
            <div class="card mb-11 sub-title">
                <div class="row g-0 inquiry-card">
                    <div class="col-md-1 inquiry-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted"><strong>No</strong></small></p>
                        </div>
                    </div>
                    <div class="col-md-4 inquiry-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted"><strong>제목</strong></small></p>
                        </div>
                    </div>
                    <div class="col-md-1 inquiry-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted"><strong>작성자 ID</strong></small></p>
                        </div>
                    </div>
                    <div class="col-md-2 inquiry-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted"><strong>작성일</strong></small></p>
                        </div>
                    </div>
                    <div class="col-md-1 inquiry-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted"><strong>조회수</strong></small></p>
                        </div>
                    </div>
                </div>
            </div>

            <c:set var="i" value="0"/>
            <c:forEach var="post" items="${list}">
                <c:set var="i" value="${ i+1 }"/>


                <div class="card mb-12">
                    <div class="row g-0 inquiry-card">

                        <c:if test="${post.secretKey==0 && (sessionScope.user != null || sessionScope.truck != null)}">
                            <div class="col-md-1 inquiry-con">
                                <div class="card-body">
                                    <input type="hidden" name="postNo" value="${post.postNo}">
                                    <p class="card-text"><small class="text-muted">${post.postNo}</small></p>
                                </div>
                            </div>
                            <div class="col-md-4 inquiry-con">
                                <div class="card-body">
                                    <p class="card-text"><small class="text-muted">${post.postTitle}</small></p>
                                </div>
                            </div>
                            <div class="col-md-1 inquiry-con">
                                <div class="card-body">
                                    <p class="card-text"><small
                                            class="text-muted">${post.postUser.userId}${post.postTruck.truckId}</small>
                                    </p>
                                </div>
                            </div>
                            <div class="col-md-2 inquiry-con">
                                <div class="card-body">
                                    <p class="card-text"><small class="text-muted"><fmt:formatDate
                                            value="${post.postRegDate}"
                                            pattern="yyyy-MM-dd"/></small></p>
                                </div>
                            </div>
                            <div class="col-md-1 inquiry-con">
                                <div class="card-body">
                                    <p class="card-text"><small class="text-muted"><span> <svg
                                            xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                            fill="currentColor"
                                            class="bi bi-eye" viewBox="0 0 16 16">
											<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
											<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
										</svg>
						</span> <span id="hit${post.postNo }">${post.postHit }</span>
                                        <input type="hidden" value="${post.postUser}"></small></p>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${post.secretKey == 1 && (sessionScope.role ne 'admin' || sessionScope.truck.role == 1)}">
                            <div class="col-md-1 inquiry-con">
                                <div class="card-body">
                                    <input type="hidden" name="postNo" value="Blind">
                                    <p class="card-text"><small class="text-muted">Blind</small></p>
                                </div>
                            </div>
                            <div class="col-md-4 inquiry-con">
                                <div class="card-body">
                                    <p class="card-text"><small class="text-muted">관리자에 의해 비공개 처리된 게시물입니다.</small></p>
                                </div>
                            </div>
                            <div class="col-md-1 inquiry-con">
                                <div class="card-body">
                                    <p class="card-text"><small
                                            class="text-muted">${post.postUser.userId}${post.postTruck.truckId}</small>
                                    </p>
                                </div>
                            </div>
                            <div class="col-md-2 inquiry-con">
                                <div class="card-body">
                                    <p class="card-text"><small class="text-muted"><fmt:formatDate
                                            value="${post.postRegDate}"
                                            pattern="yyyy-MM-dd"/></small></p>
                                </div>
                            </div>
                            <div class="col-md-1 inquiry-con">
                                <div class="card-body">
                                    <p class="card-text"><small class="text-muted"><span
                                            id="heart${post.postNo }">Blind</span>
                                        <input type="hidden" value="${post.postUser}"></small></p>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${post.secretKey==1 && sessionScope.role.equals(admin)}">
                            <div class="col-md-1 inquiry-con">
                                <div class="card-body">
                                    <input type="hidden" name="postNo" value="${post.postNo}">
                                    <p class="card-text"><small class="text-muted">${post.postNo}</small></p>
                                </div>
                            </div>
                            <div class="col-md-4 inquiry-con">
                                <div class="card-body">
                                    <p class="card-text"><small class="text-muted">관리자에 의해 비공개 처리된 게시물 입니다.</small></p>
                                </div>
                            </div>
                            <div class="col-md-1 inquiry-con">
                                <div class="card-body">
                                    <p class="card-text"><small
                                            class="text-muted">${post.postUser.userId}${post.postTruck.truckId}</small>
                                    </p>
                                </div>
                            </div>
                            <div class="col-md-2 inquiry-con">
                                <div class="card-body">
                                    <p class="card-text"><small class="text-muted"><fmt:formatDate
                                            value="${post.postRegDate}"
                                            pattern="yyyy-MM-dd"/></small></p>
                                </div>
                            </div>
                            <div class="col-md-1 inquiry-con">
                                <div class="card-body">
                                    <p class="card-text"><small class="text-muted"><span
                                            id="heart${post.postNo }">Blind</span>
                                        <input type="hidden" value="${post.postUser}"></small></p>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:forEach>

        </div class="show">
    </div>
    <!--  table End /////////////////////////////////////-->


    </div>
    </div>
    </div>
    <br/><br/>
    <!-- PageNavigation Start... -->
    <jsp:include page="../../common/pageNavigator.jsp"/>
    <!-- PageNavigation End... -->
</section>
<!--  화면구성 div End /////////////////////////////////////-->


<jsp:include page="/views/footer.jsp"/>

</body>

</html>
