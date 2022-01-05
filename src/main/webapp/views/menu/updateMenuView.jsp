
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
<head>

    <title>메뉴 수정</title>

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <%--    <link rel="canonical" href="https://getbootstrap.com/docs/5.1/examples/modals/">--%>



    <!-- Bootstrap core CSS -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<%--    <meta name="theme-color" content="#7952b3">--%>

    <%--    <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->--%>
<%--    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>--%>


    <!--  ///////////////////////// CSS ////////////////////////// -->
    <style>
        body {
            padding-top : 50px;
        }
    </style>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //============= "추가"  Event 연결 =============
        // $(function() {
        //     //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
        //     $( "#updateMenuButton" ).on("click" , function() {
        //         //fncApplyOptionNo();
        //         fncUpdateMenu();
        //     });
        // });

        //============= "취소"  Event 처리 및  연결 =============
        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("a[href='#' ]").on("click" , function() {
                $("form")[0].reset();
            });
        });

        //================optionNo 받기 위한 logic
        // function fncApplyOptionNo(){
        //
        //
        //
        //     var happyOptionNo = [];
        //
        //     var optionNoCount = $('input[name="optionNo"]').length;
        //
        //     for(var i=0; i<optionNoCount; i++){
        //
        //         var applyOptionNo = document.find('input[name="optionNo"]').eq(i).val();
        //         happyOptionNo.push(applyOptionNo);
        //
        //     }
        //     console.log("happyOptionNo : " +happyOptionNo);
        //     document.find('input[name="optionNo"]').val(happyOptionNo);
        //
        // }




        // function fncUpdateMenu(){

        $(function(){



            $(document).on("click", "#updateMenuButton", function(){
            //     var happyOptionNo = [];
            //
            //     var optionNoCount = $('#optionNo').length;
            //
            //     for(var i=0; i<optionNoCount; i++){
            //
            //         var applyOptionNo = $('#optionNo').eq(i).val();
            //         happyOptionNo.push(applyOptionNo);
            //
            //     }
            //     console.log("happyOptionNo : " +happyOptionNo);
            //     $('#optionNo').val(happyOptionNo);

                //var truckId = $("input[name='truckId']").val();
                alert("optionGroup개수 : " +$('input#optionGroupName.form-control').length);

                if($('input#optionGroupName.form-control').length===0){
                    $("form").attr("method", "POST").attr("action", "/menu/updateMenu").submit();
                } else{
                    console.log("fncUpdateMenu-target : "+$("form.form-horizontal").html());

                    $("form").attr("method", "POST").attr("action","/menu/updateMenuOptionGroup").submit();
                    // $("form").post("/menu/addMenuOptionGroup", {}, "text")

                }

            });

        });

    </script>

</head>

<body>

<!-- ToolBar Start /////////////////////////////////////-->
<jsp:include page="/views/navbar.jsp" />
<!-- ToolBar End /////////////////////////////////////-->

<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">


    <div class="page-header text-center">
        <h3 class=" text-info">${menu.menuTruckId}의 ${menu.menuNo}에 대한 메뉴 수정</h3>
    </div>

    <!-- form Start /////////////////////////////////////-->
    <form class="form-horizontal">
