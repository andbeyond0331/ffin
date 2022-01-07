
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
<head>

    <title>메뉴 수정</title>
    <jsp:include page="../../common/lib.jsp"/>

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
                    $("form").attr("method", "POST").attr("action", "/menu/updateMenu").attr("enctype","multipart/form-data").submit();
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



