<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html lang="ko">


<head>
    <!-- Basic -->
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <!-- Mobile Metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <!-- Site Metas -->
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <title>F.FIN | FOODTRUCK FINDER</title>

    <!-- bootstrap core css -->
    <link rel="stylesheet" type="text/css" href="../../resources/bootstrap/css/bootstrap.css" />

    <!-- fonts style -->
    <link href="https://fonts.googleapis.com/css?family=Poppins:400,600,700&display=swap" rel="stylesheet">

    <!-- font awesome style -->
    <link href="../../resources/bootstrap/css/font-awesome.min.css" rel="stylesheet" />
    <!-- nice select -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" integrity="sha256-mLBIhmBvigTFWPSCtvdu6a76T+3Xyt+K571hupeFLg4=" crossorigin="anonymous" />
    <!-- slidck slider -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css" integrity="sha256-UK1EiopXIL+KVhfbFa8xrmAWPeBjMVdvYMYkTAEv/HI=" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css.map" integrity="undefined" crossorigin="anonymous" />

    <!-- Custom styles for this template -->
    <link href="../../resources/bootstrap/css/style.css" rel="stylesheet" />
    <!-- responsive style -->
    <link href="../../resources/bootstrap/css/responsive.css" rel="stylesheet" />

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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js" integrity="sha256-Zr3vByTlMGQhvMfgkQ5BtWRSKBGa2QlspKYJnkjZTmo=" crossorigin="anonymous"></script>
    <!-- custom js -->
    <script src="../../resources/bootstrap/js/custom.js"></script>

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <title>게시글 작성</title>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //============= "작성완료"  Event 연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-secondary").on("click", function () {
                fncAddPost();
            });
        });

        //============= "취소"  Event 처리 및  연결 =============
        $(function () {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("a[href='#' ]").on("click", function () {
                self.location = "/views/community/getPostList.jsp"
            });
        });

        function fncAddPost() {
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
            $("form").attr("method", "POST").attr("action", "/community/addPost").attr("enctype", "multipart/form-data").submit();
            alert("게시물 작성이 완료되었습니다.");
        }


    </script>

</head>



<body id="page-top">

<jsp:include page="/views/toolbar.jsp" />
<br/><br/>


                <div class="container">
                    <div class="page-header text-info">
                        <h3> 게시글조회 </h3>
                    </div>
                    <form name="detailForm">


                        <table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
                            <tr>
                                <td height="1" colspan="3" bgcolor="D6D6D6"></td>
                            </tr>
                            <tr>
                                <td width="104" class="ct_write">
                                    게시글제목 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
                                </td>
                                <td bgcolor="D6D6D6" width="1"></td>
                                <td class="ct_write01">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="105">${post.postTitle}</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td height="1" colspan="3" bgcolor="D6D6D6"></td>
                            </tr>
                            <tr>
                                <td width="104" class="ct_write">
                                    게시글내용 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
                                </td>
                                <td bgcolor="D6D6D6" width="1"></td>
                                <td class="ct_write01" height="300">${post.postContent}</td>
                                <input type='hidden' name='postContent' value='${post.postContent}'/>
                            </tr>
                            <tr>
                                <td height="1" colspan="3" bgcolor="D6D6D6"></td>
                            </tr>
                            <tr>
                                <td width="104" class="ct_write">
                                    첨부파일1 <img 	src="/Users/js/IdeaProjects/ffin/src/main/webapp/resources/image/${post.postFile1}" width="3" height="3" align="absmiddle"/>
                                </td>
                                <td bgcolor="D6D6D6" width="1"></td>
                                <td class="ct_write01">
                                    ${post.postFile1}
                                    <img src="/Users/js/IdeaProjects/ffin/src/main/webapp/resources/image/${post.postFile1}" width="200" height="200" />
                                </td>
                            </tr>
                            <tr>
                                <td height="1" colspan="3" bgcolor="D6D6D6"></td>
                            </tr>

                            <tr>
                                <td width="104" class="ct_write">
                                    첨부파일2 <img 	src="/image/${post.postFile2}" width="3" height="3" align="absmiddle"/>
                                </td>
                                <td bgcolor="D6D6D6" width="1"></td>
                                <td class="ct_write01">
                                    <img src="../../resources/image/${post.postFile2}" width="200" height="200" />
                                </td>
                            </tr>
                            <tr>
                                <td height="1" colspan="3" bgcolor="D6D6D6"></td>
                            </tr>

                            <tr>
                                <td width="104" class="ct_write">
                                    첨부파일3 <img 	src="/image/${post.postFile3}" width="3" height="3" align="absmiddle"/>
                                </td>
                                <td bgcolor="D6D6D6" width="1"></td>
                                <td class="ct_write01">
                                    <img src="../../resources/image/${post.postFile3}" width="200" height="200" />
                                </td>
                            </tr>
                            <tr>
                                <td height="1" colspan="3" bgcolor="D6D6D6"></td>
                            </tr>
                        </table>


                        <br/>
        <div class="form-group">
            <div class="col-sm-offset-6  col-sm-6 text-center">
                <button type="button" class="btn btn-secondary">작 성 완 료</button>
                <a class="btn btn-secondary btn" href="#" role="button">취 소</a>
            </div>
        </div>
    </form>

</div>
<jsp:include page="/views/footer.jsp" />

</body>

</html>
