<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">


<head>

    <title>F.FIN | FOODTRUCK FINDER</title>
    <jsp:include page="../../common/lib.jsp"/>

    <!-- Custom styles for this template -->
    <link href="../../resources/bootstrap/css/style.css" rel="stylesheet" />
    <!-- responsive style -->
    <link href="../../resources/bootstrap/css/responsive.css" rel="stylesheet" />

    <style>
        .col{
            flex-grow: inherit;
        }
        .card{
            width: 14rem;
            height: 10rem;
            border-color: #ffffff;
            box-shadow: 0 2px 4px 0 rgba(0,0,0,0.2);
            transition: 0.3s;
        }
        .card:hover{
            width: 14rem;
            height: 10rem;
            border-color: #ffe537;
            box-shadow: 0 2px 4px 0 rgb(255, 229, 55);
            transition: 0.3s;
        }
        .fas.fa-user-alt{
            color: #ffba49;
        }
    </style>

</head>

<body id="page-top">

<jsp:include page="/views/navbar.jsp" />


<!-- client section -->

<section class="client_section layout_padding">
    <div class="container">
        <div class="col-md-11 col-lg-10 mx-auto">
            <div class="detail-box">
                <i class="fa fa-quote-left" aria-hidden="true" style="color: #f17228;"></i>
                <h4 style="margin-top: 10px;">내 정보</h4>
            </div>
        </div>
        <div class="col-md-11 col-lg-10 mx-auto">
            <div class="card">
                <div class="card-body">
                    <span class="box-icon" style="text-align: left;"><i class="fas fa-user-alt page-icon fa-2x"></i></span>
                    <h5 class="card-title" style="text-align: left;">내정보</h5>
<%--                    <h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>--%>
                    <p class="card-text"><i class="fas fa-angle-double-right"></i></p>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="/views/footer.jsp" />

</body>
</html>