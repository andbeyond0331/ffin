
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
<head>

    <title>트럭 목록</title>
    <jsp:include page="../../common/lib.jsp"/>

    <style>
        @import url(https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap);

        body {
            background: #f9f9f9;
            font-family: "roboto", sans-serif;
        }

        .main-content {
            padding-top: 100px;
            padding-bottom: 100px;
        }

        a {
            text-decoration: none;
        }

        .food-card {
            background: #fff;
            border-radius: 5px;
            overflow: hidden;
            margin-bottom: 30px;
            -webkit-box-shadow: 0 2px 10px rgba(0, 0, 0, 0.06);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.06);
            -webkit-transition: 0.1s;
            transition: 0.1s;
        }

        .food-card:hover {
            -webkit-box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

        .food-card .food-card_img {
            display: block;
            position: relative;
        }

        .food-card .food-card_img img {
            width: 100%;
            height: 200px;
            -o-object-fit: cover;
            object-fit: cover;
        }

        .food-card .food-card_img i {
            position: absolute;
            top: 20px;
            right: 30px;
            color: #fff;
            font-size: 25px;
            -webkit-transition: all 0.1s;
            transition: all 0.1s;
        }

        .food-card .food-card_img i:hover {
            top: 18px;
            right: 28px;
            font-size: 29px;
        }

        .food-card .food-card_content {
            padding: 15px;
        }

        .food-card .food-card_content .food-card_title-section {
            height: 100px;
            overflow: hidden;
        }

        .food-card .food-card_content .food-card_title-section .food-card_title {
            font-size: 24px;
            color: #333;
            font-weight: 500;
            display: block;
            line-height: 1.3;
            margin-bottom: 8px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .food-card .food-card_content .food-card_title-section .food-card_author {
            font-size: 15px;
            display: block;
        }

        .food-card .food-card_content .food-card_bottom-section .space-between {
            display: -webkit-box;
            display: -ms-flexbox;
            display: flex;
            -webkit-box-pack: justify;
            -ms-flex-pack: justify;
            justify-content: space-between;
        }

        .food-card .food-card_content .food-card_bottom-section .food-card_subscribers {
            margin-left: 17px;
        }

        .food-card .food-card_content .food-card_bottom-section .food-card_subscribers img,
        .food-card .food-card_content .food-card_bottom-section .food-card_subscribers .food-card_subscribers-count {
            height: 45px;
            width: 45px;
            border-radius: 45px;
            border: 3px solid #fff;
            margin-left: -17px;
            float: left;
            background: #f5f5f5;
        }

        .food-card .food-card_content .food-card_bottom-section .food-card_subscribers .food-card_subscribers-count {
            position: relative;
        }

        .food-card .food-card_content .food-card_bottom-section .food-card_subscribers .food-card_subscribers-count span {
            position: absolute;
            top: 50%;
            left: 50%;
            -webkit-transform: translate(-50%, -50%);
            transform: translate(-50%, -50%);
            font-size: 13px;
        }

        .food-card .food-card_content .food-card_bottom-section .food-card_price {
            font-size: 28px;
            font-weight: 500;
            color: #F47A00;
        }

        .food-card .food-card_content .food-card_bottom-section .food-card_order-count {
            width: 130px;
        }

        .food-card .food-card_content .food-card_bottom-section .food-card_order-count input {
            background: #f5f5f5;
            border-color: #f5f5f5;
            -webkit-box-shadow: none;
            box-shadow: none;
            text-align: center;
        }

        .food-card .food-card_content .food-card_bottom-section .food-card_order-count button {
            border-color: #f5f5f5;
            border-width: 3px;
            -webkit-box-shadow: none;
            box-shadow: none;
        }

        @media (min-width: 992px) {
            .food-card--vertical {
                display: -webkit-box;
                display: -ms-flexbox;
                display: flex;
                position: relative;
                height: 235px;
            }

            .food-card--vertical .food-card_img img {
                width: 200px;
                height: 100%;
                -o-object-fit: cover;
                object-fit: cover;
            }
        }
    </style>




    <!-- Bootstrap core CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">



    <!--  ///////////////////////// CSS ////////////////////////// -->
    <style>
        body {
            padding-top : 50px;
        }

        .nav{
            margin-left: 101px;
        }

        li.nav-item-custom{
            color: #ffcf46;
        }

    </style>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //============= "추가"  Event 연결 =============
        // $(function() {
        //     //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
        //     $( "#updateMenuButton" ).on("click" , function() {
        //         //fncApplyOptionNo();
        //         fncUpdateMenu();
        //     });
        // });

        //============= "취소"  Event 처리 및  연결 =============
        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("a[href='#' ]").on("click" , function() {
                $("form")[0].reset();
            });
        });



        $(function(){



            $(document).on("click", "#updateMenuButton", function(){


                //var truckId = $("input[name='truckId']").val();
                alert("optionGroup개수 : " +$('input#optionGroupName.form-control').length);

                if($('input#optionGroupName.form-control').length===0){
                    $("form").attr("method", "POST").attr("action", "/menu/updateMenu").attr("enctype","multipart/form-data").submit();
                } else{
                    console.log("fncUpdateMenu-target : "+$("form.form-horizontal").html());

                    $("form").attr("method", "POST").attr("action","/menu/updateMenuOptionGroup").submit();
                    // $("form").post("/menu/addMenuOptionGroup", {}, "text")

                }

            });

        });

    </script>

