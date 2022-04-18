<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">


<head>

  <title>F.FIN | 구매내역 </title>
  <jsp:include page="../../common/lib.jsp"/>

  <!-- bootstrap core css -->
  <link rel="stylesheet" type="text/css" href="../../resources/bootstrap/css/bootstrap.css" />
  <!-- Custom styles for this template -->
  <link href="../../resources/bootstrap/css/style.css" rel="stylesheet" />

  <!--    Favicons-->
  <link rel="apple-touch-icon" sizes="180x180" href="../../resources/bootstrap/assets/favicons/apple-touch-icon.png">
  <link rel="icon" type="image/png" sizes="32x32" href="../../resources/bootstrap/assets/favicons/favicon-32x32.png">
  <link rel="icon" type="image/png" sizes="16x16" href="../../resources/bootstrap/assets/favicons/favicon-16x16.png">
  <link rel="shortcut icon" type="image/x-icon" href="../../resources/bootstrap/assets/favicons/favicon.ico">
  <link rel="manifest" href="../../resources/bootstrap/assets/favicons/manifest.json">
  <meta name="msapplication-TileImage" content="../../resources/bootstrap/assets/favicons/mstile-150x150.png">
  <meta name="theme-color" content="#ffffff">

  <style>

    .search{
      margin-top: 100px;
    }

    #dataTable thead tr th, #dataTable tbody tr td{
      text-align: center;
    }

    #dataTable tbody tr:hover{
      color: #ffba49;
    }

    .form-inline{
      float: right;
      padding-right: 20px;
    }
    .card.mb-10{
      width: auto;
      min-height: 50px;
      margin-top: 5px;
      display: flex;
      justify-content: center;
      font-size: 16px;
    }
    .card-body {
      padding: 0;
    }
    .card-text{
      padding: 0;
    }
    .inquiry-card{
      display: flex;
      justify-content: space-around;
    }
    .inquiry-con{
      padding: 0;
    }

    #inquiryAnsContent{
      min-height: 150px;
    }
    a, a:hover {
      text-decoration: none;
      transition: color 0.3s ease-in-out;
    }
    .postcard {
      flex-wrap: wrap;
      display: flex;

      box-shadow: 0 4px 21px -12px rgba(0, 0, 0, 0.66);
      border-radius: 10px;
      margin: 0 0 2rem 0;
      overflow: hidden;
      position: relative;
      color: #ffffff;
    }
    .postcard.dark {
      background-color: #18151f;
    }
    .postcard.light {
      background-color: #ffffff;
    }
    .t-dark {
      color: #18151f;
    }
    .postcard a {
      color: inherit;
    }
    .postcard h1, .h1 {
      margin-bottom: 0.5rem;
      font-weight: 500;
      line-height: 1.2;
      text-align: initial;
    }
    .small {
      font-size: 80%;
      text-align: initial;
    }
    .postcard__title {
      font-size: 1.25rem;
    }
    .postcard__img {
      max-height: 180px;
      width: 100%;
      object-fit: cover;
      position: relative;
    }
    .postcard__img_link {
      display: contents;
    }
    .postcard__bar {
      width: 50px;
      height: 10px;
      margin: 10px 0;
      border-radius: 5px;
      background-color: #fae100;
      transition: width 0.2s ease;
    }

    .postcard__text {
      padding: 1.5rem;
      position: relative;
      display: flex;
      flex-direction: column;
    }
    .postcard__preview-txt {
      overflow: hidden;
      text-overflow: ellipsis;
      text-align: justify;
      height: 100%;
    }
    .postcard__tagbox {
      display: flex;
      flex-flow: row wrap;
      font-size: 14px;
      margin: 20px 0 0 0;
      padding: 0;
      justify-content: center;
    }
    .tag__item {
      display: inline-block;
      background: rgb(255, 255, 255);
      border-radius: 3px;
      padding: 2.5px 10px;
      margin: 0 5px 5px 0;
      cursor: default;
      user-select: none;
      transition: background-color 0.3s;
      border-radius: 20px;
    }
    .tag__item:hover{
      background: rgb(250, 225, 0);
      border-radius: 20px;
    }
    .postcard:before{
      content: "";
      position: absolute;
      top: 0;
      right: 0;
      bottom: 0;
      left: 0;
      background-image: linear-gradient(-70deg, #ffffff, transparent 50%);
      opacity: 1;
      border-radius: 10px;
    }
    .postcard:hover .postcard__bar {
      width: 100px;
    }

    @media screen and (min-width: 769px) {

      .postcard {
        flex-wrap: inherit;
      }

      .postcard__title {
        font-size: 2rem;
      }

      .postcard__tagbox {
        justify-content: start;
      }

      .postcard__img {
        max-width: 300px;
        max-height: 100%;
        transition: transform 0.3s ease;
      }

      .postcard__text {
        padding: 3rem;
        width: 100%;
      }

      .media.postcard__text:before {
        content: "";
        position: absolute;
        display: block;
        background: #ffffff;
        top: -20%;
        height: 130%;
        width: 55px;
      }

    .postcard:hover .postcard__img {
       transform: scale(1.1);
     }

    .postcard:nth-child(2n+1) {
       flex-direction: row;
     }

    .postcard:nth-child(2n+0) {
       flex-direction: row-reverse;
     }

    .postcard:nth-child(2n+1) .postcard__text::before {
       left: -12px !important;
       transform: rotate(4deg);
     }

    .postcard:nth-child(2n+0) .postcard__text::before {
       right: -12px !important;
       transform: rotate(-4deg);
     }
    }

    @media screen and (min-width: 1024px){
      .postcard__text {
        padding: 2rem 3.5rem;
      }

      .postcard__text:before {
        content: "";
        position: absolute;
        display: block;

        top: -20%;
        height: 130%;
        width: 55px;
      }

      .postcard.dark {
        background: #18151f;
      }
      .postcard__text:before {
        background: #ffffff;
      }
      .postcard.light {
        background: rgb(255, 255, 255);
      }
      .postcard__text:before {
        background: rgb(255, 255, 255);
      }
    }

    .postcard .postcard__tagbox .blue.play:hover {
      background: #fae100;
    }
    .blue .postcard__title:hover {
      color: #fae100;
    }
    .blue .postcard__bar {
      background-color: #fae100;
    }

  </style>

  <script type="text/javascript">

    function fncGetUserList(currentPage) {
      $("#currentPage").val(currentPage)
      $("#search_form").attr("method", "POST").attr("action", "/user/getPurchaseList").submit();
    }

  </script>

</head>

<body>
<jsp:include page="/views/navbar.jsp" />
<div style="height: auto">
  <jsp:include page="/views/user/sidebar.jsp" />
</div>

<section class="client_section layout_padding">

  <div class="container">
    <div class="col-md-11 col-lg-12 mx-auto">

      <div class="detail-box">
        <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
        <h4 style="margin-top: 10px;">
          구매내역
        </h4>
      </div>

      <div class="row search" style="margin-bottom: 20px;">
        <div class="col-md-6 text-left" style="display: flex; align-items: center;">
          <p style="margin: 0; font-size: 12px;">
            전체  ${resultPage.totalCount } 건, 현재 ${resultPage.currentPage}  페이지
          </p>
        </div>

        <div class="col-md-6 text-right">
          <form class="form-inline" id="search_form" name="detailForm" style="zoom: 90%; padding: 0; float: right;">
            <a type="button" href="/user/getPurchaseList?searchCondition=0" class="btn btn-cancle" style="zoom: 90%;">전체</a>
            <a type="button" href="/user/getPurchaseList?searchCondition=1" class="btn btn-cancle" style="zoom: 90%;">구매완료</a>
            <a type="button" href="/user/getPurchaseList?searchCondition=2" class="btn btn-cancle" style="zoom: 90%;">주문취소</a>
            <%--<a type="button" href="/user/getPurchaseList?searchCondition=2" class="btn btn-cancle" style="zoom: 90%;">현재주문정보</a>--%>

            <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
            <input type="hidden" id=""  name="searchCondition" value="${search.searchCondition}"/>
            <input type="hidden" id="currentPage" name="currentPage" value=""/>

          </form>
        </div>
      </div>

      <c:set var="i" value="0" />
      <c:forEach var="orderDetail" items="${list}">
      <c:set var="i" value="${ i+1 }" />

          <section class="light">
            <div class="container py-2">

              <article class="postcard light blue">
                <a class="postcard__img_link" href="#">
                  <img class="postcard__img" src="/resources/menu/${orderDetail.odMenuImage}" alt="Image Title" />
                </a>
                <div class="postcard__text t-dark">
                  <h1 class="postcard__title blue">
                    <a href="/menu/getMenuList?truckId=${orderDetail.odOrderNo.orderTruckId.truckId}">
                        ${orderDetail.odOrderNo.orderTruckId.truckName}
                    </a></h1>
                  <div class="postcard__subtitle small">
                    <c:choose>
                      <c:when test="${orderDetail.odOrderNo.orderStatus eq 1 }">
                        <span class="badge" style="background-color: #fae100; color: #110000">결제완료</span>
                      </c:when>
                      <c:when test="${orderDetail.odOrderNo.orderStatus eq 2 }">
                        <span class="badge" style="background-color: #fae100; color: #110000">주문접수</span>
                      </c:when>
                      <c:when test="${orderDetail.odOrderNo.orderStatus eq 3 }">
                        <span class="badge" style="background-color: #fae100; color: #110000">픽업요청</span>
                      </c:when>
                      <c:when test="${orderDetail.odOrderNo.orderStatus eq 4 }">
                        <span class="badge" style="background-color: #65bf96; color: #110000">픽업완료</span>
                      </c:when>
                      <c:when test="${orderDetail.odOrderNo.orderStatus eq 5 }">
                        <span class="badge" style="background-color: #ffba49; color: #110000">결제취소</span>
                      </c:when>
                    </c:choose>&nbsp;&nbsp;
                    <time datetime="YYYY-MM-DD">
                      <i class="fas fa-calendar-alt mr-2"></i>${orderDetail.odOrderNo.payDateTime}
                    </time>

                  </div>
                  <div class="postcard__bar"></div>
                  <div class="postcard__preview-txt">${orderDetail.odMenuName}</div>
                  <div class="postcard__preview-txt"><h6>${orderDetail.odOrderNo.payPrice}&nbsp;₩</h6></div>

                  <ul class="postcard__tagbox">
                    <li class="tag__item orderBtn"><a href="/user/getPurchaseByUser?orderNo=${orderDetail.odOrderNo.orderNo}"><i class="fas fa-tag mr-2"></i>주문상세</a></li>
                    <c:if test="${orderDetail.odOrderNo.orderStatus eq 4 }">
                    <li class="tag__item reviewBtn">
                      <a href="/review/addReview?orderNo=${orderDetail.odOrderNo.orderNo}"><i class="fas fa-clock mr-2"></i>리뷰작성</a>
                    </li>
                    </c:if>
                    <%--<c:if test="${orderDetail.odOrderNo.orderStatus eq 6 }">
                      <li class="tag__item reviewBtn"><a href="/review/getReview?orderNo=${orderDetail.odOrderNo.orderNo}"><i class="fas fa-clock mr-2"></i>리뷰확인</a></li>
                    </c:if>--%>
                  </ul>
                </div>
              </article>

            </div>
          </section>

      </c:forEach>


    </div>
  </div>

  <div class="modal fade" id="addReview" tabindex="-1" aria-labelledby="addInquiryAns" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">문의 답변</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <input type="hidden" id="hiddenOrderNo" name ="hiddenOrderNo" value="">
          <form style="text-align: left;">
            <div class="mb-3">
              <label for="inquiryAnsTitle" class="col-form-label">답변 제목</label>
              <input type="text" class="form-control" id="inquiryAnsTitle">
            </div>
            <div class="mb-3">
              <label for="inquiryAnsContent" class="col-form-label">답변 내용</label>
              <textarea class="form-control" id="inquiryAnsContent"></textarea>
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
          <button type="button" class="btn btn-default btn-sm" id="updateInquiryAnsBtn">답변등록</button>
        </div>
      </div>
    </div>
  </div>


</section>
<jsp:include page="../../common/pageNavigator_new.jsp"/>
<jsp:include page="/views/footer.jsp" />
</body>
</html>