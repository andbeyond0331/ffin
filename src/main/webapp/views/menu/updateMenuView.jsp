
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



        $(function(){



            $(document).on("click", "#updateMenuButton", function(){

                //todo 2022-01-13 업데이트 미루기 - 우회해서 기존 파일은 그대로 두도록 만들기


                //var truckId = $("input[name='truckId']").val();
                // alert("optionGroup개수 : " +$('input#optionGroupName.form-control').length);

                if($('input#optionGroupName.form-control').length===0){
                    $("form").attr("method", "POST").attr("action", "/menu/updateMenu").attr("enctype","multipart/form-data").submit();
                } else{
                    // console.log("fncUpdateMenu-target : "+$("form.form-horizontal").html());

                    $("form").attr("method", "POST").attr("action","/menu/updateMenuOptionGroup").attr("enctype","multipart/form-data").submit();
                    // $("form").post("/menu/addMenuOptionGroup", {}, "text")

                }

            });

        });



    </script>

    <style>
        .page-header{
            margin-top:59px;
        }
        img{
            border-radius: 10px;
            box-shadow: 0 1px 2px 1px rgba(0,0,0,0.1);
            transition: 0.2s;
        }
        input[type=text]{
            border-radius: 50px;
        }
        input[type=text]:focus{
            border-color: #ffe537;
            box-shadow: 0 0 0 1px #ffe537;
            color: ; #ffe537;
        }
        label{
            font-weight: bold;
        }

    </style>

</head>

<body>

<!-- ToolBar Start /////////////////////////////////////-->
<jsp:include page="/views/navbar.jsp" />
<!-- ToolBar End /////////////////////////////////////-->

