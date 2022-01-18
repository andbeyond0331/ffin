<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>메뉴 관리 페이지</title>
    <jsp:include page="../../common/lib.jsp"/>



    <style>
        .div.flex.card.h-100{
            float:left;
            height:500px;
        }
        .card-body{
            height:301px;
        }
        .container-fluid{

            margin-right:142px;
            padding-left:190px;
        }
    </style>



    <style>

        .truckNameForMenu{
            color:black;
            font-weight: bolder;
            text-align: center;
        }
    </style>

    <script>

        //모달에서 메뉴 추가 버튼 클릭 시
        $(function(){

            $('#add-menu').on("click", function(){

                fncAddMenu();

            });

        });

        function fncAddMenu(){

            alert("optionGroup개수 : " +$('input#optionGroupName.form-control').length);

            if($('input#optionGroupName.form-control').length==0){
                $("form").attr("method", "POST").attr("action","/menu/addMenu").attr("enctype", "multipart/form-data").submit();
            }else{
                $("form").attr("method", "POST").attr("action","/menu/addMenuOptionGroup").attr("enctype", "multipart/form-data").submit();

            }


        }

        function applyOptionGroupNamer(){ // 모달에서 옵션그룹이름 적용누르면 돌아가는 function

            var modal = $('#optionGroupModal');
            optionGroupNamer = modal.find('input#optionGroupNamer.form-control').val();

            console.log(optionGroupNamer + " : optionGroupNamer");
            //alert(realOptionGroupName)

            // divElem = "<div class=\"form-group\" id=\""+realOptionGroupName+"-target\" name=\"optionGroupName\">"+
            //     "<input type=\"text\" id=\"applyOptionGroupName+"+realOptionGroupName+"\" name=\"applyOptionGroupName\" value=\""+realOptionGroupName+"\"/>22222"+
            //     "</div>";

            // 적용할 옵션그룹 hidden
            divElem = "<input type=\"hidden\" id=\"applyOptionGroupName+"+optionGroupNamer+"\" name=\"applyOptionGroupName\" value=\""+optionGroupNamer+"\"/>";

            // alert("applyOptionGroupName을 name으로 가진 태그가 있는가 ??? 있다면 몇 개?"+modal.find('input[name="applyOptionGroupName"]').length);

            //옵션그룹이름이 정해지지 않았다면
            if(modal.find('input[name="applyOptionGroupName"]').length!==0) {
                modal.find('input[name="applyOptionGroupName"]').val(optionGroupNamer);
            }else{
                modal.find('.modal-body').append($(divElem));
            }




        }




