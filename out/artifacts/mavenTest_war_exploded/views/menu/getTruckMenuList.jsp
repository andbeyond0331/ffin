
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>




<!DOCTYPE html>

<html lang="ko">
<head>



    <title>트럭 목록</title>
    <jsp:include page="../../common/lib.jsp"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>

    <!-- bootstrap core css -->
    <link rel="stylesheet" type="text/css" href="../../resources/bootstrap/css/bootstrap.css" />
    <!-- Custom styles for this template -->
    <link href="../../resources/bootstrap/css/style.css" rel="stylesheet" />

    <!--    Favicons-->
    <link rel="apple-touch-icon" sizes="180x180" href="../../resources/bootstrap/assets/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="../../resources/bootstrap/assets/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../../resources/bootstrap/assets/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="../../resources/bootstrap/assets/favicons/favicon.ico">
    <link rel="manifest" href="../../resources/bootstrap/assets/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="../../resources/bootstrap/assets/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">

    <style>

        .search{
            margin-top: 100px;
        }
        .item {
            position: relative;
            /*float: left;*/
            /*width: 33%;*/
            background-color: #fae100;
            overflow: hidden;
            border-radius: 10px;
            box-shadow: 0 1px 2px 1px rgba(0,0,0,0.1);
            transition: 0.1s;
        }
        .item:after {
            content: '';
            display: block;
            background-color: inherit;
            opacity: 0.7;
            width: 100%;
            height: 100%;
            position: absolute;
            top: 0;
            left: 0;
            transform: scale(2) translateX(-75%) translateY(-75%) translateZ(0) rotate(-28deg);
            transition: transform 2s cubic-bezier(0.23, 1, 0.32, 1);
            border-radius: 10px;
        }
        .item:hover:after {
            transform: scale(2) translateX(0%) translateY(0%) translateZ(0) rotate(-28deg);
            border-radius: 5px;
        }
        .item:hover .item-image{
            transform: scale(1.2) translateZ(0);
            border-radius: 10px;
        }
        .item:hover .item-text{
            opacity: 1;
            transform: translateY(0);
        }
        .item-image {
            height: auto;
            backface-visibility: hidden;
            transform: translateZ(0);
            transition: transform 750ms cubic-bezier(0.23, 1, 0.32, 1);
        }
        .item-image:before {
            content: "";
            display: block;
            padding-top: 75%;
            overflow: hidden;
        }
        .item-image img {
            position: absolute;
            top: 0;
            left: 0;
            /*width: 100%;
            height: auto;*/
            height: -webkit-fill-available;
            width: -webkit-fill-available;;
            line-height: 0;
            border-radius: 10px;
            background-color: white;
        }
        .item-text {
            position: absolute;
            top: 0;
            right: 0;
            left: 0;
            bottom: 0;
            opacity: 0;
            text-align: center;
            z-index: 1;
            color: #110000;
            transition: opacity 500ms cubic-bezier(0.23, 1, 0.32, 1), transform 500ms cubic-bezier(0.23, 1, 0.32, 1);
            transition-delay: 300ms;
            transform: translateY(-20%);
        }
        .item-text-wrapper {
            width: 100%;
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
        }
        .item-text-title {
            font-weight: normal;
            /*font-style: 16px;*/
            padding: 0 15px;
            margin: 5px 0 0 0;
        }
        .item-text-dek {
            text-transform: uppercase;
            /* font-style: 14px;*/
            opacity: 0.7;
            margin: 0;
        }
        .item-link {
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            z-index: 2;
            line-height: 0;
            overflow: hidden;
            text-indent: -9999px;
        }
        .item-truck{
            /*width: 33%;*/
            display: flex;
            justify-content: center;
            margin-top: 5px;
            padding: 5px;
        }
        .item-truck span {
            display: flex;
            align-items: center;
            font-weight: normal;
            font-size: 15px;
        }
        ion-icon{
            margin-right: 2px;
        }
        .close-circle-outline{
            color: #f17228;
        }
        .add-circle-outline{
            color: #65bf96;
        }
        .landing__categories[data-v-f275d10a] {

            justify-content: center;
            flex-direction: row;
            display: flex;
            flex-wrap: wrap;
            margin: 0 auto;
            align-items: center;
        }

        .landing__categories>.category-bubble[data-v-f275d10a] {
            margin: 8px;
            text-align: center;
            background-color: #ffe537;
            border: 1.8px solid #ffe537;
            border-radius: 50%;
        }
        .landing__categories>.category-bubble[data-v-f275d10a]:hover {
            margin: 8px;
            text-align: center;
            background-color: #ffffff;
            border: 1.8px solid #ffe537;
            border-radius: 50%;
        }
        .category-bubble-link--bounce-in[data-v-21b52141] {
            -webkit-animation-duration: .3s;
            animation-duration: .3s;
            -webkit-animation-name: bounceIn-data-v-21b52141;
            animation-name: bounceIn-data-v-21b52141;
            -webkit-animation-fill-mode: backwards;
            animation-fill-mode: backwards;
        }

        .category-bubble-link .category-bubble-icon[data-v-21b52141] {
            -webkit-animation-delay: .2s;
            animation-delay: .2s;
            height: 60px;
        }


        .fadeIn[data-v-21b52141] {
            -webkit-animation-name: fadeIn;
            animation-name: fadeIn;
            -webkit-animation-duration: .3s;
            animation-duration: .3s;
            -webkit-animation-fill-mode: both;
            animation-fill-mode: both;
        }

        img {
            border-style: none;
        }

        .category-bubble-link .category-bubble-title[data-v-21b52141] {
            -webkit-animation-delay: .3s;
            animation-delay: .3s;
            margin-top: 9px;
            width: 88px;
            margin-left: auto;
            margin-right: auto;
            overflow: hidden;
            font-size: 12px;
            line-height: 1.14;
            font-weight: 300;
            max-height: 35px;
            color:black;
        }

        .fadeIn[data-v-21b52141] {
            -webkit-animation-name: fadeIn;
            animation-name: fadeIn;
            -webkit-animation-duration: .3s;
            animation-duration: .3s;
            -webkit-animation-fill-mode: both;
            animation-fill-mode: both;
        }
        .fas.fa-star, .far.fa-star{
            color: #ec6a56;
        }

    </style>

    <script type="text/javascript">



        //============= "검색"  Event  처리 =============
        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $( "#search" ).on("click" , function() {
                // 검색할 때에는 일단 기본값으로 설정
                $("input[name='cateCondition']").val(0);
                $("input[name='sortCondition']").val('distance');
                // alert("wkdsks?");
                fncGetTruckList(1);
            });


            $( "#badgeClick0").on("click" , function() {
                $("input[name='cateCondition']").val(0)

                //var sortCondition = $("input[name='sortCondition']").val()
                var sortCondition='distance'; // 원래는 이 값도 묶어가려고 해서 위처럼 코딩했는데
                // 카테고리별로 클릭하면 기본순으로 먼저 출력하는게 맞을 것 같음
                // 따라서 하위의 카테고리도 다 그렇게 변경함
                // 사실 var sortCondition='distance'; 대신에 미리 선언해놓거나, 선언하지 않아도 될거같은데
                // 지금와서 수정하기가 꾸ㅐㄲ

                fncGetSearchConditionList('1', '0', sortCondition);
            });
            $( "#badgeClick1").on("click" , function() {
                $("input[name='cateCondition']").val(1)
                var sortCondition='distance';
                fncGetSearchConditionList('1', '1', sortCondition);
            });
            $( "#badgeClick2").on("click" , function() {
                $("input[name='cateCondition']").val(2)
                var sortCondition='distance';
                fncGetSearchConditionList('1', '2', sortCondition);
            });
            $( "#badgeClick3").on("click" , function() {
                $("input[name='cateCondition']").val(3)
                var sortCondition='distance';
                fncGetSearchConditionList('1', '3', sortCondition);
            });
            $( "#badgeClick4").on("click" , function() {
                $("input[name='cateCondition']").val(4)
                var sortCondition='distance';
                fncGetSearchConditionList('1', '4', sortCondition);
            });
            $( "#badgeClick5").on("click" , function() {
                $("input[name='cateCondition']").val(5)
                var sortCondition='distance';
                fncGetSearchConditionList('1', '5', sortCondition);
            });
            $( "#badgeClick6").on("click" , function() {
                $("input[name='cateCondition']").val(6)
                var sortCondition='distance';
                fncGetSearchConditionList('1', '6', sortCondition);
            });
            $( "#badgeClick7").on("click" , function() {
                $("input[name='cateCondition']").val(7)
                var sortCondition='distance';
                fncGetSearchConditionList('1', '7', sortCondition);
            });
            $( "#badgeClick8").on("click" , function() {
                $("input[name='cateCondition']").val(8)
                var sortCondition='distance';
                fncGetSearchConditionList('1', '8', sortCondition);
            });


            $( ".category-bubble-link").on("click" , function() {
                var idx = $(this).attr('idx');

                $("input[name='cateCondition']").val(idx)
                var sortCondition='distance';
                fncGetSearchConditionList('1', idx, sortCondition);
            });


            $(document).on("click", ".order-d", function (e){
                e.preventDefault();
                //var recvUserId = $(e.currentTarget).next().text();
                $("input[name='sortCondition']").val('distance')
                var cateCondition = $("input[name='cateCondition']").val();
                fncGetSearchConditionList('1', cateCondition, 'distance');
            })
            $(document).on("click", ".order-sa", function (e){
                e.preventDefault();
                //var recvUserId = $(e.currentTarget).next().text();
                $("input[name='sortCondition']").val('starA')
                var cateCondition = $("input[name='cateCondition']").val();
                fncGetSearchConditionList('1', cateCondition, 'starA');
            })
            $(document).on("click", ".order-sd", function (e){
                e.preventDefault();
                //var recvUserId = $(e.currentTarget).next().text();
                $("input[name='sortCondition']").val('starD')
                var cateCondition = $("input[name='cateCondition']").val();
                fncGetSearchConditionList('1', cateCondition, 'starD');
            })

        });

        //=============    검색 / page 두가지 경우 모두  Event  처리 =============
        function fncGetTruckList(currentPage) {
            $("#currentPage").val(currentPage)
            $("form").attr("method" , "POST").attr("action" , "/menu/getTruckList").submit();
        }
        function fncGetSearchConditionList(currentPage, cateCondition, sortCondition) {
            $("#currentPage").val(currentPage)
            $("#cateCondition").val(cateCondition)
            $("#sortCondition").val(sortCondition)
            $("form").attr("method" , "POST").attr("action" , "/menu/getTruckList").submit();
        }





        /* 무한스크롤 */
        let isEnd = false; // 다 불러왔을 때 더이상 노출 되지 않기 위함
        var page=1;
        var roleUT = '${sessionScope.role}';



        $(window).scroll(function(){

            let $window = $(this);
            let scrollTop = $window.scrollTop();
            let windowHeight = $window.height();
            let documentHeight = $(document).height();

            //console.log("documentHeight:" + documentHeight + " | scrollTop:" + scrollTop + " | windowHeight: " + windowHeight );

            // scrollbar의 thumb가 바닥 전 30px까지 도달 하면 리스트를 가져온다.
            //if( scrollTop + windowHeight + 30 > documentHeight ){
            //if ($(window).scrollTop()  == $(document).height() - $(window).height()) {


            // 이게 '카드' 사이즈에서 가장 잘 먹혔던 무한스크롤임 근데 나는 이걸 망해버렷다
            var isBottom =  (window.innerHeight + window.scrollY) >= document.body.offsetHeight; // 바닥

            // 현재 카드 길이에서는 이게 제일 잘먹는다~~~
            //var isBottom =  scrollTop + windowHeight + 30 > documentHeight
            //var isBottom =  (window.innerHeight + window.scrollY) >= document.body.offsetHeight; // 바닥
            //var isBottom = $(window).scrollTop()  == $(document).height() - $(window).height()

            if (isBottom) {

                if(isEnd===true || isEnd ){
                    return;
                }else{
                    isEnd = true; // 스크롤시 무한대로 함수 호출하는것을 막기 위함
                    /* 마지막에 한 번 더 호출하는 현상이 있어서 수정 필요.. 그치만 무한대로 호출은 안하쟈나..?..헤헤..히..ㅠ.... */

                    loadList();
                }
            }
        })
        // loadList();




        var loadList = function(){
            /* if(isEnd === true){
                 return;
             }*/
            page++;
            // console.log("야야ㅑ")
            $.ajax({

                url : "/menu/json/getTruckList",
                method : "POST",
                dataType : "json",
                data : { currentPage : page,
                    cateCondition : $("input[name='cateCondition']").val(),
                    sortCondition : $("input[name='sortCondition']").val(),
                    searchKeyword : $("input[name='searchKeyword']").val()
                },

                //contentType:"application/json;charset=UTF-8",
                contentType: "application/x-www-form-urlencoded;",
                success : function(jsonData) {


                    var list = jsonData.list;
                    // console.log("page: "+page)
                    // console.log("list: "+list)
                    let length = list.length;

                    // console.log("length: "+length)
                    for(var i=0; i<list.length; i++){
                        var div="";



                        div +=   "<div class='card col-md-4 mb-4' style='border: 0;'>"
                            +  "<div>"
                            +" <div class='item'>"
                            +" <div class='item-image'>";
                        if ( list[i].truckSigMenuImg1 != null){
                            div += "<img src='/resources/menu/"+list[i].truckSigMenuImg1+"' alt='' />";

                        }else{
                            div += "<img src='/resources/image/truckNo.jpg' alt='' />";
                        }
                        div += "</div>"
                            + "<div class='item-text'>"
                            + " <div class='item-text-wrapper'>";

                        if (list[i].truckBusiStatus == '0'){
                            div += "<h5><span class='badge' style='background-color: #ec6a56; color: #110000'>영업종료</span></h5>";
                        }else{
                            div += "<h5><span class='badge' style='background-color: #65bf96; color: #110000'>영업중</span></h5>";
                        }


                        var truckCate = list[i].truckCate;
                        switch(truckCate){
                            case 1:
                                div += "<h5><span class='badge' style='background-color: #ffffff; color: #110000'>고기</span></h5>";
                                break;
                            case 2:
                                div += "<h5><span class='badge' style='background-color: #ffffff; color: #110000'>분식</span></h5>";
                                break;
                            case 3:
                                div += "<h5><span class='badge' style='background-color: #ffffff; color: #110000'>음료</span></h5>";
                                break;
                            case 4:
                                div += "<h5><span class='badge' style='background-color: #ffffff; color: #110000'>양식</span></h5>";
                                break;
                            case 5:
                                div += "<h5><span class='badge' style='background-color: #ffffff; color: #110000'>디저트</span></h5>";
                                break;
                            case 6:
                                div += "<h5><span class='badge' style='background-color: #ffffff; color: #110000'>한식</span></h5>";
                                break;
                            case 7:
                                div += "<h5><span class='badge' style='background-color: #ffffff; color: #110000'>일식</span></h5>";
                                break;
                            default:
                                div += "<h5><span class='badge' style='background-color: #ffffff; color: #110000'>기타</span></h5>";
                                break;
                        }

                        div +=  "<input type='hidden' name='truckId' value='"+list[i].truckId+"'>";
                        //+"<p class='item-text-dek'><strong>"+list[i].truckSigMenuName+"</strong></p>";
                        // +"<h6 class='item-text-title'>"+list[i].truckCEOIntro+"</h6>"

                        if(list[i].truckAVGStar >= 0 && list[i].truckAVGStar <0.35) {
                            div += "" +
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(list[i].truckAVGStar >= 0.35 && list[i].truckAVGStar <0.65){
                            div+=""+
                                "<i class=\"fas fa-star-half\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(list[i].truckAVGStar >= 0.65 && list[i].truckAVGStar <1.35){
                            div+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(list[i].truckAVGStar >= 1.35 && list[i].truckAVGStar <1.65){
                            div+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star-half\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(list[i].truckAVGStar >= 1.65 && list[i].truckAVGStar <2.35){
                            div+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(list[i].truckAVGStar >= 2.35 && list[i].truckAVGStar <2.65){
                            div+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star-half\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(list[i].truckAVGStar >= 2.65 && list[i].truckAVGStar <3.35){
                            div+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(list[i].truckAVGStar >= 3.35 && list[i].truckAVGStar <3.65){
                            div+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star-half\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(list[i].truckAVGStar >= 3.65 && list[i].truckAVGStar <4.35){
                            div+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(list[i].truckAVGStar >= 4.35 && list[i].truckAVGStar <4.65){
                            div+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star-half\"></i>";
                        }else if(list[i].truckAVGStar >= 4.65 && list[i].truckAVGStar <=5){
                            div+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>";
                        }

                        div +=  "<p class='item-text-dek'><strong>"+list[i].truckSigMenuName+"</strong></p>"
                            +"<h6 class='item-text-title'>"+list[i].truckNoticeContent+"</h6>";

                        div += "</div>"
                            +" </div>";


                        div += "<a class='item-link' href='/menu/getMenuList?truckId="+list[i].truckId+"'></a>";



                        div += "</div>"
                            +"<div class='item-truck'>"
                            +"<span style='text-align: center; margin: 0; box-shadow: inset 0 -11px 0 #fae100; width: fit-content; ' >"+list[i].truckName+"</span>";


                        div += "</div></div></div>";


                        $('#truckListAutokk').append(div);
                        if( length < 6 ){
                            // console.log(page)
                            isEnd = true;
                            return;
                        }
                        isEnd=false;

                    }



                },

                error : function() {

                    alert("1에러가 발생하였습니다.")

                },

            });


        }




    </script>




</head>

<body>

<!-- ToolBar Start /////////////////////////////////////-->
<jsp:include page="/views/navbar.jsp" />


    <section class="client_section layout_padding" style="padding-top: 30px;">
        <div class="container">

            <div class="col-md-12 mx-auto">
                <div class="detail-box" style="margin-top: 120px; margin-bottom: 60px;">
                    <i class="fa fa-quote-left" aria-hidden="true"></i>
                    <h4 class="truckNameForMenu" style="margin-top: 10px;">
                        푸드트럭
                    </h4>
                </div>

<%--                <hr/>--%>

                <form class="form-inline" name="detailForm">

                    <div class="col-12" style="display: flex; justify-content: space-between; margin-top: 20px;">

                        <div style="margin: 0; display: flex; justify-content: flex-end; zoom: 90%;">
                            <div class="dropdown" style="padding: 0; margin: 0;">
                                <button type="button" class="btn btn-default btn-foodtruck dropdown-toggle" id="truck-dropdown-f" data-toggle="dropdown" aria-expanded="false" style="margin:0;">
                                    <c:if test="${sortCondition eq 'distance'}">
                                        기본 순
                                    </c:if>
                                    <c:if test="${sortCondition eq 'starD'}">
                                        별점 높은 순
                                    </c:if>
                                    <c:if test="${sortCondition eq 'starA'}">
                                        별점 낮은 순
                                    </c:if>
                                </button>
                                <ul class="dropdown-menu" aria-labelledby="truck-dropdown-f">
                                    <li><a class="dropdown-item order-d" href="#" orderColurm = "distance">기본 순</a></li>
                                    <li><a class="dropdown-item order-sd" href="#" orderColurm = "starD">별점 높은 순</a></li>
                                    <li><a class="dropdown-item order-sa" href="#" orderColurm = "starA">별점 낮은 순</a></li>
                                </ul>
                            </div>
                        </div>

                        <div class="form-row" style="display: flex; justify-content: flex-end; align-items: center;">
                            <div class="form-group col-lg-6 text-center">
                                <label class="sr-only" for="searchKeyword">검색어</label>
                                <input type="text" class="form-control" id="searchKeyword" name="searchKeyword" placeholder="What are you waiting for? Hit it!" value="${! empty searchKeyword ? searchKeyword : ''}" style="width:500px; border-radius: 50px;">
                            </div>

                            <div class="col-2.1 text-right">
                                <button type="button" class="btn btn-default btn-search" id="search" style="margin: 0; zoom:90%;">검색</button>
                            </div>
                            <input type="hidden" id = "sortCondition" name="sortCondition" value="${sortCondition}">
                            <input type="hidden" id = "cateCondition" name="cateCondition" value="${cateCondition}">
                            <input type="hidden" id="currentPage" name="currentPage" value=""/>
                            <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
                        </div>
                    </div>

                    <hr style="width: -webkit-fill-available;"/>

                    <div class="col-12" style="display: flex; justify-content: center;">
                        <div class="form-row" style="margin-top: 5px;">
                            <div data-v-f275d10a="" class="landing__categories" style="max-width: 534px;">
                                <div data-v-21b52141="" data-v-f275d10a="" class="category-bubble">
                                    <a idx ='0' class="category-bubble-link category-bubble-link--bounce-in"style="animation-delay: 0.5s;" >
                                        <img data-v-21b52141="" src="https://res.cloudinary.com/glovoapp/w_60,h_60,c_fit,f_auto,q_auto:best/StoreCategories/prj0mlcuvmymzfh8pqjz" alt="Cibo" data-test-id="category-img-url" width="60" height="60" class="category-bubble-icon fadeIn">
                                        <h2 data-v-21b52141="" data-test-id="category-title" class="category-bubble-title fadeIn">
                                            전체보기                    </h2> <!---->
                                    </a> <!---->
                                </div>
                            </div>
                            <div data-v-f275d10a="" class="landing__categories" style="max-width: 534px;">
                                <div data-v-21b52141="" data-v-f275d10a="" class="category-bubble">
                                    <a idx ='1' class="category-bubble-link category-bubble-link--bounce-in"style="animation-delay: 0.5s;" >
                                        <img data-v-21b52141="" src="https://res.cloudinary.com/glovoapp/w_60,h_60,c_fit,f_auto,q_auto:best/StoreCategories/prj0mlcuvmymzfh8pqjz" alt="Cibo" data-test-id="category-img-url" width="60" height="60" class="category-bubble-icon fadeIn">
                                        <h2 data-v-21b52141="" data-test-id="category-title" class="category-bubble-title fadeIn">
                                            고기                   </h2> <!---->
                                    </a> <!---->
                                </div>
                            </div>
                            <div data-v-f275d10a="" class="landing__categories" style="max-width: 534px;">
                                <div data-v-21b52141="" data-v-f275d10a="" class="category-bubble">
                                    <a idx ='2' class="category-bubble-link category-bubble-link--bounce-in"style="animation-delay: 0.5s;" >
                                        <img data-v-21b52141="" src="https://res.cloudinary.com/glovoapp/w_60,h_60,c_fit,f_auto,q_auto:best/StoreCategories/prj0mlcuvmymzfh8pqjz" alt="Cibo" data-test-id="category-img-url" width="60" height="60" class="category-bubble-icon fadeIn">
                                        <h2 data-v-21b52141="" data-test-id="category-title" class="category-bubble-title fadeIn">
                                            분식                   </h2> <!---->
                                    </a> <!---->
                                </div>
                            </div>
                            <div data-v-f275d10a="" class="landing__categories" style="max-width: 534px;">
                                <div data-v-21b52141="" data-v-f275d10a="" class="category-bubble">
                                    <a idx ='3' class="category-bubble-link category-bubble-link--bounce-in"style="animation-delay: 0.5s;" >
                                        <img data-v-21b52141="" src="https://res.cloudinary.com/glovoapp/w_60,h_60,c_fit,f_auto,q_auto:best/StoreCategories/prj0mlcuvmymzfh8pqjz" alt="Cibo" data-test-id="category-img-url" width="60" height="60" class="category-bubble-icon fadeIn">
                                        <h2 data-v-21b52141="" data-test-id="category-title" class="category-bubble-title fadeIn">
                                            음료                   </h2> <!---->
                                    </a> <!---->
                                </div>
                            </div>
                            <div data-v-f275d10a="" class="landing__categories" style="max-width: 534px;">
                                <div data-v-21b52141="" data-v-f275d10a="" class="category-bubble">
                                    <a idx ='4' class="category-bubble-link category-bubble-link--bounce-in"style="animation-delay: 0.5s;" >
                                        <img data-v-21b52141="" src="https://res.cloudinary.com/glovoapp/w_60,h_60,c_fit,f_auto,q_auto:best/StoreCategories/prj0mlcuvmymzfh8pqjz" alt="Cibo" data-test-id="category-img-url" width="60" height="60" class="category-bubble-icon fadeIn">
                                        <h2 data-v-21b52141="" data-test-id="category-title" class="category-bubble-title fadeIn">
                                            양식                   </h2> <!---->
                                    </a> <!---->
                                </div>
                            </div>
                            <div data-v-f275d10a="" class="landing__categories" style="max-width: 534px;">
                                <div data-v-21b52141="" data-v-f275d10a="" class="category-bubble">
                                    <a idx ='5' class="category-bubble-link category-bubble-link--bounce-in"style="animation-delay: 0.5s;" >
                                        <img data-v-21b52141="" src="https://res.cloudinary.com/glovoapp/w_60,h_60,c_fit,f_auto,q_auto:best/StoreCategories/prj0mlcuvmymzfh8pqjz" alt="Cibo" data-test-id="category-img-url" width="60" height="60" class="category-bubble-icon fadeIn">
                                        <h2 data-v-21b52141="" data-test-id="category-title" class="category-bubble-title fadeIn">
                                            디저트                   </h2> <!---->
                                    </a> <!---->
                                </div>
                            </div>
                            <div data-v-f275d10a="" class="landing__categories" style="max-width: 534px;">
                                <div data-v-21b52141="" data-v-f275d10a="" class="category-bubble">
                                    <a idx ='6'  class="category-bubble-link category-bubble-link--bounce-in"style="animation-delay: 0.5s;" >
                                    <img data-v-21b52141="" src="https://res.cloudinary.com/glovoapp/w_60,h_60,c_fit,f_auto,q_auto:best/StoreCategories/prj0mlcuvmymzfh8pqjz" alt="Cibo" data-test-id="category-img-url" width="60" height="60" class="category-bubble-icon fadeIn">
                                    <h2 data-v-21b52141="" data-test-id="category-title" class="category-bubble-title fadeIn">
                                        한식                   </h2> <!---->
                                    </a> <!---->
                                </div>
                            </div>
                            <div data-v-f275d10a="" class="landing__categories" style="max-width: 534px;">
                                <div data-v-21b52141="" data-v-f275d10a="" class="category-bubble">
                                    <a idx ='7' class="category-bubble-link category-bubble-link--bounce-in"style="animation-delay: 0.5s;" >
                                        <img data-v-21b52141="" src="https://res.cloudinary.com/glovoapp/w_60,h_60,c_fit,f_auto,q_auto:best/StoreCategories/prj0mlcuvmymzfh8pqjz" alt="Cibo" data-test-id="category-img-url" width="60" height="60" class="category-bubble-icon fadeIn">
                                        <h2 data-v-21b52141="" data-test-id="category-title" class="category-bubble-title fadeIn">
                                            일식                   </h2> <!---->
                                    </a> <!---->
                                </div>
                            </div>
                            <div data-v-f275d10a="" class="landing__categories" style="max-width: 534px;">
                                <div data-v-21b52141="" data-v-f275d10a="" class="category-bubble">
                                    <a idx="8" class="category-bubble-link category-bubble-link--bounce-in" style="animation-delay: 0.5s;" >
                                        <img data-v-21b52141="" src="https://res.cloudinary.com/glovoapp/w_60,h_60,c_fit,f_auto,q_auto:best/StoreCategories/prj0mlcuvmymzfh8pqjz" alt="Cibo" data-test-id="category-img-url" width="60" height="60" class="category-bubble-icon fadeIn">
                                        <h2 data-v-21b52141="" data-test-id="category-title" class="category-bubble-title fadeIn">
                                            기타                   </h2> <!---->
                                    </a> <!---->
                                </div>
                            </div>
                        </div>
                    </div>

                    <hr style="width: -webkit-fill-available;"/>

                    <!-- end slider section -->
                    <%--</div>--%>
                    <!-- Tab 영역 태그는 ul이고 클래스는 nav와 nav-tabs를 설정한다. -->

                    <div id="truckListAutokk" class="row mb-12" style="border: 0; width: -webkit-fill-available; margin-top: 10px;">

                        <c:set var="i" value="0" />
                        <c:forEach var="truck" items="${list}" varStatus="status">
                        <c:set var="i" value="${ i+1 }" />

                            <div class="card col-md-4 mb-4" style="border: 0;">
                                <div style="display: flex; flex-direction: column;">
                                    <div class="item">
                                        <div class="item-image">
                                            <c:if test="${truck.truckSigMenuImg1 != null }">
                                                <img src="/resources/menu/${truck.truckSigMenuImg1}" alt="" />
                                            </c:if>
                                            <c:if test="${truck.truckSigMenuImg1 == null }">
                                                <img src="/resources/image/truckNo.jpg" alt="" />
                                            </c:if>
                                        </div>
                                        <div class="item-text">
                                            <div class="item-text-wrapper">

<%--                                                <div style="display: flex; justify-content: center;">--%>
                                                <c:if test="${truck.truckBusiStatus eq 0}">
                                                    <h5><span class="badge" style="margin: 0 5px; background-color: #ec6a56; color: #110000;">영업종료</span></h5>
                                                </c:if>
                                                <c:if test="${truck.truckBusiStatus eq 1}">
                                                    <h5><span class="badge" style="margin: 0 5px; background-color: #65bf96; color: #110000;">영업중</span></h5>
                                                </c:if>

                                                <c:choose>
                                                    <c:when test="${truck.truckCate eq 1}">
                                                        <h5><span class="badge" style="background-color: #ffffff; color: #110000; margin: 0 5px;">고기</span></h5>
                                                    </c:when>
                                                    <c:when test="${truck.truckCate eq 2}">
                                                        <h5><span class="badge" style="margin: 0 5px; background-color: #ffffff; color: #110000">분식</span></h5>
                                                    </c:when>
                                                    <c:when test="${truck.truckCate eq 3}">
                                                        <h5><span class="badge" style="margin: 0 5px; background-color: #ffffff; color: #110000">음료</span></h5>
                                                    </c:when>
                                                    <c:when test="${truck.truckCate eq 4}">
                                                        <h5><span class="badge" style="margin: 0 5px;background-color: #ffffff; color: #110000">양식</span></h5>
                                                    </c:when>
                                                    <c:when test="${truck.truckCate eq 5}">
                                                        <h5><span class="badge" style="margin: 0 5px; background-color: #ffffff; color: #110000">디저트</span></h5>
                                                    </c:when>
                                                    <c:when test="${truck.truckCate eq 6}">
                                                        <h5><span class="badge" style="margin: 0 5px; background-color: #ffffff; color: #110000">한식</span></h5>
                                                    </c:when>
                                                    <c:when test="${truck.truckCate eq 7}">
                                                        <h5><span class="badge" style="margin: 0 5px; background-color: #ffffff; color: #110000">일식</span></h5>
                                                    </c:when>
                                                    <c:when test="${truck.truckCate eq 8}">
                                                        <h5><span class="badge" style="margin: 0 5px; background-color: #ffffff; color: #110000">기타</span></h5>
                                                    </c:when>
                                                </c:choose>

<%--                                                </div>--%>
                                                <p class="item-text-dek"><strong>${truck.truckSigMenuName}</strong></p>

                                                <c:if test="${truck.truckAVGStar >= 0 && truck.truckAVGStar <0.35}">
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                </c:if>
                                                <c:if test="${truck.truckAVGStar >= 0.35 && truck.truckAVGStar <0.65}">
                                                    <i class="fas fa-star-half"></i>
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                </c:if>
                                                <c:if test="${truck.truckAVGStar >= 0.65 && truck.truckAVGStar <1.35}">
                                                    <i class="fas fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                </c:if>
                                                <c:if test="${truck.truckAVGStar >= 1.35 && truck.truckAVGStar <1.65}">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star-half"></i>
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                </c:if>
                                                <c:if test="${truck.truckAVGStar >= 1.65 && truck.truckAVGStar <2.35}">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                </c:if>
                                                <c:if test="${truck.truckAVGStar >= 2.35 && truck.truckAVGStar <2.65}">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star-half"></i>
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                </c:if>
                                                <c:if test="${truck.truckAVGStar >= 2.65 && truck.truckAVGStar <3.35}">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                </c:if>
                                                <c:if test="${truck.truckAVGStar >= 3.35 && truck.truckAVGStar <3.65}">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star-half"></i>
                                                    <i class="far fa-star"></i>
                                                </c:if>
                                                <c:if test="${truck.truckAVGStar >= 3.65 && truck.truckAVGStar <4.35}">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                </c:if>
                                                <c:if test="${truck.truckAVGStar >= 4.35 && truck.truckAVGStar <4.65}">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star-half"></i>
                                                </c:if>
                                                <c:if test="${truck.truckAVGStar >= 4.65 && truck.truckAVGStar <=5}">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                </c:if>
                                                <h6 class="item-text-title">${truck.truckNoticeContent}</h6>

                                            </div>
                                        </div>
                                        <a class="item-link" href="/menu/getMenuList?truckId=${truck.truckId}"></a>
                                    </div>
                                    <div class="item-truck">
                                        <span style="text-align: center; margin: 0; box-shadow: inset 0 -11px 0 #fae100; width: fit-content; ">${truck.truckName}</span>
                                    </div>
                                </div>
                            </div>
                            <%--<div class="card col-md-4 mb-4" style="border: 0; padding:0; ">
                                <div class="thumb-box">
                                    <a href="/menu/getMenuList?truckId=${truck.truckId}">
                                        <img src="/resources/menu/${truck.truckSigMenuImg1}" alt="">
                                        <span class="overlay-box">
                                                    <div class="menu-title">
                                                        <span class="meta">${truck.truckName}</span>
                                                    </div>
                                                       <span class="main-title">${truck.truckNoticeContent}</span>
                                                    <div class="menu-update">
                                                        <span class="description">
                                                            <c:if test="${truck.truckBusiStatus eq 0}">
                                                                <span class="badge" style="background-color: #ffba49; color: #110000">영업종료</span>
                                                            </c:if>
                                                            <c:if test="${truck.truckBusiStatus eq 1}">
                                                                <span class="badge" style="background-color: #fae100; color: #110000">영업중</span>
                                                            </c:if>
                                                        </span>
                                                        <span class="description">
                                                            <c:choose>
                                                                <c:when test="${truck.truckCate eq 1}">
                                                                    <h5><span class="badge" style="background-color: #ffffff; color: #110000">고기</span></h5>
                                                                </c:when>
                                                                <c:when test="${truck.truckCate eq 2}">
                                                                    <h5><span class="badge" style="background-color: #ffffff; color: #110000">분식</span></h5>
                                                                </c:when>
                                                                <c:when test="${truck.truckCate eq 3}">
                                                                    <h5><span class="badge" style="background-color: #ffffff; color: #110000">음료</span></h5>
                                                                </c:when>
                                                                <c:when test="${truck.truckCate eq 4}">
                                                                    <h5><span class="badge" style="background-color: #ffffff; color: #110000">양식</span></h5>
                                                                </c:when>
                                                                <c:when test="${truck.truckCate eq 5}">
                                                                    <h5><span class="badge" style="background-color: #ffffff; color: #110000">디저트</span></h5>
                                                                </c:when>
                                                                <c:when test="${truck.truckCate eq 6}">
                                                                    <h5><span class="badge" style="background-color: #ffffff; color: #110000">한식</span></h5>
                                                                </c:when>
                                                                <c:when test="${truck.truckCate eq 7}">
                                                                    <h5><span class="badge" style="background-color: #ffffff; color: #110000">일식</span></h5>
                                                                </c:when>
                                                                <c:when test="${truck.truckCate eq 8}">
                                                                    <h5><span class="badge" style="background-color: #ffffff; color: #110000">기타</span></h5>
                                                                </c:when>
                                                            </c:choose>
                                                        </span>
                                                        <span class="description">
                                                            <c:if test="${truck.truckAVGStar >= 0 && truck.truckAVGStar <0.35}">
                                                                <i class="far fa-star"></i>
                                                                <i class="far fa-star"></i>
                                                                <i class="far fa-star"></i>
                                                                <i class="far fa-star"></i>
                                                                <i class="far fa-star"></i>
                                                            </c:if>
                                                            <c:if test="${truck.truckAVGStar >= 0.35 && truck.truckAVGStar <0.65}">
                                                                <i class="fas fa-star-half"></i>
                                                                <i class="far fa-star"></i>
                                                                <i class="far fa-star"></i>
                                                                <i class="far fa-star"></i>
                                                                <i class="far fa-star"></i>
                                                            </c:if>
                                                            <c:if test="${truck.truckAVGStar >= 0.65 && truck.truckAVGStar <1.35}">
                                                                <i class="fas fa-star"></i>
                                                                <i class="far fa-star"></i>
                                                                <i class="far fa-star"></i>
                                                                <i class="far fa-star"></i>
                                                                <i class="far fa-star"></i>
                                                            </c:if>
                                                            <c:if test="${truck.truckAVGStar >= 1.35 && truck.truckAVGStar <1.65}">
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star-half"></i>
                                                                <i class="far fa-star"></i>
                                                                <i class="far fa-star"></i>
                                                                <i class="far fa-star"></i>
                                                            </c:if>
                                                            <c:if test="${truck.truckAVGStar >= 1.65 && truck.truckAVGStar <2.35}">
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star"></i>
                                                                <i class="far fa-star"></i>
                                                                <i class="far fa-star"></i>
                                                                <i class="far fa-star"></i>
                                                            </c:if>
                                                            <c:if test="${truck.truckAVGStar >= 2.35 && truck.truckAVGStar <2.65}">
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star-half"></i>
                                                                <i class="far fa-star"></i>
                                                                <i class="far fa-star"></i>
                                                            </c:if>
                                                            <c:if test="${truck.truckAVGStar >= 2.65 && truck.truckAVGStar <3.35}">
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star"></i>
                                                                <i class="far fa-star"></i>
                                                                <i class="far fa-star"></i>
                                                            </c:if>
                                                            <c:if test="${truck.truckAVGStar >= 3.35 && truck.truckAVGStar <3.65}">
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star-half"></i>
                                                                <i class="far fa-star"></i>
                                                            </c:if>
                                                            <c:if test="${truck.truckAVGStar >= 3.65 && truck.truckAVGStar <4.35}">
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star"></i>
                                                                <i class="far fa-star"></i>
                                                            </c:if>
                                                            <c:if test="${truck.truckAVGStar >= 4.35 && truck.truckAVGStar <4.65}">
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star-half"></i>
                                                            </c:if>
                                                            <c:if test="${truck.truckAVGStar >= 4.65 && truck.truckAVGStar <=5}">
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star"></i>
                                                                <i class="fas fa-star"></i>
                                                            </c:if>
                                                        </span>
                                                    </div>
                                                </span>
                                    </a>
                                </div>
                            </div>--%>
                            <%--
                                            <div class="card col-md-4 mb-4" style="border: 0;">
                                                <div style="display: flex; flex-direction: column;">
                                                    <div class="item">
                                                        <div class="item-image">
                                                            <c:if test="${truck.truckSigMenuImg1 ne null}">
                                                                <div class="card__background" style="background-image: url(../../resources/menu/${truck.truckSigMenuImg1})"></div>
                                                            </c:if>
                                                            <c:if test="${truck.truckSigMenuImg1 eq null}">
                                                                <div class="card__background" style="background-image: url(../../resources/image/${truck.truckProImg})"></div>
                                                            </c:if>
                                                        </div>
                                                        <div class="item-text">
                                                            <div class="item-text-wrapper">
                                                                <c:choose>
                                                                    <c:when test="${truck.truckCate eq 1}">
                                                                        <h5><span class="badge" style="background-color: #ffffff; color: #110000">고기</span></h5>
                                                                    </c:when>
                                                                    <c:when test="${truck.truckCate eq 2}">
                                                                        <h5><span class="badge" style="background-color: #ffffff; color: #110000">분식</span></h5>
                                                                    </c:when>
                                                                    <c:when test="${truck.truckCate eq 3}">
                                                                        <h5><span class="badge" style="background-color: #ffffff; color: #110000">음료</span></h5>
                                                                    </c:when>
                                                                    <c:when test="${truck.truckCate eq 4}">
                                                                        <h5><span class="badge" style="background-color: #ffffff; color: #110000">양식</span></h5>
                                                                    </c:when>
                                                                    <c:when test="${truck.truckCate eq 5}">
                                                                        <h5><span class="badge" style="background-color: #ffffff; color: #110000">디저트</span></h5>
                                                                    </c:when>
                                                                    <c:when test="${truck.truckCate eq 6}">
                                                                        <h5><span class="badge" style="background-color: #ffffff; color: #110000">한식</span></h5>
                                                                    </c:when>
                                                                    <c:when test="${truck.truckCate eq 7}">
                                                                        <h5><span class="badge" style="background-color: #ffffff; color: #110000">일식</span></h5>
                                                                    </c:when>
                                                                    <c:when test="${truck.truckCate eq 8}">
                                                                        <h5><span class="badge" style="background-color: #ffffff; color: #110000">기타</span></h5>
                                                                    </c:when>
                                                                </c:choose>
                                                                <input type="text" name="truckId" value="${truck.truckId}">
                                                                <p class="item-text-dek"><strong>${truck.truckSigMenuName}</strong></p>
                                                                <h6 class="item-text-title">${truck.truckCEOIntro}</h6>

                                                                <c:if test="${truck.truckAVGStar >= 0 && truck.truckAVGStar <0.35}">
                                                                    <i class="far fa-star"></i>
                                                                    <i class="far fa-star"></i>
                                                                    <i class="far fa-star"></i>
                                                                    <i class="far fa-star"></i>
                                                                    <i class="far fa-star"></i>
                                                                </c:if>
                                                                <c:if test="${truck.truckAVGStar >= 0.35 && truck.truckAVGStar <0.65}">
                                                                    <i class="fas fa-star-half"></i>
                                                                    <i class="far fa-star"></i>
                                                                    <i class="far fa-star"></i>
                                                                    <i class="far fa-star"></i>
                                                                    <i class="far fa-star"></i>
                                                                </c:if>
                                                                <c:if test="${truck.truckAVGStar >= 0.65 && truck.truckAVGStar <1.35}">
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="far fa-star"></i>
                                                                    <i class="far fa-star"></i>
                                                                    <i class="far fa-star"></i>
                                                                    <i class="far fa-star"></i>
                                                                </c:if>
                                                                <c:if test="${truck.truckAVGStar >= 1.35 && truck.truckAVGStar <1.65}">
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star-half"></i>
                                                                    <i class="far fa-star"></i>
                                                                    <i class="far fa-star"></i>
                                                                    <i class="far fa-star"></i>
                                                                </c:if>
                                                                <c:if test="${truck.truckAVGStar >= 1.65 && truck.truckAVGStar <2.35}">
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="far fa-star"></i>
                                                                    <i class="far fa-star"></i>
                                                                    <i class="far fa-star"></i>
                                                                </c:if>
                                                                <c:if test="${truck.truckAVGStar >= 2.35 && truck.truckAVGStar <2.65}">
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star-half"></i>
                                                                    <i class="far fa-star"></i>
                                                                    <i class="far fa-star"></i>
                                                                </c:if>
                                                                <c:if test="${truck.truckAVGStar >= 2.65 && truck.truckAVGStar <3.35}">
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="far fa-star"></i>
                                                                    <i class="far fa-star"></i>
                                                                </c:if>
                                                                <c:if test="${truck.truckAVGStar >= 3.35 && truck.truckAVGStar <3.65}">
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star-half"></i>
                                                                    <i class="far fa-star"></i>
                                                                </c:if>
                                                                <c:if test="${truck.truckAVGStar >= 3.65 && truck.truckAVGStar <4.35}">
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="far fa-star"></i>
                                                                </c:if>
                                                                <c:if test="${truck.truckAVGStar >= 4.35 && truck.truckAVGStar <4.65}">
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star-half"></i>
                                                                </c:if>
                                                                <c:if test="${truck.truckAVGStar >= 4.65 && truck.truckAVGStar <=5}">
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star"></i>
                                                                </c:if>


                                                            </div>
                                                        </div>
                                                            <a class="item-link" href="/menu/getMenuList?truckId=${truck.truckId}"></a>
                                                    </div>
                                                    <div class="item-truck">
                                                        <span>${truck.truckName}</span>
                                                        <c:if test="${truck.truckBusiStatus eq 0}">
                                                            <span class="badge" style="background-color: #ffba49; color: #110000">영업종료</span>
                                                        </c:if>
                                                        <c:if test="${truck.truckBusiStatus eq 1}">
                                                            <span class="badge" style="background-color: #fae100; color: #110000">영업중</span>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>--%>
                        </c:forEach>

                    </div>
                <!--admin truck에서 빼오기-->
                </form>
            </div>
        </div>
    </section>

<%--<jsp:include page="/views/footer.jsp" />--%>
</body>
<script src="../resources/bootstrap/js/custom.js"></script>



</html>



