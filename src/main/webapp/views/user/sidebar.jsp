<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>

<style>

    *{
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: "Noto Sans CJK KR Regular", sans-serif;
    }
/*    .sidebar-body{
        min-height: 80vh;
        background-color: #ecf0fd;
    }*/
    .sidebar-div{
        position: fixed;
        top: 130px;
        left: 20px;
        bottom: 20px;
        width: 0px;
        box-sizing: content-box;
        border-radius: 10px;
        /*border-left: 5px solid #ffffff;
        background-color: #ffe537;*/
        transition: width 0.2s;
        overflow-x: hidden;
        height: auto;
    }
    .sidebar-div.active{
        width: 180px;
    }
    .sidebar-div ul{
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        padding-left: 5px;
        padding-top: 40px;
        padding-bottom: 40px;
    }
    .sidebar-div ul li{
        position: relative;
        list-style: none;
        width: 100%;
        border-radius: 10px;
        /*border-top-left-radius: 20px;
        border-bottom-left-radius: 20px;*/
    }
    .sidebar-div ul li.active{
        background: #ffe537;
    }
    .sidebar-div ul li b:nth-child(1){
        position: absolute;
        top: -20px;
        height: 20px;
        width: 100%;
        /*background: #ffffff;*/
        display: none;
    }
    .sidebar-div ul li b:nth-child(1)::before{
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        border-bottom-right-radius: 20px;
        /*background: #ffffff;*/
    }
    .sidebar-div ul li b:nth-child(2){
        position: absolute;
        bottom: -20px;
        height: 20px;
        width: 100%;
        /*background: #ffffff;*/
        display: none;
    }
    .sidebar-div ul li b:nth-child(2)::before{
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        border-top-right-radius: 20px;
        /*background: #ffffff;*/
    }
    .sidebar-div ul li.active b:nth-child(1),
    .sidebar-div ul li.active b:nth-child(2){
        display: block;
    }
    .sidebar-div ul li a{
        position: relative;
        display: block;
        width: 100%;
        display: flex;
        text-decoration: none;
        color: #110000;
    }
    .sidebar-div ul li.active a{
        color: #ffffff;
    }
    .sidebar-div ul li a .icon{
        position: relative;
        display: list-item;
        min-width: 60px;
        height: 60px;
        line-height:70px;
        text-align: center;
    }
    .sidebar-div ul li a .icon ion-icon{
        font-size: 1.5em;
    }
    .sidebar-div ul li a .title{
        position: relative;
        display: block;
        padding-left: 10px;
        height: 60px;
        line-height: 60px;
        white-space: normal;
    }
    .sidebar-toggle{
        position: relative;
        top: 100px;
        left: 35px;
        /*right: 20px;*/
        width: 40px;
        height: 40px;
        /*background: #ffe537;*/
        border-radius: 10px;
        cursor: pointer;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .sidebar-toggle.active{
        /*background: #ffba49;*/
    }
    .sidebar-toggle ion-icon{
        position: absolute;
        color: #ffba49;
        font-size: 30px;
        display: none;
    }
    .sidebar-toggle.active ion-icon{
        color: #ffba49;
    }
    .sidebar-toggle .fas.fa-angle-double-right,
    .sidebar-toggle.active .fas.fa-angle-double-left{
        display: block;
    }
    .sidebar-toggle .fas.fa-angle-double-left,
    .sidebar-toggle.active .fas.fa-angle-double-right{
        display: none;
    }
    .toggle-btn{
        padding: 0;
    }
    #collapseInfo div a, #collapsePurchase div a, #collapseHeart div a,
    #collapsePost div a, #collapseQnAUser div a, #collapseUser div a,
    #collapseTruck div a, #collapseApp div a, #collapseQnAAdmin div a,
    #collapseInfoT div a ,#collapseSale div a, #collapsePostT div a{
        color: #110000;
        padding: 0 0 0 20px;
        margin: 5px 0 5px 0;
    }
    #collapseInfo div a:hover, #collapsePurchase div a:hover, #collapseHeart div a:hover,
    #collapsePost div a:hover, #collapseQnAUser div a:hover, #collapseUser div a:hover,
    #collapseTruck div a:hover, #collapseApp div a:hover, #collapseQnAAdmin div a:hover,
    #collapseInfoT div a:hover ,#collapseSale div a:hover, #collapsePostT div a:hover{
        color: #ffba49;
    }


