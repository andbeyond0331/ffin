<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>

    <title>푸드트럭(사업자) 아이디찾기</title>
    <jsp:include page="../../common/lib.jsp"/>
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        $("button.btn-close").on("click", function () {
            $('#findid_modal').modal('hide');
        });

        //체크 버튼에 따라 아이디/비밀번호 기능이 달라진다
        // function search_check(num) {
        //     if (num == '1') {
        //         document.getElementById("searchP").style.display = "none";
        //         document.getElementById("searchI").style.display = "";
        //     } else {
        //         document.getElementById("searchI").style.display = "none";
        //         document.getElementById("searchP").style.display = "";
        //     }
        // }


        $(document).ready(function () {
            /////////모///달///기///능///////////
            // 1. 모달창 히든 불러오기
            $('#searchBtn').on('click', function () {
                $('#findid_modal').modal('show');
            });
            // 2. 모달창 닫기 버튼
            $('.close').on('click', function () {
                $('#findid_modal').modal('hide');
            });
            // 3. 모달창 윈도우 클릭 시 닫기
            $(window).on('click', function () {
                if (event.target == $('#findid_modal').get(0)) {
                    $('#findid_modal').modal('hide');
                }
            });
        });

        // 아이디 & 스토어 값 저장하기 위한 변수
        var idV = "";
        // 아이디 값 받고 출력하는 ajax
        var idSearch_click = function () {
            //alert(1111);
            $.ajax({
                url    : "/truck/findTruckId?inputName_1="
                    + $('#inputName_1').val() + "&inputPhone_1=" + $('#inputPhone_1').val(),
                type   : "post",

                success: function (data) {
                    //alert(2222);
                    if (data == 0) {
                        $('#id_value').text("회원 정보를 확인해주세요!");
                    } else {
                        $('#id_value').text(data);
                        //alert(data);
                        // 아이디값 별도로 저장
                        idV = data;
                    }
                    //alert(3333);
                }
            });
        };

    </script>
</head>


<body id="page-top">

<jsp:include page="/views/navbar.jsp"/>
<br/><br/><br/><br/>

<div class="modal fade" id="findid_modal" tabindex="-1" aria-labelledby="findid_modalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="findid_modalLabel">회원님의 아이디는</h4>
            </div>
            <div class="modal-body">
                <h2 class="modal-content" id="id_value"></h2>
            </div>
            <div class="modal-footer">
                <h4 class="modal-footer" >입니다.</h4>
            </div>
            <br>
<%--            <button type="button" id="pwSearch_btn" class="btn peach-gradient btn-rounded waves-effect">--%>
<%--                <i class="fa fa-envelope"></i>비밀번호 찾기--%>
<%--            </button>--%>
        </div>
    </div>
</div>

<div class="container">
    <div class="area_inputs wow fadeIn">
        <div class="sub_title font-weight-bold">
            <h3>아이디 찾기</h3>
            <p>가입시 입력한 정보로 아이디 찾기가 가능합니다 :)</p>
        </div>
<%--        <div style="margin-bottom: 10px;"--%>
<%--             class="custom-control custom-radio custom-control-inline">--%>
<%--            <input type="radio" class="custom-control-input" id="search_1" name="search_total"--%>
<%--                   onclick="search_check(1)"--%>
<%--                   checked="checked">--%>
<%--            <label class="custom-control-label font-weight-bold" for="search_1">아이디 찾기</label>--%>
<%--        </div>--%>
<%--        <div class="custom-control custom-radio custom-control-inline">--%>
<%--            <input type="radio" class="custom-control-input" id="search_2" name="search_total"--%>
<%--                   onclick="search_check(2)">--%>
<%--            <label class="custom-control-label font-weight-bold" for="search_2">비밀번호 찾기</label>--%>
<%--        </div>--%>
        <div id="searchI">
            <div class="form-group">
                <label class="font-weight-bold" for="inputName_1">푸드트럭상호</label>
                <div>
                    <input type="text" class="form-control" id="inputName_1" name="inputName_1"
                           placeholder="가입되어있는 푸드트럭상호">
                </div>
            </div>
            <div class="form-group">
                <label class="font-weight-bold" for="inputPhone_1">휴대폰번호</label>
                <div>
                    <input type="text" class="form-control" id="inputPhone_1" name="inputPhone_1"
                           placeholder="회원가입시 입력한 전화번호 ('-' 제외)">
                </div>
            </div>
            <div class="form-group">
                <button id="searchBtn" type="button" onclick="idSearch_click()" class="btn btn-primary">확인</button>

                <a class="btn btn-danger" href="/views/homeTest.jsp">취소</a>
            </div>
        </div>
<%--        <div id="searchP" style="display: none;">--%>
<%--            <div class="form-group">--%>
<%--                <label class="font-weight-bold" for="inputId">아이디</label>--%>
<%--                <div>--%>
<%--                    <input type="text" class="form-control" id="inputId" name="inputId_2" placeholder="가입되어있는 아이디">--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="form-group">--%>
<%--                <label class="font-weight-bold" for="inputEmail_2">이메일</label>--%>
<%--                <div>--%>
<%--                    <input type="email" class="form-control" id="inputEmail_2" name="inputEmail_2"--%>
<%--                           placeholder="회원가입시 입력한 이메일">--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="form-group">--%>
<%--                <button id="searchBtn2" type="button" class="btn btn-primary">확인</button>--%>
<%--                <a class="btn btn-danger" href="/views/homeTest.jsp">취소</a>--%>
<%--            </div>--%>
        </div>
    </div>
</div>

<jsp:include page="/views/footer.jsp"/>

</body>

</html>
