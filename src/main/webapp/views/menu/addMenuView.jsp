<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
<head>
    <meta charset="utf-8">

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1" />

<%--    <link rel="canonical" href="https://getbootstrap.com/docs/5.1/examples/modals/">--%>



    <!-- Bootstrap core CSS -->
<%--    <link href="/docs/5.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">--%>
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <meta name="theme-color" content="#7952b3">

<%--    <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->--%>
<%--    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >--%>
<%--    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >--%>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<%--    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>--%>


    <!-- //////////cdn 옵션그룹추가////////////////-->

<%--    <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>--%>


    <!--  ///////////////////////// CSS ////////////////////////// -->
    <style>
        body {
            padding-top : 50px;
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


        $(function(){

            var modal = $('#exampleModal');

            modal.find('button.btn.btn-primary.custom').on("click", function(){
                //count++;

                realOptionGroupName = modal.find('input#optionGroupName.form-control').val();

                console.log(realOptionGroupName + " : realOptionGroupName");

                divElem = "<div class=\"form-group\" id=\""+realOptionGroupName+"-target\" name=\"optionGroupName\">"+
                    "<input type=\"hidden\" id=\"applyOptionGroupName+"+realOptionGroupName+"\" name=\"applyOptionGroupName\" value=\""+realOptionGroupName+"\"/>"+
                    "</div>";

                console.log("divElem :"+divElem);

                console.log("realOptionGroupName : " + realOptionGroupName);

                console.log("append-target : " + modal.find('form').html());
                modal.find('.modal-body').append($(divElem));

                modal.find('.col-from-label').text("옵션그룹이름 : " + realOptionGroupName);

                modal.find('div[name="optionGroupName"]').html(divElem);

            });


        });

        //옵션추가 모달 로직


        //countOp = 0;

        // function addOption(indexOp){
        $(function(){


            var modalOp = $('#optionModal');

            // console.log("indexOp : "+ indexOp);


            modalOp.find('button.btn.btn-primary.addOption').on("click", function(){
                //countOp++;

                var realOptionName = modalOp.find('input#optionName.form-control').val();
                var realOptionPrice = modalOp.find('input#optionPrice.form-control').val();

                console.log(realOptionName +" : realOptionName");
                console.log(realOptionPrice +" : realOptionPrice");

                divElemOp ="</hr>"+
                    "<div class=\"form-group\" id=\""+realOptionName+"\" name=\"optionName\">"+
                    //"<label for=\"optionName\" class=\"col-sm-offset-1 col-sm-3 control-label\">옵션"+countOp+"</label>"+
                    ///"<label for=\"optionName\" class=\"col-sm-offset-1 col-sm-3 control-label\">옵션</label>"+
                    "<div class=\"col-xs-8 col-md-4\">"+"옵션 이름 : "+realOptionName+"</div>"+
                    "<input type=\"hidden\" id=\"applyOptionName+"+realOptionName+"\" name=\"applyOptionName\" value=\""+realOptionName+"\"/>"+
                    "<div class=\"col-xs-8 col-md-4\">"+"옵션 가격 : "+realOptionPrice+"</div>"+
                    "<input type=\"hidden\" id=\"applyOptionPrice+"+realOptionPrice+"\" name=\"applyOptionPrice\" value=\""+realOptionPrice+"\"/>"+

                    // "<input type=\"hidden\" value=\""+indexOp+"\" name=\""+indexOp+"\"/>"+
                    ///"<input type=\"button\" value=\"삭제\" onclick=\"javascript:removeELOption("+realOptionName+")\"/>" +
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

                var applyOptionGroupName = modalApply.find('input[name="applyOptionGroupName"]').val();
                var applyOptionName = modalApply.find('input[name="applyOptionName"]').val();
                var applyOptionPrice = modalApply.find('input[name="applyOptionPrice"]').val();

                console.log(applyOptionGroupName +" : applyOptionGroupName");
                console.log(applyOptionName +" : applyOptionName");
                console.log(applyOptionPrice +" : applyOptionPrice");

                divElemApply ="</hr></br>"+
                    "<div class=\"form-group\">"+
                   " <label for=\"optionGroupName\" class=\"col-sm-offset-1 col-sm-3 control-label\">옵션그룹이름</label>"+
                "<div class=\"col-sm-4\">"+
                    "<input type=\"text\" class=\"form-control\" id=\"optionGroupName\" name=\"optionGroupName\"  value=\""+applyOptionGroupName+"\" placeholder=\""+applyOptionGroupName+"\">"+
                "</div>"+
            "</div>"+
                "</hr></br>"+
                    "<div class=\"form-group\">"+
                    " <label for=\"optionName\" class=\"col-sm-offset-1 col-sm-3 control-label\">옵션이름</label>"+
                    "<div class=\"col-sm-4\">"+
                    "<input type=\"text\" class=\"form-control\" id=\"optionName\" name=\"optionName\"  value=\""+applyOptionName+"\" placeholder=\""+applyOptionName+"\">"+
                    "</div>"+
                    "</div>"+
                    "</hr></br>"+
                    "<div class=\"form-group\">"+
                    " <label for=\"optionPrice\" class=\"col-sm-offset-1 col-sm-3 control-label\">옵션가격</label>"+
                    "<div class=\"col-sm-4\">"+
                    "<input type=\"text\" class=\"form-control\" id=\"optionPrice\" name=\"optionPrice\"  value=\""+applyOptionPrice+"\" placeholder=\""+applyOptionPrice+"\">"+
                    "</div>"+
                    "</div>";


                console.log("divElemApply : "+divElemApply);


                //$('div#'+indexOp+'-target').append($(divElemOp));
                console.log("append-apply-target : " + $('#here').html());
                // console.log("append-apply-target : " + $('#exampleModal').find('.modal-body').html());

                $('#here').append($(divElemApply));

                forResetModal =
                   // " <div class=\"modal fade\" id=\"exampleModal\" aria-hidden=\"true\" aria-labelledby=\"exampleModalLabel\" tabindex=\"-1\">"+
            "<div class=\"modal-dialog modal-dialog-centered\">"+
                "<div class=\"modal-content\">"+
                    "<div class=\"modal-header\">"+
                        "<h5 class=\"modal-title\" id=\"exampleModalLabel\">옵션그룹이름</h5>"+
                        "<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"modal\" aria-label=\"Close\"></button>"+
                    "</div>"+
                    "<div class=\"modal-body\">"+
                            "<div class=\"form-group\">"+
                                "<label for=\"optionGroupName\" class=\"col-from-label\">옵션그룹이름</label>"+
                                "<input type=\"text\" class=\"form-control\" id=\"optionGroupName\" value=\"\${optionGroup.optionGroupName}\">"+
                            "</div>"+
                   // "</div>"+
                    "<div class=\"modal-footer\">"+
                            "<button type=\"button\" class=\"btn btn-primary custom\">옵션그룹이름적용</button>"+
                            "<button type=\"button\" class=\"btn btn-primary customer\" data-bs-toggle=\"modal\" data-bs-target=\"#optionModal\" data-whatever=\"option\">옵션추가</button>"+
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


        // //옵션추가 모달 로직
        //
        // countOp = 0;
        //
        // $(function(){
        //
        //     var modalOp = $('#optionModal');
        //     //alert(modalOp.find('button.btn.btn-primary').html());
        //
        //
        //         modalOp.find('button.btn.btn-primary').on("click", function(){
        //             countOp++;
        //
        //             console.log($('div#optionGroupName'+count).html());
        //
        //             realOptionName = modalOp.find('input#optionName.form-control').val();
        //
        //             console.log(realOptionName + " : realOptionName");
        //
        //             divElemOp = "<div class=\"form-group\" id=\""+realOptionName+"\" name=\"optionName\">"+
        //                 "<label for=\"optionName\" class=\"col-sm-offset-1 col-sm-3 control-label\">옵션"+countOp+"</label>"+
        // 	                "<div class=\"col-xs-8 col-md-4\">"+realOptionName+"</div>"+
        //             "<input type=\"button\" value=\"삭제\" onclick=\"javascript:removeELOption("+realOptionName+")\"/>" +
        //             "</div>";
        //
        //             console.log("divElemOp :"+divElemOp);
        //
        //                // $('div#optionGroupName'+count).append($(divElemOp));
        //
        //             $('')
        //
        //             // modal.modal('hide');
        //
        //
        //         });
        //
        // });
        function removeEL(idIndex){
            console.log("removeEL(옵션그룹 삭제)");
            console.log("삭제 타겟 : " + $('div#'+idIndex+'.form-group').html());
            confirm("삭제하시겠습니까?");
            $('div#'+idIndex+'.form-group').remove();

            //count--;
        }

        function removeELOption(idIndex){
            $(idIndex).remove();
            confirm("삭제하시겠습니까?");
            //countOp--;
        }

        function fncAddMenu(){

            //var truckId = $("input[name='truckId']").val();
            console.log("fncAddMenu-target : "+$("form.form-horizontal").html());

            $("form").attr("method", "POST").attr("action","/menu/addMenuOptionGroup").submit();
            // $("form").post("/menu/addMenuOptionGroup", {}, "text")
        }

    </script>

</head>

<body>

<!-- ToolBar Start /////////////////////////////////////-->
<!-- ToolBar End /////////////////////////////////////-->

<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">


    <div class="page-header text-center">
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
            <label for="isSigMenu" class="col-sm-offset-1 col-sm-3 control-label">대표메뉴여부</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="isSigMenu" name="isSigMenu" value="${menu.isSigMenu}" placeholder="대표메뉴여부">
            </div>
        </div>

        <div class="form-group">
            <label for="menuImg1" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이미지1</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="menuImg1" name="menuImg1"  value="${menu.menuImg1}" placeholder="메뉴 이미지1">
            </div>
        </div>

        <div class="form-group">
            <label for="menuImg2" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이미지2</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="menuImg2" name="menuImg2"  value="${menu.menuImg2}" placeholder="메뉴 이미지2">
            </div>
        </div>

        <div class="form-group">
            <label for="menuImg3" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이미지3</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="menuImg3" name="menuImg3"  value="${menu.menuImg3}" placeholder="메뉴 이미지3">
            </div>
        </div>

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
                            <div class="form-group">
                                <label for="optionGroupName" class="col-from-label">옵션그룹이름</label>
                                <input type="text" class="form-control" id="optionGroupName" value="${optionGroup.optionGroupName}">
                            </div>
                    </div>
                    <div class="modal-footer">
                        <%--                        <button class="btn btn-primary" data-bs-target="#optionModalLabel" data-bs-toggle="modal">옵션추가</button>--%>
                            <button type="button" class="btn btn-primary custom">옵션그룹이름적용</button>
                            <button type="button" class="btn btn-primary customer" data-bs-toggle="modal" data-bs-target="#optionModal" data-whatever="option">옵션추가</button>
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
                            <input type="text" class="form-control" id="optionName" value="${optionGroup.optionName}">
<%--                            <label for="optionPrice" class="col-form-label">옵션 가격</label>--%>
                            <input type="text" class="form-control" id="optionPrice" value="${optionGroup.optionPrice}">
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<%--<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>--%>
<%--<script src="/docs/5.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>--%>
</body>



</html>




<%--<%@ page language="java" contentType="text/html; charset=utf-8"--%>
<%--         pageEncoding="utf-8"%>--%>

<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>

<%--<!DOCTYPE html>--%>

<%--<html>--%>
<%--<head>--%>
<%--    <meta charset="x-UTF-16LE-BOM">--%>

<%--    <!-- 참조 : http://getbootstrap.com/css/   참조 -->--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0" />--%>

<%--    <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->--%>
<%--    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >--%>
<%--    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >--%>
<%--    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>--%>
<%--    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>--%>


<%--    <!-- //////////cdn 옵션그룹추가////////////////-->--%>

<%--    <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>--%>


<%--    <!--  ///////////////////////// CSS ////////////////////////// -->--%>
<%--    <style>--%>
<%--        body {--%>
<%--            padding-top : 50px;--%>
<%--        }--%>
<%--    </style>--%>

<%--    <!--  ///////////////////////// JavaScript ////////////////////////// -->--%>
<%--    <script type="text/javascript">--%>

<%--        //============= "추가"  Event 연결 =============--%>
<%--        $(function() {--%>
<%--            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)--%>
<%--            $( "#addMenuOptionGroupButton" ).on("click" , function() {--%>
<%--                fncAddMenu();--%>
<%--            });--%>
<%--        });--%>

<%--        //============= "취소"  Event 처리 및  연결 =============--%>
<%--        $(function() {--%>
<%--            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)--%>
<%--            $("a[href='#' ]").on("click" , function() {--%>
<%--                $("form")[0].reset();--%>
<%--            });--%>
<%--        });--%>


<%--        // $('#exampleModal').on('show.bs.modal', function (event) {--%>
<%--        //     var button = $(event.relatedTarget) // Button that triggered the modal--%>
<%--        //     //var recipient = button.data('whatever') // Extract info from data-* attributes--%>
<%--        //--%>
<%--        //     var modal = $(this)--%>
<%--        //--%>
<%--        //     // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).--%>
<%--        //     // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.--%>
<%--        //     //modal.find('.modal-title').text('옵션그룹' + recipient);--%>
<%--        //     //modal.find('.modal-body input').val(recipient);--%>
<%--        //--%>
<%--        //--%>
<%--        // })--%>
<%--        // $('#optionModal').on('show.bs.modal', function (event) {--%>
<%--        //     var buttonOp = $(event.relatedTarget) // Button that triggered the modal--%>
<%--        //     //var recipientOp = buttonOp.data('whatever') // Extract info from data-* attributes--%>
<%--        //--%>
<%--        //     var modalOp = $(this)--%>
<%--        //--%>
<%--        //     // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).--%>
<%--        //     // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.--%>
<%--        //     //modalOp.find('.modal-title').text('옵션' + recipientOp);--%>
<%--        //     //modal.find('.modal-body input').val(modalOp);--%>
<%--        //--%>
<%--        //--%>
<%--        // });--%>

<%--        //옵션그룹추가 모달 로직--%>
<%--        //var count = 0;--%>

<%--        $(function(){--%>

<%--            var modal = $('#exampleModal');--%>


<%--                modal.find('button.btn.btn-primary').on("click", function(){--%>
<%--                    //count++;--%>

<%--                    realOptionGroupName = modal.find('input#optionGroupName.form-control').val();--%>

<%--                    console.log(realOptionGroupName + " : realOptionGroupName");--%>



<%--                    divElem = "<div class=\"form-group\" id=\""+realOptionGroupName+"-target\" name=\"optionGroupName\">"+--%>
<%--                        //"<label for=\"optionGroupName\" class=\"col-sm-offset-1 col-sm-3 control-label\">옵션그룹"+count+"</label>"+--%>
<%--                        ///"<label for=\"optionGroupName\" class=\"col-sm-offset-1 col-sm-3 control-label\">옵션그룹</label>"+--%>
<%--			                "<div class=\"col-xs-8 col-md-4\">"+realOptionGroupName+"</div>"+--%>
<%--                    ///"<input type=\"button\" value=\"삭제\" onclick=\"javascript:removeEL(\'"+realOptionGroupName+"\')\"/>" +--%>
<%--                    // "<input type=\"button\" value=\"옵션추가\" onclick=\"javascript:addOption(optionGroupName"+count+")\"/>" +--%>
<%--                     "<button type=\"button\" class=\"btn btn-primary\" onclick=\"javascript:addOption(\'"+realOptionGroupName+"\')\" data-toggle=\"modal\" data-target=\"#optionModal\" data-whatever=\"option\">옵션 추가</button>"+--%>
<%--                    "</div>";--%>

<%--                    console.log("divElem :"+divElem);--%>

<%--                    console.log("realOptionGroupName : " + realOptionGroupName);--%>
<%--                    console.log("realOptionGroupName.toString : " + realOptionGroupName.toString());--%>

<%--                    $('div#here').append($(divElem));--%>

<%--                    // modal.modal('hide');--%>
<%--                    modal.find('input#optionGroupName.form-control').val("");--%>

<%--                });--%>


<%--        });--%>

<%--        //옵션추가 모달 로직--%>


<%--        //countOp = 0;--%>

<%--        function addOption(indexOp){--%>

<%--            var modalOp = $('#optionModal');--%>

<%--            console.log("indexOp : "+ indexOp);--%>


<%--            modalOp.find('button.btn.btn-primary').on("click", function(){--%>
<%--                //countOp++;--%>

<%--                var realOptionName = modalOp.find('input#optionName.form-control').val();--%>

<%--                console.log(realOptionName +" : realOptionName");--%>

<%--                divElemOp = "<div class=\"form-group\" id=\""+realOptionName+"\" name=\"optionName\">"+--%>
<%--                    //"<label for=\"optionName\" class=\"col-sm-offset-1 col-sm-3 control-label\">옵션"+countOp+"</label>"+--%>
<%--                    ///"<label for=\"optionName\" class=\"col-sm-offset-1 col-sm-3 control-label\">옵션</label>"+--%>
<%--                    "<div class=\"col-xs-8 col-md-4\">"+realOptionName+"</div>"+--%>
<%--                    // "<input type=\"hidden\" value=\""+indexOp+"\" name=\""+indexOp+"\"/>"+--%>
<%--                    ///"<input type=\"button\" value=\"삭제\" onclick=\"javascript:removeELOption("+realOptionName+")\"/>" +--%>
<%--                    "</div>";--%>

<%--                console.log("divElemOp : "+divElemOp);--%>

<%--                //alert($('div:contains(\"'+paraOGN+'\")').html());--%>
<%--                //alert("append target : "+$('div#'+indexOp+'.form-group').html());--%>

<%--                var all = $("#"+realOptionName).length;--%>

<%--                //alert("all.length : " + all);--%>

<%--                //if(all===0){--%>
<%--                    $('div#'+indexOp+'-target').append($(divElemOp));--%>
<%--                //}--%>

<%--                modalOp.find('input#optionName.form-control').val("");--%>


<%--            });--%>

<%--        };--%>


<%--        // //옵션추가 모달 로직--%>
<%--        //--%>
<%--        // countOp = 0;--%>
<%--        //--%>
<%--        // $(function(){--%>
<%--        //--%>
<%--        //     var modalOp = $('#optionModal');--%>
<%--        //     //alert(modalOp.find('button.btn.btn-primary').html());--%>
<%--        //--%>
<%--        //--%>
<%--        //         modalOp.find('button.btn.btn-primary').on("click", function(){--%>
<%--        //             countOp++;--%>
<%--        //--%>
<%--        //             console.log($('div#optionGroupName'+count).html());--%>
<%--        //--%>
<%--        //             realOptionName = modalOp.find('input#optionName.form-control').val();--%>
<%--        //--%>
<%--        //             console.log(realOptionName + " : realOptionName");--%>
<%--        //--%>
<%--        //             divElemOp = "<div class=\"form-group\" id=\""+realOptionName+"\" name=\"optionName\">"+--%>
<%--        //                 "<label for=\"optionName\" class=\"col-sm-offset-1 col-sm-3 control-label\">옵션"+countOp+"</label>"+--%>
<%--		// 	                "<div class=\"col-xs-8 col-md-4\">"+realOptionName+"</div>"+--%>
<%--        //             "<input type=\"button\" value=\"삭제\" onclick=\"javascript:removeELOption("+realOptionName+")\"/>" +--%>
<%--        //             "</div>";--%>
<%--        //--%>
<%--        //             console.log("divElemOp :"+divElemOp);--%>
<%--        //--%>
<%--        //                // $('div#optionGroupName'+count).append($(divElemOp));--%>
<%--        //--%>
<%--        //             $('')--%>
<%--        //--%>
<%--        //             // modal.modal('hide');--%>
<%--        //--%>
<%--        //--%>
<%--        //         });--%>
<%--        //--%>
<%--        // });--%>
<%--        function removeEL(idIndex){--%>
<%--            console.log("removeEL(옵션그룹 삭제)");--%>
<%--            console.log("삭제 타겟 : " + $('div#'+idIndex+'.form-group').html());--%>
<%--            confirm("삭제하시겠습니까?");--%>
<%--            $('div#'+idIndex+'.form-group').remove();--%>

<%--            //count--;--%>
<%--        }--%>

<%--        function removeELOption(idIndex){--%>
<%--            $(idIndex).remove();--%>
<%--            confirm("삭제하시겠습니까?");--%>
<%--            //countOp--;--%>
<%--        }--%>

<%--        function fncAddMenu(){--%>

<%--            var truckId = $("input[name='truckId']").val();--%>

<%--            $(".form-horizontal").attr("method", "POST").attr("action","/menu/addMenuOptionGroup?truckId="+truckId).submit();--%>
<%--        }--%>

<%--    </script>--%>

<%--</head>--%>

<%--<body>--%>

<%--<!-- ToolBar Start /////////////////////////////////////-->--%>
<%--<!-- ToolBar End /////////////////////////////////////-->--%>

<%--<!--  화면구성 div Start /////////////////////////////////////-->--%>
<%--<div class="container">--%>
<%--    <input type="hidden" id = "truckId" name="truckId" value="${truck.truckId }">--%>

<%--    <div class="page-header text-center">--%>
<%--        <h3 class=" text-info">${truck.truckId}에 대한 메뉴 추가</h3>--%>
<%--    </div>--%>

<%--    <!-- form Start /////////////////////////////////////-->--%>
<%--    <form class="form-horizontal">--%>

<%--        <div class="form-group">--%>
<%--            <label for="menuName" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이름</label>--%>
<%--            <div class="col-sm-4">--%>
<%--                <input type="text" class="form-control" id="menuName" name="menuName" value="${menu.menuName }" placeholder="메뉴 이름">--%>

<%--            </div>--%>
<%--        </div>--%>

<%--        <div class="form-group">--%>
<%--            <label for="menuDetail" class="col-sm-offset-1 col-sm-3 control-label">메뉴상세정보</label>--%>
<%--            <div class="col-sm-4">--%>
<%--                <input type="text" class="form-control" id="menuDetail" name="menuDetail" value="${menu.menuDetail }" placeholder="메뉴상세정보">--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <div class="form-group">--%>
<%--            <label for="menuPrice" class="col-sm-offset-1 col-sm-3 control-label">메뉴 가격</label>--%>
<%--            <div class="col-sm-4">--%>
<%--                <input type="text" class="form-control" id="menuPrice" name="menuPrice" value="${menu.menuPrice }" placeholder="메뉴 가격">--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <div class="form-group">--%>
<%--            <label for="isSigMenu" class="col-sm-offset-1 col-sm-3 control-label">대표메뉴여부</label>--%>
<%--            <div class="col-sm-4">--%>
<%--                <input type="text" class="form-control" id="isSigMenu" name="isSigMenu" value="${menu.isSigMenu}" placeholder="대표메뉴여부">--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <div class="form-group">--%>
<%--            <label for="menuImg1" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이미지1</label>--%>
<%--            <div class="col-sm-4">--%>
<%--                <input type="text" class="form-control" id="menuImg1" name="menuImg1"  value="${menu.menuImg1}" placeholder="메뉴 이미지1">--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <div class="form-group">--%>
<%--            <label for="menuImg2" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이미지2</label>--%>
<%--            <div class="col-sm-4">--%>
<%--                <input type="text" class="form-control" id="menuImg2" name="menuImg2"  value="${menu.menuImg2}" placeholder="메뉴 이미지2">--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <div class="form-group">--%>
<%--            <label for="menuImg3" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이미지3</label>--%>
<%--            <div class="col-sm-4">--%>
<%--                <input type="text" class="form-control" id="menuImg3" name="menuImg3"  value="${menu.menuImg3}" placeholder="메뉴 이미지3">--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <div id="here"></div>--%>
<%--        <!--////////////////모달 옵션그룹 추가 시작////////////-->--%>

<%--        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" data-whatever="optionGroup">옵션그룹 추가</button>--%>

<%--        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">--%>
<%--            <div class="modal-dialog" role="document">--%>
<%--                <div class="modal-content">--%>
<%--                    <div class="modal-header">--%>
<%--                        <h5 class="modal-title" id="exampleModalLabel">옵션그룹 추가</h5>--%>
<%--                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">--%>
<%--                            <span aria-hidden="true">&times;</span>--%>
<%--                        </button>--%>
<%--                    </div>--%>
<%--                    <div class="modal-body">--%>
<%--                        <form>--%>
<%--                            <div class="form-group">--%>
<%--                                <label for="optionGroupName" class="col-form-label">옵션그룹 이름</label>--%>
<%--                                <input type="text" class="form-control" id="optionGroupName" value="">--%>
<%--                            </div>--%>

<%--                        </form>--%>
<%--                    </div>--%>
<%--                    <div class="modal-footer">--%>
<%--                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>--%>
<%--                        <button type="button" class="btn btn-primary" id="add-optionGroup">옵션그룹추가</button>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <!--모달 옵션그룹 추가 끝-->--%>

<%--        <!--////////////////모달 옵션 추가 시작////////////-->--%>

<%--        <div class="modal fade" id="optionModal" tabindex="-1" role="dialog" aria-labelledby="optionModalLabel" aria-hidden="true">--%>
<%--            <div class="modal-dialog" role="document">--%>
<%--                <div class="modal-content">--%>
<%--                    <div class="modal-header">--%>
<%--                        <h5 class="modal-title" id="optionModalLabel">옵션 추가</h5>--%>
<%--                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">--%>
<%--                            <span aria-hidden="true">&times;</span>--%>
<%--                        </button>--%>
<%--                    </div>--%>
<%--                    <div class="modal-body">--%>
<%--                        <form>--%>
<%--                            <div class="form-group">--%>
<%--                                <label for="optionName" class="col-form-label">옵션 이름</label>--%>
<%--                                <input type="text" class="form-control" id="optionName" value="">--%>
<%--                            </div>--%>

<%--                        </form>--%>
<%--                    </div>--%>
<%--                    <div class="modal-footer">--%>
<%--                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>--%>
<%--                        <button type="button" class="btn btn-primary" id="add-option">옵션추가</button>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <!--모달 옵션 추가 끝-->--%>

<%--        <div class="form-group">--%>
<%--            <div class="col-sm-offset-4  col-sm-4 text-center">--%>
<%--                <button type="submit" class="btn btn-primary"  id="addMenuOptionGroupButton">추 &nbsp;가</button>--%>
<%--                <a class="btn btn-primary btn" href="#" role="button">취 &nbsp;소</a>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </form>--%>


<%--</div>--%>


<%--</body>--%>



<%--</html>--%>