<!--  화면구성 div Start /////////////////////////////////////-->
<section class="client_section layout_padding">
    <div class="container">

        <div class="detail-box" style="margin-top: 20px;">
            <i class="fa fa-quote-left" aria-hidden="true"></i>
            <h4 style="margin-top: 10px;">
                메뉴수정
            </h4>
        </div>

        <div class="forCenter" style="text-align: -webkit-center; margin-top: 60px;">
            <!-- form Start /////////////////////////////////////-->
            <form class="form-horizontal">
                <input type="hidden" name="menuTruckId" value="${menu.menuTruckId}">

                <div class="col-md-5">
                    <div class="data-input-box">
                        <label for="menuName" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이름</label>
                        <div >
                            <input type="text" class="form-control" id="menuName" name="menuName" value="${menu.menuName }" placeholder="메뉴 이름 수정">
                            <input type="hidden" name="menuNo" value="${menu.menuNo}">
                        </div>
                    </div>

                    <div class="data-input-box">
                        <label for="menuDetail" class="col-sm-offset-1 col-sm-3 control-label">메뉴상세정보</label>
                        <div>
                            <input type="text" class="form-control" id="menuDetail" name="menuDetail" value="${menu.menuDetail }" placeholder="메뉴상세정보 수정">
                        </div>
                    </div>

                    <div class="data-input-box">
                        <label for="menuPrice" class="col-sm-offset-1 col-sm-3 control-label">메뉴 가격</label>
                        <div>
                            <input type="text" class="form-control" id="menuPrice" name="menuPrice" value="${menu.menuPrice }" placeholder="메뉴 가격 수정">
                            <div class="form-check form-switch" id="isThereSigMenu" style="margin-left: 15px;">
                                <c:if test="${menu.isSigMenu eq 0}">
                                    <input class="form-check-input" data-toggle="toggle" data-onstyle="warning" type="checkbox" id="isSigMenu" name="isSigMenu" value="0" data-val="abled">
                                    <label class="form-check-label" for="isSigMenu" style='font-weight: normal'>대표메뉴를 이 메뉴로 변경하기</label>

                                </c:if>
                                <c:if test="${menu.isSigMenu eq 1}">
                                    <input class="form-check-input" data-toggle="toggle" data-onstyle="warning" type="checkbox" id="isSigMenu" name="isSigMenu" value="1" data-val="disabled" checked disabled>
                                    <label class="form-check-label" for="isSigMenu" style='font-weight: normal'>대표메뉴 여부</label>

                                </c:if>

                            </div>
                        </div>
                    </div>

                    <script>
                        // 메뉴 추가 눌렀을 때 메뉴 없으면(메뉴가 하나라도 있다면 대표메뉴일수밖에 없음) 대표메뉴 스위치 버튼 선택상태로 되어 있고 비활성화(못 누르도록, 눌러도 alert로 "대표메뉴는 최소 하나 이상이어야 합니다".)
                        //                  대표메뉴 있으면 대표메뉴 스위치 버튼 선택안함 상태로 되어 있고, 누르면 대표메뉴가 이 메뉴로 바뀝니다. confirm창

                        // function fncSigMenu(truckId){
                        // $(function(){
                        //
                        //     var truckId = $('input[name="menuTruckId"]').val();
                        //     //
                        //     $.ajax({
                        //         url:"/menu/json/isThereSigMenu/"+truckId,
                        //         method:"get",
                        //         success:function(data){
                        //             console.log("data.menu : " + data.menu[0]);
                        //             var isSigMenuButton="";
                        //             if (data.menu[0]==undefined){
                        //                 iamSig=null;
                        //                 iamIsThereSM = 'no';
                        //                 isSigMenuButton +=
                        //                     " <input class=\"form-check-input\" data-toggle=\"toggle\" data-onstyle=\"warning\" type=\"checkbox\" id=\"isSigMenu\" name=\"isSigMenu\" value=\"1\" data-val=\"disabled\" checked disabled>"+
                        //                     "<label class=\"form-check-label\" for=\"isSigMenu\">대표메뉴여부</label>";
                        //
                        //             }else{
                        //
                        //                 iamSig=data.menu;
                        //                 iamIsThereSM = 'yes';
                        //                 isSigMenuButton+=
                        //
                        //                     " <input class=\"form-check-input\" data-toggle=\"toggle\" data-onstyle=\"warning\" type=\"checkbox\" id=\"isSigMenu\" name=\"isSigMenu\" value=\"0\" data-val=\"abled\">"+
                        //                     "<label class=\"form-check-label\" for=\"isSigMenu\" style='font-weight: normal'>대표메뉴를 이 메뉴로 변경하기</label>";
                        //
                        //
                        //                 // $('div#isThereSigMenu.form-check.form-switch').html(isSigMenuButton); //todo 대표메뉴가 없어서 나온 버튼이니까 disabled 해놓고 클릭 시 대표메뉴는 최소 1개 있어야 합니다. alert 띄우기
                        //             }
                        //             $('div#isThereSigMenu.form-check.form-switch').html(isSigMenuButton);
                        //         }
                        //     });
                        //     // $('#menuModal').modal('show');
                        // });


                        //==========대표메뉴를 클릭했을 때!===========
                        $(function(){

                            var divIsSigMenu = $('div#isThereSigMenu.form-check.form-switch');

                            $("div#isThereSigMenu").on("click", function(){

                                // alert("onclick");
                                var isSigMenuButton ="";


                                if(divIsSigMenu.find('input#isSigMenu').data("val")=='disabled'){
                                    alert("대표메뉴는 최소 1개 이상 있어야 합니다.");
                                    // isSigMenuButton+=
                                    // " <input class=\"form-check-input\" data-toggle=\"toggle\" data-onstyle=\"warning\" type=\"checkbox\" id=\"isSigMenu\" value=\"1\" data-val=\"disabled\" name=\"isSigMenu\" checked disabled>"+
                                    // "<label class=\"form-check-label\" for=\"isSigMenu\">대표메뉴 여부</label>";
                                    // $('div#isThereSigMenu.form-check.form-switch').html(isSigMenuButton);
                                }else if(divIsSigMenu.find('input#isSigMenu').val()==0){

                                    if(!confirm("대표메뉴가 이미 있습니다. 변경하시겠습니까?")){
                                        isSigMenuButton+=
                                            " <input class=\"form-check-input\" data-toggle=\"toggle\" data-onstyle=\"warning\" type=\"checkbox\" id=\"isSigMenu\" value=\"0\" data-val=\"abled\" name=\"isSigMenu\">"+
                                            "<label class=\"form-check-label\" for=\"isSigMenu\">대표메뉴를 이 메뉴로 변경하기</label>";
                                        $('div#isThereSigMenu.form-check.form-switch').html(isSigMenuButton);
                                    }else{
                                        isSigMenuButton +=
                                            " <input class=\"form-check-input\" data-toggle=\"toggle\" data-onstyle=\"warning\" type=\"checkbox\" id=\"isSigMenu\" value=\"1\" data-val=\"abled\" name=\"isSigMenu\" checked>"+
                                            "<label class=\"form-check-label\" for=\"isSigMenu\">대표메뉴 여부</label>";
                                        $('div#isThereSigMenu.form-check.form-switch').html(isSigMenuButton);

                                    }
                                }else{

                                    if(!confirm("이전 대표메뉴로 다시 변경하시겠습니까?")){
                                        isSigMenuButton+=
                                            " <input class=\"form-check-input\" data-toggle=\"toggle\" data-onstyle=\"warning\" type=\"checkbox\" id=\"isSigMenu\" value=\"1\" data-val=\"abled\" name=\"isSigMenu\" checked>"+
                                            "<label class=\"form-check-label\" for=\"isSigMenu\">대표메뉴 여부</label>";
                                        $('div#isThereSigMenu.form-check.form-switch').html(isSigMenuButton);
                                    }else{
                                        isSigMenuButton +=
                                            " <input class=\"form-check-input\" data-toggle=\"toggle\" data-onstyle=\"warning\" type=\"checkbox\" id=\"isSigMenu\" value=\"0\" data-val=\"abled\" name=\"isSigMenu\">"+
                                            "<label class=\"form-check-label\" for=\"isSigMenu\">대표메뉴를 이 메뉴로 변경하기</label>";
                                        $('div#isThereSigMenu.form-check.form-switch').html(isSigMenuButton);

                                    }

                                }


                            });

                        });
                    </script>

                    <div class="data-input-box">
                        <label for="menuImg11" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이미지1</label>
                        <div>
                            <div id="image1preview">
                                <c:if test="${menu.menuImg1 ne null}">
                                    <img src="/resources/menu/${menu.menuImg1}" alt="메뉴 이미지" style="width:100%;">
                                </c:if>
                            </div>
                            <input type="file" class="form-control" id="menuImg11" name="menuImg11"  value="${menu.menuImg1}" placeholder="메뉴 이미지1 수정" onchange="setImage1Preview(event);" style="display: none;">
                            <div style="display: flex; justify-content: center; align-items: center;">
                                <button type="button" class="btn btn-outline-warning" id="update-img11" style="float: right; margin-top: 10px;">
                                    <label for="menuImg11" class="form-label" style="float: right; margin: 0;">
                                        <i class="fas fa-camera fa-lg" style="margin: 0;"></i>
                                    </label>
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="data-input-box">
                        <label for="menuImg22" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이미지2</label>
                        <div >
                            <div id="image2preview">
                                <c:if test="${menu.menuImg2 ne null && menu.menuImg2 ne ''}">
                                    <img src="/resources/menu/${menu.menuImg2}" alt="메뉴 이미지" style="width:100%;">
                                </c:if>
                            </div>
                            <input type="file" class="form-control" id="menuImg22" name="menuImg22"  value="${menu.menuImg2}" placeholder="메뉴 이미지2 수정" onchange="setImage2Preview(event);" style="display: none;">
                            <div style="display: flex; justify-content: center; align-items: center;">
                                <button type="button" class="btn btn-outline-warning" id="update-img22" style="float: right; margin-top: 10px;">
                                    <label for="menuImg22" class="form-label" style="float: right; margin: 0;">
                                        <i class="fas fa-camera fa-lg" style="margin: 0;"></i>
                                    </label>
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="data-input-box">
                        <label for="menuImg33" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이미지3</label>
                        <div >
                            <div id="image3preview">
                                <c:if test="${menu.menuImg3 ne null && menu.menuImg3 ne ''}">
                                    <img src="/resources/menu/${menu.menuImg3}" alt="메뉴 이미지" style="width:100%;">
                                </c:if>
                            </div>
                            <input type="file" class="form-control" id="menuImg33" name="menuImg33"  value="${menu.menuImg3}" placeholder="메뉴 이미지3 수정"  onchange="setImage3Preview(event);" style="display: none;">
                            <div style="display: flex; justify-content: center; align-items: center;">
                                <button type="button" class="btn btn-outline-warning" id="update-img33" style="float: right; margin-top: 10px;">
                                    <label for="menuImg33" class="form-label" style="float: right; margin: 0;">
                                        <i class="fas fa-camera fa-lg" style="margin: 0;"></i>
                                    </label>
                                </button>
                            </div>
                        </div>
                    </div>

                    <script>

                        function setImage1Preview(event){

                            var DIVimage1preview = $('#image1preview');
                            var isTherePreview = DIVimage1preview.find('img').length;
                            // alert("isTherePreview : " + isTherePreview);
                            //이미지파일미리보기 이미 있으면 바꾸기 구현 중-  점심먹고 왔다! 다시 시작!
                            var reader  = new FileReader();

                            if(isTherePreview==0){

                            }else{

                                DIVimage1preview.find('img').remove();

                            }

                            reader.onload = function(event){
                                var img = document.createElement("img");
                                img.setAttribute("src", event.target.result);
                                img.setAttribute("style",  "width:100%;");
                                document.querySelector("div#image1preview").appendChild(img);

                            };

                            reader.readAsDataURL(event.target.files[0]);


                        }

                        function setImage2Preview(event){
                            var DIVimage2preview = $('#image2preview');
                            var isTherePreview = DIVimage2preview.find('img').length;
                            // alert("isTherePreview : " + isTherePreview);
                            //이미지파일미리보기 이미 있으면 바꾸기 구현 중-  점심먹고 왔다! 다시 시작!
                            var reader  = new FileReader();

                            if(isTherePreview==0){

                            }else{

                                DIVimage2preview.find('img').remove();

                            }

                            reader.onload = function(event){
                                var img = document.createElement("img");
                                img.setAttribute("src", event.target.result);
                                img.setAttribute("style",  "width:100%;");
                                document.querySelector("div#image2preview").appendChild(img);

                            };

                            reader.readAsDataURL(event.target.files[0]);


                        }

                        function setImage3Preview(event){
                            var DIVimage3preview = $('#image3preview');
                            var isTherePreview = DIVimage3preview.find('img').length;
                            // alert("isTherePreview : " + isTherePreview);
                            //이미지파일미리보기 이미 있으면 바꾸기 구현 중-  점심먹고 왔다! 다시 시작!
                            var reader  = new FileReader();

                            if(isTherePreview==0){

                            }else{

                                DIVimage3preview.find('img').remove();

                            }

                            reader.onload = function(event){
                                var img = document.createElement("img");
                                img.setAttribute("src", event.target.result);
                                img.setAttribute("style",  "width:100%;");
                                document.querySelector("div#image3preview").appendChild(img);

                            };

                            reader.readAsDataURL(event.target.files[0]);


                        }

                    </script>

                    <div class="happy">


                        <c:set var="count1" value="0"></c:set>
                        <c:forEach var="optionGroup1" items="${list}">
                            <c:set var="count1" value="${count1 + 1}"/>
                            <c:if test="${count1 eq 1}">
                                <hr>

                                <div class="data-input-box">
                                    <label for="optionGroupName" class="control-label" style="padding: 0 15px;">옵션 그룹 이름 ${count1}</label>
                                    <div>
                                        <input type="text" class="form-control" id="optionGroupName" name="optionGroupName" value="${optionGroup1.optionGroupName }" placeholder="옵션 그룹 이름 수정">
                                    </div>
                                </div>

                                <hr>
                            </c:if>
                            <c:if test="${count1 ne 1}">
                                <c:set var="count2" value="0"/>
                                <c:forEach var="optionGroup2" items="${list}">
                                    <c:set var="count2" value="${count2 + 1}"/>
                                    <c:if test="${(count1 - 1) eq count2}">
                                        <c:if test="${optionGroup1.optionGroupName ne optionGroup2.optionGroupName}">
                                            <hr>

                                            <div class="data-input-box">
                                                <label for="menuName" class="control-label" style="padding: 0 15px;">옵션 그룹 이름 ${count1}</label>
                                                <div>
                                                    <input type="text" class="form-control" id="optionGroupName" name="optionGroupName" value="${optionGroup1.optionGroupName }" placeholder="옵션 그룹 이름 수정">
                                                </div>
                                            </div>

                                            <hr>
                                        </c:if>

                                    </c:if>
                                </c:forEach>
                            </c:if>

                            <div class="data-input-box">
                                <div>
                                    <label for="optionName" class="control-label" style="padding: 0 15px;">옵션 이름</label>
                                    <div>
                                        <input type="text" class="form-control" id="optionName" name="optionName" value="${optionGroup1.optionName }" placeholder="옵션 이름 수정">
                                        <input type="hidden" name="optionGroupNo" value="${optionGroup1.optionGroupNo}">
                                        <input type="hidden" name="optionGroupName" value="${optionGroup1.optionGroupName}">
                                        <input type="hidden" name="optionNo" value="${optionGroup1.optionNo}">
                                        <input type="hidden" name="optionPrice" value="${optionGroup1.optionPrice}">
                                    </div>
                                </div>

                                <div style="margin-top: 12px;">
                                    <label for="optionPrice" class="control-label" style="padding: 0 15px;">옵션 가격</label>
                                    <div>
                                        <input type="text" class="form-control" id="optionPrice" name="optionPrice" value="${optionGroup1.optionPrice }" placeholder="메뉴 가격 수정">
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div id="here"></div>

                    <div class="form-group">
                        <div class="text-center" style="display: flex; justify-content: space-evenly;">
                            <a type="button" class="btn btn-cancel btn" href="#" role="button">취 &nbsp;소</a>
                            <button type="submit" class="btn btn-default" id="updateMenuButton">수 &nbsp;정</button>
                        </div>
                    </div>

                </div>
            </form>
        </div>

    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<jsp:include page="/views/footer.jsp" />
</body>

<script>



</script>


</html>


