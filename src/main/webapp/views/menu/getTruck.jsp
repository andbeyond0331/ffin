<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>메뉴 목록</title>
    <jsp:include page="../../common/lib.jsp"/>

    <style>
        .card {
            display: flex;
            /*justify-content: space-between;*/
            margin: 0 70px;
            /*margin-top: 65px;*/
            flex-wrap: wrap;
        float: left;
        }
    </style>


<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<%--    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>--%>

    <script type="text/javascript">

        // window.onload = function () {
        //     //alert("why? : " + $("tr.ct_list_pop td").find("input[name=menuNo]").val());
        //
        //     $("button.button.is-warning.is-light").on("click", function () {
        //         fncGetMenuOptionGroup();
        //         //self.location = "/menu/getMenu?menuNo=" + $("tr.ct_list_pop td").find("input[name=menuNo]").val();
        //     });
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            // var menuNo = trim($(this.find("input[name=menuNo]").val()));
            // $("tr.ct_list_pop td").on("click", function () {
            //     self.location = "/menu/getMenu?menuNo=" + $("tr.ct_list_pop td").find("input[name=menuNo]").val();
            // });

        // };

        // $(function(){
           function fncGetMenuOptionGroup(){
               self.location="/menu/getMenu?menuNo=" + $('button.button.is-warning.is-light').find('input[name=menuNo]').val();
            };
        // });

        // 별점 출력
        function ratingToPercent() {
            const score = +this.restaurant.averageScore * 20;
            return score + 1.5;
        }


    </script>

    <style>

<%--        별점 css--%>
    .star-ratings {
        color: #aaa9a9;
        position: relative;
        unicode-bidi: bidi-override;
        width: max-content;
        -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
        -webkit-text-stroke-width: 1.3px;
        -webkit-text-stroke-color: #2b2a29;
        font-size: 30px;
    }

    .star-ratings-fill {
        color: #fff58c;
        padding: 0;
        position: absolute;
        z-index: 1;
        display: flex;
        top: 0;
        left: 0;
        overflow: hidden;
        -webkit-text-fill-color: gold;
    }

    .star-ratings-base {
        z-index: 0;
        padding: 0;
    }

    .truckNameForMenu{
        color:black;
        font-weight: bolder;
        text-align: center;
    }
    </style>

</head>
<body>
<jsp:include page="/views/navbar.jsp" />
<br>
<br>
<br>
<br>
<br>

<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">

    <div class="page-header">
        <h3 class="truckNameForMenu">${truck.truckName}</h3>
    </div>
        <div class="star-ratings">
            <div
                    class="star-ratings-fill space-x-2 text-lg"
                    :style="{ width: ratingToPercent + '%' }"
            >
                <c:if test="${rvTotal ne null}">
                    <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>(${rvTotal})
                </c:if>
                <c:if test="${rvTotal eq null}">
                    <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
                </c:if>

            </div>
            <div class="star-ratings-base space-x-2 text-lg">
                <c:if test="${rvTotal ne null}">
                    <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>(${rvTotal})
                </c:if>
                <c:if test="${rvTotal eq null}">
                    <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
                </c:if>

            </div>
<%--            <div class="beside-of-star-ratings">(${rvTotal})</div>--%>

        </div>


    <div class="row">
<%--        <div class="col-xs-4 col-md-2"><strong>아 이 디</strong></div>--%>
<%--        <div class="col-xs-8 col-md-4">${truck.truckId}</div>--%>
<%--        <div class="col-xs-4 col-md-2"><strong>상 호</strong></div>--%>
<%--        <div class="col-xs-8 col-md-4">${truck.truckName}</div>--%>
<%--        <div class="col-xs-4 col-md-2"><strong>별 점</strong></div>--%>
<%--        <div class="col-xs-8 col-md-4">${truck.truckAVGStar}</div>--%>
        <div class="col-xs-4 col-md-2"><strong>프 로 필 이 미 지</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckProImg}</div>
        <div class="col-xs-4 col-md-2"><strong>영 업 상 태</strong></div>
        <c:if test="${truck.truckBusiStatus eq 0}">
            <div class="col-xs-8 col-md-4">영업 중</div>
        </c:if>
        <c:if test="${truck.truckBusiStatus eq 1}">
            <div class="col-xs-8 col-md-4">영업 종료</div>
        </c:if>
        <div class="col-xs-4 col-md-2"><strong>전 화 번 호</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckPhone}</div>
<%--        <div class="col-xs-4 col-md-2"><strong>위 도</strong></div>--%>
<%--        <div class="col-xs-8 col-md-4">${truck.truckMapLa}</div>--%>
<%--        <div class="col-xs-4 col-md-2"><strong>경 도</strong></div>--%>
<%--        <div class="col-xs-8 col-md-4">${truck.truckMapLo}</div>--%>
        <div class="col-xs-4 col-md-2"><strong>사 장 님 공 지</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckNoticeContent}</div>
<%--        <div class="col-xs-4 col-md-2"><strong>공 지 사 진</strong></div>--%>
<%--        <div class="col-xs-8 col-md-4">${truck.truckNoticeImg}</div>--%>
    </div>

    <hr/>



</div>
<!--  화면구성 div Start /////////////////////////////////////-->

<div class="container mt-3">
<%--    <div class="col-md-11 col-lg-10 mx-auto">--%>
<%--    <h2>메뉴 목록이야</h2>--%>
<%--    <p>주문을 해보지 않을래?</p>--%>

                <c:set var="i" value="0"/>
                <c:forEach var="menu" items="${list}">
                    <c:set var="i" value="${i+1}"/>
                    <div class="card" style="width: 17rem; margin-bottom:15px; margin-left: 10px;">
                        <img class="card-img-top" src="/resources/menu/${menu.menuImg1}" alt="Card image cap"
<%--                        <img class="card-img-top" src="/resources/image/menu/${menu.menuImg1}" alt="Card image cap"--%>
                             style="border-bottom: 1px solid #eee; height: 200px;">
                        <div class="card-body" style="text:center ">
                            <h3 class="align-content-center"> <strong style="text:center;">${menu.menuName}</strong></h3>
                            <h3> ${menu.menuPrice}원</h3>
                            <ul class='card-body-ul'>
                                <h4>${menu.menuDetail}</h4>
                            </ul>
                            <div class="btn-detail">
                                <button class="button is-warning is-light"
                                        style='margin-left: 100px; margin-bottom: 13px; height: 25px'
                                        onclick="fncGetMenuOptionGroup();"
                                >
                                    메뉴 상세보기
                                    <input type="hidden" name="${menu.menuNo}"/>
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>

    </div>
<%--</div>--%>
<!--////////////////모달 메뉴 상세보기 시작////////////-->
<!-- Modal -->
    <div class="modal fade" id="staticBackdrop" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">메뉴 상세정보</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"></span>
                    </button>
                </div>
                <div class="modal-body">


                </div>
                <div id="map" style='width:100%;height:350px; display:none;'></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-default" id="AddCtRes" name="AddCtRes">예약</button>
                </div>
            </div>
        </div>
    </div>


<%--<jsp:include page="/views/footer.jsp" />--%>
</body>
</html>
