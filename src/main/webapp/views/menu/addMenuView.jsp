<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
<head>
    <title>메뉴 추가</title>
    <jsp:include page="../../common/lib.jsp"/>


    <!--//////////////////////-->

    <!-- Bootstrap core CSS -->
    <%--    <link href="/docs/5.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">--%>
    <%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <meta name="theme-color" content="#7952b3">
 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>


    <!--  ///////////////////////// CSS ////////////////////////// -->
    <style>
        body {
            padding-top : 50px;
        }
        form{
            text:center;
        }
    </style>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //============= "추가"  Event 연결 =============
        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $( "#addMenuOptionGroupButton" ).on("click" , function() {
                fncAddMenu();
            });
        });

        //============= "취소"  Event 처리 및  연결 =============
        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("a[href='#' ]").on("click" , function() {
                $("form")[0].reset();
            });
        });





        function applyOptionGroupNamer(){ // 모달에서 옵션그룹이름 적용누르면 돌아가는 function

            var modal = $('#exampleModal');
            realOptionGroupName = modal.find('input#optionGroupName.form-control').val();

            console.log(realOptionGroupName + " : realOptionGroupName");
            //alert(realOptionGroupName)

            // divElem = "<div class=\"form-group\" id=\""+realOptionGroupName+"-target\" name=\"optionGroupName\">"+
            //     "<input type=\"text\" id=\"applyOptionGroupName+"+realOptionGroupName+"\" name=\"applyOptionGroupName\" value=\""+realOptionGroupName+"\"/>22222"+
            //     "</div>";


            divElem = "<input type=\"hidden\" id=\"applyOptionGroupName+"+realOptionGroupName+"\" name=\"applyOptionGroupName\" value=\""+realOptionGroupName+"\"/>";

           // alert("applyOptionGroupName을 name으로 가진 태그가 있는가 ??? 있다면 몇 개?"+modal.find('input[name="applyOptionGroupName"]').length);

            //옵션그룹이름이 정해지지 않았다면
            if(modal.find('input[name="applyOptionGroupName"]').length!==0) {
                modal.find('input[name="applyOptionGroupName"]').val(realOptionGroupName);
            }else{
                modal.find('.modal-body').append($(divElem));
            }




        }





        $(function(){


            var modalOp = $('#optionModal');


            modalOp.find('button.btn.btn-primary.addOption').on("click", function(){
                //countOp++;

                var realOptionName = modalOp.find('input#optionName.form-control').val();
                var realOptionPrice = modalOp.find('input#optionPrice.form-control').val();

                console.log(realOptionName +" : realOptionName");
                console.log(realOptionPrice +" : realOptionPrice");

                divElemOp ="</hr>"+
                    "<div class=\"form-group\" id=\""+realOptionName+"\" name=\"optionName\">"+
                    "<div class=\"col-xs-8 col-md-4\">"+"옵션 이름 : "+realOptionName+"</div>"+
                    "<input type=\"hidden\" id=\"applyOptionName+"+realOptionName+"\" name=\"applyOptionName\" value=\""+realOptionName+"\"/>"+
                    "<div class=\"col-xs-8 col-md-4\">"+"옵션 가격 : "+realOptionPrice+"</div>"+
                    "<input type=\"hidden\" id=\"applyOptionPrice+"+realOptionPrice+"\" name=\"applyOptionPrice\" value=\""+realOptionPrice+"\"/>"+
                    "<input type=\"button\" value=\"삭제\" onclick=\"javascript:removeEL(\'"+realOptionName+"\')\"/>"+
                    "</div>";

                console.log("divElemOp : "+divElemOp);


                //$('div#'+indexOp+'-target').append($(divElemOp));
                console.log("append-op-target : " + $('#exampleModal').find('.modal-body').html());

                $('#exampleModal').find('.modal-body').append($(divElemOp));

                modalOp.find('input#optionName.form-control').val("");
                modalOp.find('input#optionPrice.form-control').val("");


            });

        });

        //modal창 안에서의 적용버튼 눌렀을 때 로직
        $(function(){

            var modalApply = $('#exampleModal');

            $(document).on("click", "#add-optionGroup", function(){
                // modalApply.find('#add-optionGroup').on("click", function(){
                //countOp++;
                // var happyOptionPrice = [];

                var applyOptionGroupName = modalApply.find('input[name="applyOptionGroupName"]').val();
                var applyOptionName = modalApply.find('input[name="applyOptionName"]').val();
                var applyOptionPrice = modalApply.find('input[name="applyOptionPrice"]').val();

                console.log(applyOptionGroupName +" : applyOptionGroupName");
                console.log(applyOptionName +" : applyOptionName");
                console.log(applyOptionPrice +" : applyOptionPrice");


                ///append를 위한 for문
                var optionNameCount = $('input[name="applyOptionName"]').length;



                for(var i=0; i<optionNameCount; i++){
                    var applyOptionGroupName = modalApply.find('input[name="applyOptionGroupName"]').val();
                    finalOptionName = ($('input[name="applyOptionName"]').eq(i).val());
                    finalOptionPrice = ($('input[name="applyOptionPrice"]').eq(i).val());



                    divElemApply1 = "</hr>"+
                        "<div class=\"form-group\" id=\"removeTarget"+applyOptionGroupName+"\">"+
                        " <label for=\"optionGroupName\" class=\"col-sm-offset-1 col-sm-3 control-label\">옵션그룹이름</label>"+
                        "<div class=\"col-sm-4\">"+
                        "<input type=\"text\" class=\"form-control\" id=\"optionGroupName\" name=\"optionGroupName\"  value=\""+applyOptionGroupName+"\" placeholder=\""+applyOptionGroupName+"\">"+
                        "</div>"+
                        "</div>"+
                        "</hr>";
                    divElemApply2 =  "<div class=\"form-group\" id=\"removeTarget"+applyOptionGroupName+"\">"+
                        " <label for=\"optionName\" class=\"col-sm-offset-1 col-sm-3 control-label\">옵션이름</label>"+
                        "<div class=\"col-sm-4\">"+
                        "<input type=\"text\" class=\"form-control\" id=\"optionName\" name=\"optionName\"  value=\""+finalOptionName+"\" placeholder=\""+finalOptionName+"\">"+
                        "</div>"+
                        "</div>"+
                        "</hr>"+
                        "<div class=\"form-group\" id=\"removeTarget"+applyOptionGroupName+"\">"+
                        " <label for=\"optionPrice\" class=\"col-sm-offset-1 col-sm-3 control-label\">옵션가격</label>"+
                        "<div class=\"col-sm-4\">"+
                        "<input type=\"text\" class=\"form-control\" id=\"optionPrice\" name=\"optionPrice\"  value=\""+finalOptionPrice+"\" placeholder=\""+finalOptionPrice+"\">"+
                        "</div>"+
                        "</div>"+
                        "<input type=\"button\" value=\"삭제\" id=\"removeTarget"+applyOptionGroupName+"\" onclick=\"javascript:removeELOption(\'"+applyOptionGroupName+"\')\"/>";

                    //
                    // divElemApply1 = "</hr>"+
                    //     "<div class=\"form-group\" id=\"removeTarget"+applyOptionGroupName+"\">"+
                    //     " <label for=\"optionGroupName\" class=\"col-sm-offset-1 col-sm-3 control-label\">옵션그룹이름</label>"+
                    //     "<div class=\"col-sm-4\">"+
                    //     "<input type=\"text\" class=\"form-control\" id=\"optionGroupName\" name=\"optionGroupName\"  value=\""+applyOptionGroupName+"\" placeholder=\""+applyOptionGroupName+"\">"+
                    //     "</div>"+
                    //     "</div>"+
                    //     "</hr>";
                    // divElemApply2 =  "<div class=\"form-group\" id=\"removeTarget"+applyOptionGroupName+"\">"+
                    //     " <label for=\"optionName\" class=\"col-sm-offset-1 col-sm-3 control-label\">옵션이름</label>"+
                    //     "<div class=\"col-sm-4\">"+
                    //     "<input type=\"text\" class=\"form-control\" id=\"optionName\" name=\"optionName\"  value=\""+finalOptionName+"\" placeholder=\""+finalOptionName+"\">"+
                    //     "</div>"+
                    //     "</div>"+
                    //     "</hr>"+
                    //     "<div class=\"form-group\" id=\"removeTarget"+applyOptionGroupName+"\">"+
                    //     " <label for=\"optionPrice\" class=\"col-sm-offset-1 col-sm-3 control-label\">옵션가격</label>"+
                    //     "<div class=\"col-sm-4\">"+
                    //     "<input type=\"text\" class=\"form-control\" id=\"optionPrice\" name=\"optionPrice\"  value=\""+finalOptionPrice+"\" placeholder=\""+finalOptionPrice+"\">"+
                    //     "</div>"+
                    //     "</div>"+
                    //     "<input type=\"button\" value=\"삭제\" id=\"removeTarget"+applyOptionGroupName+"\" onclick=\"javascript:removeELOption(\'"+applyOptionGroupName+"\')\"/>";
                    //

                    alert(i+"번째 optionPrice" + ($('input[name="applyOptionPrice"]').eq(i).val()));

                    $('#here').append(divElemApply1+divElemApply2);
                }

                forResetModal =

                    "<div class=\"modal-dialog modal-dialog-centered\">"+
                    "<div class=\"modal-content\">"+
                    "<div class=\"modal-header\">"+
                    "<h5 class=\"modal-title\" id=\"exampleModalLabel\">옵션그룹이름</h5>"+
                    "<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"modal\" aria-label=\"Close\"></button>"+
                    "</div>"+
                    "<div class=\"modal-body\">"+
                    "<div class=\"form-group\">"+
                    "<label for=\"optionGroupName\" class=\"col-from-label\">옵션그룹이름</label>"+
                    "<input type=\"text\" class=\"form-control\" id=\"optionGroupName\" value=\"\">"+
                    "</div>"+
                    // "</div>"+
                    "<div class=\"modal-footer\">"+
                    //"<button type=\"button\" class=\"btn btn-primary custom\" onclick='applyOptionGroupNamer();'>옵션그룹이름적용</button>"+
                    "<button type=\"button\" class=\"btn btn-primary customer\" onclick=\'applyOptionGroupNamer()\' data-bs-toggle=\"modal\" data-bs-target=\"#optionModal\" data-whatever=\"option\">옵션추가</button>"+
                    "<button type=\"button\" class=\"btn btn-primary\" id=\"add-optionGroup\">적용</button>"+
                    "</div>"+
                    "</div>"+
                    // "</div>"+
                    "</div>";


                console.log("forresetmodal : " + $('#exampleModal').html());
                console.log("forResetModal 대체텍스트 : " + forResetModal);

                $('#exampleModal').html(forResetModal);

            });

        });

        function removeEL(idIndex){
            console.log("removeEL(옵션 삭제)");
            console.log("삭제 타겟 : " + $('div#'+idIndex+'.form-group').html());

            if(!confirm("옵션을 삭제하시겠습니까?")){

            }else{
                $('div#'+idIndex+'.form-group').remove();

            }

        }

        function removeELOption(idIndex){
            console.log("removeELOption(옵션그룹 삭제)");
            console.log("삭제 타겟 : " + $('div#removeTarget'+idIndex+'.form-group').html());

            // var removeTargetOG=[];
            // removeTargetOG=idIndex.split();
            // idIndex1 = idIndex.replace(/(\s*)/g, "\ ");




            if(!confirm("옵션 그룹"+idIndex+"을(를) 삭제하시겠습니까?")){

            }else{
                $('div#removeTarget'+idIndex+'.form-group').remove();
                $('input#removeTarget'+idIndex).remove();

            }

        }

        function fncAddMenu(){

            //var truckId = $("input[name='truckId']").val();
            //alert("fncAddMenu-target : "+$("form.form-horizontal").html());

            alert("optionGroup개수 : " +$('input#optionGroupName.form-control').length);

            if($('input#optionGroupName.form-control').length===1){
                $("form").attr("method", "POST").attr("action","/menu/addMenu").attr("enctype", "multipart/form-data").submit();
            }else{
                $("form").attr("method", "POST").attr("action","/menu/addMenuOptionGroup").attr("enctype", "multipart/form-data").submit();
                // $("form").post("/menu/addMenuOptionGroup", {}, "text")
            }


        }

    </script>

