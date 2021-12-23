<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="euc-kr"%>


<!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="euc-kr">

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

</head>

<body>

<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">

    <div class="page-header">
        <h3 class=" text-info">트럭정보조회</h3>
        <h5 class="text-muted">내 트럭 정보를 <strong class="text-danger">최신정보로 관리</strong>해 주세요.</h5>
    </div>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>아 이 디</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckId}</div>
        <div class="col-xs-4 col-md-2"><strong>상 호</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckName}</div>
        <div class="col-xs-4 col-md-2"><strong>별 점</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckAVGStar}</div>
        <div class="col-xs-4 col-md-2"><strong>프 로 필 이 미 지</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckProImg}</div>
        <div class="col-xs-4 col-md-2"><strong>영 업 상 태</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckBusiStatus}</div>
        <div class="col-xs-4 col-md-2"><strong>전 화 번 호</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckPhone}</div>
        <div class="col-xs-4 col-md-2"><strong>위 도</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckMapLa}</div>
        <div class="col-xs-4 col-md-2"><strong>경 도</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckMapLo}</div>
        <div class="col-xs-4 col-md-2"><strong>공 지 내 용</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckNoticeContent}</div>
        <div class="col-xs-4 col-md-2"><strong>공 지 사 진</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckNoticeImg}</div>
    </div>

    <hr/>



</div>
<!--  화면구성 div Start /////////////////////////////////////-->

</body>

</html>