</style>


<!-- sidebar -->
<div class="navigation sidebar-div">

    <c:choose>

        <%-- User --%>
        <c:when test="${sessionScope.role eq 'user'}">
            <ul class="sidebar-user">
                <li class="list active">
                    <b></b>
                    <b></b>
                    <a href="#">
                        <span class="icon"><ion-icon name="home-outline"></ion-icon></span>
                        <span class="title">MyPage</span>
                    </a>
                </li>
                <li class="list">
                    <b></b>
                    <b></b>
                    <a class="btn toggle-btn" role="button" data-target="#collapseInfo" data-toggle="collapse" href="#collapseInfo" aria-expanded="false" aria-controls="collapseExample">
                        <span class="icon"><ion-icon name="person-circle-outline"></ion-icon></span>
                        <span class="title">내정보</span>
                    </a>
                    <div class="collapse" id="collapseInfo" style="padding: 10px;">
                        <div class="bg-white py-2 collapse-inner rounded">
                            <a class="collapse-item" href="">내정보</a>
                            <a class="collapse-item" href="">프로필</a>
                            <a class="collapse-item" href="">비밀번호</a>
                        </div>
                    </div>
                </li>
                <li class="list">
                    <b></b>
                    <b></b>
                    <a href="#">
                        <span class="icon"><ion-icon name="chatbubbles-outline"></ion-icon></span>
                        <span class="title">채팅</span>
                    </a>
                </li>
                <li class="list">
                    <b></b>
                    <b></b>
                    <a class="btn toggle-btn" role="button" data-target="#collapsePurchase" data-toggle="collapse" href="#collapsePurchase" aria-expanded="false" aria-controls="collapseExample">
                        <span class="icon"><ion-icon name="cart-outline"></ion-icon></span>
                        <span class="title">구매</span>
                    </a>
                    <div class="collapse" id="collapsePurchase" style="padding: 10px;">
                        <div class="bg-white py-2 collapse-inner rounded">
                            <a class="collapse-item" href="">구매내역</a>
                            <a class="collapse-item" href="">환불내역</a>
                            <a class="collapse-item" href="">적립금</a>
                            <a class="collapse-item" href="">쿠폰</a>
                        </div>
                    </div>
                </li>
                <li class="list">
                    <b></b>
                    <b></b>
                    <a class="btn toggle-btn" role="button" data-target="#collapseHeart" data-toggle="collapse" href="#collapseHeart" aria-expanded="false" aria-controls="collapseExample">
                        <span class="icon"><ion-icon name="heart-outline"></ion-icon></span>
                        <span class="title">좋아요</span>
                    </a>
                    <div class="collapse" id="collapseHeart" style="padding: 10px;">
                        <div class="bg-white py-2 collapse-inner rounded">
                            <a class="collapse-item" href="">푸드트럭</a>
                            <a class="collapse-item" href="">게시글</a>
                        </div>
                    </div>
                </li>
                <li class="list">
                    <b></b>
                    <b></b>
                    <a href="#">
                        <span class="icon"><ion-icon name="star-half-outline"></ion-icon></span>
                        <span class="title">리뷰</span>
                    </a>
                </li>
                <li class="list">
                    <b></b>
                    <b></b>
                    <a class="btn toggle-btn" role="button" data-target="#collapsePost" data-toggle="collapse" href="#collapsePost" aria-expanded="false" aria-controls="collapseExample">
                        <span class="icon"><ion-icon name="reader-outline"></ion-icon></span>
                        <span class="title">글•댓글</span>
                    </a>
                    <div class="collapse" id="collapsePost" style="padding: 10px;">
                        <div class="bg-white py-2 collapse-inner rounded">
                            <a class="collapse-item" href="">글</a>
                            <a class="collapse-item" href="">댓글</a>
                        </div>
                    </div>
                </li>
                <li class="list">
                    <b></b>
                    <b></b>
                    <a class="btn toggle-btn" role="button" data-target="#collapseQnAUser" data-toggle="collapse" href="#collapseQnAUser" aria-expanded="false" aria-controls="collapseExample">
                        <span class="icon"><ion-icon name="help-outline"></ion-icon></span>
                        <span class="title">문의•신고</span>
                    </a>
                    <div class="collapse" id="collapseQnAUser" style="padding: 10px;">
                        <div class="bg-white py-2 collapse-inner rounded">
                            <a class="collapse-item" href="">문의</a>
                            <a class="collapse-item" href="">신고</a>
                        </div>
                    </div>
                </li>
            </ul>
        </c:when>

        <%-- Admin --%>
        <c:when test="${sessionScope.role eq 'admin'}">
            <ul class="sidebar-user">
                <li class="list active">
                    <b></b>
                    <b></b>
                    <a href="#">
                        <span class="icon"><ion-icon name="home-outline"></ion-icon></span>
                        <span class="title">사이트관리</span>
                    </a>
                </li>
                <li class="list">
                    <b></b>
                    <b></b>
                    <a class="btn toggle-btn" role="button" data-target="#collapseUser" data-toggle="collapse" href="#collapseUser" aria-expanded="false" aria-controls="collapseExample">
                        <span class="icon"><ion-icon name="person-circle-outline"></ion-icon></span>
                        <span class="title">일반회원</span>
                    </a>
                    <div class="collapse" id="collapseUser" style="padding: 10px;">
                        <div class="bg-white py-2 collapse-inner rounded">
                            <a class="collapse-item" href="">활동회원</a>
                            <a class="collapse-item" href="">탈퇴회원</a>
                        </div>
                    </div>
                </li>
                <li class="list">
                    <b></b>
                    <b></b>
                    <a class="btn toggle-btn" role="button" data-target="#collapseTruck" data-toggle="collapse" href="#collapseTruck" aria-expanded="false" aria-controls="collapseExample">
                        <span class="icon"><ion-icon name="cart-outline"></ion-icon></span>
                        <span class="title">사업자회원</span>
                    </a>
                    <div class="collapse" id="collapseTruck" style="padding: 10px;">
                        <div class="bg-white py-2 collapse-inner rounded">
                            <a class="collapse-item" href="">전체</a>
                            <a class="collapse-item" href="">가입승인</a>
                            <a class="collapse-item" href="">가입승인대기</a>
                            <a class="collapse-item" href="">가입승인거절</a>
                        </div>
                    </div>
                </li>
                <li class="list">
                    <b></b>
                    <b></b>
                    <a class="btn toggle-btn" role="button" data-target="#collapseLcok" data-toggle="collapse" href="#collapseLcok" aria-expanded="false" aria-controls="collapseExample">
                        <span class="icon"><ion-icon name="heart-outline"></ion-icon></span>
                        <span class="title">게시글 관리</span>
                    </a>
                </li>
                <li class="list">
                    <b></b>
                    <b></b>
                    <a href="#">
                        <span class="icon"><ion-icon name="star-half-outline"></ion-icon></span>
                        <span class="title">블랙리스트</span>
                    </a>
                </li>
                <li class="list">
                    <b></b>
                    <b></b>
                    <a class="btn toggle-btn" role="button" data-target="#collapseApp" data-toggle="collapse" href="#collapseApp" aria-expanded="false" aria-controls="collapseExample">
                        <span class="icon"><ion-icon name="reader-outline"></ion-icon></span>
                        <span class="title">가입승인</span>
                    </a>
                    <div class="collapse" id="collapseApp" style="padding: 10px;">
                        <div class="bg-white py-2 collapse-inner rounded">
                            <a class="collapse-item" href="">승인처리대기</a>
                            <a class="collapse-item" href="">승인처리완료</a>
                        </div>
                    </div>
                </li>
                <li class="list">
                    <b></b>
                    <b></b>
                    <a class="btn toggle-btn" role="button" data-target="#collapseQnAAdmin" data-toggle="collapse" href="#collapseQnAAdmin" aria-expanded="false" aria-controls="collapseExample">
                        <span class="icon"><ion-icon name="help-outline"></ion-icon></span>
                        <span class="title">문의•신고</span>
                    </a>
                    <div class="collapse" id="collapseQnAAdmin" style="padding: 10px;">
                        <div class="bg-white py-2 collapse-inner rounded">
                            <a class="collapse-item" href="">문의</a>
                            <a class="collapse-item" href="">신고</a>
                        </div>
                    </div>
                </li>
            </ul>
        </c:when>

        <%-- Truck --%>
        <c:when test="${sessionScope.role eq 'truck'}">
            <ul class="sidebar-user">
                <li class="list active">
                    <b></b>
                    <b></b>
                    <a href="#">
                        <span class="icon"><ion-icon name="home-outline"></ion-icon></span>
                        <span class="title">MyPage</span>
                    </a>
                </li>
                <li class="list">
                    <b></b>
                    <b></b>
                    <a class="btn toggle-btn" role="button" data-target="#collapseInfoT" data-toggle="collapse" href="#collapseInfoT" aria-expanded="false" aria-controls="collapseExample">
                        <span class="icon"><ion-icon name="person-circle-outline"></ion-icon></span>
                        <span class="title">내정보</span>
                    </a>
                    <div class="collapse" id="collapseInfoT" style="padding: 10px;">
                        <div class="bg-white py-2 collapse-inner rounded">
                            <a class="collapse-item" href="">내정보</a>
                            <a class="collapse-item" href="">프로필</a>
                            <a class="collapse-item" href="">비밀번호</a>
                        </div>
                    </div>
                </li>
                <li class="list">
                    <b></b>
                    <b></b>
                    <a class="btn toggle-btn" role="button" data-target="#collapseSale" data-toggle="collapse" href="#collapseSale" aria-expanded="false" aria-controls="collapseExample">
                        <span class="icon"><ion-icon name="cart-outline"></ion-icon></span>
                        <span class="title">판매</span>
                    </a>
                    <div class="collapse" id="collapseSale" style="padding: 10px;">
                        <div class="bg-white py-2 collapse-inner rounded">
                            <a class="collapse-item" href="">판매내역</a>
                            <a class="collapse-item" href="">환불내역</a>
                        </div>
                    </div>
                </li>
                <li class="list">
                    <b></b>
                    <b></b>
                    <a href="#">
                        <span class="icon"><ion-icon name="heart-outline"></ion-icon></span>
                        <span class="title">좋아요</span>
                    </a>
                </li>
                <li class="list">
                    <b></b>
                    <b></b>
                    <a href="#">
                        <span class="icon"><ion-icon name="star-half-outline"></ion-icon></span>
                        <span class="title">리뷰</span>
                    </a>
                </li>
                <li class="list">
                    <b></b>
                    <b></b>
                    <a class="btn toggle-btn" role="button" data-target="#collapsePostT" data-toggle="collapse" href="#collapsePostT" aria-expanded="false" aria-controls="collapseExample">
                        <span class="icon"><ion-icon name="reader-outline"></ion-icon></span>
                        <span class="title">글•댓글</span>
                    </a>
                    <div class="collapse" id="collapsePostT" style="padding: 10px;">
                        <div class="bg-white py-2 collapse-inner rounded">
                            <a class="collapse-item" href="">글</a>
                            <a class="collapse-item" href="">댓글</a>
                        </div>
                    </div>
                </li>
                <li class="list">
                    <b></b>
                    <b></b>
                    <a href="#">
                        <span class="icon"><ion-icon name="help-outline"></ion-icon></span>
                        <span class="title">문의</span>
                    </a>
                </li>
            </ul>
        </c:when>

    </c:choose>
</div>
<div class="toggle sidebar-toggle">
<%--    <ion-icon name="reorder-three-outline" class="open"></ion-icon>
    <ion-icon name="close-outline" class="close"></ion-icon>--%>
    <i class="fas fa-angle-double-right fa-lg"></i>
    <i class="fas fa-angle-double-left fa-lg"></i>
</div>

<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>

<script>

    let menuToggle = document.querySelector('.sidebar-toggle');
    let navigation = document.querySelector('.sidebar-div');
    menuToggle.onclick = function () {
        menuToggle.classList.toggle('active');
        navigation.classList.toggle('active');
    }

    let list = document.querySelectorAll('.list');
    for(let i=0; i<list.length; i++){
        list[i].onclick = function () {
            let j = 0;
            while (j < list.length){
                list[j++].className = 'list';
            }
            list[i].className = 'list active';
        }
    }
</script>


