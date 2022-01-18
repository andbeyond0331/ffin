<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Room
    </title>
    <jsp:include page="../../common/lib.jsp"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <meta charset="UTF-8">

    <style>
        *{
            margin:0;
            padding:0;
            box-sizing: border-box;
        }
/*        .container{
            width: 500px;
            margin: 0 auto;
            padding: 25px;
            padding-top: 100px;
        }
        .container h1{
            text-align: left;
            padding: 5px 5px 5px 15px;
            color: #FFBB00;
            border-left: 3px solid #FFBB00;
            margin-bottom: 20px;
        }
        .roomContainer{
            background-color: #F6F6F6;
            width: 500px;
            height: 500px;
            overflow: auto;
        }
        .roomList{
            border: none;
        }
        .roomList th{
            border: 1px solid #FFBB00;
            background-color: #fff;
            color: #FFBB00;
        }
        .roomList td{
            border: 1px solid #FFBB00;
            background-color: #fff;
            text-align: left;
            color: #FFBB00;
        }
        .roomList .num{
            width: 75px;
            text-align: center;
        }
        .roomList .room{
            width: 350px;
        }
        .roomList .go{
            width: 71px;
            text-align: center;
        }
        button{
            background-color: #FFBB00;
            font-size: 14px;
            color: #000;
            border: 1px solid #000;
            border-radius: 5px;
            padding: 3px;
            margin: 3px;
        }
        .inputTable th{
            padding: 5px;
        }
        .inputTable input{
            width: 330px;
            height: 25px;
        }*/

        :root {
            --surface-color: #fff;
            --curve: 40;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin: 6rem 5vw;
            padding: 0;
            list-style-type: none;
        }

        .card {
            position: relative;
            display: block;
            height: 100%;
            border-radius: calc(var(--curve) * 1px);
            overflow: hidden;
            text-decoration: none;
            box-shadow: 0 2px 4px 0 rgb(0 0 0 / 20%);
            transition: 0.3s;
        }

        .card__image {
            width: 100%;
            height: auto;
        }

        .card__overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            z-index: 1;
            border-radius: calc(var(--curve) * 1px);
            background-color: var(--surface-color);
            transform: translateY(100%);
            transition: .2s ease-in-out;
        }

        .card:hover .card__overlay {
            transform: translateY(0);
        }

        .card__header {
            position: relative;
            display: flex;
            align-items: center;
            gap: 2em;
            padding: 2em;
            border-radius: calc(var(--curve) * 1px) 0 0 0;
            background-color: var(--surface-color);
            transform: translateY(-100%);
            transition: .2s ease-in-out;
        }

        .card__arc {
            width: 80px;
            height: 80px;
            position: absolute;
            bottom: 100%;
            right: 0;
            z-index: 1;
        }

        .card__arc path {
            fill: var(--surface-color);
            d: path("M 40 80 c 22 0 40 -22 40 -40 v 40 Z");
        }

        .card:hover .card__header {
            transform: translateY(0);
        }

        .card__thumb {
            flex-shrink: 0;
            width: 50px;
            height: 50px;
            border-radius: 50%;
        }

        .card__title {
            font-size: 1em;
            margin: 0 0 .3em;
            color: #6A515E;
        }

        .card__tagline {
            display: block;
            margin: 1em 0;
            font-family: "MockFlowFont";
            font-size: .8em;
            color: #ffba49;
        }

        .card__status {
            font-size: .8em;
            color: #ffba49;
            margin-left: 10px;
        }

        .card__description {
            padding: 0 2em 2em;
            margin: 0;
            color: #ffba49;
            font-family: "MockFlowFont";
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 3;
            overflow: hidden;
        }
    </style>
</head>

