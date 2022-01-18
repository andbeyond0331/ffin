<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">

<head>

    <title>F.FIN | 판매 목록</title>
    <jsp:include page="../../common/lib.jsp"/>
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //=============    검색 / page 두가지 경우 모두  Event  처리 =============
        function fncGetUserList(currentPage) {
            $("#currentPage").val(currentPage)
            $("form").attr("method" , "GET").attr("action" , "/truck/getSalesList").submit();
        }


        //============= "검색"  Event  처리 =============

        //============= "글쓰기"  Event  처리 =============
        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $( "button.btn.btn-primary" ).on("click" , function() {
                self.location = "/views/purchase/getCartMenuList.jsp";
            });
        });


        //============= userId 에 회원정보보기  Event  처리(Click) =============
        $(function() {

            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $( "td:nth-child(2)" ).on("click" , function() {
                console.log($(this).text());
                self.location ="/user/getUserProfile?userId="+$(this).text().trim();
            });

            //==> userId LINK Event End User 에게 보일수 있도록
            $( "td:nth-child(2)" ).css("color" , "orange");

        });

    </script>



</head>



<body id="page-top">

<jsp:include page="/views/navbar.jsp" />
<br/><br/><br/><br/>

<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">

    <div class="page-header" align="center">
        <label for="page-top" class="control-label"/>
        <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
        <h4 style="margin-top: 10px;">
            판매 목록</h4>
    </div>
    <br>

    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
    <div class="row">

        <div class="col-md-6 text-left">
            <p class="text-primary">
                전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
            </p>
        </div>

<%--        <div class="col-md-6 text-right">--%>
<%--            <button type="button" class="btn btn-primary">게시글 작성</button>--%>
<%--        </div>--%>

        <div class="col-md-8 text-right">
            <form class="form-inline" name="detailForm">

<%--                                <div class="form-group">--%>
<%--                                    <select class="form-control" name="searchCondition" >--%>
<%--                                        <option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>주문자ID</option>--%>
<%--&lt;%&ndash;                                        <option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>게시물제목</option>&ndash;%&gt;--%>
<%--                                    </select>--%>
<%--                                </div>--%>

<%--                                <div class="form-group">--%>
<%--                                    <label class="sr-only" for="searchKeyword">검색어</label>--%>
<%--                                    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"--%>
<%--                                           value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >--%>
<%--                                    <button type="button" class="btn btn-default">검색</button>--%>
<%--                                </div>--%>


                <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
                <input type="hidden" id="currentPage" name="currentPage" value=""/>

            </form>
        </div>

    </div>
    <!-- table 위쪽 검색 Start /////////////////////////////////////-->


    <!--  table Start /////////////////////////////////////-->
    <table class="table table-hover table-striped" >

        <thead>
        <tr>
            <th style="text-align: center">No</th>
            <%--            <th align="left" >제목</th>--%>
            <th style=" width : 150px; text-align: right">주문자</th>
            <th style="width: 180px"></th>
            <th style="text-align: center">주문일</th>
            <th>요청사항</th>
        </tr>
        </thead>

        <tbody>

        <c:set var="i" value="0" />
        <c:forEach var="order" items="${list}">
            <c:set var="i" value="${ i+1 }" />
            <tr>
                <td style="vertical-align: middle; text-align: center">${order.orderNo}</td>
                <td style="vertical-align: middle; text-align: center"><img style="border-radius:70px; margin-left:5px"
                                                        src="../resources/image/${order.orderUserId.userProImg}" width="60"
                                                        height="60" class="pull-right"/></td>
                <td style="vertical-align: middle">${order.orderUserId.userId}</td>
                <td style="vertical-align: middle; text-align: center"><fmt:formatDate value="${order.payDateTime}" pattern="yyyy-MM-dd"/></td>
                <td style="vertical-align: middle">${order.orderRequest}</td>
            </tr>
        </c:forEach>

        </tbody>

    </table>
    <!--  table End /////////////////////////////////////-->




    <!-- PageNavigation Start... -->
    <jsp:include page="../../common/pageNavigator.jsp"/>
    <!-- PageNavigation End... -->
</div>
<!--  화면구성 div End /////////////////////////////////////-->


<jsp:include page="/views/footer.jsp" />

</body>

</html>
