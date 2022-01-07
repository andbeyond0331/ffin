<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">

<head>

    <title>F.FIN | FOODTRUCK FINDER</title>

    <jsp:include page="../common/lib.jsp"/>

    <script type="text/javascript">

        function loginModal(){
            $('#openLoginModal').modal('show');
        }

    </script>

    <script type="text/javascript">

        // $(function(){
        //     alert("'#call': " +$('#call').html());
        //     $('#call').on('click', function(){
        //         self.location = "/menu/getMenu?menuNo=1";
        //     });
        // });

        // $(function(){
        //     alert($("input[name='toMenu']").html());
        //     $("body").on("click", "input[name='toMenu']", function() {
        //         // location.replace("http://127.0.0.1:8080/menu/getMenu?menuNo=1")
        //         self.location="/menu/getMenu?menuNo=1";
        //     });
        // });

        // function fncGetMenuOptionGroupYap(){
        //     location.replace('http://127.0.0.1:8080/menu/getMenu?menuNo=1');
        // };



    </script>

</head>

<body id="page-top">




<div class="hero_area">

    <!-- toolbar -->
    <jsp:include page="/views/navbar.jsp" />

    <!-- slider section -->
    <section class="slider_section ">
        <div class="container ">
            <div class="row">
                <div class="col-lg-10 mx-auto">
                    <div class="detail-box" style="margin-bottom: -40px;">
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
                                        <div class="form-row" style="margin-top: 70px;">
                                            <div class="form-group col-lg-6">
                                                <input type="text" class="form-control" id="inputLocation" placeholder="What's your address?">
                                                <span class="location_icon">
                                                    <i class="fa fa-map-marker" aria-hidden="true"></i>
                                                  </span>
                                            </div>
                                        </div>
                                        <div class="form-row"  style="margin-top: -15px;">
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
                        <a href="http://127.0.0.1:8080/menu/getMenu?menuNo=1">
                            <i class="fa fa-arrow-right" aria-hidden="true" name="minus"></i>
<%--                            <button type="button" class="fa fa-arrow-right" aria-hidden="true" id="call" onclick="fncGetMenuOptionGroupYap();">누르렴</button>--%>
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
                        <a href="http://127.0.0.1:8080/menu/getMenu?menuNo=2">
<%--                            <i class="fa fa-arrow-right" aria-hidden="true"></i>// todo--%>
<%--                            <input type="button" name="toMenu" value="누르렴">--%>
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
                        <a href="http://127.0.0.1:8080/menu/getMenu?menuNo=29">
                            <i class="fa fa-arrow-right" aria-hidden="true"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="btn-box">
            <a href="http://127.0.0.1:8080/truck/getTruckList">
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
                        <img src="../resources/bootstrap/images/weather01.png" class="box-img" alt="">
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

<script src="../resources/bootstrap/js/custom.js"></script>

</body>

</html>