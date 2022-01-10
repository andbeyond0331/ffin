<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>메뉴 목록</title>
    <jsp:include page="../../common/lib.jsp"/>

    <style>
        .card.menu {
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
                    console.log("data : " + data)
                    optionGroupCount = data;
                }
            });

            // alert("optionGroupCount : " + optionGroupCount);

            $.ajax({
                url:"/menu/json/getMenu/"+menuNo,
                method:"get",

                success: function(data){
                    console.log("data : " + data.menu)
                    var div="";
                    var modalFooter = "";

                    div +="<div class=\"page-header\">"+
                    "<h3 class=\"getMenuTitle custom\">"+data.menu.menuTruckId+"</h3>"+
                        "</div>"+
                        "<div class=\"row\">"+
                        "<div class=\"col-xs-4 col-md-2\"><strong>메뉴번호</strong></div>"+
                        " <div class=\"col-xs-8 col-md-4\">"+data.menu.menuNo+"</div>"+
                        "</div>"+
                        "<hr/>"+
                        "<div class=\"row\">"+
                        "<div class=\"col-xs-4 col-md-2 \"><strong>메뉴 이름</strong></div>"+
                        "<div class=\"col-xs-8 col-md-4\">"+data.menu.menuName+"</div>"+
                        "</div>"+
                        "<hr/>"+
                        "<div class=\"row\">"+
                        "<div class=\"col-xs-4 col-md-2 \"><strong>메뉴이미지1</strong></div>"+
                        "<div class=\"col-xs-8 col-md-4\">" +
                        "<img src=\"/resources/image/"+data.menu.menuImg1+"\"" +
                        "style=\"border-bottom: 1px solid #eee; height: 200px;\" "+
                        "alt=\""+data.menu.menuName+"의 이미지1\" title=\"메뉴이미지1\"></div> </div>"+
                        "<hr/>"+
                        "<div class=\"row\">" +
                        "<div class=\"col-xs-4 col-md-2 \">" +
                        "<strong>메뉴상세정보</strong>" +
                        "</div><div class=\"col-xs-8 col-md-4\">"+data.menu.menuDetail+"</div>"+
                        "</div><hr/>"+
                        "<div class=\"row\">"+
                        "<div class=\"col-xs-4 col-md-2\"><strong>대표메뉴여부</strong></div>"+
                        "<div class=\"col-xs-8 col-md-4\">"+data.menu.isSigMenu+"</div>"+
                        "</div><hr/><div class=\"row\">"+
                        "<div class=\"col-xs-4 col-md-2 \"><strong>메뉴가격</strong></div>"+
                        "<div class=\"col-xs-8 col-md-4\">"+data.menu.menuPrice+"</div></div><hr/>";

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
                    console.log("data.optionGroup[0].optionGroupName : " +data.optionGroup[0].optionGroupName)
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
                            "<input class=\"form-check-input\" type=\"radio\" name=\"optionName+OGName"+x.optionGroupName+"\" id=\"optionName+OGName"+x.optionGroupName+"\">"+x.optionName+"</div>"+
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
        overflow: hidden;
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
<%--        <div class="col-xs-4 col-md-2"><strong>아 이 디</strong></div>--%>
<%--        <div class="col-xs-8 col-md-4">${truck.truckId}</div>--%>
<%--        <div class="col-xs-4 col-md-2"><strong>상 호</strong></div>--%>
<%--        <div class="col-xs-8 col-md-4">${truck.truckName}</div>--%>
<%--        <div class="col-xs-4 col-md-2"><strong>별 점</strong></div>--%>
<%--        <div class="col-xs-8 col-md-4">${truck.truckAVGStar}</div>--%>
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
<%--        <div class="col-xs-4 col-md-2"><strong>위 도</strong></div>--%>
<%--        <div class="col-xs-8 col-md-4">${truck.truckMapLa}</div>--%>
<%--        <div class="col-xs-4 col-md-2"><strong>경 도</strong></div>--%>
<%--        <div class="col-xs-8 col-md-4">${truck.truckMapLo}</div>--%>
        <div class="col-xs-4 col-md-2"><strong>사 장 님 공 지</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckNoticeContent}</div>
<%--        <div class="col-xs-4 col-md-2"><strong>공 지 사 진</strong></div>--%>
<%--        <div class="col-xs-8 col-md-4">${truck.truckNoticeImg}</div>--%>
    </div>

    <!--================truck info 끝=============-->

    <hr/>



</div>
<!--  메뉴 목록 div Start /////////////////////////////////////-->

<div class="container mt-3">

                <c:set var="i" value="0"/>
                <c:forEach var="menu" items="${list}">
                    <c:set var="i" value="${i+1}"/>
                    <div class="card menu" style="width: 17rem; margin-bottom:15px; margin-left: 10px;">
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

<!--////////////////모달 메뉴 상세보기 시작////////////-->
<!-- Modal -->
<%--    <div class="modal fade" id="staticBackdrop" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">--%>
<%--        <div class="modal-dialog" role="document">--%>
<%--            <div class="modal-content">--%>
<%--                <div class="modal-header">--%>
<%--                    <h5 class="modal-title" id="staticBackdropLabel">메뉴 상세정보</h5>--%>
<%--                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">--%>
<%--                        <span aria-hidden="true"></span>--%>
<%--                    </button>--%>
<%--                </div>--%>
<%--                <div class="modal-body">--%>
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
