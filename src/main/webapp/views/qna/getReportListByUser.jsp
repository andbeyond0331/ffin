<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">


<head>

    <title>F.FIN | 신고목록 </title>
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
            transition: 0.2s;
            margin-top: 5px;
            display: flex;
            justify-content: center;
            font-size: 16px;
        }
        .card.mb-10:hover{
            background-color: rgba(255, 229, 55, 0.16);
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
        .report-card{
            display: flex;
            justify-content: space-around;
        }
        .report-con{
            padding: 0;
        }
        .d-grid.gap-2.col-6.mx-auto{
            display: flex;
            justify-content: center;
        }
        .slickContent{
            width: 340px;
            display: block;
            text-overflow: ellipsis;
            white-space: nowrap;
            overflow: hidden;
        }

    </style>

    <script type="text/javascript">

        function fncGetUserList(currentPage) {
            $("#currentPage").val(currentPage)
            $("form").attr("method" , "POST").attr("action" , "/qna/getUserList").submit();
        }

        /* 신고내용 */
        $(function () {
           $('.mb-10').click(function () {

               var reportNo = $(this).find("input[name='reportNo']").val();
               console.log(reportNo);

               $.ajax({
                   url: "/qna/json/getReport/"+reportNo,
                   method: "GET",
                   header : {
                       "Accept" : "application/json",
                       "Content-Type" : "application/json"
                   },
                   success : function (data) {
                       console.log(data.report.reportNo);
                       console.log(data.report.reportLink);
                       console.log(data.report.reportContent);
                       var display = "<div class='card-ans mb-10'>"
                                    + "<div class='row g-0 inquiry-card'>"
                                    + "<div class='card-body'>"
                                    + "<div style='margin: 20px 55px 0 55px;'>"
                                    + "<span>신고링크 : <a class='collapse-item' href='"+data.report.reportLink+"'>"+data.report.reportLink+"</a></span>"
                                    + "<p class='card-text' style='margin-top: 10px'>"+data.report.reportContent+"</p>"
                                    +"</div>"
                                    +"<hr style='border-width:2px; margin-top: 50px;'/>"
                                    +"<div class='d-grid gap-2 col-6 mx-auto' style='margin: 0 55px 0 55px;'>";

                           if(data.report.reportProcStatus === 1){
                               display += "<button class='btn btn-default btn-sm' onclick='nopeBtn("+data.report.reportNo+")' type='button' style='color: #110000;'>신고거절</button>";
                           }

                           display +="<button class='btn btn-default btn-sm' onclick='closeBtn()' type='button' style='color: #110000; background: #ecf0fd'>확인</button>";

                           if(data.report.reportProcStatus === 1){
                                display += "<button class='btn btn-default btn-sm' onclick='okBtn("+data.report.reportNo+")' type='button' style='color: #110000'>신고처리</button>";
                           }

                           display += "</div>"
                                    +"</div>"
                                    +"</div>"
                                    +"</div>";

                       //alert(display);
                       $('.card-ans').remove();
                       $("#"+data.report.reportNo+"").html(display);
                   }
               })

           });
        });


        function closeBtn() {
            $('.card-ans').remove();
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
        <div class="col-md-11 col-lg-12 mx-auto">

            <div class="detail-box">
                <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
                <h4 style="margin-top: 10px;">
                    신고목록
                </h4>
            </div>

            <div class="row search">
                <div class="col-md-6 text-left" style="display: flex; align-items: center;">
                    <p style="margin: 0; font-size: 12px;">
                        전체  ${resultPage.totalCount } 건, 현재 ${resultPage.currentPage}  페이지
                    </p>
                </div>

                <div class="col-md-6 text-right">
                    <form class="form-inline" name="detailForm" style="padding: 0;">

                        <div class="form-group">
                            <select class="form-control" name="searchCondition" >
                                <option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>ID</option>
                                <option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>답변여부</option>
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
                <div class="row g-0 report-card">
                    <div class="col-md-2 report-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted"><strong>신고유형</strong></small></p>
                        </div>
                    </div>
                    <div class="col-md-2 report-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted"><strong>신고대상</strong></small></p>
                        </div>
                    </div>
                    <div class="col-md-4 report-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted"><strong>신고내용</strong></small></p>
                        </div>
                    </div>
                    <div class="col-md-2 report-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted"><strong>신고일</strong></small></p>
                        </div>
                    </div>
                    <div class="col-md-2 report-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted"><strong>처리상태</strong></small></p>
                        </div>
                    </div>
                </div>
            </div>

            <c:set var="i" value="0" />
            <c:forEach var="report" items="${list}">
            <c:set var="i" value="${ i+1 }" />

            <div class="card mb-10">
                <input type="hidden" id="reportNo" name ="reportNo" value="${report.reportNo}">
                <div class="row g-0 report-card">
                    <div class="col-md-2 report-con">
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${report.reportType eq 1}">
                                    <p class="card-text"><small class="text-muted">광고/도배</small></p>
                                </c:when>
                                <c:when test="${report.reportType eq 2}">
                                    <p class="card-text"><small class="text-muted">욕설/인신공격</small></p>
                                </c:when>
                                <c:when test="${report.reportType eq 3}">
                                    <p class="card-text"><small class="text-muted">개인정보침해</small></p>
                                </c:when>
                                <c:when test="${report.reportType eq 4}">
                                    <p class="card-text"><small class="text-muted">음란성/선정성</small></p>
                                </c:when>
                                <c:when test="${report.reportType eq 5}">
                                    <p class="card-text"><small class="text-muted">명예훼손/저작권</small></p>
                                </c:when>
                                <c:when test="${report.reportType eq 6}">
                                    <p class="card-text"><small class="text-muted">기타</small></p>
                                </c:when>
                            </c:choose>
                        </div>
                    </div>
                    <div class="col-md-2 report-con">
                        <div class="card-body">
                            <p class="card-text">
                                <small class="text-muted">${report.reportTargetId}</small>
                            </p>
                        </div>
                    </div>
                    <div class="col-md-4 report-con">
                        <div class="card-body">
                            <p class="card-text" style="text-align: initial;">
                                <small class="text-muted slickContent">${report.reportContent}</small>
                            </p>
                        </div>
                    </div>
                    <div class="col-md-2 report-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted">${report.reportDate}</small></p>
                        </div>
                    </div>
                    <div class="col-md-2 report-con">
                        <div class="card-body">
                            <c:if test="${report.reportProcStatus eq 1}">
                                <p class="card-text"><small class="text-muted"><span class="badge" style="background-color: #ffe537; color: #110000">처리중</span></small></p>
                            </c:if>
                            <c:if test="${report.reportProcStatus eq 2}">
                                <p class="card-text"><small class="text-muted"><span class="badge" style="background-color: #ffba49; color: #110000">신고처리</span></small></p>
                            </c:if>
                            <c:if test="${report.reportProcStatus eq 3}">
                                <p class="card-text"><small class="text-muted"><span class="badge" style="background-color: #f17228; color: #110000">신고거절</span></small></p>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

                <div id="${report.reportNo}"></div>
            </c:forEach>

            <%-- ajax ex --%>
            <%--<div class="card-ans mb-10">
                <div class="row g-0 inquiry-card">
                    <div class="card-body">
                        <div style="margin: 20px 55px 0 55px;">
                            <span>신고링크 : <a class="collapse-item" href="reportLink">reportLink</a></span>
                            <p class="card-text">문의내용입니당~asdgaejsdhasfkjsahfskkhahadkhsdafkhl</p>
                        </div>
                        <hr style="border-width:2px; margin-top: 50px;"/>
                        <div class="d-grid gap-2 col-6 mx-auto" style="margin: 0 55px 0 55px;">
                            <c:if test="${report.reportProcStatus eq 1}">
                            <button class="btn btn-default btn-sm nopeBtn" type="button" style="color: #110000;">신고거절</button>
                            </c:if>
                            <button class="btn btn-default btn-sm nopeBtn" type="button" style="color: #110000; background: #ecf0fd">확인</button>
                            <c:if test="${report.reportProcStatus eq 1}">
                            <button class="btn btn-default btn-sm okBtn" type="button" style="color: #110000">신고처리</button>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>--%>
        </div>
    </div>
</section>
    <jsp:include page="../../common/pageNavigator_new.jsp"/>
    <jsp:include page="/views/footer.jsp" />
</body>
</html>