// 옵션 모달에서 옵션 추가 버튼 클릭 시?
        $(function(){


            var modalOp = $('#optionModal');


            modalOp.find('button.btn.btn-primary.addOption').on("click", function(){
                //countOp++;

                var optionNamer = modalOp.find('input#optionNamer.form-control').val();
                var optionPricer = modalOp.find('input#optionPricer.form-control').val();

                console.log(optionNamer +" : optionNamer");
                console.log(optionPricer +" : optionPricer");

                divElemOp ="</hr>"+
                    "<div class=\"form-group\" id=\""+optionNamer+"\" name=\"optionName\">"+
                    "<div class=\"col-xs-8 col-md-4\">"+"옵션 이름 : "+optionNamer+"</div>"+
                    "<input type=\"hidden\" id=\"applyOptionName+"+optionNamer+"\" name=\"applyOptionName\" value=\""+optionNamer+"\"/>"+
                    "<div class=\"col-xs-8 col-md-4\">"+"옵션 가격 : "+optionPricer+"</div>"+
                    "<input type=\"hidden\" id=\"applyOptionPrice+"+optionPricer+"\" name=\"applyOptionPrice\" value=\""+optionPricer+"\"/>"+
                    "<input type=\"button\" value=\"삭제\" onclick=\"javascript:removeEL(\'"+optionNamer+"\')\"/>"+
                    "</div>";

                console.log("divElemOp : "+divElemOp);


                //$('div#'+indexOp+'-target').append($(divElemOp));
                console.log("append-op-target : " + $('#optionGroupModal').find('.modal-body').html());

                $('#optionGroupModal').find('.modal-body').append($(divElemOp));

                modalOp.find('input#optionNamer.form-control').val("");
                modalOp.find('input#optionPricer.form-control').val("");


            });

        });

        //modal창 안에서의 적용버튼 눌렀을 때 로직
        $(function(){

            var modalApply = $('#optionGroupModal');

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
                        " <label for=\"optionGroupName\" class=\"col-sm-offset-1 col-sm-5 control-label\">옵션그룹이름</label>"+
                        "<div class=\"col-sm-4\">"+
                        "<input type=\"text\" class=\"form-control\" id=\"optionGroupName\" name=\"optionGroupName\"  value=\""+applyOptionGroupName+"\" placeholder=\""+applyOptionGroupName+"\">"+
                        "</div>"+
                        "</div>"+
                        "</hr>";
                    divElemApply2 =  "<div class=\"form-group\" id=\"removeTarget"+applyOptionGroupName+"\">"+
                        " <label for=\"optionName\" class=\"col-sm-offset-1 col-sm-5 control-label\">옵션이름</label>"+
                        "<div class=\"col-sm-4\">"+
                        "<input type=\"text\" class=\"form-control\" id=\"optionName\" name=\"optionName\"  value=\""+finalOptionName+"\" placeholder=\""+finalOptionName+"\">"+
                        "</div>"+
                        "</div>"+
                        "</hr>"+
                        "<div class=\"form-group\" id=\"removeTarget"+applyOptionGroupName+"\">"+
                        " <label for=\"optionPrice\" class=\"col-sm-offset-1 col-sm-5 control-label\">옵션가격</label>"+
                        "<div class=\"col-sm-4\">"+
                        "<input type=\"text\" class=\"form-control\" id=\"optionPrice\" name=\"optionPrice\"  value=\""+finalOptionPrice+"\" placeholder=\""+finalOptionPrice+"\">"+
                        "</div>"+
                        "</div>"+
                        "<input type=\"button\" value=\"삭제\" id=\"removeTarget"+applyOptionGroupName+"\" onclick=\"javascript:removeELOption(\'"+applyOptionGroupName+"\')\"/>";


                    alert(i+"번째 optionPrice" + ($('input[name="applyOptionPrice"]').eq(i).val()));

                    $('#here').append(divElemApply1+divElemApply2);
                }

                forResetModal =

                    "<div class=\"modal-dialog modal-dialog-centered\">"+
                    "<div class=\"modal-content\">"+
                    "<div class=\"modal-header\">"+
                    "<h5 class=\"modal-title\" id=\"optionGroupModalLabel\">옵션 그룹 추가</h5>"+
                    "<button type=\"button\" class=\"btn-close\" data-dismiss=\"modal\" aria-label=\"Close\"></button>"+
                    "</div>"+
                    "<div class=\"modal-body\">"+
                    "<div class=\"form-group\" id=\"rrrrrr\" name=\"rrrrrr\">"+
                    "<label for=\"optionGroupNamer\" class=\"col-from-label\">옵션그룹이름</label>"+
                    "<input type=\"text\" class=\"form-control\" id=\"optionGroupNamer\" value=\"\">"+
                    "</div>"+
                    "</div>"+
                    "<div class=\"modal-footer\">"+
                    //"<button type=\"button\" class=\"btn btn-primary custom\" onclick='applyOptionGroupNamer();'>옵션그룹이름적용</button>"+
                    "<button type=\"button\" class=\"btn btn-primary addOption\" data-target=\"#optionModal\" data-dismiss=\"modal\" area-label=\"Close\" onclick=\"applyOptionGroupNamer();\" data-toggle=\"modal\">옵션추가</button>"+
                    "<button type=\"button\" class=\"btn btn-primary addOptionGroup\" id=\"add-optionGroup\" data-dismiss=\"modal\" aria-label=\"Close\" data-target=\"#menuModal\" data-toggle=\"modal\">옵션 그룹 적용</button>"+
                    "</div>"+
                    "</div>"+
                    // "</div>"+
                    "</div>";


                console.log("forresetmodal : " + $('#optionGroupModal').html());
                console.log("forResetModal 대체텍스트 : " + forResetModal);

                $('#optionGroupModal').html(forResetModal);

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




    </script>


</head>
<body>
<%--<jsp:include page="/views/navbar.jsp" />--%>
<br>
<br>
<br>
<br>
<br>

<!--////////////////모달 옵션그룹 추가 시작////////////-->

<!--modal1(메뉴 추가)-->
<div class="modal fade" id="menuModal" aria-hidden="true" aria-labelledby="menuModalLabel" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-scrollable" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="menuModalLabel">메뉴 추가</h5>

                <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!--//////////////////여기에 추가 메뉴 정보///////시이이이작//////////////////////////////////-->
                <form class="form-horizontal">
                    <input type="hidden" id = "menuTruckId" name="menuTruckId" value="${truck.truckId}">

                    <div class="form-group">
                        <label for="menuName" class="col-sm-offset-1 col-sm-10 control-label">메뉴 이름</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="menuName" name="menuName" value="${menu.menuName }" placeholder="메뉴 이름">

                        </div>
                    </div>

                    <div class="form-group">
                        <label for="menuDetail" class="col-sm-offset-1 col-sm-10 control-label">메뉴상세정보</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="menuDetail" name="menuDetail" value="${menu.menuDetail }" placeholder="메뉴상세정보">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="menuPrice" class="col-sm-offset-1 col-sm-10 control-label">메뉴 가격</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="menuPrice" name="menuPrice" value="${menu.menuPrice }" placeholder="메뉴 가격">
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-10" id="sigMenu">

                            <div class="form-check form-switch" id="isThereSigMenu">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="menuImg1" class="col-sm-offset-1 col-sm-10 control-label">메뉴 이미지1</label>
                        <div class="col-sm-10">
                            <input type="file" class="form-control" id="menuImg1" name="menuImg11"  value="${menu.menuImg1}" placeholder="메뉴 이미지1" onchange="setImage1Preview(event);">
                        </div>
                        <div id="image1preview" class="col-sm-10"></div>
                    </div>

                    <div class="form-group">
                        <label for="menuImg2" class="col-sm-offset-1 col-sm-10 control-label">메뉴 이미지2</label>
                        <div class="col-sm-10">
                            <input type="file" class="form-control" id="menuImg2" name="menuImg22"  value="${menu.menuImg2}" placeholder="메뉴 이미지2" onchange="setImage2Preview(event);">
                        </div>
                        <div id="image2preview" class="col-sm-10"></div>
                    </div>

                    <div class="form-group">
                        <label for="menuImg3" class="col-sm-offset-1 col-sm-10 control-label">메뉴 이미지3</label>
                        <div class="col-sm-10">
                            <input type="file" class="form-control" id="menuImg3" name="menuImg33"  value="${menu.menuImg3}" placeholder="메뉴 이미지3" onchange="setImage3Preview(event);">
                        </div>
                        <div id="image3preview" class="col-sm-10"></div>
                    </div>

                    <hr>

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
                                img.setAttribute("style", "width:50%");
                                document.querySelector("div#image1preview").appendChild(img);

                            };

                            reader.readAsDataURL(event.target.files[0]);


                        }

                        function setImage2Preview(event){
                            var DIVimage2preview = $('#image2preview');
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
                                img.setAttribute("style", "width:50%");
                                document.querySelector("div#image2preview").appendChild(img);

                            };

                            reader.readAsDataURL(event.target.files[0]);


                        }

                        function setImage3Preview(event){
                            var DIVimage3preview = $('#image3preview');
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
                                img.setAttribute("style", "width:50%");
                                document.querySelector("div#image3preview").appendChild(img);

                            };

                            reader.readAsDataURL(event.target.files[0]);


                        }

                    </script>
                <!--//////////////////여기에 추가 메뉴 정보///////끄으으으읕//////////////////////////////////-->
                    <div id="here"></div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary customer" data-toggle="modal" data-target="#optionGroupModal" data-whatever="optionGroup" data-dismiss="modal" aria-label="Close">옵션그룹추가</button>
                <button type="button" class="btn btn-primary" id="add-menu" data-dismiss="modal" aria-label="Close">메뉴추가</button>
            </div>
        </div>
    </div>
