<%@ page import="com.ffin.service.domain.Catering" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<style>
    *::-moz-selection {
        color: #03A9F4;
        box-sizing: border-box
    }
    *::selection {
        color: #03A9F4;
        -webkit-box-sizing: border-box;
        box-sizing: border-box
    }
    ::-webkit-scrollbar {
        width: 10px;
        background-color: transparent!important;
    }
    ::-webkit-scrollbar-thumb {
        background-color: #03A9F4!important;
    }
    body {
        padding: 0;
        margin: 0;
        font-family: 'Roboto Condensed', 'droid arabic kufi', sans-serif;
    }
    .wallpaper-overlay {
        position: fixed;
        top: 0;
        bottom: 0;
        width: 100%;
        left: 0;
        right: 0;
        -webkit-filter: blur(3px);
        filter: blur(3px);
        background: url(https://3.bp.blogspot.com/-dw0kPdIqpr8/Wi6rYQoc5jI/AAAAAAAAC4U/PtaX2GO4-FcnejiFy5BRrulxafoP7vx7gCLcBGAs/s1600/6.jpg)fixed;
        background-position: center;
        background-size: cover;
        z-index: -1;
    }
    .wrapper {
        margin: 20px auto 10px;
        overflow: hidden;
    }
    h2,
    h3 {
        font-weight: normal;
        margin: 0;
    }
    img{ max-width:100%;
        display: block;}


    *,
    *::before,
    *::after {
        box-sizing: border-box;
    }

    body{
        background-size: cover;

        font-family: "Open Sans", Arial, sans-serif;
        min-height: 100vh;
        background-color: #fafafa;
        color: #262626;
        padding-bottom: 3rem;


    }

    .container{
        margin-top: 132px;

        max-width: 93.5rem;
        margin: 0 auto;
        padding: 0 2rem;

    }
    .reply_list_profileImage{
        width: 40px;
        height: 40px;
        border: 0px;
        border-radius: 50%;
    }
    #write_reply_profileImage{
        width: 40px;
        height: 40px;
        border: 0px;
        border-radius: 50%;
    }
    .format{display: none}

    .btn {
        display: inline-block;
        font: inherit;
        background: none;
        border: none;
        color: inherit;
        padding: 0;
        cursor: pointer;
    }

    .btn:focus {
        outline: 0.5rem auto #4d90fe;
    }

    .visually-hidden {
        position: absolute !important;
        height: 1px;
        width: 1px;
        overflow: hidden;
        clip: rect(1px, 1px, 1px, 1px);
    }


    /* Gallery Section */

    .gallery {
        display: flex;
        flex-wrap: wrap;
        margin: -1rem -1rem;
        padding-bottom: 3rem;
        padding-top: 60px;
    }

    .gallery-item {
        position: relative;

        margin: 1rem;
        color: #fff;
        cursor: pointer;
    }

    .gallery-item:hover .gallery-item-info,
    .gallery-item:focus .gallery-item-info {
        display: flex;
        justify-content: center;
        align-items: center;
        position: absolute;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.3);
    }

    .gallery-item-info {
        display: none;
    }

    .gallery-item-info li {
        display: inline-block;
        font-size: 1.4rem;
        font-weight: 600;
    }


    .fa-comment {
        transform: rotateY(180deg);
    }

    .gallery-image {
        width: 350px;
        height: 350px;
        object-fit: cover;
    }
    .addbutton{
        margin-top: 101px;
        /* margin-right: 0px; */
        padding-left: 626px;
    }
    .main-insta {
        max-width: 380px;
        min-width: 300px;
        margin: auto;
        background-color: rgba(250, 250, 250, 0.85);
        -webkit-box-shadow: 0 2px 26px rgba(0, 0, 0, .3), 0 0 0 1px rgba(0, 0, 0, .1);
        box-shadow: 0 2px 26px rgba(0, 0, 0, .3), 0 0 0 1px rgba(0, 0, 0, .1);
        border-radius: 5px;
    }
    .insta-header h2:after,
    .insta-header .dots,
    .insta-reaction span, .insta-reaction label {
        background-image: url(https://2.bp.blogspot.com/-dvvriE9ZKTA/Wi6rZx7U7kI/AAAAAAAAC4g/U2OrjuO9lvIHxdsYTFv_0TFqPpHeGR4NgCLcBGAs/s1600/f2eee39b755e.png);
    }
    .insta-header {
        padding: 10px;
        position: relative;
        overflow: hidden;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
    }
    .insta-header span:nth-child(1) {
        display: inline-block;
        width: 50px;
        height: 50px;
        border-radius: 50%;
        background-image: url(https://3.bp.blogspot.com/-w6wn_9WJANI/Wi6rYtB-kTI/AAAAAAAAC4c/w8azX7AZVmgsRhzHPpwzGTeei_opUlXiQCLcBGAs/s1600/ff4a5109f997020065090205f56c2c8b.jpg);
        background-size: cover;
        background-position: 100% 25%;
        overflow: hidden;
        float: left;
        margin-right: 8px
    }
    .insta-header .header-title {
        float: left
    }
    .insta-header h2 {
        position: relative;
        color: #444;
        margin: 5px 0;
        font-size: 18px;
    }
    .insta-header h3 {
        color: #03A9F4;
        font-size: 12px
    }
    .insta-header h2:after {
        content: '';
        width: 19px;
        height: 19px;
        display: inline-block;
        position: absolute;
        background-position: -434px -226px;
        -webkit-transform: scale(.9);
        -ms-transform: scale(.9);
        transform: scale(.9);
        top: 50%;
        margin: -9.5px 0 0 4px;
    }
    .tooltip {
        top: 10px;
        font-size: 10px;
        width: 100px;
        text-align: center;
        background: rgba(0,0,0,0.3);
        position: absolute;
        padding: 4px;
        border-radius: 3px;
        color: #fff;
        right: 10px;
        display: none;
        text-transform: capitalize;
        z-index: 1;
    }
    .tooltip:after {
        content: '';
        width: 0;
        height: 0;
        border-style: solid;
        border-width: 7px;
        position: absolute;
        left: -14px;
        top: 7px;
        border-color: transparent rgba(0,0,0,0.3) transparent transparent;
    }
    .insta-header .header-title:hover .tooltip{
        display: block
    }
    .insta-header .dots{
        cursor: pointer;
        background-repeat: no-repeat;
        background-position: -434px -345px;
        height: 16px;
        width: 16px;
        display: inline-block;
        position: absolute;
        right: 10px;
        top: 50%;
        margin-top: -8px;
    }
    .insta-post {
        position: relative;
        height: 350px;
        width: 100%;
        overflow: hidden;
    }
    .css-slider-wrapper {
        overflow: hidden;
        position: absolute;
        left: 0;
        right: 0;
        top: 0;
        bottom: 0;
    }
    .slider {
        width: 100%;
        height: 100%;
        position: absolute;
        left: 0;
        top: 0;
        opacity: 1;
        z-index: 0;
        display: -webkit-box;
        display: flex;
        display: -ms-flexbox;
        -webkit-box-orient: horizontal;
        -webkit-box-direction: normal;
        -ms-flex-direction: row;
        flex-direction: row;
        -ms-flex-wrap: wrap;
        flex-wrap: wrap;
        -webkit-flex-align: center;
        -webkit-box-align: center;
        -ms-flex-align: center;
        align-items: center;
        -webkit-box-pack: center;
        -ms-flex-pack: center;
        justify-content: center;
        -ms-flex-line-pack: center;
        align-content: center;
        -webkit-transition: all 1s cubic-bezier(0.01, 0.97, 0.35, 0.99);
        -o-transition: all 1s cubic-bezier(0.01, 0.97, 0.35, 0.99);
        transition: all 1s cubic-bezier(0.01, 0.97, 0.35, 0.99);
    }
    .slide1,
    .page1 {
        background: url(https://3.bp.blogspot.com/-ULPTYqjxQ0E/Wi6rVjtdVdI/AAAAAAAAC4I/6TBeGdPw49s1SSxQpKjHQrUtLxCxStvygCLcBGAs/s1600/1.jpg);
        background-size: cover;
        left: 0;
    }
    .slide2,
    .page2 {
        background: url(https://2.bp.blogspot.com/-n1mRXW_QGfY/Wi6rVevyenI/AAAAAAAAC4E/Ui5_NefPmwwLbzNpUCjTAGHVBuapwWyqACLcBGAs/s1600/2.jpg);
        background-size: cover;
        left: 100%
    }
    .slide3,
    .page3 {
        background: url(https://4.bp.blogspot.com/-FGxjMI1_0EI/Wi6rWNOePOI/AAAAAAAAC4M/XtU8ktClrZ0xjfo0Nf3VJ8nR1mI8eAMuwCLcBGAs/s1600/3.jpg);
        background-size: cover;
        left: 200%
    }
    .slide4,
    .page4 {
        background: url(https://2.bp.blogspot.com/-RRw8jWo6vrg/Wi6rYkY2CvI/AAAAAAAAC4Y/3_ItIrb99AEgGegExl_Ro0VM3-jIYNF0gCLcBGAs/s1600/4.jpg);
        background-size: cover;
        left: 300%;
    }
    .slide5,
    .page5 {
        background: url(https://2.bp.blogspot.com/-cBCRFKl8-oM/Wi6rWnhESyI/AAAAAAAAC4Q/YY8iEpHUurcsKBqegiusBwEeXUeGIZriwCLcBGAs/s1600/5.jpg);
        background-size: cover;
        background-position: center;
        left: 400%;
    }
    .slider > div {
        text-align: center;
    }
    .slider h2 {
        color: rgba(250, 250, 250, 0.85);
        font-weight: 900;
        text-shadow: 1px 1px 5px rgba(0, 0, 0, 0.4);
        text-transform: uppercase;
        font-size: 40px;
        opacity: 0;
        -webkit-transform: translateX(500px);
        -ms-transform: translateX(500px);
        transform: translateX(500px);
        -webkit-transition: opacity 800ms, -webkit-transform 800ms;
        transition: opacity 800ms, -webkit-transform 800ms;
        -o-transition: transform 800ms, opacity 800ms;
        transition: transform 800ms, opacity 800ms;
        transition: transform 800ms, opacity 800ms, -webkit-transform 800ms;
        -webkit-transition-delay: 1s;
        -o-transition-delay: 1s;
        transition-delay: 1s;
    }
    .pagi-main {
        position: absolute;
        bottom: 0%;
        z-index: 1000;
        overflow: hidden;
        height: 54px;
        line-height: 54px;
        width: 35px;
        color: #444;
        font-size: 20px;
        background-color: rgba(250, 250, 250, 0.85);
    }
    .pagi-main > label {
        z-index: 0;
        position: absolute;
        cursor: pointer;
        width: 100%;
        height: 100%;
    }
    .previous {
        left: 0;
        border-top-right-radius: 25.5px;
        border-bottom-right-radius: 25.5px;
    }
    .next {
        right: 0;
        border-top-left-radius: 25.5px;
        border-bottom-left-radius: 25.5px;
    }
    .previous > label {

    }
    .previous > label:before {
        content: '\f053';
        font-family: fontAwesome;
        display: inline-block;
        -webkit-transform: translateX(50%);
        -ms-transform: translateX(50%);
        transform: translateX(50%);
    }
    .next > label {

    }
    .next > label:before {
        content: '\f054';
        font-family: fontAwesome;
        -webkit-transform: translateX(100%);
        -ms-transform: translateX(100%);
        transform: translateX(100%);
        display: inline-block;
    }
    .slider-pagination {
        height: 54.1px;
        position: absolute;
        bottom: 0px;
        width: 100%;
        left: 0;
        text-align: center;
        overflow: hidden;
        background: rgba(0, 0, 0, 0.3);
        z-index: 1000;
        display: -webkit-box;
        display: -ms-flexbox;
        display: flex;
        -webkit-box-pack: center;
        -ms-flex-pack: center;
        justify-content: center;
        -webkit-box-align: center;
        -ms-flex-align: center;
        align-items: center;
    }
    .slider-pagination label {
        height: 47px;
        width: 47px;
        border-radius: 50%;
        display: inline-block;
        -webkit-filter: grayscale(1);
        filter: grayscale(1);
        margin: 0 -6px 0 0;
        cursor: pointer;
        -webkit-box-shadow: 0px 0px 0px 3px rgba(0, 0, 0, 0.4);
        box-shadow: 0px 0px 0px 3px rgba(0, 0, 0, 0.4);
    }
    .slide-radio1:checked ~ .next .numb2,
    .slide-radio2:checked ~ .next .numb3,
    .slide-radio3:checked ~ .next .numb4,
    .slide-radio4:checked ~ .next .numb5,
    .slide-radio5:checked ~ .next .numb1,
    .slide-radio2:checked ~ .previous .numb1,
    .slide-radio3:checked ~ .previous .numb2,
    .slide-radio4:checked ~ .previous .numb3,
    .slide-radio5:checked ~ .previous .numb4 {

        z-index: 1
    }
    /* Slider Pagger event */

    .slide-radio1:checked ~ .slider-pagination .page1,
    .slide-radio2:checked ~ .slider-pagination .page2,
    .slide-radio3:checked ~ .slider-pagination .page3,
    .slide-radio4:checked ~ .slider-pagination .page4,
    .slide-radio5:checked ~ .slider-pagination .page5 {
        -webkit-filter: grayscale(0);
        filter: grayscale(0);
        -webkit-box-shadow: 0px 0px 0px 3px #03A9F4;
        box-shadow: 0px 0px 0px 3px #03A9F4;
    }
    .slide-radio1:checked ~ .slider {
        -webkit-transform: translateX(0%);
        -ms-transform: translateX(0%);
        transform: translateX(0%);
    }
    .slide-radio2:checked ~ .slider {
        -webkit-transform: translateX(-100%);
        -ms-transform: translateX(-100%);
        transform: translateX(-100%);
    }
    .slide-radio3:checked ~ .slider {
        -webkit-transform: translateX(-200%);
        -ms-transform: translateX(-200%);
        transform: translateX(-200%);
    }
    .slide-radio4:checked ~ .slider {
        -webkit-transform: translateX(-300%);
        -ms-transform: translateX(-300%);
        transform: translateX(-300%);
    }
    .slide-radio5:checked ~ .slider {
        -webkit-transform: translateX(-400%);
        -ms-transform: translateX(-400%);
        transform: translateX(-400%);
    }
    .slide-radio1:checked ~ .slide1 h2,
    .slide-radio2:checked ~ .slide2 h2,
    .slide-radio3:checked ~ .slide3 h2,
    .slide-radio4:checked ~ .slide4 h2,
    .slide-radio5:checked ~ .slide5 h2 {
        -webkit-transform: translateX(0);
        -ms-transform: translateX(0);
        transform: translateX(0);
        opacity: 1
    }

</style>
<script type="text/javascript">


    //=============    검색 / page 두가지 경우 모두  Event  처리 =============
    function fncGetUserList(currentPage) {
        $("#currentPage").val(currentPage)
        $("#getPostListPic").attr("method" , "POST").attr("action" , "/community/getPostList2").submit();
    }

    var role =  '${sessionScope.role}';
    var proImg;
    var uId;
    if (role == 'user'){
        proImg = '${sessionScope.user.userProImg}';
        uId = '${sessionScope.user.userId}';
    }else if(role=='truck'){
        proImg = '${sessionScope.truck.truckProImg}';
        uId = '${sessionScope.truck.truckId}';
    }



    // 사진 클릭했을 때, modal 호출

    function getCardDetail(postNo) {

        alert("얍")

        alert("postNo: "+postNo)
        $.ajax({
            url:"/community/json/getCardDetail/"+postNo,
            method:"get",

            success: function (data) {
                var div="";
                var modalFooter = "";
                let hit = data.post.postHit;
                $('#hit'+postNo).text(hit);

                    div += "<div class='cloneFail' >"+
                        "</div>";



/*

                    +"<div id='carouselExampleInterval' class='carousel slide' data-ride='carousel'>"
                     +"<div class='carousel-inner'>"
                      +"<div class='carousel-item active'>"
                          +"<img class='d-block w-100' src='../../../resources/image/"+data.post.postFile1+"' alt='First slide'>"
                         +"</div>"
                      +"<div class='carousel-item' >"
                         +"<img class='d-block w-100' src='../../../resources/image/"+data.post.postFile2+"' alt='Second slide'>"
                     +"</div>"
                      +" <div class='carousel-item'>"
                      + " <img class='d-block w-100' src='../../../resources/image/"+data.post.postFile3+"' alt='Third slide'>"
                     +" </div></div>"
                      + " <a class='carousel-control-prev' href='#carouselExampleIndicators' role='button' data-slide='prev'>"
                    + "<span class='carousel-control-prev-icon' aria-hidden='true'></span> <span class='sr-only'>Previous</span>"
                     + "</a>"
              + " <a class='carousel-control-next' href='#carouselExampleIndicators' role='button' data-slide='next'>"
                    +"<span class='carousel-control-next-icon' aria-hidden='true'></span> <span class='sr-only'>Next</span>"
                  + " </a>"
                +" </div>";






/!* 슬라이드 해볼랫는데 안먹는당 *!/

*/



       /*               +"<div class='row'>"
                    +"<div ><strong></strong> <img src='../../../resources/image/"+data.post.postFile1+"'></div></div>";

                if (data.post.postFile2 != null){
                    div += "<div class='row'>"
                        +"<div ><strong></strong> <img src='../../../resources/image/"+data.post.postFile2+"'></div></div>";
                }
                if (data.post.postFile3 != null){
                    div += "<div class='row'>"
                        +"<div ><strong></strong> <img src='../../../resources/image/"+data.post.postFile3+"'></div></div>";
                }*/
                div += "<div class='row'>"+
                    "<div>"+data.post.postContent+"</div></div>";

                if (data.post.heartNo == '0'){

                    div +=" <a idx="+data.post.postNo+" href='javascript:' class='heart-click heart_icon"+data.post.postNo+"'>"
                                                +"<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart' viewBox='0 0 16 16'>"
                                                    + "<path d='M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z' />"
                                                +"</svg> </a> ";
                }else{

                    div +=  "<a idx="+data.post.postNo+" href='javascript:' class='heart-click heart_icon"+data.post.postNo+"'>"
                        +"<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'>"
                        +"<path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z' />"
                  + " </svg></a>";
                }
                div += " <span id='m_heart"+data.post.postNo+"'>"+data.post.heartCount+"</span>"
                    +"<span>"
                        +"<a idx='"+data.post.postNo+"' href='#reply_card"+data.post.postNo+"' role='button' class='open_reply_list' data-toggle='collapse'  aria-expanded='false' aria-controls='collapseExample'> "
                          +"<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-chat-dots' viewBox='0 0 16 16'>"
													+"<path d='M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z' />"
													+"<path d='M2.165 15.803l.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z' />"
                            +"</svg>"
                            +"</a>"
                       +" </span>"
                    +" <span id='m_reply"+data.post.postNo+"'>"+data.post.replyCount+"</span>"
                   +"<span> <svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-eye' viewBox='0 0 16 16'>"
											+"<path d='M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z' />"
											+"<path d='M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z' />"
										+"</svg>"
						+"</span> <span id='hit"+data.post.postNo+"'>"+data.post.postHit+"</span>"
                 +"<div class='collapse' id='reply_card"+data.post.postNo+"'>"
                   +"<section class='modal-section'>"
                        +"<div class='card card-body'>"
                            +"<div class='reply-list reply-list"+data.post.postNo+"'>"
                            +"</div>"
                                +"<div class='row reply_write'>"
                                    +"<div class='col-1'>"
                                        +"<a href='other_profile.do?other_nick='>"
                                           +"<img id='write_reply_profileImage' src='/resources/image/"+proImg+"' />"
                                       +" </a>"
                                    +"</div>"
                                    +"<div class='col-8' class='input_reply_div'>"
                                        +"<input class='w-100 form-control' id='input_reply"+data.post.postNo+"' type='text' placeholder='댓글입력...'>"
                                    +"</div>"
                                    +"<div class='col-3 '>"
                                        +"<button type='button' idx='"+data.post.postNo+"' class='btn btn-success mb-1 write_reply'>댓글&nbsp;달기</button>"
                                   +"</div>"
                               +" </div>"
                       +" </div>"
                   +" </section>"
                +"</div>";


                if (role == "user"){

                    var userId = '${sessionScope.user.userId}'

                    if (data.post.postTruck == null && data.post.postUser.userId == userId){

                        modalFooter = "<div class='modal-footer'>"
                            +"<button class='button btn-warning' name='deletePostPic' onclick='deletePostPic("+data.post.postNo+");'>글 삭제"
                          +"<input type='hidden' name='postNo' value='"+data.post.postNo+"'/></button>"
                        +"<button class='button is-warning is-light' name='updatePostPicView'"
                                +"onclick='updatePostPicView("+data.post.postNo+");'>글 수정"
                            +"<input type='hidden' name='postNo' value='"+data.post.postNo+"'/>"
                       + "</button>"
                            +"</div>";
                    }else {
                        modalFooter = "<div class='modal-footer'>"
                            + " <button type='button' class='btn btn-secondary' data-dismiss='modal'>Close</button></div>";
                    }

                }else if(role == "truck"){

                    var truckId = '${sessionScope.truck.truckId}'

                    if (data.post.postUser == null && data.post.postTruck.truckId == truckId){

                        modalFooter = "<div class='modal-footer'>"
                            +"<button class='button btn-warning' name='deletePostPic' onclick='deletePostPic("+data.post.postNo+");'>글 삭제"
                            +"<input type='hidden' name='postNo' value='"+data.post.postNo+"'/></button>"
                            +"<button class='button is-warning is-light' name='updatePostPicView'"
                            +"onclick='updatePostPicView("+data.post.postNo+");'>글 수정"
                            +"<input type='hidden' name='postNo' value='"+data.post.postNo+"'/>"
                            + "</button>"
                            +"</div>";

                    }else {
                        modalFooter = "<div class='modal-footer'>"
                            + " <button type='button' class='btn btn-secondary' data-dismiss='modal'>Close</button></div>";
                    }
                }









                //$('body').find( '.format' ).clone().appendTo( '#carouselFail' ).css("display", "block");

                $('.modal-footer').remove();


                $('.modal-content').append(modalFooter);
                $('.modal-body').html(div);

                console.log("data.post.postHit: "+data.post.postHit);

                $('#staticBackdrop').modal('show');







            },
            error : function(err){
                console.log('에러')
            }
        });



    }

// html을 복사하고.
    // 모달이 피료없다





</script>


<head>
    <title>사진 게시판</title>
    <jsp:include page="../../common/lib.jsp"/>


</head>

<body id="page-top">

<jsp:include page="/views/navbar.jsp" />
<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->



<!-- 등록/ 수정 모달 -->
<div class="modal fade"  id="modaladdPostPic" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="modaladdPostPic" aria-hidden="true" style=" display: none; ">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"></span>
                </button>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="modaladdPostPicForm">
                <div class="form-group">
                    <span> 아이디 </span>
                    <c:if test="${sessionScope.role eq 'user'}">
                    <span id="postUser.userId">${sessionScope.user.userId}</span>
                    </c:if>
                    <c:if test="${sessionScope.role eq 'truck'}">
                        <span id="postTruck.truckId">${sessionScope.truck.truckId}</span>
                    </c:if>
                </div>
                    <div class="form-group">
                        <label for="postFile1" class="col-sm-offset-1 col-sm-10 control-label">파일 이미지1</label>
                        <div class="col-sm-10">
                            <input type="file" class="form-control" id="postFile1" name="postFile11"  value="${post.postFile1}" placeholder="파일 이미지1" onchange="setImage1Preview(event, '#image1preview');">
                        </div>
                        <div id="image1preview" class="col-sm-10"></div>
                    </div>

                    <div class="form-group">
                        <label for="postFile2" class="col-sm-offset-1 col-sm-10 control-label">파일 이미지2</label>
                        <div class="col-sm-10">
                            <input type="file" class="form-control" id="postFile2" name="postFile22"  value="${post.postFile2}" placeholder="파일 이미지1" onchange="setImage2Preview(event);">
                        </div>
                        <div id="image2preview" class="col-sm-10"></div>
                    </div>

                    <div class="form-group">
                        <label for="postFile3" class="col-sm-offset-1 col-sm-10 control-label">파일 이미지3</label>
                        <div class="col-sm-10">
                            <input type="file" class="form-control" id="postFile3" name="postFile33"  value="${post.postFile3}" placeholder="파일 이미지3" onchange="setImage3Preview(event);">
                        </div>
                        <div id="image3preview" class="col-sm-10"></div>
                    </div>

                    <script>


                        function setImage1Preview(event, tag){
                            var DIVimage1preview = $(tag);

                            if (tag == "0"){
                                DIVimage1preview = $("#m_image1preview");
                            }

                            var isTherePreview = DIVimage1preview.find('img').length;
                            alert("isTherePreview : " + isTherePreview);
                            //이미지파일미리보기 이미 있으면 바꾸기 구현 중-  점심먹고 왔다! 다시 시작!
                            var reader  = new FileReader();

                            if(isTherePreview==0){

                            }else{
                                $("#m_image1preview").find('img').remove();
                                //DIVimage1preview.find('img').remove();

                            }

                            reader.onload = function(event){

                                var div = "<img src='"+event.target.result+"'>";
                                var img = document.createElement("img");

                                img.setAttribute("src", event.target.result);
                                //img.setAttribute("style", "width:50%");
                                if (tag == "0"){
                                    //$("#modaladdPostPic").find("#m_image1preview").append(div);
                                    document.querySelector("div#m_image1preview").appendChild(img);
                                }else{
                                    img.setAttribute("style", "width:50%");
                                    document.querySelector("div#image1preview").appendChild(img);
                                }

                            };

                            reader.readAsDataURL(event.target.files[0]);


                        }

                        function setImage2Preview(event, tag){
                            var DIVimage2preview = $(tag);

                            if (tag == "0"){
                                DIVimage2preview = $("#m_image2preview");
                            }

                            var isTherePreview = DIVimage2preview.find('img').length;
                            alert("isTherePreview : " + isTherePreview);
                            //이미지파일미리보기 이미 있으면 바꾸기 구현 중-  점심먹고 왔다! 다시 시작!
                            var reader  = new FileReader();

                            if(isTherePreview==0){

                            }else{
                                $("#m_image2preview").find('img').remove();
                                //DIVimage1preview.find('img').remove();

                            }

                            reader.onload = function(event){

                                var div = "<img src='"+event.target.result+"'>";
                                var img = document.createElement("img");

                                img.setAttribute("src", event.target.result);

                                if (tag == "0"){
                                    //$("#modaladdPostPic").find("#m_image1preview").append(div);
                                    document.querySelector("div#m_image2preview").appendChild(img);
                                }else{
                                    img.setAttribute("style", "width:50%");
                                    document.querySelector("div#image2preview").appendChild(img);
                                }

                            };

                            reader.readAsDataURL(event.target.files[0]);


                        }
                        function setImage3Preview(event, tag){
                            var DIVimage3preview = $(tag);

                            if (tag == "0"){
                                DIVimage3preview = $("#m_image3preview");
                            }

                            var isTherePreview = DIVimage3preview.find('img').length;
                            alert("isTherePreview : " + isTherePreview);
                            //이미지파일미리보기 이미 있으면 바꾸기 구현 중-  점심먹고 왔다! 다시 시작!
                            var reader  = new FileReader();

                            if(isTherePreview==0){

                            }else{

                                $("#m_image3preview").find('img').remove();
                                //DIVimage1preview.find('img').remove();

                            }

                            reader.onload = function(event){

                                var div = "<img src='"+event.target.result+"'>";
                                var img = document.createElement("img");

                                img.setAttribute("src", event.target.result);

                                if (tag == "0"){
                                    //$("#modaladdPostPic").find("#m_image1preview").append(div);
                                    document.querySelector("div#m_image3preview").appendChild(img);
                                }else{
                                    img.setAttribute("style", "width:50%");
                                    document.querySelector("div#image3preview").appendChild(img);
                                }

                            };

                            reader.readAsDataURL(event.target.files[0]);


                        }

                    </script>
                <div id="here"></div>

                <div class="form-group">
                    <textarea id="postContent" name = "postContent" style="resize:none;" rows="5" cols="55" title="내용을 입력해 주세요.">${post.postContent}</textarea>
                </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="add-post-p" >글쓰기</button>
            </div>
        </div>
    </div>
</div>
<!-- slide -->
<div class="format">
<div class="wrapper">
    <div class='main-insta'>

        <div class="insta-post">
            <div class="css-slider-wrapper">
                <input type="radio" name="slider" class="slide-radio1" checked id="slider_1">
                <input type="radio" name="slider" class="slide-radio2" id="slider_2">
                <input type="radio" name="slider" class="slide-radio3" id="slider_3">

                <div class="slider-pagination">
                    <label for="slider_1" class="page1"></label>
                    <label for="slider_2" class="page2"></label>
                    <label for="slider_3" class="page3"></label>

                </div>
                <div class="next pagi-main">
                    <label for="slider_1" class="numb1"></label>
                    <label for="slider_2" class="numb2"></label>
                    <label for="slider_3" class="numb3"></label>

                </div>
                <div class="previous pagi-main">
                    <label for="slider_1" class="numb1"></label>
                    <label for="slider_2" class="numb2"></label>
                    <label for="slider_3" class="numb3"></label>

                </div>
                <div class="slider slide1">
                    <div>
                        <h2>Jerusalem shall be ours</h2>
                    </div>
                </div>
                <div class="slider slide2">
                    <div>
                        <h2>Jerusalem shall be free </h2>
                    </div>
                </div>
                <div class="slider slide3">
                    <div>
                        <h2>Together we shall walk it's scented air</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"></span>
                </button>
            </div>
            <div class="modal-body"></div>

            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>

<form class="form-inline" id="getPostListPic">
<input type="hidden" id="currentPage" name="currentPage" value=""/>





    <div class="container">
        <div class="addbutton" >
            <a class='btn btn-warning' id ='modaladdPostPicbt' role='button' data-toggle='collapse' href='#modaladdPostPic' aria-expanded='false' aria-controls='modaladdPostPic'>등록</a>
        </div>
        <div class="gallery">


            <c:forEach var="post" items="${list}">
            <div class="gallery-item" tabindex="0">

                <img src="../../resources/image/${post.postFile1}" class="gallery-image" alt="" >

                <input type="hidden" id="postNoNo" name="postNoNo" value="${post.postNo}"/>
                <div class="gallery-item-info">

                    <ul>
                        <li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> <span id="heart${post.postNo }">${post.heartCount }</span></li>
                        <li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> <span id="reply${post.postNo }">${post.replyCount }</span></li>
                        <li class="gallery-item-Hits"><span class="visually-hidden">Hits:</span><i class="fas fa-eye" aria-hidden="true"></i> <span id="hit${post.postNo }">${post.postHit }</span></li>

                    </ul>

                </div>

            </div>
            </c:forEach>

        </div>
    </div>














<%--
        <div id="card-box" class="cards-box">


                <div class="card" name ="card" id="card${post.postNo}" style="width: 23rem; margin-bottom:15px; margin-left: 10px;" >
                    <img class="card-img-top" src="../../resources/image/${post.postFile1}" alt="Card image cap"
                         style="border-bottom: 1px solid #eee; height: 300px;" onclick="getCardDetail(${post.postNo})">
                    <div class="card-body">
                        <ul class='card-body-ul'>

                            &lt;%&ndash;<c:if test="${sessionScope.role eq 'user'}">&ndash;%&gt;
                                <li> ${post.postUser.userId} ${post.postTruck.truckId}</li>
                            &lt;%&ndash;</c:if>
                            <c:if test="${sessionScope.role eq 'truck'}">&ndash;%&gt;
                               &lt;%&ndash; <li> ${post.postTruck.truckId}</li>&ndash;%&gt;
                            &lt;%&ndash;</c:if>&ndash;%&gt;
                            <li>${post.postTitle}</li>
                            <li>${post.postContent}</li>
                            <li>${post.postRegDate}</li>
                        </ul>


                                <c:choose>
                                    <c:when test="${ post.heartNo eq 0}">
                                        &lt;%&ndash; 빈 하트일때 &ndash;%&gt;
                                        <span>
                                            <a idx="${post.postNo }" href="javascript:" class="heart-click heart_icon${post.postNo }">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16">
                                                     <path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" />
                                                </svg>
                                            </a>
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        &lt;%&ndash; 꽉찬 하트일때 &ndash;%&gt;
                                        <span>
                                            <a idx="${post.postNo}" href="javascript:" class="heart-click heart_icon${post.postNo}">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart-fill" viewBox="0 0 16 16">
                                                 <path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z" />
                                             </svg>
                                        </a>
                                        </span>
                                    </c:otherwise>
                                </c:choose>



                        <span id="heart${post.postNo }">${post.heartCount }</span>
                        <span>
                                <a idx="${post.postNo }" href="javascript:" class="reply-click reply-icon${post.postNo }">
                                   <i class="fas fa-beer"></i>
                                </a>
                        </span>
                        <span id="reply${post.postNo }">${post.replyCount }</span>

                        <span> <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
											<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z" />
											<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z" />
										</svg>
						</span> <span id="hit${post.postNo }">${post.postHit }</span>


                    </div>
                </div>
            </c:forEach>
        </div>


    </div>
</div>--%>
</form>
<%--<div class="format">
    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="..." class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
                <img src="..." class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
                <img src="..." class="d-block w-100" alt="...">
            </div>
        </div>
        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
</div>--%>


<!-- PageNavigation Start... -->
<jsp:include page="../../common/pageNavigator.jsp"/>
<!-- PageNavigation End... -->
<script>
    $(function(){

        $("#modaladdPostPic").on('hide.bs.modal', function (e) {
            // self.location = "/catering/listCatering"
            window.location.reload();
            e.stopImmediatePropagation();
        });



    });

    $("body").on("click", ".gallery-item", function() {

        let postNo = $(this).find("input[name='postNoNo']").val()
        console.log("postNo: " + postNo);
        getCardDetail(postNo)
        /*let postNo = $(this).next();
        console.log("postNo: " + postNo);
        getCardDetail(postNo)*/
    });


    $("body").on("click", ".open_reply_list", function() {
        let postNo = $(this).attr('idx');
        console.log("postNo: " + postNo);
        ReplyList(postNo)
    });

    const ReplyList = function(no) {
        console.log("no: "+no)
        let postNo = no;
        $.ajax({
            url : '/community/json/replyList',
            type : 'get',
            data : {
                postNo : postNo
            },
            success : function(data) {

                console.log("댓글 리스트 가져오기 성공");
                console.log("data: "+data);



                // 댓글 목록을 html로 담기
                let listHtml = "";
                for(const i in data.replyList){

                    let commentNo = data.replyList[i].commentNo;
                    let commentPostNo = data.replyList[i].commentPostNo;
                    let grp = data.replyList[i].grp;
                    let grps = data.replyList[i].grps;
                    let grpl = data.replyList[i].grpl;
                    let commentUser = data.replyList[i].commentUserId;
                    let commentTruck = data.replyList[i].commentTruckId;
                    let commentContent =data.replyList[i].commentContent;
                    let commentDate = data.replyList[i].commentDate;
                    let wgap = data.replyList[i].wgap;
                    let userPro = data.replyList[i].userProImg;
                    let truckPro = data.replyList[i].truckProImg;
                    let commentUserId="";
                    let userProImg="";

                    console.log("userPro:: "+userPro)
                    if (commentUser=="" || !commentUser){
                        commentUserId = commentTruck;
                        userProImg = truckPro;
                    }else{
                        commentUserId = commentUser;
                        userProImg = userPro;
                    }

                    console.log(grpl);	// 모댓글일땐 0, 답글일땐 1
                    console.log("commentUserId: "+commentUserId)
                    console.log("userProImg: "+userProImg)

                    listHtml += "<div class='row replyrow reply" + commentNo + "'>";

                    if(commentContent == ""){		// 삭제된 댓글일때
                        listHtml += "	<div>";
                        listHtml += "		(삭제된 댓글입니다)";
                        listHtml += "	</div>";
                    }else{
                        if(grpl == 0){	// 모댓글일때
                            listHtml += "	<div class='col-1'>";
                            listHtml += "		<a href='other_profile.do?other_nick="+commentUserId+"'> ";
                            listHtml += "			<img class='reply_list_profileImage' src='/resources/image/"+userProImg+"'/>";
                            listHtml += "		</a> ";
                            listHtml += "	</div>";
                            listHtml += "	<div class='rereply-content col-8'>";
                            listHtml += "		<div>";
                            listHtml += "			<span>";
                            listHtml += "				<b>"+ commentUserId +"</b>";
                            listHtml += "			</span>";
                            listHtml += "			<span>";
                            listHtml += 				commentContent;
                            listHtml += "			</span>";
                            listHtml += "		</div>";
                            // 현재 로그인 상태일때 답글작성 버튼이 나온다.

                                listHtml += "		<div>";
                                // 함수에 게시글번호(bno), 모댓글번호(no), 모댓글 작성자(writer)를 인자로 담아서 넘긴다.
                                // 이때 모댓글 작성자 writer는 string인데 string을 인자에 넣기 위해선''나""로 감싸줘야한다.
                                // 여기선 ''와 ""가 이미 둘다 쓰이고 있는데  href를 감싸고 있는 ''와 겹치지 않는 ""를 \" 처리해서 넣어줬다.
                                //listHtml += "			<a href='#re_reply"+ commentNo +"' class='write_reply_start' role='button' data-bs-toggle='collapse' aria-expanded='false' aria-controls='re_reply"+ commentNo +"'>답글1&nbsp;달기</a>";
                                //listHtml += "			<button type='button' class='write_reply_start' no='" + commentNo + "' bno='" + commentPostNo + "' data-bs-toggle='collapse' data-bs-target='#re_reply"+ commentNo +"' aria-expanded='false' aria-controls='re_reply"+ commentNo +"'>답글&nbsp;달기</button>";
                                listHtml +="        <a class='btn btn-primary' role='button' data-toggle='collapse' href='#re_reply"+ commentNo +"' aria-expanded='false' aria-controls='collapseExample'>답글달기</a>"
                                listHtml += "		</div>";

                            listHtml += "	</div>";

                        }else{	// 답글일때
                            listHtml += "	<div class='col-1'>"
                            listHtml += "	</div>"
                            listHtml += "	<div class='col-1'>";
                            listHtml += "		<img class='reply_list_profileImage' src='/resources/image/"+userProImg+"'/>";
                            listHtml += "	</div>";
                            listHtml += "	<div class='rereply-content"+ commentNo +" col-7'>";
                            listHtml += "		<div>";
                            listHtml += "			<span>";
                            listHtml += "				<b>"+ commentUserId +"</b>";
                            listHtml += "			</span>";
                            listHtml += "			<span>";
                            listHtml += 				commentContent;
                            listHtml += "			</span>";
                            listHtml += "		</div>";

                            listHtml += "	</div>";
                        }

                        listHtml += "	<div class='col-3 reply-right'>";
                        listHtml += "		<div>";
                        listHtml += 			commentDate;
                        listHtml += "		</div>";
                        // 책갈피
                        // 현재 로그인 상태이고..


                            //현재 사용자가 이 댓글의 작성자일때 삭제 버튼이 나온다.
                            if(uId == commentUserId){
                                listHtml += "		<div>";
                                // 수정할 댓글의 no를 grpl과 함께 넘긴다.
                                // 모댓글 수정칸과 답글 수정칸을 화면에 다르게 나타내야하기 때문에 모댓글과 답글을 구분하는 grpl을 함께 넘겨주어야한다.
                                //listHtml += "			<a href='javascript:' no='"+ no +"' grpl='"+ grpl +"' class='reply_modify'>수정</a>";
                                //listHtml += "			&nbsp;|&nbsp;";
                                // 삭제는 no만 넘겨주면 된다.
                                listHtml += "			<a href='javascript:' no='"+ commentNo +"' grpl='"+ grpl + "' bno='"+ commentPostNo +"' grp='"+ grp +"' class='reply_delete'>삭제</a>";
/*
                                listHtml += '			<a class="btn btn-primary" role="button" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample">삭제</a>'
*/
                                listHtml += "		</div>";
                            }


                        listHtml += "	</div>";
                        // 댓글에 답글달기를 누르면 답글입력란이 나온다.
                        // ---- 답글입력란
                        //listHtml += "	<div class='collapse row rereply_write' id='re_reply"+ commentNo +"'>";
                        listHtml += "<div class='collapse row rereply_write' id='re_reply"+ commentNo +"'>";
                        listHtml += "		<div class='col-1'>"
                        listHtml += "		</div>"
                        listHtml += "		<div class='col-1'>"
                        listHtml += "			<a href='other_profile.do?other_nick="+uId+"'> ";
                        listHtml += "				<img id='write_reply_profileImage' src='/resources/image/"+proImg+"'/>"
                        listHtml += "			</a> ";
                        listHtml += "		</div>"
                        listHtml += "		<div class='col-7'>"
                        listHtml +=  "  		<input class='w-100 input_rereply_div form-control' id='input_rereply"+ commentNo +"' type='text' placeholder='댓글입력...'>"
                        listHtml += "		</div>"
                        listHtml += "		<div class='col-3'>"
                        // 답글달기 버튼이 눌리면 모댓글 번호(no)와 게시물번호(bno)를 함수에 전달한다.

                        // 동적으로 넣은 html태그에서 발생하는 이벤트는 동적으로 처리해줘야한다 !!!!!
                        // 예를들어, 동적으로 넣은 html태그에서 발생하는 click 이벤트는 html태그 안에서 onclick으로 처리하면 안되고, jquery에서 클래스명이나 id값으로 받아서 처리하도록 해야한다.
                        // 아래코드를 보자~~~~
                        // listHtml += "			<button onclick='javascript:WriteReReply("+ no +","+ bno +")' type='button' class='btn btn-success mb-1 write_rereply' >답글&nbsp;달기</button>"
                        // 위 코드는 클릭되어도 값이 넘겨지지 않는다. 값이 undefined가 된다.
                        // 아래코드처럼 짜야한다. click이벤트를 처리하지 않고 데이터(no, bno)만 속성으로 넘겨주도록 작성한다.<button type='button' class='btn btn-success mb-1 write_rereply' no='" + commentNo + "' bno='" + commentPostNo + "'>답글&nbsp;달기</button>"
                        listHtml += "<a href='javascript:' no='"+ commentNo + "' bno='"+ commentPostNo +"' class='write_rereply'>답글&nbsp;달기</a>";
                        listHtml += "		</div>";
                        listHtml += "	</div>";
                        // ---- 답글입력란 끝
                    }

                    listHtml += "</div>";


                };

                ///////////// 동적으로 넣어준 html에 대한 이벤트 처리는 같은 함수내에서 다 해줘야한다.
                ///////////// $(document).ready(function(){}); 안에 써주면 안된다.
                var modal = $('#staticBackdrop');
                //modal.find("span[id='m_heart'"+postNo+"]").text(heart);
                // 페이지에 하트수 갱신
                // console.log("listHtml: "+listHtml);
                // 댓글 리스트 부분에 받아온 댓글 리스트를 넣기
                modal.find(".reply-list"+postNo).html(listHtml);

                // 답글에서 답글달기를 누르면 input란에 "@답글작성자"가 들어간다.
                //$('.write_re_reply_start').on('click', function(){
                //	$('#input_rereply'+ $(this).attr('no')).val("@"+$(this).attr('writer')+" ");
                //});

                //답글을 작성한 후 답글달기 버튼을 눌렀을 때 그 click event를 아래처럼 jquery로 처리한다.
                $('.write_rereply').on( 'click', function() {
                    console.log( 'no', $(this).attr('no') );
                    console.log( 'bno', $(this).attr('bno') );

                    // 답글을 DB에 저장하는 함수를 호출한다. bno와 no를 같이 넘겨주어야한다.
                    WriteReReply($(this).attr('bno'), $(this).attr('no') );
                })

                // 삭제버튼을 클릭했을 때
                $('.reply_delete').on('click', function(){
                    // 모댓글 삭제일때
                    if($(this).attr('grpl') == 0){
                        DeleteReply($(this).attr('no'), $(this).attr('bno'));

                        // 답글 삭제일때
                    }else{

                        DeleteReReply($(this).attr('no'), $(this).attr('bno'), $(this).attr('grp'));
                    }

                })


            },
            error : function() {
                alert('서버 에러');
            }
        });


    };

    // 답글 달기 버튼 클릭시  실행 - 답글 저장, 댓글 갯수 가져오기
    const WriteReReply = function(bno,no) {


        console.log(bno);
        console.log(no);

        console.log($("#input_rereply" + no).val());

        // 댓글 입력란의 내용을 가져온다.
        // ||"" 를 붙인 이유  => 앞뒤 공백을 제거한다.(띄어쓰기만 입력했을때 댓글작성안되게 처리하기위함)
        let content = $("#input_rereply" + no).val();
        content = content.trim();


        if(content == ""){	// 입력된게 없을때
            alert("글을 입력하세요!");
        }else{
            // 입력란 비우기
            $("#input_rereply" + no).val("");

            // reply+1 하고 그 값을 가져옴
            $.ajax({
                url : '/community/json/write_rereply',
                type : 'get',
                data : {
                    commentNo : no,
                    commentPostNo : bno,
                    commentContent: content
                },
                success : function(pto) {

                    let reply = pto.replyCount;
                    // 페이지, 모달창에 댓글수 갱신
                    var modal = $('#staticBackdrop');

                    // 페이지에 하트수 갱신

                    // 페이지, 모달창에 댓글수 갱신
                    modal.find('#m_reply'+bno).text(reply);//
                    $('#reply'+bno).text(reply);

                    console.log("답글 작성 성공");

                    // 게시물 번호(bno)에 해당하는 댓글리스트를 새로 받아오기
                    ReplyList(bno);
                },
                error : function() {
                    alert('서버 에러');
                }
            });

        };
    };
    // 글 수정
    const updatePostPicView = function(postNo){

        $.ajax({
            url : '/community/json/getPostPic',
            type : 'get',
            data : {
                postNo : postNo
            },
            success : function(pto) {
                //$('#modaladdPostPic').modal('hide');
                var modalPic = $("#staticBackdrop");
                var div ="";


               div += " <form class='form-horizontal' id='updatePostPicViewForm'>"
                +"<div class='form-group'>"
                    +"<span> 아이디 </span>"
                    +"<span id='postId'>"+uId+"</span>"
                  + "  </div>"
                    +"<div class='form-group'>"
                      +" <label for='postFile1' class='col-sm-offset-1 col-sm-10 control-label'>파일 이미지1</label>"
                       + "<div class='col-sm-10'>"
                           + "<input type='file' class='form-control' id='postFile1' name='postFile11'  value='"+pto.post.postFile1+"' placeholder='파일 이미지1' onchange='setImage1Preview(event, 0);'>"
                       + "</div>"
                       + "<div id='m_image1preview' class='col-sm-10'><img src='../../../resources/image/"+pto.post.postFile1+" '></div>"
                   + "</div>"
                    +"<div class='form-group'>"
                       +" <label for='postFile2' class='col-sm-offset-1 col-sm-10 control-label'>파일 이미지2</label>"
                      + " <div class='col-sm-10'>"
                          +  "<input type='file' class='form-control' id='postFile2' name='postFile22'  value='"+pto.post.postFile2+"' placeholder='파일 이미지2' onchange='setImage2Preview(event, 0);'>"
                       + "</div>"
                       + "<div id='m_image2preview' class='col-sm-10'></div>"
                   + "</div>"
                   + "<div class='form-group'>"
                       + "<label for='postFile3' class='col-sm-offset-1 col-sm-10 control-label'>파일 이미지3</label>"
                       +" <div class='col-sm-10'>"
                          + " <input type='file' class='form-control' id='postFile3' name='postFile33'  value='"+pto.post.postFile3+"' placeholder='파일 이미지3' onchange='setImage3Preview(event, 0);'>"
                        +"</div>"
                        +"<div id='m_image3preview' class='col-sm-10'><img src='../../../resources/image/"+pto.post.postFile3+" '></div>"
                   +" </div>"
                +"<div id='here'></div>"
                +"<div class='form-group'>"
                    +"<textarea id='postContent' name = 'postContent' style='resize:none;' rows='5' cols='55' title='내용을 입력해 주세요.'>"+pto.post.postContent+"</textarea>"
                   +"<input name='postNo' type='hidden' value='"+postNo+"'>"
              + " </div>"
                +"</form>";
               div2="";
               div2+=
                   "<button class='button btn-warning' name='updatePostPic' onclick='fncUpdatePostPic();'>수정"
                   +"</button>"
                   +"<button class='btn btn-secondary' data-dismiss='modal'>취소"
                   + "</button>" ;
                modalPic.find('.modal-body').html(div);
                modalPic.find('.modal-footer').html(div2);
                //$('#modaladdPostPic').modal('show');


            },
            error : function() {
                alert('서버 에러');
            }
        });
    }

    function fncUpdatePostPic(){

        $("#updatePostPicViewForm").attr("method", "POST").attr("action","/community/updatePostPic").attr("enctype", "multipart/form-data").submit();

    }
    const updatePostPic = function(postNo){
        var modalPic = $("#modaladdPostPic");




    }
    // 글 삭제
    const deletePostPic = function(postNo){
        $.ajax({
            url : '/community/json/deletePostPic',
            type : 'get',
            data : {
                postNo : postNo
            },
            success : function(pto) {

                alert("게시물이 삭제되었습니다.")
                // 삭제 완료 후 reload
                window.location.reload();
            },
            error : function() {
                alert('서버 에러');
            }
        });
    }
    // 모댓글 삭제일때
    const DeleteReply = function(no, bno){
        // grp이 no인 댓글이 있는 경우 content에 null을 넣고 없으면 삭제한다.
        $.ajax({
            url : '/community/json/delete_reply',
            type : 'get',
            data : {
                commentNo : no,
                commentPostNo : bno
            },
            success : function(pto) {

                let reply = pto.replyCount;
                var modal = $('#staticBackdrop');

                // 페이지에 하트수 갱신

                // 페이지, 모달창에 댓글수 갱신
                modal.find('#m_reply'+bno).text(reply);
                $('#reply'+bno).text(reply);

                console.log("모댓글 삭제 성공");

                // 게시물 번호(bno)에 해당하는 댓글리스트를 새로 받아오기
                ReplyList(bno);
            },
            error : function() {
                alert('서버 에러');
            }
        });
    };

    // 답글 삭제일때
    const DeleteReReply = function(no, bno, grp){

        //console.log("grp : " + grp);
        console.log("no: "+no+", bno: "+bno+", grp: "+grp)
        // 답글을 삭제한다.
        $.ajax({
            url : '/community/json/delete_rereply',
            type : 'get',
            data : {
                commentNo : no,
                commentPostNo : bno,
                grp : grp
            },
            success : function(pto) {
                alert("!!!!!!!!!!!!!!!!!")
                let reply = pto.replyCount;

                var modal = $('#staticBackdrop');

                // 페이지에 하트수 갱신

                // 페이지, 모달창에 댓글수 갱신
                modal.find('#m_reply'+bno).text(reply);
                $('#reply'+bno).text(reply);

                console.log("답글 삭제 성공");

                // 게시물 번호(bno)에 해당하는 댓글리스트를 새로 받아오기
                ReplyList(bno);
            },
            error : function() {
                alert('서버 에러');
            }
        });

    };


    $("body").on("click", ".heart-click", function() {
   // $(".heart-click").click(function () {

        // 게시물 번호(no)를 idx로 전달받아 저장
        let postNo = $(this).attr('idx');
        console.log("postNo: " + postNo);

        // 빈하트를 눌렀을때
        if ($(this).children('svg').attr('class') == "bi bi-suit-heart") {
            console.log("빈하트 클릭" + postNo);

            $.ajax({
                url: 'json/addHeart',
                type: 'get',
                data: {
                    postNo: postNo,
                },
                success: function (pto) {
                    //페이지 새로고침
                    //document.location.reload(true);
                    console.log("pto: "+pto.heartCount)
                    let heart = pto.heartCount;

                    var modal = $('#staticBackdrop');
                    //modal.find("span[id='m_heart'"+postNo+"]").text(heart);
                     // 페이지에 하트수 갱신
                     modal.find('#m_heart'+postNo).text(heart);
                     $('#heart'+postNo).text(heart);

                    console.log("하트 추가!!!!!!!!!!");
                },
                error: function () {
                    alert('서버 에러');
                }
            });
            console.log("하트채워");

            // 꽉찬하트로 바꾸기
            $(this).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
            $('.heart_icon' + postNo).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");

            // 꽉찬 하트를 눌렀을 때
        } else if ($(this).children('svg').attr('class') == "bi bi-suit-heart-fill") {
            console.log("꽉찬거 하트 클릭 " + postNo);

            $.ajax({
                url: 'json/removeHeart',
                type: 'get',
                data: {
                    postNo: postNo,
                },
                success: function (pto) {
                    //페이지 새로고침
                    //document.location.reload(true);
                    console.log("pto: "+pto)
                    let heart = pto.heartCount;
                    // 페이지에 하트수 갱신
                   //
                    var modal = $('#staticBackdrop');

                    modal.find('#m_heart'+postNo).text(heart);
                    $('#heart'+postNo).text(heart);

                    console.log("하트삭제!!!!!!!!!");
                },
                error: function () {
                    alert('서버 에러');
                }
            });
            console.log("빈하트!!!!!!!!!");

            // 빈하트로 바꾸기
            $(this).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');

            $('.heart_icon' + postNo).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
        }


    });

    $("body").on("click", ".write_reply", function() {
        var modal = $('#staticBackdrop');
        // 게시물 번호
        let postNo = $(this).attr('idx');
        console.log("postNo: "+postNo)
        //책갈피
        // 댓글 입력란의 내용을 가져온다.
        let commentContent =  modal.find("#input_reply" + postNo).val();
        console.log("commentContent : "+commentContent)
        // 앞뒤 공백을 제거한다.(띄어쓰기만 입력했을때 댓글작성안되게 처리하기위함)
        commentContent = commentContent.trim();

        console.log(commentContent);

        if(commentContent == ""){	// 입력된게 없을때
            alert("글을 입력하세요!");
        }else{
            // 입력란 비우기
            modal.find("#input_reply" + postNo).val("");

            // reply+1 하고 그 값을 가져옴
            $.ajax({
                url : '/community/json/write_reply',
                type : 'get',
                data : {
                    postNo : postNo,
                    commentContent: commentContent
                },
                success : function(pto) {

                    let reply = pto.replyCount;
                    // 페이지, 모달창에 댓글수 갱신
                    var modal = $('#staticBackdrop');

                    modal.find('#m_reply'+postNo).text(reply);
                    $('#reply'+postNo).text(reply);

                    console.log("댓글 작성 성공");

                    // 댓글리스트를 새로 받아오기
                    ReplyList(postNo);
                },
                error : function() {
                    alert('서버 에러');
                }
            });

        }

    });

    ////// 등록할 모달창 show
    $("body").on("click", "a[id='modaladdPostPicbt']", function() {
        $('#modaladdPostPic').modal('show');
    });

    /////////// 글등록
    $(function(){

        $('#add-post-p').on("click", function(){

            fncAddPostPic();

        });

    });

    function fncAddPostPic(){

        $("#modaladdPostPicForm").attr("method", "POST").attr("action","/community/addPostPic").attr("enctype", "multipart/form-data").submit();

    }


</script>



</body>
</html>