</head>

<body>
<jsp:include page="../navbar.jsp"/>
<!-- ToolBar Start /////////////////////////////////////-->
<!-- ToolBar End /////////////////////////////////////-->

<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">

<div class="row justify-content-center">
    <div class="page-header">
        <h3 class=" text-info">${truck.truckId}에 대한 메뉴 추가</h3>
    </div>

    <!-- form Start /////////////////////////////////////-->
    <form class="form-horizontal">
        <input type="hidden" id = "menuTruckId" name="menuTruckId" value="${truck.truckId}">
        <%--        <div class="form-group">--%>
        <%--            <label for="menuTruckId" class="col-sm-offset-1 col-sm-3 control-label">메뉴 트럭 아이디</label>--%>
        <%--            <div class="col-sm-4">--%>
        <%--                <input type="text" class="form-control" id="menuTruckId" name="menuTruckId"  value="${truck.truckId}" placeholder="메뉴 트럭아이디">--%>
        <%--            </div>--%>
        <%--        </div>--%>

        <div class="form-group">
            <label for="menuName" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이름</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="menuName" name="menuName" value="${menu.menuName }" placeholder="메뉴 이름">

            </div>
        </div>

        <div class="form-group">
            <label for="menuDetail" class="col-sm-offset-1 col-sm-3 control-label">메뉴상세정보</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="menuDetail" name="menuDetail" value="${menu.menuDetail }" placeholder="메뉴상세정보">
            </div>
        </div>

        <div class="form-group">
            <label for="menuPrice" class="col-sm-offset-1 col-sm-3 control-label">메뉴 가격</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="menuPrice" name="menuPrice" value="${menu.menuPrice }" placeholder="메뉴 가격">
            </div>
        </div>

        <div class="form-group">
