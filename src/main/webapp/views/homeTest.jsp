<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">

<head>

    <script type="text/javascript">

        function loginModal(){
            $('#openLoginModal').modal('show');
        }

    </script>



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
    <link rel="stylesheet" type="text/css" href="../resources/bootstrap/css/bootstrap.css" />

    <!-- fonts style -->
    <link href="https://fonts.googleapis.com/css?family=Poppins:400,600,700&display=swap" rel="stylesheet">

    <!-- font awesome style -->
    <link href="../resources/bootstrap/css/font-awesome.min.css" rel="stylesheet" />
    <!-- nice select -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" integrity="sha256-mLBIhmBvigTFWPSCtvdu6a76T+3Xyt+K571hupeFLg4=" crossorigin="anonymous" />
    <!-- slidck slider -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css" integrity="sha256-UK1EiopXIL+KVhfbFa8xrmAWPeBjMVdvYMYkTAEv/HI=" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css.map" integrity="undefined" crossorigin="anonymous" />


    <!-- Custom styles for this template -->
    <link href="../resources/bootstrap/css/style.css" rel="stylesheet" />
    <!-- responsive style -->
    <link href="../resources/bootstrap/css/responsive.css" rel="stylesheet" />

    <!--    Favicons-->
    <link rel="apple-touch-icon" sizes="180x180" href="../resources/bootstrap/assets/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="../resources/bootstrap/assets/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../resources/bootstrap/assets/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="../resources/bootstrap/assets/favicons/favicon.ico">
    <link rel="manifest" href="../resources/bootstrap/assets/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="../resources/bootstrap/assets/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">

</head>

<body id="page-top">




<div class="hero_area">

    <!-- toolbar -->
    <jsp:include page="/views/toolbar.jsp" />


    <!-- slider section -->
    <section class="slider_section ">
        <div class="container ">
            <div class="row">
                <div class="col-lg-10 mx-auto">
                    <div class="detail-box">
                        <h1 class="display-1 fs-md-5 fs-lg-6 fs-xl-8 text-light">
                            FoodTruck Finder
                        </h1>
                        <h5 class="text-800 mb-5 fs-4">Within a few clicks,<br class="d-none d-xxl-block" /><br/>find foodtruck are accessible near you</h5>
                    </div>
                    <div class="find_container ">
                        <div class="container">
                            <div class="row">
                                <div class="col">
                                    <form>
                                        <div class="form-row ">
                                            <div class="form-group col-lg-6">
                                                <input type="text" class="form-control" id="inputLocation" placeholder="What's your address?">
                                                <span class="location_icon">
                                                    <i class="fa fa-map-marker" aria-hidden="true"></i>
                                                  </span>
                                            </div>
                                        </div>
                                        <div class="form-row ">
                                            <div class="form-group col-md-4">
                                                <div class="btn-box">
                                                    <button type="submit" class="btn ">Use current location</button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="slider_container">
            <div class="item">
                <div class="img-box">
                    <img src="../resources/bootstrap/images/foodtruck_default.jpg" alt="" />
                </div>
            </div>
            <div class="item">
                <div class="img-box">
                    <img src="../resources/bootstrap/images/foodtruck_default.jpg" alt="" />
                </div>
            </div>
            <div class="item">
                <div class="img-box">
                    <img src="../resources/bootstrap/images/foodtruck_default.jpg" alt="" />
                </div>
            </div>
            <div class="item">
                <div class="img-box">
                    <img src="../resources/bootstrap/images/foodtruck_default.jpg" alt="" />
                </div>
            </div>
            <div class="item">
                <div class="img-box">
                    <img src="../resources/bootstrap/images/foodtruck_default.jpg" alt="" />
                </div>
            </div>
            <div class="item">
                <div class="img-box">
                    <img src="../resources/bootstrap/images/foodtruck_default.jpg" alt="" />
                </div>
            </div>
            <div class="item">
                <div class="img-box">
                    <img src="../resources/bootstrap/images/foodtruck_default.jpg" alt="" />
                </div>
            </div>
            <div class="item">
                <div class="img-box">
                    <img src="../resources/bootstrap/images/foodtruck_default.jpg" alt="" />
                </div>
            </div>
        </div>
    </section>
    <!-- end slider section -->
</div>


<!-- Popular Foodtruck section -->