<script type="text/javascript">
    var ws;
    window.onload = function(){
        getRoom();
        createRoom();
    }

    function getRoom(){
        commonAjax('/getRoom', "", 'post', function(result){
            createChatingRoom(result);
        });
    }

    function createRoom(){

            var msg = {	roomNumber : 1, roomName : '서울'	};

            commonAjax('/createRoom', msg, 'post', function(result){
                createChatingRoom(result);
            });

            $("#roomName").val("");

    }

    function goRoom(number, name){

        location.href="/moveChating?roomNumber="+number+"&roomName="+name;



    }

    function createChatingRoom(res){

    }

    function commonAjax(url, parameter, type, calbak, contentType){
        $.ajax({
            url: url,
            data: parameter,
            type: type,
            contentType : contentType!=null?contentType:'application/x-www-form-urlencoded; charset=UTF-8',
            success: function (res) {
                calbak(res);
            },
            error : function(err){
                console.log('error');
                calbak(err);
            }
        });
    }
</script>
<body>
<jsp:include page="../navbar.jsp"></jsp:include>
<%--<div class="container">
    <h1>채팅방</h1>
    <div id="roomContainer" class="roomContainer">
        <table id="roomList" class="roomList">
            <tr>
                <td class='num'>1</td>
                <td class='room'>서울</td>
                <td class='go'><button type='button' onclick="goRoom(1, '서울')">참여</button></td>

            </tr>

            <tr>
                <td class='num'>2</td>
                <td class='room'>부산</td>
                <td class='go'><button type='button' onclick="goRoom(2, '부산')">참여</button></td>

            </tr>

            <tr>
                <td class='num'>3</td>
                <td class='room'>경기</td>
                <td class='go'><button type='button' onclick="goRoom(3, '경기')">참여</button></td>

            </tr>

        </table>
    </div>

</div>--%>


<section class="client_section layout_padding">
    <div class="container">
        <div class="col-md-11 col-lg-10 mx-auto" style="margin-top: 70px;">
            <div class="detail-box">
                <i class="fa fa-quote-left" aria-hidden="true"></i>
                <h4 style="margin-top: 10px;">
                    채팅방
                </h4>
            </div>
        </div>

        <ul class="cards">
            <li>
                <a href="#" class="card" onclick="goRoom(1, '서울')">
                    <img src="../../resources/image/seoul.jpg" class="card__image" alt="" />
                    <div class="card__overlay">
                        <div class="card__header">
                            <svg class="card__arc" xmlns="http://www.w3.org/2000/svg"><path /></svg>
                            <img class="card__thumb" src="../../resources/bootstrap/assets/logo.svg" alt="" style="max-width: 30px;"/>
                            <div class="card__header-text" style="display: inherit;">
                                <h3 class="card__title">SEUOL</h3>
                                <span class="card__status">서울지역</span>
                            </div>
                        </div>
                        <p class="card__description">서울지역 푸드트럭 채팅방입니다.</p>
                    </div>
                </a>
            </li>
            <li>
                <a href="#" class="card" onclick="goRoom(2, '부산')">
                    <img src="../../resources/image/seoul.jpg" class="card__image" alt="" />
                    <div class="card__overlay">
                        <div class="card__header">
                            <svg class="card__arc" xmlns="http://www.w3.org/2000/svg"><path /></svg>
                            <img class="card__thumb" src="../../resources/bootstrap/assets/logo.svg" alt="" style="max-width: 30px;"/>
                            <div class="card__header-text" style="display: inherit;">
                                <h3 class="card__title">BUSAN</h3>
                                <span class="card__status">부산지역</span>
                            </div>
                        </div>
                        <p class="card__description">부산지역 푸드트럭 채팅방입니다.</p>
                    </div>
                </a>
            </li>
            <li>
                <a href="#" class="card" onclick="goRoom(3, '경기')">
                    <img src="../../resources/image/seoul.jpg" class="card__image" alt="" />
                    <div class="card__overlay">
                        <div class="card__header">
                            <svg class="card__arc" xmlns="http://www.w3.org/2000/svg"><path /></svg>
                            <img class="card__thumb" src="../../resources/bootstrap/assets/logo.svg" alt="" style="max-width: 30px;" />
                            <div class="card__header-text" style="display: inherit;">
                                <h3 class="card__title">GYEONGGI</h3>
                                <span class="card__status">수도권</span>
                            </div>
                        </div>
                        <p class="card__description">경기지역 푸드트럭 채팅방입니다.</p>
                    </div>
                </a>
            </li>
        </ul>

    </div>
</section>

</body>
</html>