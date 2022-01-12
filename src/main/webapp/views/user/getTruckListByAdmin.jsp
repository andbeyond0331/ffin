<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">


<head>

    <title>F.FIN | 푸드트럭목록 </title>
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
        .truck-card{
            box-shadow: 0 1px 2px 1px rgba(0,0,0,0.1);
            transition: 0.2s;
            border: 0;
            margin-top: 20px;

        }
        .card-img-top{

        }



    </style>

    <script type="text/javascript">

    </script>

</head>

<body>
<jsp:include page="/views/navbar.jsp" />

<section class="client_section layout_padding">

    <div class="container">
        <div class="col-md-12 col-lg-12 mx-auto">

            <div class="detail-box">
                <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
                <h4 style="margin-top: 10px;">
                    푸드트럭 목록
                </h4>
            </div>

            <div class="row search">
                <div class="col-md-6 text-left">
                    <p class="text-primary">
                        전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
                    </p>
                </div>

                <div class="col-md-6 text-right">
                    <form class="form-inline" name="detailForm">

                        <div class="form-group">
                            <select class="form-control" name="searchCondition" >
                                <option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>ID</option>
                                <option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>성명</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label class="sr-only" for="searchKeyword">검색어</label>
                            <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
                                   value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
                        </div>

                        <button type="button" class="btn btn-default">검색</button>

                        <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
                        <input type="hidden" id="currentPage" name="currentPage" value=""/>

                    </form>
                </div>
            </div>

            <div class="card mb-10">
                <div class="row row-cols-1 row-cols-md-4 g-4">

                    <c:set var="i" value="0" />
                    <c:forEach var="truck" items="${list}">
                    <c:set var="i" value="${ i+1 }" />

                    <%--<div class="col col-md-4">
                        <div class="card truck-card">
                            <img src="../../resources/image/truckPro.png" class="card-img-top" alt="...">
                            <div class="card-body">
                                <h6 class="card-title"><strong>${truck.truckName}</strong></h6>
                                <p class="card-text">content</p>
                            </div>
                        </div>
                    </div>--%>
                        <li>
                            <div>
                                <figure class="figure">
                                    <img src="../../resources/image/user_img.jpg" class="figure-img img-fluid rounded" alt="...">
                                </figure>
                                <a class="shot-thumbnail-link" href="">
                                    <span class="accessibility-text">View Title!</span>
                                </a>
                                <div class="shot-thumbnail-overlay">
                                    <div class="shot-thumbnail-overlay-content">
                                        <div class="shot-title">turck!</div>
                                    </div>
                                    <ul class="js-dribbble-shot-actions shot-actions-container">
                                        <li data-bucket-container="true" class="shot-action">
                                            <a class="bucket-shot form-btn" data-bucket-add="true" data-screenshot-id="17251219" data-screenshot-user-id="108671" data-is-from-modal="false" title="Save shot" href=""></a>
                                        </li>
                                        <div class="like-action shot-action">
                                            <a class="bucket-shot form-btn" data-bucket-add="true" data-screenshot-id="17251219" data-screenshot-user-id="108671" data-is-from-modal="false" title="Save shot" href=""></a>
                                        </div>
                                    </ul>
                                </div>
                            </div>
                            <div class="shot-details-container js-shot-details-container" style="visibility: visible;">
                                <div class="user-information">
                                    <a class="hoverable url" rel="contact" href="/andrewcolinbeck">
                                        <img class="photo lazyloaded" alt="Andrew Colin Beck" width="24" height="24" data-src="">
                                        <span class="display-name">truckName</span>
                                    </a>
                                </div>
                                <div class="shot-statistics-container js-shot-statistics">
                                    <div class="shot-statistic js-shot-likes-container">
                                        <div class="like">
                                            <span class="">좋아요수? 별점?</span>
                                        </div>
                                    </div>
                                    <div class="shot-statistic js-shot-views-container">
                                        <div class="like">
                                            <span class="">좋아요수? 별점?</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>



                    </c:forEach>
                </div>
            </div>
        </div>
    </div>

</section>
<jsp:include page="../../common/pageNavigator_new.jsp"/>
<jsp:include page="/views/footer.jsp" />
</body>
</html>
