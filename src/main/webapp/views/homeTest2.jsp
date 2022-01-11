<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <title>F.FIN | FOODTRUCK FINDER</title>
    <jsp:include page="../common/lib.jsp"/>
    <script type="text/javascript">

        function loginModal(){
            $('#openLoginModal').modal('show');
        }

    </script>
<style>


</style>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=51615d81a030d0475e576eb41e443c14&libraries=services"></script>
    <script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx3252a097320d47aca5b8cef4762894c5"></script>


    <script type="text/javascript">

        var map;
        var marker_s, marker_e, marker_p1, marker_p2;
        var totalMarkerArr = [];
        var drawInfoArr = [];
        var resultdrawArr = [];

        $(function() {
            $("body").on("click", ".current-location", function () {
             //   $("#map_wrap").css("display", "block");
             //   initTmap();
                $("#iframe").css('display',"block");
                
            });
        });

        function initTmap() {


            var lalala = $("input[name='lalala']").val();
            var lololo = $("input[name='lololo']").val();


            // 1. 지도 띄우기
            map = new Tmapv2.Map("map_div", {
                //center : new Tmapv2.LatLng(lalala, lololo),
                width : "100%",
                height : "400px",
                zoom : 14,
                zoomControl : true,
                scrollwheel : true
            });

            // 2. 시작, 도착 심볼찍기
            // 시작
            marker_s = new Tmapv2.Marker(
                {
                    position : new Tmapv2.LatLng(lalala, lololo),
                    icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_s.png",
                    iconSize : new Tmapv2.Size(24, 38),
                    map : map
                });

            // 도착
            marker_e = new Tmapv2.Marker(
                {
                    position : new Tmapv2.LatLng(37.57081522, 127.00160213),
                    icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_e.png",
                    iconSize : new Tmapv2.Size(24, 38),
                    map : map
                });

            // 3. 경로탐색 API 사용요청
            $
                .ajax({
                    method : "POST",
                    url : "https://apis.openapi.sk.com/tmap/routes/pedestrian?version=1&format=json&callback=result",
                    async : false,
                    data : {
                        "appKey" : "l7xx3252a097320d47aca5b8cef4762894c5",
                        "startX" : lololo,
                        "startY" : lalala,
                        "endX" : "127.00160213",
                        "endY" : "37.57081522",
                        "reqCoordType" : "WGS84GEO",
                        "resCoordType" : "EPSG3857",
                        "startName" : "출발지",
                        "endName" : "도착지"
                    },
                    success : function(response) {
                        var resultData = response.features;

                        //결과 출력
                        var tDistance = "총 거리 : "
                            + ((resultData[0].properties.totalDistance) / 1000)
                                .toFixed(1) + "km,";
                        var tTime = " 총 시간 : "
                            + ((resultData[0].properties.totalTime) / 60)
                                .toFixed(0) + "분";

                        $("#result").text(tDistance + tTime);

                        //기존 그려진 라인 & 마커가 있다면 초기화
                        if (resultdrawArr.length > 0) {
                            for ( var i in resultdrawArr) {
                                resultdrawArr[i]
                                    .setMap(null);
                            }
                            resultdrawArr = [];
                        }

                        drawInfoArr = [];

                        for ( var i in resultData) { //for문 [S]
                            var geometry = resultData[i].geometry;
                            var properties = resultData[i].properties;
                            var polyline_;


                            if (geometry.type == "LineString") {
                                for ( var j in geometry.coordinates) {
                                    // 경로들의 결과값(구간)들을 포인트 객체로 변환
                                    var latlng = new Tmapv2.Point(
                                        geometry.coordinates[j][0],
                                        geometry.coordinates[j][1]);
                                    // 포인트 객체를 받아 좌표값으로 변환
                                    var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(
                                        latlng);
                                    // 포인트객체의 정보로 좌표값 변환 객체로 저장
                                    var convertChange = new Tmapv2.LatLng(
                                        convertPoint._lat,
                                        convertPoint._lng);
                                    // 배열에 담기
                                    drawInfoArr.push(convertChange);
                                }
                            } else {
                                var markerImg = "";
                                var pType = "";
                                var size;

                                if (properties.pointType == "S") { //출발지 마커
                                    markerImg = "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_s.png";
                                    pType = "S";
                                    size = new Tmapv2.Size(24, 38);
                                } else if (properties.pointType == "E") { //도착지 마커
                                    markerImg = "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_e.png";
                                    pType = "E";
                                    size = new Tmapv2.Size(24, 38);
                                } else { //각 포인트 마커
                                    markerImg = "http://topopen.tmap.co.kr/imgs/point.png";
                                    pType = "P";
                                    size = new Tmapv2.Size(8, 8);
                                }

                                // 경로들의 결과값들을 포인트 객체로 변환
                                var latlon = new Tmapv2.Point(
                                    geometry.coordinates[0],
                                    geometry.coordinates[1]);

                                // 포인트 객체를 받아 좌표값으로 다시 변환
                                var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(
                                    latlon);

                                var routeInfoObj = {
                                    markerImage : markerImg,
                                    lng : convertPoint._lng,
                                    lat : convertPoint._lat,
                                    pointType : pType
                                };

                                // Marker 추가
                                marker_p = new Tmapv2.Marker(
                                    {
                                        position : new Tmapv2.LatLng(
                                            routeInfoObj.lat,
                                            routeInfoObj.lng),
                                        icon : routeInfoObj.markerImage,
                                        iconSize : size,
                                        map : map
                                    });
                            }
                        }//for문 [E]
                        drawLine(drawInfoArr);
                    },
                    error : function(request, status, error) {
                        console.log("code:" + request.status + "\n"
                            + "message:" + request.responseText + "\n"
                            + "error:" + error);
                    }
                });

        }

        function addComma(num) {
            var regexp = /\B(?=(\d{3})+(?!\d))/g;
            return num.toString().replace(regexp, ',');
        }

        function drawLine(arrPoint) {
            var polyline_;

            polyline_ = new Tmapv2.Polyline({
                path : arrPoint,
                strokeColor : "#DD0000",
                strokeWeight : 6,
                map : map
            });
            resultdrawArr.push(polyline_);
        }


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
                $("input[name='lalala']").val(lat)
                $("input[name='lololo']").val(lon)
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

