<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
    <title>¸®ºä ¸ñ·Ï Á¶È¸</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <link rel="stylesheet" href="/css/admin.css" type="text/css">
    <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <script type="text/javascript">

        window.onload = function() {
            //alert("why? : " + $("tr.ct_list_pop td").find("input[name=menuNo]").val());


            //==> DOM Object GET 3°¡Áö ¹æ¹ý ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            // var menuNo = trim($(this.find("input[name=menuNo]").val()));
            $("tr.ct_list_pop td").on("click", function () {
                self.location = "/review/getReview?rvNo="+$("tr.ct_list_pop td").find("input[name=rvNo]").val();
            });

        };



    </script>
    <style>

        body{margin-top:20px;
            background:#eee;
        }
        .review-list ul li .left span {
            width: 32px;
            height: 32px;
            display: inline-block;
        }
        .review-list ul li .left {
            flex: none;
            max-width: none;
            margin: 0 10px 0 0;
        }
        .review-list ul li .left span img {
            border-radius: 50%;
        }
        .review-list ul li .right h4 {
            font-size: 16px;
            margin: 0;
            display: flex;
        }
        .review-list ul li .right h4 .gig-rating {
            display: flex;
            align-items: center;
            margin-left: 10px;
            color: #ffbf00;
        }
        .review-list ul li .right h4 .gig-rating svg {
            margin: 0 4px 0 0px;
        }
        .country .country-flag {
            width: 16px;
            height: 16px;
            vertical-align: text-bottom;
            margin: 0 7px 0 0px;
            border: 1px solid #fff;
            border-radius: 50px;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
        }
        .country .country-name {
            color: #95979d;
            font-size: 13px;
            font-weight: 600;
        }
        .review-list ul li {
            border-bottom: 1px solid #dadbdd;
            padding: 0 0 30px;
            margin: 0 0 30px;
        }
        .review-list ul li .right {
            flex: auto;
        }
        .review-list ul li .review-description {
            margin: 20px 0 0;
        }
        .review-list ul li .review-description p {
            font-size: 14px;
            margin: 0;
        }
        .review-list ul li .publish {
            font-size: 13px;
            color: #95979d;
        }

        .review-section h4 {
            font-size: 20px;
            color: #222325;
            font-weight: 700;
        }
        .review-section .stars-counters tr .stars-filter.fit-button {
            padding: 6px;
            border: none;
            color: #4a73e8;
            text-align: left;
        }
        .review-section .fit-progressbar-bar .fit-progressbar-background {
            position: relative;
            height: 8px;
            background: #efeff0;
            -webkit-box-flex: 1;
            -ms-flex-positive: 1;
            flex-grow: 1;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
            background-color: #ffffff;
        ;
            border-radius: 999px;
        }
        .review-section .stars-counters tr .star-progress-bar .progress-fill {
            background-color: #ffb33e;
        }
        .review-section .fit-progressbar-bar .progress-fill {
            background: #2cdd9b;
            background-color: rgb(29, 191, 115);
            height: 100%;
            position: absolute;
            left: 0;
            z-index: 1;
            border-radius: 999px;
        }
        .review-section .fit-progressbar-bar {
            display: flex;
            align-items: center;
        }
        .review-section .stars-counters td {
            white-space: nowrap;
        }
        .review-section .stars-counters tr .progress-bar-container {
            width: 100%;
            padding: 0 10px 0 6px;
            margin: auto;
        }
        .ranking h6 {
            font-weight: 600;
            padding-bottom: 16px;
        }
        .ranking li {
            display: flex;
            justify-content: space-between;
            color: #95979d;
            padding-bottom: 8px;
        }
        .review-section .stars-counters td.star-num {
            color: #4a73e8;
        }
        .ranking li>span {
            color: #62646a;
            white-space: nowrap;
            margin-left: 12px;
        }
        .review-section {
            border-bottom: 1px solid #dadbdd;
            padding-bottom: 24px;
            margin-bottom: 34px;
            padding-top: 64px;
        }
        .review-section select, .review-section .select2-container {
            width: 188px !important;
            border-radius: 3px;
        }
        ul, ul li {
            list-style: none;
            margin: 0px;
        }
        .helpful-thumbs, .helpful-thumb {
            display: flex;
            align-items: center;
            font-weight: 700;
        }
    </style>
</head>

<body bgcolor="#ffffff" text="#000000">

<%--<div style="width:98%; margin-left:10px;">--%>

