<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>메뉴 목록</title>
    <jsp:include page="../../common/lib.jsp"/>

    <style>
        <%--/////////////////////////////////////  장바구니 소스 ////////////////////////////////////--%>
        .card.cart{
            display: flex;
            /*justify-content: space-between;*/
            margin: 0 70px;
            margin-top: 60px;
            flex-wrap: wrap;
            float: left;
        }

        /*
                좌우 간격맞춰준다
                .restaurant-detail {
                    position: relative;
                    max-width: 1020px;
                    margin: 10px auto;
                }*/

        .clearfix:before, .clearfix:after, .dl-horizontal dd:before, .dl-horizontal dd:after, .container:before, .container:after, .container-fluid:before, .container-fluid:after, .row:before, .row:after, .form-horizontal .form-group:before, .form-horizontal .form-group:after, .btn-toolbar:before, .btn-toolbar:after, .btn-group-vertical > .btn-group:before, .btn-group-vertical > .btn-group:after, .nav:before, .nav:after, .navbar:before, .navbar:after, .navbar-header:before, .navbar-header:after, .navbar-collapse:before, .navbar-collapse:after, .pager:before, .pager:after, .panel-body:before, .panel-body:after, .modal-footer:before, .modal-footer:after {
            display: table;
            content: " ";
        }

        .list-group-item {
            position: relative;
            display: block;
            padding: 10px 15px;
            margin-bottom: -1px;
            background-color: #fff;
            border: 1px solid #ddd;
        }

        /*장바구니내부 스크롤*/
        .card-body ul, .order-wrap-pc ul {
            max-height: 300px;
            overflow-x: hidden;
            overflow-y: auto;
        }

        Bbody {
            background: #ddd;
            min-height: 100vh;
            vertical-align: middle;
            display: flex;
            font-family: sans-serif;
            font-size: 0.8rem;
            font-weight: bold
        }

        .title {
            margin-bottom: 5vh
        }

        .card.cart {
            margin: auto;
            max-width: 950px;
            width: 90%;
            box-shadow: 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            border-radius: 1rem;
            border: transparent
        }

        @media (max-width: 767px) {
            .card {
                margin: 3vh auto
            }
        }

        .cart {
            background-color: #fff;
            padding: 4vh 5vh;
            border-bottom-left-radius: 1rem;
            border-top-left-radius: 1rem
        }

        @media (max-width: 767px) {
            .cart {
                padding: 4vh;
                border-bottom-left-radius: unset;
                border-top-right-radius: 1rem
            }
        }

        .summary {
            background-color: #ddd;
            border-top-right-radius: 1rem;
            border-bottom-right-radius: 1rem;
            padding: 4vh;
            color: rgb(65, 65, 65)
        }

        @media (max-width: 767px) {
            .summary {
                border-top-right-radius: unset;
                border-bottom-left-radius: 1rem
            }
        }

        .summary .col-2 {
            padding: 0
        }

        .summary .col-10 {
            padding: 0
        }

        .row {
            margin: 0
        }

        .title b {
            font-size: 1.5rem
        }

        .main {
            margin: 0;
            padding: 2vh 0;
            width: 100%
        }

        .col-2,
        .col {
            padding: 0 1vh
        }

        a {
            padding: 0 1vh
        }

        .close {
            margin-left: auto;
            font-size: 0.7rem
        }

        img {
            width: 3.5rem
        }

        .back-to-shop {
            margin-top: 4.5rem
        }

        h5 {
            margin-top: 4vh
        }

        hr {
            margin-top: 1.25rem
        }

        form {
            padding: 2vh 0
        }

        select {
            border: 1px solid rgba(0, 0, 0, 0.137);
            padding: 1.5vh 1vh;
            margin-bottom: 4vh;
            outline: none;
            width: 100%;
            background-color: rgb(247, 247, 247)
        }

        input {
            border: 1px solid rgba(0, 0, 0, 0.137);
            padding: 1vh;
            margin-bottom: 4vh;
            outline: none;
            width: 100%;
            background-color: rgb(247, 247, 247)
        }

        input:focus::-webkit-input-placeholder {
            color: transparent
        }

        .btn {
            background-color: #000;
            border-color: #000;
            color: white;
            width: 100%;
            font-size: 0.7rem;
            margin-top: 4vh;
            padding: 1vh;
            border-radius: 0
        }

        .btn:focus {
            box-shadow: none;
            outline: none;
            box-shadow: none;
            color: white;
            -webkit-box-shadow: none;
            -webkit-user-select: none;
            transition: none
        }

        .btn:hover {
            color: white
        }

        a {
            color: black
        }

        a:hover {
            color: black;
            text-decoration: none
        }

        #code {
            background-image: linear-gradient(to left, rgba(255, 255, 255, 0.253), rgba(255, 255, 255, 0.185)), url("https://img.icons8.com/small/16/000000/long-arrow-right.png");
            background-repeat: no-repeat;
            background-position-x: 95%;
            background-position-y: center
        }

        .wrap {

            max-width: 480px;

            margin: 0 auto; /* 화면 가운데로 */

            background-color: #fff;

            height: 100%;

            padding: 20px;

            box-sizing: border-box;


        }

        .reviewform textarea {

            width: 100%;

            padding: 10px;

            box-sizing: border-box;

        }

        .rating .rate_radio {

            position: relative;

            display: inline-block;

            z-index: 20;

            opacity: 0.001;

            width: 60px;

            height: 60px;

            background-color: #fff;

            cursor: pointer;

            vertical-align: top;

            display: none;

        }

        .rating .rate_radio + label {

            position: relative;

            display: inline-block;

            margin-left: -4px;

            z-index: 10;

            width: 60px;

            height: 60px;

            /*background-image: url('./img/starrate.png');*/

            background-repeat: no-repeat;

            background-size: 60px 60px;

            cursor: pointer;

            background-color: #f0f0f0;

        }

        .rating .rate_radio:checked + label {

            background-color: #ff8;

        }


        .cmd {

            margin-top: 20px;

            text-align: right;

        }

        .cmd input[type="button"] {

            padding: 10px 20px;

            border: 1px solid #e8e8e8;

            background-color: #fff;

            background-color: #000;

            color: #fff;

        }


        .warning_msg {

            display: none;

            position: relative;

            text-align: center;

            background: #ffffff;

            line-height: 26px;

            width: 100%;

            color: red;

            padding: 10px;

            box-sizing: border-box;

            border: 1px solid #e0e0e0;

        }

        <%--/////////////////////////////////////  장바구니 소스 ////////////////////////////////////--%>
    </style>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

    <script type="text/javascript">

        window.onload = function () {
            alert("why? : " + $("tr.ct_list_pop td").find("input[name=menuNo]").val());


            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            // var menuNo = trim($(this.find("input[name=menuNo]").val()));
            $("tr.ct_list_pop td").on("click", function () {
                self.location = "/menu/getMenu?menuNo=" + $("tr.ct_list_pop td").find("input[name=menuNo]").val();
            });

        };
        <%--/////////////////////////////////////  장바구니 소스 ////////////////////////////////////--%>

        var stmnLEFT = 50; // 오른쪽 여백
        var stmnGAP1 = 0; // 위쪽 여백
        var stmnGAP2 = 150; // 스크롤시 브라우저 위쪽과 떨어지는 거리
        var stmnBASE = 150; // 스크롤 시작위치
        var stmnActivateSpeed = 35; //스크롤을 인식하는 딜레이 (숫자가 클수록 느리게 인식)
        var stmnScrollSpeed = 1; //스크롤 속도 (클수록 느림)
        var stmnTimer;

        function RefreshStaticMenu() {
            var stmnStartPoint, stmnEndPoint;
            stmnStartPoint = parseInt(document.getElementById('staticMenu').style.top, 10);
            stmnEndPoint = Math.max(document.documentElement.scrollTop, document.body.scrollTop) + stmnGAP2;
            if (stmnEndPoint < stmnGAP1) stmnEndPoint = stmnGAP1;
            if (stmnStartPoint != stmnEndPoint) {
                stmnScrollAmount = Math.ceil(Math.abs(stmnEndPoint - stmnStartPoint) / 15);
                document.getElementById('staticMenu').style.top = parseInt(document.getElementById('staticMenu').style.top, 10) + ((stmnEndPoint < stmnStartPoint) ? -stmnScrollAmount : stmnScrollAmount) + 'px';
                stmnRefreshTimer = stmnScrollSpeed;
            }
            stmnTimer = setTimeout("RefreshStaticMenu();", stmnActivateSpeed);
        }

        function InitializeStaticMenu() {
            document.getElementById('staticMenu').style.right = stmnLEFT + 'px'; //처음에 오른쪽에 위치. left로 바꿔도.
            document.getElementById('staticMenu').style.top = document.body.scrollTop + stmnBASE + 'px';
            RefreshStaticMenu();
        }


        //이벤트 리스너 등록

        document.addEventListener('DOMContentLoaded', function () {

            // "선택 상품 삭제" 버튼 클릭

            document.querySelector('.basketrowcmd a:first-child').addEventListener('click', function () {

                basket.delCheckedItem();

            });

            // "장바구니 비우기" 버튼 클릭

            document.querySelector('.basketrowcmd a:nth-child(2)').addEventListener('click', function () {

                basket.delAllItem();

            });

            // 장바구니 행 "삭제" 버튼 클릭

            document.querySelectorAll('.basketcmd a').forEach(
                function (item) {

                    item.addEventListener('click', function () {

                        basket.delItem();

                    });

                }
            );

            // 수량변경 - 이벤트 델리게이션으로 이벤트 종류 구분해 처리

            document.querySelectorAll('.updown').forEach(
                function (item, idx) {

                    //수량 입력 필드 값 변경

                    item.querySelector('input').addEventListener('keyup', function () {

                        basket.changePNum(idx + 1);

                    });

                    //수량 증가 화살표 클릭

                    item.children[1].addEventListener('click', function () {

                        basket.changePNum(idx + 1);

                    });

                    //수량 감소 화살표 클릭

                    item.children[2].addEventListener('click', function () {

                        basket.changePNum(idx + 1);

                    });

                }
            );

            //앵커 # 대체해 스크롤 탑 차단

            document.querySelectorAll('a[href="#"]').forEach(function (item) {

                item.setAttribute('href', 'javascript:void(0)');

            });

        });


        let basket = {

            totalCount: 0, //전체 갯수 변수

            totalPrice: 0, //전체 합계액 변수

            //체크한 장바구니 상품 비우기

            delCheckedItem: function () {

                document.querySelectorAll("input[name=buy]:checked").forEach(function (item) {

                    item.parentElement.parentElement.parentElement.remove();

                });

                //AJAX 서버 업데이트 전송


                //전송 처리 결과가 성공이면

                this.reCalc();

                this.updateUI();

            },

            //장바구니 전체 비우기

            delAllItem: function () {

                document.querySelectorAll('.row.data').forEach(function (item) {

                    item.remove();

                });

                //AJAX 서버 업데이트 전송


                //전송 처리 결과가 성공이면

                this.totalCount = 0;

                this.totalPrice = 0;

                this.reCalc();

                this.updateUI();

            },

            //재계산

            reCalc: function () {

                this.totalCount = 0;

                this.totalPrice = 0;

                document.querySelectorAll(".p_num").forEach(function (item) {

                    var count = parseInt(item.getAttribute('value'));
                    9999

                    this.totalCount += count;

                    var price = item.parentElement.parentElement.previousElementSibling.firstElementChild.getAttribute('value');

                    this.totalPrice += count * price;

                }, this); // forEach 2번째 파라메터로 객체를 넘겨서 this 가 객체리터럴을 가리키도록 함. - thisArg

            },

            //화면 업데이트

            updateUI: function () {

                document.querySelector('#sum_p_num').textContent = '상품갯수: ' + this.totalCount.formatNumber() + '개';

                document.querySelector('#sum_p_price').textContent = '합계금액: ' + this.totalPrice.formatNumber() + '원';

            },

            //개별 수량 변경

            changePNum: function (pos) {

                var item = document.querySelector('input[name=p_num' + pos + ']');

                var p_num = parseInt(item.getAttribute('value'));

                var newval = event.target.classList.contains('up') ? p_num + 1 : event.target.classList.contains('down') ?

                    p_num - 1 : event.target.value;


                if (parseInt(newval) < 1 || parseInt(newval) > 99) {
                    return false;
                }


                item.setAttribute('value', newval);

                item.value = newval;


                var price = item.parentElement.parentElement.previousElementSibling.firstElementChild.getAttribute('value');

                item.parentElement.parentElement.nextElementSibling.textContent = (newval * price).formatNumber() + "원";

                //AJAX 업데이트 전송


                //전송 처리 결과가 성공이면

                this.reCalc();

                this.updateUI();

            },

            //상품 삭제

            delItem: function () {

                event.target.parentElement.parentElement.parentElement.remove();

            }

        }
        /*        // 숫자 3자리 콤마찍기

                Number.prototype.formatNumber = function(){

                    if(this==0) return 0;

                    let regex = /(^[+-]?\d+)(\d)/;

                    let nstr = (this + '');

                    while (regex.test(nstr)) nstr = nstr.replace(regex, '$1' + ',' + '$2');

                    return nstr;

                };*/


        <%--/////////////////////////////////////  장바구니 소스 ////////////////////////////////////--%>


    </script>
    <style>
        #staticMenu {
            margin: 0pt;
            padding: 0pt;
            position: absolute;
            right: 0px;
            top: 0px;
        }

    </style>
