<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>
    <style>
        strong {
            font-size: 17px;
            text-align: left;
        }

        .col-sm-6 {
            font-size: 17px;
            text-align: left;
        }

        img {
            display: block;
            margin: 0px;
        }

        .join-layout {
            display: flex;
            padding-top:20px ;
            justify-content:center ;
        }


    </style>

    <title>F.FIN | 영업상태변경</title>
    <jsp:include page="../../common/lib.jsp"/>
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //============= "탈 퇴"  Event 연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-default").on("click", function () {
                fncUpdateBusiStat();
            });
            $("button.change").on("click", function () {
                fncByeTruck();
            });
            $("button.changeCancel").on("click", function () {
                $('#busiStat').modal('hide');
            });
            $("button.btn-close").on("click", function () {
                $('#busiStat').modal('hide');
            });
            // <!-- 회원탈퇴 전 Password 체크 -->
            $("#tPassword").keyup(function () {

                if ($("#tPassword").val() == $("#truckPasswordS").val()) {
                    $(".successPw").text("비밀번호가 일치합니다.");
                    $(".successPw").css("color", "blue");
                    $("#pwDouble").val("true");
                } else {
                    $(".successPw").text("비밀번호가 일치하지 않습니다.");
                    $(".successPw").css("color", "red");
                    $("#pwDouble").val("false");
                }
            })

        });

        function fncUpdateBusiStat() {
                $('#busiStat').modal('show');
        }

        function fncUpdateBusiStatus() {

            $("form").attr("method", "POST").attr("action", "/truck/updateBusiStatus").submit();
            alert("영업상태가 변경되었습니다.");
        }

        function getValue(){

            console.log( '탈퇴사유 : '+$(":input:radio[name=truckByeReason]:checked").val() );
            session.set
            $("input[name=truckByeReason]:checked").each(function() {
                console.log( '탈퇴사유 : '+$(this).val() );
            });

        }

    </script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=51615d81a030d0475e576eb41e443c14&libraries=services"></script>
</head>


<body id="page-top">

<jsp:include page="/views/navbar.jsp"/>
<br/><br/><br/><br/>



<div class="container">

    <div class="page-header" style="text-align: center">
        <label for="page-top"/>
        <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
        <h4 style="margin-top: 10px;">영업상태변경</h4>
    </div>
    <br>

    <form class="form-horizontal" style="border-radius:10px ; border: 0; box-shadow: 0 2px 4px 0 rgba(0,0,0,0.2); transition: 0.3s;">
        <div class="row justify-content-between">
        <div class="col-6">
            <div class="form-check form-switch">
                <c:if test="${truck.truckBusiStatus.equals('1')}">
                    <input class="form-check-input" type="checkbox" role="switch"
                           id="swCh" name="swCh"  data-bs-toggle="modal" data-bs-target="#staticBackdrop" checked>
                    <label class="form-check-label" for="swCh">영업중</label>
                </c:if>
                <c:if test="${truck.truckBusiStatus.equals('0')}">
                    <input class="form-check-input" type="checkbox" role="switch"
                           id="swCh" name="swCh"  data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                    <label class="form-check-label" for="swCh">영업종료</label>
                </c:if>

            </div>
        </div>


        <script>

            $("#busiStatus").on("click",function(){
                var truckId = $("input[name='truckId']").val();
                var tb = $("input[name='swCh']:checked").val();


                if(tb == 'on'){
                    tb=1;
                }else if(tb==undefined){
                    tb=0;
                }

                $.ajax({
                    url: "/purchase/json/updateBusiStatus",
                    method: "POST",
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    data: {
                        "truckId": truckId,
                        "tb" : tb
                    },
                    success: function (data) {

                        alert("영업상태가 변경되었습니다")

                        window.location.reload();
                    }
                });


            });
        </script>
    </div>

            <hr/>

