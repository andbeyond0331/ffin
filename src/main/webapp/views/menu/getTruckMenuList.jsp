
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>

<html lang="ko">
<head>

    <title>트럭 목록</title>
    <jsp:include page="../../common/lib.jsp"/>

    <style>

        .cards-box {
            display: flex;
            justify-content: flex-start;
            margin: 0 70px;
            margin-top: 65px;
            flex-wrap: wrap;

        }
        .container{
            /*margin-top: 132px*/
        }
        .ui-timepicker-container{
            z-index:1151 !important;
        }
        .ui-datepicker-div { z-index: 999999; }

        :root{
            --background-dark: #fdbf5d;
            --text-light: rgba(255,255,255,0.6);
            --text-lighter: rgba(255,255,255,0.9);
            --spacing-s: 8px;
            --spacing-m: 16px;
            --spacing-l: 24px;
            --spacing-xl: 32px;
            --spacing-xxl: 64px;
            --width-container: 1200px;
        }

        *{
            border: 0;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html{
            height: 100%;
            font-family: 'Montserrat', sans-serif;
            font-size: 14px;
        }

        body{
            height: 100%;
        }

        .hero-section{
            align-items: flex-start;

            display: flex;
            min-height: 100%;
            justify-content: center;
            padding: var(--spacing-xxl) var(--spacing-l);
        }

        .card-grid{
            display: grid;
            grid-template-columns: repeat(1, 1fr);
            grid-column-gap: var(--spacing-l);
            grid-row-gap: var(--spacing-l);
            max-width: var(--width-container);
            width: 100%;
        }

        @media(min-width: 540px){
            .card-grid{
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media(min-width: 960px){
            .card-grid{
                grid-template-columns: repeat(4, 1fr);
            }
        }

        .card{
            list-style: none;
            position: relative;
            BORDER: 0;
            box-shadow: 0 2px 4px 2px rgb(0 0 0 / 25%);
            /*border-radius: 2rem*/
        }

        .card:before{
            content: '';
            display: block;
            padding-bottom: 5%;
            width: 100%;
        }

        .card__background{
            background-size: cover;
            background-position: center;
            /*border-radius: var(--spacing-l);*/
            bottom: 0;
            filter: brightness(0.75) saturate(1.2) contrast(0.85);
            left: 0;
            position: absolute;
            right: 0;
            top: 0;
            border: 0;
            transform-origin: center;
            /*transform: scale(1) translateZ(0);*/
            transition:
                    filter 200ms linear,
                    transform 200ms linear;
        }

        .card:hover .card__background{
            /*transform: scale(1.05) translateZ(0);*/
            border: 0;
        }

        .card-grid:hover > .card:not(:hover) .card__background{
            filter: brightness(0.5) saturate(50%) contrast(1.0) blur(5px);
            border: 0;

        }

        .card__content{
            left: 0;
            padding: var(--spacing-l);
            position: absolute;
            top: 0;
        }

        .card__category{
            color: var(--text-light);
            font-size: 1.1rem;
            margin-bottom: var(--spacing-s);
            text-transform: uppercase;
        }

        .card__heading{
            color: var(--text-lighter);
            font-size: 25px;
            text-shadow: 2px 2px 20px rgba(0,0,0,0.2);
            line-height: 1.4;
            word-spacing: 100vw;
        }

    </style>

    <style>
        @import url(https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap);

        body {
            background: #f9f9f9;
            font-family: "roboto", sans-serif;
        }

        .main-content {
            padding-top: 6px;
            padding-bottom: 100px;
        }

        a {
            text-decoration: none;
        }

        .food-card {
            background: #fff;
            /*border-radius: 5px;*/
            overflow: hidden;
            margin-bottom: 30px;
            -webkit-box-shadow: 0 2px 10px rgba(0, 0, 0, 0.06);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.06);
            -webkit-transition: 0.1s;
            transition: 0.1s;
        }

        .food-card:hover {
            -webkit-box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

        .food-card .food-card_img {
            display: block;
            position: relative;
        }

        .food-card .food-card_img img {
            width: 100%;
            height: 200px;
            -o-object-fit: cover;
            object-fit: cover;
        }

        .food-card .food-card_img i {
            position: absolute;
            top: 20px;
            right: 30px;
            color: #fff;
            font-size: 25px;
            -webkit-transition: all 0.1s;
            transition: all 0.1s;
        }

        .food-card .food-card_img i:hover {
            top: 18px;
            right: 28px;
            font-size: 29px;
        }

        .food-card .food-card_content {
            padding: 15px;
        }

        .food-card .food-card_content .food-card_title-section {
            height: 100px;
            overflow: hidden;
        }

        .food-card .food-card_content .food-card_title-section .food-card_title {
            font-size: 24px;
            color: #333;
            font-weight: 500;
            display: block;
            line-height: 1.3;
            margin-bottom: 8px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .food-card .food-card_content .food-card_title-section .food-card_author {
            font-size: 15px;
            display: block;
        }

        .food-card .food-card_content .food-card_bottom-section .space-between {
            display: -webkit-box;
            display: -ms-flexbox;
            display: flex;
            -webkit-box-pack: justify;
            -ms-flex-pack: justify;
            justify-content: space-between;
        }

        .food-card .food-card_content .food-card_bottom-section .food-card_subscribers {
            margin-left: 17px;
        }

        .food-card .food-card_content .food-card_bottom-section .food-card_subscribers img,
        .food-card .food-card_content .food-card_bottom-section .food-card_subscribers .food-card_subscribers-count {
            height: 45px;
            width: 45px;
            /*border-radius: 45px;*/
            border: 3px solid #fff;
            margin-left: -17px;
            float: left;
            background: #f5f5f5;
        }

        .food-card .food-card_content .food-card_bottom-section .food-card_subscribers .food-card_subscribers-count {
            position: relative;
        }

        .food-card .food-card_content .food-card_bottom-section .food-card_subscribers .food-card_subscribers-count span {
            position: absolute;
            top: 50%;
            left: 50%;
            -webkit-transform: translate(-50%, -50%);
            transform: translate(-50%, -50%);
            font-size: 13px;
        }

        .food-card .food-card_content .food-card_bottom-section .food-card_price {
            font-size: 28px;
            font-weight: 500;
            color: #F47A00;
        }

        .food-card .food-card_content .food-card_bottom-section .food-card_order-count {
            width: 130px;
        }

        .food-card .food-card_content .food-card_bottom-section .food-card_order-count input {
            background: #f5f5f5;
            border-color: #f5f5f5;
            -webkit-box-shadow: none;
            box-shadow: none;
            text-align: center;
        }

        .food-card .food-card_content .food-card_bottom-section .food-card_order-count button {
            border-color: #f5f5f5;
            border-width: 3px;
            -webkit-box-shadow: none;
            box-shadow: none;
        }

        @media (min-width: 992px) {
            .food-card--vertical {
                display: -webkit-box;
                display: -ms-flexbox;
                display: flex;
                position: relative;
                height: 235px;
            }

            .food-card--vertical .food-card_img img {
                width: 200px;
                height: 100%;
                -o-object-fit: cover;
                object-fit: cover;
            }
        }
    </style>

    <script>
        $(function(){
            // 메뉴가 선택되어 active가 되기 전 이벤트
            // 선택되기 전 이벤트 가져오기
            $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
                e.target // 현재 설정된 tab
                e.relatedTarget // 이전에 설정된 탭
                var thiss = $(e.target); //선택된 요소 오브젝트화
                //data-load가 false인 경우 content에 data-load함
                if(!thiss.data("load")){
                    //tab-content의 id 취득
                    var id = thiss.attr("href");
                    //페이지 로드
                    location.reload(thiss.data("url"));
                    // $(id).load(thiss.data("url"));

                    //data-load를 true로 변환하여 중복 로딩 방지
                    thiss.data("load", true);
                }



            });
            // 메뉴가 선택되어 active가 된 후 이벤트
            $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                e.target // 현재 설정된 tab
                e.relatedTarget // 이전에 설정된 탭

            });
            // 다른 메뉴가 선택되어 active가 remove 되기 전 이벤트
            $('a[data-toggle="tab"]').on('hide.bs.tab', function (e) {
                e.target // 현재 설정된 tab
                e.relatedTarget // 이전에 설정된 탭
            });
            // 다른 메뉴가 선택되어 active가 remove 된 후 이벤트
            $('a[data-toggle="tab"]').on('hidden.bs.tab', function (e) {
                e.target // 현재 설정된 tab
                e.relatedTarget // 이전에 설정된 탭
            });
        })

  </script>



    <!-- Bootstrap core CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
                    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>



    <!--  ///////////////////////// CSS ////////////////////////// -->
    <style>
        body {
            padding-top : 50px;
        }

        .nav{
            margin-left: 138px;
        }

        li.nav-item-custom{
            color: #ffcf46;
        }

    </style>

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
        // $(function() {
        //     //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
        //     $("a[href='#' ]").on("click" , function() {
        //         $("form")[0].reset();
        //     });
        // });

        // function fncGetTruckYap(){
        //     self.location="/menu/getMenuList?truckNo=" + $('button.button.is-warning.is-light').find('input[name=menuNo]').val();
        // };
        //
        // $(function(){
        //     $("a[href='#!']").on("click", function(){
        //        self.location="/menu/getMenuList?truckNo="+$(this).find("input[name='truckNoo']");
        //     });
        // })



        $(function(){

//auto complete
            // $('input[name="searchKeyword"]').keyup(function(){
            //     var searchKeyword = $(this).val();
            //     // var searchCondition = $('select[name="searchCondition"]').val();
            //
            //     $.ajax(
            //         {
            //             url: "/menu/rest/menuAutoComplete/" + searchKeyword,
            //             method: "GET",
            //             headers: {
            //                 "Accept": "application/json",
            //                 "Content-Type": "application/json"
            //             },
            //             dataType: "json",
            //             success: function (JSONData, status) {
            //                 var availableTags = JSONData;
            //                 console.log(JSONData);
            //                 $(function () {
            //                     $('input[name="searchKeyword"]').autocomplete({
            //                         source: availableTags
            //                     });
            //                 });
            //
            //             },
            //         });
            // });



            // $(document).on("click", "#updateMenuButton", function(){
            //
            //
            //     //var truckId = $("input[name='truckId']").val();
            //     alert("optionGroup개수 : " +$('input#optionGroupName.form-control').length);
            //
            //     if($('input#optionGroupName.form-control').length===0){
            //         $("form").attr("method", "POST").attr("action", "/menu/updateMenu").attr("enctype","multipart/form-data").submit();
            //     } else{
            //         console.log("fncUpdateMenu-target : "+$("form.form-horizontal").html());
            //
            //         $("form").attr("method", "POST").attr("action","/menu/updateMenuOptionGroup").submit();
            //         // $("form").post("/menu/addMenuOptionGroup", {}, "text")
            //
            //     }
            //
            // });

        });

        //============= "검색"  Event  처리 =============
        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $( "#search" ).on("click" , function() {
                // alert("wkdsks?");
                fncGetTruckList(1);
            });
        });

        //=============    검색 / page 두가지 경우 모두  Event  처리 =============
        function fncGetTruckList(currentPage) {
            // function fncGetTruckList(currentPage) {
            // var menu=$("input[name='menu']").val();
            //todo cate가 있을 때랑 없을 때 나눠서! sort도 마찬가지!!!

            $("#currentPage").val(currentPage)

            var cateCondition = $('input[name="cateCondition"]').val();


            if(cateCondition!=null && cateCondition!=""){
                $("form").attr("method", "POST").attr("action","/menu/getTruckListCate").submit();
            }else{
                $("form").attr("method", "POST").attr("action","/menu/getTruckList").submit();
            }
            



        // }
        };


    </script>
    <!--  ///////////////////////// JavaScript ////////////////////////// -->

    <style>
        input#inputLocation.form-control{
            width: 265px;
        }
    </style>

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=51615d81a030d0475e576eb41e443c14&libraries=services"></script>

    <script type="text/javascript">




        window.onload = function() {

            findLocation();
        };

        function findLocation() {

            navigator.geolocation.getCurrentPosition(success, error, options);

            var options = {
                enableHighAccuracy : true,
                timeout : 5000,
                maximumAge : 0
            };
            function success(pos) {
                var crd = pos.coords;
                console.log('위도 : ' + crd.latitude);
                console.log('경도: ' + crd.longitude);
                lat = crd.latitude;
                lon = crd.longitude;
                $.ajax({
                    url:"/menu/json/truckNearBy"/+crd.latitude+","+crd.longitude,
                    method:"get",
                    success:function(data){ //data : truckList
                        console.log(data);
                        window.location.replace("http://127.0.0.1:8080/menu/getTruckListLo?la="+crd.latitude+"&lo="+crd.longitude);
                    }
                })
                getAddr(lat,lon);

                //todo 이 안에 에이작스 써서 lo, la 받아온 후 페이지 리로드하도록?



            };

            function error(err) {
                console.warn('ERROR(' + err.code + '): ' + err.message);
            };

            function getAddr(lat,lng){
                let geocoder = new kakao.maps.services.Geocoder();

                let coord = new kakao.maps.LatLng(lat, lng);
                let callback = function(result, status) {
                    if (status === kakao.maps.services.Status.OK) {
                        // console.log(result[0].address.address_name);
                        console.log(result[0].address.address_name)
                        $("input[name='inputLocation']").val(result[0].address.address_name)
                    }
                }
                geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
            }

        }

        $(function (){
            $("a#endTruck").on("click",function(){
                alert("영업종료하였습니다.")
            })
        })





        /* 무한스크롤 */
        let isEnd = false; // 다 불러왔을 때 더이상 노출 되지 않기 위함
        var page=2;
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
            // var isBottom =  (window.innerHeight + window.scrollY) >= document.body.offsetHeight; // 바닥

            // 현재 카드 길이에서는 이게 제일 잘먹는다~~~
           // var isBottom =  scrollTop + windowHeight + 30 > documentHeight
            var isBottom =  (window.innerHeight + window.scrollY) >= document.body.offsetHeight; // 바닥
            //var isBottom = $(window).scrollTop()  == $(document).height() - $(window).height()

            if (isBottom) {
                if(isEnd===true || isEnd){
                    return;
                }
                isEnd = true; // 스크롤시 무한대로 함수 호출하는것을 막기 위함
                /* 마지막에 한 번 더 호출하는 현상이 있어서 수정 필요.. 그치만 무한대로 호출은 안하쟈나..?..헤헤..히..ㅠ.... */

                loadList();
            }
        })
        // loadList();




        var loadList = function(){
            /* if(isEnd === true){
                 return;
             }*/
    console.log("야야ㅑ")
            $.ajax({

                url : "/menu/json/getTruckList",
                method : "POST",
                dataType : "json",
                data : { currentPage : page
                },

                //contentType:"application/json;charset=UTF-8",
                contentType: "application/x-www-form-urlencoded;",
                success : function(jsonData) {

                    page++;
                    var list = jsonData.list;
                    console.log("list: "+list)
                    let length = list.length;

                    console.log("length: "+length)
                        for(var i=0; i<list.length; i++){
                            var div="";



                          div +=   "<div class='card col-md-4 mb-4' style='border: 0;'>"
                  +  "<div style='display: flex; flex-direction: column;'>"
                       +" <div class='item'>"
                           +" <div class='item-image'>";
                               if ( list[i].truckSigMenuImg1 != null){
                                   div += "<div class='card__background' style='background-image: url(../../resources/menu/"+list[i].truckSigMenuImg1+")'></div>";

                               }else{
                                   div += "<div class='card__background' style='background-image: url(../../resources/menu/"+list[i].truckProImg+")'></div>";
                               }
                            div += "</div>"
                           + "<div class='item-text'>"
                              + " <div class='item-text-wrapper'>";


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

                                   div +=  "<input type='hidden' name='truckId' value='"+list[i].truckId+"'>"
                                    +"<p class='item-text-dek'><strong>"+list[i].truckSigMenuName+"</strong></p>"
                                    +"<h6 class='item-text-title'>"+list[i].truckCEOIntro+"</h6>"

                                       +"<i class='fas fa-star' style='color: #ec6a56'></i>";
                                    // 여기 위에 바꿔야할 곳, 평점 처리  임의로 해줌

                                div += "</div>"
                           +" </div>";

                                if (list[i].truckBusiStatus == 0){
                                    div += "<a type='button' class='item-link' id='endTruck'></a>";
                                }else{
                                    div += "<a class='item-link' href='/menu/getMenuList?truckId="+list[i].truckId+"'></a>";
                                }


                       div += "</div>"
                        +"<div class='item-truck'>"
                            +"<span>"+list[i].truckName+"</span>";

                            if (list[i].truckBusiStatus == 0){
                                div += "<span class='badge' style='background-color: #ffba49; color: #110000'>영업종료</span>";
                            }else{
                                div += "<span class='badge' style='background-color: #fae100; color: #110000'>영업중</span>";
                            }

                        div += "</div></div></div>";


                            $('#truckListAutokk').append(div);
                        if( length < 6 ){
                            isEnd = true;
                            // return;
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
<!-- ToolBar End /////////////////////////////////////-->
<!--find location -->
<%--<div class="find_container ">
    <div class="container">
        <div class="row">
            <div class="col">
                <form>
                    <div class="form-row" style="margin-top: 70px;">
                        <div class="form-group col-lg-6">
                            <input type="text" class="form-control" id="inputLocation" name="inputLocation" placeholder="What's your address?">
&lt;%&ndash;                            <span class="location_icon">&ndash;%&gt;
&lt;%&ndash;                                                    <i class="fa fa-map-marker" aria-hidden="true"></i>&ndash;%&gt;
&lt;%&ndash;                                                  </span>&ndash;%&gt;
                        </div>
                    </div>
                    <div class="form-row"  style="margin-top: -15px;">
                        <div class="form-group col-md-4">
                            <div class="btn-box">
                                <button type="submit" class="btn ">Use current location</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>--%>

<!-- slider section -->

                        <div class="row">
                            <div class="col-md-6 col-md-offset-3 text-center">
                                <form class="form-inline" name="detailForm">
                                    <input type="hidden" name="sortCondition" value="${search.sortCondition}">
                                    <input type="hidden" name="cateCondition" value="${cateCondition}">
                                    <div class="form-row" style="margin-top: 70px;">
                                        <div class="form-group col-lg-6">
                                            <label class="sr-only" for="searchKeyword">검색어</label>
                                            <input type="text"
                                                   class="form-control"
                                                   id="searchKeyword"
                                                   name="searchKeyword"
                                                   placeholder="What are you waiting for? Hit it!"
                                                   value="${! empty search.searchKeyword ? search.searchKeyword : ''}">
                                            <button type="button" class="btn btn-warning" id="search">검색</button>
                                        </div>

                                        <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
                                        <input type="hidden" id="currentPage" name="currentPage" value=""/>
                                    </div>
                                </form>
                            </div>
                        </div>


<!-- end slider section -->
</div>

<!-- Example single danger button -->
<div class="dropdown">
    <button type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <c:if test="${search.sortCondition eq null}">
            기본 순
        </c:if>
        <c:if test="${search.sortCondition eq 'moreStars'}">
            별점 높은 순
        </c:if>
        <c:if test="${search.sortCondition eq 'lessStars'}">
            별점 낮은 순
        </c:if>

    </button>
    <ul class="dropdown-menu">
        <c:if test="${cateCondition eq null or cateCondition eq '0'}">
            <li><a class="dropdown-item" href="/menu/getTruckList">기본 순</a></li>
            <li><a class="dropdown-item" href="/menu/getTruckList?sortCondition=moreStars">별점 높은 순</a></li>
            <li><a class="dropdown-item" href="/menu/getTruckList?sortCondition=lessStars">별점 낮은 순</a></li>
        </c:if>
        <c:if test="${cateCondition ne null and cateCondition eq '1'}">
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=1">기본 순</a></li>
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=1&sortCondition=moreStars">별점 높은 순</a></li>
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=1&sortCondition=lessStars">별점 낮은 순</a></li>
        </c:if>
        <c:if test="${cateCondition ne null and cateCondition eq '2'}">
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=2">기본 순</a></li>
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=2&sortCondition=moreStars">별점 높은 순</a></li>
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=2&sortCondition=lessStars">별점 낮은 순</a></li>
        </c:if>
        <c:if test="${cateCondition ne null and cateCondition eq '3'}">
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=3">기본 순</a></li>
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=3&sortCondition=moreStars">별점 높은 순</a></li>
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=3&sortCondition=lessStars">별점 낮은 순</a></li>
        </c:if>
        <c:if test="${cateCondition ne null and cateCondition eq '4'}">
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=4">기본 순</a></li>
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=4&sortCondition=moreStars">별점 높은 순</a></li>
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=4&sortCondition=lessStars">별점 낮은 순</a></li>
        </c:if>
        <c:if test="${cateCondition ne null and cateCondition eq '5'}">
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=5">기본 순</a></li>
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=5&sortCondition=moreStars">별점 높은 순</a></li>
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=5&sortCondition=lessStars">별점 낮은 순</a></li>
        </c:if>
        <c:if test="${cateCondition ne null and cateCondition eq '6'}">
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=6">기본 순</a></li>
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=6&sortCondition=moreStars">별점 높은 순</a></li>
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=6&sortCondition=lessStars">별점 낮은 순</a></li>
        </c:if>
        <c:if test="${cateCondition ne null and cateCondition eq '7'}">
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=7">기본 순</a></li>
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=7&sortCondition=moreStars">별점 높은 순</a></li>
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=7&sortCondition=lessStars">별점 낮은 순</a></li>
        </c:if>
        <c:if test="${cateCondition ne null and cateCondition eq '8'}">
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=8">기본 순</a></li>
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=8&sortCondition=moreStars">별점 높은 순</a></li>
            <li><a class="dropdown-item" href="/menu/getTruckListCate?cateCondition=8&sortCondition=lessStars">별점 낮은 순</a></li>
        </c:if>
<%--        <li><a class="dropdown-item" href="/menu/getTruckList">기본 순</a></li>--%>
<%--        <li><a class="dropdown-item" href="/menu/getTruckList?sortCondition=moreStars">별점 높은 순</a></li>--%>
<%--        <li><a class="dropdown-item" href="/menu/getTruckList?sortCondition=lessStars">별점 낮은 순</a></li>--%>
    </ul>
</div>

<div class="help">
<!-- Tab 영역 태그는 ul이고 클래스는 nav와 nav-tabs를 설정한다. -->
    <div class="container">
<div class="btn-group">
    <!-- Tab 아이템이다. 태그는 li과 li > a이다. li태그에 active는 현재 선택되어 있는 탭 메뉴이다. -->
    <!--노가다 말고 foreach로 새로운 시도!-->
    <!-- 전체보기일 때 버튼그룹 모양-->
    <c:if test="${cateCondition eq null or cateCondition eq '0'}">
        <a href="0" class="btn btn-warning active" data-load="true" data-url="http://127.0.0.1:8080/menu/getTruckList">전체보기</a>
        <!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->
        <a href="/menu/getTruckListCate?cateCondition=1" class="btn btn-outline-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=1">고기</a>
        <a href="/menu/getTruckListCate?cateCondition=2" class="btn btn-outline-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=2">분식</a>
        <a href="/menu/getTruckListCate?cateCondition=3" class="btn btn-outline-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=3">음료</a>
        <a href="/menu/getTruckListCate?cateCondition=4" class="btn btn-outline-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=4">양식</a>
        <a href="/menu/getTruckListCate?cateCondition=5" class="btn btn-outline-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=5">디저트</a>
        <a href="/menu/getTruckListCate?cateCondition=6" class="btn btn-outline-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=6">한식</a>
        <a href="/menu/getTruckListCate?cateCondition=7" class="btn btn-outline-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=7">일식</a>
        <a href="/menu/getTruckListCate?cateCondition=8" class="btn btn-outline-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=8">기타</a>
    </c:if>


    <c:set var="myCate" value="${fn:split('고기,분식,음료,양식,디저트,한식,일식,기타',',')}"/>
    <c:if test="${search.sortCondition eq null}">
        <c:forEach var="i" begin="1" end="8">
            <c:if test="${cateCondition ne null and cateCondition eq i}">
                <a href="/menu/getTruckList" class="btn btn-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckList" style="color:orange">전체보기</a>
                <!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->
                <c:forEach var="j" begin="1" end="8">
                    <c:if test="${i eq j}">
                        <a href="/menu/getTruckListCate?cateCondition=${j}" class="btn btn-outline-warning active" style="color:orange" data-load="true" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=${j}">${myCate[j-1]}</a>
                    </c:if>
                    <c:if test="${i ne j}">
                        <a href="/menu/getTruckListCate?cateCondition=${j}" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=${j}">${myCate[j-1]}</a>
                    </c:if>

                </c:forEach>

            </c:if>
        </c:forEach>
    </c:if>
    <c:if test="${search.sortCondition eq 'moreStars'}">
        <c:forEach var="i" begin="1" end="8">
            <c:if test="${cateCondition ne null and cateCondition eq i}">
                <a href="/menu/getTruckList" class="btn btn-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckList" style="color:orange">전체보기</a>
                <!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->
                <c:forEach var="j" begin="1" end="8">
                    <c:if test="${i eq j}">
                        <a href="/menu/getTruckListCate?cateCondition=${j}&sortCondition=moreStars" class="btn btn-outline-warning active" style="color:orange" data-load="true" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=${j}&sortCondition=moreStars">${myCate[j-1]}</a>
                    </c:if>
                    <c:if test="${i ne j}">
                        <a href="/menu/getTruckListCate?cateCondition=${j}&sortCondition=moreStars" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=${j}&sortCondition=moreStars">${myCate[j-1]}</a>
                    </c:if>

                </c:forEach>

            </c:if>
        </c:forEach>
    </c:if>
    <c:if test="${search.sortCondition eq 'lessStars'}">
        <c:forEach var="i" begin="1" end="8">
            <c:if test="${cateCondition ne null and cateCondition eq i}">
                <a href="/menu/getTruckList" class="btn btn-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckList" style="color:orange">전체보기</a>
                <!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->
                <c:forEach var="j" begin="1" end="8">
                    <c:if test="${i eq j}">
                        <a href="/menu/getTruckListCate?cateCondition=${j}&sortCondition=lessStars" class="btn btn-outline-warning active" style="color:orange" data-load="true" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=${j}&sortCondition=lessStars">${myCate[j-1]}</a>
                    </c:if>
                    <c:if test="${i ne j}">
                        <a href="/menu/getTruckListCate?cateCondition=${j}&sortCondition=lessStars" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=${j}&sortCondition=lessStars">${myCate[j-1]}</a>
                    </c:if>

                </c:forEach>

            </c:if>
        </c:forEach>
    </c:if>


    <!--노가다 말고 foreach로 새로운 시도! 끝-->

<%--    <!-- 전체보기일 때 버튼그룹 모양-->--%>
<%--    <c:if test="${cateCondition eq null or cateCondition eq '0'}">--%>
<%--        <a href="0" class="btn btn-warning active" data-load="true" data-url="http://127.0.0.1:8080/menu/getTruckList">전체보기</a>--%>
<%--        <!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->--%>
<%--        <a href="/menu/getTruckListCate?cateCondition=1" class="btn btn-outline-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=1">고기</a>--%>
<%--        <a href="/menu/getTruckListCate?cateCondition=2" class="btn btn-outline-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=2">분식</a>--%>
<%--        <a href="/menu/getTruckListCate?cateCondition=3" class="btn btn-outline-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=3">음료</a>--%>
<%--        <a href="/menu/getTruckListCate?cateCondition=4" class="btn btn-outline-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=4">양식</a>--%>
<%--        <a href="/menu/getTruckListCate?cateCondition=5" class="btn btn-outline-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=5">디저트</a>--%>
<%--        <a href="/menu/getTruckListCate?cateCondition=6" class="btn btn-outline-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=6">한식</a>--%>
<%--        <a href="/menu/getTruckListCate?cateCondition=7" class="btn btn-outline-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=7">일식</a>--%>
<%--        <a href="/menu/getTruckListCate?cateCondition=8" class="btn btn-outline-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=8">기타</a>--%>
<%--    </c:if>--%>
<%--    <!-- 고기일 때 버튼그룹 모양-->--%>
<%--    <c:if test="${cateCondition ne null}">--%>
<%--        <c:if test="${cateCondition eq '1'}">--%>
<%--            <a href="/menu/getTruckList" class="btn btn-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckList" style="color:orange">전체보기</a>--%>
<%--            <!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=1" class="btn btn-outline-warning active" style="color:orange" data-load="true" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=1">고기</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=2" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=2">분식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=3" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=3">음료</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=4" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=4">양식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=5" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=5">디저트</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=6" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=6">한식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=7" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=7">일식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=8" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=8">기타</a>--%>
<%--        </c:if>--%>
<%--    </c:if>--%>
<%--    <!-- 분식일 때 버튼그룹 모양-->--%>
<%--    <c:if test="${cateCondition ne null}">--%>
<%--        <c:if test="${cateCondition eq '2'}">--%>
<%--            <a href="/menu/getTruckList" class="btn btn-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckList" style="color:orange">전체보기</a>--%>
<%--            <!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=1" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=1">고기</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=2" class="btn btn-outline-warning active" style="color:orange" data-load="true" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=2">분식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=3" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=3">음료</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=4" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=4">양식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=5" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=5">디저트</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=6" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=6">한식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=7" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=7">일식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=8" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=8">기타</a>--%>
<%--        </c:if>--%>
<%--    </c:if>--%>
<%--    <!-- 음료일 때 버튼그룹 모양-->--%>
<%--    <c:if test="${cateCondition ne null}">--%>
<%--        <c:if test="${cateCondition eq '3'}">--%>
<%--            <a href="/menu/getTruckList" class="btn btn-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckList" style="color:orange">전체보기</a>--%>
<%--            <!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=1" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=1">고기</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=2" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=2">분식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=3" class="btn btn-outline-warning active" style="color:orange" data-load="true" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=3">음료</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=4" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=4">양식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=5" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=5">디저트</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=6" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=6">한식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=7" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=7">일식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=8" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=8">기타</a>--%>
<%--        </c:if>--%>
<%--    </c:if>--%>
<%--    <!-- 양식일 때 버튼그룹 모양-->--%>
<%--    <c:if test="${cateCondition ne null}">--%>
<%--        <c:if test="${cateCondition eq '4'}">--%>
<%--            <a href="/menu/getTruckList" class="btn btn-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckList" style="color:orange">전체보기</a>--%>
<%--            <!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=1" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=1">고기</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=2" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=2">분식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=3" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=3">음료</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=4" class="btn btn-outline-warning active" style="color:orange" data-load="true" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=4">양식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=5" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=5">디저트</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=6" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=6">한식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=7" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=7">일식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=8" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=8">기타</a>--%>
<%--        </c:if>--%>
<%--    </c:if>--%>
<%--    <!-- 디저트일 때 버튼그룹 모양-->--%>
<%--    <c:if test="${cateCondition ne null}">--%>
<%--        <c:if test="${cateCondition eq '5'}">--%>
<%--            <a href="/menu/getTruckList" class="btn btn-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckList" style="color:orange">전체보기</a>--%>
<%--            <!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=1" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=1">고기</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=2" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=2">분식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=3" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=3">음료</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=4" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=4">양식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=5" class="btn btn-outline-warning active" style="color:orange" data-load="true" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=5">디저트</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=6" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=6">한식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=7" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=7">일식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=8" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=8">기타</a>--%>
<%--        </c:if>--%>
<%--    </c:if>--%>
<%--    <!-- 한식일 때 버튼그룹 모양-->--%>
<%--    <c:if test="${cateCondition ne null}">--%>
<%--        <c:if test="${cateCondition eq '6'}">--%>
<%--            <a href="/menu/getTruckList" class="btn btn-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckList" style="color:orange">전체보기</a>--%>
<%--            <!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=1" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=1">고기</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=2" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=2">분식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=3" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=3">음료</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=4" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=4">양식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=5" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=5">디저트</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=6" class="btn btn-outline-warning active" style="color:orange" data-load="true" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=6">한식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=7" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=7">일식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=8" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=8">기타</a>--%>
<%--        </c:if>--%>
<%--    </c:if>--%>
<%--    <!-- 일식일 때 버튼그룹 모양-->--%>
<%--    <c:if test="${cateCondition ne null}">--%>
<%--        <c:if test="${cateCondition eq '7'}">--%>
<%--            <a href="/menu/getTruckList" class="btn btn-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckList" style="color:orange">전체보기</a>--%>
<%--            <!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=1" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=1">고기</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=2" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=2">분식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=3" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=3">음료</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=4" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=4">양식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=5" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=5">디저트</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=6" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=6">한식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=7" class="btn btn-outline-warning active" style="color:orange" data-load="true" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=7">일식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=8" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=8">기타</a>--%>
<%--        </c:if>--%>
<%--    </c:if>--%>
<%--    <!-- 기타일 때 버튼그룹 모양-->--%>
<%--    <c:if test="${cateCondition ne null}">--%>
<%--        <c:if test="${cateCondition eq '8'}">--%>
<%--            <a href="/menu/getTruckList" class="btn btn-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckList" style="color:orange">전체보기</a>--%>
<%--            <!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=1" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=1">고기</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=2" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=2">분식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=3" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=3">음료</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=4" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=4">양식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=5" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=5">디저트</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=6" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=6">한식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=7" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=7">일식</a>--%>
<%--            <a href="/menu/getTruckListCate?cateCondition=8" class="btn btn-outline-warning active" style="color:orange" data-load="true" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=8">기타</a>--%>
<%--        </c:if>--%>
<%--    </c:if>--%>

</div>

</div>
<p></p>



    <section class="hero-section">
<%--        <div class="card-grid">--%>
<%--            <c:set var="i" value="0"/>--%>
<%--            <c:forEach var="truck" items="${list}" varStatus="status">--%>
<%--                <c:set var="i" value="${i+1}"/>--%>

<%--                <a class="card" href="getMenuList?truckId=${truck.truckId}">--%>
<%--                    <c:if test="${truck.truckSigMenuImg1 ne null}">--%>
<%--                        <div class="card__background" style="background-image: url(../../resources/menu/${truck.truckSigMenuImg1})"></div>--%>
<%--                    </c:if>--%>
<%--                    <c:if test="${truck.truckSigMenuImg1 eq null}">--%>
<%--                        <div class="card__background" style="background-image: url(../../resources/image/${truck.truckProImg})"></div>--%>
<%--                    </c:if>--%>


<%--                    <div class="card__content">--%>
<%--                        <p class="card__category"> ${truck.truckCate}</p>--%>
<%--                        <input type="hidden" name="truckId" value="${truck.truckId}">--%>

<%--                            <h3 class="card__heading">${truck.truckName}</h3>--%>



<%--                    </div>--%>
<%--                </a>--%>



<%--                &lt;%&ndash;--%>
<%--                 <div class="card" style="width: 23rem; margin-bottom:15px; margin-left: 10px;">--%>
<%--                     <img class="card-img-top" src="../../resources/menu/${catering.ctMenu.menuImg1}" alt="Card image cap"--%>
<%--                          style="border-bottom: 1px solid #eee; height: 300px;">--%>
<%--                     <div class="card-body">--%>
<%--                         <ul class='card-body-ul'>--%>

<%--                             <c:if test="${sessionScope.role eq 'user'}">--%>
<%--                             <li> 푸드트럭 상호명 :${catering.ctTruck.truckName}</li>--%>
<%--                             </c:if>--%>
<%--                             <c:if test="${sessionScope.role eq 'truck'}">--%>
<%--                                 <li> 이용자 이름 :${catering.ctUser.userName}</li>--%>
<%--                             </c:if>--%>
<%--                             <li> 서비스 날짜 : ${catering.ctDate}</li>--%>
<%--                             <li> 견적 : ${catering.ctQuotation}</li>--%>
<%--                             <li> 상태코드 :--%>
<%--                             <c:if test="${catering.ctStatusCode eq '0'}">예약가능</c:if>--%>
<%--                             <c:if test="${catering.ctStatusCode eq '1'}">수락 대기</c:if>--%>
<%--                             <c:if test="${catering.ctStatusCode eq '2'}">이용자 취소</c:if>--%>
<%--                             <c:if test="${catering.ctStatusCode eq '3'}">사업자 거절</c:if>--%>
<%--                             <c:if test="${catering.ctStatusCode eq '4'}">결제 대기</c:if>--%>
<%--                             <c:if test="${catering.ctStatusCode eq '5'}">예약 완료</c:if>--%>
<%--                             </li>--%>
<%--                         </ul>--%>
<%--                         <div class="btn-detail">--%>
<%--                             <input type="hidden" id="ctNo${catering.ctNo}" name="ctNo" value="${catering.ctNo}"/>--%>
<%--                             <input type="hidden" id="ctStatusCode${catering.ctNo}" name="ctct" value="${catering.ctStatusCode}"/>--%>
<%--                             <c:if test="${catering.ctStatusCode eq '0'}">--%>

<%--                                 <button  name="getCateringDetail" class="button is-warning is-light" style='margin-left: 100px; margin-bottom: 13px; height: 25px'>자세히--%>
<%--                                 </button>--%>
<%--                                 &lt;%&ndash;onclick="getCateringDetail(${catering.ctNo})&ndash;%&gt;--%>
<%--                             </c:if>--%>
<%--                             <c:if test="${catering.ctStatusCode ne '0'}">--%>


<%--                                 <button  name="getResDetail" class="button is-warning is-light" style='margin-left: 100px; margin-bottom: 13px; height: 25px' >자세히--%>
<%--                                 </button>--%>
<%--                                 &lt;%&ndash;onclick="getResDetail(${catering.ctNo},${catering.ctStatusCode})"&ndash;%&gt;--%>
<%--                             </c:if>--%>
<%--                         </div>--%>
<%--                     </div>--%>
<%--                 </div>&ndash;%&gt;--%>
<%--            </c:forEach>--%>
<%--        </div>--%>

        <!--admin truck에서 빼오기-->

        <div id="truckListAutokk" class="row mb-12" style="border: 0;">

            <c:set var="i" value="0" />
            <c:forEach var="truck" items="${list}" varStatus="status">
                <c:set var="i" value="${ i+1 }" />

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
                                    <input type="hidden" name="truckId" value="${truck.truckId}">
                                    <p class="item-text-dek"><strong>${truck.truckSigMenuName}</strong></p>
                                    <h6 class="item-text-title">${truck.truckCEOIntro}</h6>

                                    <fmt:parseNumber var="percent" value="${truck.truckAVGStar}" integerOnly="true" />
                                    <c:if test="${percent eq 0}">
                                        <i class="far fa-star" style="color: #ec6a56"></i>
                                    </c:if>
                                    <c:if test="${percent eq 1}">
                                        <i class="fas fa-star" style="color: #ec6a56"></i>
                                    </c:if>
                                    <c:if test="${percent eq 2}">
                                        <i class="fas fa-star" style="color: #ec6a56"></i>
                                        <i class="fas fa-star" style="color: #ec6a56"></i>
                                    </c:if>
                                    <c:if test="${percent eq 3}">
                                        <i class="fas fa-star" style="color: #ec6a56"></i>
                                        <i class="fas fa-star" style="color: #ec6a56"></i>
                                        <i class="fas fa-star" style="color: #ec6a56"></i>
                                    </c:if>
                                    <c:if test="${percent eq 4}">
                                        <i class="fas fa-star" style="color: #ec6a56"></i>
                                        <i class="fas fa-star" style="color: #ec6a56"></i>
                                        <i class="fas fa-star" style="color: #ec6a56"></i>
                                        <i class="fas fa-star" style="color: #ec6a56"></i>
                                    </c:if>
                                    <c:if test="${percent eq 5}">
                                        <i class="fas fa-star" style="color: #ec6a56"></i>
                                        <i class="fas fa-star" style="color: #ec6a56"></i>
                                        <i class="fas fa-star" style="color: #ec6a56"></i>
                                        <i class="fas fa-star" style="color: #ec6a56"></i>
                                        <i class="fas fa-star" style="color: #ec6a56"></i>
                                    </c:if>

                                </div>
                            </div>
                            <c:if test="${truck.truckBusiStatus eq 0}">
                                <a type="button" class="item-link" id="endTruck"></a>
                            </c:if>
                            <c:if test="${truck.truckBusiStatus eq 1}">
                                <a class="item-link" href="/menu/getMenuList?truckId=${truck.truckId}"></a>
                            </c:if>

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
                </div>
            </c:forEach>

        </div>
        <!--admin truck에서 빼오기-->
    </section>
</div>

<%--<jsp:include page="/views/footer.jsp" />--%>
</body>
<script src="../resources/bootstrap/js/custom.js"></script>


<!--트럭 admin 빼오기-->
<style>

    /*.search{*/
    /*    margin-top: 100px;*/
    /*}*/
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
        width: 100%;
        height: auto;
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
        justify-content: space-between;
        margin-top: 5px;
        padding: 5px;
    }
    .item-truck span {
        display: flex;
        align-items: center;
    }


</style>


</html>



