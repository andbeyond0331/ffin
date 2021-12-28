<%--
<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR"%>

<html>
<head>
    <title>메뉴 수정</title>

    <link rel="stylesheet" href="/css/admin.css" type="text/css">

    <script type="text/javascript" src="../javascript/calendar.js">
    </script>
    <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script type="text/javascript">

        $(function(){

            var menuNo = $("input[name='menuNo']").val();

            $('span:contains("수정")').click(function(){
                $("form").attr("method","POST").attr("action","updateMenu").submit();
            });




        });




    </script>
</head>
<body bgcolor="#ffffff" text="#000000">

<form name="detailForm">
    <input type="hidden" name='menuNo' value='${menu.menuNo}'/>
    <table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
        <tr>
            <td width="15" height="37">
                <img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
            </td>
            <td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="93%" class="ct_ttl01">메뉴수정</td>
                        <td width="20%" align="right">&nbsp;</td>
                    </tr>
                </table>
            </td>
            <td width="12" height="37">
                <img src="/images/ct_ttl_img03.gif"	width="12" height="37"/>
            </td>
        </tr>
    </table>

    <table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">
                메뉴 이름 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"></td>
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="105">
                            <input type="text" name="menuName" class="ct_input_g" value="${menu.menuName}"
                                   style="width: 100px; height: 19px" maxLength="20">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">
                메뉴설명 <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">
                <input type="text" name="menuDetail" class="ct_input_g" value="${menu.menuDetail}"
                       style="width: 100px; height: 19px" maxLength="10" minLength="6"/>
            </td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>

        <tr>
            <td width="104" class="ct_write">
                메뉴 가격 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">
                <input type="text" name="menuPrice" 	class="ct_input_g"  value = "${menu.menuPrice}"
                       style="width: 100px; height: 19px" maxLength="10">&nbsp;원
            </td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">메뉴 이미지1</td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">
                <input	type="text" name="menuImg1" value="${menu.menuImg1}" class="ct_input_g" style="width: 200px; height: 19px" maxLength="13"/>
            </td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">메뉴 이미지2</td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">
                <input	type="text" name="menuImg2" value="${menu.menuImg2}" class="ct_input_g" style="width: 200px; height: 19px" maxLength="13"/>
            </td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">메뉴 이미지3</td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">
                <input	type="text" name="menuImg3" value="${menu.menuImg3}" class="ct_input_g" style="width: 200px; height: 19px" maxLength="13"/>
                <input type="hidden" name="menuNo" value="${menu.menuNo}"/>
                <input type="hidden" name="menuTruckId" value="${menu.menuTruckId}"/>
                <input type="hidden" name="isSigMenu" value="${menu.isSigMenu}"/>
                <input type="hidden" name="menuRegDate" value="${menu.menuRegDate}"/>


            </td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">대표메뉴여부</td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">
                <input	type="text" name="isSigMenu" value="${menu.isSigMenu}" class="ct_input_g" style="width: 200px; height: 19px" maxLength="13"/>
            </td>
        </tr>



        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
    </table>

    <table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
        <tr>
            <td width="53%"></td>
            <td align="right">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="17" height="23">
                            <img src="/images/ct_btnbg01.gif" width="17" height="23"/>
                        </td>
                        <td background="/images/ct_btnbg02.gif" class="ct_btn01"  style="padding-top: 3px;">
                            <!-- <a href="javascript:fncUpdateProduct();">수정</a> -->
                            <span>수정</span>
                        </td>
                        <td width="14" height="23">
                            <img src="/images/ct_btnbg03.gif" width="14" height="23"/>
                        </td>
                        <td width="30"></td>
                        <td width="17" height="23">
                            <img src="/images/ct_btnbg01.gif" width="17" height="23"/>
                        </td>
                        <td background="/images/ct_btnbg02.gif" class="ct_btn01"	 style="padding-top: 3px;">
                            <!-- <a href="javascript:history.go(-1)">취소</a> -->
                            <span>취소</span>
                        </td>
                        <td width="14" height="23">
                            <img src="/images/ct_btnbg03.gif" width="14" height="23"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

</form>
</body>
</html>--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="x-UTF-16LE-BOM">

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

        //============= "수정"  Event 연결 =============
        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $( "button.btn.btn-primary" ).on("click" , function() {
                fncUpdateMenu();
            });
        });


        //============= "취소"  Event 처리 및  연결 =============
        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("a[href='#' ]").on("click" , function() {
                $("form")[0].reset();
            });
        });


        ///////////////////////////////////////////////////////////////////////
        function fncUpdateMenu(){

            var menuNo = $("input[name='menuNo']").val();

            //document.detailForm.action='/product/updateProduct';
            //document.detailForm.submit();
            $("form").attr("method", "POST").attr("action","/menu/updateMenu?menuNo="+menuNo).submit();
        }

    </script>

</head>

<body>

<!-- ToolBar Start /////////////////////////////////////-->
<!-- ToolBar End /////////////////////////////////////-->

<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">
    <input type="hidden" name="menuNo" value="${menu.menuNo }">

    <div class="page-header text-center">
        <h3 class=" text-info">메뉴 정보 수정</h3>
        <h5 class="text-muted">상품 정보를 <strong class="text-danger">최신정보로 관리</strong>해 주세요.</h5>
    </div>

    <!-- form Start /////////////////////////////////////-->
    <form class="form-horizontal">

        <div class="form-group">
            <label for="menuName" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이름</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="menuName" name="menuName" value="${menu.menuName }" placeholder="변경 메뉴명">

            </div>
        </div>

        <div class="form-group">
            <label for="menuDetail" class="col-sm-offset-1 col-sm-3 control-label">메뉴상세정보</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="menuDetail" name="menuDetail" value="${menu.menuDetail }" placeholder="변경메뉴상세정보">
            </div>
        </div>

        <div class="form-group">
            <label for="menuPrice" class="col-sm-offset-1 col-sm-3 control-label">메뉴 가격</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="menuPrice" name="menuPrice" value="${menu.menuPrice }" placeholder="변경 메뉴 가격">
            </div>
        </div>

        <div class="form-group">
            <label for="isSigMenu" class="col-sm-offset-1 col-sm-3 control-label">대표메뉴여부</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="isSigMenu" name="isSigMenu" value="${menu.isSigMenu}" placeholder="변경 대표메뉴여부">
            </div>
        </div>

        <div class="form-group">
            <label for="menuImg1" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이미지1</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="menuImg1" name="menuImg1"  value="${menu.menuImg1}" placeholder="변경 메뉴 이미지1">
            </div>
        </div>

        <div class="form-group">
            <label for="menuImg2" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이미지2</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="menuImg2" name="menuImg2"  value="${menu.menuImg1}" placeholder="변경 메뉴 이미지2">
            </div>
        </div>

        <div class="form-group">
            <label for="menuImg3" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이미지3</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="menuImg3" name="menuImg3"  value="${menu.menuImg3}" placeholder="변경 메뉴 이미지3">
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-4  col-sm-4 text-center">
                <button type="button" class="btn btn-primary"  >수 &nbsp;정</button>
                <a class="btn btn-primary btn" href="#" role="button">취 &nbsp;소</a>
            </div>
        </div>
    </form>
    <!-- form Start /////////////////////////////////////-->

</div>
<!--  화면구성 div Start /////////////////////////////////////-->

</body>

</html>