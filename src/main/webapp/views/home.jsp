<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>

<html lang="ko">

<head>

    <title>F.FIN | FOODTRUCK FINDER</title>

    <jsp:include page="../common/lib.jsp"/>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">

<style>
    .box-img{
        width:330px;
        height:270px;
    }
    .label {margin-bottom: 105px;}
    .label * {display: inline-block;vertical-align: top;}
    .label .left {background: url("https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_l.png") no-repeat;display: inline-block;height: 24px;overflow: hidden;vertical-align: top;width: 7px;}
    .label .center {background: url(https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_bg.png) repeat-x;display: inline-block;height: 24px;font-size: 12px;line-height: 24px;}
    .label .right {background: url("https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_r.png") -1px 0  no-repeat;display: inline-block;height: 24px;overflow: hidden;width: 6px;}

</style>

    <script type="text/javascript">

        function loginModal(){
            $('#openLoginModal').modal('show');
        }

    </script>

    <script type="text/javascript">

     //todo : truck은 쿠폰 못누르게 해야함~

        // $(function(){
        //     alert("'#call': " +$('#call').html());
        //     $('#call').on('click', function(){
        //         self.location = "/menu/getMenu?menuNo=1";
        //     });
        // });

        // $(function(){
        //     alert($("input[name='toMenu']").html());
        //     $("body").on("click", "input[name='toMenu']", function() {
        //         // location.replace("http://127.0.0.1:8080/menu/getMenu?menuNo=1")
        //         self.location="/menu/getMenu?menuNo=1";
        //     });
        // });

        // function fncGetMenuOptionGroupYap(){
        //     location.replace('http://127.0.0.1:8080/menu/getMenu?menuNo=1');
        // };



    </script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=51615d81a030d0475e576eb41e443c14&libraries=services"></script>



</head>

<body id="page-top">




<div class="hero_area">

    <!-- toolbar -->
    <jsp:include page="/views/navbar.jsp" />

    <!-- slider section -->
    <section class="slider_section">
        <div class="container ">
            <div class="row">
                <div class="col-lg-10 mx-auto">
                    <div class="detail-box" style="margin-bottom: -40px;">
                        <h1 class="display-1 fs-md-5 fs-lg-6 fs-xl-8 text-light" style=" font-family: 'Pacifico', cursive; margin-top:100px; margin-bottom: 0; color: #110000">
                            FoodTruck Finder
                        </h1>
                        <h6 class="text-800 mb-5 fs-4">Within a few clicks, find foodtruck are accessible near you</h6>
                    </div>
                    <div class="find_container ">
                        <div class="container">
                            <div class="row">
                                <div class="col">
                                    <form>
                                        <div class="form-row">
                                            <div class="form-group col-lg-6">
                                                <input type="text" class="form-control" id="inputLocation" name="inputLocation" placeholder="What's your address?" value="${inputLocation}">
                                                <span class="location_icon">
                                                    <i class="fa fa-map-marker" aria-hidden="true"></i>
                                                  </span>
                                            </div>
                                        </div>
                                        <div class="form-row"  style="margin-top: -15px;">
                                            <div class="form-group col-md-4">
                                                <div class="btn-box">
                                                    <button type="button" class="btn current-location">Use current location</button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="slider_container">
            <c:forEach var="truck" items="${list}">
            <div class="item">
                <div class="img-box img-truck-box">
                    <img src="../resources/image/${truck.truckProImg}" alt="" />
                    <input type="hidden" name="truckId" value="${truck.truckId}"/>
                </div>
            </div>
            </c:forEach>
        </div>
    </section>
    <!-- end slider section -->
</div>

<form>
    <input type="hidden" name="la" />
    <input type="hidden" name="lo" />
    <input type="hidden" name="address" />
</form>

<!-- Popular Foodtruck section -->

