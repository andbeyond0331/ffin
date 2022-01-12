<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">


<head>

    <title>F.FIN | 푸드트럭(사업자) 정보수정</title>
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

        //============= "수정"  Event 연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-primary").on("click", function () {
                fncAddTruck();
            });
        });

        //============= "취소"  Event 처리 및  연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-warning").on("click", function () {
                alert("수정을 취소하시겠습니까? 확인을 누르시면 홈화면으로 이동합니다.")
                self.location = "/views/home.jsp"
            });
        });

        //============= "Password 변경"  Event 처리 및  연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-dark").on("click", function () {
                alert("Password 확인 화면으로 이동합니다.");
                self.location = "/truck/updateTruckPassword";
            });
        });



        function fncAddTruck() {
            // 유효성체크
            var name = $("input[name='truckCEOName']").val();
            var addr = $("input[name='truckAddr']").val();
            var phone_auth = $("input[name='truckPhoneAuth']").val();
            var mail_auth = $("input[name='truckEmailAuth']").val();
            var truck_name = $("input[name='truckName']").val();
            var truck_lice = $("input[name='busiLice']").val();
            var cate = $("input[name='truckCate']").val();

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


            $("form").attr("method", "POST").attr("action", "/truck/updateTruckInfo").attr("enctype", "multipart/form-data").submit();
            alert("푸드트럭(사업자) 정보수정이 완료되었습니다.");
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
    <%--    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=01337c4e168951397bd2092ef93c4666&libraries=services"></script>--%>
    <script>
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
            mapOption = {
                //center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
                level: 5 // 지도의 확대 레벨
            };

        // //지도를 미리 생성
        // var map = new daum.maps.Map(mapContainer, mapOption);
        // //주소-좌표 변환 객체를 생성
        // var geocoder = new daum.maps.services.Geocoder();
        // //마커를 미리 생성
        // var marker = new daum.maps.Marker({
        //     position: new daum.maps.LatLng(37.537187, 127.005476),
        //     map     : map
        // });


        function sample5_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function (data) {
                    var addr = data.address; // 최종 주소 변수

                    // 주소 정보를 해당 필드에 넣는다.
                    document.getElementById("truckAddr").value = addr;
                    // 주소로 상세 정보를 검색
                    geocoder.addressSearch(data.address, function (results, status) {
                        // 정상적으로 검색이 완료됐으면
                        if (status === daum.maps.services.Status.OK) {

                            var result = results[0]; //첫번째 결과의 값을 활용

                            // 해당 주소에 대한 좌표를 받아서
                            var coords = new daum.maps.LatLng(result.y, result.x);
                            // 지도를 보여준다.
                            mapContainer.style.display = "block";
                            map.relayout();
                            // 지도 중심을 변경한다.
                            map.setCenter(coords);
                            // 마커를 결과값으로 받은 위치로 옮긴다.
                            marker.setPosition(coords)
                        }
                    });
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

    <div class="page-header">
        <label for="page-top" class="col-sm-offset-4 control-label"/>
        <h3 class="text-info">푸드트럭(사업자) 정보수정</h3>
    </div>

    <form class="form-horizontal">

        <!-- 아이디 중복검사 -->
        <div class="form-group">
            <label for="tId" class="col-sm-offset-1 col-sm-3 control-label">ID</label>
            <div class="col-sm-4">
                <input id="tId" type="hidden" name="truckId" value="${truck.truckId}" placeholder="아이디를 입력해주세요." required maxlength="10"/>
                ${truck.truckId}
                <span class="point successIdChk"></span><br/>
                <span class="point">※ 아이디는 수정불가</span>
                <input type="hidden" id="idDoubleChk"/>
            </div>
        </div>

        <hr/>

        <!-- 비밀번호 확인 -->
        <div class="form-group">
            <label for="tPassword" class="col-sm-offset-1 col-sm-3 control-label">Password</label>
            <div class="col-sm-4">
                <input type="password" class="form-control" id="tPassword" name="truckPassword" value="${truck.truckPassword}"
                       required maxlength="8"
                       autocomplete="off" readonly="true"/>
                <span class="point">※ Password를 변경하시려면 아래의 버튼을 클릭하세요</span><br/>
                <button name="changePw" class="btn btn-dark" type="button">Password 변경</button>
            </div>
        </div>

        <hr/>

        <!-- 트럭 대표자 이름 입력란 -->
        <br/>
        <div class="form-group">
            <label for="truckCEOName" class="col-sm-offset-1 col-sm-3 control-label">이름</label>
            <div class="col-sm-4">
                <input id="truckCEOName" class="form-control" name="truckCEOName" value="${truck.truckCEOName}" placeholder="대표자이름"/>
                <span id="result_id_msg" class="help-block"></span>
            </div>
        </div>

        <hr/>

        <!-- 트럭 대표자 생년월일 입력란 -->
        <br/>
        <div class="form-group">
            <label for="truckCEOBirth" class="col-sm-offset-1 col-sm-3 control-label">생년월일</label>
            <div class="col-sm-4">
                <input id="truckCEOBirth" class="form-control" name="truckCEOBirth" value="${truck.truckCEOBirth}" placeholder="대표자 생년월일"/>
            </div>
        </div>

        <hr/>

        <br/>
        <!-- 주소 -->
        <div class="form-group">
            <label for="truckAddr" class="col-sm-offset-1 col-sm-3 control-label">주소</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="truckAddr" name="truckAddr" value="${truck.truckAddr}" placeholder="사업자등록증에 등록된 주소" />
            </div>
            <div>
                <input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"><br>
            </div>
            <br/>
            <label for="truckAddrDetail" class="col-sm-offset-1 col-sm-3 control-label">주소 상세</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="truckAddrDetail" name="truckAddrDetail" value="${truck.truckAddrDetail}" placeholder="주소 상세"/>
                <div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
            </div>
        </div>

        <hr/>

        <!-- 핸드폰 문자 인증 -->
        <br/>
        <div class="form-group">
            <label for="truckPhone" class="col-sm-offset-1 col-sm-3 control-label">연락처</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="truckPhone" name="truckPhone" value="${truck.truckPhone}"
                       placeholder=" - 를 제외한 전화번호 입력"/>
            </div>
            <div class="col-sm-3">
                <button id="phoneChk" type="button" class="btn btn-secondary sms-auth">인증번호 요청</button>
            </div>
        </div>
        <div class="form-group phone-check-wrap">
            <label for="truckPhone" class="col-sm-offset-1 col-sm-3 control-label"></label>
            <div class="col-sm-4 phone-check-input-box" id="phone-check-input-box-fail">
                <input type="text" class="form-control phone-check-input" id="truckPhoneAuth" name="truckPhoneAuth"
                       placeholder="인증번호" disabled
                       required/>
                <span class="point successEmailChk">정보수정을 위해 문자인증을 진행해주세요.</span>
                <span id="phone-check-input-box-warn"></span>
                <div class="clearfix"></div>
            </div>
        </div>

        <hr/>

        <!-- 이메일 입력란 -->
        <div class="form-group">
            <label for="truckEmail" class="col-sm-offset-1 col-sm-3 control-label">Email</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="truckEmail" name="truckEmail"
                       value="${truck.truckEmail}" placeholder="인증번호 확인이 가능한 Email">
            </div>
            <div class="col-sm-3">
                <button type="button" id="emailChk" class="btn btn-secondary email-auth">인증번호 요청</button>
            </div>
        </div>
        <div class="form-group mail-check-wrap">
            <label for="truckEmail" class="col-sm-offset-1 col-sm-3 control-label"></label>
            <div class="col-sm-4 mail-check-input-box" id="mail-check-input-box-fail">
                <input type="text" class="form-control mail-check-input" id="truckEmailAuth" name="truckEmailAuth"
                       placeholder="인증번호" disabled required>
                <span class="point successEmailChk">정보수정을 위해 메일인증을 진행해주세요.</span>
                <span id="mail-check-input-box-warn"></span>
                <div class="clearfix"></div>
            </div>
        </div>

        <hr/>

        <!-- 푸드트럭상호 중복검사 -->
        <br/>
        <div class="form-group">
            <label for="truckName" class="col-sm-offset-1 col-sm-3 control-label">푸드트럭 상호</label>
            <div class="col-sm-4">
                <input id="truckName" type="text" name="truckName" value="${truck.truckName}" placeholder="푸드트럭 상호 입력" required maxlength="10"/>
                <span class="point successNameChk"></span><br/>
                <span class="point">※ 한글, 영문 입력가능, 최대 10자 까지 입력</span>
                <input type="hidden" id="nameDoubleChk"/>
            </div>
        </div>

        <hr/>

        <!-- 푸드트럭 사업자등록증 파일업로드란 -->
        <br/>
        <div class="form-group">
            <label for="busiLice" class="col-sm-offset-1 col-sm-3 control-label">사업자등록증</label>
            <div class="col-sm-4">
                <input id="busiLice" type="file" name="busiLice" class="form-control" value="${truck.truckBusiLice}"/>
            </div>
        </div>
        <input type="hidden" id="checkL"/>

        <br/>
        <hr/>
        <!-- 푸드트럭 카테고리 -->
        <div class="form-group">
            <label for="truckCate" class="col-sm-offset-1 col-sm-3 control-label">푸드트럭 카테고리</label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <select name="truckCate" class="col-sm-offset-4 col-sm-4 ct_input_g"
                    style="width: 120px; height: 24px" maxLength="30">
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
            <input type="hidden" id="truckCate" name="truckCate" value="${truck.truckCate}">
        </div>

        <br/>
        <hr/>

        <!-- 푸드트럭 프로필이미지 파일업로드란 -->
        <br/>
        <div class="form-group">
            <label for="proImg" class="col-sm-offset-1 col-sm-3 control-label">프로필 이미지</label>
            <div class="col-sm-4">
                <input id="proImg" type="file" name="proImg" class="form-control" value="${truck.truckProImg}"/>
            </div>
        </div>
        <input type="hidden" id="checkP"/>

        <br/>
        <hr/>

        <!-- 푸드트럭 사장님 한마디 -->
        <div class="form-group">
            <label for="truckCEOIntro" class="col-sm-offset-1 col-sm-3 control-label">사장님 한마디</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="truckCEOIntro" name="truckCEOIntro" value="${truck.truckCEOIntro}" placeholder="사장님 한마디">
            </div>
        </div>

        <hr/>

        <br/>
        <div class="form-group">
            <div id="google_recaptha">
                <label for="google_recaptha" class="col-sm-offset-4 control-label"/>
                <div class="g-recaptcha" data-sitekey="6LcPg8gdAAAAAO5xlPExdNehovl0HGgHL8veP0OR"></div>
            </div>
        </div>

        <hr/>

        <br/>
        <div class="form-group">
            <div class="col-sm-offset-1  col-sm-4 text-center">
                <button type="button" class="btn btn-primary">수 정</button>
                <button type="button" class="btn btn-warning">취 소</button>
            </div>
        </div>
    </form>


</div>
<jsp:include page="/views/footer.jsp"/>
</body>

</html>