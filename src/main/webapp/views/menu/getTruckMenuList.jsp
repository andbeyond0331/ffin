
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
<head>

    <title>트럭 목록</title>
    <jsp:include page="../../common/lib.jsp"/>

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
            border-radius: 5px;
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
            border-radius: 45px;
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
            $( "button.btn.btn-warning" ).on("click" , function() {
                alert("wkdsks?");
                fncGetTruckList(1);
            });
        });

        //=============    검색 / page 두가지 경우 모두  Event  처리 =============
        function fncGetTruckList(currentPage) {
            // function fncGetTruckList(currentPage) {
            // var menu=$("input[name='menu']").val();

            $("#currentPage").val(currentPage)

                $("form").attr("method", "POST").attr("action","/menu/getTruckList").submit();


        // }
        };


    </script>
    <!--  ///////////////////////// JavaScript ////////////////////////// -->

    <style>
        input#inputLocation.form-control{
            width: 100px;
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

                getAddr(lat,lon);

                //todo 이 안에 에이작스 써서 lo, la 받아온 후 페이지 리로드하도록?
                // $.ajax({
                //     url:"/menu/json/truckNearBy"/+crd.latitude+","+crd.longitude,
                //     method:"get",
                //     success:function(data){ //data : truckList
                //
                //     }
                // })

                self.location="/menu/truckNearBy?la="+crd.latitude+"&&lo="+crd.longitude;




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


    </script>

</head>

<body>

<!-- ToolBar Start /////////////////////////////////////-->
<jsp:include page="/views/navbar.jsp" />
<!-- ToolBar End /////////////////////////////////////-->
<!--find location -->
<div class="find_container ">
    <div class="container">
        <div class="row">
            <div class="col">
                <form>
                    <div class="form-row" style="margin-top: 70px;">
                        <div class="form-group col-lg-6">
                            <input type="text" class="form-control" id="inputLocation" name="inputLocation" placeholder="What's your address?">
                            <span class="location_icon">
                                                    <i class="fa fa-map-marker" aria-hidden="true"></i>
                                                  </span>
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
</div>

<!-- slider section -->

                        <div class="row">
                            <div class="col-md-6 col-md-offset-3 text-center">
                                <form class="form-inline" name="detailForm">
                                    <div class="form-row" style="margin-top: 70px;">
                                        <div class="form-group col-lg-6">
                                            <label class="sr-only" for="searchKeyword">검색어</label>
                                            <input type="text"
                                                   class="form-control"
                                                   id="searchKeyword"
                                                   name="searchKeyword"
                                                   placeholder="What are you waiting for? Hit it!"
                                                   value="${! empty search.searchKeyword ? search.searchKeyword : ''}">
                                            <button type="button" class="btn btn-warning">검색</button>
                                        </div>

                                        <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
                                        <input type="hidden" id="currentPage" name="currentPage" value=""/>
                                    </div>
                                </form>
                            </div>
                        </div>


<!-- end slider section -->
</div>


