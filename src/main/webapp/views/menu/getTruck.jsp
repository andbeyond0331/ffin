<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Bootstrap Example</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<div class="container mt-3">
    <h2>Card Image</h2>
    <p>Image at the top (card-img-top):</p>

                <c:set var="i" value="0"/>
                <c:forEach var="menu" items="${list}">
                    <c:set var="i" value="${i+1}"/>
    <div class="card" style="width:400px">
        <img class="card-img-top" src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMDExMjhfMTg4%2FMDAxNjA2NDk3MTczMzM2.riqYHvwFgthRWLyNZRpmS_kowH0bKLdFJKwYjRn5TWsg.dkRa5rWPtUwKH2XUdWfA5FOhrIZi16vtisfGy8-FqBwg.JPEG.djaalswl5356%2FIMG_0438.jpg&type=sc960_832" alt="Card image" style="width:100%">
        <div class="card-body">
            <h4 class="card-title">${menu.menuName}</h4>
            <p class="card-text">${menu.menuDetail}</p>
            <a href="#" class="btn btn-primary">장바구니에 담기</a>
        </div>
    </div>
    <br>
                </c:forEach>

    <p>Image at the bottom (card-img-bottom):</p>
    <div class="card" style="width:400px">
        <div class="card-body">
            <h4 class="card-title">Jane Doe</h4>
            <p class="card-text">Some example text some example text. Jane Doe is an architect and engineer</p>
            <a href="#" class="btn btn-primary">See Profile</a>
        </div>
        <img class="card-img-bottom" src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAxNzA5MDlfNTYg%2FMDAxNTA0OTI5MDg5MDQ5.glzVvaUUF1Mlx1xINUlgkpVu8ot9PjoQiTNY1RpJOUQg.YVLpz_ucQ_idz8jo5feSHItLU1xw9rGRlqrlcwkxSwsg.JPEG.star3012777%2F5.jpg&type=sc960_832" alt="Card image" style="width:100%">
    </div>
</div>

</body>
</html>


<%--<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">--%>
<%--<%@ page contentType="text/html; charset=euc-kr" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<html>--%>
<%--<head>--%>

<%--    <title>메뉴 목록이양</title>--%>

<%--    <meta charset="EUC-KR">--%>

<%--    <meta name="viewport" content="width=device-width, initial-scale=1">--%>

<%--    <!-- Latest compiled and minified CSS -->--%>
<%--    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">--%>
<%--    <!-- Optional theme -->--%>
<%--    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">--%>
<%--    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>--%>
<%--    <!-- Latest compiled and minified JavaScript -->--%>
<%--    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>
<%--    <!-- <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script> -->--%>
<%--    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>--%>
<%--    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">--%>

