<%@ page import="com.ffin.service.domain.Catering" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <!-- Basic -->
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <!-- Mobile Metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <!-- Site Metas -->
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <title>F.FIN | FOODTRUCK FINDER</title>

    <!-- bootstrap core css -->
    <link rel="stylesheet" type="text/css" href="../../resources/bootstrap/css/bootstrap.css" />

    <!-- fonts style -->
    <link href="https://fonts.googleapis.com/css?family=Poppins:400,600,700&display=swap" rel="stylesheet">

    <!-- font awesome style -->
    <link href="../../resources/bootstrap/css/font-awesome.min.css" rel="stylesheet" />
    <!-- nice select -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" integrity="sha256-mLBIhmBvigTFWPSCtvdu6a76T+3Xyt+K571hupeFLg4=" crossorigin="anonymous" />
    <!-- slidck slider -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css" integrity="sha256-UK1EiopXIL+KVhfbFa8xrmAWPeBjMVdvYMYkTAEv/HI=" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css.map" integrity="undefined" crossorigin="anonymous" />


    <!-- Custom styles for this template -->
    <link href="../../resources/bootstrap/css/style.css" rel="stylesheet" />
    <!-- responsive style -->
    <link href="../../resources/bootstrap/css/responsive.css" rel="stylesheet" />

    <!--    Favicons-->
    <link rel="apple-touch-icon" sizes="180x180" href="../../resources/bootstrap/assets/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="../../resources/bootstrap/assets/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../../resources/bootstrap/assets/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="../../resources/bootstrap/assets/favicons/favicon.ico">
    <link rel="manifest" href="../../resources/bootstrap/assets/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="../../resources/bootstrap/assets/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">

    <!-- jQery -->
    <script src="../../resources/bootstrap/js/jquery-3.4.1.min.js"></script>
    <!-- bootstrap js -->
    <script src="../../resources/bootstrap/js/bootstrap.js"></script>
    <!-- slick  slider -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.js"></script>
    <!-- nice select -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js" integrity="sha256-Zr3vByTlMGQhvMfgkQ5BtWRSKBGa2QlspKYJnkjZTmo=" crossorigin="anonymous"></script>
    <!-- custom js -->
    <script src="../../resources/bootstrap/js/custom.js"></script>


    <%--주소API--%>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
    <link href='../../resources/fullcalendar/core/main.css' rel='stylesheet' />
    <link href='../../resources/fullcalendar/daygrid/main.css' rel='stylesheet' />
    <link href='../../resources/fullcalendar/timegrid/main.min.css' rel='stylesheet' />
    <script src='../../resources/fullcalendar/core/main.js'></script>
    <script src='../../resources/fullcalendar/daygrid/main.js'></script>
    <script src="../../resources/fullcalendar/interaction/main.min.js"></script>
    <script src="../../resources/fullcalendar/timegrid/main.min.js"></script>
    <script src='../../resources/fullcalendar/core/locales/ko.js'></script>

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=51615d81a030d0475e576eb41e443c14"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>


    <%
        List<Catering> list = (List<Catering>) request.getAttribute("list");
    %>





    <style>
        h4{
            color : #fd7622;
        }

        body{
            background-size: cover;
        }
        html, body {
            margin: 0;
            padding: 0;
            font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
            font-size: 14px;
        }

        #calendar-container {
            position: relative;
            z-index: 1;

        }

        #calendar {
            max-width: 900px;
            margin: 20px auto;
        }
        img{ max-width:100%;}
    </style>

</head>


<body id="page-top">
<jsp:include page="/views/toolbar.jsp" />

<div id="calendar-container">
    <div id="calendar"></div>
    <div><button>등록(사업자만)</button></div>
</div>

<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">서비스 상세정보</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"></span>
                </button>
            </div>
            <div class="modal-body"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-default" id="AddCtRes" name="AddCtRes">예약</button>
            </div>
        </div>
    </div>
</div>


