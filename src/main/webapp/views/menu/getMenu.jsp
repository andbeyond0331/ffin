<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">

<head>
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

<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">

    <div class="page-header">
        <h3 class=" text-info">${menu.menuTruckId}의 ${menu.menuName} 상세 조회</h3>
        <h5 class="text-muted">상품 정보를 <strong class="text-danger">최신정보로 관리</strong>해 주세요.</h5>
    </div>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
        <div class="col-xs-8 col-md-4">${menu.menuNo}</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>상품명</strong></div>
        <div class="col-xs-8 col-md-4">${menu.menuName}</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>상품이미지</strong></div>
        <div class="col-xs-8 col-md-4">${menu.menuImg1}</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>상품상세정보</strong></div>
        <div class="col-xs-8 col-md-4">${menu.menuDetail}	</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>대표메뉴여부</strong></div>
        <div class="col-xs-8 col-md-4">${menu.isSigMenu}</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>가격</strong></div>
        <div class="col-xs-8 col-md-4">${menu.menuPrice}</div>
    </div>

    <hr/>

   <table>
       <c:set var="i" value="0"/>
       <c:forEach var="optionGroup" items="${list}">
           <c:set var="i" value="${i+1}" />
           <tr class="ct_list_pop">
               <td align="center">

                       ${i}
               </td>
               <td></td>

               <td align="left">
<%--                   <span class="odMenuName">${cart.odMenuName}</span>--%>
                   <span class="optionGroupName" >${optionGroup.optionGroupName}</span>
               </td>
               <td align="left">
                   <span class="optionName" >${optionGroup.optionName}</span>

               </td>
               <td align="left">
                   <span class="optionPrice" >${optionGroup.optionPrice}</span>
               </td> v

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

</body>

</html>

