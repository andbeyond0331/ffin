<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">


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
    <!-- Favicons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.2.0/css/all.min.css" integrity="sha512-6c4nX2tn5KbzeBJo9Ywpa0Gkt+mzCzJBrE1RB6fmpcsoN+b/w/euwIMuQKNyUoU/nToKN3a8SgNOtPrbW12fug==" crossorigin="anonymous" />


    <style>
        .container.sidebar{
            position: fixed;
            width: 60px;
            height: 100%;
            background: #ffe537;
            transition: 0.5s;
            overflow: hidden;
        }

        .container.sidebar:hover,
        .container.sidebar.active{
            width: 300px;
        }


        .container.sidebar ul{
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            margin-top: 250px;
        }
        .container.sidebar ul li{
            position: relative;
            width: 100%;
            list-style: none;
        }

        .container.sidebar ul li:hover{
            background-color: #ffba49;
        }

        .container.sidebar ul li a{
            position: relative;
            display: block;
            width: 100%;
            display: flex;
            text-decoration: none;
            color: #ffffff;
        }

        .container.sidebar ul li a .icon {
            position: relative;
            display: flex;
            min-width: 60px;
            height: 60px;
            line-height: 60px;
            text-align: center;
        }

        .container.sidebar ul li a .title {
            position: relative;
            display: block;
            padding: 0 10px;
            height: 60px;
            line-height: 60px;
            text-align: start;
            white-space: nowrap;
        }

        .toggle-sidebar{
            position: absolute;
            top: 0;
            right: 0;
            width: 60px;
            height: 60px;
            margin-top: 250px;
            background: #ffe537;
            cursor: pointer;
        }

        .toggle-sidebar:active{
            background: #ffba49;
        }

        .toggle-sidebar:before{
            content: '\f0c9 ';
            font-family: FontAwesome;
            position: absolute;
            width: 100%;
            height: 100%;
            line-height: 60px;
            text-align: center;
            font-size: 24px;
            color: white;
        }

        .toggle-sidebar:active:before{
            content: '\f00d ';
        }

        @media (max-width: 767px){
            .container.sidebar{
                left: -60px;
            }
            .container.sidebar.active{
                left: -60px;
            }
        }
    </style>

    <script type="text/javascript">
        function toggleMenu(){
            let navigation = document.querySelector('.container.sidebar');
            let toggle = document.querySelector('.toggle-sidebar');
            navigation.classList.toggle('active');
            toggle.classList.toggle('active');
        }
    </script>
</head>

<body>
    <%-- sidebar --%>
    <div class="container sidebar">
        <ul>
            <li>
                <a href="#">
                    <span class="icon"><i class="fas fa-home"></i></span>
                    <span class="title">Mypage</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <span class="icon"><i class="fas fa-user-alt"></i></span>
                    <span class="title">내정보</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <span class="icon"><i class="fas fa-shopping-basket"></i></span>
                    <span class="title">구매내역</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <span class="icon"><i class="fas fa-donate"></i></span>
                    <span class="title">적립금</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <span class="icon"><i class="far fa-money-bill-alt"></i></span>
                    <span class="title">쿠폰</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <span class="icon"><i class="fas fa-heart"></i></span>
                    <span class="title">좋아요</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <span class="icon"><i class="fas fa-star-half-alt"></i></span>
                    <span class="title">리뷰</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <span class="icon"><i class="far fa-edit"></i></span>
                    <span class="title">글•댓글</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <span class="icon"><i class="far fa-question-circle"></i></span>
                    <span class="title">문의•신고</span>
                </a>
            </li>
        </ul>
    </div>
    <div class="toggle-sidebar" onclick="toggleMenu()"></div>
</body>
</html>