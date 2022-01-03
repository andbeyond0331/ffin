<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">

<!doctype html>
<html lang="ko">
<meta charset="EUC-KR">

<head>
    <jsp:include page="/views/navbar.jsp" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>
<!-- Bootstrap Dropdown Hover CSS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<style>

</style>
<main>
    <div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel"
         tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalToggleLabel">Modal 1</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">


                    <div class="container-fluid">
                        <div class="row">
                            <input type="radio" class="btn-check" name="orderCancelReason" id="btnradio1"
                                   autocomplete="off" value="1" checked>
                            <label class="btn btn-outline-primary" for="btnradio1">구매의사 취소</label>
                        </div>
                    </div>

                    <div class="container-fluid">
                        <div class="row">
                            <input type="radio" class="btn-check" name="orderCancelReason" id="btnradio2"
                                   autocomplete="off" value="2">
                            <label class="btn btn-outline-primary" for="btnradio2">메뉴 및 수량 변경</label>
                        </div>
                    </div>

                    <div class="container-fluid">
                        <div class="row">
                            <input type="radio" class="btn-check" name="orderCancelReason" id="btnradio3"
                                   autocomplete="off" value="3">
                            <label class="btn btn-outline-primary" for="btnradio3">주문접수 지연</label>
                        </div>
                    </div>
                    <div class="container-fluid">
                        <div class="row">
                            <input type="radio" class="btn-check" name="orderCancelReason" id="btnradio4"
                                   autocomplete="off" value="4">
                            <label class="btn btn-outline-primary" for="btnradio4">기    타</label>
                        </div>
                    </div>


                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary" data-bs-dismiss="modal" aria-label="Close">취소</button>
                    <button class="btn btn-primary" data-bs-target="#exampleModalToggle2" data-bs-toggle="modal">다 음
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="exampleModalToggle2" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2"
         tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalToggleLabel2">Modal 2</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    정말로 주문취소 하나요??
                </div>
                <div class="modal-footer">

                    <button class="btn btn-primary" data-bs-dismiss="modal" aria-label="Close">취소</button>
                    <button class="btn btn-primary" onclick="cancelPay()">확인</button>
                </div>
            </div>
        </div>
    </div>


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
                        <button class="btn btn-primary" data-bs-toggle="modal" href="#exampleModalToggle" type="button">주문거절</button>
                    </div>
                    <div class="col-6">

                        <input type="radio" class="btn-check" name="btnradio" id="btnradio5" autocomplete="off" value="5" checked>
                        <label class="btn btn-outline-primary" for="btnradio5">5분</label>

                        <input type="radio" class="btn-check" name="btnradio" id="btnradio6" autocomplete="off" value="10">
                        <label class="btn btn-outline-primary" for="btnradio6">10분</label>

                        <input type="radio" class="btn-check" name="btnradio" id="btnradio7" autocomplete="off" value="15">
                        <label class="btn btn-outline-primary" for="btnradio7">15분</label>

                        <input type="radio" class="btn-check" name="btnradio" id="btnradio8" autocomplete="off" value="20">
                        <label class="btn btn-outline-primary" for="btnradio8">20분</label>

                        <input type="radio" class="btn-check" name="btnradio" id="btnradio9" autocomplete="off" value="30">
                        <label class="btn btn-outline-primary" for="btnradio9">30분</label>

                        <input type="radio" class="btn-check" name="btnradio" id="btnradi010" autocomplete="off" value="40">
                        <label class="btn btn-outline-primary" for="btnradi010">40분</label>
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

</main>

</body>
<jsp:include page="/views/footer.jsp" />
</html>