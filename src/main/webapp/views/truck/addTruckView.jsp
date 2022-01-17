<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>
    <style>
        form {
            max-width: available;
            margin-left: auto;
            margin-right: auto;
            overflow: auto;
        }

        strong {
            font-size: 17px;
            text-align: left;
        }

        .col-sm-6 {
            font-size: 17px;
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

    <title>F.FIN | 푸드트럭(사업자) 회원가입</title>
    <jsp:include page="../../common/lib.jsp"/>

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!-- datepicker -->
    <!-- jQuery UI CSS 파일 -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css"/>
    <!-- jQuery 기본 js파일 -->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <!-- jQuery UI 라이브러리 js파일 -->
    <script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
    <!-- 구글 리캡차 -->
    <script src='https://www.google.com/recaptcha/api.js'></script>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //============= "가입"  Event 연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-default.addTBtn").on("click", function () {
                fncAddTruck();
            });
        });

        //============= "취소"  Event 처리 및  연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-cancle").on("click", function () {
                alert("회원가입을 취소하시겠습니까? 확인을 누르시면 메인화면으로 이동합니다.")
                self.location = "/catering/mainTruckList"
            });
        });


        function fncAddTruck() {
            // 유효성체크
            var id = $("input[name='truckId']").val();
            var pw = $("input[name='truckPassword']").val();
            var pw_confirm = $("input[name='truckPasswordChk']").val();
            var name = $("input[name='truckCEOName']").val();
            var addr = $("input[name='truckAddr']").val();
            var phone_auth = $("input[name='truckPhoneAuth']").val();
            var mail_auth = $("input[name='truckEmailAuth']").val();
            var truck_name = $("input[name='truckName']").val();
            var truck_lice = $("input[name='busiLice']").val();
            var cate = $("input[name='truckCate']").val();

            if (id == null || id.length < 1) {
                alert("아이디는 반드시 입력하셔야 합니다.");
                return;
            }
            if (pw == null || pw.length < 1) {
                alert("패스워드는 반드시 입력하셔야 합니다.");
                return;
            }
            if (pw_confirm == null || pw_confirm.length < 1) {
                alert("패스워드 확인은 반드시 입력하셔야 합니다.");
                return;
            }
            if (name == null || name.length < 1) {
                alert("사업자대표 이름은 반드시 입력하셔야 합니다.");
                return;
            }
            if (addr == null || addr.length < 1) {
                alert("사업자등록증 상의 주소지는 반드시 입력하셔야 합니다.");
                return;
            }
            if (phone_auth == null || phone_auth.length < 1) {
                alert("휴대폰 문자인증을 반드시 거쳐야 합니다.");
                return;
            }
            if (mail_auth == null || mail_auth.length < 1) {
                alert("이메일 인증을 반드시 거쳐야 합니다.");
                return;
            }
            if (truck_name == null || truck_name.length < 1) {
                alert("푸드트럭 상호는 반드시 입력하셔야 합니다.");
                return;
            }
            if (truck_lice == null || truck_lice.length < 1) {
                alert("사업자등록증 이미지 파일을 반드시 첨부하셔야 합니다.");
                return;
            }


            $("form").attr("method", "POST").attr("action", "/truck/addTruck").attr("enctype", "multipart/form-data").submit();
            alert("회원가입이 완료되었습니다. 가입승인에는 영업일 기준 2~5일이 소요되며 확인을 누르시면 로그인 화면으로 이동합니다.");
        }

        // <!-- 푸드트럭 아이디 중복체크 -->

        $(function () {
            $("#tId").keyup(function () {
                var truckId = $("#tId").val();
                if (truckId == "" || truckId.length < 2) {
                    $(".successIdChk").text("아이디는 2자 이상 10자 이하로 설정해주세요 :)");
                    $(".successIdChk").css("color", "red");
                    $("#idDoubleChk").val("false");
                } else {
                    $.ajax({
                        url     : '/truck/checkDuId/' + truckId,
                        type    : 'post',
                        data    : {},
                        success : function (data) {
                            //console.log("1::: "+data)
                            if (data == 'y') {
                                $(".successIdChk").text("사용가능한 아이디입니다 :)");
                                $(".successIdChk").css("color", "blue");
                                $("#idDoubleChk").val("true");
                            } else {
                                $(".successIdChk").text("사용중인 아이디입니다 :p");
                                $(".successIdChk").css("color", "red");
                                $("#idDoubleChk").val("false");
                            }
                        }, error: function () {
                            console.log("실패");
                        }
                    });
                }
            });


            // <!-- 푸드트럭 비밀번호 체크 -->

            $("#truckPasswordChk").keyup(function () {
                if ($("#tPassword").val() == $("#truckPasswordChk").val()) {
                    $(".successPwChk").text("비밀번호가 일치합니다.");
                    $(".successPwChk").css("color", "blue");
                    $("#pwDoubleChk").val("true");
                } else {
                    $(".successPwChk").text("비밀번호가 일치하지 않습니다.");
                    $(".successPwChk").css("color", "red");
                    $("#pwDoubleChk").val("false");
                }
            })


            // <!-- 푸드트럭상호 중복체크 -->

            $("#truckName").keyup(function () {
                var truckName = $("#truckName").val();
                if (truckName == "" || truckName.length < 1) {
                    $(".successNameChk").text("푸드트럭상호는 1자 이상 10자 이하로 설정해주세요 :)");
                    $(".successNameChk").css("color", "red");
                    $("#nameDoubleChk").val("false");
                } else {
                    $.ajax({
                        url     : '/truck/checkDuTruckName/' + truckName,
                        type    : 'post',
                        data    : {},
                        success : function (data) {
                            //console.log("1::: "+data)
                            if (data == 'y') {
                                $(".successNameChk").text("사용가능한 상호입니다 :)");
                                $(".successNameChk").css("color", "blue");
                                $("#nameDoubleChk").val("true");
                            } else {
                                $(".successNameChk").text("사용중인 상호입니다 :p");
                                $(".successNameChk").css("color", "red");
                                $("#nameDoubleChk").val("false");
                            }
                        }, error: function () {
                            console.log("실패");
                        }
                    });
                }
            });


            <!-- 휴대폰 문자인증 -->
            //휴대폰 번호 인증
            var code2 = "";

            $(".sms-auth").click(function () {
                alert("인증번호 발송이 완료되었습니다.\n휴대폰에서 인증번호 확인을 해주십시오.");

                var inputPhone = $("#truckPhone").val();
                var authInputBox = $(".phone-check-input");
                var boxWrap = $(".phone-check-input-box");

                $.ajax({
                    type   : "GET",
                    url    : "/truck/phoneCheck/" + inputPhone,
                    success: function (data) {
                        if (data == "error") {
                            alert("휴대폰 번호가 올바르지 않습니다.")
                            $(".successPhoneChk").text("유효한 번호를 입력해주세요.");
                            $(".successPhoneChk").css("color", "red");
                            $("#truckPhone").attr("autofocus", true);
                        } else {
                            authInputBox.attr("disabled", false);
                            boxWrap.attr("id", "phone-check-input-box-ture")
                            code2 = data;
                        }
                    }
                });
            });


            //휴대폰 인증번호 대조
            $(".phone-check-input").on("keyup", function () {

                var inputCode = $(".phone-check-input").val();
                var checkResult = $("#phone-check-input-box-warn");

                if (inputCode.length >= 4) {
                    if (inputCode == code2) {
                        checkResult.text("인증번호가 일치합니다");
                        checkResult.css("color", "blue")
                        checkResult.attr("class", "correct");
                    } else {
                        checkResult.text("인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.");
                        checkResult.css("color", "red");
                        checkResult.attr("class", "incorrect");
                    }
                }

            })
        });


    </script>


    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function sample5_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function (data) {
                    var addr = data.address; // 최종 주소 변수

                    // 주소 정보를 해당 필드에 넣는다.
                    document.getElementById("truckAddr").value = addr;
                    // 주소로 상세 정보를 검색

                }
            }).open();
        }


        $(function () {
            $("#truckCEOBirth").datepicker({
                changeMonth: true,
                changeYear : true,
                nextText   : '다음 달',
                prevText   : '이전 달',
                dateFormat : "yy-mm-dd"
            });
        });


        $(function () {

            var code = "";
            ``
            /* 인증번호 이메일 전송 */
            $(".email-auth").click(function () {
                alert("인증번호 발송이 완료되었습니다.\n입력하신 메일에서 인증번호 확인을 해주십시오.");

                var inputEmail = $("#truckEmail").val();
                var authInputBox = $(".mail-check-input");

                var boxWrap = $(".mail-check-input-box");
                $.ajax({
                    type   : "GET",
                    url    : "/auth/json/emailAuth/" + inputEmail,
                    success: function (data) {
                        //console.log("data : "+data);
                        /*$("#userEmailAuth").attr("disabled",false);*/
                        authInputBox.attr("disabled", false);
                        boxWrap.attr("id", "mail-check-input-box-ture")
                        code = data;
                    }
                });
            });

            /* email 인증번호 비교 */
            $(".mail-check-input").on("keyup", function () {

                var inputCode = $(".mail-check-input").val();
                var checkResult = $("#mail-check-input-box-warn");
                /*console.log("inputCode"+inputCode);
                console.log("code"+code);*/
                if (inputCode.length >= 6) {
                    if (inputCode == code) {
                        checkResult.text("인증번호가 일치합니다");
                        checkResult.css("color", "blue")
                        checkResult.attr("class", "correct");
                    } else {
                        checkResult.text("인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.");
                        checkResult.css("color", "red");
                        checkResult.attr("class", "incorrect");
                    }
                }

            })
        });

    </script>

