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

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">

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
                $("#cancelBusiStatChange").on("click", function () {
                    $('#busiStat').modal('hide');
                });
                $("#busiStatClose").on("click", function () {
                    $('#busiStat').modal('hide');
                });
                // $("button.btn-close").on("click", function () {
                //     $('#busiStat').modal('hide');
                // });


            });

            function fncUpdateBusiStat() {
                $('#busiStat').modal('show');
            }

            function fncUpdateBusiStatus() {

                var la =  $("input[name='la']").val();
                var lo = $("input[name='lo']").val();
                var truckId = '${sessionScope.truck.truckId}'
                var tb = '${truck.truckBusiStatus}'

                if (tb == '0'){
                    tb ='1';
                }else{
                    tb='0';
                }

                console.log("tb: "+tb)

                $.ajax({
                    type:"POST",
                    url: "/truck/json/updateBusiStatus",
                    data   : {
                        truckId : truckId,
                        la : la,
                        lo : lo,
                        tb : tb
                    },
                    success:function (data) {


                        alert ( " 현재 위치 및 영업 상태가 변경되었습니다. ");

                        $('#busiStat').modal('hide');
                    }
                });

            }
            $(document).ready(function(){

                var truckla = '${sessionScope.truck.truckMapLa}';
                var trucklo = '${sessionScope.truck.truckMapLo}';
                console.log("truckla : "+truckla)
                console.log("trucklo : "+trucklo)
                console.log("tb1 : "+'${truck.truckBusiStatus}')
                getAddr(truckla, trucklo);
                $("#busiStat").on('hide.bs.modal', function (e) {
                    window.location.reload();
                    e.stopImmediatePropagation();
                });
            });

        </script>
        <script type="text/javascript"
                src="//dapi.kakao.com/v2/maps/sdk.js?appkey=51615d81a030d0475e576eb41e443c14&libraries=services"></script>
    </head>


<body id="page-top">


<jsp:include page="/views/navbar.jsp"/>
<br/><br/><br/><br/>

<div class="container">
    <div class="row">
        <div class="col-lg-10 mx-auto"></div>
        <div class="page-header" style="text-align: center">
            <label for="page-top"/>
            <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
            <h4 style="margin-top: 10px;">영업 상태 변경</h4>
        </div>
        <br>

        <form class="form-horizontal"
              style="border-radius:10px ; border: 0; box-shadow: 0 2px 4px 0 rgba(0,0,0,0.2); transition: 0.3s;">
            <div class="row justify-content-between">
                <div class="col-12" style="margin-top:3px ">
                    <div class="form-check form-switch pull-right" style="font-size:22px ">
                        <c:if test="${sessionScope.truck.truckBusiStatus.equals('1')}">
                            <input class="form-check-input" type="checkbox" role="switch"
                                   id="swCh0" name="swCh0" data-bs-toggle="modal" data-bs-target="#staticBackdrop"
                                   checked>
                            <label class="form-check-label" for="swCh0"
                                   style="font-size:18px; margin-top:3px ">영업중</label>
                        </c:if>
                        <c:if test="${sessionScope.truck.truckBusiStatus.equals('0')}">
                            <input class="form-check-input" type="checkbox" role="switch"
                                   id="swCh1" name="swCh1" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                            <label class="form-check-label" for="swCh1"
                                   style="font-size:18px; margin-top:3px ">영업종료</label>
                        </c:if>
                        <input type="hidden" name="truckId" value="${sessionScope.truck.truckId}">
                    </div>
                </div>


<%--                <script>--%>