<%--        <input type="hidden" id ="menuNo" name="menuNo" value="${menu.menuNo}">--%>
        <%--        <div class="form-group">--%>
        <%--            <label for="menuTruckId" class="col-sm-offset-1 col-sm-3 control-label">메뉴 트럭 아이디</label>--%>
        <%--            <div class="col-sm-4">--%>
        <%--                <input type="text" class="form-control" id="menuTruckId" name="menuTruckId"  value="${truck.truckId}" placeholder="메뉴 트럭아이디">--%>
        <%--            </div>--%>
        <%--        </div>--%>

        <div class="form-group">
            <label for="menuName" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이름</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="menuName" name="menuName" value="${menu.menuName }" placeholder="메뉴 이름 수정">

            </div>
        </div>

        <div class="form-group">
            <label for="menuDetail" class="col-sm-offset-1 col-sm-3 control-label">메뉴상세정보</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="menuDetail" name="menuDetail" value="${menu.menuDetail }" placeholder="메뉴상세정보 수정">
            </div>
        </div>

        <div class="form-group">
            <label for="menuPrice" class="col-sm-offset-1 col-sm-3 control-label">메뉴 가격</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="menuPrice" name="menuPrice" value="${menu.menuPrice }" placeholder="메뉴 가격 수정">
            </div>
        </div>

        <div class="form-group">
            <label for="isSigMenu" class="col-sm-offset-1 col-sm-3 control-label">대표메뉴여부</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="isSigMenu" name="isSigMenu" value="${menu.isSigMenu}" placeholder="대표메뉴여부 수정">
            </div>
        </div>

        <div class="form-group">
            <label for="menuImg1" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이미지1</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="menuImg1" name="menuImg1"  value="${menu.menuImg1}" placeholder="메뉴 이미지1 수정">
            </div>
        </div>

        <div class="form-group">
            <label for="menuImg2" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이미지2</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="menuImg2" name="menuImg2"  value="${menu.menuImg2}" placeholder="메뉴 이미지2 수정">
            </div>
        </div>

        <div class="form-group">
            <label for="menuImg3" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이미지3</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="menuImg3" name="menuImg3"  value="${menu.menuImg3}" placeholder="메뉴 이미지3 수정">
            </div>
        </div>

        <c:set var="i" value="0"/>
        <c:forEach var="optionGroup" items="${list}">
            <c:set var="i" value="${i+1}"/>

            <div class="form-group">
                <label for="optionGroupName" class="col-sm-offset-1 col-sm-3 control-label\">옵션그룹이름</label>
                <div class="col-sm-4">
                <input type="text" class="form-control" id="optionGroupName" name="optionGroupName"  value="${optionGroup.optionGroupName}" placeholder="${optionGroup.optionGroupName}">
                <input type="hidden" class="form-control" id="optionNo" name="optionNo" value="${optionGroup.optionNo}"/>
                <input type="hidden" class="form-control" id="menuNo" name="menuNo" value="${optionGroup.menuNo}"/>
                </div>
                </div>

<div class="float-left">
        <div class="form-group">
        <label for="optionName" class="col-sm-offset-1 col-sm-3 control-label">옵션이름</label>
        <div class="col-sm-4">
            <input type="text" class="form-control" id="optionName" name="optionName"  value="${optionGroup.optionName}" placeholder="${optionGroup.optionName}">
            </div>
        </div>

        <div class="form-group">
        <label for="optionPrice" class="col-sm-offset-1 col-sm-3 control-label">옵션가격</label>
        <div class="col-sm-4">
            <input type="text" class="form-control" id="optionPrice" name="optionPrice"  value="${optionGroup.optionPrice}" placeholder="${optionGroup.optionPrice}">
            </div>
        </div>
</div>

        </c:forEach>

        <div id="here"></div>
        <!--////////////////모달 옵션그룹 추가 시작////////////-->

<%--        <div class="modal fade" id="exampleModal" aria-hidden="true" aria-labelledby="exampleModalLabel" tabindex="-1">--%>
<%--            <div class="modal-dialog modal-dialog-centered">--%>
<%--                <div class="modal-content">--%>
<%--                    <div class="modal-header">--%>
<%--                        <h5 class="modal-title" id="exampleModalLabel">옵션그룹이름</h5>--%>

<%--                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>--%>
<%--                    </div>--%>
<%--                    <div class="modal-body">--%>
<%--                        <div class="form-group" id="rrrrrr" name="rrrrrr">--%>
<%--&lt;%&ndash;                            <label for="optionGroupName" class="col-from-label">옵션그룹이름</label>&ndash;%&gt;--%>
<%--                            <input type="text" class="form-control" id="optionGroupNameModal" value="">--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="modal-footer">--%>
<%--                        &lt;%&ndash;                        <button class="btn btn-primary" data-bs-target="#optionModalLabel" data-bs-toggle="modal">옵션추가</button>&ndash;%&gt;--%>
<%--                        &lt;%&ndash;                        <button type="button" class="btn btn-primary custom" onclick='applyOptionGroupName();'>옵션그룹이름적용</button>&ndash;%&gt;--%>
<%--                        <button type="button" class="btn btn-primary customer" onclick='applyOptionGroupNamer();' data-bs-toggle="modal" data-bs-target="#optionModal" data-whatever="option">옵션추가</button>--%>
<%--                        <button type="button" class="btn btn-primary" id="add-optionGroup">적용</button>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>



