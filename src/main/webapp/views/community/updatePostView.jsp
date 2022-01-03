<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">


<head>
    <!-- Basic -->
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <!-- Mobile Metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <!-- Site Metas -->
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>

    <title>F.FIN | FOODTRUCK FINDER</title>

    <!-- bootstrap core css -->
    <link rel="stylesheet" type="text/css" href="../../resources/bootstrap/css/bootstrap.css"/>

    <!-- fonts style -->
    <link href="https://fonts.googleapis.com/css?family=Poppins:400,600,700&display=swap" rel="stylesheet">

    <!-- font awesome style -->
    <link href="../../resources/bootstrap/css/font-awesome.min.css" rel="stylesheet"/>
    <!-- nice select -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css"
          integrity="sha256-mLBIhmBvigTFWPSCtvdu6a76T+3Xyt+K571hupeFLg4=" crossorigin="anonymous"/>
    <!-- slidck slider -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css"
          integrity="sha256-UK1EiopXIL+KVhfbFa8xrmAWPeBjMVdvYMYkTAEv/HI=" crossorigin="anonymous"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css.map"
          integrity="undefined" crossorigin="anonymous"/>

    <!-- Custom styles for this template -->
    <link href="../../resources/bootstrap/css/style.css" rel="stylesheet"/>
    <!-- responsive style -->
    <link href="../../resources/bootstrap/css/responsive.css" rel="stylesheet"/>

    <!--    Favicons-->
    <link rel="apple-touch-icon" sizes="180x180" href="../../resources/bootstrap/assets/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="../../resources/bootstrap/assets/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="../../resources/bootstrap/assets/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="../../resources/bootstrap/assets/favicons/favicon.ico">
    <link rel="manifest" href="../../resources/bootstrap/assets/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="../../resources/bootstrap/assets/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">

    <!-- jQery -->
    <script src="../../resources/bootstrap/js/jquery-3.4.1.min.js"></script>
    <!-- bootstrap js -->
    <script src="../../resources/bootstrap/js/bootstrap.js"></script>
    <!-- slick  slider -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.js"></script>
    <!-- nice select -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"
            integrity="sha256-Zr3vByTlMGQhvMfgkQ5BtWRSKBGa2QlspKYJnkjZTmo=" crossorigin="anonymous"></script>
    <!-- custom js -->
    <script src="../../resources/bootstrap/js/custom.js"></script>

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <title>게시글 작성</title>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //============= "수정완료"  Event 연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-secondary").on("click", function () {
                fncUpdatePost();
            });
        });

        //============= "취소"  Event 처리 및  연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("a[href='#' ]").on("click", function () {
                self.location = "/community/getPostList"
            });
        });

        function fncUpdatePost() {
            // 유효성체크
            var title = $("input[name='postTitle']").val();
            var content = $("textarea[name='postContent']").val();

            if (title == null || title.length < 1) {
                alert("게시물 제목은 반드시 입력하셔야 합니다.");
                return;
            }
            if (content == null || content.length < 1) {
                alert("게시물 내용은 반드시 입력하셔야 합니다.");
                return;
            }
            $("form").attr("method", "POST").attr("action", "/community/updatePost").attr("enctype", "multipart/form-data").submit();
            alert("게시물 수정이 완료되었습니다.");
        }


    </script>

</head>


<body id="page-top">

<jsp:include page="/views/toolbar.jsp"/>
<br/><br/>
<c:if test="${sessionScope.user != null || sessionScope.truck != null}">
    <div class="container">

        <div class="page-header">
            <label for="page-top" class="col-sm-offset-4 control-label"/>
            <h3 class="text-info">게시글수정</h3>

        </div>

        <form class="form-horizontal">
            <!-- 게시판 글수정 양식 영역 시작 -->
            <div class="form-group">
                <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                    <tbody>
                    <tr>
                        <td><input id="postTitle" type="text" class="form-control" name="postTitle" value="${post.postTitle}"
                                   maxlength="50"></td>
                    </tr>
                    <tr>
                        <td><textarea id="postContent" class="form-control" name="postContent" maxlength="3000"
                                      style="height: 350px;" wrap="hard">${post.postContent}</textarea></td>
                    </tr>
                    <!-- 푸드트럭 사업자등록증 파일업로드란 -->
                    <td>
                        <label for="inputFile" class="col-sm-2 col-form-label"><strong>첨부 파일</strong></label>
                        <input id="file1" type="file" name="file1" class="form-control-file" value="${post.postFile1}"/>
                        <input id="file2" type="file" name="file2" class="form-control-file" value="${post.postFile2}"/>
                        <input id="file3" type="file" name="file3" class="form-control-file" value="${post.postFile3}"/></td>


                    </tbody>
                </table>
            </div>
            <!-- 게시판 글수정 양식 영역 끝 -->

            <br/>
            <div class="form-group">
                <div class="col-sm-offset-6 col-sm-6 text-center">
                    <button type="button" class="btn btn-secondary">수 정 완 료</button>
                    <a class="btn btn-secondary btn" href="#" role="button">취 소</a>
                </div>
            </div>
        </form>

    </div>
</c:if>
<c:if test="${sessionScope.user == null && sessionScope.truck == null}">
    <div class="col-sm-offset-6 text-center">
        <h3>회원가입 이후 게시판을 이용하실 수 있습니다</h3>
        <br/><br/>
        <a href="/views/user/addUserInfo.jsp" class="btn-warning">일반회원가입</d></a>
        <a href="/views/truck/addTruckView.jsp" class="btn-warning">사업자회원가입</a>
        <a href="/views/homeTest.jsp" class="btn-warning">메인화면으로</a>
    </div>
</c:if>
<jsp:include page="/views/footer.jsp"/>

</body>

</html>
