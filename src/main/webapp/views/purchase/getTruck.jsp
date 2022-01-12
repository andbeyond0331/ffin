<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>메뉴 목록</title>
    <jsp:include page="../../common/lib.jsp"/>

    <script>
        <%--        메뉴 상세보기 모달에서 장바구니에 담기!--%>

        $(function(){

            var modalApply = $('#exampleModalLong');


            //수량 제공 역할 메뉴 담기
            $(document).on("click", "#addCart", function(){
                var menuOdList = [];

                //원래 세션에 있는가?
                var originalSession = [];
                var getItem = sessionStorage.getItem("menuOdList");
                //alert("원래 세션 : " + getItem);
                if(getItem!=null && getItem!=""){

                    originalSession = JSON.parse(sessionStorage.getItem("menuOdList"));

                    for(var i=0; i<originalSession.length; i++){
                        menuOdList.push(originalSession[i]);
                        alert("원래꺼 담는 중 담을거: " + originalSession[i]);
                        alert("원래꺼 담는 중 담긴 menuOdList: " + menuOdList);
                    }
                }

                var orderDetail = {
                    odMenuNo : modalApply.find('div[name="odMenuNo"]').text(),
                    odMenuName : modalApply.find('div[name="odMenuName"]').text(),
                    odMenuImg1 : modalApply.find('div[name="odMenuImg1"]').data('menuImg'),
                    OdMenuDetail : modalApply.find('div[name="odMenuDetail"]').text(),
                    OdMenuPrice : modalApply.find('div[name="odMenuPrice"]').text(),
                    OdMenuQtyFlag : 0,
                    odOptionName : null,
                    odOptionGroupNo : null,
                    odOptionGroupName : null,
                    odOptionNo : null,
                    odOptionPrice : null
                };
                menuOdList.push(orderDetail);
                //alert("orderDetail : " + orderDetail);

                //수량 제외 옵션그룹 정보 담기

                //     //optionGroup
                //
                var isThereOptionGroup = modalApply.find('input:radio:checked').length;

                if(isThereOptionGroup!=0){
                    for (let i = 0; i < isThereOptionGroup; i++) {
                        var optionGroupOrderDetail = {
                            odMenuNo : modalApply.find('div[name="odMenuNo"]').text(),
                            odMenuName : modalApply.find('div[name="odMenuName"]').text(),
                            odMenuImg1 : modalApply.find('div[name="odMenuImg1"]').data('menuImg'),
                            odMenuDetail : modalApply.find('div[name="odMenuDetail"]').text(),
                            odMenuPrice : modalApply.find('div[name="odMenuPrice"]').text(),
                            odMenuQtyFlag : 1,
                            odOptionName : modalApply.find('input:radio:checked').eq(i).data("op"),
                            odOptionGroupNo : modalApply.find('input:radio:checked').eq(i).parent('div').find('input[name="odOptionGroupNo"]').val(),
                            odOptionGroupName : modalApply.find('input:radio:checked').eq(i).parent('div').find('input[name="odOptionGroupName"]').val(),
                            odOptionNo : modalApply.find('input:radio:checked').eq(i).parent('div').find('input[name="odOptionNo"]').val(),
                            odOptionPrice : modalApply.find('input:radio:checked').eq(i).parent('div').find('input[name="odOptionPrice"]').val()


                        }

                        menuOdList.push(optionGroupOrderDetail);
                    }
                }








                sessionStorage.setItem("menuOdList", JSON.stringify(menuOdList));



                var beforeAnyway = JSON.parse(sessionStorage.getItem("menuOdList"));
                var beforeAnywayList = sessionStorage.getItem("menuOdList");


                // alert("자면서 만들었나? getItem JSONparsing한거: " + beforeAnyway);
                // alert("자면서 만들었나? getItem 한거: " + beforeAnywayList);


                for( var i in beforeAnyway){
                    // console.log("beforeAnyway : " + beforeAnyway[i]);
                    for(var j in beforeAnyway[i]){
                        console.log("afterAnyway key : " +j+"/value : " + beforeAnyway[i][j]);
                    }
                }



            });

        });

    </script>

    <!--장바구니 css-->
    <style>
        div.col-md-5.col-lg-4.order-md-last{
            /*position:sticky;*/
            /*top:0px;*/
        }
        div.sticky{
            position:sticky;
            top:0px;
        }
    </style>


    <style>
        .card {
            display: flex;
            /*justify-content: space-between;*/
            margin: 0 70px;
            /*margin-top: 65px;*/
            flex-wrap: wrap;
            float: left;
        }
        .modal-header{
            margin-left : 39px;
        }
        .modal-body{
            margin-left : 39px;
        }
        .modal-happy{
            margin-left : 39px;
        }
    </style>


    <script type="text/javascript">



        // 별점 출력
        function ratingToPercent() {
            const score = +this.restaurant.averageScore * 20;
            return score + 1.5;
        }

        // 메뉴 상세보기
        function getMenu(menuNo){

            // 메뉴에 해당하는 옵션그룹이 있니?
            var optionGroupCount = 0;
            $.ajax({
                url:"/menu/json/isThereOG/"+menuNo,
                method:"get",
                success:function(data){
                    // console.log("data : " + data)
                    optionGroupCount = data;
                }
            });

            // alert("optionGroupCount : " + optionGroupCount);

            $.ajax({
                url:"/menu/json/getMenu/"+menuNo,
                method:"get",

                success: function(data){
                    // console.log("data : " + data.menu)
                    var div="";
                    var modalFooter = "";

                    div +="<div class=\"page-header\">"+
                        "<h3 class=\"getMenuTitle custom\">"+data.menu.menuTruckId+"</h3>"+
                        "</div>"+
                        "<div class=\"row\">"+
                        "<div class=\"col-xs-4 col-md-2\"><strong>메뉴번호</strong></div>"+
                        " <div class=\"col-xs-8 col-md-4\" name=\"odMenuNo\">"+data.menu.menuNo+"</div>"+
                        "</div>"+
                        "<hr/>"+
                        "<div class=\"row\">"+
                        "<div class=\"col-xs-4 col-md-2 \"><strong>메뉴 이름</strong></div>"+
                        "<div class=\"col-xs-8 col-md-4\" name=\"odMenuName\">"+data.menu.menuName+"</div>"+
                        "</div>"+
                        "<hr/>"+
                        "<div class=\"row\">"+
                        "<div class=\"col-xs-4 col-md-2 \"><strong>메뉴이미지1</strong></div>"+
                        "<div class=\"col-xs-8 col-md-4\" name=\"odMenuImg1\" data-menuImg=\""+data.menu.menuImg1+"\">" +
                        "<img src=\"/resources/image/"+data.menu.menuImg1+"\"" +
                        "style=\"border-bottom: 1px solid #eee; height: 200px;\" "+
                        "alt=\""+data.menu.menuName+"의 이미지1\" title=\"메뉴이미지1\"></div> </div>"+
                        "<hr/>"+
                        "<div class=\"row\">" +
                        "<div class=\"col-xs-4 col-md-2 \">" +
                        "<strong>메뉴상세정보</strong>" +
                        "</div><div class=\"col-xs-8 col-md-4\" name=\"odMenuDetail\">"+data.menu.menuDetail+"</div>"+
                        "</div><hr/>"+
                        "<div class=\"row\">"+
                        "<div class=\"col-xs-4 col-md-2\"><strong>대표메뉴여부</strong></div>"+
                        "<div class=\"col-xs-8 col-md-4\">"+data.menu.isSigMenu+"</div>"+
                        "</div><hr/><div class=\"row\">"+
                        "<div class=\"col-xs-4 col-md-2 \"><strong>메뉴가격</strong></div>"+
                        "<div class=\"col-xs-8 col-md-4\" name=\"odMenuPrice\">"+data.menu.menuPrice+"</div></div>" +
                        // "<input type=\"hidden\" name=\"odMenuQty\" value="+ //todo 보류입니다!(수량을 hidden으로 넣을지가)
                        "<hr/>";

                    $('.modal-body').html(div);

                    if(optionGroupCount!=0){
                        getOptionGroupListOnModal(data.menu.menuNo);
                    }


                    $('#exampleModalLong').modal('show');


                }
            })
        }

        function getOptionGroupListOnModal(menuNo){

            $.ajax({
                url:"/menu/json/getOptionGroupListOnModal/"+menuNo,
                method:"get",
                success:function(data){
                    // console.log("data.optionGroup[0].optionGroupName : " +data.optionGroup[0].optionGroupName)
                    var divOG ="<table>";
                    var modalFooterOG ="";

                    var optionGroupPLZ=0;

                    for (var x of data.optionGroup) {
                        optionGroupPLZ++;
                        //옵션그룹이름이 최초 호출될 때만 옵션그룹이름 보여주기
                        if(optionGroupPLZ!=1){
                            if(!(data.optionGroup[optionGroupPLZ-1].optionGroupName===data.optionGroup[optionGroupPLZ-2].optionGroupName)){
                                divOG+=""+
                                    "<hr><div class=\"row\"> " +
                                    // "<div class=\"col-xs-4 col-md-2\">" +
                                    // "<strong>옵션 그룹 이름</strong></div>"+
                                    "<div class=\"col-xs-8 col-md-4\"><strong>"+x.optionGroupName+"</strong></div>"+
                                    "</div><hr>";
                            }
                        }else{
                            divOG+=""+
                                "<hr><div class=\"row\"> " +
                                // "<div class=\"col-xs-4 col-md-2\">" +
                                // "<strong>옵션 그룹 이름</strong></div>"+
                                "<div class=\"col-xs-8 col-md-4\"><strong>"+x.optionGroupName+"</strong></div>"+
                                "</div><hr>";
                        }
                        divOG+=""+

                            "<div class=\"row\"> " +
                            "<div class=\"col-xs-4 col-md-2\">" +
                            // "<label class=\"form-check-label\" for=\"optionName+OGName"+x.optionGroupName+"\"><strong>옵션 이름</strong></label></div>"+
                            "<div class=\"col-xs-8 col-md-4\">" +
                            "<input class=\"form-check-input\" type=\"radio\" name=\"optionName+OGName"+x.optionGroupName+"\" id=\"optionName+OGName"+x.optionGroupName+"\" data-op=\""+x.optionName+"\">"+x.optionName+"" +
                            "<input type=\"hidden\" name=\"odOptionGroupNo\" value=\""+x.optionGroupNo+"\">"+
                            "<input type=\"hidden\" name=\"odOptionGroupName\" value=\""+x.optionGroupName+"\">"+
                            "<input type=\"hidden\" name=\"odOptionNo\" value=\""+x.optionNo+"\">"+
                            "<input type=\"hidden\" name=\"odOptionPrice\" value=\""+x.optionPrice+"\">"+
                            "</div>"+
                            // "<div class=\"row\">"+
                            // "<div class=\"col-xs-4 col-md-2\"><strong>옵션 가격</strong></div>"+
                            "<span class=\"col-xs-8 col-md-4\" style=\"right:0px;\">"+x.optionPrice+"</span>"+
                            "</div>"+
                            "</div>"+

                            "";
                    }


                    $('.modal-happy').html(divOG);


                }
            })

        }


    </script>

    <style>

        <%--        별점 css--%>
        .star-ratings {
            color: #aaa9a9;
            position: relative;
            unicode-bidi: bidi-override;
            width: max-content;
            -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
            -webkit-text-stroke-width: 1.3px;
            -webkit-text-stroke-color: #2b2a29;
            font-size: 30px;
        }

        .star-ratings-fill {
            color: #fff58c;
            padding: 0;
            position: absolute;
            z-index: 1;
            display: flex;
            top: 0;
            left: 0;
            /*overflow: hidden;*/
            -webkit-text-fill-color: gold;
        }

        .star-ratings-base {
            z-index: 0;
            padding: 0;
        }

        .truckNameForMenu{
            color:black;
            font-weight: bolder;
            text-align: center;
        }
    </style>

