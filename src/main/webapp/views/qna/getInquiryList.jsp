<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">


<head>

    <title>F.FIN | 문의목록 </title>
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
        #dataTable tbody tr:hover{
            color: #ffba49;
        }
    </style>

    <script type="text/javascript">

        function fncGetUserInquiryList(currentPage) {
            $("#currentPage").val(currentPage)
            $(".userInquiryListForm").attr("method" , "POST").attr("action" , "/qna/getUserInquiryList").submit();
        }
    </script>

</head>

<body>
    <jsp:include page="/views/navbar.jsp" />

    <section class="client_section layout_padding">
        <div class="container">
            <form class="userInquiryListForm" name="detailForm" action="/qna/getUserInquiryList?inquiryId=${inquiry.inquiryUserId}" method="post">
                <input type="hidden" id="inquiryId" name="inquiryId" value="${inquiry.inquiryUserId}">

                <div class="col-md-11 col-lg-12 mx-auto">
                    <div class="detail-box">
                        <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
                        <h4 style="margin-top: 10px;">
                            문의목록
                        </h4>
                    </div>
                    <div style="margin-top: 50px;">

                        <div class="row" style="justify-content: flex-end; margin-right: 20px;">

                            <%--<div class="col-md-6 text-left">
                                <p class="text-primary" style="padding-left: 20px;">
                                    전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
                                </p>
                            </div>--%>

                            <div class="col-md-6 text-right">
                                <div class="form-inline" name="searchForm" style="float: right;">

                                    <div class="form-group">
                                        <select class="form-control" name="searchCondition" style="padding: 1px">
                                            <option value="0" ${!empty search.searchCondition && searchCondition==0 ? "selected" : "" }>문의유형</option>
                                            <option value="1" ${!empty search.searchCondition && searchCondition==1 ? "selected" : "" }>답변여부</option>
                                        </select>
                                    </div>

                                    <div class="form-group" >
                                        <%--@declare id="searchkeyword"--%>
                                        <label class="sr-only" for="searchKeyword">검색어</label>
                                        <input type="text" class="form-control" name="searchKeyword"  placeholder="검색어"
                                               value="${!empty serach.searchKeyword ? serach.searchKeyword : "" }" >
                                    </div>

                                    <button type="button" class="btn btn-default">검색</button>

                                    <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
                                    <input type="hidden" id="currentPage" name="currentPage" value=""/>

                                </div>
                            </div>
                        </div>

                        <div class="card" style="border: 0;">
                            <%--<div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">문의목록임니당</h6>
                            </div>--%>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                        <tr>
                                            <th>문의번호</th>
                                            <th>문의유형</th>
                                            <th>제목</th>
                                            <th>아이디</th>
                                            <th>날짜</th>
                                            <th>답변여부</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:set var="i" value="0" />
                                           <c:forEach var="inquiry" items="${list}">
                                        <c:set var="i" value="${i+1}"/>

                                        <tr>
                                            <td>${inquiry.inquiryNo}</td>
                                            <td>${inquiry.inquiryType}</td>
                                            <td>${inquiry.inquiryTitle}</td>
                                            <td>${inquiry.inquiryUserId}</td>
                                                <%--<c:if test="role eq user">
                                                    <td>${inquiry.inquiryUserId}</td>
                                                </c:if>
                                                <c:if test="role eq truck">
                                                    <td>${inquiry.inquiryTruckId}</td>
                                                </c:if>--%>
                                            <td>${inquiry.inquiryDate}</td>
                                            <td>${inquiry.inquiryAnsStatus}</td>
                                            <%--<td><span><ion-icon name="chevron-down-outline"></ion-icon></span></td>--%>
                                        </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <jsp:include page="../../common/pageNavigator.jsp"/>
        </div>
    </section>

    <jsp:include page="/views/footer.jsp" />
</body>
</html>