<script>
    var role = '${sessionScope.role}';
    $(function() {
        var modal = $('#staticBackdrop');

        $("#staticBackdrop").on('hide.bs.modal', function (e) {
            self.location = "/catering/mainCalendar"
            e.stopImmediatePropagation();
        });

        $(".btn-default").on("click" , function() {
            /*
                사장님께 문자 고 고
             */

            //  var
            /* var ctUserName = modal.find("input[name='ctUserName']").val();
             var ctUserPhone = modal.find("input[name='ctUserPhone']").val();
             var ctUserAddr = modal.find("input[name='ctUserAddr']").val();
             var ctUserAddrDetail = modal.find("input[name='ctUserAddrDetail']").val();
             var ctMenuQty = modal.find("input[name='ctMenuQty']").val();
             var ctQuotation = modal.find("input[name='ctQuotation']").val();
             var ctStartTime = modal.find("input[name='ctStartTime']").val();
             var ctEndTime = modal.find("input[name='ctEndTime']").val();
             var ctUserRequest = modal.find("textarea[name='ctUserRequest']").val();*/

            //console.log(ctUserName + ":" + ctUserPhone + ":" +' ctUserAddr + ":" +ctUserAddrDetail + ":" +ctMenuQty + ":" +ctQuotation + ":" +ctStartTime + ":" +ctEndTime + ":" +ctUserRequest)

            $.ajax(
                {
                    url : "/catering/json/updateCtResAdd",
                    method : "POST",
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    data :{
                        ctNo : modal.find("input[name='ctNo']").val(),
                        ctUserId : modal.find("input[name='ctUserId']").val(),
                        ctUserPhone : modal.find("input[name='ctUserPhone']").val(),
                        ctUserAddr : modal.find("input[name='ctUserAddr']").val(),
                        ctUserAddrDetail : modal.find("input[name='ctUserAddrDetail']").val(),
                        ctMenuQty : modal.find("input[name='ctMenuQty']").val(),
                        ctQuotation : modal.find("input[name='ctQuotation']").val(),
                        ctStartTime : modal.find("input[name='ctStartTime']").val(),
                        ctEndTime : modal.find("input[name='ctEndTime']").val(),
                        ctUserRequest : modal.find("textarea[name='ctUserRequest']").val()
                    },
                    success : function(data)
                    {
                        //alert(data.reviewText)
                        alert(" 예약이 완료되었습니다. ")

                        $('#staticBackdrop').modal('hide');
                        window.location.reload();
                    }

                });//end ajax
        });


        var mapContainer = modal.find("div[name='map']"), // 지도를 표시할 div
            mapOption = {
                center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };

// 지도를 생성합니다
        var map = new kakao.maps.Map(mapContainer, mapOption);

// 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
        geocoder.addressSearch('제주특별자치도 제주시 첨단로 242', function(result, status) {

            // 정상적으로 검색이 완료됐으면
            if (status === kakao.maps.services.Status.OK) {

                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                // 결과값으로 받은 위치를 마커로 표시합니다
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });

                // 인포윈도우로 장소에 대한 설명을 표시합니다
                var infowindow = new kakao.maps.InfoWindow({
                    content: '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
                });
                infowindow.open(map, marker);

                // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                map.setCenter(coords);
            }
        });

    });






    var g_arg;
    document.addEventListener('DOMContentLoaded', function() {
        // alert("야호")
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            height: 600,
            plugins: [ 'interaction', 'dayGrid', 'timeGrid' ],
            dateClick : function (info) {

                /* 과거 못누르게 */
                let now = new Date();
                let check = moment(info.date).format('YYYY-MM-DD');
                let today = moment(now).format('YYYY-MM-DD');

                if(check < today)
                {
                    // 과거 일자
                }
                else
                {
                    if(role=="truck") {
                        addCateringService(today);
                    }
                }


            },
            eventClick: function(arg) {
                var statusCode = arg.event.extendedProps.ctStatusCode;
                /*
                   (예약가능, 초록)  statusCode = 0 : 서비스 상세보기
                          role = truck이면 수정/삭제 -> 완료 -> 수정/삭제 오께이
                          role = user면 예약 가능하도록 폼 띄우기 -> 완료 / 예약오께이
                   (예약,   보라 )  statuscode = 1 : 예약된 상태, 예약 상세 보기
                         role = user  - 이용자 취소 버튼 출력
                         role = truck - 수락/거절 버튼 출력
                   ( 수락 완료, 결제 필요 ) statuscode = 4 : 마찬가지로 예약 상세 보기
                         role = user - 결제 버튼 출력
                                truck - 수락 취소 버튼 출력 > statusCode = 1로 변경, 수락 메모 삭제
                   ( 예약 완료, 핑크 ) statuscode = 5
                         예약 상세 보기 (동일)
                 */

                if(statusCode =='0'){
                getCateringDetail(arg);
                 }else if(statusCode =='1'|| statusCode == '4' || statusCode == '5'){
                    getResDetail(arg);
                }

            },
            defaultView: 'dayGridMonth',
            defaultDate: new Date(),
            header: {
                left: 'prev,next',
                center: 'title',
                right: 'today'
            },
            eventLimit: true,
            eventLimitText: "more",
            eventLimitClick: "popover",
            editable: false,
            droppable: false,
            dayPopoverFormat: { year: 'numeric', month: 'long', day: 'numeric' },
            locale: 'ko',
            events: [
                <%
                       for (int i = 0; i < list.size(); i++) {
                     Catering ct = (Catering)list.get(i);

%>
                {
                    title : '<%= ct.getCtTruck().getTruckName() %>',
                    start : '<%= ct.getCtDate() %>',
                    end : '<%= ct.getCtDate() %>',
                    ctNo : '<%=ct.getCtNo()%>',
                    ctStatusCode : '<%=ct.getCtStatusCode()%>'
                    <% if (ct.getCtStatusCode().equals("5")){%>
                    , color: "#f81f59"
                    <%} else if (ct.getCtStatusCode().equals("0")){%>
                    , color: "#008d62"
                    <%}  else if (ct.getCtStatusCode().equals("1")){%>
                    , color: "#bcb5f3"
                    <%}  else if (ct.getCtStatusCode().equals("4")){%>
                    , color: "#fcab31"
                    <%}  else{%>
                    , color: "#868583"
                    <%} %>
                },
                <%
                    }
                %>
                {
                    title : 'default',
                    start : "2019-01-01",
                    end : "2019-01-01"
                }
            ]
            //events:function end
        });//new FullCalendar end

        calendar.render();

    });


    function addCateringService(today){

        /* 사업자의 서비스 등록을 하기 위한.. */
        let truckId = '${sessionScope.truck.truckId}';

        $.ajax({
            url:"/catering/json/addCt/"+truckId,
            method:"get",
            data:{
            },
            success: function (data) {
                // alert(data);
                //t.TRUCK_ID, t.TRUCK_NAME, t.TRUCK_PHONE, m.IS_SIG_MENU, m.MENU_IMG1, m.MENU_NO, m.MENU_NAME, m.MENU_PRICE

                var div="";
                // var role = '${sessionScope.role}';
                var modalFooter = "";

                <%--${sessionScope.role};--%>

                div += "<div class='row'>"
                    + "<div><strong>푸드트럭 이름</strong> : "+data.catering.ctTruck.truckName+"</div>" +
                    "</div>"
                    +"<div class='row'>"
                    +"<div ><strong>서비스 가능 날짜</strong> : "+today+"</div></div>"
                    +"<div class='row'>"
                    +"<div ><strong>메뉴</strong> : "+data.catering.ctMenu.menuName+"</div></div>"
                    +"<div class='row'>"
                    +"<div ><strong></strong> <img src='../../../resources/image/"+data.catering.ctMenu.menuImg1+"'></div></div>"
                    +"<div class='row'>"
                    +"<div ><strong>가격(1개)</strong> : "+data.catering.ctMenu.menuPrice+"원</div></div>"
                    +"<div class='row'>"
                    +"<div ><strong>최소 수량</strong> : <input type='text' id='servMenuMinQty' name='servMenuMinQty'  /></div></div>"
                    +"<div class='row'>"
                    +"<div ><strong>최대 수량</strong> : <input type='text' id='servMenuMaxQty' name='servMenuMaxQty' /></div></div>"
                   +"<input type='text' id='menuNo' name='menuNo' value='"+data.catering.ctMenu.menuNo+"'/>"
                   +"<input type='hidden' id='ctDate' name='ctDate' value='"+today+"'/>";

                modalFooter += "<div class='modal-footer'>"
                    +"<button type='button' class='btn btn-outline-info' id='addCtServ' name='addCtServ' onclick='addCtServ();'>서비스 등록</button>"
                    +"<button type='button' class='btn btn-secondary' data-dismiss='modal'>Close</button></button>"
                    +"</div>";

                $('.modal-footer').remove();
                $('.modal-content').append(modalFooter);
                $('.modal-body').html(div);
                $('#staticBackdrop').modal('show');
            },
            error : function(err){
                console.log('에러')
            }
        });//end ajax

    }

    function getCateringDetail(arg) {
        /* statusCode == 0 */
        g_arg = arg;
        var ctNo = arg.event.extendedProps.ctNo;
        console.log(ctNo);
        $.ajax({
            url:"/catering/json/getCtDetail/"+ctNo,
            method:"get",
            data:{
            },
            success: function (data) {
                // alert(data);
                console.log("data : "+data.catering.ctTruck.truckId)
                var div="";
               // var role = '${sessionScope.role}';
                var modalFooter = "";

                <%--${sessionScope.role};--%>
                console.log("role : "+role)
                div += "<div class='row'>"+
                    "<div><strong>서비스 번호</strong> : "+data.catering.ctNo+"</div></div>" +
                    "<div class='row'>"
                    + "<div><strong>푸드트럭 이름</strong> : "+data.catering.ctTruck.truckName+"</div>" +
                    "</div>"
                    +"<div class='row'>"
                    +"<div ><strong>서비스 가능 날짜</strong> : "+data.catering.ctDate+"</div></div>"
                    +"<div class='row'>"
                    +"<div ><strong>메뉴</strong> : "+data.catering.ctMenu.menuName+"</div></div>"
                    +"<div class='row'>"
                    +"<div ><strong></strong> <img src='../../../resources/image/"+data.catering.ctMenu.menuImg1+"'></div></div>"
                    +"<div class='row'>"
                    +"<div ><strong>가격(1개)</strong> : "+data.catering.ctMenu.menuPrice+"원</div></div>"
                    +"<input type='hidden' id='ctNo' name='ctNo' value='"+data.catering.ctNo+"'/>"
                if (role=="user") {
                    div +=
                        "<div class='row'>"
                        +"<div ><strong>최소 수량</strong> : "+data.catering.ctMenuMinQty+"</div></div>"
                        +"<div class='row'>"
                        +"<div ><strong>최대 수량</strong> : "+data.catering.ctMenuMaxQty+"</div></div>"
                        +"<div class='row'>"
                        +"<div ><strong>예약자 아이디</strong> : <input type='text' id='ctUserId' name='ctUserId'/></div></div>"
                        +"<div class='row'>"
                        +"<div ><strong>예약자 전화번호</strong> : <input type='text' id='ctUserPhone' name='ctUserPhone'/></div></div>"
                        +"<div class='row'>"
                        +"<div ><strong>예약자 주소</strong> : " +
                        "<input type='text'  id='ctUserAddr' name='ctUserAddr' placeholder='주소검색' readonly='readonly'></div>" +
                        "<button type='button' onclick='addrApi()'>주소검색</button></div>"
                        +"<div class='row'>"
                        +"<div ><strong>예약자 상세 주소</strong> : <input type='text' id='ctUserAddrDetail' name='ctUserAddrDetail' placeholder='상세주소를 입력해주세요' readonly='readonly'>	</div></div>"
                        +"<div class='row'>"
                        +"<div ><strong>필요 수량</strong> : <input type='text' id='ctMenuQty' name='ctMenuQty'/></div></div>"
                        +"<div class='row'>"
                        +"<div ><strong>예상 견적</strong> : <input type='text' id='ctQuotation' name='ctQuotation'/></div></div>"
                        // 예상견적 자동 계산되도록 하자
                        // input data 값 더 깔끔하게 수정
                        +"<div class='row'>"
                        +"<div><strong>시작 시간</strong> : <input type='text' id='ctStartTime' name='ctStartTime'/></div></div>"
                        +"<div class='row'>"
                        +"<div><strong>종료 시간</strong> : <input type='text' id='ctEndTime' name='ctEndTime'/></div></div>"
                        +"<div class='row'>"
                        +"<div><strong>요청 사항</strong> : <textarea name='ctUserRequest' rows='3'></textarea></div></div>"
                        + "</div><hr/>";
                }else if (role=="truck"){
                    div += "<div class='row'>"
                        +"<div ><strong>최소 수량</strong> : <input type='text' id='ctMenuMinQty' name='ctMenuMinQty' value='"+data.catering.ctMenuMinQty+"' /></div></div>"
                        +"<div class='row'>"
                        +"<div ><strong>최대 수량</strong> : <input type='text' id='ctMenuMaxQty' name='ctMenuMaxQty' value='"+data.catering.ctMenuMaxQty+"' /></div></div>";

                    $('.modal-footer').remove();


                    modalFooter += "<div class='modal-footer'>"
                    +"<button type='button' class='btn btn-outline-info' id='updateCtServ' name='updateCtServ' onclick='updateCtServ();'>서비스 수정</button>"
                    +"<button type='button' class='btn btn-outline-danger' id='deleteCtServ' name='deleteCtServ' onclick='deleteCtServ();'>서비스 삭제</button>"
                    +"</div>";
                    $('.modal-content').append(modalFooter);
                }
                $('.modal-body').html(div);
                $('#staticBackdrop').modal('show');

            },
            error : function(err){
                console.log('에러')
            }
        });

    }

    /*
     예약 상세
     기본적으로는 아래 footer 부분 제외하고는 다 똑같이 가도 될듯.
     이용자는 수정은 못함 취소만 가능함


      (예약,   보라 )  statuscode = 1 : 예약된 상태, 예약 상세 보기
                         role = user  - 이용자 취소 버튼 출력
                         role = truck - 수락/거절 버튼 출력
                   ( 수락 완료, 결제 필요 ) statuscode = 4 : 마찬가지로 예약 상세 보기
                         role = user - 결제 버튼 출력
                         truck - 수락 취소 버튼 출력 > statusCode = 1로 변경, 수락 메모 삭제
                   ( 예약 완료, 핑크 ) statuscode = 5
                         예약 상세 보기 (동일)
    */
    function getResDetail(arg) {
        /* statusCode == 0 */
        g_arg = arg;
        var ctNo = arg.event.extendedProps.ctNo;
        var statusCode = arg.event.extendedProps.ctStatusCode;

        console.log(ctNo);
        $.ajax({
            url:"/catering/json/getResDetail/"+ctNo,
            method:"get",
            data:{
            },
            success: function (data) {
                // alert(data);
                console.log("data : "+data.catering.ctTruck.truckId)
                var div="";
               // var role = '${sessionScope.role}';
                var modalFooter = "";

                <%--${sessionScope.role};--%>
                console.log("role : "+role)
                div += "<div class='row'>"+
                    "<div><strong>서비스 번호</strong> : "+data.catering.ctNo+"</div></div>" +
                    "<div class='row'>"
                    + "<div><strong>이용자 이름</strong> : "+data.catering.ctUser.userName+"</div></div>"
                    +"<div class='row'>"
                     + "<div><strong>이용자 전화번호</strong> : "+data.catering.ctPhone+"</div></div>"
                    +"<div class='row'>"
                    + "<div><strong>푸드트럭 이름</strong> : "+data.catering.ctTruck.truckName+"</div></div>"
                    +"<div class='row'>"
                    +"<div ><strong>예약 날짜</strong> : "+data.catering.ctDate+"</div></div>"
                    +"<div class='row'>"
                    +"<div ><strong>시작 시간</strong> : "+data.catering.ctStartTime+"</div></div>"
                    +"<div class='row'>"
                    +"<div ><strong>종료 시간</strong> : "+data.catering.ctEndTime+"</div></div>"
                    +"<div class='row'>"
                    +"<div ><strong>주소</strong> : "+data.catering.ctAdd+" "+data.catering.ctAddDetail+"</div></div>"
                    +"<div class='row'>"
                    +"<div id ='map' style='width:100%;height:350px;'>"
                    +"</div></div>"
                    +"<div class='row'>"
                    +"<div ><strong>메뉴</strong> : "+data.catering.ctMenu.menuName+"</div></div>"
                    +"<div class='row'>"
                    +"<div ><strong></strong> <img src='../../../resources/image/"+data.catering.ctMenu.menuImg1+"'></div></div>"
                    +"<div class='row'>"
                    +"<div ><strong>가격(1개)</strong> : "+data.catering.ctMenu.menuPrice+"원</div></div>"
                    +"<div class='row'>"
                    +"<div ><strong>필요 수량</strong> : "+data.catering.ctMenuQty+"</div></div>"
                    +"<div class='row'>"
                    +"<div ><strong>요청사항</strong> : "+data.catering.ctUserRequest+"</div></div>"
                    +"<div class='row'>"
                    +"<div ><strong>견적</strong> : "+data.catering.ctQuotation+"</div></div>"
                    +"<input type='hidden' id='ctNo' name='ctNo' value='"+data.catering.ctNo+"'/>";

                if (statusCode == '1') {
                    /* 이용자: 취소가능 , 사업자: 수락 or 거절 */
                    if (role=="user") { // '취소'버튼, '확인'버튼
                        modalFooter += "<div class='modal-footer'>"
                            +"<button type='button' class='btn btn-outline-danger' id='resCancel' name='resCancel' onclick='updateCtResCancel(2);'>예약 취소</button>"
                            +"<button type='button' class='btn btn-secondary' data-dismiss='modal'>Close</button></button>"
                            +"</div>";
                    }else{
                        modalFooter += "<div class='modal-footer'>"
                            +"<button type='button' class='btn btn-outline-success' id='resAccept' name='resAccept' onclick='updateCtResCancel(4);'>수락</button>"
                            +"<button type='button' class='btn btn-outline-danger' id='resReject' name='resReject' onclick='updateCtResCancel(3);'>거절</button>"
                            +"</div>";
                    }

                }else if (statusCode == '4'){
                    /*
                    role = user - 결제 버튼 출력
                         truck - 수락 취소 버튼 출력 > statusCode = 1로 변경
                     */
                    if (role=="user") { // '취소'버튼, '확인'버튼
                        modalFooter += "<div class='modal-footer'>"
                            +"<button type='button' class='btn btn-outline-danger' id='resCancel' name='resCancel' onclick=''>결제</button>"
                            +"<button type='button' class='btn btn-secondary' data-dismiss='modal'>Close</button></button>"
                            +"</div>";
                    }else{
                        modalFooter += "<div class='modal-footer'>"
                            +"<button type='button' class='btn btn-outline-success' id='resAccept' name='resAccept' onclick='updateCtResCancel(1);'>수락 취소</button>"
                            +"<button type='button' class='btn btn-secondary' data-dismiss='modal'>Close</button></button>"
                            +"</div>";
                    }


                }else if (statusCode =='5'){
                    /*
                     ( 예약 완료, 핑크 ) statuscode = 5
                         예약 상세 보기 (동일)

                         예약정보 불러오기?
                         아니면 1대1연락하기? 이런건 좀 고민해보기!!!!
                     */
                    modalFooter += "<div class='modal-footer'>"
                        +"<button type='button' class='btn btn-secondary' data-dismiss='modal'>Close</button></button>"
                        +"</div>";
                }

                $('.modal-footer').remove();
                $('.modal-content').append(modalFooter);
                $('.modal-body').html(div);
                $('#staticBackdrop').modal('show');

            },
            error : function(err){
                console.log('에러')
            }
        });

    }
    /* 이용자 취소(2), 사업자 취소(3) */
    function updateCtResCancel(statusCode){
        var modal = $('#staticBackdrop');

        $.ajax(
            {
                url : "/catering/json/updateCtResCancel",
                method : "POST",
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                data :{
                    ctNo : modal.find("input[name='ctNo']").val(),
                    ctStatusCode : statusCode
                },
                success : function(data)
                {
                    //alert(data.reviewText)
                    alert(" 취소되었습니다. ")
                    $('#staticBackdrop').modal('hide');
                    window.location.reload();
                }

            });//end ajax
    }

    /* 서비스 등록 */
    function addCtServ(){
        var modal = $('#staticBackdrop');

        $.ajax(
            {
                url : "/catering/json/addCtServ",
                method : "POST",
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                data :{
                    menuNo : modal.find("input[name='menuNo']").val(),
                    ctDate : modal.find("input[name='ctDate']").val(),
                    ctMenuMinQty : modal.find("input[name='ctMenuMinQty']").val(),
                    ctMenuMaxQty : modal.find("input[name='ctMenuMaxQty']").val()
                },
                success : function(data)
                {
                    //alert(data.reviewText)
                    alert(" 등록되었습니다. ")
                    $('#staticBackdrop').modal('hide');
                    window.location.reload();
                }

            });//end ajax
    }

    /* 서비스 수정, role=truck, statusCode=0 */
    function updateCtServ(){
        var modal = $('#staticBackdrop');

        $.ajax(
            {
                url : "/catering/json/updateCtMenuQty",
                method : "POST",
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                data :{
                    ctNo : modal.find("input[name='ctNo']").val(),
                    ctMenuMinQty : modal.find("input[name='ctMenuMinQty']").val(),
                    ctMenuMaxQty : modal.find("input[name='ctMenuMaxQty']").val()
                },
                success : function(data)
                {
                    //alert(data.reviewText)
                    alert(" 수정되었습니다. ")
                    $('#staticBackdrop').modal('hide');
                    window.location.reload();
                }

            });//end ajax
    }

    /* 서비스 삭제, role=truck, statusCode=0
    * flag를 두려다가 그냥 resStatusCode=6으로 사용하려 함
    * 걍 삭제해버리까.....
    * */
    function deleteCtServ(){
        var modal = $('#staticBackdrop');

        $.ajax(
            {
                url : "/catering/json/updateCtServDelete",
                method : "POST",
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                data :{
                    ctNo : modal.find("input[name='ctNo']").val()
                },
                success : function(data)
                {
                    //alert(data.reviewText)
                    alert(" 삭제되었습니다. ")
                    $('#staticBackdrop').modal('hide');
                    window.location.reload();
                }

            });//end ajax
    }


    /* Daum API */
    function addrApi(){
        new daum.Postcode({
            oncomplete: function(data) {

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    // document.getElementById("sample6_extraAddress").value = extraAddr;
                    addr += extraAddr;
                } else {
                    // document.getElementById("sample6_extraAddress").value = '';
                    addr = '';
                }

                console.log(addr);
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                // document.getElementById('ctUserAddr').value = data.zonecode;

                //$(".userAddr").val(data.zonecode);
                // 커서를 상세주소 필드로 이동한다.
                // document.getElementById("sample6_detailAddress").focus();

                $("input:text[name=ctUserAddr]").val(addr);
                $("input:text[name=ctUserAddrDetail]").attr("readonly", false);
                $("input:text[name=ctUserAddrDetail]").focus();
            }
        }).open();
    }





</script>

<jsp:include page="/views/footer.jsp" />

</body>
</html>