</head>
<body>
<jsp:include page="/views/navbar.jsp" />
<br>
<br>
<br>
<br>
<br>


<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">

    <div class="page-header">
        <h3 class="truckNameForMenu">${truck.truckName}</h3>
    </div>
    <div class="star-ratings">
        <div
                class="star-ratings-fill space-x-2 text-lg"
                :style="{ width: ratingToPercent + '%' }"
        >
            <c:if test="${rvTotal ne null}">
                <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>(${rvTotal})
            </c:if>
            <c:if test="${rvTotal eq null}">
                <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
            </c:if>

        </div>
        <div class="star-ratings-base space-x-2 text-lg">
            <c:if test="${rvTotal ne null}">
                <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>(${rvTotal})
            </c:if>
            <c:if test="${rvTotal eq null}">
                <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
            </c:if>

        </div>
        <%--            <div class="beside-of-star-ratings">(${rvTotal})</div>--%>

    </div>

    <!--================truck info 시작=============-->
    <div class="row">

        <div class="col-xs-4 col-md-2"><strong>프 로 필 이 미 지</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckProImg}</div>
        <div class="col-xs-4 col-md-2"><strong>영 업 상 태</strong></div>
        <c:if test="${truck.truckBusiStatus eq 0}">
            <div class="col-xs-8 col-md-4">영업 중</div>
        </c:if>
        <c:if test="${truck.truckBusiStatus eq 1}">
            <div class="col-xs-8 col-md-4">영업 종료</div>
        </c:if>
        <div class="col-xs-4 col-md-2"><strong>전 화 번 호</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckPhone}</div>

        <div class="col-xs-4 col-md-2"><strong>사 장 님 공 지</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckNoticeContent}</div>

    </div>

    <!--================truck info 끝=============-->

    <hr/>