<%--        <div class="modal fade" id="optionModal" aria-hidden="true" aria-labelledby="optionModalLabel" tabindex="-1">--%>
<%--            <div class="modal-dialog modal-dialog-centered">--%>
<%--                <div class="modal-content">--%>
<%--                    <div class="modal-header">--%>
<%--                        <h5 class="modal-title" id="optionModalLabel">옵션 추가</h5>--%>
<%--                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>--%>
<%--                    </div>--%>
<%--                    <div class="modal-body">--%>
<%--                        &lt;%&ndash;                        <form>&ndash;%&gt;--%>
<%--                        &lt;%&ndash;                            <label for="optionName" class="col-form-label">옵션 이름</label>&ndash;%&gt;--%>
<%--                        <input type="text" class="form-control" id="optionNameModal" value="${optionGroup.optionName}">--%>
<%--                        &lt;%&ndash;                            <label for="optionPrice" class="col-form-label">옵션 가격</label>&ndash;%&gt;--%>
<%--                        <input type="text" class="form-control" id="optionPriceModal" value="${optionGroup.optionPrice}">--%>
<%--                        &lt;%&ndash;                        </form>&ndash;%&gt;--%>
<%--                    </div>--%>
<%--                    <div class="modal-footer">--%>
<%--                        <button type="button" class="btn btn-primary addOption" data-bs-target="#exampleModal" data-bs-toggle="modal">옵션 추가</button>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        &lt;%&ndash;        <a class="btn btn-primary" data-bs-toggle="modal" href="#exampleModal" role="button">옵션그룹추가</a>&ndash;%&gt;--%>
<%--        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" data-whatever="optionGroup">옵션그룹추가</button>--%>
<%--        <!--모달 옵션그룹 추가 끝-->--%>




        <div class="form-group">
            <div class="col-sm-offset-4  col-sm-4 text-center">
                <button type="submit" class="btn btn-primary" id="updateMenuButton">수 &nbsp;정</button>
                <a class="btn btn-primary btn" href="#" role="button">취 &nbsp;소</a>
            </div>
        </div>

    </form>


</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<jsp:include page="/views/footer.jsp" />
</body>



</html>





<%--<%@ page language="java" contentType="text/html; charset=EUC-KR"--%>
<%--         pageEncoding="EUC-KR"%>--%>

<%--&lt;%&ndash;<%@page import="com.model2.mvc.service.domain.Product"%>--%>
<%--<% Product product = (Product)request.getAttribute("product"); %> &ndash;%&gt;--%>

<%--<html>--%>
<%--<head>--%>
<%--    <title>메뉴 수정</title>--%>

<%--    <link rel="stylesheet" href="/css/admin.css" type="text/css">--%>

<%--    <script type="text/javascript" src="../javascript/calendar.js">--%>
<%--    </script>--%>
<%--    <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>--%>
<%--    <script type="text/javascript">--%>

<%--        $(function(){--%>

<%--            $('span:contains("수정")').click(function(){--%>
<%--                $(self.location).attr('method','post').attr('action','/menu/updateMenu').attr('enctype','multipart/form-data').submit();--%>
<%--            });--%>

<%--            $('span:contains("취소")').click(function(){--%>
<%--                $(window.parent.frames.document.location).attr('href','/index.jsp');--%>
<%--            });--%>

<%--            $('input[name="manuDate"]').click(function(){--%>
<%--                show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value);--%>
<%--            });--%>
<%--        });--%>

<%--        /*--%>
<%--        function fncUpdateProduct(){--%>
<%--            document.detailForm.action='/product/updateProduct';--%>
<%--            document.detailForm.submit();--%>
<%--        }--%>
<%--        */--%>


<%--    </script>--%>
<%--</head>--%>
<%--<body bgcolor="#ffffff" text="#000000">--%>

<%--<form name="detailForm">--%>
<%--    <input type="hidden" name='menuNo' value='${menu.menuNo }'/>--%>
<%--    <table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">--%>
<%--        <tr>--%>
<%--            <td width="15" height="37">--%>
<%--                <img src="/images/ct_ttl_img01.gif" width="15" height="37"/>--%>
<%--            </td>--%>
<%--            <td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">--%>
<%--                <table width="100%" border="0" cellspacing="0" cellpadding="0">--%>
<%--                    <tr>--%>
<%--                        <td width="93%" class="ct_ttl01">메뉴수정</td>--%>
<%--                        <td width="20%" align="right">&nbsp;</td>--%>
<%--                    </tr>--%>
<%--                </table>--%>
<%--            </td>--%>
<%--            <td width="12" height="37">--%>
<%--                <img src="/images/ct_ttl_img03.gif"	width="12" height="37"/>--%>
<%--            </td>--%>
<%--        </tr>--%>
<%--    </table>--%>

