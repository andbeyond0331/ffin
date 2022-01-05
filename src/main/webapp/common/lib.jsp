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

<!-- 카카오 로그인 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>




<!-- bootstrap -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<!-- bootstrap core css -->
<link rel="stylesheet" type="text/css" href="../resources/bootstrap/css/bootstrap.css" />


<!-- fonts style -->
<link href="https://fonts.googleapis.com/css?family=Poppins:400,600,700&display=swap" rel="stylesheet">

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
<link rel="manifest" href="../resources/bootstrap/assets/favicons/manifest.json">
<meta name="msapplication-TileImage" content="../resources/bootstrap/assets/favicons/mstile-150x150.png">
<meta name="theme-color" content="#ffffff">

<!-- Favicons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.2.0/css/all.min.css" integrity="sha512-6c4nX2tn5KbzeBJo9Ywpa0Gkt+mzCzJBrE1RB6fmpcsoN+b/w/euwIMuQKNyUoU/nToKN3a8SgNOtPrbW12fug==" crossorigin="anonymous" />

<style>
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
        border-width: 2px;
    }

    .btn.btn-default.login{
        width:500px;
        margin-left: 0;
        background-color: #ffba49;
    }

    .btn.btn-default.login:hover{
        width:500px;
        margin-left: 0;
        background-color: #f17228;
        color: #ffe537;
        border: 0;
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

</style>

<script type="text/javascript">

    /*카카오 로그인*/
    $(function () {

        Kakao.init('b729adcc43707d7099ee5f895c968b62');
        var id = "";

        $("#kakaoLogin").on("click", function () {

            alert("카카오로그인");
            console.log("카카오 로그인");


            Kakao.Auth.login({
                success: function (authObj) {
                    //console.log(JSON.stringify(authObj));
                    //console.log(Kakao.Auth.getAccessToken());

                    //2. 로그인 성공시, API를 호출합니다.
                    Kakao.API.request({
                        url: '/v2/user/me',
                        success: function (res) {
                            //console.log(JSON.stringify(res));
                            id = res.kakao_account.email;

                            $.ajax({
                                url: "/user/json/checkDuplication/" + res.kakao_account.email,
                                type : "GET",
                                headers: {
                                    "Accept": "application/json",
                                    "Content-Type": "application/json"
                                },
                                success: function (idChk) {
                                    console.log("hey kakao");
                                    console.log(idChk);
                                    if (idChk === id) { //DB에 아이디가 없을 경우 => 회원가입
                                        console.log("회원가입중...");
                                        $.ajax({
                                            url: "views/user/addUser.jsp",
                                            method: "POST",
                                            headers: {
                                                "Accept": "application/json",
                                                "Content-Type": "application/json"
                                            },
                                            data: JSON.stringify({
                                                userId: res.kakao_account.email,
                                                userName: res.properties.nickname
                                                /*userPassword: "kakao123",*/
                                            }),
                                            success: function (JSONData) {
                                                console.log(JSONData)
                                                alert("회원가입이 정상적으로 되었습니다.");
                                                $("form").attr("method", "POST").attr("action", "/user/snsLogin/" + res.id).attr("target", "_parent").submit();
                                            }
                                        })
                                    }
                                    if (!(idChk === id)) { //DB에 아이디가 존재할 경우 => 로그인
                                        console.log("로그인중...");
                                        $("form").attr("method", "POST").attr("action", "/user/snsLogin/" + res.kakao_account.email).attr("target", "_parent").submit();
                                    }
                                }
                            })
                        },
                        fail: function (error) {
                            alert(JSON.stringify(error));
                        }
                    });
                },
                fail: function (err) {
                    alert(JSON.stringify(err));
                }
            });

        });
    });


    /*로그인 Modal*/
    function loginModal(){
        $('#openLoginModal').modal('show');
    }

    /*로그인*/
    $(function () {

        $("#modalLoginBtn").click(function () {

            console.log("user")

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
                    /*javascript redirect 방법*/
                    location.replace("http://localhost:8080/views/homeTest.jsp");
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
                        location.replace("http://localhost:8080/views/homeTest.jsp");
                    }
                })
            });
        });
    });

    //왜때문에 경로에 user가 자꾸 붙는지...ㅠ
    $( function() {
        $(".navbar-brand").on("click" , function() {
            alert(1234);
            location.replace("http://localhost:8080/views/homeTest.jsp");
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


</script>