</div>
<!--modal1(메뉴 추가 끝)-->

<%--<!--modal2(옵션그룹추가)-->--%>
<div class="modal fade" id="optionGroupModal" aria-hidden="true" aria-labelledby="optionGroupModalLabel" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="optionGroupModalLabel">옵션 그룹 추가</h5>
                <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!--옵션그룹추가 시이이이작-->
                <div class="form-group" id="rrrrrr" name="rrrrrr">
                    <label for="optionGroupNamer" class="col-from-label">옵션그룹이름</label>
                    <input type="text" class="form-control" id="optionGroupNamer" value="">
                </div>
                <!--옵션그룹추가 끄으으으읕-->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary addOption" data-target="#optionModal" data-dismiss="modal" aria-label="Close" onclick="applyOptionGroupNamer();" data-toggle="modal">옵션 추가</button>
                <button type="button" class="btn btn-primary addOptionGroup" id="add-optionGroup" data-dismiss="modal" aria-label="Close" data-target="#menuModal" data-toggle="modal">옵션 그룹 적용</button>
            </div>
        </div>
    </div>
</div>
<%--<!--modal2(옵션그룹추가 끝)-->--%>

<%--<!--modal3(옵션그룹추가)-->--%>
<div class="modal fade" id="optionModal" aria-hidden="true" aria-labelledby="optionModalLabel" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="optionModalLabel">옵션 추가</h5>
                <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!--옵션추가 시이이이이작-->
                <span>옵션 이름
                                <input type="text" class="form-control" id="optionNamer" value="${optionGroup.optionName}"></span>

                <span>옵션 가격</span>
                <input type="text" class="form-control" id="optionPricer" value="${optionGroup.optionPrice}" placeholder="옵션 가격 - 숫자를 입력해주세요.">
                <!--옵션추가 끄으으으으읕-->

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary addOption" data-dismiss="modal" aria-label="Close" data-target="#optionGroupModal" data-toggle="modal">옵션 적용</button>
            </div>
        </div>
    </div>
