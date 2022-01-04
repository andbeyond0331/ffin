<%@ page import="com.ffin.service.domain.Catering" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

    <%--주소API--%>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>



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
        .allCT{
            background-color : #ced4da;
        }

        .cards-box {
            display: flex;
            justify-content: flex-start;
            margin: 0 70px;
            margin-top: 65px;
            flex-wrap: wrap;

        }
        .container{
            margin-top: 132px
        }

    </style>

</head>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=51615d81a030d0475e576eb41e443c14&libraries=services"></script>

<body id="page-top">
<jsp:include page="/views/navbar.jsp" />

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
            <div id="map" style='width:100%;height:350px; display:none;'></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-default" id="AddCtRes" name="AddCtRes">예약</button>
            </div>
        </div>
    </div>
</div>
<script>
    var role = '${sessionScope.role}';
    function fncGetCateringList(currentPage) {
        //document.getElementById("currentPage").value = currentPage;
        $("#currentPage").val(currentPage)
        $("#flag").val("0")
        $("form").attr("method" , "POST").attr("action" , "/catering/listCatering").submit();
    }
    function fncGetCtStatusList(currentPage, ctStatusCode) {
        //document.getElementById("currentPage").value = currentPage;
        $("#currentPage").val(currentPage)
        $("#ctStatusCode").val(ctStatusCode)
        $("#cate").val("list");
        $("#flag").val("1")
        $("form").attr("method" , "POST").attr("action" , "/catering/getCtStatusList?ctStatusCode="+ctStatusCode+"&cate=list").submit();
    }
    function fncGetCtServAllList(currentPage) {
        //document.getElementById("currentPage").value = currentPage;
        $("#currentPage").val(currentPage)
        $("#cate").val("list");
        $("#flag").val("2")
        $("form").attr("method" , "POST").attr("action" , "/catering/getCtServAllList?cate=list").submit();
    }
    let isEnd = false;
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

            var isBottom =  (window.innerHeight + window.scrollY) >= document.body.offsetHeight;


            if (isBottom) {
                if(isEnd===true || isEnd){
                    return;
                }
                isEnd = true;
                page++;
                loadList();
            }
        })
       // loadList();




    var loadList = function(){
       /* if(isEnd === true){
            return;
        }*/

        $.ajax({

            url : "/catering/json/listCatering",
            method : "POST",
            dataType : "json",
            data : { currentPage : page,
                ctStatusCode : $("input[name='ctStatusCode']").val(),
                cate : "list",
                flag : $("input[name='flag']").val()
            },

            //contentType:"application/json;charset=UTF-8",
            contentType: "application/x-www-form-urlencoded;",
            success : function(jsonData) {

               // page++;
                var list = jsonData.list;
                console.log("list: "+list)
                let length = list.length;

                console.log("length: "+length)



                for(var i=0; i<list.length; i++){
                    var div="";



                    div +=  "<div class='card' style='width: 23rem; margin-bottom:15px; margin-left: 10px;'>"
                +"<img class='card-img-top' src='../../resources/image/"+list[i].ctMenu.menuImg1+"' alt='Card image cap' style='border-bottom: 1px solid #eee; height: 300px;'>"
                +"<div class='card-body'>"
                    +"<ul class='card-body-ul'>";

                    if ( roleUT == 'user'){
                        div += "<li> 푸드트럭 상호명 :"+list[i].ctTruck.truckName+"</li>";
                    }else{
                        div += "<li> 이용자 이름 :"+list[i].ctUser.userName+"</li>";
                    }
                     div += " <li> 서비스 날짜 : "+list[i].ctDate+"</li>"
                         +" <li> 견적 : "+list[i].ctQuotation+"</li>";
                    if(list[i].ctStatusCode == "0"){
                        div += "<li> 상태코드 : 예약가능</li>";
                    }else if(list[i].ctStatusCode == "1"){
                        div += "<li> 상태코드 : 수락 대기</li>";
                    }else if(list[i].ctStatusCode == "2"){
                        div += "<li> 상태코드 : 이용자 취소</li>";
                    }else if(list[i].ctStatusCode == "3"){
                        div += "<li> 상태코드 : 사업자 거절</li>";
                    }else if(list[i].ctStatusCode == "4"){
                        div += "<li> 상태코드 : 결제 대기</li>";
                    }else {
                        div += "<li> 상태코드 : 예약 완료</li>";
                    }
                    div += "</ul>"
                    +"<div class='btn-detail'>"
                       + "<input type='hidden' id='ctNo' name='ctNo' value='"+list[i].ctNo+"'/>"
                    + "<input type='hidden' id='statusCode' name='statusCode' value='"+list[i].ctStatusCode+"'/>";

                    if(list[i].ctStatusCode == "0") {
                        div += " <button id ='getCateringDetail' name='getCateringDetail' class='button is-warning is-light'"
                            + "style='margin-left: 100px; margin-bottom: 13px; height: 25px'"
                            + "onclick='getCateringDetail(" + list[i].ctNo + ")'>자세히 "
                            + "</button>";
                    }else{
                        div += " <button id ='getResDetail' name='getResDetail' class='button is-warning is-light'"
                            + "style='margin-left: 100px; margin-bottom: 13px; height: 25px'"
                            + "onclick='getResDetail(" + list[i].ctNo + ", "+list[i].ctStatusCode+")'>자세히 "
                            + "</button>";
                    }

                    div += "</div></div> </div>";


                    $('.cards-box').append(div);
                    if( length < 6 ){
                        isEnd = true;
                        // return;
                    }

                }



            },

            error : function() {

                alert("1에러가 발생하였습니다.")

            },

        });


    }



    $(function() {
        var modal = $('#staticBackdrop');

        $("#staticBackdrop").on('hide.bs.modal', function (e) {
           // self.location = "/catering/listCatering"
           window.location.reload();
            e.stopImmediatePropagation();
        });



        $(".btn-default").on("click", function () {
            /*
                사장님께 문자 고 고
             */


            $.ajax(
                {
                    url: "/catering/json/updateCtResAdd",
                    method: "POST",
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    data: {
                        ctNo: modal.find("input[name='ctNo']").val(),
                        ctUserId: '${sessionScope.user.userId}',
                        ctUserName: '${sessionScope.user.userName}',
                        ctUserPhone: modal.find("input[name='ctUserPhone']").val(),
                        ctUserAddr: modal.find("input[name='ctUserAddr']").val(),
                        ctUserAddrDetail: modal.find("input[name='ctUserAddrDetail']").val(),
                        ctMenuQty: modal.find("input[name='ctMenuQty']").val(),
                        ctQuotation: modal.find("input[name='ctQuotation']").val(),
                        ctStartTime: modal.find("input[name='ctStartTime']").val(),
                        ctEndTime: modal.find("input[name='ctEndTime']").val(),
                        ctUserRequest: modal.find("textarea[name='ctUserRequest']").val()
                    },
                    success: function (data) {
                        //alert(data.reviewText)
                        alert(" 예약이 완료되었습니다. ")

                        $('#staticBackdrop').modal('hide');
                        window.location.reload();
                    }

                });//end ajax
        });

    });

    function lookMap(){
        var modal = $('#staticBackdrop');


        /* 지도 */
        var address =modal.find("input[name='ctAdd']").val()+" "+modal.find("input[name='ctAddDetail']").val();
        console.log("address: "+address)
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
            mapOption = {
                center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };

// 지도를 생성합니다
        var map = new kakao.maps.Map(mapContainer, mapOption);

// 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
        geocoder.addressSearch(address, function(result, status) {

            // 정상적으로 검색이 완료됐으면
            if (status === kakao.maps.services.Status.OK) {

                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                // 결과값으로 받은 위치를 마커로 표시합니다
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });



                // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                map.setCenter(coords);
            }


        });

        $("#map").css("display","");
        map.relayout();

    }




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
                    ctMenuMinQty : modal.find("input[name='servMenuMinQty']").val(),
                    ctMenuMaxQty : modal.find("input[name='servMenuMaxQty']").val()
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

        var element_wrap = document.getElementById("wrap");

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

    $( function() {
        $( "input[value='전체']" ).on("click" , function() {

            fncGetCateringList('1');
        });

        $( "input[value='예약가능']" ).on("click" , function() {
            fncGetCtServAllList('1');
        });

        $( "input[value='수락대기']" ).on("click" , function() {
            fncGetCtStatusList('1', '1');
        });

        $( "input[value='수락완료(결제대기)']" ).on("click" , function() {
            fncGetCtStatusList('1', '4');
        });

        $( "input[value='예약완료']" ).on("click" , function() {
            fncGetCtStatusList('1', '5');
        });

        $( "input[value='취소 및 거절']" ).on("click" , function() {
            fncGetCtStatusList('1', '2');
        });

    });


