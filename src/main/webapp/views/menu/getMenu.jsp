<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">

<head>
    <title>메뉴 조회</title>
    <jsp:include page="../../common/lib.jsp"/>
    <meta charset="EUC-KR">

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

    <!-- Bootstrap Dropdown Hover CSS -->
    <link href="/css/animate.min.css" rel="stylesheet">
    <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

    <!-- Bootstrap Dropdown Hover JS -->
    <script src="/javascript/bootstrap-dropdownhover.min.js"></script>

    <!--  ///////////////////////// CSS ////////////////////////// -->
    <style>
        body {
            padding-top : 50px;
        }
        h3.getMenuTitle.custom {
            color: #ffba49;
        }
    </style>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //============= 회원정보수정 Event  처리 =============
        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $( "button" ).on("click" , function() {
                self.location = "/menu/updateMenu?menuNo=${menu.menuNo}"
            });
        });

    </script>

</head>

<body>
<jsp:include page="/views/navbar.jsp" />
<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">

    <div class="page-header">
        <h3 class="getMenuTitle custom">${menu.menuTruckId}의 ${menu.menuName}</h3>
     </div>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>메뉴번호</strong></div>
        <div class="col-xs-8 col-md-4">${menu.menuNo}</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>메뉴 이름</strong></div>
        <div class="col-xs-8 col-md-4">${menu.menuName}</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>메뉴이미지1</strong></div>
        <div class="col-xs-8 col-md-4"><img src="/resources/image/${menu.menuImg1}" style="border-bottom: 1px solid #eee; height: 200px;" alt="${menu.menuName}의 이미지1" title="메뉴이미지1"></div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>메뉴상세정보</strong></div>
        <div class="col-xs-8 col-md-4">${menu.menuDetail}	</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>대표메뉴여부</strong></div>
        <div class="col-xs-8 col-md-4">${menu.isSigMenu}</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>메뉴가격</strong></div>
        <div class="col-xs-8 col-md-4">${menu.menuPrice}</div>
    </div>

    <hr/>

   <table>
       <c:set var="i" value="0"/>
       <c:forEach var="optionGroup" items="${list}">
           <c:set var="i" value="${i+1}" />
<%--           <tr class="ct_list_pop">--%>
<%--               <td align="center">--%>

<%--                       ${i}--%>
<%--               </td>--%>
<%--               <td></td>--%>

<%--               <td align="left">--%>
<%--&lt;%&ndash;                   <span class="odMenuName">${cart.odMenuName}</span>&ndash;%&gt;--%>
<%--                   <span class="optionGroupName" >${optionGroup.optionGroupName}</span>--%>
<%--               </td>--%>
<%--               <td align="left">--%>
<%--                   <span class="optionName" >${optionGroup.optionName}</span>--%>

<%--               </td>--%>
<%--               <td align="left">--%>
<%--                   <span class="optionPrice" >${optionGroup.optionPrice}</span>--%>
<%--               </td> v--%>
           <c:if test=""></c:if>
           <div class="row">
                   <div class="col-xs-4 col-md-2"><strong>옵션 그룹 이름</strong></div>
                   <div class="col-xs-8 col-md-4">${optionGroup.optionGroupName}</div>
               </div>
                <div class="row">
                   <div class="col-xs-4 col-md-2"><strong>옵션 이름</strong></div>
                   <div class="col-xs-8 col-md-4">${optionGroup.optionName}</div>
               </div>
               <div class="row">
                   <div class="col-xs-4 col-md-2"><strong>옵션 가격</strong></div>
                   <div class="col-xs-8 col-md-4">${optionGroup.optionPrice}</div>
               </div>

               </c:forEach>
   </table>


    <div class="row">
        <div class="col-md-12 text-center ">
            <button type="button" class="btn btn-primary">메뉴정보수정</button>
        </div>
    </div>

    <br/>

</div>
<!--  화면구성 div Start /////////////////////////////////////-->
<jsp:include page="/views/footer.jsp" />
</body>

</html>

