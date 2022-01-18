<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="ko">
<meta charset="EUC-KR">

<head>
    <jsp:include page="../../common/lib.jsp"/>



    <style>


        .btn-secondary {
            color: #212529;
            background-color: #ffba49;
            border-color: #ffba49;
        }

        .btn-check:active+.btn-outline-primary, .btn-check:checked+.btn-outline-primary, .btn-outline-primary.active, .btn-outline-primary.dropdown-toggle.show, .btn-outline-primary:active {
            color: #212529;
            background-color: #ffba49;
            border-color: #ffba49;
        }
        .btn-outline-primary {
            color: #fdc76e;
            border-color: #ffba49;
        }

        .btn-primary {
            color: #212529;
            background-color: #ffba49;
            border-color: #ffba49;
        }
        #map_ma {
            width: 100%;
            height: 400px;
            clear: both;
            border: solid 1px red;
        }

        h5.card-title {
            font-size: 15px;
        }

        main {
            margin-top: 80px;
        }

        footer {
            margin-top: 1000px;
        }

        /*이미지 사이즈*/
        .img-fluid {
            height: auto;
            width: 250px;
        }

        /*카드 둥글게*/
        .card {
            position: relative;
            display: -ms-flexbox;
            display: flex;
            -ms-flex-direction: column;
            flex-direction: column;
            min-width: 0;
            word-wrap: break-word;
            background-color: #fff;
            background-clip: border-box;
            border: 1px solid rgba(0, 0, 0, 0.125);
            border-radius: 1.25rem;
        }
        /*이미지접히게*/
        .rounded-start {
            border-bottom-left-radius: 1.25rem!important;
            border-top-left-radius: 1.25rem!important;
        }

    </style>
</head>
<body>
<jsp:include page="/views/navbar.jsp"/>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
        integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript"
        src="http://maps.google.com/maps/api/js?key=AIzaSyBmxlLXS2GGFBgeQTt6n4YPhxU6NKu4Kx8"></script>
<!-- 도보 경로 navi -->
<script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx3252a097320d47aca5b8cef4762894c5"></script>
<!-- 현재 위치 찾기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=51615d81a030d0475e576eb41e443c14&libraries=services"></script>