</head>
<body onload="InitializeStaticMenu();">

<jsp:include page="/views/navbar.jsp"/>
<br>
<br>
<div class="container mt-3">
    <h2>메뉴 목록이야</h2>
    <p>주문을 해보지 않을래?</p>

    <c:set var="i" value="0"/>
    <c:forEach var="menu" items="${list}">
        <c:set var="i" value="${i+1}"/>
        <div class="card cart" style="width: 17rem; margin-bottom:15px; margin-left: 10px;">
            <img class="card-img-top" src="/resources/image/${menu.menuImg1}" alt="Card image cap"
                 style="border-bottom: 1px solid #eee; height: 200px;">
            <div class="card-body">
                <ul class='card-body-ul'>
                    <li> ${menu.menuName}</li>
                    <li> ${menu.menuDetail}</li>
                    <li> ${menu.menuPrice}원</li>
                </ul>
                <div class="btn-detail">
                    <button class="button is-warning is-light"
                            style='margin-left: 100px; margin-bottom: 13px; height: 25px'
                            onclick="fncGetMenuOptionGroup();">메뉴 상세보기
                    </button>
                </div>
            </div>
        </div>
    </c:forEach>


</div>


<%--/////////////////////////////////////  장바구니 소스 ////////////////////////////////////--%>
<div id="staticMenu">

    <div class="card" style="width: 18rem;">
        <div class="card-header">
            <div class="row">
                <div class="col-10">
                    장바구니
                </div>
                <div class="col-2">
                    <svg type="button" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                         class="bi bi-trash" viewBox="0 0 16 16">
                        <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                        <path fill-rule="evenodd"
                              d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                    </svg>
                </div>
            </div>
        </div>
        <div class="card-body">
            <ul class="list-group list-group-flush">


                <div class="basket" id="basket">

                    <%--


                                        <div class="row data">
                                            <div class="subdiv">
                                                <div class="check"><input type="checkbox" name="buy" value="260" checked="" onclick="javascript:basket.checkItem();">&nbsp;</div>
                                                <div class="pname">
                                                    <span>찜마마(XJ-92214/3)</span>
                                                </div>
                                            </div>
                                            <div class="subdiv">
                                                <div class="basketprice"><input type="hidden" name="p_price" id="p_price1" class="p_price" value="20000">20,000원</div>
                                                <div class="num">
                                                    <div class="updown">
                                                        <input type="text" name="p_num1" id="p_num1" size="2" maxlength="4" class="p_num" value="2" onkeyup="javascript:basket.changePNum(1);">
                                                        <span onclick="javascript:basket.changePNum(1);"><i class="fas fa-arrow-alt-circle-up up"></i></span>
                                                        <span onclick="javascript:basket.changePNum(1);"><i class="fas fa-arrow-alt-circle-down down"></i></span>
                                                    </div>
                                                </div>
                                                <div class="sum">40,000원</div>
                                            </div>
                                            <div class="subdiv">
                                                <div class="basketcmd"><a href="javascript:void(0)" class="abutton" onclick="javascript:basket.delItem();">삭제</a></div>
                                            </div>
                                        </div>


                                        <div class="row data">
                                            <div class="subdiv">
                                                <div class="check"><input type="checkbox" name="buy" value="261" checked="" onclick="javascript:basket.checkItem();">&nbsp;</div>
                                                <div class="img"><img src="./img/basket2.jpg" width="60"></div>
                                                <div class="pname">
                                                    <span>노바 요거팜(JP-268T)</span>
                                                </div>
                                            </div>
                                            <div class="subdiv">
                                                <div class="basketprice"><input type="hidden" name="p_price" id="p_price2" class="p_price" value="19000">19,000원</div>
                                                <div class="num">
                                                    <div class="updown">
                                                        <input type="text" name="p_num2" id="p_num2" size="2" maxlength="4" class="p_num" value="1" onkeyup="javascript:basket.changePNum(2);">
                                                        <span onclick="javascript:basket.changePNum(2);"><i class="fas fa-arrow-alt-circle-up up"></i></span>
                                                        <span onclick="javascript:basket.changePNum(2);"><i class="fas fa-arrow-alt-circle-down down"></i></span>
                                                    </div>
                                                </div>
                                                <div class="sum">19,000원</div>
                                            </div>
                                            <div class="subdiv">
                                                <div class="basketcmd"><a href="javascript:void(0)" class="abutton" onclick="javascript:basket.delItem();">삭제</a></div>
                                            </div>
                                        </div>


                                        <div class="row data">
                                            <div class="subdiv">
                                                <div class="check"><input type="checkbox" name="buy" value="262" checked="" onclick="javascript:basket.checkItem();">&nbsp;</div>
                                                <div class="img"><img src="./img/basket3.jpg" width="60"></div>
                                                <div class="pname">
                                                    <span>아날도 바시니 보스톤 가방 20인치 (ab-380)</span>
                                                </div>
                                            </div>
                                            <div class="subdiv">
                                                <div class="basketprice"><input type="hidden" name="p_price" id="p_price3" class="p_price" value="15200">15,200원</div>
                                                <div class="num">
                                                    <div class="updown">
                                                        <input type="text" name="p_num3" id="p_num3" size="2" maxlength="4" class="p_num" value="1" onkeyup="javascript:basket.changePNum(3);">
                                                        <span onclick="javascript:basket.changePNum(3);"><i class="fas fa-arrow-alt-circle-up up"></i></span>
                                                        <span onclick="javascript:basket.changePNum(3);"><i class="fas fa-arrow-alt-circle-down down"></i></span>
                                                    </div>
                                                </div>
                                                <div class="sum">15,200원</div>
                                            </div>
                                            <div class="subdiv">
                                                <div class="basketcmd"><a href="javascript:void(0)" class="abutton" onclick="javascript:basket.delItem();">삭제</a></div>
                                            </div>
                                        </div>


                    --%>




                    <!-- "장바구니 상품 목록" -->

                    <%--  <div class="row data">

                          <div class="check"><input type="checkbox" name="buy" value="260" checked="">&nbsp;</div>


                          <div class="pname">

                              <span>찜마마(XJ-92214/3)</span>

                          </div>

                          <div class="basketprice"><input type="hidden" name="p_price" id="p_price1" class="p_price" value="20000">20,000원</div>

                          <div class="num">

                              <!-- "장바구니 수량 변경" -->

                              <div class="updown">

                                  <input type="text" name="p_num1" id="p_num1" size="2" maxlength="4" class="p_num" value="2">

                                  <span><i class="fas fa-arrow-alt-circle-up up"></i></span>

                                  <span><i class="fas fa-arrow-alt-circle-down down"></i></span>

                              </div>

                          </div>

                          <!-- "장바구니 상품 합계" -->

                          <div class="sum">40,000원</div>

                          <div class="basketcmd"><a href="#" class="abutton">삭제</a></div>

                      </div>--%>
                        <div id="order"></div>

                </div>

                <!-- "장바구니 기능 버튼" -->

                <div class="right-align basketrowcmd">

                    <a href="#" class="abutton">선택상품삭제</a>

                    <a href="#" class="abutton">장바구니비우기</a>

                </div>

                <!-- "장바구니 전체 합계 정보" -->

                <div class="bigtext right-align sumcount" id="sum_p_num">상품갯수: 4개</div>

                <div class="bigtext right-align box blue summoney" id="sum_p_price">합계금액: 74,200원</div>


                <div id="goorder" class="">

                    <div class="clear"></div>

                    <div class="buttongroup center-align cmd">

                        <a href="#">선택한 상품 주문</a>

                    </div>

                </div>
                <%--
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item">
                                    <div class="row border-top border-bottom">
                                        <div class="row main align-items-center">
                                            <div class="col">
                                                <div class="row text-muted">Shirt</div>
                                                <div class="row">Cotton T-shirt</div>
                                            </div>
                                            <div class="col"> <a href="#">-</a><a href="#" class="border">1</a><a href="#">+</a> </div>
                                            <div class="col">&euro; 44.00 <span class="close">&#10005;</span></div>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                --%>

            </ul>
            <c:set var="i" value="0"/>
            <c:forEach var="cart" items="${map.get('list')}">
                <c:set var="i" value="${i+1}"/>


                <input type="hidden" id="odMenuName" name="odMenuName" value="${cart.odMenuName}"/>
                <input type="hidden" id="odOptionGroupName" name="odOptionGroupName"
                       value="${cart.odOptionGroupName}"/>
                <input type="hidden" id="odOptionName" name="odOptionName" value="${cart.odOptionName}"/>
                <input type="hidden" id="odMenuQty" name="odMenuQty" value="${cart.odMenuQty}"/>
                <input type="hidden" id="odMenuPrice" name="odMenuPrice" value="${cart.odMenuPrice}"/>
                <input type="hidden" id="odOptionPrice" name="odOptionPrice" value="${cart.odOptionPrice}"/>
                <input type="hidden" id="odMenuImage" name="odMenuImage" value="${cart.odMenuImage}"/>
                <input type="hidden" id="odMenuQtyFlag" name="odMenuQtyFlag" value="${cart.odMenuQtyFlag}"/>


            </c:forEach>
            <div id="total"></div>
        </div>
        <div class="card-footer" type="button">
            <p class="text-center" style="font-size: x-large">주문하기</p>
        </div>
    </div>

