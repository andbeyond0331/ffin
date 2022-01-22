<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">


<head>

    <title>F.FIN | 쿠폰 발급 </title>
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
            margin-top: 5px;
            display: flex;
            justify-content: center;
            font-size: 16px;
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

        #inquiryAnsContent{
            min-height: 150px;
        }
        a, a:hover {
            text-decoration: none;
            transition: color 0.3s ease-in-out;
        }
        .postcard {
            flex-wrap: wrap;
            display: flex;

            box-shadow: 0 4px 21px -12px rgba(0, 0, 0, 0.66);
            border-radius: 10px;
            margin: 0 0 2rem 0;
            overflow: hidden;
            position: relative;
            color: #ffffff;
        }
        .postcard.dark {
            background-color: #18151f;
        }
        .postcard.light {
            background-color: #ffffff;
        }
        .t-dark {
            color: #18151f;
        }
        .postcard a {
            color: inherit;
        }
        .postcard h1, .h1 {
            margin-bottom: 0.5rem;
            font-weight: 500;
            line-height: 1.2;
            text-align: initial;
        }
        .small {
            font-size: 80%;
            text-align: initial;
        }
        .postcard__title {
            font-size: 1.25rem;
        }
        .postcard__img {
            max-height: 180px;
            width: 100%;
            object-fit: cover;
            position: relative;
        }
        .postcard__img_link {
            display: contents;
        }
        .postcard__bar {
            width: 50px;
            height: 10px;
            margin: 10px 0;
            border-radius: 5px;
            background-color: #fae100;
            transition: width 0.2s ease;
        }

        .postcard__text {
            padding: 1.5rem;
            position: relative;
            display: flex;
            flex-direction: column;
        }
        .postcard__preview-txt {
            overflow: hidden;
            text-overflow: ellipsis;
            text-align: justify;
            height: 100%;
        }
        .postcard__tagbox {
            display: flex;
            flex-flow: row wrap;
            font-size: 14px;
            margin: 20px 0 0 0;
            padding: 0;
            justify-content: center;
        }
        .tag__item {
            display: inline-block;
            background: rgb(255, 255, 255);
            border-radius: 3px;
            padding: 2.5px 10px;
            margin: 0 5px 5px 0;
            cursor: default;
            user-select: none;
            transition: background-color 0.3s;
            border-radius: 20px;
        }
        .tag__item:hover{
            background: rgb(250, 225, 0);
            border-radius: 20px;
        }
        .postcard:before{
            content: "";
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            background-image: linear-gradient(-70deg, #ffffff, transparent 50%);
            opacity: 1;
            border-radius: 10px;
        }
        .postcard:hover .postcard__bar {
            width: 100px;
        }

        @media screen and (min-width: 769px) {

            .postcard {
                flex-wrap: inherit;
            }

            .postcard__title {
                font-size: 2rem;
            }

            .postcard__tagbox {
                justify-content: start;
            }

            .postcard__img {
                max-width: 300px;
                max-height: 100%;
                transition: transform 0.3s ease;
            }

            .postcard__text {
                padding: 3rem;
                width: 100%;
            }

            .media.postcard__text:before {
                content: "";
                position: absolute;
                display: block;
                background: #ffffff;
                top: -20%;
                height: 130%;
                width: 55px;
            }

            .postcard:hover .postcard__img {
                transform: scale(1.1);
            }

            .postcard:nth-child(2n+1) {
                flex-direction: row;
            }

            .postcard:nth-child(2n+0) {
                flex-direction: row-reverse;
            }

            .postcard:nth-child(2n+1) .postcard__text::before {
                left: -12px !important;
                transform: rotate(4deg);
            }

            .postcard:nth-child(2n+0) .postcard__text::before {
                right: -12px !important;
                transform: rotate(-4deg);
            }
        }

        @media screen and (min-width: 1024px){
            .postcard__text {
                padding: 2rem 3.5rem;
            }

            .postcard__text:before {
                content: "";
                position: absolute;
                display: block;

                top: -20%;
                height: 130%;
                width: 55px;
            }

            .postcard.dark {
                background: #18151f;
            }
            .postcard__text:before {
                background: #ffffff;
            }
            .postcard.light {
                background: rgb(255, 255, 255);
            }
            .postcard__text:before {
                background: rgb(255, 255, 255);
            }
        }

        .postcard .postcard__tagbox .blue.play:hover {
            background: #fae100;
        }
        .blue .postcard__title:hover {
            color: #fae100;
        }
        .blue .postcard__bar {
            background-color: #fae100;
        }
        /*    .blue::before {
              background-image: linear-gradient(-30deg, rgba(255, 229, 55, 0.16), transparent 50%);
            }
            .blue:nth-child(2n)::before {
              background-image: linear-gradient(30deg, rgba(255, 229, 55, 0.16), transparent 50%);
            }*/


    </style>
    <!-- google -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDqWPYtQyM3eS3xjLTGzTGSbiXqfTaIbEM&x	v=3.exp"></script>

    <script type="text/javascript">
        $(function() {
            $("body").on("click", "#rainCoupon", function () {
                findLocation("rain");
            });

            $("body").on("click", "#snowCoupon", function () {
                findLocation("snow");
            });
        });



        function findLocation(weather){

            // Geolocation API, 위도 경도 찾기
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(showYourLocation, showErrorMsg);
            }
            else {

            }

            // 위치 확인 내부 함수 정의
            function showYourLocation(position) {
                var userLat = position.coords.latitude;
                var userLng = position.coords.longitude;

                // openWeather 적용
                getDataByLocating(userLat, userLng, weather);

            }


            // 에러 확인 내부 함수 정의
            function showErrorMsg(error) {
                // console.log("");
                // console.log("showErrorMsg : error : " + error.code);
                switch(error.code) {
                    case error.PERMISSION_DENIED:
                        console.log("showErrorMsg : error : " + "Geolocation API의 사용 요청을 거부했습니다");
                        break;

                    case error.POSITION_UNAVAILABLE:
                        console.log("showErrorMsg : error : " + "위치 정보를 사용할 수 없습니다");
                        break;

                    case error.TIMEOUT:
                        console.log("showErrorMsg : error : " + "위한 요청이 허용 시간을 초과했습니다");
                        break;

                    case error.UNKNOWN_ERROR:
                        console.log("showErrorMsg : error : " + "알 수 없는 오류가 발생했습니다");
                        break;
                }
                console.log("");
            }





        };
        function getDataByLocating(la, lon, weather){
            var URL = "https://api.openweathermap.org/data/2.5/weather?lat="+la+"&lon="+lon+"&units=metric&appid=be78cfd9bc9ce8e44adfd5004caf3134";


            $.ajax({
                url: URL,
                dataType: "json",
                type: "GET",
                async: "false",
                success: function(resp) {
                    console.log(resp);
                    console.log("현재온도 : "+ resp.main.temp );
                    console.log("날씨 아이디  : "+ resp.weather[0].id);
                    console.log("날씨 : "+ resp.weather[0].main );
                    console.log("상세날씨설명 : "+ resp.weather[0].description );
                    console.log("날씨 이미지 : "+ resp.weather[0].icon );
                    console.log("바람   : "+ resp.wind.speed );
                    console.log("나라   : "+ resp.sys.country );
                    console.log("도시이름  : "+ resp.name );
                    console.log("구름  : "+ (resp.clouds.all) +"%" );

                    const str1 = (resp.weather[0].id).toString();

                    let weatherGroupCode =str1.substr(0, 1);
                    console.log("weatherGroupCode: "+weatherGroupCode);
                    console.log("weather: "+weather)
                    var weatherCheck='f'; // 날씨 체크
                    /*
                        weatherGroupCode : 5 - Rain
                        weatherGroupCode : 6 - Snow
                     */
                    if (weather == 'rain' && weatherGroupCode =='8'){
                        weatherCheck ='t';
                    }else if (weather == 'snow' && weatherGroupCode =='6'){
                        weatherCheck ='t';
                    }

                    if (weatherCheck == 't'){
                        //ajax
                        $.ajax({
                            url : '/purchase/json/addCoupon',
                            type : 'get',
                            data : {
                                couponType : weather
                            },
                            success : function(pto) {
                                alert(pto.message)
                            },
                            error : function() {
                                alert('서버 에러');
                            }
                        });
                    }else{
                        alert(" 고객님이 계신 곳의 날씨는 "+resp.weather[0].main+"입니다. 다음에 다시 발급해주세요 ! ");
                    }


                }
            });
        }


    </script>

