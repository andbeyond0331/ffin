<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
    <title>메뉴 목록 조회</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <link rel="stylesheet" href="/css/admin.css" type="text/css">
    <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
    <script type="text/javascript">



    </script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

    <form name="detailForm">
        <input type="hidden" id="tranNo" name="tranNo"/>
        <table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
            <tr>
                <td width="15" height="37">
                    <img src="/images/ct_ttl_img01.gif" width="15" height="37">
                </td>
                <td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="93%" class="ct_ttl01">
                                메뉴 목록 조회
                           </td>
                        </tr>

                    </table>
                </td>
                <td width="12" height="37">
                    <img src="/images/ct_ttl_img03.gif" width="12" height="37">
                </td>
            </tr>
        </table>



        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">

            <tr>
                <td class="ct_list_b" width="100">no</td>
                <td class="ct_line02"></td>
                <td class="ct_list_b" width="150">메뉴 이름</td>
                <td class="ct_line02"></td>
                <td class="ct_list_b" width="150">메뉴 설명</td>
                <td class="ct_line02"></td>
                <td class="ct_list_b" width="150">메뉴 가격</td>
                <td class="ct_line02"></td>
                <td class="ct_list_b">대표 메뉴 여부</td>
                <td class="ct_line02"></td>
                <td class="ct_list_b">메뉴 이미지</td>
            </tr>
            <tr>
                <td colspan="11" bgcolor="808285" height="1"></td>
            </tr>


            <c:set var="i" value="0"/>
            <c:forEach var="menu" items="${list}">
                <c:set var="i" value="${i+1}" />
                <tr class="ct_list_pop">
                    <td align="center">

                            ${i}
                    </td>
                    <td></td>

                    <td align="left">

                        <span class="menu">${menu.menuName}</span>
                        <span class="menu" hidden="">${menu.menuNo}</span>
                        <span class="menu" hidden="">${menu.menuTruckId}</span>

                    </td>

                    <td></td>
                    <td align="left">

                            ${menu.menuDetail}
                    </td>
                    <td></td>
                    <td align="left">
                            ${menu.menuPrice}
                    </td>
                    <td></td>
                    <td align="left">
                            ${menu.isSigMenu}
                    </td>
                <tr>
                    <td id="${menu.menuImg1}" colspan="11" bgcolor="D6D7D6" height="1"></td>
                </tr>
            </c:forEach>

        </table>

        <table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
            <tr>

            </tr>
        </table>
        <!--  페이지 Navigator 끝 -->
    </form>
</div>

</body>
</html>