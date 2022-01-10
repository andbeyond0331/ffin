<%--
  Created by IntelliJ IDEA.
  User: js
  Date: 2022/01/05
  Time: 12:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Basic -->
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />

<!-- jQery -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<!-- bootstrap js -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<!-- slick  slider -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.js"></script>
<!-- nice select -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js" integrity="sha256-Zr3vByTlMGQhvMfgkQ5BtWRSKBGa2QlspKYJnkjZTmo=" crossorigin="anonymous"></script>
<!-- custom js -->
<script src="../resources/bootstrap/js/custom.js"></script>

<!-- Custom styles for this template -->
<link href="../resources/bootstrap/css/style.css" rel="stylesheet" />
<!-- responsive style -->
<link href="../resources/bootstrap/css/responsive.css" rel="stylesheet" />

<!-- 카카오 로그인 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<!-- 구글 로그인 -->
<script src="https://apis.google.com/js/client:platform.js?onload=renderButton" async defer></script>
<meta name="google-signin-client_id" content="548740743413-4o51iohu918i0ukg4s9tcqpdrr3bnroj.apps.googleusercontent.com"/>


<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css"/>





<!-- bootstrap -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<!-- bootstrap core css -->
<link rel="stylesheet" type="text/css" href="../resources/bootstrap/css/bootstrap.css" />


<!-- fonts style -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">

<!-- font awesome style -->
<link href="../resources/bootstrap/css/font-awesome.min.css" rel="stylesheet" />
<!-- nice select -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" integrity="sha256-mLBIhmBvigTFWPSCtvdu6a76T+3Xyt+K571hupeFLg4=" crossorigin="anonymous" />
<!-- slidck slider -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css" integrity="sha256-UK1EiopXIL+KVhfbFa8xrmAWPeBjMVdvYMYkTAEv/HI=" crossorigin="anonymous" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css.map" integrity="undefined" crossorigin="anonymous" />
<!-- Custom styles for this template -->
<link href="../resources/bootstrap/css/style.css" rel="stylesheet" />
<!-- responsive style -->
<link href="../resources/bootstrap/css/responsive.css" rel="stylesheet" />

<!-- Favicons -->
<link rel="apple-touch-icon" sizes="180x180" href="../resources/bootstrap/assets/favicons/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32" href="../resources/bootstrap/assets/favicons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="../resources/bootstrap/assets/favicons/favicon-16x16.png">
<link rel="shortcut icon" type="image/x-icon" href="../resources/bootstrap/assets/favicons/favicon.ico">
<meta name="msapplication-TileImage" content="../resources/bootstrap/assets/favicons/mstile-150x150.png">
<meta name="theme-color" content="#ffffff">

<!-- Favicons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.2.0/css/all.min.css" integrity="sha512-6c4nX2tn5KbzeBJo9Ywpa0Gkt+mzCzJBrE1RB6fmpcsoN+b/w/euwIMuQKNyUoU/nToKN3a8SgNOtPrbW12fug==" crossorigin="anonymous" />

<!-- icnicons -->
<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>

<style>
    *{
        font-family: "Noto Sans CJK KR Regular", sans-serif;
    }

    .nav-user{
        width: 0;
        margin-right: 100px;
    }
    .navbar.navbar-expand-md{
        background-color: #fff;
        box-shadow: 2px 2px 2px #f17228;
        padding-left: 100px;
    }

    .btn.btn-default{
        color: #fff;
        background-color: #ffe537;
        margin-left: 10px;
        padding: 10px 15px 10px 15px;
    }
    .btn.btn-default:hover{
        color: #ffe537;
        background-color: #ffffff;
        border-color: #ffe537;
    }

    .btn.btn-default.login{
        width:500px;
        margin-left: 0;
        color: #fff;
        background-color: #ffe537;
    }

    .btn.btn-default.login:hover{
        width:500px;
        margin-left: 0;
        background-color: #ffffff;
        color: #ffe537;
        border-color: #ffe537;
    }

    .navbar-toggler{
        color: #fff;
        background-color: #ffe537;
    }

    .navbar-toggler-icon{
        color: #fff;
    }

    .fas.fa-user-alt{
        margin-right: 8px;
        color: #ffffff;
    }

    .fas{
        margin-right: 8px;
        color: #ffba49;
    }
    .far{
        margin-right: 8px;
        color: #ffba49;
    }
    .nav-link{
        color: #110000;
    }

    .dropdown-item.user-menu:hover{
        background-color: #ecf0fd;
    }
    /*        li.form-inline.my-2.my-lg-0.show > ul:before{
                content: "";
                border-bottom: 10px solid #fff;
                border-right: 10px solid transparent;
                border-left: 10px solid transparent;
                position: absolute;
                top: -10px;
                right: 16px;
                z-index: 10;
            }*/
    .btn-social-login {
        transition: all .2s;
        outline: 0;
        border: 1px solid transparent;
        padding: .5rem !important;
        border-radius: 50%;
        color: #fff;
    }
    .btn-social-login:focus {
        box-shadow: 0 0 0 .2rem rgba(0,123,255,.25);
    }
    .text-dark { color: #343a40!important; }

    .background_modal{
        display: none;
    }

    .btn.findIdBtn, .btn.findPwBtn, #longinGoBtn, #findUserPw{
        color: #fff;
        background-color: #ffe537;
        margin-left: 10px;
        padding: 10px 15px 10px 15px;
    }

    .btn.findIdBtn:hover , .btn.findPwBtn:hover, #longinGoBtn:hover, #findUserPw:hover{
        color: #ffe537;
        background-color: #ffffff;
        border-color: #ffe537;
        margin-left: 10px;
        padding: 10px 15px 10px 15px;
    }

    .btn.findIdBtn, .btn.findPwBtn{
        width: inherit;
    }

    #longinGoBtn, #findUserPw{
        justify-content: center;
    }

    *{
        font-family: "Noto Sans CJK KR Regular", sans-serif;
    }


