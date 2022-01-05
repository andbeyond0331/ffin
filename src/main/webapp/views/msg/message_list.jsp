<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <title>메세지</title>
    <jsp:include page="../../common/lib.jsp"/>


    <!-- bootstrap, jquery -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>


    <!--  날씨아이콘 부트스트랩 -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/weather-icons/2.0.9/css/weather-icons.min.css">

    <!-- Google Fonts -->
    <!--
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
     -->

    <!-- font -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">


    <!-- font -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">

    <!-- CSS File -->
    <link href="../../resources/css/message_list.css" rel="stylesheet">
    <link href="navbar.css" rel="stylesheet">

    <!-- 메세지 전송 아이콘(종이비행기) 때문에 필요 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" type="text/css" rel="stylesheet"/>

</head>

<body>

<!-- 메뉴바
   현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐
  -->
<jsp:include page="navbar.jsp">
    <jsp:param value="msg" name="thisPage" />
</jsp:include>


<br />
<br />
<br />
<br />
<br />

<div class="msg-container">

    <div class="messaging">
        <div class="inbox_msg">
            <!-- 메세지 목록 영역 -->
            <div class="inbox_people">
                <div class="headind_srch">
                    <div class="recent_heading">
                        <h4>메세지함</h4>
                    </div>
                    <!-- 메세지 검색 -->
          <%--          <div class="srch_bar">
                        <div class="stylish-input-group">
                            <input type="text" class="search-bar"  placeholder="Search" >
                            <span class="input-group-addon">
	                <button type="button"> <i class="fa fa-search" aria-hidden="true"></i> </button>
	                </span>
                        </div>
                    </div>--%>
                </div>

                <!-- 메세지 리스트 -->
                <div class="inbox_chat">

                </div>
            </div>

            <!-- 메세지 내용 영역 -->
            <div class="mesgs">
                <!-- 메세지 내용 목록 -->
                <div class="msg_history" name="contentList">
                    <!-- 메세지 내용이 올 자리 -->
                </div>
                <div class="send_message">
                </div>
                <!-- 메세지 입력란이 올자리 -->
            </div>
        </div>

    </div>
</div>

