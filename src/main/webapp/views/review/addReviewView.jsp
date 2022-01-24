
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
<head>

    <title>리뷰 등록</title>
    <jsp:include page="../../common/lib.jsp"/>

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <%--    <link rel="canonical" href="https://getbootstrap.com/docs/5.1/examples/modals/">--%>



    <!-- Bootstrap core CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <%--    <meta name="theme-color" content="#7952b3">--%>

    <%--    <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->--%>
    <%--    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>--%>


    <!--  ///////////////////////// CSS ////////////////////////// -->
    <style>
        body {
            padding-top : 50px;
        }

    </style>

    <script type="text/javascript">


        //============= "추가"  Event 연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            // alert("나와라 : " +  $( "#addReviewButton" ).html());
            $("#addReviewButton").on("click", function () {
                fncAddReview();
            });
        });

        //============= "취소"  Event 처리 및  연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("a[href='#' ]").on("click", function () {
                $("form")[0].reset();
            });
        });

        function fncAddReview() {

            // var rvOrderNo = $("input[name='rvOrderNo']").val();
            $(".form-horizontal").attr("method", "POST").attr("action", "/review/addReviewER").attr("enctype", "multipart/form-data").submit();
            // $(".form-horizontal").attr("method","POST").attr("action","/review/addReviewER").submit();
        }

        // })


    </script>

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
            -webkit-text-stroke-width:  1.2999999999999998px;
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
        .page-header{
            margin-top:59px;
        }
        img{
            border-radius: 10px;
            box-shadow: 0 1px 2px 1px rgba(0,0,0,0.1);
            transition: 0.2s;
        }
        input[type=text]{
            border-radius: 50px;
        }
        input[type=text]:focus{
            border-color: #ffe537;
            box-shadow: 0 0 0 1px #ffe537;
            color: #ffe537;
        }
        label{
            font-weight: bold;
        }

    </style>

</head>

<body>

<!-- ToolBar Start /////////////////////////////////////-->
<jsp:include page="/views/navbar.jsp" />
<!-- ToolBar End /////////////////////////////////////-->

