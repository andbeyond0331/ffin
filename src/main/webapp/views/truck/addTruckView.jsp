<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="UTF-8">

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <title>푸드트럭(사업자) 회원가입</title>

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
            $("button.btn.btn-primary").on("click", function () {
                fncAddTruck();
            });
        });

        //============= "취소"  Event 처리 및  연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("a[href='#' ]").on("click", function () {
                self.location = "/views/truck/loginTruck.jsp"
            });
        });


        function fncAddTruck() {

            var id = $("input[name='truckId']").val();
            var pw = $("input[name='truckPassword']").val();
            var pw_confirm = $("input[name='truckPasswordChk']").val();
            var name = $("input[name='truckCEOName']").val();


            if (id == null || id.length < 1) {
                alert("아이디는 반드시 입력하셔야 합니다.");
                return;
            }
            if (pw == null || pw.length < 1) {
                alert("패스워드는  반드시 입력하셔야 합니다.");
                return;
            }
            if (pw_confirm == null || pw_confirm.length < 1) {
                alert("패스워드 확인은  반드시 입력하셔야 합니다.");
                return;
            }
            if (name == null || name.length < 1) {
                alert("이름은  반드시 입력하셔야 합니다.");
                return;
            }

            // var value = "";
            // if( $("input:text[name='phone2']").val() != ""  &&  $("input:text[name='phone3']").val() != "") {
            //     var value = $("option:selected").val() + "-"
            //         + $("input[name='phone2']").val() + "-"
            //         + $("input[name='phone3']").val();
            // }
            //
            // $("input:hidden[name='phone']").val( value );

            $("form").attr("method", "POST").attr("action", "/truck/addTruck").submit();
            alert("회원가입이 완료되었습니다. 가입승인에는 영업일 기준 2~5일이 소요되며 확인을 누르시면 로그인 화면으로 이동합니다.");
        }
    </script>
    <!-- 푸드트럭 아이디 중복체크 -->
    <script type="text/javascript">

        $(function () {
            $("#truckId").keyup(function () {
                var truckId = $("#truckId").val();
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
                                $(".successIdChk").css("color", "green");
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
        });

        <!-- 푸드트럭 비밀번호 체크 -->
        $(function () {
            $("#truckPasswordChk").keyup(function () {
                if ($("#truckPassword").val() == $("#truckPasswordChk").val()) {
                    $(".successPwChk").text("비밀번호가 일치합니다.");
                    $(".successPwChk").css("color", "green");
                    $("#pwDoubleChk").val("true");
                } else {
                    $(".successPwChk").text("비밀번호가 일치하지 않습니다.");
                    $(".successPwChk").css("color", "red");
                    $("#pwDoubleChk").val("false");
                }
            })
        })

        <!-- 푸드트럭상호 중복체크 -->
        $(function () {
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
                                $(".successNameChk").css("color", "green");
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
        });

        // <!-- 휴대폰 문자인증 -->
        // //휴대폰 번호 인증
        // var code2 = "";
        // $("#phoneChk").click(function () {
        //     alert("인증번호 발송이 완료되었습니다.\n휴대폰에서 인증번호 확인을 해주십시오.");
        //     var phone = $("#phone").val();
        //     $.ajax({
        //         type: "GET", url: "phoneCheck?phone=" + phone, cache: false, success: function (data) {
        //             if (data == "error") {
        //                 alert("휴대폰 번호가 올바르지 않습니다.")
        //                 $(".successPhoneChk").text("유효한 번호를 입력해주세요.");
        //                 $(".successPhoneChk").css("color", "red");
        //                 $("#phone").attr("autofocus", true);
        //             } else {
        //                 $("#phone2").attr("disabled", false);
        //                 $("#phoneChk2").css("display", "inline-block");
        //                 $(".successPhoneChk").text("인증번호를 입력한 뒤 본인인증을 눌러주십시오.");
        //                 $(".successPhoneChk").css("color", "green");
        //                 $("#phone").attr("readonly", true);
        //                 code2 = data;
        //             }
        //         }
        //     });
        // });
        //
        //
        // //휴대폰 인증번호 대조
        // $("#phoneChk2").click(function () {
        //     if ($("#phone2").val() == code2) {
        //         $(".successPhoneChk").text("인증번호가 일치합니다.");
        //         $(".successPhoneChk").css("color", "green");
        //         $("#phoneDoubleChk").val("true");
        //         $("#phone2").attr("disabled", true);
        //     } else {
        //         $(".successPhoneChk").text("인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.");
        //         $(".successPhoneChk").css("color", "red");
        //         $("#phoneDoubleChk").val("false");
        //         $(this).attr("autofocus", true);
        //     }
        // });


    </script>


    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<%--    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=01337c4e168951397bd2092ef93c4666&libraries=services"></script>--%>
    <script>
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
            mapOption = {
                //center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
                level : 5 // 지도의 확대 레벨
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
    </script>


    <script>

        $(function () {
            $("#truckCEOBirth").datepicker({
                changeMonth: true,
                changeYear : true,
                nextText   : '다음 달',
                prevText   : '이전 달',
                dateFormat : "yy-mm-dd"
            });
        });


    </script>

</head>

<body>
<div class="container">
    <div class="titleStyle">
        <h3 class=" text-info">푸드트럭(사업자) 회원가입</h3>
    </div>
    <form method="form-horizontal">

        <!-- 아이디 중복검사 -->
        <tr>
            <th>
                <label for="truckId">아이디</label>
            </th>
            <td>
                <input id="truckId" type="text" name="truckId" placeholder="아이디를 입력해주세요." required maxlength="10"/>
                <span class="point successIdChk"></span><br/>
                <span class="point">※ 영문자, 소문자 입력가능, 최대 10자 까지 입력</span>
                <input type="hidden" id="idDoubleChk"/>
            </td>
        </tr>


        <!-- 비밀번호 확인 -->
        <br/><br/>
        <tr>
            <th>
                <label for="truckPassword">비밀번호</label>
            </th>
            <td>
                <input id="truckPassword" type="password" name="truckPassword" required maxlength="8"
                       autocomplete="off"/>
                <span class="point">※ 비밀번호는 총 8자 까지 입력가능</span><br/>
            </td>
        </tr>
        <tr>
            <th>
                <label for="truckPasswordChk">비밀번호 확인</label>
            </th>
            <td>
                <input id="truckPasswordChk" type="password" name="truckPasswordChk" placeholder="동일하게 입력해주세요." required
                       maxlength="8" autocomplete="off"/>
                <span class="point successPwChk"></span>
                <input type="hidden" id="pwDoubleChk"/>
            </td>
        </tr>

        <!-- 트럭 대표자 이름 입력란 -->
        <br/><br/>
        <div class="form-group">
            <label for="truckCEOName" class="col-sm-offset-1 col-sm-3 control-label">이름</label>

            <input id="truckCEOName" class="form-control" name="truckCEOName" placeholder="대표자이름">
        </div>


        <!-- 트럭 대표자 생년월일 입력란 -->
        <br/><br/>
        <div class="form-group">
            <label for="truckCEOBirth" class="col-sm-offset-1 col-sm-3 control-label">생년월일</label>

            <input id="truckCEOBirth" class="form-control" name="truckCEOBirth" placeholder="대표자 생년월일">
            &nbsp;

        </div>

        <br/>
        <!-- 주소 -->
        <div class="form-group">
            <label for="truckAddr" class="col-sm-offset-1 col-sm-3 control-label">주소</label>
            <input type="text" id="truckAddr" name="truckAddr" placeholder="사업자등록증에 등록된 주소">
            <input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"><br>
            <input type="text" id="truckAddrDetail" name="truckAddrDetail" placeholder="주소 상세">
            <div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
        </div>


        <!-- 핸드폰 문자 인증 -->
        <br/><br/>
        <tr class="mobileNo">
            <th><label for="phone">휴대폰 번호</label></th>
            <td><p><input id="phone" type="text" name="phone" title="전화번호 입력" required/> <span id="phoneChk"
                                                                                               class="doubleChk">인증번호 보내기</span><br/>
                <input id="phone2" type="text" name="phone2" title="인증번호 입력" disabled required/> <span id="phoneChk2"
                                                                                                       class="doubleChk">본인인증</span>
                <span class="point successPhoneChk">휴대폰 번호 입력후 인증번호 보내기를 해주십시오.</span> <input type="hidden"
                                                                                              id="phoneDoubleChk"/></p>
            </td>
        </tr>


        <!-- 이메일 입력란 -->
        <br/><br/>
        <div class="form-group">
            <label for="truckEmail" class="col-sm-offset-1 col-sm-3 control-label">이메일</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="truckEmail" name="truckEmail" placeholder="이메일">
            </div>
        </div>

        <!-- 푸드트럭상호 중복검사 -->
        <br/><br/>
        <tr>
            <th>
                <label for="truckName">푸드트럭상호</label>
            </th>
            <td>
                <input id="truckName" type="text" name="truckName" placeholder="푸드트럭 상호를 입력해주세요." required
                       maxlength="10"/>
                <span class="point successNameChk"></span><br/>
                <span class="point">※ 한글, 영문 입력가능, 최대 10자 까지 입력</span>
                <input type="hidden" id="nameDoubleChk"/>
            </td>
        </tr>

        <!-- 푸드트럭 사업자등록증 파일업로드란 -->
        <br/><br/>
        <div class="form-group">
            <label for="truckBusiLice" class="col-sm-offset-1 col-sm-3 control-label">사업자등록증</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="truckBusiLice" name="truckBusiLice"
                       placeholder="사업자등록증 파일업로드">
            </div>
        </div>
        <br/>
        <h4>사업자등록증 파일업로드</h4>
        업로드하실 파일을 선택하세요. <br/>
        <form action="./upload.jsp" method="post"
              enctype="multipart/form-data">
            <input type="file" name="file" size="50"/>
            <br/>
            <input type="submit" value="선택한 파일 업로드"/>
        </form>


        <!-- 푸드트럭 카테고리 -->
        <br/><br/>
        <div class="form-group">
            <label for="truckCate" class="col-sm-offset-1 col-sm-3 control-label">푸드트럭 카테고리</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="truckCate" name="truckCate" placeholder="푸드트럭 카테고리">
            </div>
        </div>

        <!-- 푸드트럭 프로필이미지 파일업로드란 -->
        <br/><br/>
        <div class="form-group">
            <label for="truckProImg" class="col-sm-offset-1 col-sm-3 control-label">프로필 이미지</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="truckProImg" name="truckProImg" placeholder="프로필 이미지 파일업로드">
            </div>
        </div>
        <br/>
        <h4>푸드트럭 프로필 이미지 파일업로드</h4>
        업로드하실 파일을 선택하세요. <br/>
        <form action="./upload.jsp" method="post"
              enctype="multipart/form-data">
            <input type="file" name="file" size="50"/>
            <br/>
            <input type="submit" value="선택한 파일 업로드"/>
        </form>


        <!-- 푸드트럭 사장님 한마디 -->
        <br/><br/>
        <div class="form-group">
            <label for="truckCEOIntro" class="col-sm-offset-1 col-sm-3 control-label">사장님 한마디</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="truckCEOIntro" name="truckCEOIntro" placeholder="사장님 한마디">
            </div>
        </div>
        <br/><br/>
        <div id="google_recaptha">
            <div class="g-recaptcha" data-sitekey="6LcPg8gdAAAAAO5xlPExdNehovl0HGgHL8veP0OR"></div>
        </div>

        <br/><br/>
        <div class="form-group">
            <div class="col-sm-offset-4  col-sm-4 text-center">
                <button type="button" class="btn btn-primary">가 입</button>
                <a class="btn btn-primary btn" href="#" role="button">취 소</a>
            </div>
        </div>
    </form>


</div>

</body>

</html>