</div>
<%--<!--modal3(옵션그룹추가 끝)-->--%>

<!--모달 옵션그룹 추가 끝-->



<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">

    <div class="page-header">
        <h3 class="truckNameForMenu">${truck.truckName} 메뉴 관리</h3>
    </div>

    <!--메뉴 추가 버튼-->
    <a class="btn btn-warning" role="button" onclick="javascript:fncSigMenu('${truck.truckId}')" >메뉴 추가</a>
<%--    <a class="btn btn-warning" data-toggle="modal" href="#menuModal" role="button" onclick="fncSigMenu(${truck.truckId})" >메뉴 추가</a> todo : 대표메뉴 로직--%>
    <hr/>

    <script>
        // 메뉴 추가 눌렀을 때 메뉴 없으면(메뉴가 하나라도 있다면 대표메뉴일수밖에 없음) 대표메뉴 스위치 버튼 선택상태로 되어 있고 비활성화(못 누르도록, 눌러도 alert로 "대표메뉴는 최소 하나 이상이어야 합니다".)
        //                  대표메뉴 있으면 대표메뉴 스위치 버튼 선택안함 상태로 되어 있고, 누르면 대표메뉴가 이 메뉴로 바뀝니다. confirm창

        function fncSigMenu(truckId){

            //
            $.ajax({

                url:"/menu/json/isThereSigMenu/"+truckId,
                method:"get",
                success:function(data){
                    console.log("data.menu : " + data.menu[0]);
                    var isSigMenuButton="";
                    if (data.menu[0]==undefined){
                        iamSig=null;
                        iamIsThereSM = 'no';
                        isSigMenuButton +=
                            " <input class=\"form-check-input\" data-toggle=\"toggle\" data-onstyle=\"warning\" type=\"checkbox\" id=\"isSigMenu\" name=\"isSigMenu\" value=\"1\" data-val=\"disabled\" checked disabled>"+
                            "<label class=\"form-check-label\" for=\"isSigMenu\">대표메뉴여부</label>";

                    }else{

                        iamSig=data.menu;
                        iamIsThereSM = 'yes';
                        isSigMenuButton+=

                            " <input class=\"form-check-input\" data-toggle=\"toggle\" data-onstyle=\"warning\" type=\"checkbox\" id=\"isSigMenu\" name=\"isSigMenu\" value=\"0\" data-val=\"abled\">"+
                            "<label class=\"form-check-label\" for=\"isSigMenu\">대표메뉴를 이 메뉴로 변경하기</label>";


                        // $('div#isThereSigMenu.form-check.form-switch').html(isSigMenuButton); //todo 대표메뉴가 없어서 나온 버튼이니까 disabled 해놓고 클릭 시 대표메뉴는 최소 1개 있어야 합니다. alert 띄우기
                    }
                    $('div#isThereSigMenu.form-check.form-switch').html(isSigMenuButton);

                }


            });

            $('#menuModal').modal('show');

        }


        //==========대표메뉴를 클릭했을 때!===========

        $(function(){

            var divIsSigMenu = $('div#isThereSigMenu.form-check.form-switch');

            $("div#sigMenu").on("click", function(){

                alert("onclick");
                var isSigMenuButton ="";

                if(divIsSigMenu.find('input#isSigMenu').data("val")=='disabled'){
                    alert("대표메뉴는 최소 1개 이상 있어야 합니다.");
                }else if(divIsSigMenu.find('input#isSigMenu').val()==0){

                    if(!confirm("대표메뉴가 이미 있습니다. 변경하시겠습니까?")){
                        isSigMenuButton+=
                            " <input class=\"form-check-input\" data-toggle=\"toggle\" data-onstyle=\"warning\" type=\"checkbox\" id=\"isSigMenu\" value=\"0\" data-val=\"abled\" name=\"isSigMenu\">"+
                            "<label class=\"form-check-label\" for=\"isSigMenu\">대표메뉴를 이 메뉴로 변경하기</label>";
                        $('div#isThereSigMenu.form-check.form-switch').html(isSigMenuButton);
                    }else{
                        isSigMenuButton +=
                            " <input class=\"form-check-input\" data-toggle=\"toggle\" data-onstyle=\"warning\" type=\"checkbox\" id=\"isSigMenu\" value=\"1\" data-val=\"abled\" name=\"isSigMenu\" checked>"+
                            "<label class=\"form-check-label\" for=\"isSigMenu\">대표메뉴를 이 메뉴로 변경하기</label>";
                        $('div#isThereSigMenu.form-check.form-switch').html(isSigMenuButton);

                    }
                }else{

                    if(confirm("이전 대표메뉴로 다시 변경하시겠습니까?")){
                        isSigMenuButton+=
                            " <input class=\"form-check-input\" data-toggle=\"toggle\" data-onstyle=\"warning\" type=\"checkbox\" id=\"isSigMenu\" value=\"0\" data-val=\"abled\" name=\"isSigMenu\">"+
                            "<label class=\"form-check-label\" for=\"isSigMenu\">대표메뉴를 이 메뉴로 변경하기</label>";
                        $('div#isThereSigMenu.form-check.form-switch').html(isSigMenuButton);
                    }else{
                        isSigMenuButton +=
                            " <input class=\"form-check-input\" data-toggle=\"toggle\" data-onstyle=\"warning\" type=\"checkbox\" id=\"isSigMenu\" value=\"1\" data-val=\"abled\" name=\"isSigMenu\" checked>"+
                            "<label class=\"form-check-label\" for=\"isSigMenu\">대표메뉴를 이 메뉴로 변경하기</label>";
                        $('div#isThereSigMenu.form-check.form-switch').html(isSigMenuButton);

                    }

                }


            });

        });
    </script>