<%--    <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>--%>
<%--    <script type="text/javascript">--%>
<%--        $(function(){--%>

<%--            $.ajax(--%>
<%--                {--%>
<%--                    url : "/product/rest/listProduct/search",--%>
<%--                    method : "POST",--%>
<%--                    headers : {--%>
<%--                        "Accept" : "application/json",--%>
<%--                        "Content-Type" : "application/json"--%>
<%--                    },--%>
<%--                    dataType : "json",--%>
<%--                    data : JSON.stringify({--%>
<%--                        currentPage : 1--%>
<%--                    }),--%>
<%--                    success : function(JSONData,status){--%>
<%--                        console.log(JSONData);--%>
<%--                        var list = JSONData.list;--%>
<%--                        for(var i=0; i<4; i++){--%>

<%--                            var temp = list[i];--%>
<%--                            console.log(temp.fileName);--%>

<%--                            $($('.image')[i]).attr('src','/images/uploadFiles/'+temp.fileName);--%>
<%--                            $($('.prodName')[i]).text(temp.prodName);--%>
<%--                            $($('.price')[i]).text(temp.price+"원");--%>
<%--                            $($('.prodDetail')[i]).text(temp.prodDetail);--%>
<%--                            $($('.btn-success:contains("구매")')[i]).attr('href','/purchase/addPurchaseView?prodNo='+temp.prodNo);--%>
<%--                            $($('.btn-default:contains("장바구니")')[i]).attr('href','/purchase/addPurchaseCart?prodNo='+temp.prodNo);--%>
<%--                        }--%>
<%--                    }--%>
<%--                });--%>

<%--            $.ajax(--%>
<%--                {--%>
<%--                    url : "/product/rest/listProduct/search",--%>
<%--                    method : "POST",--%>
<%--                    headers : {--%>
<%--                        "Accept" : "application/json",--%>
<%--                        "Content-Type" : "application/json"--%>
<%--                    },--%>
<%--                    dataType : "json",--%>
<%--                    data : JSON.stringify({--%>
<%--                        currentPage : 2--%>
<%--                    }),--%>
<%--                    success : function(JSONData,status){--%>
<%--                        console.log(JSONData);--%>
<%--                        var list = JSONData.list;--%>
<%--                        for(var i=4; i<8; i++){--%>

<%--                            var temp = list[i-4];--%>
<%--                            console.log(temp.fileName);--%>

<%--                            $($('.image')[i]).attr('src','/images/uploadFiles/'+temp.fileName);--%>
<%--                            $($('.prodName')[i]).text(temp.prodName);--%>
<%--                            $($('.price')[i]).text(temp.price+"원");--%>
<%--                            $($('.prodDetail')[i]).text(temp.prodDetail);--%>
<%--                            $($('.btn-success:contains("구매")')[i]).attr('href','/purchase/addPurchaseView?prodNo='+temp.prodNo);--%>
<%--                            $($('.btn-default:contains("장바구니")')[i]).attr('href','/purchase/addPurchaseCart?prodNo='+temp.prodNo);--%>
<%--                        }--%>
<%--                    }--%>
<%--                });--%>

<%--            $('input[name="searchKeyword"]').keyup(function(){--%>
<%--                var searchKeyword = $(this).val();--%>

<%--                $.ajax(--%>
<%--                    {--%>
<%--                        url : "/product/rest/productAutoComplete/"+searchKeyword+"/1",--%>
<%--                        method : "GET",--%>
<%--                        headers : {--%>
<%--                            "Accept" : "application/json",--%>
<%--                            "Content-Type" : "application/json"--%>
<%--                        },--%>
<%--                        dataType:"json",--%>
<%--                        success : function(JSONData,status){--%>
<%--                            var availableTags = JSONData;--%>
<%--                            console.log(JSONData);--%>
<%--                            $(function(){--%>
<%--                                $('input[name="searchKeyword"]').autocomplete({--%>
<%--                                    source: availableTags--%>
<%--                                });--%>
<%--                            });--%>
<%--                        },--%>
<%--                    });--%>

<%--            });--%>

<%--            $('.searchContainer').css('margin','50px');--%>

<%--            $('.search').css('display','flex');--%>

<%--            $('.thumbnail-container').css('margin','90px');--%>

<%--        });--%>

