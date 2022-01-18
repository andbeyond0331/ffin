<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>채팅</title>
    <jsp:include page="../../common/lib.jsp"/>
    <jsp:include page="../../common/profileDropdown.jsp"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
    <meta charset="UTF-8">
    <link href="../../resources/css/message_list.css" rel="stylesheet">
    <style>
        *{
            margin:0;
            padding:0;
        }
        .container{
            width: 800px;
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
        .chating-box{
            margin-bottom: 20px;
            margin-top: 20px;
            box-shadow: 0 2px 4px 0 rgb(0 0 0 / 20%);
            padding: 15px;
            border-radius: 10px 10px 10px 10px;
            background-color: white;
        }

        .chating{
            padding: 10px;
            display: table-cell;
            width: 750px;
            height: 500px;
            overflow: auto;
            transition: 0.3s;
            border-radius: 10px 10px 10px 10px;
        }
        .chating .me{
            color: #F6F6F6;
            text-align: right;
            padding-left: 15px;
            padding-right: 15px;
        }
        .chating .others{
            color: #FFE400;
            text-align: left;
            padding-left: 15px;
            padding-right: 15px;
        }
        input{
            width: 330px;
            height: 25px;
        }
        .msgImg{
            width: 200px;
            height: 125px;

        }
        .clearBoth{
            clear: both;
        }
        .img{
            float: right;
        }
        img{
            /*글쓴이의 프로필 사진을 둥글게*/
            width: 40px;
            height: 40px;
            border: 0px;
            /*border: 1px solid #cecece;*/
            border-radius: 50%;
        }
        .incoming_msg_img{
            position: relative;
            display: grid;
            align-items: center;
        }
        .uuuuuddd{position: absolute; top: 20px;left: 0;}
        .input_msg_write{
            display: flex;
            justify-content: center;
        }
        .write_msg_chat.form-control{
            background: #e9ecef none repeat scroll 0 0;
            border-radius: 50px;
            margin-top: 15px;
            font-size: 14px;
            height: 35px;
            padding-left: 20px;
            min-height: unset;
            margin-bottom: 0;
        }
        .write_msg_chat:focus{
            color: #212529;
            background-color: #fff;
            border-color: #ffec8a;
            outline: 0;
            box-shadow: 0 0 0 0.1rem rgb(255, 236, 138);
        }
        .sent_msg{
            float: right;
        }
        .incoming_msg{
            display: flex;
            margin-top: 10px;
        }
        .outgoing_msg_chat{
            overflow: hidden;
            display: flex;
            justify-content: flex-end;
        }


    </style>
</head>

<script type="text/javascript">
    var ws;
    var userName = '${sessionScope.user.userId}';
    console.log("userName: "+userName);
    let today = new Date();

    $(document).ready(function(){


        wsOpen();

        //  connect();
    });

    function wsOpen(){
        //웹소켓 전송시 현재 방의 번호를 넘겨서 보낸다.
        ws = new WebSocket("ws://" + location.host + "/chating/"+$("#roomNumber").val());
        wsEvt();
    }

    function wsEvt() {
        ws.onopen = function(data){
            //소켓이 열리면 동작
        }


        ws.onmessage = function(data) {
            //메시지를 받으면 동작
            var msg = data.data;

            if(msg != null && msg.type != ''){
                var d = JSON.parse(msg);
                console.log("d: "+d.profile);
                if(d.type == "getId"){
                    var si = d.sessionId != null ? d.sessionId : "";
                    if(si != ''){
                        $("#sessionId").val(si);
                        $("#sessionName").val(d.userName);
                    }
                }else if(d.type == "message"){
                    console.log("d2: "+d.time)
                    if(d.sessionId == $("#sessionId").val()){
                        var div = "";
                       div += "<div class='outgoing_msg_chat'>"
                +"<div class='sent_msg'>"
                   +" <p>"+d.msg+"</p>"
                    +"<span class='time_date'>"+d.time+"</span>"
                +"</div>"
            +"</div>";

                       /* $("#chating").append("<p class='me'>" +
                            "<a href='/views/home.jsp'><img src='../../../resources/image/"+d.profile+"' alt='sunil' ></a>"
                            +userName+" :" + d.msg + "</p>");*/
                        $("#chating").append(div);
                    }else{









                        var div2 = "";
                        div2 +=" <div class='incoming_msg'>"
                            + "<div class='incoming_msg_img'>"
                            +"<a class='user-profile' href='#' data-toggle='dropdown' role='button' data-target='#' aria-haspopup='true' aria-expanded='false'>"
                            + "<img src='../../../resources/image/"+d.profile+"' alt='sunil' >"
                            +"</a>"
                            +"<ul class='dropdown-menu' role='menu' aria-labelledby='dLabel'>"
                                +"<li><a class='dropdown-item user-menu user-view' href='#' idx='"+d.userName+"'><i class='fas fa-user-circle'></i>프로필보기</a></li>"
                                +"<li><a class='dropdown-item user-menu user-message' href='#' idx='"+d.userName+"'><i class='fas fa-broom'></i>쪽지보내기</a></li>"
                                +"<li><a class='dropdown-item user-menu user-report' href='#' idx='"+d.userName+"'><i class='fas fa-sign-out-alt'></i>신고하기</a></li>"
                            +"</ul>"
                            +"<span class='time_date' style='margin-right: 0; display: grid;'>"+d.userName+"</span>"
                            + "</div>"
                            +"  <div class='received_msg' style='padding-left: 0;'>"
                            +"<div class='received_withd_msg'>"
                            + "<p>"+d.msg+"</p>"
                            +"<span class='time_date' style='text-align:right; margin-left: 15px;'>"+d.time+"</span>"
                            + " </div>"
                            +  "</div>"
                            + " </div>";
                        $("#chating").append(div2);
                        //$("#chating").append("<p class='others'><a href='/views/home.jsp'><img src='../../../resources/image/"+d.profile+"' alt='sunil' ></a>" + d.userName + " :" + d.msg + "</p>");
                    }

                }else{
                    console.warn("unknown type!")
                }
            }else{

                //파일 업로드한 경우 업로드한 파일을 채팅방에 뿌려준다.
                var url = URL.createObjectURL(new Blob([msg]));
                console.log('url: '+url)
                console.log('msg: '+msg)
                $("#chating").append("<div class='img'><img class='msgImg' src="+url+"></div><div class='clearBoth'></div></p>");

                /*
                    채팅에서 사진 전송을 제외하던지
                    다른 방법을 찾아보던지 해야 할 것 같음 잘 안되네

                if(userName== $("#sessionName").val()){
                    console.log("여기지.")
                    $("#chating").append("<p class='me'>"+userName+" :<div class='img'><img class='msgImg' src="+url+"></div><div class='clearBoth'></div></p>");
                }else{
                    console.log("아니, 여기지.")
                    $("#chating").append("<p class='others'>" + $("#sessionName").val() + " :<div class='img'><img class='msgImg' src="+url+"></div><div class='clearBoth'></div></p>");
                } */

            }
            $("#chating").scrollTop($("#chating")[0].scrollHeight);
        }

        document.addEventListener("keypress", function(e){
            if(e.keyCode == 13){ //enter press
                send();
            }
        });
    }

    function chatName(){
       // var userName = $("#userName").val();
        var userName = '${sessionScope.userId}';
        console.log("userName: "+userName);
      /*  if(userName == null || userName.trim() == ""){
            alert("사용자 이름을 입력해주세요.");
            $("#userName").focus();
        }else{
            wsOpen();
            $("#yourName").hide();
            $("#yourMsg").show();
        }*/
    }

    function send() {

        var option ={
            type: "message",
            roomNumber: $("#roomNumber").val(),
            sessionId : $("#sessionId").val(),
            userName : userName,
            msg : $("#chatting").val()
            //time : today.getHours()+" : "+today.getMinutes()+" : "+today.getSeconds()
        }
        ws.send(JSON.stringify(option))
        $('#chatting').val("");
    }

    function fileSend(){
        var file = document.querySelector("#fileUpload").files[0];
        var fileReader = new FileReader();

        console.log("file: "+file+"fileReader : "+fileReader);

        fileReader.onload = function() {
            var param = {
                type: "fileUpload",
                file: file,
                roomNumber: $("#roomNumber").val(),
                sessionId : $("#sessionId").val(),
                msg : $("#chatting").val(),
                userName : userName
            }
            ws.send(JSON.stringify(param)); //파일 보내기전 메시지를 보내서 파일을 보냄을 명시한다.

            arrayBuffer = this.result;
            ws.send(arrayBuffer); //파일 소켓 전송
        };
        fileReader.readAsArrayBuffer(file);
    }


</script>
<body id="page-top">
<jsp:include page="../navbar.jsp"></jsp:include>
<%--<jsp:include page="/views/navbar.jsp" />--%>


<section class="client_section layout_padding">
    <div id="container" class="container">
        <div class="col-md-11 col-lg-10 mx-auto" style="margin-top: 10px;">
            <div class="detail-box">
                <i class="fa fa-quote-left" aria-hidden="true"></i>
                <h4 style="margin-top: 10px;">
                    ${roomName} 채팅방
                        <input type="hidden" id="sessionId" value="">
                        <input type="hidden" id="sessionName" value="">
                        <input type="hidden" id="roomNumber" value="${roomNumber}">
                </h4>

            </div>
        </div>

        <%-- 채팅창 --%>
        <div class="col-12 chating-box">
            <%-- 메세지 전송창 --%>
            <div id="chating" class="chating">
            </div>
            <input type="hidden" name="userName" id="userName">

            <%-- 메세지 입력창 --%>
            <div class='type_msg'>
                <div class='input_msg_write row'>
                    <div class='col-10' style="padding-right: 0;">
                        <input type='text' id="chatting" class='write_msg_chat form-control' placeholder='보내실 메시지를 입력하세요.' />
                    </div>
                    <div class='col-1' style="padding: 0; position: relative; margin-top: 5px;">
                        <div><button class='msg_send_btn' type='button' onclick="send()" id="sendBtn"><ion-icon name="paper-plane-outline"></ion-icon></button></div>
                    </div>
                </div>
            </div>
        </div>

   <%-- <div id="yourName">
        <table class="inputTable">
            <tr>
                <th>사용자명</th>
                <th><input type="text" name="userName" id="userName"></th>
                <th><button onclick="chatName()" id="startBtn">이름 등록</button></th>
            </tr>
        </table>
    </div>--%>

    <%--<div id="yourMsg">
        <table class="inputTable">
            <tr>
                <th>메시지</th>
                <th><input id="chatting" placeholder="보내실 메시지를 입력하세요."></th>
                <th><button onclick="send()" id="sendBtn">보내기</button></th>
            </tr>
           &lt;%&ndash; <tr>
                <th>파일업로드</th>
                <th><input type="file" id="fileUpload"></th>
                <th><button onclick="fileSend()" id="sendFileBtn">파일올리기</button></th>
            </tr>&ndash;%&gt;
        </table>
    </div>--%>

    </div>
</section>
</body>
</html>