<%--    <form name="detailForm">--%>

<%--        <table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">--%>
<%--            <tr>--%>
<%--                <td width="15" height="37">--%>
<%--                    <img src="/images/ct_ttl_img01.gif" width="15" height="37">--%>
<%--                </td>--%>
<%--                <td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">--%>
<%--                    <table width="100%" border="0" cellspacing="0" cellpadding="0">--%>
<%--                        <tr>--%>
<%--                            <td width="93%" class="ct_ttl01">--%>
<%--                                ¸®ºä ¸ñ·Ï Á¶È¸--%>
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
<%--                <td class="ct_list_b" width="150">¸®ºä ÀÛ¼ºÀÚ</td>--%>
<%--                <td class="ct_line02"></td>--%>
<%--                <td class="ct_list_b" width="150">¸®ºä º°Á¡</td>--%>
<%--                <td class="ct_line02"></td>--%>
<%--                <td class="ct_list_b" width="150">¸Þ´º ³»¿ë</td>--%>
<%--                <td class="ct_line02"></td>--%>
<%--                <td class="ct_list_b">»çÀå´Ô ´ñ±Û</td>--%>
<%--                <td class="ct_line02"></td>--%>
<%--                <td class="ct_list_b">¸®ºä ÀÌ¹ÌÁö</td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td colspan="11" bgcolor="808285" height="1"></td>--%>
<%--            </tr>--%>


<%--            <c:set var="i" value="0"/>--%>
<%--            <c:forEach var="review" items="${list}">--%>
<%--                <c:set var="i" value="${i+1}" />--%>
<%--                <tr class="ct_list_pop">--%>
<%--                    <td align="center">--%>

<%--                            ${i}--%>
<%--                    </td>--%>
<%--                    <td></td>--%>

<%--                    <td align="left">--%>

<%--                        <span class="review">${review.rvUserId}--%>
<%--                        <input type="hidden" id="rvNo" name="rvNo" value="${review.rvNo}"/></span>--%>
<%--&lt;%&ndash;                        <span class="review" hidden="">${review.menuNo}</span>&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <span class="review" hidden="">${review.menuTruckId}</span>&ndash;%&gt;--%>

<%--                    </td>--%>

<%--                    <td></td>--%>
<%--                    <td align="left">--%>

<%--                            ${review.rvStar}--%>
<%--                    </td>--%>
<%--                    <td></td>--%>
<%--                    <td align="left">--%>
<%--                            ${review.rvContent}--%>
<%--                    </td>--%>
<%--                    <td></td>--%>
<%--                    <td align="left">--%>
<%--                            ${review.rvTruckCmtContent}--%>
<%--                    </td>--%>
<%--                <tr>--%>
<%--                    <td id="${review.rvImg1}" colspan="11" bgcolor="D6D7D6" height="1"></td>--%>
<%--                </tr>--%>
<%--            </c:forEach>--%>

<%--        </table>--%>

<%--        <table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">--%>
<%--            <tr>--%>

<%--            </tr>--%>
<%--        </table>--%>
<%--        <!--  ÆäÀÌÁö Navigator ³¡ -->--%>
<%--    </form>--%>
<%--</div>--%>

<div class="container">
    <div id="reviews" class="review-section">
        <div class="d-flex align-items-center justify-content-between mb-4">
            <h4 class="m-0">${resultPage.totalCount} Reviews(Æò±Õ ${rvAvg})</h4>


        </div>


        </div>
    </div>

    <div class="review-list">
        <ul>
            <li>
<%--                <div class="d-flex">--%>
<%--                    <div class="left">--%>
<%--                        <span>--%>
<%--&lt;%&ndash;                            <img src="https://bootdey.com/img/Content/avatar/avatar1.png" class="profile-pict-img img-fluid" alt="" />&ndash;%&gt;--%>
<%--                        </span>--%>
<%--                    </div>--%>
<%--                    <div class="right">--%>
<%--                        <h4>--%>
<%--                            Askbootstrap--%>
<%--                            <span class="gig-rating text-body-2">--%>
<%--                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1792 1792" width="15" height="15">--%>
<%--                                    <path--%>
<%--                                            fill="currentColor"--%>
<%--                                            d="M1728 647q0 22-26 48l-363 354 86 500q1 7 1 20 0 21-10.5 35.5t-30.5 14.5q-19 0-40-12l-449-236-449 236q-22 12-40 12-21 0-31.5-14.5t-10.5-35.5q0-6 2-20l86-500-364-354q-25-27-25-48 0-37 56-46l502-73 225-455q19-41 49-41t49 41l225 455 502 73q56 9 56 46z"--%>
<%--                                    ></path>--%>
<%--                                </svg>--%>
<%--                                5.0--%>
<%--                            </span>--%>
<%--                        </h4>--%>
<%--                        <div class="country d-flex align-items-center">--%>
<%--                            <span>--%>
<%--                                <img class="country-flag img-fluid" src="https://bootdey.com/img/Content/avatar/avatar6.png" />--%>
<%--                            </span>--%>

