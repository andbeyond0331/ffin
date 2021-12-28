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
            $( "button.btn.btn-primary" ).on("click" , function() {
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


        ///////////////////////////////////////////////////////////////////////
        /*function fncAddMenu(){

            var truckId = $("input[name='truckId']").val();

            $("form").attr("method", "POST").attr("action","/menu/addMenu?truckId="+truckId).submit();
        }*/
        var count = 1;

        $('#exampleModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget) // Button that triggered the modal
            var recipient = button.data('whatever') // Extract info from data-* attributes

            var modal = $(this)

            // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
            // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
            modal.find('.modal-title').text('새 옵션그룹 ' + recipient)
            modal.find('.modal-body input').val(recipient)

            alert(modal.find('button.btn.btn-primary'));

            $(function(){

                modal.find('button.btn.btn-primary').on("click", function(){
                    count++;
                    var divElem = "<div id='append"+count+"'>"+recipient+count+"</div>";

                    $(divElem).appendTo("div#here.form-group");
                });

            });


        })

        function fncAddMenu(){

            var truckId = $("input[name='truckId']").val();

            $("#form-horizontal").attr("method", "POST").attr("action","/menu/addMenu?truckId="+truckId).submit();
        }






    </script>

</head>

<body>

<!-- ToolBar Start /////////////////////////////////////-->
<!-- ToolBar End /////////////////////////////////////-->

<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">
    <input type="hidden" name="truckId" value="${truck.truckId }">

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
                <input type="text" class="form-control" id="menuImg2" name="menuImg2"  value="${menu.menuImg1}" placeholder="메뉴 이미지2">
            </div>
        </div>

        <div class="form-group" id="here">
            <label for="menuImg3" class="col-sm-offset-1 col-sm-3 control-label">메뉴 이미지3</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="menuImg3" name="menuImg3"  value="${menu.menuImg3}" placeholder="메뉴 이미지3">
            </div>
        </div>
        <!--////////////////모달////////////-->

        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" data-whatever="optionGroup">Open modal for optionGroup</button>

        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">옵션그룹 추가</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <label for="optionGroupName" class="col-form-label">옵션그룹 이름</label>
                                <input type="text" class="form-control" id="optionGroupName">
                            </div>

                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">옵션그룹추가</button>
                    </div>
                </div>
            </div>
        </div>

        <!--모달 끝-->

        <div class="form-group">
            <div class="col-sm-offset-4  col-sm-4 text-center">
                <button type="button" class="btn btn-primary"  >추 &nbsp;가</button>
                <a class="btn btn-primary btn" href="#" role="button">취 &nbsp;소</a>
            </div>
        </div>
    </form>


</div>


</body>



</html>





<%--
<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>메뉴 추가</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">

    <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
    <script type="text/javascript">

       /* $(function(){

            $('input:button').click(function(){

                var type = $(this).val();
                console.log(type);
                var number =  $('#total').val();
                console.log(number);
                if(type === '+') {
                    number = parseInt(number) + 1;
                    if(number >= parseInt(${product.prodTotal}) ){
                        number = parseInt(${product.prodTotal})
                    }
                }else if(type === '-')  {
                    number = parseInt(number) - 1;
                    if(number<=0)
                        number = 0;
                }
                // 결과 출력
                console.log(number);
                $('#total').val(number);
            });

            $('.btn-default:contains("옵션그룹 추가")').attr('href','/purchase/addPurchaseCart?prodNo='+${product.prodNo});

            $("#datepicker").on("click",function(){
                $("#datepicker").datepicker({
                    minDate: "+1D",
                    maxDate: "+1M +10D",
                    dateFormat : "yy/mm/dd"
                });
            });


        });*/

        $(function(){
            alert($('span:contains("추가")').find("input[name=menuTruckId]").val());


                $('span:contains("추가하기")').click(function(){
                    alert("메뉴 ${menu.menuName}을(를) 추가하시겠습니까?");
                    $("form").attr("method", "POST").attr("action", "views/menu/addMenuOptionGroup").submit();
                });

        });
    </script>

    <style>
        body{
            padding-top:70px;
        }
    </style>
&lt;%&ndash;

</head>
<body>
&lt;%&ndash;<jsp:include page="../header.jsp"></jsp:include>&ndash;%&gt;
<div class="container">

    <div class="py-5 text-center">
        <h2>메뉴 추가 페이지</h2>
        <p class="lead">메뉴 정보를 입력해 주세요.</p>
    </div>

    <div class="row g-5">
        <div class="col-md-5 col-lg-4 order-md-last">
            <h4 class="d-flex justify-content-between align-items-center mb-3">
                <span class="text-primary">메뉴 정보</span>
                <span class="badge bg-primary rounded-pill">1</span>
            </h4>
            <ul class="list-group mb-3">
                <li class="list-group-item d-flex justify-content-between bg-light">
                    <div class="text-success">
                        <h6 class="my-0">푸드트럭 상호</h6>
                        <small>NO.${truck.truckId}</small>
                    </div>
                    <span class="text-success"></span>
                </li>
               &lt;%&ndash; <li class="list-group-item d-flex justify-content-between lh-sm">
                    <div>
                        <h6 class="my-0">메뉴 이름</h6>
                        <small class="text-muted">${menu.menuName}</small>
                    </div>
                    <span class="text-muted"></span>
                </li>
                <li class="list-group-item d-flex justify-content-between lh-sm">
                    <div>
                        <h6 class="my-0">메뉴 가격</h6>
                        <small class="text-muted">${menu.menuPrice}</small>
                    </div>
                    <span class="text-muted"></span>
                </li>
                <li class="list-group-item d-flex justify-content-between lh-sm">
                    <div>
                        <h6 class="my-0">메뉴 설명</h6>
                        <small class="text-muted">${menu.menuDetail}</small>
                    </div>
                    <span class="text-muted"></span>
                </li>&ndash;%&gt;
                <!--추후 여기에 대표메뉴 여부 버튼 추가-->
                <!-- 아래는 한 번에 여러 이미지 받는 폼 검색해서 추가하기-->
              &lt;%&ndash;  <li class="list-group-item d-flex justify-content-between lh-sm">
                    <div>
                        <h6 class="my-0">메뉴 이미지 1</h6>
                        <small class="text-muted">
                            <img src="../images/uploadFiles/${menu.menuImg1}" width="300px" height="300px">
                        </small>
                    </div>
                    <span class="text-muted"></span>
                </li>&ndash;%&gt;

            </ul>

            &lt;%&ndash;<form class="card p-2">
                <div class="input-group">
                    <a href="" class="btn btn-default" role="button">옵션 그룹 추가</a>
                </div>
            </form>&ndash;%&gt;
        </div>
        <div class="col-md-7 col-lg-8">

                <div class="my-3">
                    <hr class="my-4">
                    <div class="col-12">
                        &lt;%&ndash;@declare id="menuname"&ndash;%&gt;<label for="menuName" class="form-label">메뉴 이름</label>
                        <div class="input-group has-validation">
                            <input type="text" class="form-control" name="menuName" value="${menu.menuName}" >
                        </div>
                    </div>

                    <div class="col-12">
                        &lt;%&ndash;@declare id="menuprice"&ndash;%&gt;<label for="menuPrice" class="form-label">메뉴 가격<span class="text-muted"></span></label>
                        <div class="input-group has-validation">
                            <input type="text" class="form-control" name="menuPrice" value="${menu.menuPrice }">
                        </div>
                    </div>

                    <div class="col-12">
                        &lt;%&ndash;@declare id="menudetail"&ndash;%&gt;<label for="menuDetail" class="form-label">메뉴 설명</label>
                        <input type="text" class="form-control" name="divyAddr" value="${ empty user.addr || user.addr eq 'null' ? '' : user.addr }">
                    </div>


                </div>



                        <td align="left">
                            &lt;%&ndash;@declare id="optiongroupname"&ndash;%&gt;<label for="optionGroupName" class="form-label">옵션 그룹 이름</label>
                                <div class="input-group has-validation">
                                    <input type="text" class="form-control" name="optionGroupName" value="${optionGroup.optionGroupName}">
                                </div>
                                <span class="menuNo" hidden="">${optionGroup.menuNo}</span>
                                <span class="optionGroupNo" hidden="">${optionGroup.optionGroupNo}</span>
                        </td>
                        <div class="col-12">
                                &lt;%&ndash;@declare id="optionName"&ndash;%&gt;<label for="optionName" class="form-label">옵션 이름<span class="text-muted"></span></label>
                            <div class="input-group has-validation">
                                <input type="text" class="form-control" name="optionName" value="${optionGroup.optionName }">
                            </div>
                        </div>
                        <div class="col-12">
                                &lt;%&ndash;@declare id="optionPrice"&ndash;%&gt;<label for="optionPrice" class="form-label">옵션 가격<span class="text-muted"></span></label>
                            <div class="input-group has-validation">
                                <input type="text" class="form-control" name="optionPrice" value="${optionGroup.optionPrice }">
                            </div>
                        </div>
                        <td></td>






            <td background="/images/ct_btnbg02.gif" class="ct_btn01"  style="padding-top: 3px;">
                <!-- <a href="javascript:fncUpdateProduct();">수정</a> -->
                <span>추가하기
                <input type="hidden" name="menuTruckId" value="${menu.menuTruckId}">
                           </span>
            </td>



        </div>
    </div>
</div>
</body>
</html>

</body>
</html>&ndash;%&gt;
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
                        <td width="93%" class="ct_ttl01">메뉴 추가</td>
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
                푸드트럭 상호 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"></td>
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="105">
                            <input type="text" name="menuTruckId" class="ct_input_g" value="${truck.truckId }"
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
                메뉴이름 <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">
                <input type="text" name="menuName" class="ct_input_g" value="${menu.menuName }"
                       style="width: 100px; height: 19px" maxLength="10" minLength="6"/>
            </td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">
                메뉴가격 <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">
                <input type="text" name="menuPrice" class="ct_input_g" value="${menu.menuPrice }"
                       style="width: 100px; height: 19px" maxLength="10" minLength="6"/>
            </td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">
                메뉴 설명 <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">
                <input type="text" name="menuDetail" class="ct_input_g" value="${menu.menuDetail }"
                       style="width: 100px; height: 19px" maxLength="10" minLength="6"/>
            </td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">
                메뉴가격 <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">
                <input type="text" name="menuPrice" class="ct_input_g" value="${menu.menuPrice }"
                       style="width: 100px; height: 19px" maxLength="10" minLength="6"/>
            </td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">
                메뉴이미지 <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">
                <input type="text" name="menuImg1" class="ct_input_g" value="${menu.menuImg1 }"
                       style="width: 100px; height: 19px" maxLength="10" minLength="6"/>
            </td>
        </tr>

        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">
                옵션 그룹 이름 <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">
                <input type="text" name="optionGroupName" class="ct_input_g" value="${optionGroup.optionGroupName }"
                       style="width: 100px; height: 19px" maxLength="10" minLength="6"/>
            </td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">
                옵션이름 <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">
                <input type="text" name="optionName" class="ct_input_g" value="${optionGroup.optionName }"
                       style="width: 100px; height: 19px" maxLength="10" minLength="6"/>
            </td>
        </tr>
        <tr>
            <td height="1" colspan="3" bgcolor="D6D6D6"></td>
        </tr>
        <tr>
            <td width="104" class="ct_write">
                옵션가격 <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
            </td>
            <td bgcolor="D6D6D6" width="1"></td>
            <td class="ct_write01">
                <input type="text" name="optionPrice" class="ct_input_g" value="${optionGroup.optionPrice }"
                       style="width: 100px; height: 19px" maxLength="10" minLength="6"/>
            </td>
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
                            <span>추가하기
                            <input type="hidden" name="menuNo" value="${menu.menuNo}"/></span>
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
