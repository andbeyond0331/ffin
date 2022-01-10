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
        width: 70px;
        box-sizing: content-box;
        border-radius: 10px;
        border-left: 5px solid #ffffff;
        /*background-color: #ffe537;*/
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
        color: #ffe537;
    }
    .sidebar-toggle ion-icon.open,
    .sidebar-toggle.active ion-icon.close{
        display: block;
    }
    .sidebar-toggle ion-icon.close,
    .sidebar-toggle.active ion-icon.open{
        display: none;
    }

</style>



<!-- sidebar -->
<div class="navigation sidebar-div">
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
            <a href="#" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="collapseExample">
                <span class="icon"><ion-icon name="person-circle-outline"></ion-icon></span>
                <span class="title">내정보</span>
            </a>
        </li>
        <li class="list">
            <b></b>
            <b></b>
            <a href="#">
                <span class="icon"><ion-icon name="person-circle-outline"></ion-icon></span>
                <span class="title">내정보</span>
            </a>
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
            <a href="#">
                <span class="icon"><ion-icon name="cart-outline"></ion-icon></span>
                <span class="title">구매</span>
            </a>
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
            <a href="#">
                <span class="icon"><ion-icon name="reader-outline"></ion-icon></span>
                <span class="title">글•댓글</span>
            </a>
        </li>
        <li class="list">
            <b></b>
            <b></b>
            <a href="#">
                <span class="icon"><ion-icon name="help-outline"></ion-icon></span>
                <span class="title">문의•신고</span>
            </a>
        </li>
    </ul>
</div>
<div class="toggle sidebar-toggle">
    <ion-icon name="reorder-three-outline" class="open"></ion-icon>
    <ion-icon name="close-outline" class="close"></ion-icon>
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