<%--    <table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">--%>
<%--        <tr>--%>
<%--            <td height="1" colspan="3" bgcolor="D6D6D6"></td>--%>
<%--        </tr>--%>
<%--        <tr>--%>
<%--            <td width="104" class="ct_write">--%>
<%--                메뉴 이름 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"></td>--%>
<%--            </td>--%>
<%--            <td bgcolor="D6D6D6" width="1"></td>--%>
<%--            <td class="ct_write01">--%>
<%--                <table width="100%" border="0" cellspacing="0" cellpadding="0">--%>
<%--                    <tr>--%>
<%--                        <td width="105">--%>
<%--                            <input type="text" name="menuName" class="ct_input_g" value="${menu.menuName }"--%>
<%--                                   style="width: 100px; height: 19px" maxLength="20">--%>
<%--                        </td>--%>
<%--                    </tr>--%>
<%--                </table>--%>
<%--            </td>--%>
<%--        </tr>--%>
<%--        <tr>--%>
<%--            <td height="1" colspan="3" bgcolor="D6D6D6"></td>--%>
<%--        </tr>--%>
<%--        <tr>--%>
<%--            <td width="104" class="ct_write">--%>
<%--                메뉴설명 <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>--%>
<%--            </td>--%>
<%--            <td bgcolor="D6D6D6" width="1"></td>--%>
<%--            <td class="ct_write01">--%>
<%--                <input type="text" name="menuDetail" class="ct_input_g" value="${menu.menuDetail }"--%>
<%--                       style="width: 100px; height: 19px" maxLength="10" minLength="6"/>--%>
<%--            </td>--%>
<%--        </tr>--%>
<%--        <tr>--%>
<%--            <td height="1" colspan="3" bgcolor="D6D6D6"></td>--%>
<%--        </tr>--%>

<%--        <tr>--%>
<%--            <td width="104" class="ct_write">--%>
<%--                메뉴 가격 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>--%>
<%--            </td>--%>
<%--            <td bgcolor="D6D6D6" width="1"></td>--%>
<%--            <td class="ct_write01">--%>
<%--                <input type="text" name="menuPrice" 	class="ct_input_g"  value = "${menu.menuPrice }"--%>
<%--                       style="width: 100px; height: 19px" maxLength="10">&nbsp;원--%>
<%--            </td>--%>
<%--        </tr>--%>
<%--        <tr>--%>
<%--            <td height="1" colspan="3" bgcolor="D6D6D6"></td>--%>
<%--        </tr>--%>
<%--        <tr>--%>
<%--            <td width="104" class="ct_write">메뉴 이미지1</td>--%>
<%--            <td bgcolor="D6D6D6" width="1"></td>--%>
<%--            <td class="ct_write01">--%>
<%--&lt;%&ndash;                <input	type="text" name="fileUpload" class="ct_input_g" style="width: 200px; height: 19px" maxLength="13"/>&ndash;%&gt;--%>
<%--                     <input type="text" name="menuImg1" class="ct_input_g" value="${menu.menuImg1 }"--%>
<%--           style="width: 100px; height: 19px" maxLength="10" minLength="6"/>--%>
<%--            </td>--%>
<%--        </tr>--%>

<%--        <tr>--%>
<%--            <td height="1" colspan="3" bgcolor="D6D6D6"></td>--%>
<%--        </tr>--%>
<%--    </table>--%>
<%--    --%>

<%--    <table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">--%>
<%--        <tr>--%>
<%--            <td width="53%"></td>--%>
<%--            <td align="right">--%>
<%--                <table border="0" cellspacing="0" cellpadding="0">--%>
<%--                    <tr>--%>
<%--                        <td width="17" height="23">--%>
<%--                            <img src="/images/ct_btnbg01.gif" width="17" height="23"/>--%>
<%--                        </td>--%>
<%--                        <td background="/images/ct_btnbg02.gif" class="ct_btn01"  style="padding-top: 3px;">--%>
<%--                            <!-- <a href="javascript:fncUpdateProduct();">수정</a> -->--%>
<%--                            <span>수정</span>--%>
<%--                        </td>--%>
<%--                        <td width="14" height="23">--%>
<%--                            <img src="/images/ct_btnbg03.gif" width="14" height="23"/>--%>
<%--                        </td>--%>
<%--                        <td width="30"></td>--%>
<%--                        <td width="17" height="23">--%>
<%--                            <img src="/images/ct_btnbg01.gif" width="17" height="23"/>--%>
<%--                        </td>--%>
<%--                        <td background="/images/ct_btnbg02.gif" class="ct_btn01"	 style="padding-top: 3px;">--%>
<%--                            <!-- <a href="javascript:history.go(-1)">취소</a> -->--%>
<%--                            <span>취소</span>--%>
<%--                        </td>--%>
<%--                        <td width="14" height="23">--%>
<%--                            <img src="/images/ct_btnbg03.gif" width="14" height="23"/>--%>
<%--                        </td>--%>
<%--                    </tr>--%>
<%--                </table>--%>
<%--            </td>--%>
<%--        </tr>--%>
<%--    </table>--%>

<%--</form>--%>
<%--</body>--%>
<%--</html>--%>