</div>
<%--<div class="card">
    <div class="row">
        <div class="col-md-8 cart">
            <div class="title">
                <div class="row">
                    <div class="col">
                        <h4><b>Shopping Cart</b></h4>
                    </div>
                    <div class="col align-self-center text-right text-muted">3 items</div>
                </div>
            </div>
            <div class="row border-top border-bottom">
                <div class="row main align-items-center">
                    <div class="col-2"><img class="img-fluid" src="https://i.imgur.com/1GrakTl.jpg"></div>
                    <div class="col">
                        <div class="row text-muted">Shirt</div>
                        <div class="row">Cotton T-shirt</div>
                    </div>
                    <div class="col"><a href="#">-</a><a href="#" class="border">1</a><a href="#">+</a></div>
                    <div class="col">&euro; 44.00 <span class="close">&#10005;</span></div>
                </div>
            </div>
            <div class="row">
                <div class="row main align-items-center">
                    <div class="col-2"><img class="img-fluid" src="https://i.imgur.com/ba3tvGm.jpg"></div>
                    <div class="col">
                        <div class="row text-muted">Shirt</div>
                        <div class="row">Cotton T-shirt</div>
                    </div>
                    <div class="col"><a href="#">-</a><a href="#" class="border">1</a><a href="#">+</a></div>
                    <div class="col">&euro; 44.00 <span class="close">&#10005;</span></div>
                </div>
            </div>
            <div class="row border-top border-bottom">
                <div class="row main align-items-center">
                    <div class="col-2"><img class="img-fluid" src="https://i.imgur.com/pHQ3xT3.jpg"></div>
                    <div class="col">
                        <div class="row text-muted">Shirt</div>
                        <div class="row">Cotton T-shirt</div>
                    </div>
                    <div class="col"><a href="#">-</a><a href="#" class="border">1</a><a href="#">+</a></div>
                    <div class="col">&euro; 44.00 <span class="close">&#10005;</span></div>
                </div>
            </div>
            <div class="back-to-shop"><a href="#">&leftarrow;</a><span class="text-muted">Back to shop</span></div>
        </div>
        <div class="col-md-4 summary">
            <div>
                <h5><b>Summary</b></h5>
            </div>
            <hr>
            <div class="row">
                <div class="col" style="padding-left:0;">ITEMS 3</div>
                <div class="col text-right">&euro; 132.00</div>
            </div>
            <form>
                <p>SHIPPING</p> <select>
                <option class="text-muted">Standard-Delivery- &euro;5.00</option>
            </select>
                <p>GIVE CODE</p> <input id="code" placeholder="Enter your code">
            </form>
            <div class="row" style="border-top: 1px solid rgba(0,0,0,.1); padding: 2vh 0;">
                <div class="col">TOTAL PRICE</div>
                <div class="col text-right">&euro; 137.00</div>
            </div>
            <button class="btn">CHECKOUT</button>
        </div>
    </div>