<script type="text/javascript">
    var map;
    var marker_s, marker_e, marker_p1, marker_p2;
    var totalMarkerArr = [];
    var drawInfoArr = [];
    var resultdrawArr = [];
    let truckMapLa = ${purchase.orderTruckId.truckMapLa}; // 트럭의 위도
    let truckMapLo = ${purchase.orderTruckId.truckMapLo}; // 트럭의 경도


    $(document).ready(function () {
        initTmap(); // 처음 onload될 때엔 truck의 위도, 경도를 받아간다.

    });

    /* 처음 onload 될 때의 지도 */
    function initTmap(){

        map = new Tmapv2.Map("map_ma", { // "map_div" : 지도가 표시될 div의 id

            center: new Tmapv2.LatLng(truckMapLa,truckMapLo), // 지도 초기 좌표
            width: "100%", // map의 width 설정
            height: "400px", // map의 height 설정
            zoom: 17
        });

        var marker = new Tmapv2.Marker({
            position: new Tmapv2.LatLng(truckMapLa,truckMapLo),
            icon : "http://tmapapi.sktelecom.com/resources/images/common/pin_car.png",
            map: map
        });

        console.log("truckMapLa : "+truckMapLa);
        console.log("truckMapLo : "+truckMapLo);

    }

    $(function() {
        $("body").on("click", ".current-location", function () {
            //   $("#map_wrap").css("display", "block");
            findLocation(); // 이용자가 버튼을 누르면 findLocation();
           // $("#iframe").css('display',"block");

        });
    });

    // 현재 위치 찾기
    function findLocation() {
        //$("#map_wrap").css("display", "none");
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
            /* ymca */
           // lat = 37.570343803513154;
           // lon = 126.98501697552159;
            findLocationNavi(lat,lon);
        };

        function error(err) {
            console.warn('ERROR(' + err.code + '): ' + err.message);
        };
    }

    // 도보경로
    const findLocationNavi = function (lat, lon) {

      //  console.log("lat : "+lat);
      // console.log("lon : "+lon);

       // 중간지점 노출하기 위함
        let latCenter = (lat + truckMapLa)/2;
        let lonCenter = (lon + truckMapLo)/2;

        // 1. 지도 띄우기
        map = new Tmapv2.Map("map_ma2", {
            center : new Tmapv2.LatLng(latCenter, lonCenter),
            width : "100%",
            height : "400px",
            zoom :17,
            zoomControl : true,
            scrollwheel : true
        });
        $("#map_wrap").remove();
        // 2. 시작, 도착 심볼찍기
        // 시작
        marker_s = new Tmapv2.Marker(
            {
                position : new Tmapv2.LatLng(lat, lon), // 시작지점: 이용자
                icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_s.png",
                iconSize : new Tmapv2.Size(24, 38),
                map : map
            });

        // 도착
        marker_e = new Tmapv2.Marker(
            {
                position : new Tmapv2.LatLng(truckMapLa, truckMapLo), // 도착지점 트럭
                icon : "http://tmapapi.sktelecom.com/resources/images/common/pin_car.png",
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
                    "startX" : lon,
                    "startY" : lat,
                    "endX" : truckMapLo,
                    "endY" : truckMapLa,
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

                    $("#roadCheck").text(tDistance + tTime);

                    //기존 그려진 라인 & 마커가 있다면 초기화
                    if (resultdrawArr.length > 0) {
                        for ( var i in resultdrawArr) {
                            resultdrawArr[i].setMap(null);
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
                    console.log("drawInfoArr: "+drawInfoArr)
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



    /* Iamport 환불시스템*/
    function cancelPay() {
        var pointNo = $("input[name='pointNo']").val();
        var couponNo = $("input[name='couponNo']").val();
        var payId = $("input[name='payId']").val();
        var orderNo = $("input[name='orderNo']").val();
        var orderCancelReason = $("input[name='orderCancelReason']:checked").val();

        if(pointNo == undefined || pointNo ==''){
            pointNo = 0;
        }

        if(couponNo == undefined || couponNo == ''){
            couponNo = 0;
        }



        $.ajax({
            url: "/purchase/json/payRefund", // 예: http://www.myservice.com/payments/cancel
            type: "POST",
            async: false,
            dataType: "json",
            data: {
                "payId": payId,
                "orderNo": orderNo,
                "orderCancelReason": orderCancelReason,
                "couponNo": couponNo,
                "pointNo": pointNo,
            },

            success: function (map) {
                self.location = "/user/getPurchaseList";
            },
            error: function (xhr, status, error) {
                alert("[Error]" + error);
                return;
            }

        });

    }


</script>
<title>F.FIN | 현재주문정보</title>
<style>

    .adminbox{
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 2px 4px 1px rgba(0,0,0,0.2);
        transition: 0.3s;
    }
    .info{
        display: grid;
    }
    .info map_ma{
        height: auto;
        max-width: 400px;
        box-shadow: 0 1px 2px 1px rgba(0,0,0,0.2);
        transition: 0.2s;
    }
    .form-control:disabled, .form-control[readonly]{
        background-color: rgba(255, 229, 55, 0.16);
        width: auto;
        opacity: 1;
        border: 0;
        /*border-width: 2px;
        border-color: #ffe537;*/
    }
    .data-input-box{
        margin-top: 30px;
    }
    h5 span{
        margin-left: 10px;
    }
    #user_update_info{
        margin-top: 20px;
    }


    /*.img-fluid {

        height: auto;
        width: 180px
    }*/

</style>
<%--<script>
    $(document).ready(function(){
        var a = ${purchase.orderTruckId.truckName};
       console.log()
    });
</script>--%>
<section class="client_section layout_padding">
    <div class="container">
        <div class="col-md-11 col-lg-10 mx-auto">
            <div class="detail-box">
                <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
                <h4 style="margin-top: 10px;">
                    현재주문정보
                </h4>
            </div>

            <form class="row justify-content-center" id="user_update_info">

                <div class="col-md-12 data-input-box adminbox">
                    <div class="data-input-box info" >
                        <div>
                            <div style="margin-top: 15px;">
                                <h4 style="text-align: center;">${purchase.orderTruckId.truckName}</h4>
                            </div>
                        </div>
                        <hr style="margin-top: 35px; margin-bottom: 60px;"/>

                        <div id="map_wrap" class="map_wrap3" >
                            <div id="map_ma"></div>
                        </div>
                        <div class="map_act_btn_wrap clear_box"></div>
                        <div> <div id="map_ma2"></div> </div>
                        <p id="roadCheck"></p>
                        <br />


                            <button type="button" class="btn current-location btn-primary">경로 안내</button>


                    </div>
                    <hr style="margin-top: 60px;"/>

                    <div style="display: flex; justify-content: center;">
                        <div class="col-md-6 data-input-box" style="display: flex; justify-content: center;">
                            <div class="data-input-box user-info">
                                <div>
                                    <div style="margin-bottom: 15px;">
                                        <label for="orderNo" class="form-label label-name">주문번호</label>
                                        <input type="text" class="form-control" value="${purchase.orderNo}" id="orderNo" name="orderNo" readonly style="width: 340px;">
                                    </div>
                                    <div style="margin-bottom: 15px;">
                                        <label for="orderTruckId.truckPhone" class="form-label label-name">사장님연락처</label>
                                        <input type="text" class="form-control" value=" ${purchase.orderTruckId.truckPhone}" id="orderTruckId.truckPhone" name="orderTruckId.truckPhone" readonly style="width: 340px;">
                                    </div>

                                    <div style="margin-bottom: 15px;">
                                        <label for="orderRequest" class="form-label label-name">주문요청사항</label>
                                        <input type="text" class="form-control" value="${purchase.orderRequest}" id="orderRequest" name="orderRequest" readonly style="width: 340px;">
                                    </div>
                                    <div style="margin-bottom: 15px;">
                                        <label for="orderPickUpTime" class="form-label label-name">픽업희망시간</label>
                                        <input type="text" class="form-control" value="${purchase.orderPickUpTime}" id="orderPickUpTime" name="orderPickUpTime" readonly style="width: 340px;">
                                    </div>
                                    <div style="margin-bottom: 15px;">
                                        <label for="orderCookingTime" class="form-label label-name">예상조리시간</label>
                                        <input type="text" class="form-control" value="<c:if test="${purchase.orderCookingTime eq 0}">주문 접수 중</c:if><c:if test="${purchase.orderCookingTime ne 0}">${purchase.orderCookingTime}</c:if>" id="orderCookingTime" name="orderCookingTime" readonly style="width: 340px;">
                                    </div>
                                    <div style="margin-bottom: 15px;">
                                        <c:if test="${purchase.payOption == '0'}">
                                            <label for="payOption" class="form-label label-name">결제방법</label>
                                            <input type="text" class="form-control" value="휴대폰결제" id="payOption" name="payOption" readonly style="width: 340px;">
                                        </c:if>
                                        <c:if test="${purchase.payOption == '1'}">
                                            <label for="payOption" class="form-label label-name">결제방법</label>
                                            <input type="text" class="form-control" value="카카오결제" id="payOption" name="payOption" readonly style="width: 340px;">
                                        </c:if>
                                        <c:if test="${purchase.payOption == '3'}">
                                            <label for="payOption" class="form-label label-name">결제방법</label>
                                            <input type="text" class="form-control" value="신용카드" id="payOption" name="payOption" readonly style="width: 340px;">
                                        </c:if>
                                        <c:if test="${purchase.payOption == '4'}">
                                            <label for="payOption" class="form-label label-name">결제방법</label>
                                            <input type="text" class="form-control" value="무통장입금" id="payOption" name="payOption" readonly style="width: 340px;">
                                        </c:if>

                                    </div>
                                    <div style="margin-bottom: 15px;">
                                        <label for="payPrice" class="form-label label-name">결제금액</label>
                                        <input type="text" class="form-control" value="${purchase.payPrice}" id="payPrice" name="payPrice" readonly style="width: 340px;">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 data-input-box" style="display: flex; justify-content: center;">
                            <div class="data-input-box user-profile">
                                <div>
                                    <div style="margin-bottom: 30px;">
                                        <c:choose>
                                            <c:when test="${purchase.orderStatus == '1'}">
                                                <label  class="form-label label-name">주문상태</label>
                                                <span class="badge" style="background-color: #fae100; color: #110000">결제완료</span>
                                            </c:when>
                                            <c:when test="${purchase.orderStatus == '2'}">
                                                <label  class="form-label label-name">주문상태</label>
                                                <span class="badge" style="background-color: #fae100; color: #110000">주문접수</span>
                                            </c:when>
                                            <c:when test="${purchase.orderStatus == '3'}">
                                                <label class="form-label label-name">주문상태</label>
                                                <span class="badge" style="background-color: #fae100; color: #110000">픽업요청</span>
                                            </c:when>
                                            <c:when test="${purchase.orderStatus == '4'}">
                                                <label  class="form-label label-name">주문상태</label>
                                                <span class="badge" style="background-color: #65bf96; color: #110000">픽업완료</span>
                                            </c:when>
                                            <c:when test="${purchase.orderStatus == '5'}">
                                                <label class="form-label label-name">주문상태</label>
                                                <span class="badge" style="background-color: #ffba49; color: #110000">결제취소</span>
                                            </c:when>
                                            <c:when test="${purchase.orderStatus == '6'}">
                                                <label class="form-label label-name">주문상태</label>
                                                <span class="badge" style="background-color: #ffba49; color: #110000">픽업완료</span>
                                            </c:when>
                                            <c:when test="${purchase.orderStatus == '7'}">
                                                <label class="form-label label-name">주문상태</label>
                                                <span class="badge" style="background-color: #ffba49; color: #110000">픽업완료</span>
                                            </c:when>
                                        </c:choose>&nbsp;&nbsp;

                                    </div>

                                    <div style="margin-bottom: 30px;">
                                        <label for="orderCookingTime" class="form-label label-name">주문목록</label>
                                        <div id="order"></div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <hr style="margin-bottom: 35px;"/>
                </div>

            </form>

            <div class="btn-box" style=" margin-top: 20px;">
                <a type="button" href="/catering/mainTruckList" style="margin-right: 10px;  background-color: #ecf0fd; border-color: #ecf0fd">
                    확인
                </a>
                <c:if test="${purchase.orderStatus == '1'}">
                <a data-bs-toggle="modal" href="#exampleModalToggle"  style="margin-right: 10px;  background-color: #ecf0fd; border-color: #ecf0fd">
                    주문취소
                </a>
                </c:if>
                <c:set var="i" value="0"/>
                <c:forEach var="cart" items="${map.get('list')}">
                    <c:set var="i" value="${i+1}"/>


                    <input type="hidden" id="odMenuName" name="odMenuName" value="${cart.odMenuName}"/>
                    <input type="hidden" id="odOptionGroupName" name="odOptionGroupName"
                           value="${cart.odOptionGroupName}"/>
                    <input type="hidden" id="odOptionName" name="odOptionName" value="${cart.odOptionName}"/>
                    <input type="hidden" id="odMenuQty" name="odMenuQty" value="${cart.odMenuQty}"/>
                    <input type="hidden" id="odMenuPrice" name="odMenuPrice" value="${cart.odMenuPrice}"/>
                    <input type="hidden" id="odOptionPrice" name="odOptionPrice" value="${cart.odOptionPrice}"/>
                    <input type="hidden" id="odMenuImage" name="odMenuImage" value="${cart.odMenuImage}"/>
                    <input type="hidden" id="odMenuQtyFlag" name="odMenuQtyFlag" value="${cart.odMenuQtyFlag}"/>


                </c:forEach>
                <input type="hidden" name="payId" value="${purchase.payId}">
                <input type="hidden" name="orderNo" value="${purchase.orderNo}">
                <input type="hidden" name="couponNo" value="${purchase.payCouponNo.couponNo}">
                <input type="hidden" name="pointNo" value="${purchase.payPointNo.pointNo}">
                <input type="hidden" name="userId" value="${user.userId}">
                <%-- HHJ 나도 감출 정보 있오 --%>
                <input type="hidden" name="lalala" >
                <input type="hidden" name="lololo" >
            </div>
        </div>
    </div>
</section>
<div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel"
     tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalToggleLabel">Modal 1</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">


                <div class="container-fluid">
                    <div class="row">
                        <input type="radio" class="btn-check" name="orderCancelReason" id="btnradio1"
                               autocomplete="off" value="1" checked>
                        <label class="btn btn-outline-primary" for="btnradio1">구매의사 취소</label>
                    </div>
                </div>

                <div class="container-fluid">
                    <div class="row">
                        <input type="radio" class="btn-check" name="orderCancelReason" id="btnradio2"
                               autocomplete="off" value="2">
                        <label class="btn btn-outline-primary" for="btnradio2">메뉴 및 수량 변경</label>
                    </div>
                </div>

                <div class="container-fluid">
                    <div class="row">
                        <input type="radio" class="btn-check" name="orderCancelReason" id="btnradio3"
                               autocomplete="off" value="3">
                        <label class="btn btn-outline-primary" for="btnradio3">주문접수 지연</label>
                    </div>
                </div>
                <div class="container-fluid">
                    <div class="row">
                        <input type="radio" class="btn-check" name="orderCancelReason" id="btnradio4"
                               autocomplete="off" value="4">
                        <label class="btn btn-outline-primary" for="btnradio4">기 타</label>
                    </div>
                </div>


            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" data-bs-dismiss="modal" aria-label="Close">취소</button>
                <button class="btn btn-primary" data-bs-target="#exampleModalToggle2" data-bs-toggle="modal">다 음
                </button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="exampleModalToggle2" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2"
     tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalToggleLabel2">Modal 2</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                정말로 주문취소 하나요??
            </div>
            <div class="modal-footer">

                <button class="btn btn-primary" data-bs-dismiss="modal" aria-label="Close">취소</button>
                <button class="btn btn-primary" onclick="cancelPay()">확인</button>
            </div>
        </div>
    </div>
</div>


<script>
    $(function () {
        var odMenuNameCount = $("input[name='odMenuName']").length;


        var odMenuNameL;
        var odOptionGroupNameL;
        var odOptionNameL;
        var odMenuQtyL;
        var odMenuPriceL;
        var odOptionPriceL;
        var odMenuImageL;

        for (var i = 0; i < odMenuNameCount; i++) {
            var odMenuName = $("input[name='odMenuName']").eq(i).val();
            var odOptionGroupName = $("input[name='odOptionGroupName']").eq(i).val();
            var odOptionName = $("input[name='odOptionName']").eq(i).val();
            var odMenuQty = $("input[name='odMenuQty']").eq(i).val();
            var odMenuPrice = $("input[name='odMenuPrice']").eq(i).val();
            var odOptionPrice = $("input[name='odOptionPrice']").eq(i).val();
            var odMenuImage = $("input[name='odMenuImage']").eq(i).val();
            var odMenuQtyFlag = $("input[name='odMenuQtyFlag']").eq(i).val();


            var odMenuImageCopy;
            var odMenuNameCopy;
            var odOptionGroupNameCopy;
            var odOptionNameCopy;
            var odMenuQtyCopy;
            var odMenuPriceCopy;
            var odOptionPriceCopy;
            var test2;
            var totalPrice;


            if (odMenuNameCopy != undefined && odMenuQtyFlag == 0) {
                odMenuNameCopy = odMenuNameCopy + "," + odMenuName;
                odMenuImageCopy = odMenuImageCopy + "," + odMenuImage;
                odMenuQtyCopy = odMenuQtyCopy + "," + odMenuQty;
                odMenuPriceCopy = odMenuPriceCopy + "," + odMenuPrice;
                totalPrice = totalPrice + parseInt(odMenuPrice);
            } else if (odMenuNameCopy == undefined) {

                odMenuNameCopy = odMenuName;
                odMenuImageCopy = odMenuImage;
                odMenuQtyCopy = odMenuQty;
                odMenuPriceCopy = odMenuPrice;
                totalPrice = parseInt(odMenuPrice);

            }

            odMenuNameL = odMenuNameCopy.split(",");
            odMenuImageL = odMenuImageCopy.split(",");
            odMenuQtyL = odMenuQtyCopy.split(",");
            odMenuPriceL = odMenuPriceCopy.split(",").map(Number);

            if (odOptionNameCopy == undefined) {
                odOptionNameCopy = odOptionName;
                test2 = odMenuName;
                odOptionGroupNameCopy = odOptionGroupName;
                odOptionPriceCopy = odOptionPrice;

            } else if (test2 != odMenuName ) {
                odOptionNameCopy = odOptionNameCopy + "/" + odOptionName;
                odOptionGroupNameCopy = odOptionGroupNameCopy + "/" + odOptionGroupName;
                odOptionPriceCopy = odOptionPriceCopy + "/" + odOptionPrice;

            } else if (odOptionNameCopy != undefined) {

                odOptionNameCopy = odOptionNameCopy + "," + odOptionName;
                test2 = odMenuName;
                odOptionGroupNameCopy = odOptionGroupNameCopy + "," + odOptionGroupName;
                odOptionPriceCopy = odOptionPriceCopy + "," +  odOptionPrice;
            }

            odOptionNameL = odOptionNameCopy.split("/");
            odOptionGroupNameL = odOptionGroupNameCopy.split("/");



        }
        var sum = new Array() ;
        var test3 = new Array();

        odOptionPriceL = odOptionPriceCopy.split("/");

        /*alert("ordejoijafjs"+odOptionPriceL)*/
        for(var i = 0; i<odOptionPriceL.length; i++){
            test3 = odOptionPriceL[i].split(",");

            for(var j = 0; j<test3.length; j++){

                if(sum[i]==undefined){
                    sum[i] =Number(test3[j]);
                    /*alert("첫번째값"+Number(test3[j]))*/
                }else{
                    sum[i]=(Number(sum[i])+Number(test3[j]));
                    /*alert("계속 들어가는 값"+Number(sum[i]));*/
                }

            }

        }

        var menuPrice = 0;
        for (var i = 0; i < odMenuNameL.length; i++) {


            menuPrice += (sum[i] + odMenuPriceL[i]);


            divElemApply1 = "<div class=\"card mb-3\" >" +
                " <div class=\"row g-0\">" +
                "<div class=\"col-md-4\">" +
                "<img src=\"/resources/menu/"+odMenuImageL[i]+"\" class=\"img-fluid rounded-start\" alt=\"image\" style='height: 124px;'>" +
                "</div>" +
                "<div class=\"col-md-8\">" +
                "<div class=\"card-body\">" +
                "<h5 class=\"card-title\">" + odMenuNameL[i] + "</h5>" +
                "<p class=\"card-text\"><small class=\"text-muted font-size 12px\">옵션 " + odOptionGroupNameL[i] + " :" + odOptionNameL[i] + "  :</small><br><small class=\"text-muted\">수량 :" + odMenuQtyL[i] + " 가격 :" + (sum[i] + odMenuPriceL[i]) + " </small></p>" +
                "</div>" +
                "</div>" +
                "</div>" +
                "</div>"


            $('#order').append(divElemApply1);

        }

    });


    /*




                        <div class="card mb-3 h-10" style="width: 300px; height: 90px" >
                            <div class="row g-0">
                                <div class="col-md-4">
                                    <img src="/resources/image/1.jpg" class="img-fluid rounded-start" alt="image">
                                </div>
                                <div class="col-md-8">
                                    <div class="card-body">
                                        <h5 class="card-title">${cart.odMenuName}</h5>
                                        <p class="card-text"></p>
                                        <p class="card-text"><small class="text-muted">${cart.odMenuPrice + cart.odOptionPrice}</small></p>
                                    </div>
                                </div>
                            </div>
                        </div>


                                        <input type="hidden" id="odMenuName" name="odMenuName" value="${cart.odMenuName}"/>
                                    <input type="hidden" id="odOptionGroupName" name="odOptionGroupName" value="${cart.odOptionGroupName}"/>
                                    <input type="hidden" id="odOptionName" name="odOptionName" value="${cart.odOptionName}"/>
                                    <input type="hidden" id="odMenuQty" name="odMenuQty" value="${cart.odMenuQty}"/>
                                    <input type="hidden" id="odMenuPrice" name="odMenuPrice" value="${cart.odMenuPrice}"/>
                                    <input type="hidden" id="odOptionPrice" name="odOptionPrice" value="${cart.odOptionPrice}"/>
                                    <input type="hidden" id="odMenuImage" name="odMenuImage" value="${cart.odMenuImage}"/>



*/


</script>
</body>
</html>



