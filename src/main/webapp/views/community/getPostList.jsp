<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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


    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">

        //=============    검색 / page 두가지 경우 모두  Event  처리 =============
        function fncGetUserList(currentPage) {
            $("#currentPage").val(currentPage)
            $("form").attr("method" , "POST").attr("action" , "/community/getPostList").submit();
        }


        //============= "검색"  Event  처리 =============
        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $( "button.btn.btn-default" ).on("click" , function() {
            	fncGetUserList(1);
            });
        });

        //============= "글쓰기"  Event  처리 =============
        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $( "button.btn.btn-primary" ).on("click" , function() {
                self.location = "/views/community/addPostView.jsp";
            });
        });


        //============= userId 에 회원정보보기  Event  처리(Click) =============
        $(function() {

            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $( "td:nth-child(1)" ).on("click" , function() {
                self.location ="/community/getPost?postNo="+$(this).text().trim();
            });

            //==> userId LINK Event End User 에게 보일수 있도록
            $( "td:nth-child(1)" ).css("color" , "orange");

        });


        //============= userId 에 회원정보보기  Event  처리 (double Click)=============
        $(function() {

            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $(  "td:nth-child(5) > i" ).on("click" , function() {

                var userId = $(this).next().val();

                $.ajax(
                    {
                        url : "/user/json/getUser/"+userId ,
                        method : "GET" ,
                        dataType : "json" ,
                        headers : {
                            "Accept" : "application/json",
                            "Content-Type" : "application/json"
                        },
                        success : function(JSONData , status) {

                            var displayValue = "<h6>"
                                +"아이디 : "+JSONData.userId+"<br/>"
                                +"이  름 : "+JSONData.userName+"<br/>"
                                +"이메일 : "+JSONData.email+"<br/>"
                                +"ROLE : "+JSONData.role+"<br/>"
                                +"등록일 : "+JSONData.regDateString+"<br/>"
                                +"</h6>";
                            $("h6").remove();
                            $( "#"+userId+"" ).html(displayValue);
                        }
                    });
                ////////////////////////////////////////////////////////////////////////////////////////////

            });

            //==> userId LINK Event End User 에게 보일수 있도록
            $( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
            $("h7").css("color" , "red");

            //==> 아래와 같이 정의한 이유는 ??
            $(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
        });

    </script>



</head>



<body id="page-top">

<jsp:include page="/views/toolbar.jsp" />
<br/><br/>

<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">

    <div class="page-header text-info">
        <h3>게시판 목록조회</h3>
    </div>

    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
    <div class="row">

        <div class="col-md-6 text-left">
            <p class="text-primary">
                전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
            </p>
        </div>

        <div class="col-md-6 text-right">
            <button type="button" class="btn btn-primary">게시글 작성</button>
        </div>

        <div class="col-md-8 text-right">
            <form class="form-inline" name="detailForm">

                <div class="form-group">
                    <select class="form-control" name="searchCondition" >
                        <option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>작성자ID</option>
                        <option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>게시물제목</option>
                    </select>
                </div>

                <div class="form-group">
                    <label class="sr-only" for="searchKeyword">검색어</label>
                    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
                           value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
                    <button type="button" class="btn btn-default">검색</button>
                </div>


                <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
                <input type="hidden" id="currentPage" name="currentPage" value=""/>

            </form>
        </div>

    </div>
    <!-- table 위쪽 검색 Start /////////////////////////////////////-->


    <!--  table Start /////////////////////////////////////-->
    <table class="table table-hover table-striped" >

        <thead>
        <tr>
            <th align="center">No</th>
            <th align="left" >제목</th>
            <th align="left">작성회원 ID</th>
            <th align="left">작성사업자 ID</th>
            <th align="left">작성일</th>
            <th align="left">좋아요</th>
        </tr>
        </thead>

        <tbody>

        <c:set var="i" value="0" />
        <c:forEach var="post" items="${list}">
            <c:set var="i" value="${ i+1 }" />
            <tr>
                <td align="center">${ i }</td>
                <td align="left">${post.postTitle}</td>
                <td align="left">${post.postUser.userId}</td>
                <td align="left">${post.postTruck.truckId}</td>
                <td align="left">${post.postRegDate}</td>
                <td align="left">
                    <i class="glyphicon glyphicon-ok" id= "${post.postNo}"></i>
                    <input type="hidden" value="${post.postUser}">
                </td>
            </tr>
        </c:forEach>

        </tbody>

    </table>
    <!--  table End /////////////////////////////////////-->

</div>
<!--  화면구성 div End /////////////////////////////////////-->


<!-- PageNavigation Start... -->
<jsp:include page="../../common/pageNavigator_new.jsp"/>
<!-- PageNavigation End... -->



<jsp:include page="/views/footer.jsp" />

</body>

</html>