</head>

<body id="page-top">

<jsp:include page="/views/navbar.jsp"/>
<br/><br/><br/><br/>
<div class="container">

    <div class="page-header" style="text-align: center">
        <label for="page-top"/>
        <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
        <h4 style="margin-top: 10px;">
            푸드트럭(사업자) 회원가입
        </h4>
    </div>
    <br>

    <form class="form-horizontal" style="border-radius:10px ; border: 0; box-shadow: 0 2px 4px 0 rgba(0,0,0,0.2); transition: 0.3s;">

        <!-- 아이디 중복검사 -->
        <div class="form-group join-layout" align="center" style="padding-top:20px ">
            <div class="col-md-3" style="text-align: end;">
            <strong class="col-sm-offset-1 col-sm-3 control-label" style="margin-top:5px ">ID</strong>
            </div>
                <div class="col-md-6">
                <input id="tId" type="text" class="form-control align-center" name="truckId"
                       placeholder="아이디를 입력해주세요." required
                       maxlength="10"/>
                <span class="point" style="font-size:16px ">※ 영문자, 소문자 입력가능, 최대 10자 까지 입력</span>
                    <span class="point successIdChk align-center"></span><br/>
                    <input type="hidden" id="idDoubleChk"/>
            </div>
        </div>


        <!-- 비밀번호 확인 -->
        <div class="form-group join-layout" align="center">
            <div class="col-md-3" style="text-align: end;">
            <strong for="tPassword" class="col-sm-offset-1 col-sm-3 control-label">Password</strong>
            </div>
            <div class="col-sm-6">
                <input type="password" class="form-control align-center" id="tPassword"
                       name="truckPassword"
                       placeholder="Password"
                       required maxlength="8"/>
                <span class="point" style="font-size:16px ">※ 비밀번호는 총 8자 까지 입력가능</span><br/>
            </div>
        </div>

        <br>

        <div class="form-group join-layout" align="center">
            <div class="col-md-3" style="text-align: end;">
            <strong for="tPassword" class="col-sm-offset-1 col-sm-3 control-label" style="font-size:17px ">Password
                확인</strong>
            </div>
            <div class="col-sm-6">
                <input id="truckPasswordChk" type="password" class="form-control align-center"
                       name="truckPasswordChk"
                       placeholder="동일하게 입력해주세요." required
                       maxlength="8"/>
                <span class="point successPwChk" style="font-size:16px "></span>
                <input type="hidden" id="pwDoubleChk"/>
            </div>
        </div>


        <!-- 트럭 대표자 이름 입력란 -->
        <br/>
        <div class="form-group join-layout" align="center">
            <div class="col-md-3" style="text-align: end;">
            <strong for="truckCEOName" class="col-sm-offset-1 col-sm-3 control-label">이름</strong>
            </div>
            <div class="col-sm-6">
                <input id="truckCEOName" class="form-control align-center" name="truckCEOName"
                       placeholder="대표자이름"/>
                <span id="result_id_msg" class="help-block"></span>
            </div>
        </div>


        <!-- 트럭 대표자 생년월일 입력란 -->
        <div class="form-group join-layout" align="center">
            <div class="col-md-3" style="text-align: end;">
            <strong for="truckCEOBirth" class="col-sm-offset-1 col-sm-3 control-label">생년월일</strong>
            </div>
            <div class="col-sm-6">
                <input id="truckCEOBirth" class="form-control" name="truckCEOBirth"
                       placeholder="대표자 생년월일"/>
            </div>
        </div>

        <br/>
        <!-- 주소 -->
        <div class="form-group join-layout" align="center">
            <div class="col-md-3" style="text-align: end;">
            <strong for="truckAddr" class="col-sm-offset-1 col-sm-3 control-label">주소</strong>
            </div>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="truckAddr" name="truckAddr"
                       placeholder="사업자등록증에 등록된 주소"/>
            </div>
            <div>
                <input type="button" class="btn btn-dark" onclick="sample5_execDaumPostcode()"
                       value="주소 검색"><br>
            </div>
        </div>

        <br/>
        <div class="form-group join-layout" align="center">
            <div class="col-md-3" style="text-align: end;">
            <strong for="truckAddrDetail" class="col-sm-offset-1 col-sm-3 control-label">주소 상세</strong>
            </div>
            <div class="col-sm-6"><input type="text" class="form-control" id="truckAddrDetail"
                                         name="truckAddrDetail" placeholder="주소 상세"/>
            </div>
        </div>

        <!-- 핸드폰 문자 인증 -->
        <br/>
        <div class="form-group join-layout" align="center">
            <div class="col-md-3" style="text-align: end;">
            <strong for="truckPhone" class="col-sm-offset-1 col-sm-3 control-label">연락처</strong>
            </div>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="truckPhone" name="truckPhone"
                       placeholder=" - 를 제외한 전화번호 입력"/>
            </div>
            <div>
                <button id="phoneChk" type="button" class="btn btn-dark sms-auth">인증번호 요청
                </button>
            </div>
        </div>
        <div class="form-group join-layout" align="center">
            <div class="col-md-3" style="text-align: end;">
            <strong for="truckPhoneAuth" class="col-sm-offset-1 col-sm-3 control-label"></strong>
            </div>
            <div class="col-sm-6 phone-check-input-box" id="phone-check-input-box-fail">
                <input type="text" class="form-control phone-check-input" id="truckPhoneAuth"
                       name="truckPhoneAuth"
                       placeholder="인증번호" disabled
                       required/>
                <span class="point successEmailChk" style="font-size:15px ">인증번호 확인이 가능한 전화번호를 먼저 입력해주세요.</span>
                <span id="phone-check-input-box-warn"></span>
                <div class="clearfix"></div>
            </div>
        </div>

        <!-- 이메일 입력란 -->
        <div class="form-group join-layout" align="center">
            <div class="col-md-3" style="text-align: end;">
            <strong for="truckEmail" class="col-sm-offset-1 col-sm-3 control-label">Email</strong>
            </div>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="truckEmail" name="truckEmail"
                       placeholder="인증번호 확인이 가능한 Email"/>
            </div>
            <div>
                <button type="button" id="emailChk" class="btn btn-dark email-auth">인증번호 요청
                </button>
            </div>
        </div>
        <div class="form-group join-layout" align="center">
            <div class="col-md-3" style="text-align: end;">
            <strong for="truckEmailAuth" class="col-sm-offset-1 col-sm-3 control-label"></strong>
            </div>
            <div class="col-sm-6 mail-check-input-box" id="mail-check-input-box-fail">
                <input type="text" class="form-control mail-check-input" id="truckEmailAuth"
                       name="truckEmailAuth"
                       placeholder="인증번호" disabled required/>
                <span class="point successEmailChk" style="font-size:15px ">인증번호 확인이 가능한 메일 주소를 먼저 입력해주세요.</span>
                <span id="mail-check-input-box-warn"></span>
                <div class="clearfix"></div>
            </div>
        </div>

        <!-- 푸드트럭상호 중복검사 -->
        <br/>
        <div class="form-group join-layout" align="center">
            <div class="col-md-3" style="text-align: end;">
            <strong for="truckName" class="col-sm-offset-1 col-sm-3 control-label">푸드트럭 상호</strong>
            </div>
            <div class="col-sm-6">
                <input id="truckName" type="text" name="truckName" placeholder="푸드트럭 상호 입력"
                       required maxlength="10" class="form-control"/>
                <span class="point successNameChk" style="font-size:15px "></span><br/>
                <span class="point" style="font-size:15px ">※ 한글, 영문 입력가능, 최대 10자 까지 입력</span>
                <input type="hidden" id="nameDoubleChk"/>
            </div>
        </div>

        <!-- 푸드트럭 사업자등록증 파일업로드란 -->
        <br/>
        <div class="form-group join-layout" align="center">
            <div class="col-md-3" style="text-align: end;">
            <strong for="truckPhone" class="col-sm-offset-1 col-sm-3 control-label">사업자등록증</strong>
            </div>
            <div class="col-sm-6">
                <input id="busiLice" type="file" name="busiLice" class="form-control"/>
            </div>
        </div>
        <input type="hidden" id="checkL"/>

        <br/>
        <!-- 푸드트럭 카테고리 -->
        <div class="form-group join-layout" align="center" style="display: block;">
            <div>
            <div class="col-md-3" style="text-align: end;">
            <strong for="truckPhone" class="col-sm-offset-1 col-sm-3 control-label">푸드트럭 카테고리</strong>
            </div>
            <div class="col-sm-6">
            <select name="truckCate" class="col-md-8 ct_input_g"
                    style="width: auto; height: auto">
                <option value="0" selected="selected">카테고리 선택</option>
                <option value="1">고기</option>
                <option value="2">분식</option>
                <option value="3">음료</option>
                <option value="4">양식</option>
                <option value="5">디저트</option>
                <option value="6">한식</option>
                <option value="7">일식</option>
                <option value="8">기타</option>
            </select>
            <input type="hidden" id="truckCate" name="truckCate">
            </div>
        </div>

        <br/>
        <!-- 푸드트럭 프로필이미지 파일업로드란 -->
        <br/>
            <div class="form-group join-layout" align="center">
                <div class="col-md-3" style="text-align: end;">
            <strong for="truckProImg" class="col-sm-offset-1 col-sm-3 control-label">프로필 이미지</strong>
                </div>
                <div class="col-sm-6">
                <input id="proImg" type="file" name="proImg" class="form-control"/>
            </div>
        </div>
        <input type="hidden" id="checkP"/>

        <br/>
        <!-- 푸드트럭 사장님 한마디 -->
            <div class="form-group join-layout" align="center">
                <div class="col-md-3" style="text-align: end;">
                <strong for="truckCEOIntro" class="col-sm-offset-1 col-sm-3 control-label">사장님 한마디</strong>
                </div>
                <div class="col-sm-6">
                <input type="text" class="form-control" id="truckCEOIntro" name="truckCEOIntro"
                       placeholder="사장님 한마디"/>
            </div>
        </div>

        <br/>
            <div class="form-group join-layout" align="center">
            <div id="google_recaptha">
                <label for="google_recaptha" class="col-sm-offset-1 col-sm-4 control-label"/>
                <div class="g-recaptcha"
                     data-sitekey="6LcPg8gdAAAAAO5xlPExdNehovl0HGgHL8veP0OR"></div>
            </div>
        </div>

        <br/>
            <div class="form-group join-layout" align="center">
            <div class="col-sm-offset-1  col-sm-4 text-center">
                <button type="button" class="btn btn-default addTBtn">가 입</button>
                <button type="button" class="btn btn-cancle">취 소</button>
            </div>
        </div>
        </div>
    </form>
</div>
</div>

</section>
<jsp:include page="/views/footer.jsp"/>
</body>

</html>