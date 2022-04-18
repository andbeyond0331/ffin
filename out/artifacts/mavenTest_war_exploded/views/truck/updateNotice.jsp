<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>

    <title>F.FIN | 공지 작성</title>
    <jsp:include page="../../common/lib.jsp"/>
    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //============= "작성완료"  Event 연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("#updateNoti").on("click", function () {
                fncUpdateNotice();
            });
        });

        //============= "취소"  Event 처리 및  연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("#cun").on("click", function () {
                alert("공지 수정을 취소하시겠습니까?");
                self.location = "/views/truck/truckMyPage.jsp"
            });
        });

        function fncUpdateNotice() {
            // 유효성체크
            var title = $("input[name='truckNoticeTitle']").val();
            var content = $("textarea[name='truckNoticeContent']").val();

            if (title == null || title.length < 1) {
                alert("제목은 반드시 입력하셔야 합니다.");
                return;
            }
            if (content == null || content.length < 1) {
                alert("내용은 반드시 입력하셔야 합니다.");
                return;
            }
            $("form").attr("method", "POST").attr("action", "/truck/updateNotice").attr("enctype", "multipart/form-data").submit();
            console.log(title);
            console.log(content);
            console.log(11111);
            alert("공지 작성(수정)이 완료되었습니다.");
        }


    </script>

</head>


<body id="page-top">

<jsp:include page="/views/navbar.jsp"/>
<br/><br/><br/><br/>
<c:if test="${sessionScope.truck != null && sessionScope.truck.role == 1}">
    <div class="container">

        <div class="page-header" style="text-align: center">
            <label for="page-top"/>
            <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228; margin-top:40px "></i>
            <h4 style="margin-top: 10px;">공지 작성(수정)</h4>
        </div>

        <form name="updateN" class="form-horizontal">
            <!-- 공지수정 양식 영역 시작 -->
            <div class="form-group">
                <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                    <tbody>
                    <tr>
                        <td><input id="truckNoticeTitle" type="text" class="form-control" placeholder="공지 제목"
                                   name="truckNoticeTitle"
                                   maxlength="50" value="${truck.truckNoticeTitle}"></td>
                    </tr>
                    <tr>
                        <td><textarea id="truckNoticeContent" class="form-control" placeholder="공지 내용"
                                      name="truckNoticeContent" maxlength="3000"
                                      style="height: 350px;" wrap="hard">${truck.truckNoticeContent}</textarea></td>
                    </tr>
                    <!-- 푸드트럭 공지 파일업로드란 -->
                    <td>
                        <div class="form-group join-layout">
                            <div class="col-md-6 offset-3" style="text-align:center">
                                <strong for="truckNoticeImg1" class="col-sm-offset-1 col-sm-4 control-label">첨부
                                    파일</strong>
                            </div>
                            <div class="col-sm-6 offset-3"  style="content-align:center ">
                                <input id="truckNoticeImg1" type="file" name="truckNoticeImg1" class="form-control"
                                       value="${truck.truckNoticeImg}" id="truckNoticeImg1" placeholder="파일첨부"
                                       onchange="setNotiPreview(event);"/>
                                <div id="notiFilePreview"></div>
                            </div>
                        </div>
                        <input type="hidden" id="checkL"/>
                        <script>


                            function setNotiPreview(event) {

                                var DIVimage1preview = $('#notiFilePreview');
                                var isTherePreview = DIVimage1preview.find('img').length;
                                //alert("isTherePreview : " + isTherePreview);
                                var reader = new FileReader();

                                if (isTherePreview == 0) {

                                } else {

                                    DIVimage1preview.find('img').remove();

                                }

                                reader.onload = function (event) {
                                    var img = document.createElement("img");
                                    img.setAttribute("src", event.target.result);
                                    document.querySelector("div#notiFilePreview").appendChild(img);

                                };

                                reader.readAsDataURL(event.target.files[0]);


                            }
                        </script>
                    </td>


                    </tbody>
                </table>
            </div>
            <!-- 게시판 글쓰기 양식 영역 끝 -->

            <br/>
            <div class="form-group">
                <div class="offset-3 col-sm-6 text-center">
                    <button type="button" class="btn btn-default" id="updateNoti">작성(수정) 완 료</button>
                    <button class="btn btn-cancle" type="button" id="cun">취 소</button>
                </div>
            </div>
        </form>

    </div>
</c:if>
<c:if test="${sessionScope.truck == null || sessionScope.truck.role == 0}">
    <div class="col-sm-offset-6 text-center">
        <h3>가입승인이 완료된 사업자 회원만 공지를 작성하실 수 있습니다</h3>
        <br/><br/>
        <a href="/views/truck/addTruckView.jsp" class="btn-warning">사업자회원가입</a>
        <a href="/catering/mainTruckList" class="btn-warning">메인화면으로</a>
    </div>
</c:if>
<jsp:include page="/views/footer.jsp"/>

</body>

</html>
