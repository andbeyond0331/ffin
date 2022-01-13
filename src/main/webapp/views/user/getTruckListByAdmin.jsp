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
        .item {
            position: relative;
            float: left;
            width: 33%;
            background-color: #fae100;
            overflow: hidden;
            border-radius: 10px;
        }
        .item:after {
             content: '';
             display: block;
             background-color: inherit;
             opacity: 0.5;
             width: 100%;
             height: 100%;
             position: absolute;
             top: 0;
             left: 0;
             transform: scale(2) translateX(-75%) translateY(-75%) translateZ(0) rotate(-28deg);
             transition: transform 2s cubic-bezier(0.23, 1, 0.32, 1);
             border-radius: 10px;
        }
        .item:hover:after {
             transform: scale(2) translateX(0%) translateY(0%) translateZ(0) rotate(-28deg);
            border-radius: 5px;
         }
        .item:hover .item-image{
            transform: scale(1.2) translateZ(0);
            border-radius: 10px;
        }
        .item:hover .item-text{
            opacity: 1;
            transform: translateY(0);
        }
        .item-image {
            height: auto;
            backface-visibility: hidden;
            transform: translateZ(0);
            transition: transform 750ms cubic-bezier(0.23, 1, 0.32, 1);
        }
        .item-image:before {
             content: "";
             display: block;
             padding-top: 75%;
             overflow: hidden;
        }
        .item-image img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: auto;
            line-height: 0;
            border-radius: 10px;
            background-color: white;
        }
        .item-text {
            position: absolute;
            top: 0;
            right: 0;
            left: 0;
            bottom: 0;
            opacity: 0;
            text-align: center;
            z-index: 1;
            color: #110000;
            transition: opacity 500ms cubic-bezier(0.23, 1, 0.32, 1), transform 500ms cubic-bezier(0.23, 1, 0.32, 1);
            transition-delay: 300ms;
            transform: translateY(-20%);
        }
        .item-text-wrapper {
            width: 100%;
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
        }
        .item-text-title {
            font-weight: normal;
            /*font-style: 16px;*/
            padding: 0 15px;
            margin: 5px 0 0 0;
        }
        .item-text-dek {
            text-transform: uppercase;
           /* font-style: 14px;*/
            opacity: 0.7;
            margin: 0;
        }
        .item-link {
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            z-index: 2;
            line-height: 0;
            overflow: hidden;
            text-indent: -9999px;
        }
        .item-truck{
            width: 33%;
            display: flex;
            justify-content: space-between;
            margin-top: 5px;
            padding: 5px;
        }

    </style>

    <script type="text/javascript">

        function getTruckInfo(){

            var truckId =  document.getElementById("truckIdId").value
            alert(truckId);

            self.location ="/truck/getTruck?truckId="+truckId;
        }

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
                        전체  ${resultPage.totalCount } 건, 현재 ${resultPage.currentPage}  페이지
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

            <div class="card mb-12" style="border: 0;">

                    <c:set var="i" value="0" />
                    <c:forEach var="truck" items="${list}">
                    <c:set var="i" value="${ i+1 }" />

                        <div class="card mb-4" style="border: 0;">
                            <div style="display: flex; flex-direction: column;">
                                <input type="hidden" id="truckIdId" name="truckIdId" value="${truck.truckId}">
                            <div class="item">
                                <div class="item-image">
                                    <c:if test="${truck.truckProImg != null }">
                                        <img src="../../resources/image/${truck.truckProImg}" alt="" />
                                    </c:if>
                                    <c:if test="${truck.truckProImg == null }">
                                        <img src="/resources/image/truckPro.png" alt="" />
                                    </c:if>
                                </div>
                                <div class="item-text">
                                    <div class="item-text-wrapper">
                                        <p class="item-text-dek">${truck.truckSigMenuName}</p>
                                        <h6 class="item-text-title">${truck.truckCEOIntro}</h6>
                                    </div>
                                </div>
                                <a class="item-link" href="#" onclick="getTruckInfo()"></a>
                            </div>
                            <div class="item-truck">
                                <span>${truck.truckName}</span>
                                <span><i class="fas fa-star"></i>${truck.truckAVGStar}4.4</span>
                            </div>
                        </div>
                    </div>
                    </c:forEach>

            </div>
        </div>
    </div>

</section>
<jsp:include page="../../common/pageNavigator_new.jsp"/>
<jsp:include page="/views/footer.jsp" />
</body>
</html>
