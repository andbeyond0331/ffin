<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">


<head>

    <title>F.FIN | 블랙리스트 목록 </title>
    <jsp:include page="../../common/lib.jsp"/>

    <!-- bootstrap core css -->
    <link rel="stylesheet" type="text/css" href="../../resources/bootstrap/css/bootstrap.css" />
    <!-- Custom styles for this template -->
    <link href="../../resources/bootstrap/css/style.css" rel="stylesheet" />

    <!--    Favicons-->
    <link rel="apple-touch-icon" sizes="180x180" href="../../resources/bootstrap/assets/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="../../resources/bootstrap/assets/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../../resources/bootstrap/assets/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="../../resources/bootstrap/assets/favicons/favicon.ico">
    <link rel="manifest" href="../../resources/bootstrap/assets/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="../../resources/bootstrap/assets/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">

    <style>

        .search{
            margin-top: 100px;
        }


        .search{
            margin-top: 100px;
        }

        #dataTable thead tr th, #dataTable tbody tr td{
            text-align: center;
        }

        #dataTable tbody tr:hover{
            color: #ffba49;
        }

        .form-inline{
            float: right;
            padding-right: 20px;
        }
        .card.mb-10{
            width: auto;
            min-height: 50px;
            box-shadow: 0 1px 2px 1px rgba(0,0,0,0.1);
            transition: 0.1s;
            margin-top: 5px;
            display: flex;
            justify-content: center;
            font-size: 16px;
        }
        .card.mb-10:hover{
            background-color: rgba(255, 229, 55, 0.16);
        }
        .card.mb-10.sub-title:hover{
            background-color: rgb(255, 255, 255);
        }
        .card-ans{
            box-shadow: 0 1px 2px 1px rgba(0,0,0,0.2);
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
        .card-text{
            padding: 0;
        }
        .inquiry-card{
            display: flex;
            justify-content: space-around;
        }
        .inquiry-con{
            padding: 0;
        }
        .d-grid.gap-2.col-6.mx-auto{
            display: flex;
            justify-content: space-around;
        }


    </style>

    <script type="text/javascript">

        function fncGetUserList(currentPage) {
            $("#currentPage").val(currentPage)
            $("form").attr("method", "POST").attr("action", "/user/getBlackList").submit();
        }

    </script>

</head>

<body>
<jsp:include page="/views/navbar.jsp" />
<div style="height: auto">
    <jsp:include page="/views/user/sidebar.jsp" />
</div>

<section class="client_section layout_padding">

    <div class="container">
        <div class="col-md-12 col-lg-12 mx-auto">

            <div class="detail-box">
                <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
                <h4 style="margin-top: 10px;">
                    블랙리스트 목록
                </h4>
            </div>

            <div class="row search" style="margin-bottom: 20px;">
                <div class="col-md-6 text-left" style="display: flex; align-items: center;">
                    <p style="margin: 0; font-size: 12px;">
                        전체  ${resultPage.totalCount } 건, 현재 ${resultPage.currentPage}  페이지
                    </p>
                </div>

                <div class="col-md-6 text-right">
                    <form class="form-inline" name="detailForm" style="zoom: 90%; padding: 0; float: right;">

                        <div class="form-group">
                            <select class="form-control" name="searchCondition" >
                                <option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>ID</option>
                                <option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>답변여부</option>
                            </select>
                        </div>
                        <style>.nice-select.form-control{min-width: 95px;}</style>

                        <div class="form-group">
                            <label class="sr-only" for="searchKeyword">검색어</label>
                            <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
                                   value="${! empty search.searchKeyword ? search.searchKeyword : '' }" style="width: 200px;" >
                        </div>

                        <button type="button" class="btn btn-cancle" style="zoom: 90%;">검색</button>

                        <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
                        <input type="hidden" id="currentPage" name="currentPage" value=""/>

                    </form>
                </div>
            </div>

            <div class="card mb-10 sub-title">
                <div class="row g-0 inquiry-card">
                    <div class="col-md-2 inquiry-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted"><strong>상태</strong></small></p>
                        </div>
                    </div>
                    <div class="col-md-2 inquiry-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted"><strong>아이디</strong></small></p>
                        </div>
                    </div>
                    <div class="col-md-2 inquiry-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted"><strong>이름</strong></small></p>
                        </div>
                    </div>
                    <div class="col-md-2 inquiry-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted"><strong>신고횟수</strong></small></p>
                        </div>
                    </div>
                    <div class="col-md-2 inquiry-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted"><strong>등록일</strong></small></p>
                        </div>
                    </div>
                    <div class="col-md-2 inquiry-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted"><strong>해제일</strong></small></p>
                        </div>
                    </div>
                </div>
            </div>

            <c:set var="i" value="0" />
            <c:forEach var="user" items="${list}">
                <c:set var="i" value="${ i+1 }" />

                <div class="card mb-10">
                    <div class="row g-0 inquiry-card">
                          <div class="col-md-2 inquiry-con">
                            <div class="card-body">
                                <c:if test="${user.reportCount % 3 == 0 && user.reportCount != 0 }">
                                    <p class="card-text"><small class="text-muted"><span class="badge" style="background-color: #25323c; color: #ffffff">블랙리스트</span></small></p>
                                </c:if>
                            </div>
                        </div>
                        <div class="col-md-2 inquiry-con">
                            <div class="card-body">
                                <p class="card-text"><small class="text-muted">${user.userId}</small></p>
                            </div>
                        </div>
                        <div class="col-md-2 inquiry-con">
                            <div class="card-body">
                                <p class="card-text"><small class="text-muted">${user.userName}</small></p>
                            </div>
                        </div>
                        <div class="col-md-2 inquiry-con">
                            <div class="card-body">
                                <p class="card-text"><small class="text-muted">${user.reportCount}</small></p>
                            </div>
                        </div>
                        <div class="col-md-2 inquiry-con">
                            <div class="card-body">
                                <p class="card-text"><small class="text-muted">${user.blackRegDate}</small></p>
                            </div>
                        </div>
                        <div class="col-md-2 inquiry-con">
                            <div class="card-body">
                                <p class="card-text"><small class="text-muted">${user.blackEndDate}</small></p>
                            </div>
                        </div>
                    </div>
                </div>

                <div id=""></div>

            </c:forEach>

            <div class="show"></div>

        </div>
    </div>

</section>
<jsp:include page="../../common/pageNavigator_new.jsp"/>
<jsp:include page="/views/footer.jsp" />
</body>
</html>