<%--            <label for="isSigMenu" class="col-sm-offset-1 col-sm-3 control-label">대표메뉴여부</label>--%>
            <div class="col-sm-4">
<%--                <input type="text" class="form-control" id="isSigMenu" name="isSigMenu" value="${menu.isSigMenu}" placeholder="대표메뉴여부">--%>

                <div class="form-check form-switch" id="isThereSigMenu">
<%--                    <input class="form-check-input" type="checkbox" id="flexSwitchCheckDefault">--%>
<%--                    <label class="form-check-label" for="flexSwitchCheckDefault">대표메뉴여부</label>--%>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label for="menuImg1" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이미지1</label>
            <div class="col-sm-4">
                <input type="file" class="form-control" id="menuImg1" name="menuImg11"  value="${menu.menuImg1}" placeholder="메뉴 이미지1" onchange="setImage1Preview(event);">
            </div>
            <div id="image1preview"></div>
        </div>

        <div class="form-group">
            <label for="menuImg2" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이미지2</label>
            <div class="col-sm-4">
                <input type="file" class="form-control" id="menuImg2" name="menuImg22"  value="${menu.menuImg2}" placeholder="메뉴 이미지2" onchange="setImage2Preview(event);">
            </div>
            <div id="image2preview"></div>
        </div>

        <div class="form-group">
            <label for="menuImg3" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이미지3</label>
            <div class="col-sm-4">
                <input type="file" class="form-control" id="menuImg3" name="menuImg33"  value="${menu.menuImg3}" placeholder="메뉴 이미지3" onchange="setImage3Preview(event);">
            </div>
            <div id="image3preview"></div>
        </div>

    <script>


        function setImage1Preview(event){

            var DIVimage1preview = $('#image1preview');
            var isTherePreview = DIVimage1preview.find('img').length;
            alert("isTherePreview : " + isTherePreview);
            //이미지파일미리보기 이미 있으면 바꾸기 구현 중-  점심먹고 왔다! 다시 시작!
            var reader  = new FileReader();

            if(isTherePreview==0){

            }else{

                DIVimage1preview.find('img').remove();

            }

            reader.onload = function(event){
                var img = document.createElement("img");
                img.setAttribute("src", event.target.result);
                document.querySelector("div#image1preview").appendChild(img);

            };

            reader.readAsDataURL(event.target.files[0]);


        }

        function setImage2Preview(event){
            var reader  = new FileReader();
            var isTherePreview = DIVimage2preview.find('img').length;
            alert("isTherePreview : " + isTherePreview);
            //이미지파일미리보기 이미 있으면 바꾸기 구현 중-  점심먹고 왔다! 다시 시작!
            var reader  = new FileReader();

            if(isTherePreview==0){

            }else{

                DIVimage2preview.find('img').remove();

            }

            reader.onload = function(event){
                var img = document.createElement("img");
                img.setAttribute("src", event.target.result);
                document.querySelector("div#image2preview").appendChild(img);

            };

            reader.readAsDataURL(event.target.files[0]);

        }

        function setImage3Preview(event){
            var reader  = new FileReader();
            var isTherePreview = DIVimage3preview.find('img').length;
            alert("isTherePreview : " + isTherePreview);
            //이미지파일미리보기 이미 있으면 바꾸기 구현 중-  점심먹고 왔다! 다시 시작!
            var reader  = new FileReader();

            if(isTherePreview==0){

            }else{

                DIVimage3preview.find('img').remove();

            }

            reader.onload = function(event){
                var img = document.createElement("img");
                img.setAttribute("src", event.target.result);
                document.querySelector("div#image3preview").appendChild(img);

            };

            reader.readAsDataURL(event.target.files[0]);

        }

    </script>



        <div id="here"></div>
        <!--////////////////모달 옵션그룹 추가 시작////////////-->

        <div class="modal fade" id="exampleModal" aria-hidden="true" aria-labelledby="exampleModalLabel" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">옵션그룹이름</h5>

                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group" id="rrrrrr" name="rrrrrr">
                            <label for="optionGroupName" class="col-from-label">옵션그룹이름</label>
                            <input type="text" class="form-control" id="optionGroupName" value="">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <%--                        <button class="btn btn-primary" data-bs-target="#optionModalLabel" data-bs-toggle="modal">옵션추가</button>--%>
