<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">

<!doctype html>
<html lang="ko">
<meta charset="EUC-KR">

<head>
    <jsp:include page="/views/toolbar.jsp" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>
<!-- Bootstrap Dropdown Hover CSS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<style>

</style>
<form>
    <%--<div class="container py-4">--%>
    <header class="pb-4 mb-5 py-4 border-bottom">
        <span class="fs-1">주문내역</span>
    </header>

    <div class="container-fluid">
        <div class="row justify-content-evenly">

            <div class="col-5 p-3 mb-2  bg-light text-dark">

                <div class="row ">
                    <div class="col-1">
                        <button class="btn btn-primary" type="button">처리중</button>

                        <button class="btn btn-primary" type="button">픽업완료</button>
                    </div>
                    <div class="col-11">
                        <div class="row justify-content-between">
                            <div class="col-3"> 전체 : </div>
                            <div class="col-3">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckChecked" checked>
                                    <label class="form-check-label" for="flexSwitchCheckChecked">영업중</label>

                                </div>
                            </div>
                            <br><br>
                        </div>
                        <hr class="my-2">

                    </div>
                </div>


            </div>

            <div class="col-6 p-3 mb-2 bg-light  text-dark">
                <div class="row ">
                    <div class="col-2"> 상호 : </div>
                    <div class="col-2">
                        <button class="btn btn-primary" type="button">주문거절</button>

                    </div>
                    <div class="col-6">

                        <input type="radio" class="btn-check w-25 p-1" name="btnradio" id="btnradio1" autocomplete="off" checked>
                        <label class="btn btn-outline-primary" for="btnradio1">5분</label>

                        <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off">
                        <label class="btn btn-outline-primary" for="btnradio2">10분</label>

                        <input type="radio" class="btn-check" name="btnradio" id="btnradio3" autocomplete="off">
                        <label class="btn btn-outline-primary" for="btnradio3">15분</label>

                        <input type="radio" class="btn-check " name="btnradio" id="btnradio4" autocomplete="off">
                        <label class="btn btn-outline-primary" for="btnradio4">20분</label>

                        <input type="radio" class="btn-check" name="btnradio" id="btnradio5" autocomplete="off">
                        <label class="btn btn-outline-primary" for="btnradio5">30분</label>

                        <input type="radio" class="btn-check" name="btnradio" id="btnradio6" autocomplete="off">
                        <label class="btn btn-outline-primary" for="btnradio6">40분</label>
                    </div>
                    <div class="col-2">

                        <button class="btn btn-primary" type="button">주문접수</button>

                    </div>
                </div>
                <hr class="my-2">
                <div class="row">

                    <div class="col-7">

                        <div class="row">
                        <label for="orderRequest" class="col-form-label">주문요청사항 :</label>
                        <textarea class="form-control" id="orderRequest" name="orderRequest"  value="${purchase.orderRequest}" disabled></textarea>
                        </div>
                        <br>
                        <div class="row">
                            <label for="orderRequest" class="col-form-label">픽업희망시간 :</label>
                        </div>
                        <hr class="my-2">
                        <div class="row">
                            <label for="orderRequest" class="col-form-label">주문내역 :</label>
                        </div>

                    </div>
                    <div class="col-1">
                        <div class="d-flex" style="height: 200px;">
                            <div class="vr"></div>
                        </div>
                    </div>

                    <div class="col-4">
                        <div class="row">
                            <label for="orderRequest" class="col-form-label">고객정보 :</label>
                        </div>
                        <div class="row">

                            <img src="/resources/image/1.jpg" width="90" height="120" alt="주문상품 이미지">

                        </div>
                        <div class="row">



                        </div>

                    </div>

                </div>

            </div>
        </div>

    </div>
    <%--</div>--%>

</form>

</body>
<jsp:include page="/views/footer.jsp" />
</html>