<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>
    <style>
        strong {
            font-size: 17px;
            text-align: left;
        }

        img {
            display: block;
            margin: 0px;
        }

    </style>

    <title>F.FIN | 영업상태변경</title>
    <jsp:include page="../../common/lib.jsp"/>
    <!-- bootstrap core css -->
    <link rel="stylesheet" type="text/css" href="../../resources/bootstrap/css/bootstrap.css"/>
    <!-- Custom styles for this template -->
    <link href="../../resources/bootstrap/css/style.css" rel="stylesheet"/>

    <!--    Favicons-->
    <link rel="apple-touch-icon" sizes="180x180" href="../../resources/bootstrap/assets/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="../../resources/bootstrap/assets/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../../resources/bootstrap/assets/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="../../resources/bootstrap/assets/favicons/favicon.ico">
    <link rel="manifest" href="../../resources/bootstrap/assets/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="../../resources/bootstrap/assets/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <head>

        <!--  ///////////////////////// JavaScript ////////////////////////// -->
        <script type="text/javascript">

            //============= 영업모드변경 function =============
            $(function () {
                //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
                $("#changeMode").on("click", function () {
                    fncUpdateBusiStat();
                });
                $("#confirmOnModal").on("click", function () {
                    fncUpdateBusiStatus();
                });
                // $("button.changeCancel").on("click", function () {
                //     $('#busiStat').modal('hide');
                // });
                // $("button.btn-close").on("click", function () {
                //     $('#busiStat').modal('hide');
                // });


            });

            function fncUpdateBusiStat() {
                $('#busiStat').modal('show');
            }

            function fncUpdateBusiStatus() {

                $("form").attr("method", "POST").attr("action", "/truck/updateBusiStatus").submit();
                alert("영업상태가 변경되었습니다.");
            }

            function getValue() {

                console.log('탈퇴사유 : ' + $(":input:radio[name=truckByeReason]:checked").val());
                session.set
                $("input[name=truckByeReason]:checked").each(function () {
                    console.log('탈퇴사유 : ' + $(this).val());
                });

            }

            // 지도 클릭시 지도 화면 띄우기
            $(".fa-map-marker").on("click" , function () {
                    mapLocationSelect()
            });
            // 화살표 클릭시!
            $("body").on("click", ".menu-location", function () {
                var menuNo = $(this).attr('idx');

                if (userIdch == '' && truckIdch == '') {
                    loginModal()
                } else {
                    self.location = "/menu/getMenu?menuNo=" + menuNo;
                }
            });


            // 현재 위치 찾기
            function findLocation() {

                navigator.geolocation.getCurrentPosition(success, error, options);

                var options = {
                    enableHighAccuracy: true,
                    timeout           : 5000,
                    maximumAge        : 0
                };

                function success(pos) {
                    var crd = pos.coords;
                    console.log('위도 : ' + crd.latitude);
                    console.log('경도: ' + crd.longitude);
                    lat = crd.latitude;
                    lon = crd.longitude;


                    getAddr(lat, lon);


                };

                function error(err) {
                    console.warn('ERROR(' + err.code + '): ' + err.message);
                };


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
                        center: new kakao.maps.LatLng(37.566481622437934, 126.98502302169841), // 지도의 중심좌표
                        level : 3 // 지도의 확대 레벨
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
                kakao.maps.event.addListener(map, 'click', function (mouseEvent) {

                    // 클릭한 위도, 경도 정보를 가져옵니다
                    var latlng = mouseEvent.latLng;
                    var lat = latlng.getLat();
                    var lng = latlng.getLng();
                    marker.setPosition(latlng);    // 마커 위치를 클릭한 위치로 옮깁니다

                    $("#staticBackdrop").find("#mapAccess").on("click", function () {
                        getAddr(lat, lng)
                    });


                });


                $("#map").css("display", "");

                // map.trigger('resize');
                $('#staticBackdrop').modal('show');

                // map 노출이 안되어서 강제로 setTimeout 주었엉...ㅎㅎ
                setTimeout(function () {
                    window.dispatchEvent(new Event('resize'));
                }, 300);
            }


        </script>
        <script type="text/javascript"
                src="//dapi.kakao.com/v2/maps/sdk.js?appkey=51615d81a030d0475e576eb41e443c14&libraries=services"></script>
    </head>


<body id="page-top">

<jsp:include page="/views/navbar.jsp"/>
<br/><br/><br/><br/>


