<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
    <style>
        body{
            background-color: #f4f7f6;
            margin-top:20px;
        }
        .file_manager .file a:hover .hover,
        .file_manager .file .file-name small{
            display: block
        }
        .file_manager .file {
            padding: 0 !important
        }

        .file_manager .file .icon{
            text-align: center
        }


        .file_manager .file {
            position: relative;
            border-radius: .55rem;
            overflow: hidden
        }

        .file_manager .file .image,
        .file_manager .file .icon {
            max-height: 180px;
            overflow: hidden;
            background-size: cover;
            background-position: top
        }

        .file_manager .file .hover {
            position: absolute;
            right: 10px;
            top: 10px;
            display: none;
            transition: all 0.2s ease-in-out
        }

        .file_manager .file a:hover .hover {
            transition: all 0.2s ease-in-out
        }

        .file_manager .file .icon {
            padding: 15px 10px;
            display: table;
            width: 100%
        }

        .file_manager .file .icon i {
            display: table-cell;
            font-size: 30px;
            vertical-align: middle;
            color: #777;
            line-height: 100px
        }

        .file_manager .file .file-name {
            padding: 10px;
            border-top: 1px solid #f7f7f7
        }

        .file_manager .file .file-name small .date {
            float: right
        }

        .folder {
            padding: 20px;
            display: block;
            color: #777
        }

        @media only screen and (max-width: 992px) {
            .file_manager .nav-tabs {
                padding-left: 0;
                padding-right: 0
            }
            .file_manager .nav-tabs .nav-item {
                display: inline-block
            }
        }

        .card {
            background: #fff;
            transition: .5s;
            border: 0;
            margin-bottom: 30px;
            border-radius: .55rem;
            position: relative;
            width: 100%;
            box-shadow: 0 1px 2px 0 rgb(0 0 0 / 10%);
        }

        a:hover {
            text-decoration:none;
        }
    </style>

    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />


    <title>메뉴 목록 조회</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <link rel="stylesheet" href="/css/admin.css" type="text/css">
    <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <script type="text/javascript">

        window.onload = function () {
            alert("why? : " + $("tr.ct_list_pop td").find("input[name=menuNo]").val());


            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            // var menuNo = trim($(this.find("input[name=menuNo]").val()));
            $("tr.ct_list_pop td").on("click", function () {
                self.location = "/menu/getMenu?menuNo=" + $("tr.ct_list_pop td").find("input[name=menuNo]").val();
            });

        };


    </script>
</head>

<body bgcolor="#ffffff" text="#000000">

<%--<div style="width:98%; margin-left:10px;">--%>

<%--    <form name="detailForm">--%>
<%--        <table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">--%>
<%--            <tr>--%>
<%--                <td width="15" height="37">--%>
<%--                    <img src="/images/ct_ttl_img01.gif" width="15" height="37">--%>
<%--                </td>--%>
<%--                <td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">--%>
<%--                    <table width="100%" border="0" cellspacing="0" cellpadding="0">--%>
<%--                        <tr>--%>
<%--                            <td width="93%" class="ct_ttl01">--%>
<%--                                메뉴 목록 조회--%>
<%--                            </td>--%>
<%--                        </tr>--%>

<%--                    </table>--%>
<%--                </td>--%>
<%--                <td width="12" height="37">--%>
<%--                    <img src="/images/ct_ttl_img03.gif" width="12" height="37">--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--        </table>--%>


<%--        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">--%>

<%--            <tr>--%>
<%--                <td class="ct_list_b" width="100">no</td>--%>
<%--                <td class="ct_line02"></td>--%>
<%--                <td class="ct_list_b" width="150">메뉴 이름</td>--%>
<%--                <td class="ct_line02"></td>--%>
<%--                <td class="ct_list_b" width="150">메뉴 설명</td>--%>
<%--                <td class="ct_line02"></td>--%>
<%--                <td class="ct_list_b" width="150">메뉴 가격</td>--%>
<%--                <td class="ct_line02"></td>--%>
<%--                <td class="ct_list_b">대표 메뉴 여부</td>--%>
<%--                <td class="ct_line02"></td>--%>
<%--                <td class="ct_list_b">메뉴 이미지</td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td colspan="11" bgcolor="808285" height="1"></td>--%>
<%--            </tr>--%>


<%--            <c:set var="i" value="0"/>--%>
<%--            <c:forEach var="menu" items="${list}">--%>
<%--                <c:set var="i" value="${i+1}"/>--%>
<%--                <tr class="ct_list_pop">--%>
<%--                    <td align="center">--%>

<%--                            ${i}--%>
<%--                    </td>--%>
<%--                    <td></td>--%>

<%--                    <td align="left">--%>

<%--                        <span class="menu">${menu.menuName}--%>
<%--                        <input type="hidden" id="menuNo" name="menuNo" value="${menu.menuNo}"/></span>--%>
<%--                        <span class="menu" hidden="">${menu.menuNo}</span>--%>
<%--                        <span class="menu" hidden="">${menu.menuTruckId}</span>--%>

<%--                    </td>--%>

<%--                    <td></td>--%>
<%--                    <td align="left">--%>