</div>


<!--20220117 메뉴 스타일 바꾸기 시도 -->

<style>
    .single_menu {
        position: relative;
        margin-bottom: 75px;
        transition: .3s;
    }
    .single_menu:hover img{
        -webkit-clip-path: polygon(0% 0%, 100% 0, 100% 50%, 100% 100%, 0% 100%);
        clip-path: polygon(0% 0%, 100% 0, 100% 50%, 100% 100%, 0% 100%);

    }
    .single_menu img {
        width: 33%;
        position: absolute;
        height: 140px;
        -webkit-clip-path: polygon(0% 0%, 75% 0%, 100% 50%, 75% 100%, 0% 100%);
        clip-path: polygon(0% 0%, 75% 0%, 100% 50%, 75% 100%, 0% 100%);
        transition: .3s;
        border: 1px solid #ddd;
        border-radius: 5px;
    }
    .menu_content {
        padding-left: 200px;
    }
    .menu_content h4 {
        font-size: 25px;
        font-weight: 300;
        border-bottom: 1px dashed #c0392b;
        line-height: 2;
        text-transform: capitalize;
    }
    .menu_content h4 span {
        font-size: 25px;
        font-weight: 800;
        float: right;
        font-style: italic;
        color: #c0392b;
    }
    .menu_content p {
        font-weight: 200;
        font-size: 16px;
        letter-spacing: 1px;
    }
    .menu_btn.btn.btn-danger {
        margin: 0 auto;
        display: block;
        width: 140px;
    }
    /*Menu ends*/
    .menu_btn.btn.btn-danger {
        margin: 0 auto;
        display: block;
        width: 140px;
    }
    .btn.btn-danger {
        background: #c0392b;
        border: 1px solid #c0392b;
        transition: .3s;
        position: relative;
        z-index: 1;
        text-transform: capitalize;
        font-weight: 700;
        overflow: hidden;
        padding: 15px 25px;
    }
    .btn.btn-danger::before {
        position: absolute;
        content: '';
        background: #e74c3c;
        width: 100%;
        height: 100%;
        left: -100%;
        top: 100%;
        transition: .3s;
        z-index: -1;
    }
    .btn.btn-danger:hover:before{
        top: 0;
        left: 0;
    }