</div>
<!--  메뉴 목록 div Start /////////////////////////////////////-->
<body class="row g-5">
<!--헝헝헝-->

<div class="col-md-5 col-lg-4 order-md-last">
    <div class="sticky">

        <h4 class="d-flex justify-content-between align-items-center mb-3" style="width:259px;">
            <span class="text">장바구니</span>

        </h4>
        <ul class="list-group mb-3" style="width:259px;">
            <li class="list-group-item d-flex justify-content-between lh-sm">
                <div>
                    <h6 class="my-0">Product name</h6>
                    <small class="text-muted">Brief description</small>
                </div>
                <span class="text-muted">$12</span>
            </li>
            <li class="list-group-item d-flex justify-content-between lh-sm">
                <div>
                    <h6 class="my-0">Second product</h6>
                    <small class="text-muted">Brief description</small>
                </div>
                <span class="text-muted">$8</span>
            </li>
            <li class="list-group-item d-flex justify-content-between lh-sm">
                <div>
                    <h6 class="my-0">Third item</h6>
                    <small class="text-muted">Brief description</small>
                </div>
                <span class="text-muted">$5</span>
            </li>
            <li class="list-group-item d-flex justify-content-between bg-light">
                <div class="text-success">
                    <h6 class="my-0">Promo code</h6>
                    <small>EXAMPLECODE</small>
                </div>
                <span class="text-success">−$5</span>
            </li>
            <li class="list-group-item d-flex justify-content-between">
                <span>Total (USD)</span>
                <strong>$20</strong>
            </li>
        </ul>

        <button type="button" class="btn btn-warning">주문하기</button>
    </div>
    <%--</form></div>--%>