<%--        <!-- slider section -->--%>
<%--        <section class="slider_section">--%>
<%--            <div class="container ">--%>
<%--                <div class="row">--%>
<%--                    <div class="col-lg-10 mx-auto">--%>
<%--                        <div class="detail-box" style="margin-bottom: -40px;">--%>
<%--                            <h1 class="display-1 fs-md-5 fs-lg-6 fs-xl-8 text-light" style=" font-family: 'Pacifico', cursive; margin-top:100px; margin-bottom: 0; color: #110000">--%>
<%--                                FoodTruck Finder--%>
<%--                            </h1>--%>
<%--                            <h6 class="text-800 mb-5 fs-4">Within a few clicks, find foodtruck are accessible near you</h6>--%>
<%--                        </div>--%>
<%--                        <div class="find_container ">--%>
<%--                            <div class="container">--%>
<%--                                <div class="row">--%>
<%--                                    <div class="col">--%>
<%--                                        <form>--%>
<%--                                            <div class="form-row">--%>
<%--                                                <div class="form-group col-lg-6">--%>
<%--                                                    <input type="text" class="form-control" id="inputLocation" name="inputLocation" placeholder="What's your address?" value="${inputLocation}">--%>
<%--                                                    <span class="location_icon">--%>
<%--                                                    <i class="fa fa-map-marker" aria-hidden="true"></i>--%>
<%--                                                  </span>--%>
<%--                                                </div>--%>
<%--                                            </div>--%>
<%--                                            <div class="form-row"  style="margin-top: -15px;">--%>
<%--                                                <div class="form-group col-md-4">--%>
<%--                                                    <div class="btn-box">--%>
<%--                                                        <button type="button" class="btn current-location">Use current location</button>--%>
<%--                                                    </div>--%>
<%--                                                </div>--%>
<%--                                            </div>--%>
<%--                                        </form>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <hr/>--%>

<%--            &lt;%&ndash; 지도 띄울 modal &ndash;%&gt;--%>

<%--            <!-- Modal -->--%>
<%--            <div class="modal fade" id="staticBackdrop" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">--%>
<%--                <div class="modal-dialog" role="document">--%>
<%--                    <div class="modal-content">--%>
<%--                        <div class="modal-header">--%>
<%--                            <h5 class="modal-title" id="staticBackdropLabel">지도 출력</h5>--%>
<%--                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">--%>
<%--                                <span aria-hidden="true"></span>--%>
<%--                            </button>--%>
<%--                        </div>--%>
<%--                        <div class="modal-body"></div>--%>
<%--                        <div id="map" name = "map" style='width:100%;height:350px; display:none;'></div>--%>
<%--                        <p id="result"></p>--%>
<%--                        <div class="modal-footer">--%>
<%--                            <button type="button" class="btn btn-default" id="mapAccess" name="mapAccess">설정완료</button>--%>
<%--                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>


<%--            <!-- Modal -->--%>
<%--        <div class="modal fade" id="busiStat" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="busiStat" aria-hidden="true">--%>
<%--            <div class="modal-dialog">--%>
<%--                <div class="modal-content">--%>
<%--                    <div class="modal-header">--%>
<%--                        <h5 class="modal-title" id="busiStatLabel">영업모드</h5>--%>
<%--                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>--%>
<%--                    </div>--%>
<%--                    <div class="modal-body">--%>
<%--                        <c:if test="${truck.truckBusiStatus.equals('1')}">--%>
<%--                            영업종료 상태로 변경합니다.--%>
<%--                        </c:if>--%>
<%--                        <c:if test="${truck.truckBusiStatus.equals('0')}">--%>
<%--                            영업중 상태로 변경합니다.--%>
<%--                        </c:if>--%>
<%--                    </div>--%>
<%--                    <div class="modal-footer">--%>
<%--                        <button type="button" class="btn btn-cancle changeCancel" data-bs-dismiss="modal">취소</button>--%>
<%--                        <button type="button" class="btn btn-default change" id="busiStatus">변경</button>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>

        <!-- Button trigger modal -->
        <div class="form-group" align="center">
            <div class="col-sm-offset-1  col-sm-10 text-center">
                <button type="button" class="btn btn-default" data-bs-toggle="modal" data-bs-target="#busiStat">
                    영업상태변경
                </button>
                <input type="button" class="btn btn-cancle" value="취소"
                       onclick="javascript:window.location='/catering/mainTruckList'">
            </div>
        </div>
        <br/>
    </form>


    <jsp:include page="/views/footer.jsp"/>

</body>

</html>