<div class="container">

    <div class="page-header" style="text-align: center">
        <label for="page-top"/>
        <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
        <h4 style="margin-top: 10px;">영업상태변경</h4>
    </div>
    <br>

    <form class="form-horizontal"
          style="border-radius:10px ; border: 0; box-shadow: 0 2px 4px 0 rgba(0,0,0,0.2); transition: 0.3s;">
        <div class="row justify-content-between">
            <div class="col-12" style="margin-top:3px ">
                <div class="form-check form-switch pull-right" style="font-size:25px ">
                    <c:if test="${truck.truckBusiStatus.equals('1')}">
                        <input class="form-check-input" type="checkbox" role="switch"
                               id="swCh" name="swCh" data-bs-toggle="modal" data-bs-target="#staticBackdrop" checked>
                        <label class="form-check-label" for="swCh" style="font-size:20px; margin-top:3px ">영업중</label>
                    </c:if>
                    <c:if test="${truck.truckBusiStatus.equals('0')}">
                        <input class="form-check-input" type="checkbox" role="switch"
                               id="swCh" name="swCh" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                        <label class="form-check-label" for="swCh">영업종료</label>
                    </c:if>

                </div>
            </div>


            <script>

                $("#busiStatus").on("click", function () {
                    var truckId = $("input[name='truckId']").val();
                    var tb = $("input[name='swCh']:checked").val();


                    if (tb == 'on') {
                        tb = 1;
                    } else if (tb == undefined) {
                        tb = 0;
                    }

                    $.ajax({
                        url        : "/purchase/json/updateBusiStatus",
                        method     : "POST",
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        data       : {
                            "truckId": truckId,
                            "tb"     : tb
                        },
                        success    : function (data) {

                            alert("영업상태가 변경되었습니다")

                            window.location.reload();
                        }
                    });


                });
            </script>
        </div>

        <hr/>

        <!-- slider section -->
        <section class="slider_section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-10 mx-auto">
                        <div class="detail-box" style="margin-bottom: -40px;">
                            <h1 class="display-1 fs-md-5 fs-lg-6 fs-xl-8 text-light"
                                style=" font-family: 'Pacifico', cursive; color: #110000">
                                FoodTruck Finder
                            </h1>
                            <h6 class="text-800 mb-5 fs-4">check your location</h6>
                        </div>
                        <div class="find_container ">
                            <div class="container">
                                <div class="row">
                                    <div class="col">
                                        <form>
                                            <div class="form-row">
                                                <div class="form-group col-lg-6">
                                                    <input type="text" class="form-control" id="inputLocation"
                                                           name="inputLocation" placeholder="오늘 영업하실 장소를 설정해주세요."
                                                           value="${inputLocation}">
                                                    <span class="location_icon">
                                                    <i class="fa fa-map-marker" aria-hidden="true"></i>
                                                  </span>
                                                </div>
                                            </div>
                                            <div class="form-row" style="margin-top: -15px;">
                                                <div class="form-group col-md-4">
                                                    <div class="btn-box">
                                                        <button type="button" class="btn current-location">트럭 현재위치
                                                            설정하기
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="map" name="map" style='width:100%;height:350px;'></div>
                    </div>
                </div>
            </div>
        </section>

        <%-- 지도 띄울 modal --%>

        <!-- Modal -->
        <div class="modal fade" id="staticBackdrop" data-backdrop="static" tabindex="-1" role="dialog"
             aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="staticBackdropLabel">지도 출력</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true"></span>
                        </button>
                    </div>
                    <div class="modal-body"></div>
                    <%--                        <div id="map" name = "map" style='width:100%;height:350px; display:none;'></div>--%>
                    <p id="result"></p>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" id="mapAccess" name="mapAccess">설정완료</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>


        <!-- Modal -->
        <div class="modal fade" id="busiStat" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="busiStat" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="busiStatLabel">영업모드</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <c:if test="${truck.truckBusiStatus.equals('1')}">
                            영업종료 상태로 변경합니다.
                        </c:if>
                        <c:if test="${truck.truckBusiStatus.equals('0')}">
                            영업중 상태로 변경합니다.
                        </c:if>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-cancle" data-bs-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-default" id="confirmOnModal">변경</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Button trigger modal -->
        <div class="form-group" align="center">
            <div class="col-sm-offset-1  col-sm-10 text-center">
                <button type="button" class="btn btn-default" id="changeMode" data-bs-toggle="modal"
                        data-bs-target="#busiStat">
                    영업상태변경
                </button>
                <input type="button" class="btn btn-cancle" value="취소"
                       onclick="javascript:window.location='/catering/mainTruckList'">
            </div>
        </div>
        <br/>
</div>
</form>


<jsp:include page="/views/footer.jsp"/>

</body>

</html>
