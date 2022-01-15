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
            justify-content: center;
        }
        #inquiryAnsContent{
            min-height: 150px;
        }
    </style>

    <script type="text/javascript">

        //다시다시
        /*function fncGetInquiryList(currentPage) {
            $("#currentPage").val(currentPage)
            $("form").attr("method" , "POST").attr("action" , "/qna/getInquiryListByAdmin").submit();
        }
*/

        /* 문의 내용 펼치기 */
        $(function () {

           $('.mb-10').click(function () {

               var inquiryNo = $(this).find("input[name='inquiryNo']").val();
               // alert(inquiryNo);

               $.ajax({
                   url : "/qna/json/getInquiry/"+inquiryNo,
                   method : "GET",
                   dataType: "json",
                   header : {
                       "Accept" : "application/json",
                       "Content-Type" : "application/json"
                   },
                   success : function (Data) {
                       console.log(Data.inquiry.inquiryNo);
                       var display = "<div class='card-ans mb-10'>"
                                    + "<div class='row g-0 inquiry-card'>"
                                    + "<div class='card-body'>"
                                    + "<div style='margin: 0 55px 0 55px;'>";

                       if(Data.inquiry.inquiryFile != null){
                           display += "<img src="+Data.inquiry.inquiryFile+"'../../resources/image' class='card-img-top' alt='inquiryFile' style='width: 200px;'>";
                       }

                       display  += "<p class='card-text'>"+Data.inquiry.inquiryContent+"</p>"
                                    + "</div>"
                                    + "<hr style='border-width:2px;'/>";

                       if(Data.inquiry.inquiryAnsStatus === 1 ){

                           display += "<div class='d-grid gap-2 col-6 mx-auto' style='margin: 0 55px 0 55px;'>"
                                    + "<button class='btn btn-default btn-sm' onclick='closeBtn()' type='button' style='color: #110000; background: #ecf0fd'>확인</button>"
                                    + "<button class='btn btn-default btn-sm' data-bs-toggle='modal' data-bs-target='#addInquiryAns' onclick='addInquiryAns("+Data.inquiry.inquiryNo+")' type='button'>답변등록</button>"
                                    + "</div>";
                       } else {
                           display += "<div style='margin: 0 55px 0 55px;'>"
                               + "<div style='display: flex; justify-content: space-between'>"
                               + "<h6 class='card-title'>"+Data.inquiry.inquiryAnsTitle+"</h6>"
                               + "<p class='card-text'>"+Data.inquiry.inquiryAnsDate+"</p>"
                               + "</div>"
                               + "<p class='card-text'>"+Data.inquiry.inquiryAnsContent+"</p>"
                               + "<div class='d-grid gap-2 col-6 mx-auto' style='margin: 0 55px 0 55px;'>"
                               + "<button class='btn btn-default btn-sm' onclick='closeBtn()' type='button' style='color: #110000; background: #ecf0fd'>확인</button>"
                               + "</div>"
                               + "</div>"
                               + "</div>"
                               + "</div>";
                       }

                       //alert(display);
                       $(".card-ans").remove();
                       $("#"+Data.inquiry.inquiryNo+"").html(display);
                   }
               });
           }) ;
        });

        function closeBtn() {
            $('.card-ans').remove();
        }

        /* 답변모달 */
        function addInquiryAns(inquiryNo){

            // var inquiry_No = $('this').data(inquiryNo);
            $('#hiddenInquiryNo').val(inquiryNo);
            // alert($('#hiddenInquiryNo').parents().html());
            var no = $('#hiddenInquiryNo').val();
            //alert(no);
            $('#addInquiryAns').modal('show');
        }

        /* 답변등록 */
        $(function () {

            $('#updateInquiryAnsBtn').click(function () {

                var inquiryNo = $('#hiddenInquiryNo').val();
                var inquiryAnsTitle = $('#inquiryAnsTitle').val();
                var inquiryAnsContent = $('#inquiryAnsContent').val();

                console.log(inquiryNo);
                console.log(inquiryAnsTitle);
                console.log(inquiryAnsContent);

                $.ajax({

                    url : "/qna/json/updateInquiryAns",
                    method : "POST",
                    dataType: "json",
                    header : {
                        "Accept" : "application/json",
                        "Content-Type" : "application/json"
                    },
                    data : {
                        inquiryNo : inquiryNo,
                        inquiryAnsTitle : inquiryAnsTitle,
                        inquiryAnsContent : inquiryAnsContent
                    },
                    success : function (data){
                        console.log(data);
                        window.location.reload();
                    }
                });
            });
        });

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
                    문의목록
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

            <div class="card mb-10 sub-title">
                <div class="row g-0 inquiry-card">
                    <div class="col-md-2 inquiry-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted"><strong>문의유형</strong></small></p>
                        </div>
                    </div>
                    <div class="col-md-5 inquiry-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted"><strong>문의제목</strong></small></p>
                        </div>
                    </div>
                    <div class="col-md-1 inquiry-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted"><strong>회원ID</strong></small></p>
                        </div>
                    </div>
                    <div class="col-md-1 inquiry-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted"><strong>문의일</strong></small></p>
                        </div>
                    </div>
                    <div class="col-md-1 inquiry-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted"><strong>답변상태</strong></small></p>
                        </div>
                    </div>
                </div>
            </div>

            <c:set var="i" value="0" />
            <c:forEach var="inquiry" items="${list}">
            <c:set var="i" value="${ i+1 }" />

            <div class="card mb-10">
                <div class="row g-0 inquiry-card">
                    <div class="col-md-2 inquiry-con">
                        <div class="card-body">
                            <input type="hidden" id="inquiryNo" name ="inquiryNo" value="${inquiry.inquiryNo}">
                            <c:choose>
                                <c:when test="${inquiry.inquiryType eq 1}">
                                    <p class="card-text"><small class="text-muted">사이트 이용</small></p>
                                </c:when>
                                <c:when test="${inquiry.inquiryType eq 2}">
                                    <p class="card-text"><small class="text-muted">푸드트럭</small></p>
                                </c:when>
                                <c:when test="${inquiry.inquiryType eq 3}">
                                    <p class="card-text"><small class="text-muted">주문</small></p>
                                </c:when>
                                <c:when test="${inquiry.inquiryType eq 4}">
                                    <p class="card-text"><small class="text-muted">기타</small></p>
                                </c:when>
                            </c:choose>
                        </div>
                    </div>
                    <div class="col-md-5 inquiry-con">
                        <div class="card-body">
                            <p class="card-text" style="text-align: initial;">
                                <small class="text-muted">${inquiry.inquiryTitle}</small>
                            </p>
                        </div>
                    </div>
                    <div class="col-md-1 inquiry-con">
                        <div class="card-body">
                            <c:if test="${inquiry.inquiryUserRole eq 1}">
                                <p class="card-text"><small class="text-muted">${inquiry.inquiryUserId}</small></p>
                            </c:if>
                            <c:if test="${inquiry.inquiryUserRole eq 2}">
                                <p class="card-text"><small class="text-muted">${inquiry.inquiryTruckId}</small></p>
                            </c:if>
                        </div>
                    </div>
                    <div class="col-md-1 inquiry-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted">${inquiry.inquiryDate}</small></p>
                        </div>
                    </div>
                    <div class="col-md-1 inquiry-con">
                        <div class="card-body">
                            <c:if test="${inquiry.inquiryAnsStatus eq 1}">
                                <p class="card-text"><small class="text-muted"><span class="badge" style="background-color: #ffe537; color: #110000">답변대기중</span></small></p>
                            </c:if>
                            <c:if test="${inquiry.inquiryAnsStatus eq 2}">
                                <p class="card-text"><small class="text-muted"><span class="badge" style="background-color: #ffba49; color: #110000">답변완료</span></small></p>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

                <div id="${inquiry.inquiryNo}"></div>

            </c:forEach>

            <div class="show"></div>

            <%-- ajax ex --%>

