<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <meta charset="UTF-8">
    <title>Room</title>
    <style>
        *{
            margin:0;
            padding:0;
        }
        .container{
            width: 500px;
            margin: 0 auto;
            padding: 25px
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
<div class="container">
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

</div>
</body>
</html>