</style>
<div class="container-fluid content-row">
    <div class="row mb-3">

        <c:set var="i" value="0"/>
        <c:forEach var="menu" items="${list}">
            <c:set var="i" value="${i+1}"/>
            <div class="single_menu">
                <img src="/resources/menu/${menu.menuImg1}" alt="${menu.menuName}">
                <div class="menu_content">
                    <h4>${menu.menuName}  <span>${menu.menuPrice}원</span></h4>
                    <p>${menu.menuDetail}</p>
                </div>
            </div>
<%--            <div class="flex card h-100" style="width: 17rem; margin-bottom:15px; margin-left: 10px;">--%>
<%--                <img class="card-img-top" src="/resources/menu/${menu.menuImg1}" alt="Card image cap"--%>
<%--                     style="border-bottom: 1px solid #eee; height: 200px;">--%>
<%--                <div class="card-body" style="text:center ">--%>
<%--                    <h3 class="align-content-center"> <strong style="text:center;">${menu.menuName}</strong></h3>--%>
<%--                    <h3> ${menu.menuPrice}원</h3>--%>
<%--                    <ul class='card-body-ul'>--%>
<%--                        <h4>${menu.menuDetail}</h4>--%>
<%--                    </ul>--%>
<%--                    <div class="btn-detail">--%>
<%--                        <button class="button btn-warning" name="deleteMenu" onclick="deleteMenu(${menu.menuNo});">--%>
<%--                            메뉴 삭제하기--%>
<%--                            <input type="hidden" name="menuNo" value="${menu.menuNo}"/></button>--%>
<%--                        <button class="button is-warning is-light" name="getMenu"--%>
<%--                                style='margin-left: 100px; margin-bottom: 13px; height: 25px'--%>
<%--                                onclick="updateMenu(${menu.menuNo});"--%>
<%--                        >--%>
<%--                            메뉴 수정하기--%>
<%--                            <input type="hidden" name="menuNo" value="${menu.menuNo}"/>--%>
<%--                        </button>--%>

<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
            <%--</div>--%>
        </c:forEach>
    </div>

</div>


<!--  메뉴 목록 div Start /////////////////////////////////////-->


<div class="container-fluid content-row">
    <div class="row mb-3">

        <c:set var="i" value="0"/>
        <c:forEach var="menu" items="${list}">
            <c:set var="i" value="${i+1}"/>
            <div class="flex card h-100" style="width: 17rem; margin-bottom:15px; margin-left: 10px;">
                <img class="card-img-top" src="/resources/menu/${menu.menuImg1}" alt="Card image cap"
                     style="border-bottom: 1px solid #eee; height: 200px;">
                <div class="card-body" style="text:center ">
                    <h3 class="align-content-center"> <strong style="text:center;">${menu.menuName}</strong></h3>
                    <h3> ${menu.menuPrice}원</h3>
                    <ul class='card-body-ul'>
                        <h4>${menu.menuDetail}</h4>
                    </ul>
                    <div class="btn-detail">
                        <button class="button btn-warning" name="deleteMenu" onclick="deleteMenu(${menu.menuNo}, ${menu.isSigMenu});">
                            메뉴 삭제
                            <input type="hidden" name="menuNo" value="${menu.menuNo}"/></button>
                        <button class="button is-warning is-light" name="getMenu"
                                style='margin-left: 100px; margin-bottom: 13px; height: 25px'
                                onclick="updateMenu(${menu.menuNo});"
                        >
                            메뉴 수정
                            <input type="hidden" name="menuNo" value="${menu.menuNo}"/>
                        </button>

                    </div>
                </div>
            </div>
            <%--</div>--%>
        </c:forEach>
    </div>

</div>
<!--  메뉴 목록 div End /////////////////////////////////////-->


</body>


<script>

    //메뉴 수정 클릭 시
    function updateMenu(menuNo){
        var menuNoo = menuNo;

        self.location="/menu/updateMenu?menuNo="+menuNoo;

    }

    function deleteMenu(menuNo, isSigMenu){

        if(isSigMenu==1) {
            alert("대표메뉴는 최소 한 개 이상이어야 합니다.");
        }else{

            if(!confirm("정말 삭제하시겠습니까?(복구 불가)")){

            }else{
                $.ajax({
                    url:"/menu/json/deleteMenu/"+menuNo,
                    method:"get",
                    success:function(data){
                        // console.log("")
                        alert("메뉴가 삭제되었습니다.");
                        location.reload();


                    }
                })
            }
        }


    }
</script>



</body>
</html>