<%--            <div class="card-ans mb-10">
                <div class="row g-0 inquiry-card">
                    <div class="card-body">
                        <div style="margin: 0 55px 0 55px;">
                            <c:if test="${inquiry.inquiryFile != null }">
                            <img src="../../resources/image/moma.png" class="card-img-top" alt="inquiryFile" style="width: 200px;">
                            </c:if>
                            <p class="card-text">문의내용입니당~asdgaejsdhasfkjsahfskkhahadkhsdafkhl</p>
                        </div>
                        <hr style="border-width:2px;"/>
                        <c:if test="${inquiry.inquiryAnsStatus eq 0 }">
                            <div class="d-grid gap-2 col-6 mx-auto" style="margin: 0 55px 0 55px;">
                                <button class="btn btn-primary" type="button">답변등록</button>
                            </div>
                        </c:if>
                        <c:if test="${inquiry.inquiryAnsStatus eq 1 }">
                        <div style="margin: 0 55px 0 55px;">
                            <div style="display: flex; justify-content: space-between">
                                <h6 class="card-title">문의답변제목 : 안녕하세요 고갱님!</h6>
                                <p class="card-text">답변일입니당~</p>
                            </div>
                            <p class="card-text">답변내용입니당~</p>
                        </div>
                        </c:if>
                    </div>
                </div>
            </div>--%>

        </div>
    </div>

    <div class="modal fade" id="addInquiryAns" tabindex="-1" aria-labelledby="addInquiryAns" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">문의 답변</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="hiddenInquiryNo" name ="hiddenInquiryNo" value="">
                    <form style="text-align: left;">
                        <div class="mb-3">
                            <label for="inquiryAnsTitle" class="col-form-label">답변 제목</label>
                            <input type="text" class="form-control" id="inquiryAnsTitle">
                        </div>
                        <div class="mb-3">
                            <label for="inquiryAnsContent" class="col-form-label">답변 내용</label>
                            <textarea class="form-control" id="inquiryAnsContent"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-default btn-sm" id="updateInquiryAnsBtn">답변등록</button>
                </div>
            </div>
        </div>
    </div>

</section>
    <jsp:include page="/views/footer.jsp" />
</body>
</html>