<body id="page-top">




<div class="hero_area">

    <!-- toolbar -->
    <jsp:include page="/views/navbar.jsp" />

    <!-- slider section -->
    <section class="slider_section ">
        <div class="container ">
            <div class="row">
                <div class="col-lg-10 mx-auto">
                    <div class="detail-box" style="margin-bottom: -40px;">
                        <h1 class="display-1 fs-md-5 fs-lg-6 fs-xl-8 text-light">
                            FoodTruck Finder
                        </h1>
                        <h5 class="text-800 mb-5 fs-4">Within a few clicks,<br class="d-none d-xxl-block" /><br/>find foodtruck are accessible near you</h5>
                    </div>
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
                                                    <button type="button" class="btn current-location">Use current location</button>
                                                    <input type="text" name="lalala" />
                                                    <input type="text" name="lololo"/>
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
        <iframe id="iframe" src="/room" frameborder="0" width="1000" height="300" marginwidth="0" marginheight="0" style="display:none;"></iframe>

        <div class="slider_container">
            <div class="item">
                <div class="img-box">
                    <img src="../resources/bootstrap/images/foodtruck_default.jpg" alt="" />
                </div>
            </div>
            <div class="item">
                <div class="img-box">
                    <img src="../resources/bootstrap/images/foodtruck_default.jpg" alt="" />
                </div>
            </div>
            <div class="item">
                <div class="img-box">
                    <img src="../resources/bootstrap/images/foodtruck_default.jpg" alt="" />
                </div>
            </div>
            <div class="item">
                <div class="img-box">
                    <img src="../resources/bootstrap/images/foodtruck_default.jpg" alt="" />
                </div>
            </div>
            <div class="item">
                <div class="img-box">
                    <img src="../resources/bootstrap/images/foodtruck_default.jpg" alt="" />
                </div>
            </div>
            <div class="item">
                <div class="img-box">
                    <img src="../resources/bootstrap/images/foodtruck_default.jpg" alt="" />
                </div>
            </div>
            <div class="item">
                <div class="img-box">
                    <img src="../resources/bootstrap/images/foodtruck_default.jpg" alt="" />
                </div>
            </div>
            <div class="item">
                <div class="img-box">
                    <img src="../resources/bootstrap/images/foodtruck_default.jpg" alt="" />
                </div>
            </div>
        </div>
    </section>
    <!-- end slider section -->
