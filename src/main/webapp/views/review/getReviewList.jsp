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

    <%--별점 구현--%>

    <style>
        .star-rating {
            display: flex;
            flex-direction: row-reverse;
            font-size: 2.25rem;
            line-height: 2.5rem;
            justify-content: space-around;
            padding: 0 0.2em;
            text-align: center;
            width: 5em;
        }

        .star-rating input {
            display: none;
        }

        .star-rating label {
            -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
            -webkit-text-stroke-width: 1.5px;
            -webkit-text-stroke-color: #2b2a29;
            cursor: pointer;
        }

        .star-rating :checked ~ label {
            -webkit-text-fill-color: gold;
        }

        .star-rating label:hover,
        .star-rating label:hover ~ label {
            -webkit-text-fill-color: #fff58c;
        }
        .text-center{
            display: flex
        }

    </style>

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
            /*width:938px;*/
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
            /*margin-right:60%*/
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
/*        .testimonial-box:hover{
            transform: translateY(-10px);
            transition: all ease 0.3s;
        }*/

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

<%--    <style>

        .carousel-item {
            width:30%;
        }

    </style>--%>

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

                var role = $('input[name="role"]').val();


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
                        var display ="<div class='card-ans mb-10'>";
                        display +="<hr style='border-width:2px;'/>";
                        display += "<div class='card-ans mb-10'>"
                            + "<div class='row g-0 inquiry-card'>"
                            + "<div class='card-body'>"
                            + "<div style='margin: 0 55px 0 55px;'>";

                        var odMenuNameCount = Data.orderDetail.list.length;
                        // console.log(odMenuNameCount);


                        var odMenuNameL;
                        var odOptionGroupNameL;
                        var odOptionNameL;
                        var odMenuQtyL;
                        var odMenuPriceL;
                        var odOptionPriceL;
                        var odMenuImageL;

                        var totototoprice =0; // 전체 금액
                        var totototoqty =0; // 수량
                        var pricepriceprice =0 // 임시 가격

                        var menuPriceOne = [];
                        var menuPriceTwo = [];
                        var optionPriceOne = [];
                        var optionPriceTwo = [];
                        var menuCount = 0;
                        var menuCheck = [];

                        var optionNameShow = []; // 이름 보여지게 할 값 만들기~ (최종)
                        var optionPriceShow = [];
                        var totalshow =0;



                        for (var i = 0; i < odMenuNameCount; i++) {
                            var odMenuName = Data.orderDetail.list[i].odMenuName;
                            var odOptionGroupName = Data.orderDetail.list[i].odOptionGroupName;
                            var odOptionName = Data.orderDetail.list[i].odOptionName;
                            var odMenuQty = (Data.orderDetail.list[i].odMenuQty).toString();
                            var odMenuPrice = (Data.orderDetail.list[i].odMenuPrice).toString();
                            var odOptionPrice = (Data.orderDetail.list[i].odOptionPrice).toString();
                            var odMenuImage = Data.orderDetail.list[i].odMenuImage;
                            var odMenuQtyFlag =Data.orderDetail.list[i].odMenuQtyFlag;

                            // console.log("odOptionName ["+i+"] : " + odOptionName);

                            if (optionNameShow[menuCount] == undefined){
                                optionNameShow[menuCount] = " ";
                            }


                            if ( odMenuQtyFlag == '0'){

                                pricepriceprice = Number(odMenuPrice);
                                totototoqty = Number(odMenuQty);
                                menuCount++;
                                totalshow=0;
                                //pricepriceprice *= qtyqtyqty;
                                //console.log("pricepriceprice *= qtyqtyqty" + (pricepriceprice *= qtyqtyqty));
                                //tttttppppprrrr += Number(pricepriceprice)// 처음 들어온 값도 0, 이후엔 곱해짐 // 기존값 더함
                                //qtyqtyqty = Number(odMenuQty); // 수량값 기억하고 있도록 for문 밖에 선언해준 qtyqtyqty 에 저장
                            }else { // 옵션이면
                                // console.log("odOptionName : "+odOptionName)
                                pricepriceprice = Number(odOptionPrice);
                                optionNameShow[Number(menuCount-1)] += odOptionName + "(+" + odOptionPrice + ") ";

                            }
                            //console.log("optionNameShow[menuCount]: "+optionNameShow[menuCount])
                            totototoprice+= Number(pricepriceprice * totototoqty);
                            totalshow += Number(pricepriceprice * totototoqty);
                            optionPriceShow[Number(menuCount-1)] = totalshow;
                            console.log("ttototototo :: " + totototoprice)

                            var odMenuImageCopy;
                            var odMenuNameCopy;
                            var odOptionGroupNameCopy;
                            var odOptionNameCopy;
                            var odMenuQtyCopy;
                            var odMenuPriceCopy;
                            var odOptionPriceCopy;
                            var test2;
                            var totalPrice;


                            if (odMenuNameCopy != null && odMenuQtyFlag == 0) {
                                odMenuNameCopy = odMenuNameCopy + "," + odMenuName;
                                odMenuImageCopy = odMenuImageCopy + "," + odMenuImage;
                                odMenuQtyCopy = odMenuQtyCopy + "," + odMenuQty;
                                odMenuPriceCopy = odMenuPriceCopy + "," + odMenuPrice;
                                totalPrice = totalPrice + parseInt(odMenuPrice);
                            } else if (odMenuNameCopy == null) {

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

                            if (odOptionNameCopy == null) {
                                odOptionNameCopy = odOptionName;
                                test2 = odMenuName;
                                odOptionGroupNameCopy = odOptionGroupName;
                                odOptionPriceCopy = odOptionPrice;

                            } else if (test2 != odMenuName ) {
                                odOptionNameCopy = odOptionNameCopy + "/" + odOptionName;
                                odOptionGroupNameCopy = odOptionGroupNameCopy + "/" + odOptionGroupName;
                                odOptionPriceCopy = odOptionPriceCopy + "/" + odOptionPrice;

                            } else if (odOptionNameCopy != null) {

                                odOptionNameCopy = odOptionNameCopy + "," + odOptionName;
                                test2 = odMenuName;
                                odOptionGroupNameCopy = odOptionGroupNameCopy + "," + odOptionGroupName;
                                odOptionPriceCopy = odOptionPriceCopy + "," +  odOptionPrice;
                            }
                            if(odOptionNameL!=null){
                                odOptionNameL = odOptionNameCopy.split("/");
                                odOptionGroupNameL = odOptionGroupNameCopy.split("/");

                            }





                        }



                        var sum = new Array() ;
                        var test3 = new Array();

                        odOptionPriceL = odOptionPriceCopy.split("/");

                        for(var i=0; i<odOptionPriceL.length; i++){
                            a=odOptionPriceL[i]*1;
                            odOptionPrice[i] = a;
                        }

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
                                "<img src=\"/resources/menu/"+odMenuImageL[i]+"\" class=\"img-fluid rounded-start\" alt=\"image\">" +
                                "</div>" +
                                "<div class=\"col-md-8\">" +
                                "<div class=\"card-body\">" +
                                "<h5 class=\"card-title\">" + odMenuNameL[i] + "</h5>" +
                                "<p class=\"card-text\"><small class=\"text-muted\"><span class=\"badge\" style=\"background-color: #fae100; color: #110000\">&nbsp;옵션&nbsp;</span> " + optionNameShow[i] + " </small><br>"  +
                                "  <small class=\"text-muted\"><span class=\"badge\" style=\"background-color: #fae100; color:#110000\">&nbsp;수량&nbsp;</span> "+ odMenuQtyL[i] + "<br><span class=\"badge\" style=\"background-color: #fae100; color: #110000\">총 가격</span> "+optionPriceShow[i] + " </small></p>" +
                                "</div></div></div></div>" ;

                            display+=(divElemApply1);
                        }
                        display += "<hr>";


                        // alert(Data.review.rvTruckCmtContent);

                        // 스타일 바꾸기 시도 시작
                        display +="<div class=\"testimonial-box\" style='display: flex; flex-direction: column;'>"+
                        "<input type=\"hidden\" name=\"rvNo\" value=\""+Data.review.rvNo+"\">"+
                        "<div class=\"box-top\">"+
                        "<div class=\"profile\">"+
                        " <div class=\"profile-img\">";
                        if(role=='truck'){
                            display+=""+
                                " <img src=\"/resources/image/"+Data.review.userProImg+"\" />";
                        }else if(role=='user'){
                            display+=""+
                                " <img src=\"/resources/image/"+Data.review.truckProImg+"\" />";
                        }

                        display+=""+
                        "</div>"+
                        "<div class=\"name-user\">";
                        if(role=='truck'){
                            display+="<strong>"+Data.review.rvUserId+"</strong>";
                        }else if(role=='user'){
                            display+="<strong>"+Data.review.truckName+"</strong>";
                        }
                        display+=
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
                            "<hr/>"+
                            "<div class=\"client-comment col-12\">"+
                            "<p style='font-size: 15px;'>"+Data.review.rvContent+"</p>"+
                            "</div>"+

                            ""+

                            "";

                        //스타일 바꾸기 시도 끝



                        //carousel 적용
                        /*if(Data.review.rvImg1){
                            display += ""+
                                "<div id=\"carouselExampleIndicators\" class=\"carousel slide\" data-ride=\"carousel\">"+
                                "<ol class=\"carousel-indicators\">"+
                                "<li data-target=\"#carouselExampleIndicators\" data-slide-to=\"0\" class=\"active\"></li>";

                        }
                        if(Data.review.rvImg2){
                            display += ""+
                                "<li data-target=\"#carouselExampleIndicators\" data-slide-to=\"1\"></li>";
                        }
                        if(Data.review.rvImg3){
                            display+=""+
                                "<li data-target=\"#carouselExampleIndicators\" data-slide-to=\"\"></li>";
                        }*/
                        if(Data.review.rvImg1){
                            display+=""+
                        //"</ol>"+
                            "<div class=\"carousel-item col-12\" style='display: flex;'>"+
                                "<div class=\"carousel-item active col-4\" style='display: flex; margin: 0;'>"+
                                "<img class=\"d-block w-100\" src=\"/resources/image/"+Data.review.rvImg1+"\" alt=\"First slide\" style='box-shadow: 0 2px 4px 1px rgba(0,0,0,0.2); transition: 0.3s; border-radius: 10px;'>"+
                                "</div>";
                        }
                        if(Data.review.rvImg2){
                            display+=""+
                                "<div class=\"carousel-item col-4\" style='display: flex; margin: 0;'>"+
                                "<img class=\"d-block w-100\" src=\"/resources/image/"+Data.review.rvImg2+"\" alt=\"Second slide\" style='box-shadow: 0 2px 4px 1px rgba(0,0,0,0.2); transition: 0.3s; border-radius: 10px;'>"+
                                "</div>";
                        }
                        if(Data.review.rvImg3){
                            display+=""+
                                "<div class=\"carousel-item col-4\" style='display: flex; margin: 0;'>"+
                                "<img class=\"d-block w-100\" src=\"/resources/image/"+Data.review.rvImg3+"\" alt=\"Third slide\" style='box-shadow: 0 2px 4px 1px rgba(0,0,0,0.2); transition: 0.3s; border-radius: 10px;'>"+
                                "</div>";
                        }
                        display += "</div>";
                        display +="<hr style='border-width:2px;'/>";

                        if(!Data.review.rvTruckCmtContent){
                            // alert(Data.review.rvTruckCmtContent);
                            if(role=='truck'){
                                display += "<div class='d-grid gap-2 col-6 mx-auto' style='margin: 0 55px 0 55px;'>"
                                    + "<button class='btn btn-cancle btn-sm ansBtn' type='button' onclick='closeAjax()' style='background: #ecf0fd; color: #000000'>확인</button>"
                                    + "<button class='btn btn-default btn-sm' data-bs-toggle='modal' data-bs-target='#addTruckComment' onclick='updateReview("+Data.review.rvNo+")' type='button' style='color: #000000'>댓글달기</button>"
                                    + "</div>";
                            }else if(role=='user'){
                                display += "<div class='d-grid gap-2 col-6 mx-auto' style='margin: 0 55px 0 55px;'>"
                                    + "<button class='btn btn-sm btn-cancle ansBtn' type='button' onclick='closeAjax()' style='background: #ecf0fd; color: #000000'>확인</button>";

                                display +=""+
                                     "<button class='btn btn-default btn-sm' data-bs-toggle='modal' data-bs-target='#updateReview' onclick='updateReviewUpdate("+Data.review.rvNo+")' type='button' style='color: #000000'>수정하기</button>"
                                    + "</div>"
                                    + "</div>"
                                    + "</div>"
                                    + "</div>";
                            }

                        } else {
                            display += "<div'>"
                                + "<div style='display: flex; justify-content: space-between; padding: 0 15px;'>"
                                + "<div><h5 class='card-title'><span class=\"badge badge-warning\">사장님 댓글</span></div>"
                                + "<div><p class='card-text'>"+Data.review.rvTruckCmtRegTime+"</p></div>"
                                + "</div>"
                                +"<div style='padding: 0 15px;'>"
                                +Data.review.rvTruckCmtContent+"</h5>"
                                +"</div>"
                                +"<hr/>"
                                + "<div style='display: flex; justify-content: center;'>"
                                + "<button class='btn btn-cancle btn-sm ansBtn' type='button' onclick='closeAjax()' style='background: #ecf0fd; color: #000000'>확인</button>";
                                if(role=='truck'){
                                    display +=""
                                        + "<button class='btn btn-default btn-sm' data-bs-toggle='modal' data-bs-target='#addTruckComment' onclick='updateReviewUpdate("+Data.review.rvNo+")' type='button' style='color: #000000'>수정하기</button>"
                                        + "</div>"
                                        + "</div>"
                                        + "</div>"
                                        + "</div>";
                                }else if(role=='user'){
                                    display+=""
                                        + "<button class='btn btn-default btn-sm' data-bs-toggle='modal' data-bs-target='#updateReview' onclick='updateReviewUpdate("+Data.review.rvNo+")' type='button' style='color: #000000'>수정하기</button>"
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


                    div += "<div class='row rvContent' style='justify-content: center; font-weight: bold;'>"
                        +"<div>"+data.review.rvContent+"</div>"
                        + "</div>"+"<div class='align-test'>";

                    $('.mb-3.truck').html(div);


                }

            })
            $('#addTruckComment').modal('show');
        }
        //사장님댓글 수정
        function updateReviewUpdate(rvNo) {

            var role = $('input[name="role"]').val();


            $.ajax({
                url:"/review/json/getReviewDetail/"+rvNo,
                method:"get",
                success:function(data){
                    var div="";
                    var modalFooter = "";
                    // var hit = data.post.postHit;
                     $('#hiddenRvNoNo').val(rvNo);
                     $('#hiddenRvNoNoNo').val(rvNo);

                    div += "<div class='row rvContent' style='justify-content: center; font-weight: bold;' >"
                        +"<div>"+data.review.rvContent+"</div>"
                        + "</div>"+"<div class='align-test'>";
                    $('#updateTruckCmtContent.form-control').text(data.review.rvTruckCmtContent);

                    $('.mb-3.truckUpdate').html(div);
                }
            })

            if(role=='truck') {
                $('#updateTruckComment').modal('show');
            }else{
                $('#updateUserReview').modal('show');
            }
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
                            <div class="card-body" style="display:flex; padding: 0 20px;">
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
                                        <p class="card-text"><h6><span class="badge" style="background-color: #fae100; color: #110000">OK</span></h6></p>
                                    </c:if>
                                    <c:if test="${review.rvTruckCmtContent eq null}">
                                        <p class="card-text"><h6><span class="badge" style="background-color: #ec6a56; color: #110000">No</span></h6></p>
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
               <%-- <div class="modal-header">
                    <h5 class="modal-title" id="updateTruckCmtModalLabel">사장님 댓글 달기</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>--%>
                <div class="modal-body">
                    <input type="hidden" id="NohiddenRvNo" name ="hiddenRvNo" value="">

                    <div style="text-align: -webkit-center;">
                        <h5 class="modal-title" id="updateTruckCmtModalLabel" style=" width: fit-content; margin: 10px 0 25px 0; box-shadow: inset 0 -11px 0 #fae100;">사장님 댓글</h5>
                    </div>

                    <hr style="margin: 10px 0;"/>

                    <form style="text-align: left;">
                        <div style="display: grid; padding: 0 20px;">
                            <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
                            <div class="mb-3 truck" style="margin-bottom: 0;">
                                <label for="addTruckCommentTitle" class="col-form-label">리뷰 정보</label>
                                <input type="text" class="form-control" id="addTruckCommentTitle">
                            </div>
                            <i class="fa fa-quote-left" aria-hidden="true" style="transform: scaleX(-1); color: #f17228;"></i>
                        </div>
                        <div class="mb-3" style="padding: 0 20px;">
                            <label for="inquiryAnsContent" class="col-form-label" style="font-weight: bold;">사장님 댓글 내용</label>
                            <textarea class="form-control" id="inquiryAnsContent"></textarea>
                        </div>
                    </form>

                    <hr style="margin: 10px 0;"/>

                    <div style="display: flex; justify-content: center;">
                        <button type="button" class="btn btn-cancle" data-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-default btn-sm" id="updateRVForAddTruckCmt">사장님 댓글등록</button>
                    </div>

                </div>
                <%--<div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-default btn-sm" id="updateRVForAddTruckCmt">사장님 댓글등록</button>
                </div>--%>
            </div>
        </div>
    </div>

    <!--수정하기-->
    <div class="modal fade" id="updateTruckComment" tabindex="-1" aria-labelledby="updateTruckComment" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <%--<div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">사장님 댓글 달기</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>--%>
                <div class="modal-body">
                    <input type="hidden" id="hiddenRvNoNo" name ="hiddenRvNoNo" value="">

                    <div style="text-align: -webkit-center;">
                        <h5 class="modal-title" id="exampleModalLabel" style=" width: fit-content; margin: 10px 0 25px 0; box-shadow: inset 0 -11px 0 #fae100;">사장님 댓글 수정</h5>
                    </div>

                    <hr style="margin: 10px 0;"/>

                    <form style="text-align: left;">
                        <div style="display: grid; padding: 0 20px;">
                            <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
                            <div class="mb-3 truckUpdate" style="margin-bottom: 0;">
                                <label for="updateTruckCommentTitle" class="col-form-label">리뷰 정보</label>
                                <input type="text" class="form-control" id="updateTruckCommentTitle">
                            </div>
                            <i class="fa fa-quote-left" aria-hidden="true" style="transform: scaleX(-1); color: #f17228;"></i>
                        </div>

                        <div class="mb-3"  style="padding: 0 20px;">
                            <label for="updateTruckCmtContent" class="col-form-label"  style="font-weight: bold;">사장님 댓글 내용</label>
                            <textarea class="form-control" id="updateTruckCmtContent"></textarea>
                        </div>
                    </form>

                    <hr style="margin: 10px 0;"/>

                    <div style="display: flex; justify-content: center;">
                        <button type="button" class="btn btn-cancle" data-bs-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-default btn-sm" id="updateRVForUpdateTruckCmt">사장님 댓글수정</button>
                    </div>

                </div>
                <%--<div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-default btn-sm" id="updateRVForUpdateTruckCmt">사장님 댓글수정</button>
                </div>--%>
            </div>
        </div>
    </div>
    <!--수정하기 - user-->
    <div class="modal fade" id="updateUserReview" tabindex="-1" aria-labelledby="updateUserReview" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateUserReviewModalLabel">리뷰 수정</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="hiddenRvNoNoNo" name ="hiddenRvNoNoNo" value="">
                    <form style="text-align: left;">
                        <div class="mb-3 truckUpdate">
                            <label for="updateTruckCommentTitle" class="col-form-label">리뷰 정보</label>
                            <input type="text" class="form-control" id="updateUserReviewTitle">
                        </div>
                        <div class="mb-3">
                            <div class="col">
                                <%--                <input type="text" class="form-control" id="rvStar" name="rvStar" value="${review.rvStar }" placeholder="리뷰 별점을 입력하세요.">--%>
                                <div class="star-rating space-x-4 mx-auto">
                                    <input type="hidden" name="ssttaarr" value=""/>
                                    <input type="radio" id="5-stars" name="rvStar" value="5"/>
                                    <label for="5-stars" class="star pr-4">★</label>
                                    <input type="radio" id="4-stars" name="rvStar" value="4"/>
                                    <label for="4-stars" class="star">★</label>
                                    <input type="radio" id="3-stars" name="rvStar" value="3"/>
                                    <label for="3-stars" class="star">★</label>
                                    <input type="radio" id="2-stars" name="rvStar" value="2"/>
                                    <label for="2-stars" class="star">★</label>
                                    <input type="radio" id="1-star" name="rvStar" value="1"/>
                                    <label for="1-star" class="star">★</label>
                                </div>
                            </div>
                            <label for="updateTruckCmtContent" class="col-form-label">리뷰 변경 내용</label>
                            <textarea class="form-control" id="updateReviewContent"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-default btn-sm" id="updateReview">리뷰 수정</button>
                </div>
            </div>
        </div>
    </div>
</section>

<script>

    $(function(){
        $('input[name="rvStar"]').on("click", function(){
            var star = $(this).val();
            console.log("star : "  + star);
            $('input[name="ssttaarr"]').val(star);
        })
    })

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



    /* 리뷰 수정 */
    $(function () {

        $('#updateReview').click(function () {



            var rvNo = $('#hiddenRvNoNoNo').val();
            var rvContent = $('#updateReviewContent').val();
            var rvStar = $('input[name="ssttaarr"]').val();


            console.log(rvNo);
            console.log(rvContent);
            console.log(rvStar);

            $.ajax({

                url : "/review/json/updateReview",
                method : "POST",
                dataType: "json",
                header : {
                    "Accept" : "application/json",
                    "Content-Type" : "application/json"
                },
                data : {
                    rvNo : rvNo,
                    rvContent : rvContent,
                    rvStar : rvStar
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