<!--  화면구성 div Start /////////////////////////////////////-->
<section class="client_section layout_padding">
    <div class="container">

        <div class="detail-box" style="margin-top: 20px;">
            <i class="fa fa-quote-left" aria-hidden="true"></i>
            <h4 style="margin-top: 10px;">
                리뷰 등록
            </h4>
        </div>

        <div class="forCenter" style="text-align: -webkit-center; margin-top: 60px;">
            <!-- form Start /////////////////////////////////////-->
            <form class="form-horizontal">
                <input type="hidden" name="rvOrderNo" value="${purchase.orderNo}">

                <div class="forCenter" style="text-align: -webkit-center; margin-top: 60px;">

                    <c:set var="i" value="0"/>
                    <c:forEach var="cart" items="${orderDetail.get('list')}">
                        <c:set var="i" value="${i+1}"/>
                        <div style="float: none; margin:0 auto; justify-content: center;">
                                <%--            <div >--%>

                                <%--                    ${i}--%>
                                <%--            </div>--%>
                                <%--            <div></div>--%>

                                <%--            <div class="col-sm-offset-4  col-sm-4 text-center">--%>
                            <c:if test="${cart.odMenuQty ne 0}">
                                <div>
                    <span class="odMenuImages"><img src="/resources/menu/${cart.odMenuImage}" class="star-rating"
                                                    alt="image" style="width:184px;"></span>

                                </div>

                                <div> <p></p>
                                    <span class="badge" style="background-color: #fae100; color: #110000; height:21px; place-self: center;">&nbsp;메뉴&nbsp;</span><span class="odMenuName" style="place-self: center;">&nbsp;${cart.odMenuName}</span>
                                    <p></p>
                                    <span class="badge" style="background-color: #fae100; color: #110000; height:21px; place-self: center;     margin-left: -109px;">&nbsp;수량&nbsp;</span><span class="odMenuQty" style="place-self: center;">&nbsp;${cart.odMenuQty}개</span>
                                </div>
                            </c:if>
                                <%--                <span class="odMenuName">${cart.odMenuName}</span>--%>
                                <%--                <span class="odMenuQty">${cart.odMenuQty}개</span>--%>
                                <%--                <c:if test="${cart.odOptionName}!=null">--%>
                                <%--                    <span class="odMenuPrice">${cart.odMenuPrice}</span>--%>
                                <%--                </c:if>--%>


                                <%--            </div>--%>


                                <%--            <td></td>--%>
                                <%--            <td align="left">--%>
                                <%--                <input type="hidden"  name="odMenuName" value="${cart.odMenuName}"/>--%>
                                <%--           --%>
                                <%--                <input type="hidden"  name="odMenuQty" value="${cart.odMenuQty}"/>--%>
                                <%--                <input type="hidden"  name="odMenuPrice" value="${cart.odMenuPrice}"/>--%>
                                <%--                <input type="hidden"  name="odOptionPrice" value="${cart.odOptionPrice}"/>--%>
                                <%--                <input type="hidden"  name="odMenuImage" value="${cart.odMenuImage}"/>--%>
                                <%--                    ${cart.odMenuQty}--%>
                                <%--            </td>--%>
                                <%--            <td></td>--%>
                                <%--            <td align="left">--%>
                                <%--                    ${cart.odMenuPrice}--%>
                                <%--            </td>--%>
                                <%--            <td></td>--%>
                                <%--            <td align="left">--%>
                                <%--                    ${cart.odOptionPrice}--%>
                                <%--            </td>--%>
                                <%--        <tr>--%>
                                <%--            <td id="${cart.odMenuImage}" colspan="11" bgcolor="D6D7D6" height="1"></td>--%>
                                <%--        </tr>--%>

                        </div>
                        <p></p>
                    </c:forEach>

                </div>
                <p></p>
                <p></p>
                <hr style="height:0.3px; width:600px;">


                <div class="col-md-5">
                    <div class="data-input-box" style="text-align: center">
                        <label for="rvStar" class="col-sm-offset-1 col-sm-8 control-label">리뷰 별점</label>
                        &nbsp;<div class="star-rating space-x-4 mx-auto" id="rvStar">
                        <input type="radio" id="5-stars" name="rvStar" value="5"/>
                        <label for="5-stars" class="star pr-4" style="font-size: 20px;">★</label>
                        <input type="radio" id="4-stars" name="rvStar" value="4"/>
                        <label for="4-stars" class="star"  style="font-size: 20px;">★</label>
                        <input type="radio" id="3-stars" name="rvStar" value="3"/>
                        <label for="3-stars" class="star"  style="font-size: 20px;">★</label>
                        <input type="radio" id="2-stars" name="rvStar" value="2"/>
                        <label for="2-stars" class="star" style="font-size: 20px;">★</label>
                        <input type="radio" id="1-star" name="rvStar" value="1"/>
                        <label for="1-star" class="star" style="font-size: 20px;">★</label>
                    </div>
                    </div>

                    <div class="data-input-box" style="text-align: center">
                        <label for="rvContent" class="col-sm-offset-1 col-sm-8 control-label">리뷰 내용</label>
                        <div>
                            <input type="text" class="form-control" id="rvContent" name="rvContent">
                        </div>
                    </div>



                    <div class="data-input-box" style="text-align: center">
                        <label for="rvImg11" class="col-sm-offset-1 col-sm-8 control-label">리뷰 이미지1</label>
                        <div>
                            <div id="image1preview">
                                <c:if test="${review.rvImg1 ne null}">
                                    <img src="/resources/image/${review.rvImg1}" alt="리뷰 이미지" style="width:100%;">
                                </c:if>
                            </div>
                            <input type="file" class="form-control" id="rvImg11" name="rvImg11"  value="${review.rvImg1}" onchange="setImage1Preview(event);" style="display: none;">
                            <div style="display: flex; justify-content: center; align-items: center;">
                                <button type="button" class="btn btn-outline-warning" id="update-img11" style="float: right; margin-top: 10px;">
                                    <label for="rvImg11" class="form-label" style="float: right; margin: 0;">
                                        <i class="fas fa-camera fa-lg" style="margin: 0;"></i>
                                    </label>
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="data-input-box" style="text-align: center">
                        <label for="rvImg22" class="col-sm-offset-1 col-sm-8 control-label">리뷰 이미지2</label>
                        <div >
                            <div id="image2preview">
                                <c:if test="${review.rvImg2 ne null && review.rvImg2 ne ''}">
                                    <img src="/resources/image/${review.rvImg2}" alt="리뷰 이미지" style="width:100%;">
                                </c:if>
                            </div>
                            <input type="file" class="form-control" id="rvImg22" name="rvImg22"  value="${review.rvImg2}" onchange="setImage2Preview(event);" style="display: none;">
                            <div style="display: flex; justify-content: center; align-items: center;">
                                <button type="button" class="btn btn-outline-warning" id="update-img22" style="float: right; margin-top: 10px;">
                                    <label for="rvImg22" class="form-label" style="float: right; margin: 0;">
                                        <i class="fas fa-camera fa-lg" style="margin: 0;"></i>
                                    </label>
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="data-input-box" style="text-align: center">
                        <label for="rvImg33" class="col-sm-offset-1 col-sm-8 control-label">리뷰 이미지3</label>
                        <div >
                            <div id="image3preview">
                                <c:if test="${review.rvImg3 ne null && review.rvImg3 ne ''}">
                                    <img src="/resources/image/${review.rvImg3}" alt="리뷰 이미지" style="width:100%;">
                                </c:if>
                            </div>
                            <input type="file" class="form-control" id="rvImg33" name="rvImg33"  value="${menu.rvImg3}" onchange="setImage3Preview(event);" style="display: none;">
                            <div style="display: flex; justify-content: center; align-items: center;">
                                <button type="button" class="btn btn-outline-warning" id="update-img33" style="float: right; margin-top: 10px;">
                                    <label for="rvImg33" class="form-label" style="float: right; margin: 0;">
                                        <i class="fas fa-camera fa-lg" style="margin: 0;"></i>
                                    </label>
                                </button>
                            </div>
                        </div>
                    </div>

                    <script>

                        function setImage1Preview(event){

                            var DIVimage1preview = $('#image1preview');
                            var isTherePreview = DIVimage1preview.find('img').length;
                            // alert("isTherePreview : " + isTherePreview);
                            //이미지파일미리보기 이미 있으면 바꾸기 구현 중-  점심먹고 왔다! 다시 시작!
                            var reader  = new FileReader();

                            if(isTherePreview==0){

                            }else{

                                DIVimage1preview.find('img').remove();

                            }

                            reader.onload = function(event){
                                var img = document.createElement("img");
                                img.setAttribute("src", event.target.result);
                                img.setAttribute("style",  "width:100%;");
                                document.querySelector("div#image1preview").appendChild(img);

                            };

                            reader.readAsDataURL(event.target.files[0]);


                        }

                        function setImage2Preview(event){
                            var DIVimage2preview = $('#image2preview');
                            var isTherePreview = DIVimage2preview.find('img').length;
                            // alert("isTherePreview : " + isTherePreview);
                            //이미지파일미리보기 이미 있으면 바꾸기 구현 중-  점심먹고 왔다! 다시 시작!
                            var reader  = new FileReader();

                            if(isTherePreview==0){

                            }else{

                                DIVimage2preview.find('img').remove();

                            }

                            reader.onload = function(event){
                                var img = document.createElement("img");
                                img.setAttribute("src", event.target.result);
                                img.setAttribute("style",  "width:100%;");
                                document.querySelector("div#image2preview").appendChild(img);

                            };

                            reader.readAsDataURL(event.target.files[0]);


                        }

                        function setImage3Preview(event){
                            var DIVimage3preview = $('#image3preview');
                            var isTherePreview = DIVimage3preview.find('img').length;
                            // alert("isTherePreview : " + isTherePreview);
                            //이미지파일미리보기 이미 있으면 바꾸기 구현 중-  점심먹고 왔다! 다시 시작!
                            var reader  = new FileReader();

                            if(isTherePreview==0){

                            }else{

                                DIVimage3preview.find('img').remove();

                            }

                            reader.onload = function(event){
                                var img = document.createElement("img");
                                img.setAttribute("src", event.target.result);
                                img.setAttribute("style",  "width:100%;");
                                document.querySelector("div#image3preview").appendChild(img);

                            };

                            reader.readAsDataURL(event.target.files[0]);


                        }

                    </script>



                    <div class="form-group">
                        <div class="text-center" style="display: flex; justify-content: space-evenly;">
                            <a type="button" class="btn btn-cancel btn" href="#" role="button">취 &nbsp;소</a>
                            <button type="submit" class="btn btn-default" id="addReviewButton">추 &nbsp;가</button>
                        </div>
                    </div>

                </div>
            </form>
        </div>

    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<jsp:include page="/views/footer.jsp" />
</body>

<script>



</script>


</html>