</div>

<!--헝헝헝 끝-->


<div class="container col-md-7 col-lg-8">

    <c:set var="i" value="0"/>
    <c:forEach var="menu" items="${list}">
        <c:set var="i" value="${i+1}"/>
        <div class="card" style="width: 17rem; margin-bottom:15px; margin-left: 10px;">
            <img class="card-img-top" src="/resources/menu/${menu.menuImg1}" alt="Card image cap"
                <%--                        <img class="card-img-top" src="/resources/image/menu/${menu.menuImg1}" alt="Card image cap"--%>
                 style="border-bottom: 1px solid #eee; height: 200px;">
            <div class="card-body" style="text:center ">
                <h3 class="align-content-center"> <strong style="text:center;">${menu.menuName}</strong></h3>
                <h3> ${menu.menuPrice}원</h3>
                <ul class='card-body-ul'>
                    <h4>${menu.menuDetail}</h4>
                </ul>
                <div class="btn-detail">
                    <button class="button is-warning is-light" name="getMenu"
                            style='margin-left: 100px; margin-bottom: 13px; height: 25px'
                            onclick="getMenu(${menu.menuNo});"
                    >
                        메뉴 상세보기
                        <input type="hidden" name="menuNo" value="${menu.menuNo}"/>
                    </button>
                        <%--                                <div class="bd-example">--%>
                        <%--                                    <button type="button" name="getMenu" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModalLong">--%>
                        <%--                                        Launch demo modal--%>

                        <%--                                    </button>--%>
                        <%--                                    <input type="hidden" name="menuNo" value="${menu.menuNo}"/>--%>
                        <%--                                </div>--%>
                </div>
            </div>
        </div>
    </c:forEach>

</div>
<!--  메뉴 목록 div End /////////////////////////////////////-->


</body>


<!--////////////////모달 메뉴 상세보기 시작////////////-->
<!-- Modal -->

<div class="modal fade" id="exampleModalLong" tabindex="-1" aria-labelledby="exampleModalLongTitle" style="display: none;" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">메뉴 정보</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"></span>
                </button>
            </div>
            <div class="modal-body" style="min-height: 500px">
                <p>This is some placeholder content to show the scrolling behavior for modals. Instead of repeating the text the modal, we use an inline style set a minimum height, thereby extending the length of the overall modal and demonstrating the overflow scrolling. When content becomes longer than the height of the viewport, scrolling will move the modal as needed.</p>
            </div>
            <div class="modal-happy">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-default" id="addCart" name="addCart">장바구니로!</button>
            </div>
        </div>
    </div>
</div>

<script>
    $(function(){
        var modal = $('#exampleModalLong');

        $("#exampleModalLong").on('hide.bs.modal', function(e){
            window.location.reload();
            e.stopImmediatePropagation();
        });

        $("#addCart").on("click", function(){
            // 카트에 담기!(selected 등..)

        });

        $("body").on("click", "button[name='getMenu']", function(){
            var menuNo = $(this).parent().find("input[name='menuNo']").val();
            // alert("menuNo : " + menuNo);
            getMenu(menuNo);
        });

        // function getMenuDetail(menuNo){
        //
        // }

    })
</script>



</body>
</html>