<script>

    // 가장 처음 메세지 리스트를 가져온다.
    const FirstMessageList = function(){
        $.ajax({
            url:"/msg/json/message_ajax_list",
            method:"get",
            data:{
            },
            success:function(data){

                console.log("메세지 리스트 리로드 성공");

                $('.inbox_chat').html(data);

                // 메세지 리스트중 하나를 클릭했을 때
                $('.chat_list').on('click', function(){
                    //alert('room : '+ $(this).attr('room'));

                    let msgRoom = $(this).attr('msgRoom');
                    let other_id = $(this).attr('other-id');
                    //let other_id='user02';
                    // 선택한 메세지빼고 나머지는 active 효과 해제하기
                    $('.chat_list_box').not('.chat_list_box.chat_list_box'+msgRoom).removeClass('active_chat');
                    // 선택한 메세지만 active 효과 주기
                    $('.chat_list_box'+msgRoom).addClass('active_chat');

                    let send_msg = "";
                    send_msg += "<div class='type_msg'>";
                    send_msg += "	<div class='input_msg_write row'>";
                    send_msg += "		<div class='col-11'>";
                    send_msg += "			<input type='text' class='write_msg form-control' placeholder='메세지를 입력...' />";
                    send_msg += "		</div>";
                    send_msg += "		<div class='col-1'>";
                    send_msg += "			<button class='msg_send_btn' type='button'><i class='fa fa-paper-plane-o' aria-hidden='true'></i></button>";
                    send_msg += "		</div>";
                    send_msg += "	</div>";
                    send_msg += "</div>";

                    // 메세지 입력, 전송 칸을 보인다.
                    $('.send_message').html(send_msg);

                    // 메세지 전송버튼을 눌렀을 때
                    $('.msg_send_btn').on('click',function(){

                        // 메세지 전송 함수 호출
                        SendMessage(msgRoom, other_id);

                        // 전송버튼을 누르면 메세지 리스트가 리로드 되면서 현재 열린 메세지의 선택됨 표시가 사라진다.
                        // 이걸 해결하기 위해 메세지 전송버튼을 누르고 메세지 리스트가 리로드되면 메세지 리스트의 첫번째 메세지(현재 열린 메세지)가 선택됨 표시 되도록 한다.
                        $('.chat_list_box:first').addClass('active_chat');
                    });


                    // 메세지 내용을 불러오는 함수 호출
                    MessageContentList(msgRoom);

                });

            }
        })
    };

    // 메세지 리스트를 다시 가져온다.
    const MessageList = function(){
        $.ajax({
            url:"/msg/json/message_ajax_list",
            method:"get",
            data:{
            },
            success:function(data){
                //alert("2")
                console.log("메세지 리스트 리로드 성공");

                $('.inbox_chat').html(data);

                // 메세지 리스트중 하나를 클릭했을 때
                $('.chat_list').on('click', function(){
                    //alert('room : '+ $(this).attr('room'));

                    let msgRoom = $(this).attr('msgRoom');
                    let other_id = $(this).attr('other-id');

                    // 선택한 메세지빼고 나머지는 active 효과 해제하기
                    $('.chat_list_box').not('.chat_list_box.chat_list_box'+msgRoom).removeClass('active_chat');
                    // 선택한 메세지만 active 효과 주기
                    $('.chat_list_box'+msgRoom).addClass('active_chat');

                    let send_msg = "";
                    send_msg += "<div class='type_msg'>";
                    send_msg += "	<div class='input_msg_write row'>";
                    send_msg += "		<div class='col-11'>";
                    send_msg += "			<input type='text' class='write_msg form-control' placeholder='메세지를 입력...' />";
                    send_msg += "		</div>";
                    send_msg += "		<div class='col-1'>";
                    send_msg += "			<button class='msg_send_btn' type='button'><i class='fa fa-paper-plane-o' aria-hidden='true'></i></button>";
                    send_msg += "		</div>";
                    send_msg += "	</div>";
                    send_msg += "</div>";

                    // 메세지 입력, 전송 칸을 보인다.
                    $('.send_message').html(send_msg);

                    // 메세지 전송버튼을 눌렀을 때
                    $('.msg_send_btn').on('click',function(){

                        // 메세지 전송 함수 호출
                        SendMessage(msgRoom, other_id);

                        // 전송버튼을 누르면 메세지 리스트가 리로드 되면서 현재 열린 메세지의 선택됨 표시가 사라진다.
                        // 이걸 해결하기 위해 메세지 전송버튼을 누르고 메세지 리스트가 리로드되면 메세지 리스트의 첫번째 메세지(현재 열린 메세지)가 선택됨 표시 되도록 한다.
                        $('.chat_list_box:first').addClass('active_chat');
                    });

                    // 메세지 내용을 불러오는 함수 호출
                    MessageContentList(msgRoom);

                });

                // 전송버튼을 누르면 메세지 리스트가 리로드 되면서 현재 열린 메세지의 선택됨 표시가 사라진다.
                // 이걸 해결하기 위해 메세지 전송버튼을 누르고 메세지 리스트가 리로드되면 메세지 리스트의 첫번째 메세지(현재 열린 메세지)가 선택됨 표시 되도록 한다.
                $('.chat_list_box:first').addClass('active_chat');
            }
        })
    };


    // 메세지 내용을 가져온다.
    // 읽지 않은 메세지들을 읽음으로 바꾼다.
    const MessageContentList = function(msgRoom) {

        $.ajax({
            url:"/msg/json/message_content_list",
            method:"GET",
            data:{
                msgRoom : msgRoom,
            },
            success:function(data){
               // alert("3")
                console.log("메세지 내용 가져오기 성공");

                // 메세지 내용을 html에 넣는다
                $('.msg_history').html(data);

                // 이 함수로 메세지 내용을 가져올때마다 스크롤를 맨아래로 가게 한다.
                $(".msg_history").scrollTop($(".msg_history")[0].scrollHeight);

            },
            error : function() {
                alert('서버 에러');
            }
        })

        $('.unread'+msgRoom).empty();

    };


    // 메세지를 전송하는 함수
    const SendMessage = function(msgRoom, other_id){


        let msgContent = $('.write_msg').val();
//evt.preventDefault();


        msgContent = msgContent.trim();
      //  alert("msgContent : "+msgContent);
      //  alert("other_id: "+other_id);
      //  alert("msgRoom: "+msgRoom);
        if(msgContent == ""){
            alert("메세지를 입력하세요!");
        }else{
            $.ajax({
                url:"/msg/json/message_send_inlist",
                method:"POST",

                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                data:{
                    msgRoom : msgRoom,
                    other_id: other_id,
                    msgContent: msgContent
                },
                success:function(data){
                    // 전송에 성공시 알림을 주기 위하여..
                    var userId = '${sessionScope.user.userId}';
                    console.log("message.socket::::" + socket);
                    if(socket) {
                        // websocket에 보내기!!! (message, 보내는이, 받는이)
                        let socketMessage = "message,"+userId+","+other_id;
                        console.log("socketM::::" + socketMessage);
                        socket.send(socketMessage);
                    }


                    console.log("메세지 전송 성공");

                    // 메세지 입력칸 비우기
                    $('.write_msg').val("");

                    // 메세지 내용  리로드
                    MessageContentList(msgRoom);

                    // 메세지 리스트 리로드
                    MessageList();

                },
                error : function() {
                    alert('서버 왜 에러?');
                }
            });
        }

    };

    $(document).ready(function(){
        // 메세지 리스트 리로드
        FirstMessageList();

        connectWS();

      //  connect();
    });




</script>

<script>
    var socket = null; //전역변수.
   /* $(document).ready(function(){
        connectWS();
    });*/

    function connectWS(){
        var ws = new WebSocket("ws://localhost:8080/push");
        // servlet-context에 선언한 path와 일치시키도록...
        socket = ws;

        ws.onopen = function(){
            console.log('Info : connection opened. ');


        };
        ws.onmessage = function(event){
            console.log("ReceiveMessage: ", event.data+'\n');
            let $socketAlert =  $('div#socketAlert');
            $socketAlert.html(event.data);
            $socketAlert.css('display', 'block');
            setTimeout( function(){
                $socketAlert.css('display', 'none')
            }, 3000)

        }

        ws.onclose = function(event){
            console.log('info: connection closed.');
            setTimeout( function(){connectWS();}, 1000);
        };
        ws.onerror = function(err){console.log('error: connection error.', err);};

    }


</script>
</body>
</html>