</head>

<body>
<jsp:include page="/views/navbar.jsp" />


<section class="client_section layout_padding">

    <div class="container">
        <div class="col-md-11 col-lg-12 mx-auto">

            <div class="detail-box">
                <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
                <h4 style="margin-top: 10px;">
                    쿠폰발급
                </h4>
            </div>



                <section class="light">
                    <div class="container py-2">

                        <article class="postcard light blue" id="rainCoupon">
                                <img class="postcard__img" src="/resources/image/1.jpg" alt="Image Title" />
                            <div class="postcard__text t-dark">
                                <h1 class="postcard__title blue"><a href="#">비오는 날 쿠폰</a></h1>

                                <div class="postcard__bar"></div>
                                <div class="postcard__preview-txt">비 오는 날엔 언제나 할인</div>
                                <div class="postcard__preview-txt">현재 위치 기준으로 발급됩니다.</div>
                                <div class="postcard__preview-txt"><h6>3000원</h6></div>

                                <ul class="postcard__tagbox">
                                    <li class="tag__item orderBtn"><i class="fas fa-tag mr-2"></i>비가와비가와</li>

                                </ul>
                            </div>
                        </article>

                        <article class="postcard light blue" id="snowCoupon">

                                <img class="postcard__img" src="/resources/image/1.jpg" alt="Image Title" />

                            <div class="postcard__text t-dark">
                                <h1 class="postcard__title blue"><a href="#">눈오는 날 쿠폰</a></h1>
                                <div class="postcard__bar"></div>
                                <div class="postcard__preview-txt">눈 오는 날엔 언제나 할인</div>
                                <div class="postcard__preview-txt">현재 위치 기준으로 발급됩니다.</div>
                                <div class="postcard__preview-txt"><h6>3000원</h6></div>

                                <ul class="postcard__tagbox">
                                    <li class="tag__item orderBtn"><i class="fas fa-tag mr-2"></i>눈이와 눈이와</li>

                                </ul>
                            </div>
                        </article>

                    </div>
                </section>





        </div>
    </div>


</section>
<jsp:include page="/views/footer.jsp" />
</body>
</html>