</script>

<div class="card-colums" id="all_posting">
    <div class="container">

        <div class="detail-box" >
            <h4 style="margin-top: 10px; align: center">
                예약목록조회
            </h4>
            <a href="/catering/getCtServAllList?cate=list">예약가능 서비스 조회</a>
            <input type="text" id="ctStatusCode" name="ctStatusCode" value="${ctStatusCode}"/>
            <input type="text" id="currentPage" name="currentPage" value=""/>
            <input type="text" id="cate" name="cate" value="list"/>
            <input type="text" id="flag" name="flag" value="${flag}"/>
        </div>
        <form name="detailForm">
    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
    <div class="row">

        <div class="col-md-6 text-left">
            <div id="calStatus">
                <input type="button" value="전체"/>
                <input type="button" value="예약가능"/>
                <input type="button" value="수락대기"/>
                <input type="button" value="수락완료(결제대기)"/>
                <input type="button" value="예약완료"/>
                <input type="button" value="취소 및 거절"/>
                <!-- 여기 수정
                <a href="/catering/listCatering"> 전체 </a>
                <a href="/catering/getCtServAllList?cate=list" style=" background-color : #008d62;"> 예약가능 </a>
                <a href="/catering/getCtStatusList?ctStatusCode=1&cate=list" style=" background-color : #bcb5f3;"> 수락대기 </a>
                <a href="/catering/getCtStatusList?ctStatusCode=4&cate=list" style=" background-color : #fcab31;"> 수락완료(결제대기) </a>
                <a href="/catering/getCtStatusList?ctStatusCode=5&cate=list" style=" background-color : #f81f59;"> 예약완료 </a>
                <a href="/catering/getCtStatusList?ctStatusCode=2&cate=list" style=" background-color : #f81f59;"> 취소 및 거절 </a>-->
            </div>
        </div>

    </div>
    <div id="card-box" class="cards-box">
        <c:forEach var="catering" items="${list}">
            <div class="card" style="width: 23rem; margin-bottom:15px; margin-left: 10px;">
                <img class="card-img-top" src="../../resources/image/${catering.ctMenu.menuImg1}" alt="Card image cap"
                     style="border-bottom: 1px solid #eee; height: 300px;">
                <div class="card-body">
                    <ul class='card-body-ul'>

                        <c:if test="${sessionScope.role eq 'user'}">
                        <li> 푸드트럭 상호명 :${catering.ctTruck.truckName}</li>
                        </c:if>
                        <c:if test="${sessionScope.role eq 'truck'}">
                            <li> 이용자 이름 :${catering.ctUser.userName}</li>
                        </c:if>
                        <li> 서비스 날짜 : ${catering.ctDate}</li>
                        <li> 견적 : ${catering.ctQuotation}</li>
                        <li> 상태코드 :
                        <c:if test="${catering.ctStatusCode eq '0'}">예약가능</c:if>
                        <c:if test="${catering.ctStatusCode eq '1'}">수락 대기</c:if>
                        <c:if test="${catering.ctStatusCode eq '2'}">이용자 취소</c:if>
                        <c:if test="${catering.ctStatusCode eq '3'}">사업자 거절</c:if>
                        <c:if test="${catering.ctStatusCode eq '4'}">결제 대기</c:if>
                        <c:if test="${catering.ctStatusCode eq '5'}">예약 완료</c:if>
                        </li>
                    </ul>
                    <div class="btn-detail">
                        <input type="hidden" id="ctNo" name="ctNo" value="${catering.ctNo}"/>
                        <input type="hidden" id="statusCode" name="statusCode" value="${catering.ctStatusCode}"/>
                        <c:if test="${catering.ctStatusCode eq '0'}">

                            <button id ="getCateringDetail" name="getCateringDetail" class="button is-warning is-light"
                                    style='margin-left: 100px; margin-bottom: 13px; height: 25px'
                                    onclick="getCateringDetail(${catering.ctNo})">자세히
                            </button>
                        </c:if>
                        <c:if test="${catering.ctStatusCode ne '0'}">


                            <button id ="getResDetail" name="getResDetail" class="button is-warning is-light"
                                    style='margin-left: 100px; margin-bottom: 13px; height: 25px' onclick="getResDetail(${catering.ctNo},${catering.ctStatusCode})">자세히
                            </button>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
        </form>