<!-- Tab 영역 태그는 ul이고 클래스는 nav와 nav-tabs를 설정한다. -->
<div class="btn-group">
    <!-- Tab 아이템이다. 태그는 li과 li > a이다. li태그에 active는 현재 선택되어 있는 탭 메뉴이다. -->
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
    <!-- 고기일 때 버튼그룹 모양-->
    <c:if test="${cateCondition ne null}">
        <c:if test="${cateCondition eq '1'}">
            <a href="/menu/getTruckList" class="btn btn-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckList" style="color:orange">전체보기</a>
            <!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->
            <a href="/menu/getTruckListCate?cateCondition=1" class="btn btn-outline-warning active" style="color:orange" data-load="true" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=1">고기</a>
            <a href="/menu/getTruckListCate?cateCondition=2" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=2">분식</a>
            <a href="/menu/getTruckListCate?cateCondition=3" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=3">음료</a>
            <a href="/menu/getTruckListCate?cateCondition=4" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=4">양식</a>
            <a href="/menu/getTruckListCate?cateCondition=5" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=5">디저트</a>
            <a href="/menu/getTruckListCate?cateCondition=6" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=6">한식</a>
            <a href="/menu/getTruckListCate?cateCondition=7" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=7">일식</a>
            <a href="/menu/getTruckListCate?cateCondition=8" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=8">기타</a>
        </c:if>
    </c:if>
    <!-- 분식일 때 버튼그룹 모양-->
    <c:if test="${cateCondition ne null}">
        <c:if test="${cateCondition eq '2'}">
            <a href="/menu/getTruckList" class="btn btn-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckList" style="color:orange">전체보기</a>
            <!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->
            <a href="/menu/getTruckListCate?cateCondition=1" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=1">고기</a>
            <a href="/menu/getTruckListCate?cateCondition=2" class="btn btn-outline-warning active" style="color:orange" data-load="true" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=2">분식</a>
            <a href="/menu/getTruckListCate?cateCondition=3" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=3">음료</a>
            <a href="/menu/getTruckListCate?cateCondition=4" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=4">양식</a>
            <a href="/menu/getTruckListCate?cateCondition=5" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=5">디저트</a>
            <a href="/menu/getTruckListCate?cateCondition=6" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=6">한식</a>
            <a href="/menu/getTruckListCate?cateCondition=7" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=7">일식</a>
            <a href="/menu/getTruckListCate?cateCondition=8" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=8">기타</a>
        </c:if>
    </c:if>
    <!-- 음료일 때 버튼그룹 모양-->
    <c:if test="${cateCondition ne null}">
        <c:if test="${cateCondition eq '3'}">
            <a href="0" class="btn btn-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckList" style="color:orange">전체보기</a>
            <!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->
            <a href="/getTruckListCate?cateCondition=1" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=1">고기</a>
            <a href="/getTruckListCate?cateCondition=2" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=2">분식</a>
            <a href="/getTruckListCate?cateCondition=3" class="btn btn-outline-warning active" style="color:orange" data-load="true" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=3">음료</a>
            <a href="/getTruckListCate?cateCondition=4" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=4">양식</a>
            <a href="/getTruckListCate?cateCondition=5" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=5">디저트</a>
            <a href="/getTruckListCate?cateCondition=6" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=6">한식</a>
            <a href="/getTruckListCate?cateCondition=7" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=7">일식</a>
            <a href="/getTruckListCate?cateCondition=8" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=8">기타</a>
        </c:if>
    </c:if>
    <!-- 양식일 때 버튼그룹 모양-->
    <c:if test="${cateCondition ne null}">
        <c:if test="${cateCondition eq '4'}">
            <a href="/menu/getTruckList" class="btn btn-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckList" style="color:orange">전체보기</a>
            <!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->
            <a href="/menu/getTruckListCate?cateCondition=1" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=1">고기</a>
            <a href="/menu/getTruckListCate?cateCondition=2" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=2">분식</a>
            <a href="/menu/getTruckListCate?cateCondition=3" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=3">음료</a>
            <a href="/menu/getTruckListCate?cateCondition=4" class="btn btn-outline-warning active" style="color:orange" data-load="true" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=4">양식</a>
            <a href="/menu/getTruckListCate?cateCondition=5" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=5">디저트</a>
            <a href="/menu/getTruckListCate?cateCondition=6" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=6">한식</a>
            <a href="/menu/getTruckListCate?cateCondition=7" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=7">일식</a>
            <a href="/menu/getTruckListCate?cateCondition=8" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=8">기타</a>
        </c:if>
    </c:if>
    <!-- 디저트일 때 버튼그룹 모양-->
    <c:if test="${cateCondition ne null}">
        <c:if test="${cateCondition eq '5'}">
            <a href="/menu/getTruckList" class="btn btn-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckList" style="color:orange">전체보기</a>
            <!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->
            <a href="/menu/getTruckListCate?cateCondition=1" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=1">고기</a>
            <a href="/menu/getTruckListCate?cateCondition=2" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=2">분식</a>
            <a href="/menu/getTruckListCate?cateCondition=3" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=3">음료</a>
            <a href="/menu/getTruckListCate?cateCondition=4" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=4">양식</a>
            <a href="/menu/getTruckListCate?cateCondition=5" class="btn btn-outline-warning active" style="color:orange" data-load="true" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=5">디저트</a>
            <a href="/menu/getTruckListCate?cateCondition=6" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=6">한식</a>
            <a href="/menu/getTruckListCate?cateCondition=7" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=7">일식</a>
            <a href="/menu/getTruckListCate?cateCondition=8" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=8">기타</a>
        </c:if>
    </c:if>
    <!-- 한식일 때 버튼그룹 모양-->
    <c:if test="${cateCondition ne null}">
        <c:if test="${cateCondition eq '6'}">
            <a href="/menu/getTruckList" class="btn btn-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckList" style="color:orange">전체보기</a>
            <!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->
            <a href="/menu/getTruckListCate?cateCondition=1" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=1">고기</a>
            <a href="/menu/getTruckListCate?cateCondition=2" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=2">분식</a>
            <a href="/menu/getTruckListCate?cateCondition=3" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=3">음료</a>
            <a href="/menu/getTruckListCate?cateCondition=4" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=4">양식</a>
            <a href="/menu/getTruckListCate?cateCondition=5" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=5">디저트</a>
            <a href="/menu/getTruckListCate?cateCondition=6" class="btn btn-outline-warning active" style="color:orange" data-load="true" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=6">한식</a>
            <a href="/menu/getTruckListCate?cateCondition=7" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=7">일식</a>
            <a href="/menu/getTruckListCate?cateCondition=8" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=8">기타</a>
        </c:if>
    </c:if>
    <!-- 일식일 때 버튼그룹 모양-->
    <c:if test="${cateCondition ne null}">
        <c:if test="${cateCondition eq '7'}">
            <a href="/menu/getTruckList" class="btn btn-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckList" style="color:orange">전체보기</a>
            <!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->
            <a href="/menu/getTruckListCate?cateCondition=1" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=1">고기</a>
            <a href="/menu/getTruckListCate?cateCondition=2" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=2">분식</a>
            <a href="/menu/getTruckListCate?cateCondition=3" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=3">음료</a>
            <a href="/menu/getTruckListCate?cateCondition=4" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=4">양식</a>
            <a href="/menu/getTruckListCate?cateCondition=5" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=5">디저트</a>
            <a href="/menu/getTruckListCate?cateCondition=6" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=6">한식</a>
            <a href="/menu/getTruckListCate?cateCondition=7" class="btn btn-outline-warning active" style="color:orange" data-load="true" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=7">일식</a>
            <a href="/menu/getTruckListCate?cateCondition=8" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=8">기타</a>
        </c:if>
    </c:if>
    <!-- 기타일 때 버튼그룹 모양-->
    <c:if test="${cateCondition ne null}">
        <c:if test="${cateCondition eq '8'}">
            <a href="/menu/getTruckList" class="btn btn-warning" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckList" style="color:orange">전체보기</a>
            <!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->
            <a href="/menu/getTruckListCate?cateCondition=1" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=1">고기</a>
            <a href="/menu/getTruckListCate?cateCondition=2" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=2">분식</a>
            <a href="/menu/getTruckListCate?cateCondition=3" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=3">음료</a>
            <a href="/menu/getTruckListCate?cateCondition=4" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=4">양식</a>
            <a href="/menu/getTruckListCate?cateCondition=5" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=5">디저트</a>
            <a href="/menu/getTruckListCate?cateCondition=6" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=6">한식</a>
            <a href="/menu/getTruckListCate?cateCondition=7" class="btn btn-outline-warning" style="color:orange" data-load="false" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=7">일식</a>
            <a href="/menu/getTruckListCate?cateCondition=8" class="btn btn-outline-warning active" style="color:orange" data-load="true" data-url="http://127.0.0.1:8080/menu/getTruckListCate?cateCondition=8">기타</a>
        </c:if>
    </c:if>