</head>

<body>

<!-- ToolBar Start /////////////////////////////////////-->
<jsp:include page="/views/navbar.jsp" />
<!-- ToolBar End /////////////////////////////////////-->

<br>
<br>
<br>
<br>
<br>
<h4>
<div class="d-flex align-items-start">
    <div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" area-orientation="vertical">
<%--        <a class="nav-link active" aria-current="page" href="#">고기</a>--%>
        <button class="nav-link active"  id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">고기</button>

        <button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">분식</button>

        <button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">음료</button>

        <button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">양식</button>

        <button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">디저트</button>

        <button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">한식</button>

        <button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">일식</button>

        <button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">기타</button>
    </div>

</div>
</h4>
<section class="main-content">
    <div class="container">
        <h1 class="text-center text-uppercase">Food Order Card</h1>
        <br>
        <br>
        <div class="row">
<%--            <div class="col-sm-6 col-md-6 col-lg-4">--%>
<%--                <div class="food-card">--%>
<%--                    <div class="food-card_img">--%>
<%--                        <img src="https://i.imgur.com/eFWRUuR.jpg" alt="">--%>
<%--                        <a href="#!"><i class="far fa-heart"></i></a>--%>
<%--                    </div>--%>
<%--                    <div class="food-card_content">--%>
<%--                        <div class="food-card_title-section">--%>
<%--                            <a href="#!" class="food-card_title">Double Cheese Potato Burger</a>--%>
<%--                            <a href="#!" class="food-card_author">Burger</a>--%>
<%--                        </div>--%>
<%--                        <div class="food-card_bottom-section">--%>
<%--                            <div class="space-between">--%>
<%--                                <div>--%>
<%--                                    <span class="fa fa-fire"></span> 220 - 280 Kcal--%>
<%--                                </div>--%>
<%--                                <div class="pull-right">--%>
<%--                                    <span class="badge badge-success">Veg</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <hr>--%>
<%--                            <div class="space-between">--%>
<%--                                <div class="food-card_price">--%>
<%--                                    <span>5.99$</span>--%>
<%--                                </div>--%>
<%--                                <div class="food-card_order-count">--%>
<%--                                    <div class="input-group mb-3">--%>
<%--                                        <div class="input-group-prepend">--%>
<%--                                            <button class="btn btn-outline-secondary minus-btn" type="button" id="button-addon1"><i class="fa fa-minus"></i></button>--%>
<%--                                        </div>--%>
<%--                                        <input type="text" class="form-control input-manulator" placeholder="" aria-label="Example text with button addon" aria-describedby="button-addon1" value="0">--%>
<%--                                        <div class="input-group-append">--%>
<%--                                            <button class="btn btn-outline-secondary add-btn" type="button" id="button-addon1"><i class="fa fa-plus"></i></button>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
            <div class="col-sm-6 col-md-6 col-lg-6">
                <div class="food-card food-card--vertical">
                    <div class="food-card_img">
                        <img src="https://i.imgur.com/eFWRUuR.jpg" alt="">
                        <a href="#!"><i class="fa fa-heart"></i></a>
                    </div>
                    <div class="food-card_content">
                        <div class="food-card_title-section">
                            <a href="#!" class="food-card_title">Double Cheese Potato Burger</a>
                            <a href="#!" class="food-card_author">Burger</a>
                        </div>
                        <div class="food-card_bottom-section">
                            <div class="space-between">
                                <div>
                                    <span class="fa fa-fire"></span> 220 - 280 Kcal
                                </div>
                                <div class="pull-right">
                                    <span class="badge badge-success">Veg</span>
                                </div>
                            </div>
                            <hr>
                            <div class="space-between">
                                <div class="food-card_price">
                                    <span>5.99$</span>
                                </div>
                                <div class="food-card_order-count">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
<%--                                            <button class="btn btn-outline-secondary minus-btn" type="button" id="button-addon1"><i class="fa fa-minus"></i></button>--%>
<%--                                        </div>--%>
<%--                                        <input type="text" class="form-control input-manulator" placeholder="" aria-label="Example text with button addon" aria-describedby="button-addon1" value="0">--%>
<%--                                        <div class="input-group-append">--%>
<%--                                            <button class="btn btn-outline-secondary add-btn" type="button" id="button-addon1"><i class="fa fa-plus"></i></button>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="/views/footer.jsp" />
</body>



</html>



