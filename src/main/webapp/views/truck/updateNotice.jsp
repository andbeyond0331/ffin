<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>

    <title>공지 작성</title>
    <jsp:include page="../../common/lib.jsp"/>
    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //============= "작성완료"  Event 연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-secondary").on("click", function () {
                fncUpdateNotice();
            });
        });

        //============= "취소"  Event 처리 및  연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-warning").on("click", function () {
                self.location = "/truck/truckMyPage"
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
            alert("공지 작성(수정)이 완료되었습니다.");
        }


    </script>

</head>


<body id="page-top">

<jsp:include page="/views/navbar.jsp"/>
<br/><br/><br/><br/>
<c:if test="${sessionScope.truck != null && sessionScope.truck.role == 1}">
    <div class="container">

        <div class="page-header">
            <label for="page-top" class="col-sm-offset-4 control-label"/>
            <h3 class="text-info">공지 작성(수정)</h3>

        </div>

        <form class="form-horizontal">
            <!-- 게시판 글쓰기 양식 영역 시작 -->
            <div class="form-group">
                <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                    <tbody>
                    <tr>
                        <td><input id="truckNoticeTitle" type="text" class="form-control" placeholder="공지 제목" name="truckNoticeTitle"
                                   maxlength="50" value="${truck.truckNoticeTitle}"></td>
                    </tr>
                    <tr>
                        <td><textarea id="truckNoticeContent" class="form-control" placeholder="공지 내용" name="truckNoticeContent" maxlength="3000"
                                      style="height: 350px;" >${truck.truckNoticeContent}${truck.truckNoticeImg}</textarea></td>
                    </tr>
                    <!-- 푸드트럭 공지 파일업로드란 -->
                    <td>
                        <label for="inputFile" class="col-sm-2 col-form-label"><strong>첨부 파일</strong></label>
                        <input id="truckNoticeImg" type="file" name="truckNoticeImg" class="form-control-file"/>
                        </td>


                    </tbody>
                </table>
            </div>
            <!-- 게시판 글쓰기 양식 영역 끝 -->

            <br/>
            <div class="form-group">
                <div class="col-sm-offset-6 col-sm-6 text-center">
                    <button type="button" class="btn btn-secondary">작성(수정) 완 료</button>
                    <button class="btn btn-warning" type="button">취 소</button>
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
        <a href="/views/home.jsp" class="btn-warning">메인화면으로</a>
    </div>
</c:if>
<jsp:include page="/views/footer.jsp"/>

</body>

</html>