<section class="recipe_section layout_padding-top">
    <div class="container">
        <div class="heading_container heading_center">
            <h2 style=" font-family: 'Pacifico', cursive;">
                Popular Foodtruck
            </h2>
        </div>
        <div class="row menu-container">

            <%--todo: 송화 헬프 섀도우 필요 아니 내가 찾아볼게 그치만 --%>

            <c:forEach var="truck" items="${list}" end="5">
            <div class="col-sm-6 col-md-4 mx-auto">
                <div class="box">
                    <div class="img-box img-menu-box">
                        <a idx="${truck.truckSigMenuNo}" class = "menu-location" href="/menu/getMenuList?truckId=${truck.truckId}">
                        <img src="../resources/menu/${truck.truckSigMenuImg1}" class="box-img" alt="" />
                            <input type="hidden" id="goTruckArrow" value="${truck.truckId}">
                        </a>
                    </div>
                    <div class="detail-box">
                        <c:if test="${truck.truckBusiStatus == '0'}">
                        <span class="badge" style="background-color: #fae100; color: #110000">영업종료</span>
                        </c:if>
                        <c:if test="${truck.truckBusiStatus == '1'}">
                            <span class="badge" style="background-color: #fae100; color: #110000">영업중</span>
                        </c:if>
                        <h5> ${truck.truckSigMenuName} </h5>
                        <div>
                            <span class="text-warning me-2">
                            <a style="background-color: #ffffff;" la="${truck.truckMapLa}" lo="${truck.truckMapLo}" href="#" class="truckMapFind" td="${truck.truckId}" nm="${truck.truckName}" im="${truck.truckSigMenuImg1}"><i class="fas fa-map-marker-alt"></i></a>
                            </span>
                            <span class="text-primary">${truck.truckName}</span>
                        </div>
                        <br/>
                    </div>
                </div>
            </div>
            </c:forEach>
        </div>
        <div class="btn-box">
            <a href="http://localhost:8080/menu/getTruckList">
                more FoodTruck
            </a>
        </div>
    </div>
</section>
<!-- end Popular Foodtruck section -->


<!-- coupon section -->
<section id = "couponSection" class="about_section layout_padding" >
    <div class="container">
        <div class="col-md-11 col-lg-10 mx-auto">
            <div class="heading_container heading_center">
                <h2 style=" font-family: 'Pacifico', cursive;">
                    Coupon
                </h2>
            </div>
            <div class="box">
                <div class="col-md-7 mx-auto">
                    <div class="img-box">
                        <img src="../resources/bootstrap/images/weather01.png" class="box-img" alt="">
                    </div>
                </div>
                <div class="detail-box">
                    <p></p>
                </div>
                <div class="btn-box">
                    <a href="/views/purchase/getCouponList.jsp">
                        coupon
                    </a>
                </div>
            </div>
        </div>

    </div>
</section>

<!-- end coupon section -->

<!-- end select start-->

<section class="about_section layout_padding">
    <div class="container">
        <div class="col-md-11 col-lg-10 mx-auto">
            <div class="heading_container heading_center">
                <h2 style=" font-family: 'Pacifico', cursive;">
                    Let's do it together
                </h2>
            </div>
            <div class="box">
                <div class="col-md-7 mx-auto">
                    <div class="img-box">
                        <img src="../resources/bootstrap/images/handshake.png" class="box-img" alt="">
                    </div>
                </div>
                <div class="detail-box">
                    <p>Grow with F.FIN! <br/> Our technology and user base can help you boost sales and unlock new opportunities!</p>

                    <%--<a href="">
                        <i class="fa fa-arrow-right" aria-hidden="true"></i>
                    </a>--%>
                </div>
                <div class="btn-box">
                    <a href="">
                        Join us!
                    </a>
                </div>
            </div>
        </div>

    </div>
</section>
<!-- end select end-->

<%-- 지도 띄울 modal --%>

<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">지도 출력</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"></span>
                </button>
            </div>
            <div class="modal-body"></div>
            <div id="map" name = "map" style='width:100%;height:350px; display:none;'></div>
            <p id="result"></p>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="mapAccess" name="mapAccess">설정완료</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>



<!-- footer -->
<jsp:include page="/views/footer.jsp" />
<script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx3252a097320d47aca5b8cef4762894c5"></script>