</style>

<script type="text/javascript">

    /*카카오 로그인*/
    $(function () {

        Kakao.init('b729adcc43707d7099ee5f895c968b62');
        var id = "";

        $("#kakaoLogin").on("click", function () {

            //alert("카카오로그인");
            console.log("카카오 로그인");

            Kakao.Auth.login({
                success: function (authObj) { //성공시
                    console.log("카카오 token :: "+Kakao.Auth.getAccessToken());

                    Kakao.API.request({ //로그인 성공시
                        url: '/v2/user/me',
                        success: function (response) {
                            const id = response.kakao_account.email;
                            console.log(id);

                            $.ajax({
                                url : "/user/json/checkDuplication/"+id,
                                method : "GET",
                                headers : {
                                    "Accept" : "application/json",
                                    "Content-Type" : "application/json"
                                },
                                success : function (data) {
                                    console.log("중복체크 성공 :: "+data);

                                    if( data === id ){
                                        console.log("--------------------------");
                                        console.log("카카오로그인 data :: "+data);
                                        console.log("카카오로그인 id :: "+id);

                                        $.ajax({
                                            url : "/user/json/addUser",
                                            method : "POST",
                                            headers : {
                                                "Accept" : "application/json",
                                                "Content-Type" : "application/json"
                                            },
                                            data : JSON.stringify({
                                                userId : id,
                                                userName : response.properties.nickname,
                                                userPassword : "1234kakao",
                                                userRegDate : "2021-02-02",
                                                userPhone : "010-0000-0000"
                                            }),
                                            success: function (JSONData){
                                                alert("가입 완료");
                                                $("form").attr("method","POST").attr("action","/user/kakaoLogin/"+id).attr("target","_parent").submit();
                                            }
                                        });
                                    }
                                    if( data !== id ){
                                        console.log("로그인ing...");
                                        $("form").attr("method","post").attr("action","/user/kakaoLogin/"+id).attr("target","_parent").submit();
                                    }
                                },
                                fail: function (error){
                                    console.log("중복체크 실패 :: "+error);
                                }
                            });
                        },
                        fail: function (error) {
                            console.log(error);
                        },
                    });
                },
                fail: function (error){
                    console.log(error);
                }
            });
        });
    });

    /* 구글 로그인 */
    /*        $(function () {

                $(".g-signin2").click(function () {
                    alert("구글 로그인");

                    gapi.client.load('plus', 'v1', function () {
                        gapi.client.plus.people.get({
                            'userId': 'me'
                        }).execute(function (res) {

                            console.log("reponse data :: "+JSON.stringify(res));

                            //res.id += "@g";
                        })
                    });
                })
            });*/


    /*로그인 Modal*/
    function loginModal(){
        $('#openLoginModal').modal('show');
    }

    /*로그인*/
    $(function () {

        $("#modalLoginBtn").click(function () {

            var userIdModal = $("#userIdModal").val();
            var userPasswordModal = $("#userPasswordModal").val();

            console.log(userIdModal);
            console.log(userPasswordModal);

            $.ajax({
                type: "POST",
                url: "/user/json/login/"+userIdModal,
                data: {userId : userIdModal,
                    userPassword : userPasswordModal},
                success: function (data) {

                    console.log(data.userId);
                    //alert("안녕좀비야..");
                    if( data.userId == userIdModal) {
                        //alert(data.userId);
                        window.location.reload();
                    } else {
                        //alert(data);
                        window.location.reload();
                    }
                },
                fail:function (error){
                    console.log(error);
                }
            });
        });

        $("#roleTab a[href='#CEO']").click(function (){
            /*alert("나와라 CEO");*/

            $("#modalLoginBtn").click(function () {

                console.log("truck")

                var truckId=$("#truckId").val();
                var truckPassword=$("#truckPassword").val();

                console.log(truckId);
                console.log(truckPassword);

                $.ajax({
                    type   : "POST",
                    url    : "/truck/json/login/" + truckId,
                    data   : {truckId, truckPassword},
                    success: function (data) {
                        alert(truckId+" 사장님 환영합니다.");
                        /*javascript redirect 방법*/
                        location.replace("http://localhost:8080/views/home.jsp");
                    }
                })
            });
        });
    });

    //왜때문에 경로에 user가 자꾸 붙는지...ㅠ
    $( function() {
        $(".navbar-brand").on("click" , function() {
            //alert(1234);
            location.replace("http://localhost:8080/views/home.jsp");
        });
    });


    // 혜지 추가
    // ============= 쪽지 ===============
    $( function() {
        $("#goMsg").on("click" , function() {
            self.location = "/msg/message_list"
        });
    });
    // ============= 채팅 ===============
    $( function() {
        $("#goChat").on("click" , function() {
            self.location = "/room"
        });
    });
    // ============= 케이터링 ===============
    $( function() {
        $("#goCatering").on("click" , function() {
            self.location = "/catering/mainCalendar"
        });
    });

    // 진석 추가
    // ============= 게시판 ===============
    $( function() {
        $("#goPost").on("click" , function() {
            self.location = "/community/getPostList"
        });
    });

    /* userId 찾기 */
    function findUser(){
        //alert("ID/PW찾기");
        $('#openLoginModal').modal('hide');
        $('#findUserModal').modal('show');
    }

    $(function () {
        $('.findIdBtn').click(function () {

           var userName = $('#userIdforId').val();
           var userPhone = $('#userPhoneForId').val();

           console.log(userName);
           console.log(userPhone);

           $.ajax({
               type:"POST",
               url: "/user/json/getUserId",
               data   : {
                   userName : userName,
                   userPhone : userPhone},
               success:function (data) {
                   console.log("아이디 찾기 data : "+data);
                   if(data === "fail" ){
                       //alert(data);
                       $('#id_value').text('회원 정보를 찾을 수 없습니다.');
                       $('#longinGoBtn').css('display','none');
                       $('#findUserPw').css('display', 'none');
                   } else {
                       $('#id_value').text('회원님의 Id는 '+data+'입니다.');
                       $('#longinGoBtn').css('display','flex');
                       $('#findUserPw').css('display', 'flex');
                       idV = data;
                   }
               }
           })
        });
    });

    /* PW찾기 */
    $(function () {
       $('.findPwBtn').click(function () {

            var userName  = $('#userNameforPw').val();
            var userId  = $('#userIdforPw').val();
            var userPhone  = $('#userPhoneforPw').val();

            console.log(userName);
            console.log(userId);
            console.log(userPhone);

           $.ajax({
               type:"POST",
               url: "/user/json/getUserIdForPassword",
               data   : {
                   userId : userId,
                   userName : userName,
                   userPhone : userPhone},
               success:function (data) {
                   console.log("비밀번호 찾기 data : "+data);
                   if(data === ""){
                       alert('회원정보를 찾을 수 없습니다.');
                   } else {
                       console.log("-------------------");
                       console.log(userPhone);

                       $.ajax({
                           type:"GET",
                           url:"/user/json/sendSMSForPassword/"+userPhone,
                           data: {
                               userId : userId
                           },
                           success:function (data) {
                               console.log(data);
                               alert("입력하신 연락처로 임시비밀번호가 발송되었습니다.");
                               $('#background_modal').hide();
                               $('#findUserModal').hide();
                               $('#openLoginModal').modal('show');
                           },
                           fail:function (error){
                               console.log(error);
                               alert("임시비밀번호 전송이 취소되었습니다.")
                           }
                       });
                   }
               }
           });
       });
    });




    function getUserId(){
        //alert("떠라떠라");
        $('#background_modal').show();
    }

    $(function () {
        $('.close').on('click', function() {
            $('#background_modal').hide();
        });
    });
    $(window).on('click', function() {
        if (event.target == $('#background_modal').get(0)) {
            $('#background_modal').hide();
        }
    });

    function longinGoBtn(){
        $('#background_modal').hide();
        $('#findUserModal').hide();
        $('#openLoginModal').modal('show');
    }

    function findUserPw(){
        $('#background_modal').hide();
    }



</script>