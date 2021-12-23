<%@ page contentType="text/html;charset=UTF-8" language="java"   pageEncoding="UTF-8"%>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script
        src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>


<script type="text/javascript">
    $(function () {
        $(window).scroll(function () { //브라우저에 스크롤이 발생하는 순간부터
            var curpos = $(window).scrollTop()+20; //스크롤바의 상단 위치값+20 보관
            $(".sky").stop().animate({"top":curpos}); //스카이메뉴의 상단위치값 애니
        });
    });

    $(function() {
        $("button.btn-primary:contains('확정')").click(function() {
            $("form").attr("method","POST").attr("action","/purchase/addCart").submit();
        });
    });


</script>
<style type="text/css">
    * {
        padding:0;
        margin:0;
    }
    .box {
        position:relative;
        width:400px;
        margin:auto;
        background:#ccc;
        height:3000px;
    }
    .sky {
        position:absolute;
        width:200px;
        left:200%;
        top:20px;
        background: #b47f7f;
        height:200px;
    }
</style>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="box">
    <p class="sky">



<form>
        <table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="15" height="37">
                    <img src="/images/ct_ttl_img01.gif"  width="15" height="37"/>
                </td>
                <td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="93%" class="ct_ttl01">구매정보수정</td>
                            <td width="20%" align="right">&nbsp;</td>
                        </tr>
                    </table>
                </td>
                <td width="12" height="37">
                    <img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
                </td>
            </tr>
        </table>
        <input type="hidden" name="odMenuName" value="${cart.odMenuName}" />
        <table width="600" border="0" cellspacing="0" cellpadding="0"	align="center" style="margin-top: 13px;">
            <tr>
                <td height="1" colspan="3" bgcolor="D6D6D6"></td>
            </tr>
            <tr>
                <td width="104" class="ct_write">구매자아이디</td>
                <td bgcolor="D6D6D6" width="1"></td>
                <td class="ct_write01">${cart.odOptionGroupName}</td>

                <input type="hidden" name="odOptionName" value="${cart.odOptionName}">

            </tr>
            <tr>
                <td height="1" colspan="3" bgcolor="D6D6D6"></td>
            </tr>
            <tr>
                <td width="104" class="ct_write">구매방법${cart.odMenuQty}</td>
                <td bgcolor="D6D6D6" width="1"></td>
                <td class="ct_write01">

                </td>
            </tr>
            <tr>
                <td height="1" colspan="3" bgcolor="D6D6D6"></td>
            </tr>
            <tr>
                <td width="104" class="ct_write">구매자이름</td>
                <td bgcolor="D6D6D6" width="1"></td>
                <td class="ct_write01">
                    <input 	type="text" name="odMenuQtyFlag" 	class="ct_input_g" style="width: 100px; height: 19px"
                              maxLength="20" value="${cart.odMenuQtyFlag}" />
                </td>
            </tr>
            <tr>
                <td height="1" colspan="3" bgcolor="D6D6D6"></td>
            </tr>
            <tr>
                <td width="104" class="ct_write">구매자 연락처</td>
                <td bgcolor="D6D6D6" width="1"></td>
                <td class="ct_write01">
                    <input 	type="text" name="odMenuPrice" class="ct_input_g" style="width: 100px; height: 19px"
                              maxLength="20" value="${cart.odMenuPrice}" />
                </td>
            </tr>

            <tr>
                <td height="1" colspan="3" bgcolor="D6D6D6"></td>
            </tr>
            <tr>
                <td width="104" class="ct_write">구매자주소</td>
                <td bgcolor="D6D6D6" width="1"></td>
                <td class="ct_write01">
                    <input 	type="text" name="odMenuImage" class="ct_input_g" style="width: 100px; height: 19px"
                              maxLength="20" value="${cart.odMenuImage}" />
                </td>
            </tr>
            <tr>
                <td height="1" colspan="3" bgcolor="D6D6D6"></td>
            </tr>
            <tr>
                <td width="104" class="ct_write">구매요청사항</td>
                <td bgcolor="D6D6D6" width="1"></td>
                <td class="ct_write01">
                    <input 	type="text" name="odOptionPrice" 	class="ct_input_g" style="width: 100px; height: 19px"
                              maxLength="20" value="${cart.odOptionPrice}" />
                </td>
            </tr>
            <tr>
                <td height="1" colspan="3" bgcolor="D6D6D6"></td>
            </tr>
            <tr>
                <td height="1" colspan="3" bgcolor="D6D6D6"></td>
            </tr>
        </table>

        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
            <tr>
                <td width="53%"></td>
                <td align="right">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="17" height="23">
                                <img src="/images/ct_btnbg01.gif" width="17" height="23"/>
                            </td>
                            <td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
                                <!-- <input type="submit" value="수정"/> -->확인
                            </td>
                            <td background="/images/ct_btnbg02.gif" class="ct_btn01"
                                style="padding-top: 3px;">
                                <!-- <a href="javascript:fncAddPurchase();">구매</a> -->구매
                            </td>
                            <button type="button" class="btn btn-primary">확정</button>
                            <td width="14" height="23">
                                <img src="/images/ct_btnbg03.gif" width="14" height="23"/>
                            </td>
                            <td width="30"></td>
                            <td width="17" height="23">
                                <img src="/images/ct_btnbg01.gif" width="17" height="23"/>
                            </td>
                            <td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
                                <!-- <a href="javascript:history.go(-1)">취소</a> -->취소
                            </td>
                            <td width="14" height="23">
                                <img src="/images/ct_btnbg03.gif" width="14" height="23"/>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

</form>

    </p>
</div>
</body>
</html>
