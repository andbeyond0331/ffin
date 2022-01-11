<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>

	.pagination{
		display: flex;
		justify-content: center;
	}

</style>

<script type="text/javascript">

	function fncGetUserList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/user/getUserList").submit();
	}

</script>


<div class="container">

	<nav aria-label="Page navigation example">
		<ul class="pagination">

			<c:if test="${ resultPage.currentPage <= resultPage.pageUnit }">
				<li class="disabled">
			</c:if>
			<c:if test="${ resultPage.currentPage > resultPage.pageUnit }">
				<li>
			</c:if>
					<a href="javascript:fncGetUserList('${ resultPage.currentPage-1}')" aria-label="Previous">
						<span aria-hidden="true">&laquo;</span>
					</a>
				</li>

			<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
				<c:if test="${ resultPage.currentPage == i }">
					<!--  현재 page 가르킬경우 : active -->
					<li class="page-item active">
						<a class="page-link" href="javascript:fncGetUserList('${ i }');">${ i }<span class="sr-only">(current)</span></a>
					</li>
				</c:if>

				<c:if test="${ resultPage.currentPage != i}">
					<li  class="page-item">
						<a class="page-link" href="javascript:fncGetUserList('${ i }');">${ i }</a>
					</li>
				</c:if>
			</c:forEach>


			<c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">
				<li class="disabled">
			</c:if>
				<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
				<li>
			</c:if>
					<a href="javascript:fncGetUserList('${resultPage.endUnitPage+1}')" aria-label="Next">
						<span aria-hidden="true">&raquo;</span>
					</a>
				</li>
		</ul>
	</nav>

</div>