</div>--%>


<%--/////////////////////////////////////  장바구니 소스 ////////////////////////////////////--%>
<br>
<br>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

<jsp:include page="/views/footer.jsp"/>


<script>
    $(function () {
        var odMenuNameCount = $("input[name='odMenuName']").length;


        var odMenuNameL;
        var odOptionGroupNameL;
        var odOptionNameL;
        var odMenuQtyL;
        var odMenuPriceL;
        var odOptionPriceL;
        var odMenuImageL;

        for (var i = 0; i < odMenuNameCount; i++) {
            var odMenuName = $("input[name='odMenuName']").eq(i).val();
            var odOptionGroupName = $("input[name='odOptionGroupName']").eq(i).val();
            var odOptionName = $("input[name='odOptionName']").eq(i).val();
            var odMenuQty = $("input[name='odMenuQty']").eq(i).val();
            var odMenuPrice = $("input[name='odMenuPrice']").eq(i).val();
            var odOptionPrice = $("input[name='odOptionPrice']").eq(i).val();
            var odMenuImage = $("input[name='odMenuImage']").eq(i).val();
            var odMenuQtyFlag = $("input[name='odMenuQtyFlag']").eq(i).val();


            var odMenuImageCopy;
            var odMenuNameCopy;
            var odOptionGroupNameCopy;
            var odOptionNameCopy;
            var odMenuQtyCopy;
            var odMenuPriceCopy;
            var odOptionPriceCopy;
            var test2;
            var totalPrice;


            if (odMenuNameCopy != undefined && odMenuQtyFlag == 0) {
                odMenuNameCopy = odMenuNameCopy + "," + odMenuName;
                odMenuImageCopy = odMenuImageCopy + "," + odMenuImage;
                odMenuQtyCopy = odMenuQtyCopy + "," + odMenuQty;
                odMenuPriceCopy = odMenuPriceCopy + "," + odMenuPrice;
                totalPrice = totalPrice + parseInt(odMenuPrice);
            } else if (odMenuNameCopy == undefined) {

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

            if (odOptionNameCopy == undefined) {
                odOptionNameCopy = odOptionName;
                test2 = odMenuName;
                odOptionGroupNameCopy = odOptionGroupName;
                odOptionPriceCopy = odOptionPrice;

            } else if (test2 != odMenuName && odOptionNameCopy.substring(odOptionNameCopy.length - 1, odOptionNameCopy.length) != "/") {
                odOptionNameCopy = odOptionNameCopy + "/" + odOptionName;
                odOptionGroupNameCopy = odOptionGroupNameCopy + "/" + odOptionGroupName;
                odOptionPriceCopy = odOptionPriceCopy + "/" + odOptionPrice;

            } else if (odOptionNameCopy != undefined) {

                odOptionNameCopy = odOptionNameCopy + "," + odOptionName;
                test2 = odMenuName;
                odOptionGroupNameCopy = odOptionGroupNameCopy + "," + odOptionGroupName;
                odOptionPriceCopy = odOptionPriceCopy + odOptionPrice;
            }

            odOptionNameL = odOptionNameCopy.split("/");
            odOptionGroupNameL = odOptionGroupNameCopy.split("/");
            odOptionPriceL = odOptionPriceCopy.split("/").map(Number);


            /* alert("total"+odMenuPriceL)
             alert("price"+odOptionPriceL)*/


        }


        var menuPrice = 0;
        for (var i = 0; i < odMenuNameL.length; i++) {


            menuPrice += (odOptionPriceL[i] + odMenuPriceL[i]);


            /*  divElemApply1 = "<div class=\"card mb-3\" style=\"max-width: 540px;\">" +
                  " <div class=\"row g-0\">" +
                  "<div class=\"col-md-4\">" +
                  "<img src=\"/resources/image/1.jpg\" class=\"img-fluid rounded-start\" alt=\"image\">" +
                  "</div>" +
                  "<div class=\"col-md-8\">" +
                  "<div class=\"card-body\">" +
                  "<h5 class=\"card-title\">" + odMenuNameL[i] + "</h5>" +
                  "<p class=\"card-text\"><small class=\"text-muted\">옵션 " + odOptionNameL[i] + " :" + odOptionGroupNameL[i] + "  :</small></p>" +
                  "<p class=\"card-text\"><small class=\"text-muted\">수량 :" + odMenuQtyL[i] + " 가격 :" + (odOptionPriceL[i] + odMenuPriceL[i]) + " </small></p>" +
                  "</div>" +
                  "</div>" +
                  "</div>" +
                  "</div>"*/


            /*  divElemApply1 ="<li class='list-group-item'>"+
              "<div class='row border-top border-bottom'>"+
              "<div class='row main align-items-center'>"+
              "<div class='col'>"+
              "<div class='row text-muted'>" + odMenuNameL[i] + " :" + odOptionGroupNameL[i] + "</div>"+
              "<div class='row'>" + odOptionNameL[i] + "</div>"+
              "</div>"+
              "<div class='col'> <a href='#'>-</a><a href='#' class='border'>" + odMenuQtyL[i] + "</a><a href='#'>+</a> </div>"+
              "<div class='col'>" + (odOptionPriceL[i] + odMenuPriceL[i]) + "<span class='close'>&#10005;</span></div>"+
              "</div>"+
              "</div>"+
              "</li>"*/
            /*

                        divElemApply1 = "<div class='row data'>"+
                        "<div class='check'><input type='checkbox' name='buy' value='260' checked=''>&nbsp;</div>"+
                        "<div class='pname'>"+
                        "<span>찜마마(XJ-92214/3)</span>"+
                        "</div>"+
                        "<div class='basketprice'><input type='hidden' name='p_price' id='p_price2' class='p_price' value='20000'>20,000원</div>"+
                        "<div class='num'>"+
                        "<div class='updown'>"+
                        "<input type='text' name='p_num1' id='p_num2' size='2' maxlength='4' class='p_num' value='2'>"+
                        "<span><i class='fas fa-arrow-alt-circle-up up'></i></span>"+
                        "<span><i class='fas fa-arrow-alt-circle-down down'></i></span>"+
                        "</div>"+
                        "</div>"+
                        "<div class='sum'>40,000원</div>"+
                        "<div class='basketcmd'><a href='#' class='abutton'>삭제</a></div>"+
                        "</div>"
            */


            divElemApply1 = "<div class='row data'>"+
            "<div class='subdiv'>"+
            "<div class='check'><input type='checkbox' name='buy' value='260' checked='' onclick='javascript:basket.checkItem();'>&nbsp;</div>"+
            "<div class='pname'>"+
            "<span>찜마마(XJ-92214/3)</span>"+
            "</div>"+
            "</div>"+
            "<div class='subdiv'>"+
            "<div class='basketprice'><input type='hidden' name='p_price' id='p_price1' class='p_price' value='20000'>20,000원</div>"+
            "<div class='num'>"+
            "<div class='updown'>"+
            "<input type='text' name='p_num1' id='p_num1' size='2' maxlength='4' class='p_num' value='2' onkeyup='javascript:basket.changePNum(" + i + ");'>"+
            "<span onclick='javascript:basket.changePNum(" + i + ");'><i class='fas fa-arrow-alt-circle-up up'></i></span>"+
            "<span onclick='javascript:basket.changePNum(" + i + ");'><i class='fas fa-arrow-alt-circle-down down'></i></span>"+
            "</div>"+
            "</div>"+
            "<div class='sum'>40,000원</div>"+
            "</div>"+
            "<div class='subdiv'>"+
            "<div class='basketcmd'><a href='javascript:void(0)' class='abutton' onclick='javascript:basket.delItem();'>삭제</a></div>"+
            "</div>"+
            "</div>"


            alert(divElemApply1)
            $('#order').append(divElemApply1);

        }
        /*alert(menuPrice)*/

        divElemApply2 = "<input type=\"hidden\" name=\"orderPrice\" id=\"orderPrice\" value=\"" + menuPrice + "\">" +
            "<h5 id='price'>합계 : " + menuPrice + "</h5>"


        $('#total').append(divElemApply2);


    });
</script>

</body>
</html>