<section class="recipe_section layout_padding-top">
    <div class="container">
        <div class="heading_container heading_center">
            <h2>
                Popular Foodtruck
            </h2>
        </div>
        <div class="row">
            <div class="col-sm-6 col-md-4 mx-auto">
                <div class="box">
                    <div class="img-box">
                        <img src="../resources/bootstrap/images/food1.png" class="box-img" alt="">
                    </div>
                    <div class="detail-box">
                        <h5> MenuName </h5>
                        <div><span class="text-warning me-2"><i class="fas fa-map-marker-alt"></i></span><span class="text-primary">TruckName</span></div><span class="text-1000 fw-bold">₩5,000</span>
                        <br/>
                        <a href="">
                            <i class="fa fa-arrow-right" aria-hidden="true"></i>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-4 mx-auto">
                <div class="box">
                    <div class="img-box">
                        <img src="../resources/bootstrap/images/food2.png" class="box-img" alt="">
                    </div>
                    <div class="detail-box">
                        <h5> MenuName </h5>
                        <div><span class="text-warning me-2"><i class="fas fa-map-marker-alt"></i></span><span class="text-primary">TruckName</span></div><span class="text-1000 fw-bold">₩5,000</span>
                        <br/>
                        <a href="">
                            <i class="fa fa-arrow-right" aria-hidden="true"></i>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-4 mx-auto">
                <div class="box">
                    <div class="img-box">
                        <img src="../resources/bootstrap/images/food3.png" class="box-img" alt="">
                    </div>
                    <div class="detail-box">
                        <h5> MenuName </h5>
                        <div><span class="text-warning me-2"><i class="fas fa-map-marker-alt"></i></span><span class="text-primary">TruckName</span></div><span class="text-1000 fw-bold">₩5,000</span>
                        <br/>
                        <a href="">
                            <i class="fa fa-arrow-right" aria-hidden="true"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="btn-box">
            <a href="">
                more FoodTruck
            </a>
        </div>
    </div>
</section>
<!-- end Popular Foodtruck section -->


<!-- coupon section -->
<section class="about_section layout_padding">
    <div class="container">
        <div class="col-md-11 col-lg-10 mx-auto">
            <div class="heading_container heading_center">
                <h2>
                    Coupon
                </h2>
            </div>
            <div class="box">
                <div class="col-md-7 mx-auto">
                    <div class="img-box">
                        <img src="../resources/bootstrap/images/weather.png" class="box-img" alt="">
                    </div>
                </div>
                <div class="detail-box">
                    <p>coupon 받아가라... font 적용 어떻게하냐....</p>
                </div>
                <div class="btn-box">
                    <a href="">
                        coupon
                    </a>
                </div>
            </div>
        </div>

    </div>
</section>

<!-- end coupon section -->

<!-- end select start-->

<section class="about_section layout_padding">
    <div class="container">
        <div class="col-md-11 col-lg-10 mx-auto">
            <div class="heading_container heading_center">
                <h2>
                    Let's do it together
                </h2>
            </div>
            <div class="box">
                <div class="col-md-7 mx-auto">
                    <div class="img-box">
                        <img src="../resources/bootstrap/images/handshake.png" class="box-img" alt="">
                    </div>
                </div>
                <div class="detail-box">
                    <p>Grow with F.FIN! <br/> Our technology and user base can help you boost sales and unlock new opportunities!</p>

                    <%--<a href="">
                        <i class="fa fa-arrow-right" aria-hidden="true"></i>
                    </a>--%>
                </div>
                <div class="btn-box">
                    <a href="">
                        Join us!
                    </a>
                </div>
            </div>
        </div>

    </div>
</section>
<!-- end select end-->


<!-- footer -->
<jsp:include page="/views/footer.jsp" />

<!-- jQery -->
<script src="../resources/bootstrap/js/jquery-3.4.1.min.js"></script>
<!-- bootstrap js -->
<script src="../resources/bootstrap/js/bootstrap.js"></script>
<!-- slick  slider -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.js"></script>
<!-- nice select -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js" integrity="sha256-Zr3vByTlMGQhvMfgkQ5BtWRSKBGa2QlspKYJnkjZTmo=" crossorigin="anonymous"></script>
<!-- custom js -->
<script src="../resources/bootstrap/js/custom.js"></script>

</body>

</html>