<%--                        <button type="button" class="btn btn-primary custom" onclick='applyOptionGroupName();'>옵션그룹이름적용</button>--%>
                        <button type="button" class="btn btn-primary customer" onclick='applyOptionGroupNamer();' data-bs-toggle="modal" data-bs-target="#optionModal" data-whatever="option">옵션추가</button>
                        <button type="button" class="btn btn-primary" id="add-optionGroup">적용</button>
                    </div>
                </div>
            </div>
        </div>



        <div class="modal fade" id="optionModal" aria-hidden="true" aria-labelledby="optionModalLabel" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="optionModalLabel">옵션 추가</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <%--                        <form>--%>
                        <%--                            <label for="optionName" class="col-form-label">옵션 이름</label>--%>

                                <span>옵션 이름
                                <input type="text" class="form-control" id="optionName" value="${optionGroup.optionName}"></span>

                        <%--                            <label for="optionPrice" class="col-form-label">옵션 가격</label>--%>
                            <span>옵션 가격</span>
                        <input type="text" class="form-control" id="optionPrice" value="${optionGroup.optionPrice}" placeholder="옵션 가격 - 숫자를 입력해주세요.">
                        <%--                        </form>--%>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary addOption" data-bs-target="#exampleModal" data-bs-toggle="modal">옵션 추가</button>
                    </div>
                </div>
            </div>
        </div>
        <%--        <a class="btn btn-primary" data-bs-toggle="modal" href="#exampleModal" role="button">옵션그룹추가</a>--%>
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" data-whatever="optionGroup">옵션그룹추가</button>
        <!--모달 옵션그룹 추가 끝-->




        <div class="form-group">
            <div class="col-sm-offset-4  col-sm-4 text-center">
                <button type="submit" class="btn btn-primary"  id="addMenuOptionGroupButton">추 &nbsp;가</button>
                <a class="btn btn-primary btn" href="#" role="button">취 &nbsp;소</a>
            </div>
        </div>
    </form>
