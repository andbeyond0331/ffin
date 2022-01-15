<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">

<head>

    <title>F.FIN | 게시글 목록</title>
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
            $( "button.btn.btn-dark" ).on("click" , function() {
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
                if($(this).text()=="Blind"){
                    alert("비공개 처리된 게시물입니다!!")
                    return;
                }
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
                    <button type="button" class="btn btn-dark">검색</button>
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
            <th align="left">조회수</th>
        </tr>
        </thead>

        <tbody>

        <c:set var="i" value="0" />
        <c:forEach var="post" items="${list}">
            <c:set var="i" value="${ i+1 }" />
            <tr>
                <c:if test="${post.secretKey==0 && (sessionScope.user != null || sessionScope.truck != null)}">
                <td align="center">${post.postNo}</td>
                <td align="left">${post.postTitle}</td>
                <td align="left">${post.postUser.userId}${post.postTruck.truckId}</td>
                <td align="left"><fmt:formatDate value="${post.postRegDate}" pattern="yyyy-MM-dd"/></td>
                <td align="left">
                    <span> <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
											<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z" />
											<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z" />
										</svg>
						</span> <span id="hit${post.postNo }">${post.postHit }</span>
                    <input type="hidden" value="${post.postUser}">
                </td>
                </c:if>
                <c:if test="${post.secretKey==1 && (sessionScope.user.role != 0 || sessionScope.truck.role == 1)}">
                    <td align="center">Blind</td>
                    <td align="left">비공개 처리된 게시물</td>
                    <td align="left">${post.postUser.userId}${post.postTruck.truckId}</td>
                    <td align="left"><fmt:formatDate value="${post.postRegDate}" pattern="yyyy-MM-dd"/></td>
                    <td align="left">
<%--                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart-fill" viewBox="0 0 16 16">--%>
<%--                            <path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z" />--%>
<%--                        </svg>--%>
                        <span id="heart${post.postNo }">Blind</span>
                        <input type="hidden" value="${post.postUser}">
                    </td>
                </c:if>
                <c:if test="${post.secretKey==1 && sessionScope.user.role == 0}">
                    <td align="center">${post.postNo}</td>
                    <td align="left">비공개 처리된 게시물 입니다.</td>
                    <td align="left">${post.postUser.userId}${post.postTruck.truckId}</td>
                    <td align="left"><fmt:formatDate value="${post.postRegDate}" pattern="yyyy-MM-dd"/></td>
                    <td align="left">
<%--                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart-fill" viewBox="0 0 16 16">--%>
<%--                            <path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z" />--%>
<%--                        </svg>--%>
                        <span id="heart${post.postNo }">Blind</span>
                        <input type="hidden" value="${post.postUser}">
                    </td>
                </c:if>
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
