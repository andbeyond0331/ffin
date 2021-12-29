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


    <!-- //////////cdn 옵션그룹추가////////////////-->

    <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>


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


        // $('#exampleModal').on('show.bs.modal', function (event) {
        //     var button = $(event.relatedTarget) // Button that triggered the modal
        //     //var recipient = button.data('whatever') // Extract info from data-* attributes
        //
        //     var modal = $(this)
        //
        //     // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        //     // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        //     //modal.find('.modal-title').text('옵션그룹' + recipient);
        //     //modal.find('.modal-body input').val(recipient);
        //
        //
        // })
        // $('#optionModal').on('show.bs.modal', function (event) {
        //     var buttonOp = $(event.relatedTarget) // Button that triggered the modal
        //     //var recipientOp = buttonOp.data('whatever') // Extract info from data-* attributes
        //
        //     var modalOp = $(this)
        //
        //     // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        //     // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        //     //modalOp.find('.modal-title').text('옵션' + recipientOp);
        //     //modal.find('.modal-body input').val(modalOp);
        //
        //
        // });

        //옵션그룹추가 모달 로직
        //var count = 0;

        $(function(){

            var modal = $('#exampleModalToggle');


            modal.find('button.btn.btn-primary').on("click", function(){
                //count++;

                realOptionGroupName = modal.find('input#optionGroupName.form-control').val();

                console.log(realOptionGroupName + " : realOptionGroupName");

                divElem = "<div class=\"form-group\" id=\""+realOptionGroupName+"-target\" name=\"optionGroupName\">"+
                    //"<label for=\"optionGroupName\" class=\"col-sm-offset-1 col-sm-3 control-label\">옵션그룹"+count+"</label>"+
                    ///"<label for=\"optionGroupName\" class=\"col-sm-offset-1 col-sm-3 control-label\">옵션그룹</label>"+
                    "<div class=\"col-xs-8 col-md-4\">"+realOptionGroupName+"</div>"+
                    ///"<input type=\"button\" value=\"삭제\" onclick=\"javascript:removeEL(\'"+realOptionGroupName+"\')\"/>" +
                    // "<input type=\"button\" value=\"옵션추가\" onclick=\"javascript:addOption(optionGroupName"+count+")\"/>" +
                    "<button type=\"button\" class=\"btn btn-primary\" onclick=\"javascript:addOption(\'"+realOptionGroupName+"\')\" data-toggle=\"modal\" data-target=\"#optionModal\" data-whatever=\"option\">옵션 추가</button>"+
                    "</div>";

                console.log("divElem :"+divElem);

                console.log("realOptionGroupName : " + realOptionGroupName);
                console.log("realOptionGroupName.toString : " + realOptionGroupName.toString());

                $('div#here').append($(divElem));

                // modal.modal('hide');
                modal.find('input#optionGroupName.form-control').val("");

            });


        });

        //옵션추가 모달 로직


        //countOp = 0;

        function addOption(indexOp){

            var modalOp = $('#optionModal');

            console.log("indexOp : "+ indexOp);


            modalOp.find('button.btn.btn-primary').on("click", function(){
                //countOp++;

                var realOptionName = modalOp.find('input#optionName.form-control').val();

                console.log(realOptionName +" : realOptionName");

                divElemOp = "<div class=\"form-group\" id=\""+realOptionName+"\" name=\"optionName\">"+
                    //"<label for=\"optionName\" class=\"col-sm-offset-1 col-sm-3 control-label\">옵션"+countOp+"</label>"+
                    ///"<label for=\"optionName\" class=\"col-sm-offset-1 col-sm-3 control-label\">옵션</label>"+
                    "<div class=\"col-xs-8 col-md-4\">"+realOptionName+"</div>"+
                    // "<input type=\"hidden\" value=\""+indexOp+"\" name=\""+indexOp+"\"/>"+
                    ///"<input type=\"button\" value=\"삭제\" onclick=\"javascript:removeELOption("+realOptionName+")\"/>" +
                    "</div>";

                console.log("divElemOp : "+divElemOp);

                //alert($('div:contains(\"'+paraOGN+'\")').html());
                //alert("append target : "+$('div#'+indexOp+'.form-group').html());

                var all = $("#"+realOptionName).length;

                //alert("all.length : " + all);

                //if(all===0){
                $('div#'+indexOp+'-target').append($(divElemOp));
                //}

                modalOp.find('input#optionName.form-control').val("");


            });

        };


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

            var truckId = $("input[name='truckId']").val();

            $(".form-horizontal").attr("method", "POST").attr("action","/menu/addMenuOptionGroup?truckId="+truckId).submit();
        }

    </script>

</head>

<body>

<!-- ToolBar Start /////////////////////////////////////-->
<!-- ToolBar End /////////////////////////////////////-->

<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">
    <input type="hidden" id = "truckId" name="truckId" value="${truck.truckId }">

    <div class="page-header text-center">
        <h3 class=" text-info">${truck.truckId}에 대한 메뉴 추가</h3>
    </div>

    <!-- form Start /////////////////////////////////////-->
    <form class="form-horizontal">

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

        <div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalToggleLabel">옵션그룹이름</h5>
                        <
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Show a second modal and hide this one with the button below.
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary" data-bs-target="#exampleModalToggle2" data-bs-toggle="modal">Open second modal</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="exampleModalToggle2" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalToggleLabel2">Modal 2</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Hide this modal and show the first with the button below.
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary" data-bs-target="#exampleModalToggle" data-bs-toggle="modal">Back to first</button>
                    </div>
                </div>
            </div>
        </div>
        <a class="btn btn-primary" data-bs-toggle="modal" href="#exampleModalToggle" role="button">Open first modal</a>

        <!--모달 옵션그룹 추가 끝-->

        <!--////////////////모달 옵션 추가 시작////////////-->

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

        <!--모달 옵션 추가 끝-->

        <div class="form-group">
            <div class="col-sm-offset-4  col-sm-4 text-center">
                <button type="submit" class="btn btn-primary"  id="addMenuOptionGroupButton">추 &nbsp;가</button>
                <a class="btn btn-primary btn" href="#" role="button">취 &nbsp;소</a>
            </div>
        </div>
    </form>


</div>


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


