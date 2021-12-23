<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <title>test</title>

    <jsp:include page="index.jsp"></jsp:include>

    <!-- CSS File -->
    <link href="../../../resources/css/message_list.css" rel="stylesheet">
    <link href="navbar.css" rel="stylesheet">

    <!-- 메세지 전송 아이콘(종이비행기) 때문에 필요 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" type="text/css" rel="stylesheet"/>
    <%--<style>



        img{
            /*글쓴이의 프로필 사진을 둥글게*/
            width: 40px;
            height: 40px;
            border: 0px;
            /*border: 1px solid #cecece;*/
            border-radius: 50%;
        }

        p {
            /*font-family: 'Noto Sans KR', sans-serif;*/
            font-size: 20px;
        }

        .badge{
            margin-left: 15px;
        }



        .msg-container{max-width:1170px; margin:auto;}
        img{ max-width:100%;}
        .inbox_people {
            background: #f8f8f8 none repeat scroll 0 0;
            float: left;
            overflow: hidden;
            width: 40%; border-right:1px solid #f7f7f7;
        }
        .inbox_msg {
            border: 1px solid #f7f7f7;
            border-radius: 15px;
            clear: both;
            overflow: hidden;
        }
        .top_spac{ margin: 20px 0 0;}


        .recent_heading {float: left; width:40%;}
        .srch_bar {
            display: inline-block;
            text-align: right;
            width: 60%;
        }
        .headind_srch{ padding:10px 29px 10px 20px; overflow:hidden; border-bottom:1px solid #f7f7f7;}

        .recent_heading h4 {
            color: #cf795f;
            font-size: 30px;
            margin: auto;

        }
        .srch_bar input{ border:1px solid #cdcdcd; border-width:0 0 1px 0; width:80%; padding:2px 0 4px 6px; background:none;}
        .srch_bar .input-group-addon button {
            background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
            border: medium none;
            padding: 0;
            color: #707070;
            font-size: 18px;
        }
        .srch_bar .input-group-addon { margin: 0 0 0 -27px;}

        .chat_ib h5{ font-size:20px; color:#464646; margin:0 0 8px 0; }
        .chat_ib h5 span{ font-size:17px; float:right;}
        .chat_ib p{ font-size:14px; color:#989898; margin:auto}
        .chat_img {
            float: left;
            width: 11%;
        }
        .chat_ib {
            float: left;
            padding: 0 0 0 15px;
            width: 88%;
        }

        .chat_people{ overflow:hidden; clear:both;}
        .chat_list {
            border-bottom: 1px solid #f7f7f7;
            margin: 0;
            padding: 18px 16px 10px;
        }


        .chat_list_box :hover{
            background-color: #d6ead0;
        }

        .inbox_chat { height: 550px; overflow-y: scroll;}

        .active_chat{ background:#ebebeb;}

        .incoming_msg_img {
            display: inline-block;
            width: 6%;
        }
        .received_msg {
            display: inline-block;
            padding: 0 0 0 10px;
            vertical-align: top;
            width: 92%;
        }
        .received_withd_msg p {
            background: #f4f4f4 none repeat scroll 0 0;
            border-radius: 7px;
            color: #646464;
            font-size: 14px;
            margin: 0;
            padding: 10px 10px 10px 12px;
            width: 100%;
            /*font-family: 'Noto Sans KR', sans-serif;*/
        }
        .time_date {
            color: #747474;
            display: block;
            font-size: 12px;
            margin: 5px 0 8px;
        }
        .received_withd_msg { width: 57%;}
        .mesgs {
            float: left;
            padding: 30px 15px 0 25px;
            width: 60%;
        }

        .sent_msg p {
            background: #97df93 none repeat scroll 0 0;
            border-radius: 7px;
            font-size: 14px;
            margin: 0; color:#fff;
            padding: 10px 10px 10px 12px;
            width:100%;
            /*font-family: 'Noto Sans KR', sans-serif;*/

        }
        .outgoing_msg{ overflow:hidden; margin:26px 0 26px;}
        .sent_msg {
            float: right;
            width: 46%;
            /*font-family: 'Noto Sans KR', sans-serif;*/
        }
        .input_msg_write input {
            background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
            border: medium none;
            color: #4c4c4c;
            font-size: 15px;
            min-height: 48px;
            width: 100%;
        }

        .type_msg {border-top: 1px solid #dfdfdf;position: relative;}
        .msg_send_btn {
            background: #ff5900 none repeat scroll 0 0;
            border: medium none;
            border-radius: 50%;
            color: #fff;
            cursor: pointer;
            font-size: 17px;
            height: 33px;
            position: absolute;
            right: 0;
            top: 11px;
            width: 33px;
        }

        .msg_send_btn:hover{
            background: #ff5900 none repeat scroll 0 0;
        }

        .messaging { padding: 0 0 50px 0;}
        .msg_history {
            height: 516px;
            overflow-y: auto;
        }

    </style>--%>
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
                        //$('.chat_list_box:first').addClass('active_chat');
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
                        //$('.chat_list_box:first').addClass('active_chat');
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
    });




</script>
</body>
</html>