<%--        var page = 2;--%>
<%--        var isflag = true;--%>
<%--        $(window).scroll(function(e) {--%>

<%--            if (isflag && $(window).scrollTop() == $(document).height() - $(window).height()) {--%>
<%--                page += 1;--%>
<%--                console.log(page)--%>
<%--                $.ajax(--%>
<%--                    {--%>
<%--                        url : "/product/rest/listProduct/search",--%>
<%--                        method : "POST",--%>
<%--                        headers : {--%>
<%--                            "Accept" : "application/json",--%>
<%--                            "Content-Type" : "application/json"--%>
<%--                        },--%>
<%--                        dataType : "json",--%>
<%--                        data : JSON.stringify({--%>
<%--                            currentPage : page--%>
<%--                        }),--%>
<%--                        success : function(JSONData,status){--%>
<%--                            console.log('JSONData'+JSONData);--%>

<%--                            var str = "";--%>
<%--                            var list = JSONData.list;--%>
<%--                            for(var i=0; i<4; i++){--%>

<%--                                var temp = list[i];--%>
<%--                                console.log(temp);--%>
<%--                                if(list[i] == undefined){--%>
<%--                                    console.log('실행');--%>
<%--                                    isflag = false;--%>
<%--                                    break;--%>
<%--                                }--%>
<%--                                var stringHtml =--%>
<%--                                    '<div class="col-sm-6 col-md-3">'--%>
<%--                                    +'<div class="thumbnail">'--%>
<%--                                    +'<img class="image" src="/images/uploadFiles/'+temp.fileName+'" border="0px" width="240px" height="180px">'--%>
<%--                                    +'<div class="caption">'--%>
<%--                                    +'<h3 class="prodName">'+temp.prodName+'</h3>'--%>
<%--                                    +'<h4 class="price">'+temp.price+'</h4>'--%>
<%--                                    +'<p class="prodDetail">'+temp.prodDetail+'</p>'--%>
<%--                                    +'<p><a href="/purchase/addPurchaseView?prodNo='+temp.prodNo+'" class="btn btn-success" role="button">구매</a> <a href="/purchase/addPurchaseCart?prodNo='+temp.prodNo+'" class="btn btn-default" role="button">장바구니</a></p>'--%>
<%--                                    +'</div></div></div>';--%>
<%--                                str += stringHtml;--%>


<%--                            }--%>

<%--                            $('form').append('<div class="container-fluid" style="margin: 90px;"><div class="row"><div class="col-md-1"></div><div class="col-md-10"><div class="row">'--%>
<%--                                + str + '</div></div><div class="col-md-1"></div></div></div>');--%>
<%--                        }--%>
<%--                    });--%>
<%--            }--%>

<%--        });--%>

<%--    </script>--%>

<%--    <style>--%>
<%--        body{--%>
<%--            padding-top:70px;--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<form>--%>


<%--    <div class="container-fluid searchContainer">--%>
<%--        <div class="row">--%>
<%--            <div class="col-md-3"></div>--%>
<%--            <div class="col-md-6">--%>
<%--                <div class="form-group form-group-lg search">--%>
<%--                    <input class="form-control" type="text" id="formGroupInputLarge" name="searchKeyword" placeholder="SearchKeyword...">--%>
<%--                    <button type="button" class="btn btn-default">--%>
<%--                        <span class="glyphicon glyphicon-search"></span>--%>
<%--                    </button>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="col-md-3"></div>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <div class="container-fluid thumbnail-container">--%>
<%--        <div class="row">--%>
<%--            <div class="col-md-1"></div>--%>
<%--            <div class="col-md-10">--%>
<%--                <div class="row">--%>
<%--                    <c:forEach begin="0" end="3" step="1">--%>
<%--                        <div class="col-sm-6 col-md-3">--%>
<%--                            <div class="thumbnail">--%>
<%--                                <img class="image" src="" border="0px" width="200px" height="200px">--%>
<%--                                <div class="caption">--%>
<%--                                    <h3 class="menuName"></h3>--%>
<%--                                    <h4 class="menuPrice"></h4>--%>
<%--                                    <p class="menuDetail"></p>--%>

<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </c:forEach>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="col-md-1"></div>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <div class="container-fluid thumbnail-container">--%>
<%--        <div class="row">--%>
<%--            <div class="col-md-1"></div>--%>
<%--            <div class="col-md-10">--%>
<%--                <div class="row">--%>
<%--                    <c:forEach begin="0" end="3" step="1">--%>
<%--                        <div class="col-sm-6 col-md-3">--%>
<%--                            <div class="thumbnail">--%>
<%--                                <img class="image" src="" border="0px" width="240px" height="240px">--%>
<%--                                <div class="caption">--%>
<%--                                    <h3 class="menuName"></h3>--%>
<%--                                    <h4 class="menuPrice"></h4>--%>
<%--                                    <p class="menuDetail"></p>--%>

<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </c:forEach>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="col-md-1"></div>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--</form>--%>
<%--</body>--%>
<%--</html>--%>