<script src="../resources/bootstrap/js/custom.js"></script>
<script type="text/javascript">


    /* todo: HHJ 로직짜기

        **** 고민

        1. 화면 입장시 controller에서 애초에 list 생성하여 화면에 뿌려줄 것
            - 컨트롤단에서 리스트 출력하는 서비스 필요 (이미 있는 서비스 써도 될 것 같음)
            - 고민할 것
                1) 애초에 들어올 때부터 주소값을 찍은 후 출력할 것인가.
                    - 이 경우라면 컨트롤단에서 찍는 것이 아니라 window.onload 될 때 ajax로 처리해야 할 것
                2) 그냥 전체 순위로 출력한 후, 주소값을 처리할 것인가.
                    - 이 경우엔 controller 단으로 가능.
                    - 근데 이게 item 에 넣었을 때 먹히느냐...? (css)

        2. 로그인 안한 상태에서 '현재 위치' 값 클릭 or 지도 값 클릭시 -> 로그인 하라는 버튼 띄우기

        3. 로그인한 상태
                1) 유저의 주소 정보가 있다면 위도, 경도로 변환하여 출력함
                2) 유저의 주소 정보가 없다면 현재 주소로 변환하여 출력함
                3) 지도 클릭하여 위치 선택할 수 있음
                참고) 유저의 주소 정보를 업데이트 시키고 싶은데 이건 시간이 모자랄 것 같고.. 왜냐면 db도 바꿔야할 것 같고... 이거는 아쉬운 점 중에 하나로 체크하면 될듯


        **** 결정 - 시간을 최소화하고 최대한 간단하게 하는 형식으로 감ㅠ

        1. 처음 메인 입장할 때에는 전체 순위로 불러올 예정 (주소값 x)
            - 기존처럼 jsp로 들어오는것이 아니라 controller 한번 타서 뿌려줄 예정 -> 완성
            - todo: catering에 붙여놓음 이거 옮겨야 하고, 처음 메인창 띄우는 형식 바꿔야 함 (컨트롤러 태워야 함)
            - todo: login시 이동시키는 주소 바뀜! 우선 메인 주소부터 정리한 후에~

        2. 현재 위치값 누르면 rest컨트롤러타서 내용 변경시키기!
            2-1. 로그인을 안한 상태 : 모든 클릭 이벤트에 대하여 로그인 이벤트를 걸어줄 것 (다른 것 못함)
                => 완성
            2-2. 로그인을 한 상태라면 : 현재 위치값으로 우선 rest 컨트롤러를 타게 하자.  (완성)
                => 완성 : rest 태우니까 css가 다 어그러져서 form.submit 시켯음! 오예

        3. 지도 버튼 누르면 변경할 수 있게끔 하는 정도까지만.
            3-1. 지도 버튼 누르면 지도 출력 (modal) (완성)
            3-2. 지도에서 위치 선택하여 확인 누르면 위도, 경도값 받아옴 (완성)
            3-3. getAddr(lat, lon) 태우면 완성 (완성)

        todo 다른 부분은 욕심 부리지 말장 이건 플젝 끝나고 더 손봐보는거로!
            하고싶었던 것 - 사용자가 최근 검색한 위치장소 저장하여 다음에 오면 노출시키기 ! 어렵진 않을거같은데 손이 좀 갈것같아

     */
    var userIdch = '${sessionScope.user.userId}';
    var truckIdch = '${sessionScope.truck.truckId}';
    console.log("userIdch: "+userIdch)
    console.log("truckIdch: "+truckIdch)
    $(function() {
        // 현재 위치 클릭하기
        $("body").on("click", ".current-location", function () {
            if (userIdch == '' && truckIdch == ''){
                loginModal()
            }else {
                findLocation();
            }
        });

        // 트럭 사진 클릭하면 트럭으로 가기
        $("body").on("click", ".img-truck-box", function () {
            var truckNo = $(this).find('input').val();
            if (userIdch == '' && truckIdch == ''){
                loginModal()
            }else {
                self.location="/menu/getMenuList?truckId="+truckNo;
            }

        });
        // 지도 클릭시 지도 화면 띄우기
        $("body").on("click", ".fa-map-marker", function () {
            if (userIdch == '' && truckIdch == ''){
                loginModal()
            }else {
                mapLocationSelect()
            }

        });
        // // 화살표 클릭시!
        // $("#goTruckArrow").on("click",function () {
        //     // var menuNo = $(this).attr('idx');
        //     var truckId = $("#goTruckArrow").val();
        //     if (userIdch == '' && truckIdch == ''){
        //         loginModal()
        //     }else {
        //         alert(truckId);
        //         self.location="/menu/getMenuList?truckId="+truckId;
        //     }
        // });

        // 메뉴 사진 클릭시
        $("body").on("click", ".img-menu-box", function () {
            var menuNo = $(this).parent().find('a').attr('idx');

            if (userIdch == '' && truckIdch == ''){
                loginModal()
            }else {
                self.location="/menu/getMenu?menuNo="+menuNo;
            }
        });



    });

    // 현재 위치 찾기
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


        };

        function error(err) {
            console.warn('ERROR(' + err.code + '): ' + err.message);
        };



    }

    // 위도-> 주소 변환하여 소팅
    const getAddr = function (lat,lng){
        let geocoder = new kakao.maps.services.Geocoder();

        let coord = new kakao.maps.LatLng(lat, lng);
        let callback = function(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                // console.log(result[0].address.address_name);
                console.log(result[0].address.address_name)
                var address = result[0].address.address_name;
                $("input[name='address']").val(address);
                $("input[name='la']").val(lat);
                $("input[name='lo']").val(lng);
                // todo: HHJ 주소창에 이거 뜨는거 뵈기시러.... post로 바꿔야할거같은디.....  깩 :::: 바까따~~~~~!
                $("form").attr("method","post").attr("action","/catering/mainTruckListLaLo").attr("target","_parent").submit();


//todo: 토) 쿼리 수정 (menu price 필요 )



            }
        }
        geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
    }


    // 지도 클릭하여 지도 위치 변경
    function mapLocationSelect() {

//todo : tmap 이 좀 예뻐서 쓰고싶엇는뎅 일단 정보가 많은 카카오로 구현해보깅 대신 도보경로는 tmap 으루 햇당
        /* var map = new Tmapv2.Map("map", {
             center :new Tmapv2.LatLng(37.566481622437934,126.98502302169841), // 지도 초기 좌표
             width : "100%",
             height : "400px",
             zoom : 14,
             zoomControl : true,
             scrollwheel : true,
             httpsMode : true //map의 https모드 설정
         });*/
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
            mapOption = {
                center: new kakao.maps.LatLng(37.566481622437934,126.98502302169841), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };

        var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 지도를 클릭한 위치에 표출할 마커입니다
        var marker = new kakao.maps.Marker({
            // 지도 중심좌표에 마커를 생성합니다
            position: map.getCenter()
        });
// 지도에 마커를 표시합
        marker.setMap(map);

// 지도에 클릭 이벤트를 등록합니다
// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
        kakao.maps.event.addListener(map, 'click', function(mouseEvent) {

            // 클릭한 위도, 경도 정보를 가져옵니다
            var latlng = mouseEvent.latLng;
            var lat = latlng.getLat();
            var lng = latlng.getLng();
            marker.setPosition(latlng);    // 마커 위치를 클릭한 위치로 옮깁니다

            $("#staticBackdrop").find("#mapAccess").on("click", function () {
                getAddr(lat, lng)
            });



        });


        $("#map").css("display","");

        // map.trigger('resize');
        $('#staticBackdrop').modal('show');

        // map 노출이 안되어서 강제로 setTimeout 주었엉...ㅎㅎ
        setTimeout( function() {
            map.relayout();
            map.setCenter(new kakao.maps.LatLng(37.566481622437934,126.98502302169841));
            window.dispatchEvent(new Event('resize'));
        }, 300);
    }

    function mapLocationSelectTruck(lat, lon, truckId, truckName, truckImg) {


        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
            mapOption = {
                center: new kakao.maps.LatLng(lat, lon), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };

        var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 지도를 클릭한 위치에 표출할 마커입니다
        var marker = new kakao.maps.Marker({
            // 지도 중심좌표에 마커를 생성합니다
            position: map.getCenter(),
            map: map
        });
        marker.setMap(map);


        // 커스텀 오버레이에 표시할 내용입니다
// HTML 문자열 또는 Dom Element 입니다
        var content = "<div class ='label'><span class='left'></span><span class='center'><a href='/menu/getMenuList?truckId="+truckId+"'>"+truckName+"</a></span>"
            + "<span class='right'></span></div>";

// 커스텀 오버레이가 표시될 위치입니다
        var position = new kakao.maps.LatLng(lat, lon);

// 커스텀 오버레이를 생성합니다
        var customOverlay = new kakao.maps.CustomOverlay({
            position: position,
            content: content
        });

// 커스텀 오버레이를 지도에 표시합니다
        customOverlay.setMap(map);

        $("#map").css("display","");
        $("#mapAccess").remove();


        // map.trigger('resize');
        $('#staticBackdrop').modal('show');

        // map 노출이 안되어서 강제로 setTimeout 주었엉...ㅎㅎ
        // 중심부 못잡아서도 이렇게 주었다
        setTimeout( function() {

            map.relayout();
            map.setCenter(new kakao.maps.LatLng(lat, lon));
            window.dispatchEvent(new Event('resize'));
        }, 300);

    }

    $(document).on("click", ".truckMapFind", function (){
        var lat = $(this).attr('la')
        var lon = $(this).attr('lo')
        var truckId = $(this).attr('td')
        var truckName = $(this).attr('nm')
        var truckImg = $(this).attr('im')

        console.log('lat : '+lat);
        console.log('lon : '+lon)
        mapLocationSelectTruck(lat, lon, truckId, truckName, truckImg)
    })

</script>
</body>

</html>