<%--                    $("#busiStatus").on("click", function () {--%>
<%--                        var truckId = $("input[name='truckId']").val();--%>
<%--                        var tb = $("input[name='swCh']:checked").val();--%>
<%--                        console.log(truckId);--%>
<%--                        console.log(tb);--%>

<%--                        if (tb == 'on') {--%>
<%--                            tb = 1;--%>
<%--                        } else if (tb == undefined) {--%>
<%--                            tb = 0;--%>
<%--                        }--%>

<%--                        $.ajax({--%>
<%--                            url        : "/truck/json/updateBusiStatus",--%>
<%--                            method     : "POST",--%>
<%--                            contentType: "application/x-www-form-urlencoded; charset=UTF-8",--%>
<%--                            data       : {--%>
<%--                                "truckId": truckId,--%>
<%--                                "tb"     : tb--%>
<%--                            },--%>
<%--                            success    : function (data) {--%>

<%--                                alert("영업상태가 변경되었습니다")--%>

<%--                                window.location.reload();--%>
<%--                            }--%>
<%--                        });--%>


<%--                    });--%>
<%--                </script>--%>
            </div>

            <!-- slider section -->
            <div class="detail-box" style="margin-bottom: -40px;">
                <h3 class="col-sm-6 offset-3" style="text-align: center">내 푸드트럭 위치설정</h3>
            </div>
            <br/>
            <br/>
            <div class="find_container ">
                <div class="container">
                    <div class="col-md-6 offset-3">
                        <form>
                            <div class="form-group col-md-6 offset-2">
                                <span class="location_icon"><i class="fa fa-crosshairs"></i></span>
                                <br/>
                                <input type="text" class="form-control" id="inputLocation"
                                       name="inputLocation" placeholder="좌측 상단의 마커를 클릭해주세요."
                                       value="${inputLocation}" style="width: 300px">
                            </div>
                            <div class="form-group col-md-6 offset-3" style="text-align: center">
                                <div class="btn-box">
                                    <button type="button" class="btn current-location">현재위치
                                        설정하기
                                    </button>
                                </div>
                            </div>
                            <input type="hidden" name="la" />
                            <input type="hidden" name="lo" />
                            <input type="hidden" name="address" />
                        </form>
                    </div>
                    <div id="map" name="map" style='width:100%;height:350px; margin-bottom:30px; border-radius:15px '></div>

                </div>
            </div>
        </form>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="busiStat" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
     aria-labelledby="busiStat" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="busiStatLabel">영업모드</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="busiStatClose"></button>
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
                <button type="button" class="btn btn-cancle" data-bs-dismiss="modal" id="cancelBusiStatChange">취소</button>
                <button type="button" class="btn btn-default" id="confirmOnModal">변경</button>
            </div>
        </div>
    </div>
</div>
<br>
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

<script src="../resources/bootstrap/js/custom.js"></script>
<script type="text/javascript">



    var userIdch = '${sessionScope.user.userId}';
    var truckIdch = '${sessionScope.truck.truckId}';
    console.log("userIdch: " + userIdch)
    console.log("truckIdch: " + truckIdch)
    $(function () {
        // 현재 위치 클릭하기
        $("body").on("click", ".current-location", function () {
            if (userIdch == '' && truckIdch == '') {
                loginModal()
            } else {
                findLocation();
            }
        });

        // 지도 클릭시 지도 화면 띄우기
        $("body").on("click", ".fa-crosshairs", function () {
            if (userIdch == '' && truckIdch == '') {
                loginModal()
            } else {
                mapLocationSelect()
            }

        });
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

    // 위도-> 주소 변환하여 소팅
    const getAddr = function (lat, lng) {
        let geocoder = new kakao.maps.services.Geocoder();

        let coord = new kakao.maps.LatLng(lat, lng);
        let callback = function (result, status) {
            if (status === kakao.maps.services.Status.OK) {
                // console.log(result[0].address.address_name);
                console.log(result[0].address.address_name)
                var address = result[0].address.address_name;
                $("input[name='inputLocation']").val(address);
                $("input[name='address']").val(address);
                $("input[name='la']").val(lat);
                $("input[name='lo']").val(lng);
                // todo: HHJ 주소창에 이거 뜨는거 뵈기시러.... post로 바꿔야할거같은디.....  깩 :::: 바까따~~~~~!
               // $("form").attr("method", "post").attr("action", "/truck/mainTruckListLaLo").attr("target", "_parent").submit();

                var mapContainer = document.getElementById('map'), // 지도를 표시할 div
                    mapOption = {
                        center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
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
                    console.log(latlng);

                    getAddr(lat, lng)



                });


                $("#map").css("display", "");

                // map.trigger('resize');


                // map 노출이 안되어서 강제로 setTimeout 주었엉...ㅎㅎ
                setTimeout(function () {
                    window.dispatchEvent(new Event('resize'));
                }, 300);



            }
        }
        geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
    }





</script>

</body>

</html>
