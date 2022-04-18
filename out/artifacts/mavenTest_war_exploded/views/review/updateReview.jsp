<%@ page contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>

    <title>리뷰 수정</title>
    <jsp:include page="../../common/lib.jsp"/>


    <!--  ///////////////////////// CSS ////////////////////////// -->
    <style>
        body {
            padding-top : 50px;
        }
    </style>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">


        //============= "추가"  Event 연결 =============
        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            // alert("나와라 : " +  $( "#addReviewButton" ).html());
            $( "#updateReviewButton" ).on("click" , function() {
                fncUpdateReview();
            });
        });

        //============= "취소"  Event 처리 및  연결 =============
        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("a[href='#' ]").on("click" , function() {
                $("form")[0].reset();
            });
        });

        function fncUpdateReview(){

            // var rvOrderNo = $("input[name='rvOrderNo']").val();
            $(".form-horizontal").attr("method","POST").attr("action","/review/updateReview").attr("enctype", "multipart/form-data").submit();
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
            -webkit-text-stroke-width: 2.3px;
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
    </style>



</head>

<body>

<!-- ToolBar Start /////////////////////////////////////-->
<jsp:include page="/views/navbar.jsp" /><br><br><br><br><br>
<!-- ToolBar End /////////////////////////////////////-->

<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">
    <%--    <input type="hidden" id = "rvOrderNo" name="rvOrderNo" value="${purchase.orderNo}">--%>

    <div class="page-header text-center">
        <%--        <h3 class=" text-info">${purchase.orderNo}</h3>--%>
    </div>

    <%--    <div class="container row" style="float: none; margin:0 auto;">--%>
    <c:set var="i" value="0"/>
    <c:forEach var="cart" items="${orderDetail.get('list')}">
        <c:set var="i" value="${i+1}" />
        <div class="text-center" style="float: none; margin:0 auto;">
                <%--            <div >--%>

                <%--                    ${i}--%>
                <%--            </div>--%>
                <%--            <div></div>--%>

                <%--            <div class="col-sm-offset-4  col-sm-4 text-center">--%>
            <c:if test="${cart.odMenuQty ne 0}">
                <span class="odMenuName">${cart.odMenuName}</span>
                <span class="odMenuQty">${cart.odMenuQty}개</span>
            </c:if>

        </div>

    </c:forEach>

    <form class="form-horizontal">



        <div class="form-group">

            <input type="hidden" value="${purchase.orderNo}" name="rvOrderNo"/>

            <div class="col-sm-4">
               <div class="star-rating space-x-4 mx-auto">
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
        </div>

        <div class="form-group">
            <label for="rvContent" class="col-sm-offset-1 col-sm-3 control-label">리뷰내용</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="rvContent" name="rvContent" placeholder="리뷰 내용을 입력하세요.">
            </div>
        </div>

        <div class="form-group">
            <label for="rvImg1" class="col-sm-offset-1 col-sm-3 control-label">리뷰 이미지1</label>
            <div class="col-sm-4">
                <input type="file" class="form-control" id="rvImg1" name="rvImg11"  value="${review.rvImg1}" placeholder="리뷰 이미지1">
            </div>
        </div>

        <div class="form-group">
            <label for="rvImg2" class="col-sm-offset-1 col-sm-3 control-label">리뷰 이미지2</label>
            <div class="col-sm-4">
                <input type="file" class="form-control" id="rvImg2" name="rvImg22"  value="${review.rvImg2}" placeholder="리뷰 이미지2">
            </div>
        </div>

        <div class="form-group">
            <label for="rvImg3" class="col-sm-offset-1 col-sm-3 control-label">리뷰 이미지3</label>
            <div class="col-sm-4">
                <input type="file" class="form-control" id="rvImg3" name="rvImg33"  value="${review.rvImg3}" placeholder="리뷰 이미지3">
            </div>
        </div>
    </form>

    <div class="form-group">
        <div class="col-sm-offset-4  col-sm-4 text-center">
            <button type="submit" class="btn btn-primary"  id="updateReviewButton">수 &nbsp;정</button>
            <a class="btn btn-primary btn" href="#" role="button">취 &nbsp;소</a>
        </div>
    </div>



</div>

<jsp:include page="/views/footer.jsp" />
</body>



</html>


