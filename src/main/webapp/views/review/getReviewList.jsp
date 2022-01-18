<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">


<head>

    <c:if test="${truckId ne null}">
        <title>F.FIN | 푸드트럭 리뷰목록 </title>
    </c:if>
    <c:if test="${userId ne null}">
        <title>F.FIN | 이용자 리뷰목록 </title>
    </c:if>

    <jsp:include page="../../common/lib.jsp"/>

    <!-- bootstrap core css -->
    <link rel="stylesheet" type="text/css" href="../../resources/bootstrap/css/bootstrap.css" />
    <!-- Custom styles for this template -->
    <link href="../../resources/bootstrap/css/style.css" rel="stylesheet" />

    <!--    Favicons-->
    <link rel="apple-touch-icon" sizes="180x180" href="../../resources/bootstrap/assets/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="../../resources/bootstrap/assets/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../../resources/bootstrap/assets/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="../../resources/bootstrap/assets/favicons/favicon.ico">
    <link rel="manifest" href="../../resources/bootstrap/assets/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="../../resources/bootstrap/assets/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">

    <style>

        .search{
            margin-top: 100px;
        }

        #dataTable thead tr th, #dataTable tbody tr td{
            text-align: center;
        }

        #dataTable tbody tr:hover{
            color: #ffba49;
        }

        .form-inline{
            float: right;
            padding-right: 20px;
        }
        .card.mb-10{
            width: auto;
            min-height: 50px;
            box-shadow: 0 1px 2px 1px rgba(0,0,0,0.1);
            transition: 0.2s;
            margin-top: 5px;
            display: flex;
            justify-content: center;
            font-size: 16px;
        }
        .card.mb-10:hover{
            background-color: rgba(255, 229, 55, 0.16);
        }
        .card-ans{
            box-shadow: 0 1px 2px 1px rgba(0,0,0,0.2);
            transition: 0.2s;
            margin-top: 5px;
            /*display: flex;
            justify-content: flex-start;*/
            text-align: left;
            font-size: 14px;
            padding: 30px;
        }
        .card-body {
            padding: 0;
        }
        .card-text{
            padding: 0;
        }
        .inquiry-card{
            display: flex;
            justify-content: space-around;
        }
        .inquiry-con{
            padding: 0;
        }
        .d-grid.gap-2.col-6.mx-auto{
            display: flex;
            justify-content: center;
        }
        #inquiryAnsContent{
            min-height: 150px;
        }
    </style>


    <%--리뷰 css--%>
    <style>

        *{
            margin: 0px;
            padding: 0px;
            font-family: poppins;
            box-sizing: border-box;
        }
        a{
            text-decoration: none;
        }
        #testimonials{
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            width:100%;
        }
        .testimonial-heading{
            letter-spacing: 1px;
            margin: 30px 0px;
            padding: 10px 20px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .testimonial-heading span{
            font-size: 1.3rem;
            color: #252525;
            margin-bottom: 10px;
            letter-spacing: 2px;
            text-transform: uppercase;
        }
        .testimonial-box-container{
            display: flex;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
            width:100%;
        }
        .testimonial-box{
            width:500px;
            box-shadow: 2px 2px 30px rgba(0,0,0,0.1);
            background-color: #ffffff;
            padding: 20px;
            margin: 15px;
            cursor: pointer;
        }
        .profile-img{
            width:50px;
            height: 50px;
            border-radius: 50%;
            overflow: hidden;
            margin-right: 10px;
        }
        .profile-img img{
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: center;
        }
        .profile{
            display: flex;
            align-items: center;
        }
        .name-user{
            display: flex;
            flex-direction: column;
        }
        .name-user strong{
            color: #3d3d3d;
            font-size: 1.1rem;
            letter-spacing: 0.5px;
        }
        .name-user span{
            color: #979797;
            font-size: 0.8rem;
        }
        .reviews{
            color: #f9d71c;
        }
        .box-top{
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .client-comment p{
            font-size: 0.9rem;
            color: #4b4b4b;
        }
        .testimonial-box:hover{
            transform: translateY(-10px);
            transition: all ease 0.3s;
        }

        @media(max-width:1060px){
            .testimonial-box{
                width:80%;
                padding: 10px;
            }
        }
        @media(max-width:790px){
            .testimonial-box{
                width:100%;
            }
            .testimonial-heading h1{
                font-size: 1.4rem;
            }
        }
        @media(max-width:340px){
            .box-top{
                flex-wrap: wrap;
                margin-bottom: 10px;
            }
            .reviews{
                margin-top: 10px;
            }
        }
        ::selection{
            color: #ffffff;
            background-color: #252525;
        }
    </style>

    <script type="text/javascript">

        function fncGetUserList(currentPage) {
            $("#currentPage").val(currentPage);
            let truckId = $('input[name="truckId"]').val();
            let userId = $('input[name="userId"]').val();

            if(truckId!=null && truckId!=''){
                $("#getReviewList").attr("method" , "POST").attr("action" , "/review/getReviewListTruck").submit();
            }else if(userId!=null && userId!=''){
                $("#getReviewList").attr("method" , "POST").attr("action" , "/review/getReviewListUser").submit();
            }

        }


        /* 리뷰 내용 펼치기 */
        $(function () {

            $('.mb-10').click(function () {


                var rvNo = $(this).find("input[name='rvNo']").val();
                // alert(rvNo);

                $.ajax({
                    url : "/review/json/getReviewDetail/"+rvNo,
                    method : "GET",
                    dataType: "json",
                    header : {
                        "Accept" : "application/json",
                        "Content-Type" : "application/json"
                    },
                    success : function (Data) {
                        console.log(Data.review.rvNo);
                        var display = "<div class='card-ans mb-10'>"
                            + "<div class='row g-0 inquiry-card'>"
                            + "<div class='card-body'>"
                            + "<div style='margin: 0 55px 0 55px;'>";
                        display += "<hr>";
                        for(var i in Data.orderDetail){
                            display+=""+
                                ""+
                                ""+
                                ""+
                                ""+
                                "";
                        }



                        // alert(Data.review.rvTruckCmtContent);

                        // 스타일 바꾸기 시도 시작
                        display +="<div class=\"testimonial-box\">"+
                        "<input type=\"hidden\" name=\"rvNo\" value=\""+Data.review.rvNo+"\">"+
                        "<div class=\"box-top\">"+
                        "<div class=\"profile\">"+
                        " <div class=\"profile-img\">"+
                        " <img src=\"/resources/image/"+Data.review.userProImg+"\" />"+
                        "</div>"+
                        "<div class=\"name-user\">"+
                        "<strong>"+Data.review.rvUserId+"</strong>"+
                        "<span>"+Data.review.rvRegTime+"</span>"+
                        "</div>"+
                        "</div>"+
                        "<div class=\"reviews\">";
                        if(Data.review.rvStar==0){
                            display+=""+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(Data.review.rvStar==0.5){
                            display+=""+
                                "<i class=\"fas fa-star-half\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(Data.review.rvStar==1){
                            display+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(Data.review.rvStar==1.5){
                            display+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star-half\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(Data.review.rvStar==2){
                            display+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(Data.review.rvStar==2.5){
                            display+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star-half\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(Data.review.rvStar==3){
                            display+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(Data.review.rvStar==3.5){
                            display+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star-half\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(Data.review.rvStar==4){
                            display+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(Data.review.rvStar==4.5){
                            display+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star-half\"></i>";
                        }else if(Data.review.rvStar==5){
                            display+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>";
                        }
                        display+=""+
                            "</div>"+
                            "</div>"+
                            "<div class=\"client-comment\">"+
                            "<p>"+Data.review.rvContent+"</p>"+
                            "</div>"+
                            "</div>"+
                            ""+

                            "";

                        //스타일 바꾸기 시도 끝

                        if(Data.review.rvImg1){
                            display += "<img src='../../resources/image/"+Data.review.rvImg1+"' class='card-img-top' alt='reviewImg' style='width: 200px;'>";
                        }

                        if(Data.review.rvImg2){
                            display += "<img src='../../resources/image/"+Data.review.rvImg2+"' class='card-img-top' alt='reviewImg' style='width: 200px;'>";
                        }

                        if(Data.review.rvImg3){
                            display += "<img src='../../resources/image/"+Data.review.rvImg3+"' class='card-img-top' alt='reviewImg' style='width: 200px;'>";
                        }

                        // display  += "<p class='card-text'>"+Data.review.rvContent+"</p>"
                        //     + "</div>";

                        display +="<hr style='border-width:2px;'/>";
                        var role = $('input[name="role"]').val();

                        if(!Data.review.rvTruckCmtContent){
                            // alert(Data.review.rvTruckCmtContent);
                            if(role=='truck'){
                                display += "<div class='d-grid gap-2 col-6 mx-auto' style='margin: 0 55px 0 55px;'>"
                                    + "<button class='btn btn-sm ansBtn' type='button' onclick='closeAjax()' style='background: #ecf0fd; color: #000000'>확인</button>"
                                    + "<button class='btn btn-default btn-sm' data-bs-toggle='modal' data-bs-target='#addTruckComment' onclick='updateReview("+Data.review.rvNo+")' type='button' style='color: #000000'>댓글달기</button>"
                                    + "</div>";
                            }else if(role=='user'){
                                display += "<div class='d-grid gap-2 col-6 mx-auto' style='margin: 0 55px 0 55px;'>"
                                    + "<button class='btn btn-sm ansBtn' type='button' onclick='closeAjax()' style='background: #ecf0fd; color: #000000'>확인</button>"

                                    + "</div>";
                            }

                        } else {
                            display += "<div style='margin: 0 55px 0 55px;'>"
                                + "<div style='display: flex; justify-content: space-between'>"
                                + "<h6 class='card-title'><span class=\"badge badge-warning\">사장님 댓글</span> &nbsp&nbsp"+Data.review.rvTruckCmtContent+"</h6>"
                                // + "<p class='card-text'>사장님 댓글 작성 일시 : </p>"
                                + "<p class='card-text'>"+Data.review.rvTruckCmtRegTime+"</p>"
                                + "</div>"
                                + "<div style='display: flex; justify-content: center;'>"
                                + "<button class='btn btn-sm ansBtn' type='button' onclick='closeAjax()' style='background: #ecf0fd; color: #000000'>확인</button>";
                                if(role=='truck'){
                                    display +=""
                                        + "<button class='btn btn-default btn-sm' data-bs-toggle='modal' data-bs-target='#addTruckComment' onclick='updateReviewUpdate("+Data.review.rvNo+")' type='button' style='color: #000000'>수정하기</button>"
                                        + "</div>"
                                        + "</div>"
                                        + "</div>"
                                        + "</div>";
                                }else if(role=='user'){
                                    display+=""
                                        + "</div>"
                                        + "</div>"
                                        + "</div>"
                                        + "</div>";
                                }

                        }

                        //alert(display);
                        $(".card-ans").remove();
                        $("#"+Data.review.rvNo+"").html(display);
                    }
                });
            }) ;
        });

        function closeAjax(){
            $(".card-ans").remove();
        }


        //사장님댓글 달기
        function updateReview(rvNo) {



            $.ajax({
                url:"/review/json/getReviewDetail/"+rvNo,
                method:"get",
                success:function(data){
                    var div="";
                    var modalFooter = "";
                    // var hit = data.post.postHit;
                     $('#hiddenRvNo').val(rvNo);


                    div += "<div class='row rvContent' >"
                        +"<div>"+data.review.rvContent+"</div>"
                        + "</div>"+"<div class='align-test'>";

                    $('.mb-3.truck').html(div);


                }

            })
            $('#addTruckComment').modal('show');
        }
        //사장님댓글 수정
        function updateReviewUpdate(rvNo) {



            $.ajax({
                url:"/review/json/getReviewDetail/"+rvNo,
                method:"get",
                success:function(data){
                    var div="";
                    var modalFooter = "";
                    // var hit = data.post.postHit;
                     $('#hiddenRvNoNo').val(rvNo);


                    div += "<div class='row rvContent' >"
                        +"<div>"+data.review.rvContent+"</div>"
                        + "</div>"+"<div class='align-test'>";
                    $('#updateTruckCmtContent.form-control').text(data.review.rvTruckCmtContent);

                    $('.mb-3.truckUpdate').html(div);


                }

            })
            $('#updateTruckComment').modal('show');
        }

    </script>


</head>

<body>
<jsp:include page="/views/navbar.jsp" />
<div style="height: auto">
<%--    <jsp:include page="/views/user/sidebar.jsp" />--%>
</div>


<form class="client_section layout_padding" id="getReviewList">
    <input type="hidden" name="truckId" value="${truckId}">
    <input type="hidden" name="userId" value="${userId}">
    <input type="hidden" name="role" value="${sessionScope.role}">
    <input type="hidden" id="currentPage" name="currentPage" value=""/>
    <div class="container">

        <div class="col-md-11 col-lg-12 mx-auto">

            <div class="detail-box">
                <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
                <h4 style="margin-top: 10px;">
                    리뷰목록
                </h4>
            </div>

            <div class="row search">
                <div class="col-md-6 text-left" style="display: flex; align-items: center;">
                    <p style="margin: 0; font-size: 12px;">
                        <c:if test="${truckId ne null}">
                            전체  ${resultPage.totalCount} 건 평균 ${rvAvg}/5
                        </c:if>
                        <c:if test="${userId ne null}">
                            전체  ${resultPage.totalCount} 건
                        </c:if>
                    </p>
                </div>


            </div>

            <div class="card mb-10">
                <div class="row g-0 inquiry-card" style="align-items: center;">
                    <div class="col-md-2 inquiry-con">
                        <div class="card-body">
                            <c:if test="${sessionScope.role eq 'truck'}">
                                <p class="card-text"><small class="text-muted"><strong>리뷰 작성자</strong></small></p>
                            </c:if>
                            <c:if test="${sessionScope.role eq 'user'}">
                                <p class="card-text"><small class="text-muted"><strong>트럭 이름</strong></small></p>
                            </c:if>
                        </div>
                    </div>
                    <div class="col-md-6 inquiry-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted"><strong>리뷰내용</strong></small></p>
                        </div>
                    </div>
                    <div class="col-md-2 inquiry-con">
                        <div class="card-body">
                            <p class="card-text"><small class="text-muted"><strong>리뷰작성일</strong></small></p>
                        </div>
                    </div>
                    <div class="col-md-2 inquiry-con">
                        <div class="card-body">
                            <c:if test="${sessionScope.role eq 'truck'}">
                                <p class="card-text"><small class="text-muted"><strong>사장님 댓글</strong></small></p>
                            </c:if>
                            <c:if test="${sessionScope.role eq 'user'}">
                                <p class="card-text"><small class="text-muted"><strong>리뷰 별점</strong></small></p>
                            </c:if>

                        </div>
                    </div>
                </div>
            </div>

            <c:set var="i" value="0" />
            <c:forEach var="review" items="${list}">
                <c:set var="i" value="${ i+1 }" />

                <div class="card mb-10">
                    <div class="row g-0 inquiry-card" style="align-items: center;">
                        <div class="col-md-2 inquiry-con">
                            <div class="card-body">
                                <input type="hidden" id="rvNo" name ="rvNo" value="${review.rvNo}">

                                <c:if test="${sessionScope.role eq 'truck'}">
                                    <p class="card-text"><small class="text-muted">${review.rvUserId}</small></p>
                                </c:if>
                                <c:if test="${sessionScope.role eq 'user'}">
                                    <p class="card-text"><small class="text-muted">${review.truckName}</small></p>
                                </c:if>


                            </div>
                        </div>
                        <div class="col-md-6 inquiry-con" style="text-align-last: center;">
                            <div class="card-body">
                                <p class="card-text" style="text-align: initial;">
                                    <small class="text-muted">${review.rvContent}</small>
                                </p>
                            </div>
                        </div>
                        <div class="col-md-2 inquiry-con">
                            <div class="card-body">
                                <p class="card-text"><small class="text-muted">${review.rvRegTime}</small></p>
                            </div>
                        </div>
                        <div class="col-md-2 inquiry-con">
                            <div class="card-body">
                                <c:if test="${sessionScope.role eq 'truck'}">
                                    <c:if test="${review.rvTruckCmtContent ne null}">
                                        <p class="card-text"><h6><span class="badge badge-secondary">있음</span></h6></p>
                                    </c:if>
                                    <c:if test="${review.rvTruckCmtContent eq null}">
                                        <p class="card-text"><h6><span class="badge badge-secondary">없음</span></h6></p>
                                    </c:if>
                                </c:if>
                                <c:if test="${sessionScope.role eq 'user'}">
                                    <c:if test="${review.rvStar eq 0}">
                                        <i class="far fa-star"></i>
                                        <i class="far fa-star"></i>
                                        <i class="far fa-star"></i>
                                        <i class="far fa-star"></i>
                                        <i class="far fa-star"></i>
                                    </c:if>
                                   <c:if test="${review.rvStar eq 0.5}">
                                       <i class="fas fa-star-half"></i>
                                       <i class="far fa-star"></i>
                                       <i class="far fa-star"></i>
                                       <i class="far fa-star"></i>
                                       <i class="far fa-star"></i>
                                    </c:if>
                                   <c:if test="${review.rvStar eq 1}">
                                       <i class="fas fa-star"></i>
                                       <i class="far fa-star"></i>
                                       <i class="far fa-star"></i>
                                       <i class="far fa-star"></i>
                                       <i class="far fa-star"></i>
                                    </c:if>
                                   <c:if test="${review.rvStar eq 1.5}">
                                       <i class="fas fa-star"></i>
                                       <i class="fas fa-star-half"></i>
                                       <i class="far fa-star"></i>
                                       <i class="far fa-star"></i>
                                       <i class="far fa-star"></i>
                                    </c:if>
                                   <c:if test="${review.rvStar eq 2}">
                                       <i class="fas fa-star"></i>
                                       <i class="fas fa-star"></i>
                                       <i class="far fa-star"></i>
                                       <i class="far fa-star"></i>
                                       <i class="far fa-star"></i>
                                    </c:if>
                                   <c:if test="${review.rvStar eq 2.5}">
                                       <i class="fas fa-star"></i>
                                       <i class="fas fa-star"></i>
                                       <i class="fas fa-star-half"></i>
                                       <i class="far fa-star"></i>
                                       <i class="far fa-star"></i>
                                    </c:if>
                                   <c:if test="${review.rvStar eq 3}">
                                       <i class="fas fa-star"></i>
                                       <i class="fas fa-star"></i>
                                       <i class="fas fa-star"></i>
                                       <i class="far fa-star"></i>
                                       <i class="far fa-star"></i>
                                    </c:if>
                                   <c:if test="${review.rvStar eq 3.5}">
                                       <i class="fas fa-star"></i>
                                       <i class="fas fa-star"></i>
                                       <i class="fas fa-star"></i>
                                       <i class="fas fa-star-half"></i>
                                       <i class="far fa-star"></i>
                                    </c:if>
                                   <c:if test="${review.rvStar eq 4}">
                                       <i class="fas fa-star"></i>
                                       <i class="fas fa-star"></i>
                                       <i class="fas fa-star"></i>
                                       <i class="fas fa-star"></i>
                                       <i class="far fa-star"></i>
                                    </c:if>
                                   <c:if test="${review.rvStar eq 4.5}">
                                       <i class="fas fa-star"></i>
                                       <i class="fas fa-star"></i>
                                       <i class="fas fa-star"></i>
                                       <i class="fas fa-star"></i>
                                       <i class="fas fa-star-half"></i>
                                    </c:if>
                                   <c:if test="${review.rvStar eq 5}">
                                       <i class="fas fa-star"></i>
                                       <i class="fas fa-star"></i>
                                       <i class="fas fa-star"></i>
                                       <i class="fas fa-star"></i>
                                       <i class="fas fa-star"></i>
                                    </c:if>

                                </c:if>




                            </div>
                        </div>
                    </div>
                </div>

                <div id="${review.rvNo}"></div>

            </c:forEach>

            <div class="show"></div>


        </div>
    </div>
</form>
<!--댓글달기-->
    <div class="modal fade" id="addTruckComment" tabindex="-1" aria-labelledby="addTruckComment" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateTruckCmtModalLabel">사장님 댓글 달기</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="NohiddenRvNo" name ="hiddenRvNo" value="">
                    <form style="text-align: left;">
                        <div class="mb-3 truck">
                            <label for="addTruckCommentTitle" class="col-form-label">리뷰 정보</label>
                            <input type="text" class="form-control" id="addTruckCommentTitle">
                        </div>
                        <div class="mb-3">
                            <label for="inquiryAnsContent" class="col-form-label">사장님 댓글 내용</label>
                            <textarea class="form-control" id="inquiryAnsContent"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-default btn-sm" id="updateRVForAddTruckCmt">사장님 댓글등록</button>
                </div>
            </div>
        </div>
    </div>
    <!--수정하기-->
    <div class="modal fade" id="updateTruckComment" tabindex="-1" aria-labelledby="updateTruckComment" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">사장님 댓글 달기</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="hiddenRvNoNo" name ="hiddenRvNoNo" value="">
                    <form style="text-align: left;">
                        <div class="mb-3 truckUpdate">
                            <label for="updateTruckCommentTitle" class="col-form-label">리뷰 정보</label>
                            <input type="text" class="form-control" id="updateTruckCommentTitle">
                        </div>
                        <div class="mb-3">
                            <label for="updateTruckCmtContent" class="col-form-label">사장님 댓글 내용</label>
                            <textarea class="form-control" id="updateTruckCmtContent"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-default btn-sm" id="updateRVForUpdateTruckCmt">사장님 댓글수정</button>
                </div>
            </div>
        </div>
    </div>
</section>

<script>

    /* 사장님 댓글 등록 */
    $(function () {

        $('#updateRVForAddTruckCmt').click(function () {



            var rvNo = $('#hiddenRvNo').val();
            var rvTruckCmtContent = $('#inquiryAnsContent').val();

            console.log(rvNo);
            console.log(rvTruckCmtContent);

            $.ajax({

                url : "/review/json/updateRvForAddTruckCmt",
                method : "POST",
                dataType: "json",
                header : {
                    "Accept" : "application/json",
                    "Content-Type" : "application/json"
                },
                data : {
                    rvNo : rvNo,
                    rvTruckCmtContent : rvTruckCmtContent
                },
                success : function (data){
                    console.log(data);
                    window.location.reload();
                }
            });
        });
    });


    /* 사장님 댓글 수정 */
    $(function () {

        $('#updateRVForUpdateTruckCmt').click(function () {



            var rvNo = $('#hiddenRvNoNo').val();
            var rvTruckCmtContent = $('#updateTruckCmtContent').val();

            console.log(rvNo);
            console.log(rvTruckCmtContent);

            $.ajax({

                url : "/review/json/updateRvForUpdateTruckCmt",
                method : "POST",
                dataType: "json",
                header : {
                    "Accept" : "application/json",
                    "Content-Type" : "application/json"
                },
                data : {
                    rvNo : rvNo,
                    rvTruckCmtContent : rvTruckCmtContent
                },
                success : function (data){
                    console.log(data);
                    window.location.reload();
                }
            });
        });
    });


</script>

<jsp:include page="/common/pageNavigator_new.jsp" />
<jsp:include page="/views/footer.jsp" />
</body>
</html>




<%--<%@ page language="java" contentType="text/html; charset=EUC-KR"--%>
<%--         pageEncoding="EUC-KR"%>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>


<%--<html>--%>
<%--<head>--%>
<%--    <title>리뷰 목록 조회</title>--%>
<%--    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">--%>
<%--    <link rel="stylesheet" href="/resources/demos/style.css">--%>
<%--    <link rel="stylesheet" href="/css/admin.css" type="text/css">--%>
<%--    <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>--%>
<%--    <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>--%>
<%--    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>--%>
<%--    <script type="text/javascript">--%>

<%--        window.onload = function() {--%>
<%--            //alert("why? : " + $("tr.ct_list_pop td").find("input[name=menuNo]").val());--%>


<%--            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)--%>
<%--            // var menuNo = trim($(this.find("input[name=menuNo]").val()));--%>
<%--            $("tr.ct_list_pop td").on("click", function () {--%>
<%--                self.location = "/review/getReview?rvNo="+$("tr.ct_list_pop td").find("input[name=rvNo]").val();--%>
<%--            });--%>

<%--        };--%>



<%--    </script>--%>
<%--    <style>--%>

<%--        body{margin-top:20px;--%>
<%--            background:#eee;--%>
<%--        }--%>
<%--        .review-list ul li .left span {--%>
<%--            width: 32px;--%>
<%--            height: 32px;--%>
<%--            display: inline-block;--%>
<%--        }--%>
<%--        .review-list ul li .left {--%>
<%--            flex: none;--%>
<%--            max-width: none;--%>
<%--            margin: 0 10px 0 0;--%>
<%--        }--%>
<%--        .review-list ul li .left span img {--%>
<%--            border-radius: 50%;--%>
<%--        }--%>
<%--        .review-list ul li .right h4 {--%>
<%--            font-size: 16px;--%>
<%--            margin: 0;--%>
<%--            display: flex;--%>
<%--        }--%>
<%--        .review-list ul li .right h4 .gig-rating {--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            margin-left: 10px;--%>
<%--            color: #ffbf00;--%>
<%--        }--%>
<%--        .review-list ul li .right h4 .gig-rating svg {--%>
<%--            margin: 0 4px 0 0px;--%>
<%--        }--%>
<%--        .country .country-flag {--%>
<%--            width: 16px;--%>
<%--            height: 16px;--%>
<%--            vertical-align: text-bottom;--%>
<%--            margin: 0 7px 0 0px;--%>
<%--            border: 1px solid #fff;--%>
<%--            border-radius: 50px;--%>
<%--            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);--%>
<%--        }--%>
<%--        .country .country-name {--%>
<%--            color: #95979d;--%>
<%--            font-size: 13px;--%>
<%--            font-weight: 600;--%>
<%--        }--%>
<%--        .review-list ul li {--%>
<%--            border-bottom: 1px solid #dadbdd;--%>
<%--            padding: 0 0 30px;--%>
<%--            margin: 0 0 30px;--%>
<%--        }--%>
<%--        .review-list ul li .right {--%>
<%--            flex: auto;--%>
<%--        }--%>
<%--        .review-list ul li .review-description {--%>
<%--            margin: 20px 0 0;--%>
<%--        }--%>
<%--        .review-list ul li .review-description p {--%>
<%--            font-size: 14px;--%>
<%--            margin: 0;--%>
<%--        }--%>
<%--        .review-list ul li .publish {--%>
<%--            font-size: 13px;--%>
<%--            color: #95979d;--%>
<%--        }--%>

<%--        .review-section h4 {--%>
<%--            font-size: 20px;--%>
<%--            color: #222325;--%>
<%--            font-weight: 700;--%>
<%--        }--%>
<%--        .review-section .stars-counters tr .stars-filter.fit-button {--%>
<%--            padding: 6px;--%>
<%--            border: none;--%>
<%--            color: #4a73e8;--%>
<%--            text-align: left;--%>
<%--        }--%>
<%--        .review-section .fit-progressbar-bar .fit-progressbar-background {--%>
<%--            position: relative;--%>
<%--            height: 8px;--%>
<%--            background: #efeff0;--%>
<%--            -webkit-box-flex: 1;--%>
<%--            -ms-flex-positive: 1;--%>
<%--            flex-grow: 1;--%>
<%--            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);--%>
<%--            background-color: #ffffff;--%>
<%--        ;--%>
<%--            border-radius: 999px;--%>
<%--        }--%>
<%--        .review-section .stars-counters tr .star-progress-bar .progress-fill {--%>
<%--            background-color: #ffb33e;--%>
<%--        }--%>
<%--        .review-section .fit-progressbar-bar .progress-fill {--%>
<%--            background: #2cdd9b;--%>
<%--            background-color: rgb(29, 191, 115);--%>
<%--            height: 100%;--%>
<%--            position: absolute;--%>
<%--            left: 0;--%>
<%--            z-index: 1;--%>
<%--            border-radius: 999px;--%>
<%--        }--%>
<%--        .review-section .fit-progressbar-bar {--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--        }--%>
<%--        .review-section .stars-counters td {--%>
<%--            white-space: nowrap;--%>
<%--        }--%>
<%--        .review-section .stars-counters tr .progress-bar-container {--%>
<%--            width: 100%;--%>
<%--            padding: 0 10px 0 6px;--%>
<%--            margin: auto;--%>
<%--        }--%>
<%--        .ranking h6 {--%>
<%--            font-weight: 600;--%>
<%--            padding-bottom: 16px;--%>
<%--        }--%>
<%--        .ranking li {--%>
<%--            display: flex;--%>
<%--            justify-content: space-between;--%>
<%--            color: #95979d;--%>
<%--            padding-bottom: 8px;--%>
<%--        }--%>
<%--        .review-section .stars-counters td.star-num {--%>
<%--            color: #4a73e8;--%>
<%--        }--%>
<%--        .ranking li>span {--%>
<%--            color: #62646a;--%>
<%--            white-space: nowrap;--%>
<%--            margin-left: 12px;--%>
<%--        }--%>
<%--        .review-section {--%>
<%--            border-bottom: 1px solid #dadbdd;--%>
<%--            padding-bottom: 24px;--%>
<%--            margin-bottom: 34px;--%>
<%--            padding-top: 64px;--%>
<%--        }--%>
<%--        .review-section select, .review-section .select2-container {--%>
<%--            width: 188px !important;--%>
<%--            border-radius: 3px;--%>
<%--        }--%>
<%--        ul, ul li {--%>
<%--            list-style: none;--%>
<%--            margin: 0px;--%>
<%--        }--%>
<%--        .helpful-thumbs, .helpful-thumb {--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            font-weight: 700;--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>

<%--<body bgcolor="#ffffff" text="#000000">--%>

<%--&lt;%&ndash;<div style="width:98%; margin-left:10px;">&ndash;%&gt;--%>

<%--&lt;%&ndash;    <form name="detailForm">&ndash;%&gt;--%>

<%--&lt;%&ndash;        <table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">&ndash;%&gt;--%>
<%--&lt;%&ndash;            <tr>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <td width="15" height="37">&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <img src="/images/ct_ttl_img01.gif" width="15" height="37">&ndash;%&gt;--%>
<%--&lt;%&ndash;                </td>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <table width="100%" border="0" cellspacing="0" cellpadding="0">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <tr>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <td width="93%" class="ct_ttl01">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                리뷰 목록 조회&ndash;%&gt;--%>
<%--&lt;%&ndash;                            </td>&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </tr>&ndash;%&gt;--%>

<%--&lt;%&ndash;                    </table>&ndash;%&gt;--%>
<%--&lt;%&ndash;                </td>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <td width="12" height="37">&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <img src="/images/ct_ttl_img03.gif" width="12" height="37">&ndash;%&gt;--%>
<%--&lt;%&ndash;                </td>&ndash;%&gt;--%>
<%--&lt;%&ndash;            </tr>&ndash;%&gt;--%>
<%--&lt;%&ndash;        </table>&ndash;%&gt;--%>



<%--&lt;%&ndash;        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">&ndash;%&gt;--%>

<%--&lt;%&ndash;            <tr>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <td class="ct_list_b" width="100">no</td>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <td class="ct_line02"></td>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <td class="ct_list_b" width="150">리뷰 작성자</td>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <td class="ct_line02"></td>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <td class="ct_list_b" width="150">리뷰 별점</td>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <td class="ct_line02"></td>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <td class="ct_list_b" width="150">메뉴 내용</td>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <td class="ct_line02"></td>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <td class="ct_list_b">사장님 댓글</td>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <td class="ct_line02"></td>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <td class="ct_list_b">리뷰 이미지</td>&ndash;%&gt;--%>
<%--&lt;%&ndash;            </tr>&ndash;%&gt;--%>
<%--&lt;%&ndash;            <tr>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <td colspan="11" bgcolor="808285" height="1"></td>&ndash;%&gt;--%>
<%--&lt;%&ndash;            </tr>&ndash;%&gt;--%>


<%--&lt;%&ndash;            <c:set var="i" value="0"/>&ndash;%&gt;--%>
<%--&lt;%&ndash;            <c:forEach var="review" items="${list}">&ndash;%&gt;--%>
<%--&lt;%&ndash;                <c:set var="i" value="${i+1}" />&ndash;%&gt;--%>
<%--&lt;%&ndash;                <tr class="ct_list_pop">&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <td align="center">&ndash;%&gt;--%>

<%--&lt;%&ndash;                            ${i}&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </td>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <td></td>&ndash;%&gt;--%>

<%--&lt;%&ndash;                    <td align="left">&ndash;%&gt;--%>

<%--&lt;%&ndash;                        <span class="review">${review.rvUserId}&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <input type="hidden" id="rvNo" name="rvNo" value="${review.rvNo}"/></span>&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;                        <span class="review" hidden="">${review.menuNo}</span>&ndash;%&gt;&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;                        <span class="review" hidden="">${review.menuTruckId}</span>&ndash;%&gt;&ndash;%&gt;--%>

<%--&lt;%&ndash;                    </td>&ndash;%&gt;--%>

<%--&lt;%&ndash;                    <td></td>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <td align="left">&ndash;%&gt;--%>

<%--&lt;%&ndash;                            ${review.rvStar}&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </td>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <td></td>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <td align="left">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            ${review.rvContent}&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </td>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <td></td>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <td align="left">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            ${review.rvTruckCmtContent}&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </td>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <tr>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <td id="${review.rvImg1}" colspan="11" bgcolor="D6D7D6" height="1"></td>&ndash;%&gt;--%>
<%--&lt;%&ndash;                </tr>&ndash;%&gt;--%>
<%--&lt;%&ndash;            </c:forEach>&ndash;%&gt;--%>

<%--&lt;%&ndash;        </table>&ndash;%&gt;--%>

<%--&lt;%&ndash;        <table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">&ndash;%&gt;--%>
<%--&lt;%&ndash;            <tr>&ndash;%&gt;--%>

<%--&lt;%&ndash;            </tr>&ndash;%&gt;--%>
<%--&lt;%&ndash;        </table>&ndash;%&gt;--%>
<%--&lt;%&ndash;        <!--  페이지 Navigator 끝 -->&ndash;%&gt;--%>
<%--&lt;%&ndash;    </form>&ndash;%&gt;--%>
<%--&lt;%&ndash;</div>&ndash;%&gt;--%>

<%--<div class="container">--%>
<%--    <div id="reviews" class="review-section">--%>
<%--        <div class="d-flex align-items-center justify-content-between mb-4">--%>
<%--            <h4 class="m-0">${resultPage.totalCount} Reviews(평균 ${rvAvg})</h4>--%>


<%--        </div>--%>


<%--        </div>--%>
<%--    </div>--%>

<%--    <div class="review-list">--%>
<%--        <ul>--%>
<%--            <li>--%>
<%--&lt;%&ndash;                <div class="d-flex">&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <div class="left">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <span>&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;                            <img src="https://bootdey.com/img/Content/avatar/avatar1.png" class="profile-pict-img img-fluid" alt="" />&ndash;%&gt;&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </span>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <div class="right">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <h4>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            Askbootstrap&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <span class="gig-rating text-body-2">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1792 1792" width="15" height="15">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    <path&ndash;%&gt;--%>
<%--&lt;%&ndash;                                            fill="currentColor"&ndash;%&gt;--%>
<%--&lt;%&ndash;                                            d="M1728 647q0 22-26 48l-363 354 86 500q1 7 1 20 0 21-10.5 35.5t-30.5 14.5q-19 0-40-12l-449-236-449 236q-22 12-40 12-21 0-31.5-14.5t-10.5-35.5q0-6 2-20l86-500-364-354q-25-27-25-48 0-37 56-46l502-73 225-455q19-41 49-41t49 41l225 455 502 73q56 9 56 46z"&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    ></path>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                </svg>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                5.0&ndash;%&gt;--%>
<%--&lt;%&ndash;                            </span>&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </h4>&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <div class="country d-flex align-items-center">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <span>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <img class="country-flag img-fluid" src="https://bootdey.com/img/Content/avatar/avatar6.png" />&ndash;%&gt;--%>
<%--&lt;%&ndash;                            </span>&ndash;%&gt;--%>

<%--&lt;%&ndash;                        </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <div class="review-description">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <p>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                The process was smooth, after providing the required info, Pragyesh sent me an outstanding packet of wireframes. Thank you a lot!&ndash;%&gt;--%>
<%--&lt;%&ndash;                            </p>&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </div>&ndash;%&gt;--%>

<%--&lt;%&ndash;                        <div class="response-item mt-4 d-flex">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <div class="left">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <span>&ndash;%&gt;--%>
<%--&lt;%&ndash;&lt;%&ndash;                                    <img src="https://bootdey.com/img/Content/avatar/avatar2.png" class="profile-pict-img img-fluid" alt="" />&ndash;%&gt;&ndash;%&gt;--%>
<%--&lt;%&ndash;                                </span>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <div class="right">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <h4>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    Gurdeep Osahan&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    <span class="gig-rating text-body-2">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1792 1792" width="15" height="15">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                            <path&ndash;%&gt;--%>
<%--&lt;%&ndash;                                                    fill="currentColor"&ndash;%&gt;--%>
<%--&lt;%&ndash;                                                    d="M1728 647q0 22-26 48l-363 354 86 500q1 7 1 20 0 21-10.5 35.5t-30.5 14.5q-19 0-40-12l-449-236-449 236q-22 12-40 12-21 0-31.5-14.5t-10.5-35.5q0-6 2-20l86-500-364-354q-25-27-25-48 0-37 56-46l502-73 225-455q19-41 49-41t49 41l225 455 502 73q56 9 56 46z"&ndash;%&gt;--%>
<%--&lt;%&ndash;                                            ></path>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        </svg>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        5.0&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    </span>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                </h4>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <div class="country d-flex align-items-center">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    <span>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        <img class="country-flag img-fluid" src="https://bootdey.com/img/Content/avatar/avatar3.png" />&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    </span>&ndash;%&gt;--%>

<%--&lt;%&ndash;                                </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <div class="review-description">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    <p>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        The process was smooth, after providing the required info, Pragyesh sent me an outstanding packet of wireframes. Thank you a lot!&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    </p>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                </div>&ndash;%&gt;--%>

<%--&lt;%&ndash;                            </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                </div>&ndash;%&gt;--%>
<%--                <div class="d-flex">--%>
<%--                  <c:set var="i" value="0"/>--%>
<%--                    <c:forEach var="review" items="${list}">--%>
<%--                        <div class="response-item mt-4 d-flex">--%>
<%--                            <div class="left">--%>
<%--                                <span>--%>
<%--                                        &lt;%&ndash;                                    <img src="https://bootdey.com/img/Content/avatar/avatar2.png" class="profile-pict-img img-fluid" alt="" />&ndash;%&gt;--%>
<%--                                </span>--%>
<%--                            </div>--%>
<%--                            <div class="right">--%>
<%--                                <h4>--%>
<%--                                    ${review.rvUserId}--%>
<%--                                    <span class="gig-rating text-body-2">--%>
<%--                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1792 1792" width="15" height="15">--%>
<%--                                            <path--%>
<%--                                                    fill="currentColor"--%>
<%--                                                    d="M1728 647q0 22-26 48l-363 354 86 500q1 7 1 20 0 21-10.5 35.5t-30.5 14.5q-19 0-40-12l-449-236-449 236q-22 12-40 12-21 0-31.5-14.5t-10.5-35.5q0-6 2-20l86-500-364-354q-25-27-25-48 0-37 56-46l502-73 225-455q19-41 49-41t49 41l225 455 502 73q56 9 56 46z"--%>
<%--                                            ></path>--%>
<%--                                        </svg>--%>
<%--                                        ${review.rvStar}--%>
<%--                                    </span>--%>
<%--                                </h4>--%>
<%--                                <div class="country d-flex align-items-center">--%>
<%--                                    <span>--%>
<%--                                        <img class="country-flag img-fluid" src="../../resources/image/${review.userProImg}" />--%>
<%--                                    </span>--%>
<%--                                    <span>--%>
<%--                                        <img class="country-flag img-fluid" src="../../resources/image/${review.truckProImg}" />--%>
<%--                                    </span>--%>

<%--                                </div>--%>
<%--                                <div class="review-description">--%>
<%--                                    <p>--%>
<%--                                        ${review.rvContent}--%>
<%--                                    </p>--%>
<%--                                </div>--%>

<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </c:forEach>--%>


<%--                    </div>--%>

<%--            </li>--%>
<%--        </ul>--%>
<%--    </div>--%>
<%--</div>--%>

<%--</body>--%>
<%--</html>--%>