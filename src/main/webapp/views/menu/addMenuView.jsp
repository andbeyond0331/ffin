<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>메뉴 추가</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstㅔ개rap.min.css">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">

    <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
    <script type="text/javascript">

        $(function(){

            $('input:button').click(function(){

                var type = $(this).val();
                console.log(type);
                var number =  $('#total').val();
                console.log(number);
                if(type === '+') {
                    number = parseInt(number) + 1;
                    if(number >= parseInt(${product.prodTotal}) ){
                        number = parseInt(${product.prodTotal})
                    }
                }else if(type === '-')  {
                    number = parseInt(number) - 1;
                    if(number<=0)
                        number = 0;
                }
                // 결과 출력
                console.log(number);
                $('#total').val(number);
            });

            $('.btn-default:contains("옵션그룹 추가")').attr('href','/purchase/addPurchaseCart?prodNo='+${product.prodNo});

            $("#datepicker").on("click",function(){
                $("#datepicker").datepicker({
                    minDate: "+1D",
                    maxDate: "+1M +10D",
                    dateFormat : "yy/mm/dd"
                });
            });
        });
    </script>

    <style>
        body{
            padding-top:70px;
        }
    </style>

</head>
<body>
<%--<jsp:include page="../header.jsp"></jsp:include>--%>
<div class="container">

    <div class="py-5 text-center">
        <h2>메뉴 추가 페이지</h2>
        <p class="lead">메뉴 정보를 입력해 주세요.</p>
    </div>

    <div class="row g-5">
        <div class="col-md-5 col-lg-4 order-md-last">
            <h4 class="d-flex justify-content-between align-items-center mb-3">
                <span class="text-primary">메뉴 정보</span>
                <span class="badge bg-primary rounded-pill">1</span>
            </h4>
            <ul class="list-group mb-3">
                <li class="list-group-item d-flex justify-content-between bg-light">
                    <div class="text-success">
                        <h6 class="my-0">푸드트럭 상호</h6>
                        <small>NO.${truck.truckId}</small>
                    </div>
                    <span class="text-success"></span>
                </li>
               <%-- <li class="list-group-item d-flex justify-content-between lh-sm">
                    <div>
                        <h6 class="my-0">메뉴 이름</h6>
                        <small class="text-muted">${menu.menuName}</small>
                    </div>
                    <span class="text-muted"></span>
                </li>
                <li class="list-group-item d-flex justify-content-between lh-sm">
                    <div>
                        <h6 class="my-0">메뉴 가격</h6>
                        <small class="text-muted">${menu.menuPrice}</small>
                    </div>
                    <span class="text-muted"></span>
                </li>
                <li class="list-group-item d-flex justify-content-between lh-sm">
                    <div>
                        <h6 class="my-0">메뉴 설명</h6>
                        <small class="text-muted">${menu.menuDetail}</small>
                    </div>
                    <span class="text-muted"></span>
                </li>--%>
                <!--추후 여기에 대표메뉴 여부 버튼 추가-->
                <!-- 아래는 한 번에 여러 이미지 받는 폼 검색해서 추가하기-->
              <%--  <li class="list-group-item d-flex justify-content-between lh-sm">
                    <div>
                        <h6 class="my-0">메뉴 이미지 1</h6>
                        <small class="text-muted">
                            <img src="../images/uploadFiles/${menu.menuImg1}" width="300px" height="300px">
                        </small>
                    </div>
                    <span class="text-muted"></span>
                </li>--%>

            </ul>

            <form class="card p-2">
                <div class="input-group">
                    <a href="" class="btn btn-default" role="button">옵션 그룹 추가</a>
                </div>
            </form>
        </div>
        <div class="col-md-7 col-lg-8">
            <form class="needs-validation" method="POST" action="/purchase/addPurchase">
                <div class="my-3">
                    <hr class="my-4">
                    <div class="col-12">
                        <%--@declare id="menuname"--%><label for="menuName" class="form-label">메뉴 이름</label>
                        <div class="input-group has-validation">
                            <input type="text" class="form-control" name="menuName" value="${menu.menuName}" >
                        </div>
                    </div>

                    <div class="col-12">
                        <%--@declare id="menuprice"--%><label for="menuPrice" class="form-label">메뉴 가격<span class="text-muted"></span></label>
                        <div class="input-group has-validation">
                            <input type="text" class="form-control" name="menuPrice" value="${menu.menuPrice }">
                        </div>
                    </div>

                    <div class="col-12">
                        <%--@declare id="menudetail"--%><label for="menuDetail" class="form-label">메뉴 설명</label>
                        <input type="text" class="form-control" name="divyAddr" value="${ empty user.addr || user.addr eq 'null' ? '' : user.addr }">
                    </div>


                </div>


                <hr class="my-4">

                <button class="w-100 btn btn-default btn-lg" type="submit">추가하기</button>
                <input type="hidden" name="menuTruckId" value="${menu.menuTruckId}">
            </form>
        </div>
    </div>
</div>
</body>
</html>

</body>
</html>