</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<jsp:include page="/views/footer.jsp" />
</body>

<script>
    //===============대표메뉴 여부 연결 ================
    /// todo 2022-01-10 대표메뉴 ajax
    $(document).onload(function(){
        //온로드 시 대표메뉴가 있는지 없는지 판단
        <%--var truckIdForSigMenu = ${truckId};--%>

        var iamSig;
        var iamIsThereSM;

        $.ajax({

            url:"/menu/json/isThereSigMenu/"+${truck.truckId},
            method:"get",
            success:function(data){
                if (data.menu!=null){
                    console.log("data.menu : " + data.menu);
                    iamSig=data.menu;
                    iamIsThereSM = 'yes';
                    var isSigMenuButton =
                        "<label class=\"form-check-label\" for=\"isSigMenu\">대표메뉴여부</label>"+
                        " <input class=\"form-check-input\" type=\"checkbox\" id=\"isSigMenu\" name=\"isSigMenu\" data-val=\"abled\">";

                    $('div#isThereSigMenu.form-check.form-switch').html(isSigMenuButton);
                }else{
                    iamSig=null;
                    iamIsThereSM = 'no';
                    var isSigMenuButton =
                        "<label class=\"form-check-label\" for=\"isSigMenu\">대표메뉴여부</label>"+
                        " <input class=\"form-check-input\" type=\"checkbox\" id=\"isSigMenu\" name=\"isSigMenu\" data-val=\"disabled\" checked disabled>";

                    $('div#isThereSigMenu.form-check.form-switch').html(isSigMenuButton); //todo 대표메뉴가 없어서 나온 버튼이니까 disabled 해놓고 클릭 시 대표메뉴는 최소 1개 있어야 합니다. alert 띄우기
                }


            }
        });


    });

    //==========대표메뉴를 클릭했을 때!===========

    $(function(){

        var divIsSigMenu = $('div#isThereSigMenu.form-check.form-switch');

        $("input[name='isSigMenu']").on("click", function(){

            if(divIsSigMenu.find('input[name="isSigMenu"]').data("val")=='disabled'){
                alert("대표메뉴는 최소 1개 이상 있어야 합니다.");
            }else{
                if(!confirm("대표메뉴가 이미 있습니다. 변경하시겠습니까?")){

                }else{
                    var isSigMenuButton =
                        "<label class=\"form-check-label\" for=\"isSigMenu\">대표메뉴여부</label>"+
                        " <input class=\"form-check-input\" type=\"checkbox\" id=\"isSigMenu\" name=\"isSigMenu\" data-val=\"abled\">";

                    $('div#isThereSigMenu.form-check.form-switch').html(isSigMenuButton);
                }
            }

        });

    });

    //
    // function isThereSigMenu(truckId){
    //
    //     var iamSig;
    //     var iamIsThereSM;
    //
    //     $.ajax({
    //         url:"/menu/json/isThereSigMenu/"+truckId,
    //         method:"get",
    //         success:function(data){
    //             if (data.menu!=null){
    //                 console.log("data.menu : " + data.menu);
    //                 iamSig=data.menu;
    //                 iamIsThereSM = 'yes';
    //             }else{
    //                 iamSig=null;
    //                 iamIsThereSM = 'no';
    //             }
    //
    //
    //         }
    //     });
    //
    // }


</script>



</html>