</div>
</div>
<script>

    //$("#getCateringDetail").on("click", function () {
    function getCateringDetail(ctNo) {
        /* statusCode == 0 */
       // var ctNo= $(this).parent().find("input[name='ctNo']").val()
        console.log("ctNo : "+ctNo);
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
                        +"<div ><strong>예약자 아이디</strong> : "+'${sessionScope.user.userId}'+"</div></div>"
                        +"<div class='row'>"
                        +"<div ><strong>예약자 전화번호</strong> : <input type='text' id='ctUserPhone' name='ctUserPhone' value="+'${sessionScope.user.userPhone}'+"></div></div>"
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


    //$("#getResDetail").on("click", function () {

    function getResDetail(ctNo, statusCode) {
        /* statusCode == 0 */
       // var ctNo= $(this).parent().find("input[name='ctNo']").val()
       // var statusCode =  $(this).parent().find("input[name='statusCode']").val()

        //  function getResDetail(ctNo, statusCode) {


        console.log("ctno L " + ctNo);
        console.log("code::: " + statusCode);
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
                    +"<div class='row'>"
                    +"<div ><strong>주소</strong> : "+data.catering.ctAdd+" "+data.catering.ctAddDetail+"</div><button type='button' class='btn btn-outline-danger' id='lookMap' name='lookMap' onclick='lookMap();'>지도가 궁금행?</button></div>"

                    +"<input type='hidden' id='ctNo' name='ctNo' value='"+data.catering.ctNo+"'/>"
                    +"<input type='hidden' id='ctAdd' name='ctAdd' value='"+data.catering.ctAdd+"'/>"
                    +"<input type='hidden' id='ctAddDetail' name='ctAddDetail' value='"+data.catering.ctAddDetail+"'/>";




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
                            +"<button type='button' class='btn btn-outline-danger' id='purchaseRes' name='purchaseRes' onclick=purchaseRes()''>결제</button>"
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
                }else {
                    modalFooter+=  "<div class='modal-footer'>"
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
</script>
<%--
<jsp:include page="/views/footer.jsp" />
--%>

</body>
</html>