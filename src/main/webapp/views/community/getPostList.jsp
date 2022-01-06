<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">

<head>

    <title>게시글 목록</title>
    <jsp:include page="../../common/lib.jsp"/>
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //=============    검색 / page 두가지 경우 모두  Event  처리 =============
        function fncGetUserList(currentPage) {
            $("#currentPage").val(currentPage)
            $("form").attr("method" , "POST").attr("action" , "/community/getPostList").submit();
        }


        //============= "검색"  Event  처리 =============
        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $( "button.btn.btn-default" ).on("click" , function() {
            	fncGetUserList(1);
            });
        });

        //============= "글쓰기"  Event  처리 =============
        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $( "button.btn.btn-primary" ).on("click" , function() {
                self.location = "/views/community/addPostView.jsp";
            });
        });


        //============= userId 에 회원정보보기  Event  처리(Click) =============
        $(function() {

            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $( "td:nth-child(1)" ).on("click" , function() {
                console.log($(this).text());
                self.location ="/community/getPost?postNo="+$(this).text().trim();
            });

            //==> userId LINK Event End User 에게 보일수 있도록
            $( "td:nth-child(1)" ).css("color" , "orange");

        });

    </script>



</head>



<body id="page-top">

<jsp:include page="/views/navbar.jsp" />
<br/><br/><br/><br/>

<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">

    <div class="page-header text-info">
        <h3>게시판 목록조회</h3>
    </div>

    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
    <div class="row">

        <div class="col-md-6 text-left">
            <p class="text-primary">
                전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
            </p>
        </div>

        <div class="col-md-6 text-right">
            <button type="button" class="btn btn-primary">게시글 작성</button>
        </div>

        <div class="col-md-8 text-right">
            <form class="form-inline" name="detailForm">

                <div class="form-group">
                    <select class="form-control" name="searchCondition" >
                        <option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>작성자ID</option>
                        <option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>게시물제목</option>
                    </select>
                </div>

                <div class="form-group">
                    <label class="sr-only" for="searchKeyword">검색어</label>
                    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
                           value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
                    <button type="button" class="btn btn-default">검색</button>
                </div>


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
            <th align="center">No</th>
            <th align="left" >제목</th>
            <th align="left">작성자 ID</th>
            <th align="left">작성일</th>
            <th align="left">좋아요</th>
        </tr>
        </thead>

        <tbody>

        <c:set var="i" value="0" />
        <c:forEach var="post" items="${list}">
            <c:set var="i" value="${ i+1 }" />
            <tr>
                <td align="center">${post.postNo}</td>
                <td align="left">${post.postTitle}</td>
                <td align="left">${post.postUser.userId}${post.postTruck.truckId}</td>
                <td align="left"><fmt:formatDate value="${post.postRegDate}" pattern="yyyy-MM-dd"/></td>
                <td align="left">
                    <i class="glyphicon glyphicon-ok" id= "${post.postNo}"></i>
                    <input type="hidden" value="${post.postUser}">
                </td>
            </tr>
        </c:forEach>

        </tbody>

    </table>
    <!--  table End /////////////////////////////////////-->




<!-- PageNavigation Start... -->
<jsp:include page="../../common/pageNavigator_new.jsp"/>
<!-- PageNavigation End... -->
</div>
<!--  화면구성 div End /////////////////////////////////////-->


<jsp:include page="/views/footer.jsp" />

</body>

</html>