<%--                        </div>--%>
<%--                        <div class="review-description">--%>
<%--                            <p>--%>
<%--                                The process was smooth, after providing the required info, Pragyesh sent me an outstanding packet of wireframes. Thank you a lot!--%>
<%--                            </p>--%>
<%--                        </div>--%>

<%--                        <div class="response-item mt-4 d-flex">--%>
<%--                            <div class="left">--%>
<%--                                <span>--%>
<%--&lt;%&ndash;                                    <img src="https://bootdey.com/img/Content/avatar/avatar2.png" class="profile-pict-img img-fluid" alt="" />&ndash;%&gt;--%>
<%--                                </span>--%>
<%--                            </div>--%>
<%--                            <div class="right">--%>
<%--                                <h4>--%>
<%--                                    Gurdeep Osahan--%>
<%--                                    <span class="gig-rating text-body-2">--%>
<%--                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1792 1792" width="15" height="15">--%>
<%--                                            <path--%>
<%--                                                    fill="currentColor"--%>
<%--                                                    d="M1728 647q0 22-26 48l-363 354 86 500q1 7 1 20 0 21-10.5 35.5t-30.5 14.5q-19 0-40-12l-449-236-449 236q-22 12-40 12-21 0-31.5-14.5t-10.5-35.5q0-6 2-20l86-500-364-354q-25-27-25-48 0-37 56-46l502-73 225-455q19-41 49-41t49 41l225 455 502 73q56 9 56 46z"--%>
<%--                                            ></path>--%>
<%--                                        </svg>--%>
<%--                                        5.0--%>
<%--                                    </span>--%>
<%--                                </h4>--%>
<%--                                <div class="country d-flex align-items-center">--%>
<%--                                    <span>--%>
<%--                                        <img class="country-flag img-fluid" src="https://bootdey.com/img/Content/avatar/avatar3.png" />--%>
<%--                                    </span>--%>

<%--                                </div>--%>
<%--                                <div class="review-description">--%>
<%--                                    <p>--%>
<%--                                        The process was smooth, after providing the required info, Pragyesh sent me an outstanding packet of wireframes. Thank you a lot!--%>
<%--                                    </p>--%>
<%--                                </div>--%>

<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
                <div class="d-flex">
                  <c:set var="i" value="0"/>
                    <c:forEach var="review" items="${list}">
                        <div class="response-item mt-4 d-flex">
                            <div class="left">
                                <span>
                                        <%--                                    <img src="https://bootdey.com/img/Content/avatar/avatar2.png" class="profile-pict-img img-fluid" alt="" />--%>
                                </span>
                            </div>
                            <div class="right">
                                <h4>
                                    ${review.rvUserId}
                                    <span class="gig-rating text-body-2">
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1792 1792" width="15" height="15">
                                            <path
                                                    fill="currentColor"
                                                    d="M1728 647q0 22-26 48l-363 354 86 500q1 7 1 20 0 21-10.5 35.5t-30.5 14.5q-19 0-40-12l-449-236-449 236q-22 12-40 12-21 0-31.5-14.5t-10.5-35.5q0-6 2-20l86-500-364-354q-25-27-25-48 0-37 56-46l502-73 225-455q19-41 49-41t49 41l225 455 502 73q56 9 56 46z"
                                            ></path>
                                        </svg>
                                        ${review.rvStar}
                                    </span>
                                </h4>
                                <div class="country d-flex align-items-center">
                                    <span>
                                        <img class="country-flag img-fluid" src="https://bootdey.com/img/Content/avatar/avatar3.png" />
                                    </span>

                                </div>
                                <div class="review-description">
                                    <p>
                                        ${review.rvContent}
                                    </p>
                                </div>

                            </div>
                        </div>
                    </c:forEach>


                    </div>

            </li>
        </ul>
    </div>
</div>

</body>
</html>