</div>



<section class="main-content">
    <div class="container">
<%--        <h1 class="text-center text-uppercase">Food Order Card</h1>--%>

        <div class="row">
            <c:set var="i" value="0"/>
            <c:forEach var="truck" items="${list}" varStatus="status">
                <c:set var="i" value="${i+1}"/>
                <div class="col-sm-6 col-md-6 col-lg-4">
                    <div class="food-card">
                        <div class="food-card_img">
                            <c:if test="${truck.truckSigMenuImg1 eq null}">
                                <img src="/resources/image/${truck.truckProImg}" alt="">
                            </c:if>
                            <c:if test="${truck.truckSigMenuImg1 ne null}">

                                <img src="/resources/menu/${truck.truckSigMenuImg1}" alt="">
                            </c:if>
<%--                            <img src="https://i.imgur.com/eFWRUuR.jpg" alt="">--%>
                            <a href="#!"><i class="far fa-heart"></i></a>
                        </div>
                        <div class="food-card_content">
                            <div class="food-card_title-section">
                                <a href="getMenuList?truckId=${truck.truckId}" class="food-card_title">${truck.truckName}</a>
<%--                                <input type="hidden" name="truckNoo" value="${truck.truckNo}">--%>
                                <input type="hidden" name="truckId" value="${truck.truckId}">
                                <a href="#!" class="food-card_author">${truck.truckCate} </a>
                            </div>
                            <div class="food-card_bottom-section">
                                <div class="space-between">
                                    <div>
<%--                                        <span class="fa fa-fire"></span>${list2[status.index].menuName}--%>
                                        <span class="fa fa-fire"></span>${truck.truckSigMenuName}
                                    </div>
                                    <div class="pull-right">
                                        <span class="badge badge-success">Veg</span>
                                    </div>
                                </div>
                                <hr>
                                <div class="space-between">
                                    <div class="food-card_price">
<%--                                        <span>${list2[status.index].menuPrice}</span>--%>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>


        </div>
    </div>
</section>


<%--<jsp:include page="/views/footer.jsp" />--%>
</body>
<script src="../resources/bootstrap/js/custom.js"></script>


</html>