<%--                            ${menu.menuDetail}--%>
<%--                    </td>--%>
<%--                    <td></td>--%>
<%--                    <td align="left">--%>
<%--                            ${menu.menuPrice}--%>
<%--                    </td>--%>
<%--                    <td></td>--%>
<%--                    <td align="left">--%>
<%--                            ${menu.isSigMenu}--%>
<%--                    </td>--%>
<%--                <tr>--%>
<%--                    <td id="${menu.menuImg1}" colspan="11" bgcolor="D6D7D6" height="1"></td>--%>
<%--                </tr>--%>
<%--            </c:forEach>--%>

<%--        </table>--%>

<%--        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">--%>
<%--            <tr>--%>

<%--            </tr>--%>
<%--        </table>--%>
<!--  페이지 Navigator 끝 -->
<%--    </form>--%>
<%--</div>--%>

<%--////////////////////////////////////////////--%>

<div class="row row-cols-1 row-cols-lg-3 align-items-stretch g-4 py-5">
      <div class="col">
<%--        <div class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg" style="background-image: url('');">--%>
          <div class="d-flex flex-column h-100 p-5 pb-3 text-white text-shadow-1">
            <h2 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold">Short title, long jacket</h2>
            <ul class="d-flex list-unstyled mt-auto">
              <li class="me-auto">
                <img src="https://github.com/twbs.png" alt="Bootstrap" width="32" height="32" class="rounded-circle border border-white">
              </li>
              <li class="d-flex align-items-center me-3">
                <svg class="bi me-2" width="1em" height="1em"><use xlink:href="#geo-fill"></use></svg>
                <small>Earth</small>
              </li>
              <li class="d-flex align-items-center">
                <svg class="bi me-2" width="1em" height="1em"><use xlink:href="#calendar3"></use></svg>
                <small>3d</small>
              </li>
            </ul>
          </div>
        </div>
      </div>

      <div class="col">
<%--        <div class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg" style="background-image: url('');">--%>
          <div class="d-flex flex-column h-100 p-5 pb-3 text-white text-shadow-1">
            <h2 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold">Much longer title that wraps to multiple lines</h2>
            <ul class="d-flex list-unstyled mt-auto">
              <li class="me-auto">
                <img src="https://github.com/twbs.png" alt="Bootstrap" width="32" height="32" class="rounded-circle border border-white">
              </li>
              <li class="d-flex align-items-center me-3">
                <svg class="bi me-2" width="1em" height="1em"><use xlink:href="#geo-fill"></use></svg>
                <small>Pakistan</small>
              </li>
              <li class="d-flex align-items-center">
                <svg class="bi me-2" width="1em" height="1em"><use xlink:href="#calendar3"></use></svg>
                <small>4d</small>
              </li>
            </ul>
          </div>
        </div>
      </div>

      <div class="col">
        <div class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg" style="">
          <div class="d-flex flex-column h-100 p-5 pb-3 text-shadow-1">
            <h2 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold">Another longer title belongs here</h2>
            <ul class="d-flex list-unstyled mt-auto">
              <li class="me-auto">
                <img src="https://github.com/twbs.png" alt="Bootstrap" width="32" height="32" class="rounded-circle border border-white">
              </li>
              <li class="d-flex align-items-center me-3">
                <svg class="bi me-2" width="1em" height="1em"><use xlink:href="#geo-fill"></use></svg>
                <small>California</small>
              </li>
              <li class="d-flex align-items-center">
                <svg class="bi me-2" width="1em" height="1em"><use xlink:href="#calendar3"></use></svg>
                <small>5d</small>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>



<%--<div style="width:98%; margin-left:10px;">--%>

<%--    <form name="detailForm">--%>

<%--<div id="main-content" class="file_manager">--%>
<%--    <div class="container">--%>
<%--        <div class="row clearfix">--%>
<%--                            <c:set var="i" value="0"/>--%>
<%--                            <c:forEach var="menu" items="${list}">--%>
<%--                                <c:set var="i" value="${i+1}"/>--%>
<%--            <div class="col-lg-3 col-md-4 col-sm-12">--%>
<%--                <div class="card">--%>
<%--                    <div class="file">--%>
<%--                        <a href="javascript:void(0);">--%>
<%--                            <div class="hover">--%>
<%--                                <button type="button" class="btn btn-icon btn-danger">--%>
<%--                                    <i class="fa fa-trash"></i>--%>
<%--                                </button>--%>
<%--                            </div>--%>
<%--                            <div class="image">--%>
<%--                                <img src="https://via.placeholder.com/280x280/FF69B4/000000" alt="img" class="img-fluid">--%>
<%--                            </div>--%>
<%--                            <div class="file-name">--%>
<%--                                <p class="m-b-5 text-muted">${menu.menuName}</p>--%>
<%--                                <small>${menu.menuPrice} <span class="date text-muted">${menu.menuDetail}</span></small>--%>
<%--                            </div>--%>
<%--                        </a>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--                            </c:forEach>--%>

<%--        </div>--%>

<%--    </div>--%>
<%--</div>--%>
<%--    </form>--%>
<%--</div>--%>



</body>
</html>