</div>
<div id="map_wrap" class="map_wrap3" style="display: none">
    <div id="map_div"></div>
</div>
<div class="map_act_btn_wrap clear_box"></div>
<p id="result"></p>
<br />

<!-- Popular Foodtruck section -->

<section class="recipe_section layout_padding-top">
    <div class="container">
        <div class="heading_container heading_center">
            <h2>
                Popular Foodtruck
            </h2>
        </div>
        <div class="row">
            <div class="col-sm-6 col-md-4 mx-auto">
                <div class="box">
                    <div class="img-box">
                        <img src="../resources/bootstrap/images/food1.png" class="box-img" alt="">
                    </div>
                    <div class="detail-box">
                        <h5> MenuName </h5>
                        <div><span class="text-warning me-2"><i class="fas fa-map-marker-alt"></i></span><span class="text-primary">TruckName</span></div><span class="text-1000 fw-bold">₩5,000</span>
                        <br/>
                        <a href="">
                            <i class="fa fa-arrow-right" aria-hidden="true"></i>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-4 mx-auto">
                <div class="box">
                    <div class="img-box">
                        <img src="../resources/bootstrap/images/food2.png" class="box-img" alt="">
                    </div>
                    <div class="detail-box">
                        <h5> MenuName </h5>
                        <div><span class="text-warning me-2"><i class="fas fa-map-marker-alt"></i></span><span class="text-primary">TruckName</span></div><span class="text-1000 fw-bold">₩5,000</span>
                        <br/>
                        <a href="">
                            <i class="fa fa-arrow-right" aria-hidden="true"></i>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-4 mx-auto">
                <div class="box">
                    <div class="img-box">
                        <img src="../resources/bootstrap/images/food3.png" class="box-img" alt="">
                    </div>
                    <div class="detail-box">
                        <h5> MenuName </h5>
                        <div><span class="text-warning me-2"><i class="fas fa-map-marker-alt"></i></span><span class="text-primary">TruckName</span></div><span class="text-1000 fw-bold">₩5,000</span>
                        <br/>
                        <a href="">
                            <i class="fa fa-arrow-right" aria-hidden="true"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="btn-box">
            <a href="">
                more FoodTruck
            </a>
        </div>
    </div>
</section>
<!-- end Popular Foodtruck section -->


<!-- coupon section -->
<section class="about_section layout_padding">
    <div class="container">
        <div class="col-md-11 col-lg-10 mx-auto">
            <div class="heading_container heading_center">
                <h2>
                    Coupon
                </h2>
            </div>
            <div class="box">
                <div class="col-md-7 mx-auto">
                    <div class="img-box">
                        <img src="../resources/bootstrap/images/weather.png" class="box-img" alt="">
                    </div>
                </div>
                <div class="detail-box">
                    <p>coupon 받아가라... font 적용 어떻게하냐....</p>
                </div>
                <div class="btn-box">
                    <a href="">
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
                <h2>
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
    <div class="fab-container">
        <div class="fab shadow">
            <div class="fab-content">
                <span class="material-icons">support_agent</span>
            </div>
        </div>
        <div class="sub-button shadow">
            <a href="google.com" target="_blank">
                <span class="material-icons">phone</span>
            </a>
        </div>
        <div class="sub-button shadow">
            <a href="google.com" target="_blank">
                <span class="material-icons">mail_outline</span>
            </a>
        </div>
        <div class="sub-button shadow">
            <a href="google.com" target="_blank">
                <span class="material-icons">language</span>
            </a>
        </div>
        <div class="sub-button shadow">
            <a href="google.com" target="_blank">
                <span class="material-icons">help_outline</span>
            </a>
        </div>
    </div>
</section>
<!-- end select end-->


<!-- footer -->
<jsp:include page="/views/footer.jsp" />
<%--
<!-- jQery -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<!-- bootstrap js -->
<script src="../resources/bootstrap/js/bootstrap.js"></script>
<!-- slick  slider -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.js"></script>
<!-- nice select -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js" integrity="sha256-Zr3vByTlMGQhvMfgkQ5BtWRSKBGa2QlspKYJnkjZTmo=" crossorigin="anonymous"></script>
<!-- custom js -->--%>
<script src="../resources/bootstrap/js/custom.js"></script>

</body>

</html>