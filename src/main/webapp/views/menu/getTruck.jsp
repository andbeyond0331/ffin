<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>메뉴 목록</title>
    <jsp:include page="../../common/lib.jsp"/>

    <style>

        #dataTable thead tr th, #dataTable tbody tr td{
            text-align: center;
        }

        #dataTable tbody tr:hover{
            color: #ffba49;
        }

        .form-inline{
            float: right;
            padding-right: 20px;
        }
        .card.mb-10{
            width: auto;
            min-height: 50px;
            box-shadow: 0 1px 2px 1px rgba(0,0,0,0.1);
            transition: 0.2s;
            margin-top: 5px;
            display: flex;
            justify-content: center;
            font-size: 16px;
        }
        .card.mb-10:hover{
            background-color: rgba(255, 229, 55, 0.16);
        }
        .card.mb-10.sub-title:hover{
            background-color: rgb(255, 255, 255);
        }
        .card-ans{
            box-shadow: 0 1px 2px 1px rgba(0,0,0,0.2);
            transition: 0.2s;
            margin-top: 5px;
            /*display: flex;
            justify-content: flex-start;*/
            text-align: left;
            font-size: 14px;
            padding: 30px;
        }
        .card-body {
            padding: 0;
        }
        .card-text{
            padding: 0;
        }
        .inquiry-card{
            display: flex;
            justify-content: space-around;
        }
        .inquiry-con{
            padding: 0;
        }
        .d-grid.gap-2.col-6.mx-auto{
            display: flex;
            justify-content: center;
        }
        #inquiryAnsContent{
            min-height: 150px;
        }
    </style>



    <script>
        <%--        메뉴 상세보기 모달에서 장바구니에 담기!--%>

        $(function(){

            var modalApply = $('#exampleModalLong');

            //처음 로드했을 때 기존 세션 장바구니의 정보 가져와서 장바구니에 뿌리기

            //  처음 화면에 담기

            var targetCartFirst = $('div.sticky').find('ul'); //주문 목록 담길 장바구니

            var beforeAnywayFirst = JSON.parse(sessionStorage.getItem("menuOdList")); //세션에 있는 애 가져와서 json파싱

            for( var i in beforeAnywayFirst){
                // console.log("beforeAnyway : " + beforeAnyway[i]);
                for(var j in beforeAnywayFirst[i]){
                    console.log(" 처음 화면에 뿌리기 전 점검 afterAnyway key : " +j+"/value : " + beforeAnywayFirst[i][j]);

                }
            } //세션에 있는 애 확인
            //담을 li

            var finalCartFirst = "";
            var forOneFirst=0;

            // ////////////시작///////////////////
            if(beforeAnywayFirst) { // sessionStorage에 뭔가 있다?
                console.log("처음 sessionStorage에 있다! 화면 뿌려주기 준비 시작!");
                for (var i = 0; i < beforeAnywayFirst.length; i++) {//sessionStorage의 orderDetail만큼 for문 돌리기

                    console.log("처음 for문 안에 있다!");
                    console.log("처음 beforeAnywayFirst[" + i + "]번째 세션 : " + JSON.stringify(beforeAnywayFirst[i]));
                    // finalCart += "<li class=\"list-group-item d-flex justify-content-between lh-sm\">"+
                    //     "<div><h6 class=\"my-0\">"+beforeAnyway[i]['odMenuName']+"</h6>"+
                    //     "<h6 class=\"my-0\">"+beforeAnyway[i]['odMenuQty']+"</h6>"+
                    //     "<small class=\"text-muted\">"+beforeAnyway[i]['odOptionGroupName']+"</small>"+
                    //     "<small class=\"text-muted\">"+beforeAnyway[i]['odOptionName']+"</small>"+
                    //     "</div><span class=\"text-muted\">"+beforeAnyway[i]['odMenuPrice']+"</span></li>";

                    if (beforeAnywayFirst[i]['odMenuQtyFlag'] == 0) {//플래그0일 때 메뉴 수량, 이름 출력
                        finalCartFirst += "" +
                            "<li class=\"list-group-item d-flex justify-content-between lh-sm\">" +
                            "<button type='button' class='close' id='cancelMenu'>"+
                            "<span aria-hidden='true'>&times;</span></button>"+
                            "<div><h6 class=\"my-0\">" + beforeAnywayFirst[i]['odMenuName'] + "</h6>" +
                            "<h6 class=\"my-0\">수량 : <input type='button' class='my-11' value='-' id='decreaseQuantity'>" +
                            "<input type='hidden' name='orderCount' value='"+i+"'>"+
                            " <input type='text' id='numberUpDown' value='" + beforeAnywayFirst[i]['odMenuQty'] + "' size='1' max=''> " +
                            "<input type='button' value='+' id='increaseQuantity'> </h6>" +
                            "";
                        //2022-01-16
                        // finalCartFirst += "" +
                        //     "<li class=\"list-group-item d-flex justify-content-between lh-sm\">" +
                        //     "<div><h6 class=\"my-0\">" + beforeAnywayFirst[i]['odMenuName'] + "</h6>" +
                        //     "<h6 class=\"my-0\">수량 : " + beforeAnywayFirst[i]['odMenuQty'] + "</h6>" +
                        //     "";
                        forOneFirst += 1;
                        if (beforeAnywayFirst[i + 1] != null) { //만약 다음 애가 있는데
                            if (beforeAnywayFirst[i + 1]['odMenuQtyFlag'] == 0) { //수량제공메뉴이면(지금 이게 수량제공메뉴란 소리니까 닫아줘야함)
                                finalCartFirst += "</div><span class=\"text-muted\">" + beforeAnywayFirst[i]['odMenuPrice'] + "원</span></li>";
                            }

                        }else{ //만약 다음 애가 없으면
                            finalCartFirst += "</div><span class=\"text-muted\">" + beforeAnywayFirst[i]['odMenuPrice'] + "원</span></li>";
                        }
                    } else { //플래그 1일 때
                        // for(var j=i+1; j<beforeAnyway.length; j++){ //옵션그룹 화면에 뿌려주기 위한 for문 (수량제공메뉴+1부터
                        //     if(beforeAnyway[j]['odMenuQtyFlag']==1){
                        finalCartFirst += "" +
                            "<p></p>" +
                            "<input type='hidden' name='orderCancelCount' value='"+i+"'>"+
                            "<small class=\"text-muted\">" + beforeAnywayFirst[i]['odOptionGroupName'] + "</small> : " +
                            "<small class=\"text-muted\">" + beforeAnywayFirst[i]['odOptionName'] + "</small> +" +
                            "<small class=\"text-muted\">" + beforeAnywayFirst[i]['odOptionPrice'] + "원</small>";
                        //2022-01-16
                        // finalCartFirst += "" +
                        //     "<p></p>" +
                        //     "<small class=\"text-muted\">" + beforeAnywayFirst[i]['odOptionGroupName'] + "</small> : " +
                        //     "<small class=\"text-muted\">" + beforeAnywayFirst[i]['odOptionName'] + "</small> +" +
                        //     "<small class=\"text-muted\">" + beforeAnywayFirst[i]['odOptionPrice'] + "원</small>";
                        //
                        forOneFirst += 1;
                        if (beforeAnywayFirst[i + 1] != null) {
                            if (beforeAnywayFirst[i + 1]['odMenuQtyFlag'] == 0) {
                                finalCartFirst += "</div><span class=\"text-muted\">" + beforeAnywayFirst[i]['odMenuPrice'] + "원</span></li>";
                            }

                        }

                        // finalCart+="</div><span class=\"text-muted\">"+beforeAnyway[i]['odMenuPrice']+"원</span></li>";
                        // i=forOne;


                    }//sessionStorage만큼 for문 돌리기
                }
                console.log("하하"+targetCartFirst.html());
                console.log("호호"+finalCartFirst);
                targetCartFirst.html(finalCartFirst);
            }




            // location.reload();

            //처음 화면에 담기 끝




            $(document).on("click", "#addCart", function(){
                var menuOdList = [];

                //원래 세션에 있는가?
                var originalSession = [];
                var getItem = sessionStorage.getItem("menuOdList");
                //alert("원래 세션 : " + getItem);
                if(getItem){

                    originalSession = JSON.parse(sessionStorage.getItem("menuOdList"));

                    if(originalSession){
                        for(var i=0; i<originalSession.length; i++){
                            menuOdList.push(originalSession[i]);
                            //alert("원래꺼 담는 중 담을거: " + originalSession[i]);
                            //alert("원래꺼 담는 중 담긴 menuOdList: " + menuOdList);
                        }
                    }


                }
                //수량 제공 역할 메뉴 만들기
                /* alert("modalApply data-menuimg : " + modalApply.find('div[name="odMenuImg1"]').data('menuimg'));*/

                var orderDetail = {
                    menuTruckId : modalApply.find('h3[name="menuTruckId"]').text(),
                    odMenuNo : modalApply.find('div[name="odMenuNo"]').text(),
                    odMenuName : modalApply.find('div[name="odMenuName"]').text(),
                    odMenuImg1 : modalApply.find('div[name="odMenuImg1"]').data('menuimg'),
                    odMenuDetail : modalApply.find('div[name="odMenuDetail"]').text(),
                    odMenuPrice : modalApply.find('div[name="odMenuPrice"]').text(),
                    odMenuQty : 1,
                    odMenuQtyFlag : 0,
                    odOptionName : '',
                    odOptionGroupNo : '',
                    odOptionGroupName : '',
                    odOptionNo : '',
                    odOptionPrice : 0,
                };
                //
                // if(getItem!=null && getItem!=""){
                //
                //     originalSession = JSON.parse(sessionStorage.getItem("menuOdList"));
                //
                //     for(var i=0; i<originalSession.length; i++){
                //         if(originalSession[i]['odMenuNo']==orderDetail)
                //         // menuOdList.push(originalSession[i]);
                //         //alert("원래꺼 담는 중 담을거: " + originalSession[i]);
                //         //alert("원래꺼 담는 중 담긴 menuOdList: " + menuOdList);
                //     }
                //
                // }


                //alert("orderDetail : " + orderDetail);

                //수량 제외 옵션그룹 정보 만들기

                //     //optionGroup
                //
                if(modalApply.find('input:radio:checked')){
                    var isThereOptionGroup = modalApply.find('input:radio:checked').length;
                }

                var odOptionGroupList = [];

                ///////////////////////////
                //console.log("1111111111111111 : " + menuOdList);
                ///////////////////////////

                if(isThereOptionGroup){ //만약 체크된 라디오 박스가 있다면
                    for (let i = 0; i < isThereOptionGroup; i++) {
                        var optionGroupOrderDetail = {
                            menuTruckId : modalApply.find('h3[name="menuTruckId"]').text(),
                            odMenuNo : modalApply.find('div[name="odMenuNo"]').text(),
                            odMenuName : modalApply.find('div[name="odMenuName"]').text(),
                            odMenuImg1 : modalApply.find('div[name="odMenuImg1"]').data('menuimg'),
                            odMenuDetail : modalApply.find('div[name="odMenuDetail"]').text(),
                            odMenuPrice : modalApply.find('div[name="odMenuPrice"]').text(),
                            odMenuQty : 1,
                            odMenuQtyFlag : 1,
                            odOptionName : modalApply.find('input:radio:checked').eq(i).data("op"),
                            odOptionGroupNo : modalApply.find('input:radio:checked').eq(i).parent('div').find('input[name="odOptionGroupNo"]').val(),
                            odOptionGroupName : modalApply.find('input:radio:checked').eq(i).parent('div').find('input[name="odOptionGroupName"]').val(),
                            odOptionNo : modalApply.find('input:radio:checked').eq(i).parent('div').find('input[name="odOptionNo"]').val(),
                            odOptionPrice : modalApply.find('input:radio:checked').eq(i).parent('div').find('input[name="odOptionPrice"]').val()


                        }

                        odOptionGroupList.push(optionGroupOrderDetail);
                    }
                }
///////////////////////////
                //console.log("22222222222222222222 : " + menuOdList);
                var didYouAdd = 0; //session에 add했는지 여부

                ///////////////////////////
                if(!isThereOptionGroup){///////추가하고자 하는 옵션그룹==0일 때
                    if(originalSession.length){//세션 널체크
                        // if(isThereOptionGroup==0 && originalSession!=0 &&originalSession!=null){

                        if(originalSession.length==1){// 만약 session의 od 갯수가 1일 때
                            /// 1-1. 지금 담으려고 하는 수량 정보 제공 메뉴랑 od가 1개인 애의 menuNo 비교 - 같을 때
                            if(originalSession[0]['odMenuNo']==orderDetail['odMenuNo']){
                                // 수량 추가
                                //console.log("1-1 : 수량 추가 이전 ="+originalSession[0]['odMenuQty']);
                                orderDetail['odMenuQty']=originalSession[0]['odMenuQty']+1;
                                //console.log("1-1 : 수량 추가 이후 ="+orderDetail['odMenuQty']);
                                //수량 추가된 메뉴를 list의 첫번째 요소와 바꾼다.(어차피 하나)
                                //console.log("1-1 : list 첫번째 요소 바꾸기 전 : "  +menuOdList[0]);
                                menuOdList[0]=(orderDetail);
                                //console.log("1-1 : list 첫번째 요소 바꾼 후 : "  +menuOdList[0]);
                                //list의 json을 스트링으로 만들어서 menu에 넣고 session에 담는다.(겉으로는 수량이 추가된 것
                                sessionStorage.setItem("menuOdList", JSON.stringify(menuOdList));
                                didYouAdd++;
                                //console.log("didYouAdd(1 초과 불가) : "+didYouAdd );

                                //console.log("1-1. 수량 추가 로직 끝"); //완료
                            }
                            else{/// 1-2. 지금 담으려고 하는 수량 정보 제공 메뉴랑 od가 1개인 애의 menuNo 비교 - 다를 때
                                // 원래 있던 session에 수량 정보 제공 메뉴 하나 더 담기
                                // console.log("1-2 : 하나 더 담기 이전 ="+JSON.stringify(menuOdList[0]));
                                menuOdList.push(orderDetail);
                                //console.log("1-2 : 하나 더 담기 이후 ="+JSON.stringify(menuOdList[0]));

                                //list의 json을 스트링으로 만들어서 menu에 넣고 session에 담는다.(겉으로는 수량이 추가된 것
                                sessionStorage.setItem("menuOdList", JSON.stringify(menuOdList));
                                didYouAdd++;
                                //console.log("didYouAdd(1 초과 불가) : "+didYouAdd );

                                //console.log("1-2. 하나 더 담기 로직 끝"); //완료
                                /////////////////
                                //console.log("3333333333333333 : " + menuOdList);
                            }
                        }// 만약 session의 od 갯수가 1일 때 끝 - 완료

                        else{// 만약 session의 od 갯수가 1과 0이 아닐 때 (0인 경우는 한 단계 outer에 있음 - null check 시
                            //console.log("@@@@@@i : "  +i  );
                            //console.log("$$$$originalSession.length : " +originalSession.length);
                            //qtyFlag가 0인 애 찾기
                            for(var i=0; i<originalSession.length;i++){//qtyFlag가 0인 애가 있으면서 추가 메뉴와 같을 때 이 안에서 session 저장 끝남
                                if(i===originalSession.length-1){// 마지막 요소
                                    //console.log("@@@@@@i :  마지막요소 : "  +i  );
                                    //console.log("$$$$originalSession.length : " +originalSession.length);
                                    if(originalSession[i]['odMenuQtyFlag']===0){ //2.마지막 요소가 수량 제공 메뉴일 때
                                        //console.log("!!!!!!!!!!!!1originalSession["+i+"]['odMenuNo'] : " + JSON.stringify(originalSession)[i]['odMenuNo']);
                                        //console.log("!!!!!!!!!!!!orderDetail["+i+"]['odMenuNo'] : " + JSON.stringify(orderDetail)[i]['odMenuNo']);
                                        if(originalSession[i]['odMenuNo']===orderDetail['odMenuNo']){ //2-1.마지막 요소가 추가할 수량 제공 메뉴와 같을 때
                                            // 수량 추가
                                            //console.log("2-1 : 수량 추가 이전 ="+originalSession[i]['odMenuQty']);
                                            orderDetail['odMenuQty']=originalSession[i]['odMenuQty']+1;
                                            //console.log("2-1 : 수량 추가 이후 ="+orderDetail['odMenuQty']);
                                            //수량 추가된 메뉴를 list의 마지막 요소와 바꾼다.
                                            //console.log("2-1 : list 마지막 요소 바꾸기 전 : "  +menuOdList[i]);
                                            menuOdList[i]=(orderDetail);
                                            //console.log("2-1 : list 마지막 요소 바꾼 후 : "  +menuOdList[i]);
                                            //list의 json을 스트링으로 만들어서 menu에 넣고 session에 담는다.(겉으로는 수량이 추가된 것
                                            sessionStorage.setItem("menuOdList", JSON.stringify(menuOdList));
                                            didYouAdd++;
                                            //console.log("didYouAdd(1 초과 불가) : "+didYouAdd );

                                            //console.log("2-1. 마지막 요소 수량 추가 로직 끝");

                                        }//2-1.마지막 요소가 수량 제공 메뉴와 같을 때 끝

                                    }//2.마지막 요소가 수량 제공 메뉴일 때 끝
                                }else if(originalSession[i]['odMenuQtyFlag']==0){ //3. 마지막 요소가 아니면서 수량제공메뉴일 때

                                    if(originalSession[i+1]!=null && originalSession[i]['odMenuNo']!=originalSession[i+1]['odMenuNo']){//3-1. 옵션그룹이 없는 메뉴이면,
                                        if(originalSession[i]['odMenuNo']==orderDetail['odMenuNo']){//3-1-1.추가할 메뉴랑 같을 때
                                            // 수량 추가
                                            //console.log("3-1-1 : 수량 추가 이전 ="+originalSession[i]['odMenuQty']);
                                            orderDetail['odMenuQty']=originalSession[i]['odMenuQty']+1;
                                            //console.log("3-1-1 : 수량 추가 이후 ="+orderDetail['odMenuQty']);
                                            //수량 추가된 메뉴를 list의 요소와 바꾼다.
                                            //console.log("3-1-1 : list 요소 바꾸기 전 : "  +menuOdList[i]);
                                            menuOdList[i]=(orderDetail);
                                            //console.log("3-1-1 : list 요소 바꾼 후 : "  +menuOdList[i]);
                                            //list의 json을 스트링으로 만들어서 menu에 넣고 session에 담는다.(겉으로는 수량이 추가된 것
                                            sessionStorage.setItem("menuOdList", JSON.stringify(menuOdList));
                                            didYouAdd++;
                                            //console.log("didYouAdd(1 초과 불가) : "+didYouAdd );

                                            //console.log("3-1-1. 요소 수량 추가 로직 끝");

                                        }//3-1-1.추가할 메뉴랑 같을 때 끝
                                        else{//3-1-2. 추가할 메뉴랑 다를 때

                                        }//3-1-2. 추가할 메뉴랑 다를 때 끝
                                    }//3-1. 옵션그룹이 없는 메뉴이면, 끝

                                }//3. 마지막 요소가 아니면서 수량제공메뉴일 때 끝
                            }//qtyFlag가 0인 애가 있으면서 추가 메뉴와 같을 때 이 안에서 session 저장 끝남
///////////////////////////
                            //console.log("44444444444444444444444444 : " + menuOdList);
                            ///////////////////////////
                            //console.log("didYouAdd(1 초과 불가) : "+didYouAdd );
                            if(didYouAdd==0){//4.만약 세션에 추가메뉴가 저장되지 않았다면

                                // 원래 있던 session에 수량 정보 제공 메뉴 하나 더 담기
                                //console.log("4 : 하나 더 담기 이전 ="+JSON.stringify(menuOdList));
                                menuOdList.push(orderDetail);
                                //console.log("4 : 하나 더 담기 이후 ="+JSON.stringify(menuOdList));

                                //list의 json을 스트링으로 만들어서 menu에 넣고 session에 담는다.
                                sessionStorage.setItem("menuOdList", JSON.stringify(menuOdList));

                                //console.log("4. 하나 더 담기 로직 끝");
                            }//4.만약 세션에 추가메뉴가 저장되지 않았다면 끝

///////////////////////////
                            //console.log("5555555555555555 : " + menuOdList);
                            ///////////////////////////
                        }// 만약 session의 od 갯수가 1과 0이 아닐 때 끝

                    }
                    else {///만약 session의 od 갯수가 0일 때
                        //list에 수량 정보 제공 메뉴 넣고 session에 담기
                        if(didYouAdd==0) {
                            //console.log("////1111///////orderDetail : " + JSON.stringify(orderDetail));
                            //console.log("//////11111111/////menuOdList : " + JSON.stringify(menuOdList));
                            menuOdList.push(orderDetail);
                            sessionStorage.setItem("menuOdList", JSON.stringify(menuOdList));
                            didYouAdd++;
                            //console.log("didYouAdd : " +didYouAdd);

                            var beforeAnyway = JSON.parse(sessionStorage.getItem("menuOdList"));

                            for( var i in beforeAnyway){
                                // console.log("beforeAnyway : " + beforeAnyway[i]);
                                for(var j in beforeAnyway[i]){
                                    //console.log("afterAnyway key : " +j+"/value : " + beforeAnyway[i][j]);

                                }
                            }


                        }
                    }///만약 session의 od 갯수가 0일 때 끝
                }///////추가하고자 하는 옵션그룹==0일 때 끝
///////////////////////////
                //console.log("666666666666666666 : " + menuOdList);
                ///////////////////////////

                ///////////////////////////추가하고자 하는 옵션그룹이 없고(위)있고 (아래)
                var didYouAddOp = 0; //session에 add했는지 여부
                if(isThereOptionGroup ){///////추가하고자 하는 옵션그룹!=0일 때
                    //console.log("가");
                    // if(originalSession.length){ //세션에 담긴 애가 있을 때
                    //console.log("가가");
                    if(originalSession.length==1){//aaa. 만약 session의 od 갯수가 1일 때
                        // console.log("가가가");
                        // 원래 있던 session에 수량 정보 제공 메뉴랑 옵션 담기
                        //console.log("aaa : 담기 이전 ="+JSON.stringify(menuOdList));
                        menuOdList.push(orderDetail);
                        //console.log("aaa : 담기 이후 ="+JSON.stringify(menuOdList));
                        // 원래 있던 session에 수량 정보 제공 메뉴 하나 더 담기
                        //console.log("aaa : 옵션 더 담기 이전 ="+JSON.stringify(menuOdList));

                        for(var i=0; i<odOptionGroupList.length; i++){
                            menuOdList.push(odOptionGroupList[i]);
                        }

                        //console.log("aaa : 옵션 더 담기 이후 ="+JSON.stringify(menuOdList));


                        //list의 json을 스트링으로 만들어서 menu에 넣고 session에 담는다.
                        sessionStorage.setItem("menuOdList", JSON.stringify(menuOdList));
                        didYouAddOp++;
                        //console.log("didYouAddOp(1 초과 불가) : "+didYouAddOp );
                        //console.log("aaa. 담기 로직 끝"); //완료

                    }// 만약 session의 od 갯수가 1일 때 끝 - 완료

                        //
                    //
                    else if(originalSession.length>1){// 만약 session의 od 갯수가 1과 0이 아닐 때 (0인 경우는 한 단계 outer에 있음 - null check 시
                        //console.log("가가가가");
                        //qtyFlag가 0인 애 찾기
                        //
                        //     var arrayMenuZero = []; //수량제공메뉴 파악해서 모아두기
                        //     for(var zero=0; zero<originalSession.length; zero++){
                        //         if(originalSession[zero]['odMenuQtyFlag']===0){
                        //
                        //             arrayMenuZero.push(zero);
                        //         }
                        //     }
                        //     console.log("00000");
                        //     console.log("00000arrayMenuZero : " + arrayMenuZero);
                        //     console.log("00000");
                        //
                        //     var arrayMatch = [];
                        //
                        //
                        //     if(arrayMenuZero.length>1){
                        //         for(var match=0; match<arrayMenuZero.length-1; match++){
                        //             // arrayMenuZero[match+1]*=1;
                        //             // arrayMenuZero[match]*=1;
                        //             arrayMatch.push(arrayMenuZero[match+1]-arrayMenuZero[match]-1);
                        //         }
                        //     }else{
                        //         arrayMatch.push(isThereOptionGroup);
                        //     }
                        //
                        //     console.log("11111");
                        //     console.log("11111arrayMatch : " + arrayMatch);
                        //     console.log("11111");
                        //
                        //     var hard = 0;
                        //     var comparisonTarget = []; //여기에 옵션그룹 수가 같아서 비교 대상이 되는 수량제공메뉴의 순서가 들어감
                        //
                        //     if(arrayMatch!=0){
                        //         for(var aOrB=0; aOrB<arrayMatch.length; aOrB++){
                        //             if(isThereOptionGroup===arrayMatch[aOrB]){
                        //                 ++hard;
                        //                 comparisonTarget.push(arrayMenuZero[aOrB]);
                        //
                        //             }
                        //         }
                        //     }else {
                        //         if (isThereOptionGroup === originalSession.length - 1) {
                        //             ++hard;
                        //         }
                        //     }
                        //
                        //
                        //
                        //     console.log("22222");
                        //     console.log("22222comparisonTarget : " + comparisonTarget);
                        //     console.log("22222");
                        //
                        //     console.log("hard : " +hard);
                        //
                        //     // hard가 0일 때 그냥 단순 push 하면 되고, 0이 아닐 때는 comparisonTarget에 담긴 순서에 있는 애를 비교
                        //     if(hard===0){ //단순 올리기
                        //         ///////////////////////////////
                        //         // 원래 있던 session에 수량 정보 제공 메뉴 하나 더 담기
                        //         console.log("hard가 0일 때 : " +hard);
                        //         menuOdList.push(orderDetail);
                        //
                        //         if(isThereOptionGroup!=0){
                        //             for(var i=0; i<odOptionGroupList.length; i++){
                        //                 menuOdList.push(odOptionGroupList[i]);
                        //             }
                        //         }
                        //         //list의 json을 스트링으로 만들어서 menu에 넣고 session에 담는다.
                        //         sessionStorage.setItem("menuOdList", JSON.stringify(menuOdList));
                        //
                        //     }else{ // comparisonTarget에 담긴 순서에 있는 애를 추가할 메뉴랑 비교
                        //         console.log("else");
                        //         console.log("originalSession.length" + originalSession.length);
                        //         for(var compa=0; compa<originalSession.length; compa++){ //
                        //             console.log("안에 들어왔다! compa : " + compa);
                        //             // console.log(comparisonTarget.length);
                        //             for(var tar=0; tar<comparisonTarget.length; tar++){
                        //                 console.log("comparisonTarget[tar] : " + comparisonTarget[tar]);
                        //                 console.log("compa : " + compa);
                        //                 if(comparisonTarget[tar]===compa){//여기까지가 비교대상인지 아닌지 거르기 (compa== 세션에서의 비교대상 수량제공메뉴 순번
                        //                     console.log("옵션그룹 수만 따졌을 땐 비교대상이로군");
                        //                     if(originalSession[compa]['odMenuNo']===orderDetail['odMenuNo']){ //수량제공메뉴가 같은지
                        //                         console.log("수량 제공 메뉴와 추가 메뉴의 메뉴 넘버가 같군");
                        //                         var optionSame = 0;
                        //                         console.log("tar : " + tar);
                        //                         console.log("comparisonTarget[tar+1] : " + comparisonTarget[tar]);
                        //                         for(var order=compa+1;order<comparisonTarget[tar]+1;order++){//옵션no 같은지
                        //                             // console.log(originalSession[order]['odOptionNo'])
                        //                             console.log(order-compa-1)
                        //                             if(originalSession[order]['odOptionNo']===odOptionGroupList[order-compa-1]){//옵션no 같으면 optionSame에 1추가
                        //                                 optionSame++;
                        //                             }
                        //                         }//for문 다 돌아가고 optionSame이 isthereOptionGroup과 같은지 비교
                        //                         console.log("optionSame : " + optionSame);
                        //                         console.log("isThereOptionGroup : " + isThereOptionGroup);
                        //
                        //                         if(optionSame!=0 && optionSame===isThereOptionGroup){ //드디어 같다면 수량추가
                        //                             console.log("수량추가를 할 만큼 충분히 같군.");
                        //                             ///////////////////////////////수량추가
                        //                             orderDetail['odMenuQty']=originalSession[compa]['odMenuQty']+1;
                        //                             //수량 추가된 메뉴를 list의 요소와 바꾼다.
                        //                             menuOdList[compa]=(orderDetail);
                        //                             console.log("ccc : list 요소 바꾼 후 : "  +JSON.stringify(menuOdList[compa]));
                        //                             //list의 json을 스트링으로 만들어서 menu에 넣고 session에 담는다.(겉으로는 수량이 추가된 것
                        //                             // if(isThereOptionGroup!=1){
                        //                                 for(var c=0; c<isThereOptionGroup; c++){
                        //                                     menuOdList[compa+c+1]=odOptionGroupList[c];
                        //                                 }
                        //                             // }else{
                        //                             //     menuOdList[compa+1]=odOptionGroupList[0];
                        //                             //     //console.log("1개일 때");
                        //                             // }
                        //                             sessionStorage.setItem("menuOdList", JSON.stringify(menuOdList));
                        //
                        //                             break;
                        //                         }//!!!!!!!!!!!!!!!
                        //                         else{//옵션이 다르면 단순 올리기
                        //                             ///////////////////////////////
                        //                             menuOdList.push(orderDetail);
                        //
                        //                             if(isThereOptionGroup!=0){
                        //                                 for(var i=0; i<odOptionGroupList.length; i++){
                        //                                     menuOdList.push(odOptionGroupList[i]);
                        //                                 }
                        //                             }
                        //                             //list의 json을 스트링으로 만들어서 menu에 넣고 session에 담는다.
                        //                             sessionStorage.setItem("menuOdList", JSON.stringify(menuOdList));
                        //                             break;
                        //                         }
                        //                     }
                        //                     else{//수량제공메뉴랑 다르면 단순 올리기
                        //                         ///////////////////////////////
                        //                         menuOdList.push(orderDetail);
                        //
                        //                         if(isThereOptionGroup!=0){
                        //                             for(var i=0; i<odOptionGroupList.length; i++){
                        //                                 menuOdList.push(odOptionGroupList[i]);
                        //                             }
                        //                         }
                        //                         //list의 json을 스트링으로 만들어서 menu에 넣고 session에 담는다.
                        //                         sessionStorage.setItem("menuOdList", JSON.stringify(menuOdList));
                        //                         break;
                        //                     }
                        //
                        //                 }else{//비교대상 아니라면 단순 담기
                        //                     ///////////////////////////////
                        //                     console.log("비교대상 아님");
                        //                     menuOdList.push(orderDetail);
                        //
                        //                     if(isThereOptionGroup!=0){
                        //                         for(var i=0; i<odOptionGroupList.length; i++){
                        //                             menuOdList.push(odOptionGroupList[i]);
                        //                         }
                        //                     }
                        //                     //list의 json을 스트링으로 만들어서 menu에 넣고 session에 담는다.
                        //                     sessionStorage.setItem("menuOdList", JSON.stringify(menuOdList));
                        //                     break;
                        //                 }
                        //             }
                        //         }
                        //     }

                        for(var i=0; i<originalSession.length;i++){//qtyFlag가 0인 애가 추가 메뉴&옵션 갯수와 이름까지 같을 때 이 안에서 session 저장 끝남
                            if(originalSession[i]['odMenuQtyFlag']==0){//세션에 담긴 애 중 수량제공메뉴일 때
                                //console.log("//세션에 담긴 애 중 수량제공메뉴일 때 i : " +i);

                                if(originalSession[i+1]!=null
                                    && originalSession[i]['odMenuNo']==originalSession[i+1]['odMenuNo']
                                    && originalSession[i+1]['odMenuQtyFlag']==1){//bbb. 세션에 옵션그룹이 있는 메뉴
                                    //console.log("cccccccccccccccc");
                                    //console.log("////bbb. 옵션그룹이 있는 메뉴 i : " +i);
                                    //console.log("추가할 메뉴랑 no 같은가");
                                    //console.log("메뉴 no 같은지 확인 : " +originalSession[i]['odMenuNo']+"==="+orderDetail['odMenuNo']);
                                    if(originalSession[i]['odMenuNo']===orderDetail['odMenuNo']){//추가할 메뉴랑 같을 때
                                        //console.log("추가할 메뉴랑 no 같을 때");
                                        //console.log("메뉴 no 같은지 확인 : " +originalSession[i]['odMenuNo']+"==="+orderDetail['odMenuNo']);
                                        //console.log("i="+i);
                                        var isItSame = 0;
                                        // for(var k=i+1; k<i+originalSession.length; k++){
                                        //     //console.log("///////////originalSession json parse"+k+" : "+JSON.stringify(originalSession[k]));
                                        // }

                                        if(isThereOptionGroup!=1){//추가할 옵션그룹 수가 1이 아닐 때
                                            for(var f=i+1; f<i+originalSession.length; f++) {

                                                if(originalSession[f]!=null && originalSession[f]['odMenuQtyFlag']!=0) {
                                                    isItSame++;
                                                    // console.log(isItSame + " : isItSame");
                                                    //console.log(isThereOptionGroup + " : isThereOptionGroup");

                                                }else {
                                                    //console.log("break;");
                                                    break;

                                                }
                                            }
                                        }else{//추가할 옵션그룹 수가 1일 때
                                            if(originalSession[i+2]!=null){
                                                if(originalSession[i+2]['odMenuQtyFlag']===1){
                                                    isItSame++;
                                                }
                                            }else{
                                                isItSame++;
                                            }

                                        }
                                        //console.log("111111111111111isItSame : " + isItSame);
                                        //console.log("111111111111111111111isThereOptionGroup : " + isThereOptionGroup);
                                        if(isItSame===isThereOptionGroup) { //옵션그룹의 수 같은가?
                                            var isItReallySame =0;
                                            if(isThereOptionGroup!=1){ //추가하려는 옵션그룹&비교대상 옵션그룹 수가 1이 아닐 때
                                                for(var a = i+1; a<i+isItSame+1; a++) {
                                                    //console.log("제발 111111111111");

                                                    if(originalSession[a]['odOptionNo']===odOptionGroupList[a-i-1]['odOptionNo']) {
                                                        //console.log("제발 222222222222222222");
                                                        //console.log("///////////originalSession json parse"+a+" : "+JSON.stringify(originalSession[a]));
                                                        //console.log("///////////odOptionGroupList json parse"+(a-i-1)+" : "+JSON.stringify(odOptionGroupList[a-i-1]));

                                                        isItReallySame++;
                                                    }//옵션그룹의 옵션 넘버가 다 같은가?
                                                }
                                            }else{//추가하려는 옵션그룹&비교대상 옵션그룹 수가 1일 때
                                                //console.log("제발 3333333333333");
                                                //console.log( " i : " + i);
                                                if(originalSession[i+1]!=null){//널체크
                                                    //console.log("제발 444444444444444");
                                                    //console.log( " i : " + i);
                                                    //console.log("JSON.stringify(originalSession["+i+1+"])"+(originalSession)[i+1]['odOptionNo']);
                                                    //console.log("JSON.stringify(odOptionGroupList[0])"+(odOptionGroupList)[0]['odOptionNo']);
                                                    if(originalSession[i+1]['odOptionNo']===odOptionGroupList[0]['odOptionNo']) {
                                                        isItReallySame++;
                                                        //console.log("제발 55555555555555");
                                                    }//옵션그룹의 옵션 넘버가 다 같은가?

                                                }else{
                                                    //console.log("제발 66666666666");
                                                    for(var a = i+1; a<i+isItSame; a++) {
                                                        //console.log("제발 777777777777777");
                                                        if(originalSession[a]['odOptionNo']===optionGroupOrderDetail['odOptionNo']) {
                                                            //console.log("제발 88888888888888");
                                                            isItReallySame++;
                                                        }//옵션그룹의 옵션 넘버가 다 같은가?
                                                    }
                                                }
                                            }

                                            //console.log("111111111111111isItReallySame : " + isItReallySame);
                                            //console.log("111111111111111111111isThereOptionGroup : " + isThereOptionGroup);

                                            if(isItReallySame===isThereOptionGroup ) {//ccc. 옵션그룹들도 다 똑같으면
                                                // 수량 추가
                                                //console.log("ccc : 수량 추가 이전 ="+originalSession[i]['odMenuQty']);
                                                orderDetail['odMenuQty']=originalSession[i]['odMenuQty']+1;
                                                //console.log("ccc : 수량 추가 이후 ="+orderDetail['odMenuQty']);
                                                //수량 추가된 메뉴를 list의 요소와 바꾼다.
                                                //console.log("ccc : list 요소 바꾸기 전 : "  +JSON.stringify(menuOdList[i]));
                                                menuOdList[i]=(orderDetail);
                                                //console.log("ccc : list 요소 바꾼 후 : "  +JSON.stringify(menuOdList[i]));
                                                //list의 json을 스트링으로 만들어서 menu에 넣고 session에 담는다.(겉으로는 수량이 추가된 것
                                                if(odOptionGroupList.length!=1){
                                                    for(var c=0; c<odOptionGroupList.length; c++){
                                                        menuOdList[i+c+1]=odOptionGroupList[c];
                                                        //console.log("1개 아닐 때 "+c);
                                                        //console.log("odOptionGroupList ["+c+"] : " + odOptionGroupList[c]);
                                                    }
                                                }else{
                                                    menuOdList[i+1]=odOptionGroupList[0];
                                                    //console.log("1개일 때");
                                                }


                                                sessionStorage.setItem("menuOdList", JSON.stringify(menuOdList));
                                                didYouAddOp++;
                                                //console.log("didYouAddOp(1 초과 불가) : "+didYouAddOp );

                                                //console.log("ccc. 요소 수량 추가 로직 끝");

                                            }
                                        }

                                    }//추가할 메뉴랑 같을 때 끝

                                }//bbb. 마지막 요소 아니면서 옵션 그룹 있는 애 끝
                            }//세션에 담긴 애 중 수량제공메뉴일 때 끝

                        }//qtyFlag가 0인 애가 있으면서 추가 메뉴와 같을 때 이 안에서 session 저장 끝남

                        //console.log("didYouAddOp(1 초과 불가) : "+didYouAddOp );
                        if(didYouAddOp==0 && didYouAdd==0){//fianl 만약 세션에 추가메뉴가 저장되지 않았다면

                            // 원래 있던 session에 수량 정보 제공 메뉴 하나 더 담기
                            //console.log("fianl : 하나 더 담기 이전 ="+JSON.stringify(menuOdList));
                            menuOdList.push(orderDetail);
                            //console.log("fianl : 하나 더 담기 이후 ="+JSON.stringify(menuOdList));

                            // 원래 있던 session에 수량 정보 제공 메뉴 하나 더 담기
                            //console.log("fianl : 옵션 더 담기 이전 ="+JSON.stringify(menuOdList));
                            if(isThereOptionGroup!=0){
                                for(var i=0; i<odOptionGroupList.length; i++){
                                    menuOdList.push(odOptionGroupList[i]);
                                }
                            }
                            //console.log("fianl : 옵션 더 담기 이후 ="+JSON.stringify(menuOdList));
                            //console.log("bbbbbbbbbbbb");
                            var beforeAnyway = JSON.parse(sessionStorage.getItem("menuOdList"));

                            for( var i in beforeAnyway){
                                // console.log("beforeAnyway : " + beforeAnyway[i]);
                                for(var j in beforeAnyway[i]){
                                    //console.log("afterAnyway key : " +j+"/value : " + beforeAnyway[i][j]);

                                }
                            }


                            //list의 json을 스트링으로 만들어서 menu에 넣고 session에 담는다.
                            sessionStorage.setItem("menuOdList", JSON.stringify(menuOdList));
                            didYouAddOp++;
                            //console.log("didYouAddOp(1 초과 불가) : "+didYouAddOp );

                            //console.log("fianl. 메뉴와 옵션 더 담기 로직 끝");
                        }//fianl.만약 세션에 추가메뉴가 저장되지 않았다면 끝
                        //console.log("aaaaaaaaaaaaaaaa");
                        var beforeAnyway = JSON.parse(sessionStorage.getItem("menuOdList"));

                        for( var i in beforeAnyway){
                            // console.log("beforeAnyway : " + beforeAnyway[i]);
                            for(var j in beforeAnyway[i]){
                                //console.log("afterAnyway key : " +j+"/value : " + beforeAnyway[i][j]);

                            }
                        }

                    }// 만약 session의 od 갯수가 1과 0이 아닐 때 끝
//////////////////////////////////////////////////////
//                     } //세션에 담긴 애 있을 때 끝

                    else {///세션에 담긴 애 없을 때

                        if(didYouAddOp==0 && didYouAdd==0) {//fianl 만약 세션에 추가메뉴가 저장되지 않았다면
                            //list에 수량 정보 제공 메뉴+옵션 넣고 session에 담기
                            menuOdList.push(orderDetail);
                            //옵션그룹정보 메뉴 담기
                            if (isThereOptionGroup != 0) {
                                for (var i = 0; i < odOptionGroupList.length; i++) {
                                    menuOdList.push(odOptionGroupList[i]);
                                }
                            }
                            sessionStorage.setItem("menuOdList", JSON.stringify(menuOdList));
                        }
                    }///만약 session의 od 갯수가 0일 때 끝
                    ///!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11
                }//추가하고자 하는 옵션그룹 !=0일 때 ...끝



                //////////////////////////////////////////////논리야 놀자 끝!/////////////////////////////


// 화면에 담기

                var targetCart = $('div.sticky').find('ul'); //주문 목록 담길 장바구니

                var beforeAnyway = JSON.parse(sessionStorage.getItem("menuOdList")); //세션에 있는 애 가져와서 json파싱

                for( var i in beforeAnyway){
                    // console.log("beforeAnyway : " + beforeAnyway[i]);
                    for(var j in beforeAnyway[i]){
                        console.log(" 화면에 뿌리기 전 점검 afterAnyway key : " +j+"/value : " + beforeAnyway[i][j]);

                    }
                } //세션에 있는 애 확인
                //담을 li

                var finalCart = "";
                var forOne=0;

                // ////////////시작///////////////////
                if(beforeAnyway) { // sessionStorage에 뭔가 있다?
                    console.log("sessionStorage에 있다! 화면 뿌려주기 준비 시작!");
                    for (var i = 0; i < beforeAnyway.length; i++) {//sessionStorage의 orderDetail만큼 for문 돌리기

                        console.log("for문 안에 있다!");
                        console.log("beforeAnyway[" + i + "]번째 세션 : " + JSON.stringify(beforeAnyway[i]));
                        // finalCart += "<li class=\"list-group-item d-flex justify-content-between lh-sm\">"+
                        //     "<div><h6 class=\"my-0\">"+beforeAnyway[i]['odMenuName']+"</h6>"+
                        //     "<h6 class=\"my-0\">"+beforeAnyway[i]['odMenuQty']+"</h6>"+
                        //     "<small class=\"text-muted\">"+beforeAnyway[i]['odOptionGroupName']+"</small>"+
                        //     "<small class=\"text-muted\">"+beforeAnyway[i]['odOptionName']+"</small>"+
                        //     "</div><span class=\"text-muted\">"+beforeAnyway[i]['odMenuPrice']+"</span></li>";

                        if (beforeAnyway[i]['odMenuQtyFlag'] == 0) {//플래그0일 때 메뉴 수량, 이름 출력
                            finalCart += "" +
                                "<li class=\"list-group-item d-flex justify-content-between lh-sm\">" +
                                "<button type='button' class='close' id='cancelMenu'>"+
                                "<span aria-hidden='true'>&times;</span></button>"+
                                "<div><h6 class=\"my-0\">" + beforeAnyway[i]['odMenuName'] + "</h6>" +
                                "<h6 class=\"my-0\">수량 : <input type='button' class='my-11' value='-' id='decreaseQuantity'>" +
                                "<input type='hidden' name='orderCount' value='"+i+"'>"+
                                " <input type='text' id='numberUpDown' value='" + beforeAnyway[i]['odMenuQty'] + "' size='1' max=''> " +
                                "<input type='button' value='+' id='increaseQuantity'> </h6>" +
                                "";
                            ///////////////수정/////////////////
                            //2022-01-16
                            // finalCart += "" +
                            //     "<li class=\"list-group-item d-flex justify-content-between lh-sm\">" +
                            //     "<div><h6 class=\"my-0\">" + beforeAnyway[i]['odMenuName'] + "</h6>" +
                            //     "<h6 class=\"my-0\">수량 : " + beforeAnyway[i]['odMenuQty'] + "</h6>" +
                            //     "";
                            forOne += 1;
                            if (beforeAnyway[i + 1] != null) { //만약 다음 애가 있는데
                                if (beforeAnyway[i + 1]['odMenuQtyFlag'] == 0) { //수량제공메뉴이면(지금 이게 수량제공메뉴란 소리니까 닫아줘야함)
                                    finalCart += "</div><span class=\"text-muted\">" + beforeAnyway[i]['odMenuPrice'] + "원</span></li>";
                                }

                            }else{ //만약 다음 애가 없으면
                                finalCart += "</div><span class=\"text-muted\">" + beforeAnyway[i]['odMenuPrice'] + "원</span></li>";
                            }
                        } else { //플래그 1일 때
                            // for(var j=i+1; j<beforeAnyway.length; j++){ //옵션그룹 화면에 뿌려주기 위한 for문 (수량제공메뉴+1부터
                            //     if(beforeAnyway[j]['odMenuQtyFlag']==1){
                            finalCart += "" +
                                "<p></p>" +
                                "<input type='hidden' name='orderCancelCount' value='"+i+"'>"+
                                "<small class=\"text-muted\">" + beforeAnyway[i]['odOptionGroupName'] + "</small> : " +
                                "<small class=\"text-muted\">" + beforeAnyway[i]['odOptionName'] + "</small> +" +
                                "<small class=\"text-muted\">" + beforeAnyway[i]['odOptionPrice'] + "원</small>";
                            //2022-01-16
                            // finalCart += "" +
                            //     "<p></p>" +
                            //     "<small class=\"text-muted\">" + beforeAnyway[i]['odOptionGroupName'] + "</small> : " +
                            //     "<small class=\"text-muted\">" + beforeAnyway[i]['odOptionName'] + "</small> +" +
                            //     "<small class=\"text-muted\">" + beforeAnyway[i]['odOptionPrice'] + "원</small>";
                            forOne += 1;
                            if (beforeAnyway[i + 1] != null) {
                                if (beforeAnyway[i + 1]['odMenuQtyFlag'] == 0) {
                                    finalCart += "</div><span class=\"text-muted\">" + beforeAnyway[i]['odMenuPrice'] + "원</span></li>";
                                }

                            }

                            // finalCart+="</div><span class=\"text-muted\">"+beforeAnyway[i]['odMenuPrice']+"원</span></li>";
                            // i=forOne;


                        }//sessionStorage만큼 for문 돌리기
                    }

                }
                /*    ///////////////////////////////////////////////////////////////////////////////////수정///*/
                var beforeAny = JSON.parse(sessionStorage.getItem("menuOdList"));
                var orderDetailList = "";
                var orderTruckIdCheck = "";

                for (var i in beforeAny) {



                    orderDetailList += "<input type='hidden' name='odMQFlag' id='odMQFlag' value='" + beforeAny[i]['odMenuQtyFlag'] + "'>" +
                        "<input type='hidden' name='odMQty' id='odMQty' value='" + beforeAny[i]['odMenuQty'] + "'>" +
                        "<input type='hidden' name='odMName' id='odMName' value='" + beforeAny[i]['odMenuName'] + "'>" +
                        "<input type='hidden' name='odMPrice' id='odMPrice' value='" + beforeAny[i]['odMenuPrice'] + "'>" +
                        "<input type='hidden' name='odOGName' id='odOGName' value='" + beforeAny[i]['odOptionGroupName'] + "'>" +
                        "<input type='hidden' name='odOpName' id='odOpName' value='" + beforeAny[i]['odOptionName'] + "'>" +
                        "<input type='hidden' name='odOpPrice' id='odOpPrice' value='" + beforeAny[i]['odOptionPrice'] + "'>" +
                        "<input type='hidden' name='odMImg1' id='odMImg1' value='" + beforeAny[i]['odMenuImg1'] + "'>";

                    orderTruckIdCheck = "<input type='hidden' name='checkMenuTruckId' id='checkMenuTruckId' value='" + beforeAny[i]['menuTruckId'] + "'>";

                }

                $("#cartList").append(orderDetailList);
                $("#cartList").append(orderTruckIdCheck);
                targetCart.html(finalCart);
                // location.reload();



            });

            //화면에 담기 끝




        });

        /*//////////////////////////////////////////////수정//////////////////////////*/
        <!--장바구니 삭제 & 수량 버튼-->
        //2022-01-16
        /*삭제버튼 클릭 이벤트*/
        $(function(){
            var orderDetail = JSON.parse(sessionStorage.getItem("menuOdList"));

            var orderCancelCount = [];

            $('button#cancelMenu').click(function(){
                var orderCount = $(this).parent('li').find('input[name="orderCount"]').val();
                // var orderCancelCount = $(this).parent('li').find('input[name="orderCancelCount"]').val();
                $(this).parent('li').find('input[name="orderCancelCount"]').each(function (i) {
                    orderCancelCount.push($(this).val());
                });

                orderDetail.splice(orderCount,orderCancelCount.length+1);

                sessionStorage.setItem("menuOdList", JSON.stringify(orderDetail));


                $(this).parent('li').remove();

            })

        })

        $(function(){
            $("#cancelCartMenuList").on("click",function(){
                sessionStorage.removeItem("menuOdList");
                location.reload();
            })
        })


        /*수량버튼 클릭 이벤트*/
        $(function(){


            var orderDetail = JSON.parse(sessionStorage.getItem("menuOdList"));


            $('input#decreaseQuantity').click(function(e){
                var orderCount = $(this).parent('h6').find('input[name="orderCount"]').val();
                //alert("클릭한 메뉴의 순서 정보"+orderCount);
                e.preventDefault();

                var stat = $(this).parent('h6').find('input#numberUpDown');
                var num = stat.val();
                num--;
                if(num<=0){
                    alert('더이상 줄일수 없습니다.');
                    num =1;
                }
                // 수량 추가
                orderDetail[orderCount]['odMenuQty']=num;
                stat.val(num);
                sessionStorage.setItem("menuOdList", JSON.stringify(orderDetail));

                //$('input#numberUpDown').val(num);
            });
            $('input#increaseQuantity').click(function(e){
                var orderCount = $(this).parent('h6').find('input[name="orderCount"]').val();
                e.preventDefault();

                var stat = $(this).parent('h6').find('input#numberUpDown');
                var num = stat.val();
                num++;

                if(num>10){
                    alert('더이상 늘릴수 없습니다.');
                    num=10;
                }

                orderDetail[orderCount]['odMenuQty']=num;
                stat.val(num);
                sessionStorage.setItem("menuOdList", JSON.stringify(orderDetail));
                // $('input#numberUpDown').val(num);
            });
        });



        $(function (){

            var beforeAny = JSON.parse(sessionStorage.getItem("menuOdList"));
            var orderDetailList = "";
            /*    ///////////////////////////////////////////////////////////////////////////////////수정///*/
            var orderTruckIdCheck = "";

            for (var i in beforeAny) {



                orderDetailList += "<input type='hidden' name='odMQFlag' id='odMQFlag' value='" + beforeAny[i]['odMenuQtyFlag'] + "'>" +
                    "<input type='hidden' name='odMQty' id='odMQty' value='" + beforeAny[i]['odMenuQty'] + "'>" +
                    "<input type='hidden' name='odMName' id='odMName' value='" + beforeAny[i]['odMenuName'] + "'>" +
                    "<input type='hidden' name='odMPrice' id='odMPrice' value='" + beforeAny[i]['odMenuPrice'] + "'>" +
                    "<input type='hidden' name='odOGName' id='odOGName' value='" + beforeAny[i]['odOptionGroupName'] + "'>" +
                    "<input type='hidden' name='odOpName' id='odOpName' value='" + beforeAny[i]['odOptionName'] + "'>" +
                    "<input type='hidden' name='odOpPrice' id='odOpPrice' value='" + beforeAny[i]['odOptionPrice'] + "'>" +
                    "<input type='hidden' name='odMImg1' id='odMImg1' value='" + beforeAny[i]['odMenuImg1'] + "'>";

                orderTruckIdCheck = "<input type='hidden' name='checkMenuTruckId' id='checkMenuTruckId' value='" + beforeAny[i]['menuTruckId'] + "'>";

            }

            $("#cartList").append(orderDetailList);
            $("#cartList").append(orderTruckIdCheck);
            //2022-01-16
            //
            //
            // }
            // $("#cartList").append(orderDetailList);

        });



        /*장바구니 주문하기 */
        $(function () {
            $("#addMenuCart").click(function () {
                /*//////////////////////////수정///////////////////////////*/
                var orderCheck = $("input[name='checkMenuTruckId']").val();
                if(orderCheck== undefined){
                    alert("담겨있는 메뉴가 없습니다")
                    return;
                }

                var order = menu_ajax()


                append = "<input type=\"hidden\" id=\"orderNo\" name=\"orderNo\" value=\"" + order + "\">";
                $('#app').append(append);
                /*alert(append)*/
                self.location = "/purchase/addCart?orderNo=" + order
                /* $("form").attr("method" , "POST").attr("action" , "/purchase/addCart").submit();*/

            });
        });


        function menu_ajax() {
            /*alert("1111111")*/
            var reOrderNo;
            var odMenuName = [];
            var odOptionGroupName = [];
            var odOptionName = [];
            var odMenuQty = [];
            var odMenuPrice = [];
            var odOptionPrice = [];
            var odMenuImage = [];
            var odMenuQtyFlag = [];
            var orderPickUpTime = $('input[name="orderPickUpTime"]:checked').val();
            var orderTotalPrice = $('#orderTotalPrice').val();
            var orderUserId = $('#orderUserId').val();
            var orderTruckId = $('#orderTruckId').val();
            var orderRequest = $('#menuRequest').val();
            var orderQty = $('#orderQty').val();

            $('input[name="odMName"]').each(function (i) {
                odMenuName.push($(this).val());
            });

            $('input[name="odOGName"]').each(function (i) {
                odOptionGroupName.push($(this).val());
            });

            $('input[name="odOpName"]').each(function (i) {
                odOptionName.push($(this).val());
            });

            $('input[name="odMQty"]').each(function (i) {
                odMenuQty.push($(this).val());
            });

            $('input[name="odMPrice"]').each(function (i) {
                odMenuPrice.push($(this).val());
            });

            $('input[name="odOpPrice"]').each(function (i) {
                odOptionPrice.push($(this).val());
            });

            $('input[name="odMImg1"]').each(function (i) {
                odMenuImage.push($(this).val());
            });

            $('input[name="odMQFlag"]').each(function (i) {
                odMenuQtyFlag.push($(this).val());
            });
            /*   alert(orderPickUpTime)
               alert(orderTotalPrice)
               alert(orderUserId)
               alert(orderTruckId)
               alert(orderRequest)
               alert(orderQty)
               alert(odMenuQtyFlag)*/

            var data = {
                "odMenuName": odMenuName,
                "odOptionGroupName": odOptionGroupName,
                "odOptionName": odOptionName,
                "odMenuQty": odMenuQty,
                "odMenuPrice": odMenuPrice,
                "odOptionPrice": odOptionPrice,
                "odMenuImage": odMenuImage,
                "orderPickUpTime": orderPickUpTime,
                "orderTotalPrice": orderTotalPrice,
                "orderUserId": orderUserId,
                "orderTruckId": orderTruckId,
                "orderRequest": orderRequest,
                "orderQty": orderQty,
                "odMenuQtyFlag": odMenuQtyFlag,
            }
            $.ajax({
                type: "post",
                url: '/purchase/json/addCartList',
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                data: data,
                async: false,
                dataType: 'json',
                success: function (retVal) {
                    reOrderNo = retVal.orderNo;
                    sessionStorage.removeItem('menuOdList');
                },
                error: function (xhr, status, error) {
                    alert("[Error]" + error);
                    return;
                }


            });
            return reOrderNo;
        }




















    </script>

    <!--장바구니 css-->
    <style>
        div.col-md-5.col-lg-4.order-md-last{
            /*position:sticky;*/
            /*top:0px;*/
        }
        div.sticky{
            position:sticky;
            top:0px;
        }
    </style>


    <style>
        .card {
            display: flex;
            /*justify-content: space-between;*/
            margin: 0 70px;
            /*margin-top: 65px;*/
            flex-wrap: wrap;
            float: left;
        }
        .modal-header{
            margin-left : 39px;
        }
        .modal-body{
            margin-left : 39px;
        }
        .modal-happy{
            margin-left : 39px;
        }
    </style>


    <script type="text/javascript">



        // 별점 출력
        function ratingToPercent() {
            const score = +this.restaurant.averageScore * 20;
            return score + 1.5;
        }

        // 메뉴 상세보기
        function getMenu(menuNo){

            // 메뉴에 해당하는 옵션그룹이 있니?
            var optionGroupCount = 0;
            $.ajax({
                url:"/menu/json/isThereOG/"+menuNo,
                method:"get",
                success:function(data){
                    // console.log("data : " + data)
                    optionGroupCount = data;
                }
            });

            // alert("optionGroupCount : " + optionGroupCount);

            $.ajax({
                url:"/menu/json/getMenu/"+menuNo,
                method:"get",

                success: function(data){
                    // console.log("data : " + data.menu)
                    var div="";
                    var modalFooter = "";

                    div +="<div class=\"page-header\">"+
                        "<h3 class=\"getMenuTitle custom\" name=\"menuTruckId\">"+data.menu.menuTruckId+"</h3>"+
                        "</div>"+
                        "<div class=\"row\">"+
                        "<div class=\"col-xs-4 col-md-2\"><strong>메뉴번호</strong></div>"+
                        " <div class=\"col-xs-8 col-md-4\" name=\"odMenuNo\">"+data.menu.menuNo+"</div>"+
                        "</div>"+
                        "<hr/>"+
                        "<div class=\"row\">"+
                        "<div class=\"col-xs-4 col-md-2 \"><strong>메뉴 이름</strong></div>"+
                        "<div class=\"col-xs-8 col-md-4\" name=\"odMenuName\">"+data.menu.menuName+"</div>"+
                        "</div>"+
                        "<hr/>"+
                        "<div class=\"row\">"+
                        "<div class=\"col-xs-4 col-md-2 \"><strong>메뉴이미지1</strong></div>"+
                        "<div class=\"col-xs-8 col-md-4\" name=\"odMenuImg1\" data-menuimg=\""+data.menu.menuImg1+"\">" +
                        "<img src=\"/resources/image/"+data.menu.menuImg1+"\"" +
                        "style=\"border-bottom: 1px solid #eee; height: 200px;\" "+
                        "alt=\""+data.menu.menuName+"의 이미지1\" title=\"메뉴이미지1\"></div> </div>"+
                        "<hr/>"+
                        "<div class=\"row\">" +
                        "<div class=\"col-xs-4 col-md-2 \">" +
                        "<strong>메뉴상세정보</strong>" +
                        "</div><div class=\"col-xs-8 col-md-4\" name=\"odMenuDetail\">"+data.menu.menuDetail+"</div>"+
                        "</div><hr/>"+
                        "<div class=\"row\">"+
                        "<div class=\"col-xs-4 col-md-2\"><strong>대표메뉴여부</strong></div>"+
                        "<div class=\"col-xs-8 col-md-4\">"+data.menu.isSigMenu+"</div>"+
                        "</div><hr/><div class=\"row\">"+
                        "<div class=\"col-xs-4 col-md-2 \"><strong>메뉴가격</strong></div>"+
                        "<div class=\"col-xs-8 col-md-4\" name=\"odMenuPrice\">"+data.menu.menuPrice+"</div></div>" +
                        // "<input type=\"hidden\" name=\"odMenuQty\" value="+ //todo 보류입니다!(수량을 hidden으로 넣을지가)
                        "<hr/>";

                    $('.modal-body-hey').html(div);

                    if(optionGroupCount!=0){
                        getOptionGroupListOnModal(data.menu.menuNo);
                    }


                    $('#exampleModalLong').modal('show');


                }
            })
        }

        function getOptionGroupListOnModal(menuNo){

            $.ajax({
                url:"/menu/json/getOptionGroupListOnModal/"+menuNo,
                method:"get",
                success:function(data){
                    // console.log("data.optionGroup[0].optionGroupName : " +data.optionGroup[0].optionGroupName)
                    var divOG ="<table>";
                    var modalFooterOG ="";

                    var optionGroupPLZ=0;

                    for (var x of data.optionGroup) {
                        optionGroupPLZ++;
                        //옵션그룹이름이 최초 호출될 때만 옵션그룹이름 보여주기
                        if(optionGroupPLZ!=1){
                            if(!(data.optionGroup[optionGroupPLZ-1].optionGroupName===data.optionGroup[optionGroupPLZ-2].optionGroupName)){
                                divOG+=""+
                                    "<hr><div class=\"row\"> " +
                                    // "<div class=\"col-xs-4 col-md-2\">" +
                                    // "<strong>옵션 그룹 이름</strong></div>"+
                                    "<div class=\"col-xs-8 col-md-4\"><strong>"+x.optionGroupName+"</strong></div>"+
                                    "</div><hr>";
                            }
                        }else{
                            divOG+=""+
                                "<hr><div class=\"row\"> " +
                                // "<div class=\"col-xs-4 col-md-2\">" +
                                // "<strong>옵션 그룹 이름</strong></div>"+
                                "<div class=\"col-xs-8 col-md-4\"><strong>"+x.optionGroupName+"</strong></div>"+
                                "</div><hr>";
                        }
                        divOG+=""+

                            "<div class=\"row\"> " +
                            "<div class=\"col\">" +
                            // "<label class=\"form-check-label\" for=\"optionName+OGName"+x.optionGroupName+"\"><strong>옵션 이름</strong></label></div>"+
                            "<div class=\"col-xs-8 col-md-4\">" +
                            "<input class=\"form-check-input\" type=\"radio\" name=\"optionName+OGName"+x.optionGroupName+"\" id=\"optionName+OGName"+x.optionGroupName+"\" data-op=\""+x.optionName+"\">"+x.optionName+"" +
                            "<input type=\"hidden\" name=\"odOptionGroupNo\" value=\""+x.optionGroupNo+"\">"+
                            "<input type=\"hidden\" name=\"odOptionGroupName\" value=\""+x.optionGroupName+"\">"+
                            "<input type=\"hidden\" name=\"odOptionNo\" value=\""+x.optionNo+"\">"+
                            "<input type=\"hidden\" name=\"odOptionPrice\" value=\""+x.optionPrice+"\">"+
                            "</div>"+
                            // "<div class=\"row\">"+
                            // "<div class=\"col-xs-4 col-md-2\"><strong>옵션 가격</strong></div>"+
                            "<span class=\"col-xs-8 col-md-4\" style=\"right:0px;\">"+x.optionPrice+"</span>"+
                            "</div>"+
                            "</div>"+

                            "";
                    }


                    $('.modal-happy').html(divOG);


                }
            })

        }

        //2022-01-16
        /*confirm 해당트럭에 대한 메뉴가 아니면 Session초기화*/
        $(document).ready(function(){
            var checkMenuTruckId = $("input[name='checkMenuTruckId']").val();
            var orderTruckId = $("input[name='orderTruckId.truckId']").val();

            /*  alert(orderTruckId)
              alert(checkMenuTruckId)*/

            if(checkMenuTruckId != undefined) {

                if (checkMenuTruckId != orderTruckId) {
                    $('button#truckIdCheck.button.is-warning.is-light').click(function () {
                        var result = confirm('기존에 저장된 메뉴를 삭제하시겠습니까??');
                        if (result) { //yes
                            sessionStorage.removeItem('menuOdList');
                        } else {
                            //no
                            self.location = "/menu/getMenuList?truckId=" + checkMenuTruckId;

                        }
                    });
                }
            }
        });
    </script>

    <!--별점-->
    <style>

        <%--        별점 css--%>
        .star-ratings {
            color: #aaa9a9;
            position: relative;
            unicode-bidi: bidi-override;
            width: max-content;
            -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
            -webkit-text-stroke-width: 1.3px;
            -webkit-text-stroke-color: #2b2a29;
            font-size: 30px;
        }

        .star-ratings-fill {
            color: #fff58c;
            padding: 0;
            position: absolute;
            z-index: 1;
            display: flex;
            top: 0;
            left: 0;
            /*overflow: hidden;*/
            -webkit-text-fill-color: gold;
        }

        .star-ratings-base {
            z-index: 0;
            padding: 0;
        }

        .truckNameForMenu{
            color:black;
            font-weight: bolder;
            text-align: center;
        }
        /*주문하기Madal Radio button*/
        .toggle3 input[type=radio]{
            display: none;
        }
        .toggle3 input[type=radio] + label {
            color: #e0e0e0;
            font-size: 1em;
        }
        .toggle3 input[type=radio]:checked + label {
            color: #000;
        }
        .btn-outline-primary {
            color: #007bff;
            border-color: #ffba49;
        }
    </style>

    <script>

        $(function(){

            // alert($('div.star-ratings').html());

            // var menuTruck = {
            //     truckId : $('input[name="truckId"]').val()
            // }
            //
            // sessionStorage.setItem("menuTruck", menuTruck);



            $('div.star-ratings').on("click", function(){
                // alert($('div.star-ratings').html());
                var truckId = $('input[name="truckId"]').val();

                // alert(truckId);

                self.location="/review/getReviewListTruck?truckId="+truckId;


            })

        })

    </script>



    <script>
        //리뷰 목록 뿌려주기 ajax

        $(function(){

            var truckId = $('input[name="truckId"]').val();
            // alert(truckId);


            $.ajax({

                url:"/review/json/getReviewList/"+truckId,
                method:"get",
                success:function(data){
                    var rvDiv = "<div class=\"d-flex\"";
                    var reviewPLZ = 0;

                    rvDiv+=""+
                        "<section id=\"testimonials\">"+
                        "<div class=\"testimonial-heading\">"+
                        "<span>Comments</span>"+
                        "<h4>Clients Says</h4>"+
                        "</div>"+
                        "<div class=\"testimonial-box-container\">"+
                        ""+
                        "";

                    for(var rv of data.review){
                        reviewPLZ++;
                        rvDiv+=""+
                            "<div class=\"testimonial-box\">"+
                            "<input type=\"hidden\" name=\"rvNo\" value=\""+rv.rvNo+"\">"+
                            "<div class=\"box-top\">"+
                            "<div class=\"profile\">"+
                            " <div class=\"profile-img\">"+
                            " <img src=\"https://cdn.clien.net/web/api/file/F01/3026181/26c0c7097b4545faa89.JPG\" />"+
                            "</div>"+
                            "<div class=\"name-user\">"+
                            "<strong>"+rv.rvUserId+"</strong>"+
                            "<span>"+rv.rvRegTime+"</span>"+
                            "</div>"+
                            "</div>"+
                            "<div class=\"reviews\">";
                        if(rv.rvStar==0){
                            rvDiv+=""+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(rv.rvStar==0.5){
                            rvDiv+=""+
                                "<i class=\"fas fa-star-half\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(rv.rvStar==1){
                            rvDiv+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(rv.rvStar==1.5){
                            rvDiv+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star-half\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(rv.rvStar==2){
                            rvDiv+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(rv.rvStar==2.5){
                            rvDiv+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star-half\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(rv.rvStar==3){
                            rvDiv+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(rv.rvStar==3.5){
                            rvDiv+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star-half\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(rv.rvStar==4){
                            rvDiv+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"far fa-star\"></i>";
                        }else if(rv.rvStar==4.5){
                            rvDiv+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star-half\"></i>";
                        }else if(rv.rvStar==5){
                            rvDiv+=""+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>"+
                                "<i class=\"fas fa-star\"></i>";
                        }
                        rvDiv+=""+
                            "</div>"+
                            "</div>"+
                            "<div class=\"client-comment\">"+
                            "<p>"+rv.rvContent+"</p>"+
                            "</div>"+
                            "</div>"+
                            ""+
                            "";


                    }
                    rvDiv+="</div>"+
                        "</section>";

                    // alert($('div.card.review-body').html());
                    $('div.card.review-body').html(rvDiv);

                }

            });

        });

    </script>

    <!--리뷰 상세보기 모달-->
    <script>
        $(function(){

            $("body").on("click", ".testimonial-box", function() {

                let rvNo = $(this).find("input[name='rvNo']").val()
                console.log("rvNo: " + rvNo);
                // if(postNo=="Blind"){
                //     alert("비공개 처리된 게시물입니다.")
                //     return;
                // }
                getReviewDetail(rvNo)
                /*let postNo = $(this).next();
                console.log("postNo: " + postNo);
                getCardDetail(postNo)*/
            });
        })




        // 리뷰 클릭했을 때, modal 호출

        function getReviewDetail(rvNo) {

            // alert("얍");

            // alert("rvNo: "+rvNo);
            $.ajax({
                url:"/review/json/getReviewDetail/"+rvNo,
                method:"get",

                success: function (data) {
                    var div="";
                    var modalFooter = "";
                    // var hit = data.post.postHit;
                    // $('#hit'+postNo).text(hit);

                    div += "<div class='cloneFail' >"+
                        "</div>";

                    div += "<div class='row rvContent' >"
                        +"<div>"+data.review.rvContent+"</div>"
                        + "</div>";
                    div += "<div class='align-test'>";
                    alert(data.review.rvTruckCmtContent);
                    if(data.review.rvTruckCmtContent!=null){
                        div+= "<hr><div>사장님 댓글 : "+data.review.rvTruckCmtContent+"</div></div>";
                    }
                    // if (data.review.heartNo == '0'){
                    //
                    //     div +=" <a idx="+data.review.postNo+" href='javascript:' class='heart-click heart_icon"+data.post.postNo+"'>"
                    //         +"<svg xmlns='http://www.w3.org/2000/svg' width='20' height='20' fill='red' class='bi bi-suit-heart' viewBox='0 0 20 20'>"
                    //         + "<path d='M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z' />"
                    //         +"</svg> </a> ";
                    // }else{
                    //
                    //     div +=  "<a idx="+data.review.postNo+" href='javascript:' class='heart-click heart_icon"+data.post.postNo+"'>"
                    //         +"<svg xmlns='http://www.w3.org/2000/svg' width='20' height='20' fill='red' class='bi bi-suit-heart-fill' viewBox='0 0 20 20'>"
                    //         +"<path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z' />"
                    //         + " </svg></a>";
                    // }
                    // div += " <span id='m_heart"+data.review.postNo+"'>"+data.review.heartCount+"</span>"
                    //     +"<span>"
                    //     +"<a idx='"+data.review.postNo+"' href='#reply_card"+data.review.postNo+"' role='button' class='open_reply_list' data-toggle='collapse'  aria-expanded='false' aria-controls='collapseExample'> "
                    //     +"<svg xmlns='http://www.w3.org/2000/svg' width='20' height='20' fill='red' class='bi bi-chat-dots' viewBox='0 0 20 20'>"
                    //     +"<path d='M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z' />"
                    //     +"<path d='M2.165 15.803l.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z' />"
                    //     +"</svg>"
                    //     +"</a>"
                    //     +" </span>"
                    //     +" <span id='m_reply"+data.review.postNo+"'>"+data.review.replyCount+"</span>"
                    //     +"<span> <svg xmlns='http://www.w3.org/2000/svg' width='20' height='20' fill='red' class='bi bi-eye' viewBox='0 0 20 20'>"
                    //     +"<path d='M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z' />"
                    //     +"<path d='M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z' />"
                    //     +"</svg>"
                    //     +"</span> <span id='hit"+data.review.postNo+"'>"+data.review.postHit+"</span>"
                    //     +"</div>"
                    //     +"<div class='collapse' id='reply_card"+data.review.postNo+"'>"
                    //     +"<section class='modal-section'>"
                    //     +"<div class='card card-body'>"
                    //     +"<div class='reply-list reply-list"+data.review.postNo+"'>"
                    //     +"</div>"
                    //     +"<div class='row reply_write'>"
                    //     +"<div class='col-1'>"
                    //     +"<a href='other_profile.do?other_nick='>"
                    //     +"<img id='write_reply_profileImage' src='../../../resources/image/"+proImg+"' />"
                    //     +" </a>"
                    //     +"</div>"
                    //     +"<div class='col-8' class='input_reply_div'>"
                    //     +"<input class='w-100 form-control' id='input_reply"+data.review.postNo+"' type='text' placeholder='댓글입력...'>"
                    //     +"</div>"
                    //     +"<div class='col-3 '>"
                    //     +"<button type='button' idx='"+data.review.postNo+"' class='btn btn-success mb-1 write_reply' style='background-color: #ffe537; border-radius:12px; border-color: #ffba49; color: black; font-size: 12px; '>댓글달기</button>"
                    //     +"</div>"
                    //     +" </div>"
                    //     +" </div>"
                    //     +" </section>"
                    //     +"</div>";


                    <%--if (role == "user"){--%>

                    <%--    var userId = '${sessionScope.user.userId}'--%>

                    <%--    if (data.post.postTruck == null && data.post.postUser.userId == userId){--%>

                    <%--        modalFooter = "<div class='modal-footer'>"--%>
                    <%--            +"<button class='button btn-warning' name='deletePostPic' onclick='deletePostPic("+data.post.postNo+");'>글 삭제"--%>
                    <%--            +"<input type='hidden' name='postNo' value='"+data.post.postNo+"'/></button>"--%>
                    <%--            +"<button class='button is-warning is-light' name='updatePostPicView'"--%>
                    <%--            +"onclick='updatePostPicView("+data.post.postNo+");'>글 수정"--%>
                    <%--            +"<input type='hidden' name='postNo' value='"+data.post.postNo+"'/>"--%>
                    <%--            + "</button>"--%>
                    <%--            +"</div>";--%>
                    <%--    }else {--%>
                    <%--        modalFooter = "<div class='modal-footer'>"--%>
                    <%--            + " <button type='button' class='btn btn-secondary' data-dismiss='modal'>Close</button></div>";--%>
                    <%--    }--%>

                    <%--}else if(role == "truck"){--%>

                    <%--    var truckId = '${sessionScope.truck.truckId}'--%>

                    <%--    if (data.post.postUser == null && data.post.postTruck.truckId == truckId){--%>

                    <%--        modalFooter = "<div class='modal-footer'>"--%>
                    <%--            +"<button class='button btn-warning' name='deletePostPic' onclick='deletePostPic("+data.post.postNo+");'>글 삭제"--%>
                    <%--            +"<input type='hidden' name='postNo' value='"+data.post.postNo+"'/></button>"--%>
                    <%--            +"<button class='button is-warning is-light' name='updatePostPicView'"--%>
                    <%--            +"onclick='updatePostPicView("+data.post.postNo+");'>글 수정"--%>
                    <%--            +"<input type='hidden' name='postNo' value='"+data.post.postNo+"'/>"--%>
                    <%--            + "</button>"--%>
                    <%--            +"</div>";--%>

                    <%--    }else {--%>
                    <%--        modalFooter = "<div class='modal-footer'>"--%>
                    <%--            + " <button type='button' class='btn btn-secondary' data-dismiss='modal'>Close</button></div>";--%>
                    <%--    }--%>
                    <%--}--%>
                    //$('body').find( '.format' ).clone().appendTo( '#carouselFail' ).css("display", "block");

                    // var postPicUserId;
                    // var postPicProImg;
                    // if (data.post.truckProImg != null){
                    //     postPicUserId = data.post.postTruck.truckId;
                    //     postPicProImg = data.post.truckProImg;
                    // }else {
                    //     postPicUserId = data.post.postUser.userId;
                    //     postPicProImg = data.post.userProImg;
                    // }

                    // console.log("id : "+postPicUserId);
                    // console.log("img : "+postPicProImg);





                    // $(".header-title").css({"background-image":"url(../../../resources/image/"+postPicProImg+")"});
                    $(".insta-header").find('h2').text(data.review.rvUserId);

                    // $('.insta-header').html(sap);
                    //$('.page1').css("background", "../../../resources/image/"+data.post.postFile1+"")
                    // $("#page1").style.background = "url('../../../resources/image/"+data.post.postFile1+"') no-repeat 0 0";
                    if(data.review.rvImg1!=null){
                        $(".page1").css({"background":"url(../../../resources/image/"+data.review.rvImg1+") 50% 50% / 50px 50px"});
                        $(".slide1").css({"background":"url(../../../resources/image/"+data.review.rvImg1+")"});
                        $(".page1").css({"background-size":"50px 50px"});
                        $(".slide1").css({"background-size":"450px 450px"});
                    }

                    if ( data.review.rvImg2 != null ) {
                        $(".page2").css({"background": "url(../../../resources/image/" + data.review.rvImg2 + ") 50% 50% / 50px 50px"});
                        $(".slide2").css({"background": "url(../../../resources/image/" + data.review.rvImg2 + ")"});
                        $(".page2").css({"background-size": "50px 50px"});
                        $(".slide2").css({"background-size": "450px 450px"});
                        $(".page2").css({"display": "block"});
                        $(".numb2").css({"display": "block"});
                    }
                    if ( data.review.rvImg3 != null ) {
                        //alert("333")
                        $(".page3").css({"background": "url(../../../resources/image/" + data.review.rvImg3 + ") 50% 50% / 50px 50px"});
                        $(".slide3").css({"background": "url(../../../resources/image/" + data.review.rvImg3 + ")"});
                        $(".page3").css({"background-size": "50px 50px"});
                        $(".slide3").css({"background-size": "450px 450px"});
                        $(".page3").css({"display": "block"});
                        $(".numb3").css({"display": "block"});
                    }

                    // $('.modal-footer').remove();
                    // alert("여기까지 오는가?");


                    // $('.modal-content-review').append(modalFooter);
                    $('.modal-body.review').html(div);
                    // $( '.format .wrapper' ).clone().appendTo( '.cloneFail' );

                    // console.log("data.review.postHit: "+data.post.postHit);

                    $('#staticBackdrop').modal('show');







                },
                error : function(err){
                    console.log('에러')
                }
            });



        }
    </script>




    <%--리뷰 css--%>
    <style>

        *{
            margin: 0px;
            padding: 0px;
            font-family: poppins;
            box-sizing: border-box;
        }
        a{
            text-decoration: none;
        }
        #testimonials{
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            width:100%;
        }
        .testimonial-heading{
            letter-spacing: 1px;
            margin: 30px 0px;
            padding: 10px 20px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .testimonial-heading span{
            font-size: 1.3rem;
            color: #252525;
            margin-bottom: 10px;
            letter-spacing: 2px;
            text-transform: uppercase;
        }
        .testimonial-box-container{
            display: flex;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
            width:100%;
        }
        .testimonial-box{
            width:500px;
            box-shadow: 2px 2px 30px rgba(0,0,0,0.1);
            background-color: #ffffff;
            padding: 20px;
            margin: 15px;
            cursor: pointer;
        }
        .profile-img{
            width:50px;
            height: 50px;
            border-radius: 50%;
            overflow: hidden;
            margin-right: 10px;
        }
        .profile-img img{
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: center;
        }
        .profile{
            display: flex;
            align-items: center;
        }
        .name-user{
            display: flex;
            flex-direction: column;
        }
        .name-user strong{
            color: #3d3d3d;
            font-size: 1.1rem;
            letter-spacing: 0.5px;
        }
        .name-user span{
            color: #979797;
            font-size: 0.8rem;
        }
        .reviews{
            color: #f9d71c;
        }
        .box-top{
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .client-comment p{
            font-size: 0.9rem;
            color: #4b4b4b;
        }
        .testimonial-box:hover{
            transform: translateY(-10px);
            transition: all ease 0.3s;
        }

        @media(max-width:1060px){
            .testimonial-box{
                width:80%;
                padding: 10px;
            }
        }
        @media(max-width:790px){
            .testimonial-box{
                width:100%;
            }
            .testimonial-heading h1{
                font-size: 1.4rem;
            }
        }
        @media(max-width:340px){
            .box-top{
                flex-wrap: wrap;
                margin-bottom: 10px;
            }
            .reviews{
                margin-top: 10px;
            }
        }
        ::selection{
            color: #ffffff;
            background-color: #252525;
        }
    </style>
    <!--리뷰 상세보기-->
    <style>
        .main-insta {
            max-width:450px;
            min-width: 450px;
            margin: auto;
            background-color: rgba(250, 250, 250, 0.85);
            -webkit-box-shadow: 0 2px 26px rgba(0, 0, 0, .3), 0 0 0 1px rgba(0, 0, 0, .1);
            /*box-shadow: 0 2px 26px rgba(0, 0, 0, .3), 0 0 0 1px rgba(0, 0, 0, .1);
                padding: 1rem;
                flex: 1 1 auto;
            */
            border-radius: 5px;

            position: relative;
            -ms-flex: 1 1 auto;


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
        .insta-header .header-title:hover .tooltip{
            display: block
        }
        .insta-header span:nth-child(1) {
            display: inline-block;
            width: 60px;
            height: 50px;
            border-radius: 50%;

            background-size: cover;
            background-position: 100% 25%;
            overflow: hidden;
            float: left;
            margin-right: 8px
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


            left: 0;
        }
        .slide2,
        .page2 {


            left: 100%
        }
        .slide3,
        .page3 {


            left: 200%
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
        .slide-radio5:checked ~ .next .numb1,
        .slide-radio2:checked ~ .previous .numb1,
        .slide-radio3:checked ~ .previous .numb2,
        .slide-radio4:checked ~ .previous .numb3,
        .slide-radio5:checked ~ .previous  {

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
        .postContent{
            padding-left:30px;
        }

        .btn.btn-primary{

            margin-left: 0;
            color: #fff;
            background-color: #ffe537;
            border-radius: 10px;
        }

        .btn.btn-primary:hover{

            margin-left: 0;
            background-color: #ffffff;
            color: #ffe537;
            border-color: #ffe537;
        }

        .btn.btn-warning{

            margin-left: 0;
            color: #060000;
            background-color: #ffe537;
            border-radius: 10px;
            font-size: 12px;
        }

        .btn.btn-warning:hover{

            margin-left: 0;
            background-color: #ffffff;
            color: #ffe537;
            border-color: #ffe537;
        }
        .align-test{
            padding-left: 16px;
            margin-top: 10px;
            font-weight: bold;
        }
        .row.postContent{
            font-weight: bold;
            font-size: 14px;
        }

    </style>



</head>
<body>
<jsp:include page="/views/navbar.jsp" />





<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container" style="margin-top:119px;">

    <div class="page-header">
        <h3 class="truckNameForMenu">${truck.truckName}</h3>
    </div>
    <div class="star-ratings">
        <div
                class="star-ratings-fill space-x-2 text-lg"
                :style="{ width: ratingToPercent + '%' }"
        >
            <c:if test="${rvTotal ne null}">
                <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>(${rvTotal})
            </c:if>
            <c:if test="${rvTotal eq null}">
                <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
            </c:if>

        </div>
        <div class="star-ratings-base space-x-2 text-lg">
            <c:if test="${rvTotal ne null}">
                <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>(${rvTotal})
            </c:if>
            <c:if test="${rvTotal eq null}">
                <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
            </c:if>

        </div>
        <%--            <div class="beside-of-star-ratings">(${rvTotal})</div>--%>

    </div>

    <!--리뷰보기 버튼-->
    <a class="btnf btn-warning" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
        리뷰 보기
    </a>

    <!--좋아요--> <!-- 0115 HHJ 추가 -->


    <button type="button" class="btn btn-outline-danger heart-click-t">
        <c:if test="${truck.truckHeartCount eq '0'}">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16">
                <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"></path>
            </svg>
        </c:if>
        <c:if test="${truck.truckHeartCount ne '0'}">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart-fill" viewBox="0 0 16 16">
                <path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z"></path>
            </svg>
        </c:if>

    </button>
    <span id="heartC">${truck.truckHeartCount}</span>
    <!--좋아요-->

    <!--================truck info 시작=============-->
    <div class="row">

        <div class="col-xs-4 col-md-2"><strong>프 로 필 이 미 지</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckProImg}</div>
        <div class="col-xs-4 col-md-2"><strong>영 업 상 태</strong></div>
        <c:if test="${truck.truckBusiStatus eq 0}">
            <div class="col-xs-8 col-md-4">영업 중</div>
        </c:if>
        <c:if test="${truck.truckBusiStatus eq 1}">
            <div class="col-xs-8 col-md-4">영업 종료</div>
        </c:if>
        <div class="col-xs-4 col-md-2"><strong>전 화 번 호</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckPhone}</div>

        <div class="col-xs-4 col-md-2"><strong>사 장 님 공 지</strong></div>
        <div class="col-xs-8 col-md-4">${truck.truckNoticeContent}</div>
        <input type="hidden" name="truckId" value="${truck.truckId}">

    </div>

    <!--================truck info 끝=============-->

    <hr/>



    <!--리뷰 리스트 시작-->
    <%--    <p>--%>
    <%--      --%>
    <%--        <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">--%>
    <%--            리뷰 보기--%>
    <%--        </button>--%>
    <%--    </p>--%>
    <div class="collapse" id="collapseExample">
        <div class="card review-body">

        </div>
    </div>
    <!--리뷰 리스트 시작-->


</div>
<!--  메뉴 목록 div Start /////////////////////////////////////-->
<body class="row g-5">


<!--헝헝헝-->

<div class="col-md-5 col-lg-4 order-md-last">
    <div class="sticky">
        <form>
            <h4 class="d-flex justify-content-between align-items-center mb-3" style="width:259px;">
                <span class="text">장바구니</span>

                <div id="cartList" name="cartList"></div>
                <div id="add" name="add"></div>

            </h4>
            <ul class="list-group mb-3" style="width:259px;">
                <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAN0AAADlCAMAAADgMwLoAAAAflBMVEX///8AAAD6+voMDAx1dXV5eXnq6upra2uzs7OsrKyhoaHy8vKUlJQ8PDwxMTH5+flgYGDh4eHs7OzLy8u+vr5ubm6NjY3V1dVWVlZERESmpqbc3NzAwMAmJiZkZGSenp44ODiIiIhHR0cYGBgiIiKBgYFQUFArKysbGxsSEhLSQfC6AAAN1klEQVR4nN1d54LyKhB1LbHEFuMae9tVv33/F7xXBlIIwTAMkd3za4sSDmU6pNVyjFkQL0+XW3e9mR6+Oh+dr8N0M+/dVttlHIWuH+4Qwf7Uu3596PCz6Y7iX8cxjE9zLa0i5qd49u4u18QsXm0MmAlMLvG7e/4S0faOYCZwH0XvJlCNaPyo7nnncb6uj/35ffLQ7cXp2EuCi9FU1dvzcTWMd0H547t4OO5evxVfmQx9kzPLdbmX89Uyar/6YhhvPzvlr3q0B4NVaX3dluXpqka4X13lhTzyYwJ3faljvT2mY/+L2rPUjskAuUFSlJETK6kXDooLfJ6Q9RODeFOkZj/a4bAwXOv38UsKm+VCJcoXp3+5Zu/v4Rccc324LknbjvMrdN78/gt7ued36TVwkG//1rAVus09e+VGds9OuWdsnTxCjV3OLDk5fM420/PTncPnFHDJzZvjNZNbIxe3T+JIMonWa8CeyNbnTwPmWTZxm2as+bDb2PRFB/GkDq0O0D401asPpwOabYOVy8eUMGhAeLbTWMm5MQnGEaamw9HRE4J0VY4cPUGHfaobFi6aj9OJe49nMkutMweyM91yzegdFYaiC+QWRM/hwNVGIKJSPdp2hdO1eXM8QAiXNWGb4cHNmCEwErKFbJgXwpht0lKvghBuHSLRGYkt994oh0Aggr0kojsl50uQeDah69CON/XwI77IIGSLtcUkZm7zMqrcJHo0sxfwZq40vSLDjffLSrSEXFreqXpFhguXnBb7pX3wlVyrxXMX3/jQx8Zfcuni3GC/37f8vmNw0YJ0+PjcT2n7RAg++iinZWC/b12D2/ZD828mnlkoKrS/kSbijJPzKMWrgFDHpoKTu/kDJ52iQ4KS6mOLDdsohoiO8iGh9IBdoWu8g9pggHW8spyrMDXdekciB6MRLAyVOtd074jJYrA3EoDh79l0AG6S1TM71iYf9gLf9adj+RvUeBE8OlIj59aGT3bd94kQ47oyni/iX6EMMkAI/mUwmU/yvokuESKpp8MgiTtvpEuU6NWxN5e/Tl5ytOvIQjDBDPJji8AEr0Ztu54IHA2rDmBevnUfgQzLT+0mE02ZtxJzrTlYLLA1dFCgdlXjp89q6w3ATu78axw0zZ2kz5q53FywVH8A1Eb9GBjm7IFmcCfSRw0nD2z/Sut4ZjpkPwh2GjNBLvk3tCi4s1D1bwjxGVjP5VL71/isbs6SHdcKFSKRT52BV+cZO+3kwaY2UeSeseOTp3b0oEkTh9w3duCZ/lP9Czxyo9iZb+z45KmMZGjbSMd4xw4yxQq5CMpwYtSYd+x4XKGcHYCEilns2T92MEclM4CrA7O2MOw0FjoBO96G/FeIWBtWzGLYadwECnYgG2W5Aua5YTrLnF1H9wQKduDnSUobUkWmOWQlu8N4WAm9RKZgx/MKxRUCjp1pElPFzqJumYRdomACDZsm+RTsbLLsJOxarEiuoNkC1Wp9DQU7m6JeGnbj0tKEvxiH+RTsbJK1NOyi0tKcoBamih2i/iDFP6ktZDycxXpy1hg4RuZJHwU7C6GSyG0h2Y2lqRogF5VKZuKzK6W7BpDsIJaVbTM4AWMeolXqu1HYroD07TCPxbJ8KQI2U8O+fCv+iigHM7RVDuPcdxPltRAk7EChpw9iv411XyBhl9/apU1GyA5SzcLmg4AKomLd3M5Md4Mcu6RkBwEIIb3B5UNk7MzZid0we/1Riwwpqyvl0hvMakwRgDk70eHQKTsWmOUJE5CgGBPKV3aw8aAiHLQdRk/5yg5ah2QPhMkw1dO+sgObDqIrzC7TZZ5+Hzum8UCSsJZQZ8+8ZQdRoudPIFRQtr237OAY2/OQFyScUcavObtUMrtlB4P3NB3AYUAdqDFnlz6m9/qzNvVO32IoWUK2g2rDmF1m7bVr1BNYsGPm11OWsFoB3HkRNbvuuALLgrE3muehuG3Nhh2zVu7CDsM1pGJ3x1aYyRUPVuzY6fiH2IAI96elZFe/1qWEMSE7EJozRQipPhTscMMEIGQHam7BWeKiIcQxMemmOxt2M84KbGjcaR/iuZM9WpsKWNbAnmcQcEV9CnYoe5WDkh0rFBrwEhxcEyqZucZX5VKyY+75iR+wxDWh1ne9kQa6e00p2TEb5QLOAlKOY3KvGgFGyY7R6oHNgjzaimJXbdJSsrs8GzhCShlZB41jVylWKdkxcbKGJpG5DRy7flVzlOyYXXcFFVr5QD1w7CqHkpIdMzQ3kHn5e+yYkXJuscsONAVAOvjO7gFe7B9ld4B43x9lN/2rUoXF/M7Q5N9jx5yDjZU217+WowqVnSbXd3c4MYG0xOQb2uuh8qiK/EqMW9UHa4DbKqyHSK+sVkRZRnXltRxYsTkEyOKlXSsPqLU4yn1/CU0JaLv4Sauboj6fLdxaFxt2zy6ZQdtWmB8suzsD5zCSEEb05phrvWF4DaboRjwZ5PMdMSgwVgOeY/bjAkJCcLGUWIsnHxHwFQlS/bfcWFEXMGchj9raKE4fwVKuz1gYc/D8vO4ND6YJnsXRzNB8UDYdJvuBMeKI8mUETJk/rWcwVsiaXnZxtvVzrMdkt/GcQZmLa65p2o3qpMN1mNrkkDKAMHm2BeKF4uKw8NOS2xMdip6AQnjOGKgEgpvDBrpOG+Bqf8sEmCjsR/aT/S1GXV2PzWB9Lw/z7sCtm2dELWDzzsISbFcn6ww4GeAlWNrRmFdNuqPH2oCbyWOC9sy92BewMut3uSZArFjZYkNdR3Gw7w5X4Uz12SS8F/TksEFIBhYrEpEwUMEWl7qbvLm2NizWJisJEAEcqGHEb7w6JyfMgT+nCNtOqBXYePjYqKqCjQBorQdFKumvk+KvhnCx655AX/vFRjszTyBMil3o5eI8IiD9FgiLZtGGivsDaoJYkWdAvukLxEjOOmG/Iz3Y8pGen0HlEbxKzKJLqR2kCmb6IH+xGFjAOB+vdO0WVtjt5YZwoXYY7fxChIZx9XlLuVPoNzKUyk8t+lMQIuwvyitzXmIrdcki/k/CTuHyfJYJ14U84haxA7n8FPW+5tLCFH4CSqHLL8i2cDbkF2Vj2CnDRHCtGybzMpK6ZPFWQ4qVyaqLZMG2Qo+7HE7BV7WX5BOiDVDd8iu1oLQdkz+P5T5hPcWZHAjFqJZP9ZIGWxMRfygnz7sonZCU6kMQYgA6U64ZgWWBKTpSHIvfdHuGOJavCsDsExDgCu/iRz2nr3Ep94sGCH+afU+1ooE2QuK5cV5RQgAknErjcmsYoRQOmi5aALEwYf0p/wXiBpGFpQqxSzDvCMgO9fKLsI26mTzEayDhxGKF6ICyL8SlASWVRwCEsgNPp0rd8slD7DzbtJ0CCM0LSqVS6oPzgDEUTW/FfgnEuoQIdLWlxCcPofNQ1X4aIKy59svOg9jEOEKRpqvmwITZQV/rQl98CjABlgW6GKAMTHSOd10rNMARQpXatsmyXKhIHzxdv1354sX513uS6eujgrSglF4lsngmDhkGHuKq3HOYI0tLYGBfFvOBn4fOnsVdzNX0HJMTttyh7hXz9q9diZbjXt8U3cs2xldy8E7XcJn4m0a9qSWuAzB0a9mQwA55NOgtuLAe17NMuU2MzMC8ATVfBsRh9E6y96MN8rJ2FgTEntmd7e/D3GBdPsGn+neUE/PUr4HHtPo9W4/PhJHHdDUekDeBG89mFQT8Sx3KWmUngKTYl6F25mrB6hxVA8C+3ZQnHW3KtdyDdxKREOUHI20uu3ENHkhF5bLPCGnUKKx2j4gE+XoCiuuCb6TkE5Uofr4cVcSp0AUkscf0RObJ4piIyGRbVKY6QkIx8JiXozcBsaosa9/BRrV4L4ATCHK28tzmEkNnECX01ic+dxQLgBhjopkTcsWrt9SLA0cEh9lGdjqFHrM7HTnpTQrvRySi3SQWFBspfyIsaSkZzV75hzbCXYBHkj8ONFsFckI2L2giRCBqttA3/0qIPPIS0oNiZEsp9kYhZHev0BxrfgLqcD3ImKT1TP8I43RsG+Nq3SkRpgepSC1e6cDQm5CdNKJblU98Ve7iWdyU07dPC1PPtI9sV1qrz33QbSJLFGWn+yyq5ZUIKhSC2Acr1/ImyC5XmJJL7uwNGAXkjiifXPJb5KrrHAQeC0eb02cWrwVwxi/IcTu62AQrhUKQTzV9fFxcOEhJrnTp4CYox9KahexRIJ/VYfikvrFrn18frqLhrDQnHxDLDv18tpI80anuinJDBIVjYe5iOqz5TING2Q2XTI7GhSNla5JUbTgsrI6bO60DAbF00WdDehSCJi4u1N7eTsSEg+LZ9bHL7CgoBC4zomyi8pOUSGfpj0vsaO9G0ulnx24lGObwczZxc2lAg1uxUx/Ti3HJVzCQ71G9Oi9JYAqBBVV2WVm3IrbZ3spnOj+mvUFN22IRn+alws5VA/UIzAx65pYv6WPXFbMSrRRHLr77p2USVu2dMNpve6o7IubNxAL4He5JdnpM54EkVacSHpv5bTwaDgb7OIn3g8HwNO6tJxUHUO6EqkUPeF626u6vjJK4pzhGZ4D1oLniNPnyjVo2QzRE3iVzWMWNRjiKdxxs6ruOu21ffpu3HvexRWEtEoWTZ6bKJ4xPn3UozlfL4C1RqdzFKROkzx/Fp1X/ei5Xgj+u/fE2fmcdWuYXW1uyszCMkjje7+M42S3CmQcxRGFDTv0v9UOAqwLqYI0nYPvu4UOY3Qku3tUDGOI/P5WpBYaF8HcAAAAASUVORK5CYII=">
            </ul>
            <input type="hidden" id="orderUserId" name="orderUserId.userId" value="${user.userId}"/>
            <input type="hidden" id="orderTruckId" name="orderTruckId.truckId" value="${truck.truckId}"/>
            &emsp;&emsp;<button type="button"  class="btn btn-warning" data-toggle="modal" data-target="#cartModal" >주문하기</button>
            &emsp;&emsp;<button type="button"  class="btn btn-warning" id="cancelCartMenuList"  >삭  제</button>
        </form>
    </div>
    <%--</form></div>--%>
</div>

<!--헝헝헝 끝-->


<div class="container col-md-7 col-lg-8">

    <c:set var="i" value="0"/>
    <c:forEach var="menu" items="${list}">
        <c:set var="i" value="${i+1}"/>
        <div class="card" style="width: 17rem; margin-bottom:15px; margin-left: 10px;">
            <img class="card-img-top" src="/resources/menu/${menu.menuImg1}" alt="Card image cap"
                <%--                        <img class="card-img-top" src="/resources/image/menu/${menu.menuImg1}" alt="Card image cap"--%>
                 style="border-bottom: 1px solid #eee; height: 200px;">
            <div class="card-body" style="text:center ">
                <h3 class="align-content-center"> <strong style="text:center;">${menu.menuName}</strong></h3>
                <h3> ${menu.menuPrice}원</h3>
                <ul class='card-body-ul'>
                    <h4>${menu.menuDetail}</h4>
                </ul>
                <div class="btn-detail">
                        <%--          //////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 수정--%>
                    <button class="button is-warning is-light" id="truckIdCheck" name="getMenu"
                            style='margin-left: 100px; margin-bottom: 13px; height: 25px'
                            onclick="getMenu(${menu.menuNo});"
                    >
                        메뉴 상세보기
                        <input type="hidden" name="menuNo" value="${menu.menuNo}"/>
                    </button>
                        <%--                                <div class="bd-example">--%>
                        <%--                                    <button type="button" name="getMenu" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModalLong">--%>
                        <%--                                        Launch demo modal--%>

                        <%--                                    </button>--%>
                        <%--                                    <input type="hidden" name="menuNo" value="${menu.menuNo}"/>--%>
                        <%--                                </div>--%>
                </div>
            </div>
        </div>
    </c:forEach>

</div>
<!--  메뉴 목록 div End /////////////////////////////////////-->


</body>


<!--////////////////모달 메뉴 상세보기 시작////////////-->
<!-- Modal -->

<div class="modal fade" id="exampleModalLong" tabindex="-1" aria-labelledby="exampleModalLongTitle" style="display: none;" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">메뉴 정보</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body-hey" style="min-height: 500px; margin-left: 19px;">
                <p>This is some placeholder content to show the scrolling behavior for modals. Instead of repeating the text the modal, we use an inline style set a minimum height, thereby extending the length of the overall modal and demonstrating the overflow scrolling. When content becomes longer than the height of the viewport, scrolling will move the modal as needed.</p>
            </div>
            <div class="modal-happy">

            </div>
            <div class="modal-footer">

                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-default" id="addCart" data-dismiss='modal' name="addCart">장바구니로!</button>
            </div>
        </div>
    </div>
</div>


<!--review Modal -->
<div class="modal fade" id="staticBackdrop" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog review" role="document">
        <div class="modal-content review">
            <div class="modal-header review">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"></span>
                </button>
            </div>
            <div class="wrapper">
                <div class='main-insta'>
                    <div class='insta-header'>
                        <span class="header-title">

                         </span>
                        <h2></h2>
                    </div>
                    <div class="insta-post">
                        <div class="css-slider-wrapper">
                            <input type="radio" name="slider" class="slide-radio1" checked id="slider_1" style="display: none">
                            <input type="radio" name="slider" class="slide-radio2" id="slider_2" style="display: none">
                            <input type="radio" name="slider" class="slide-radio3" id="slider_3" style="display: none">

                            <div class="slider-pagination">
                                <label for="slider_1" class="page1" id="page1"></label>
                                <label for="slider_2" class="page2" style="display: none"></label>
                                <label for="slider_3" class="page3" style="display: none"></label>

                            </div>
                            <div class="next pagi-main">
                                <label for="slider_1" class="numb1"></label>
                                <label for="slider_2" class="numb2" style="display: none"></label>
                                <label for="slider_3" class="numb3" style="display: none"></label>

                            </div>
                            <div class="previous pagi-main">
                                <label for="slider_1" class="numb1"></label>
                                <label for="slider_2" class="numb2" style="display: none"></label>
                                <label for="slider_3" class="numb3" style="display: none"></label>

                            </div>
                            <div class="slider slide1">
                                <div>

                                </div>
                            </div>
                            <div class="slider slide2">
                                <div>

                                </div>
                            </div>
                            <div class="slider slide3">
                                <div>

                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <div class="modal-body review">


            </div>

            <div class="modal-footer review">
            </div>
        </div>
    </div>
</div>

<!--review 모달-->

<script>
    $("body").on("click", ".heart-click-t", function() {
        var role = '${sessionScope.role}';
        console.log("role"+role);

        if(role=="truck") {
            alert("푸드트럭은 좋아요를 누를 수 없어요 ( ´･･)ﾉ(._.`)");
        }else{
            var truckId = $('input[name="truckId"]').val();
            console.log("truckId: " + truckId);

            // 빈하트를 눌렀을때
            if ($(this).children('svg').attr('class') == "bi bi-suit-heart") {
                console.log("빈하트 클릭" + truckId);

                $.ajax({
                    url: '/community/json/addHeartTruck',
                    type: 'get',
                    data: {
                        truckId: truckId,
                    },
                    success: function (pto) {
                        //페이지 새로고침
                        //document.location.reload(true);
                        console.log("pto: "+pto.heartCount)
                        let heart = pto.heartCount;


                        $('#heartC').text(하트);

                        console.log("하트 추가!!!!!!!!!!");
                    },
                    error: function () {
                        alert('서버 에러');
                    }


                });
                console.log("하트채워");

                // 꽉찬하트로 바꾸기
                $(this).html("<svg xmlns='http://www.w3.org/2000/svg' width='20' height='20' fill='red' class='bi bi-suit-heart-fill' viewBox='0 0 20 20'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z' /></svg>");
                //$('.heart_icon').html("<svg xmlns='http://www.w3.org/2000/svg' width='20' height='20' fill='red' class='bi bi-suit-heart-fill' viewBox='0 0 20 20'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z' /></svg>");

                // 꽉찬 하트를 눌렀을 때
            } else if ($(this).children('svg').attr('class') == "bi bi-suit-heart-fill") {
                console.log("꽉찬거 하트 클릭 " + truckId);

                $.ajax({
                    url: '/community/json/removeHeartTruck',
                    type: 'get',
                    data: {
                        truckId: truckId,
                    },
                    success: function (pto) {
                        //페이지 새로고침
                        //document.location.reload(true);
                        console.log("pto: "+pto)
                        let heart = pto.heartCount;
                        // 페이지에 하트수 갱신
                        //

                        $('#heartC').text(하트);

                        console.log("하트삭제!!!!!!!!!");
                    },
                    error: function () {
                        alert('서버 에러');
                    }
                });
                console.log("빈하트!!!!!!!!!");

                // 빈하트로 바꾸기
                $(this).html('<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="red" class="bi bi-suit-heart" viewBox="0 0 20 20"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');

                //$('.heart_icon' + postNo).html('<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="red" class="bi bi-suit-heart" viewBox="0 0 20 20"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
            }
        }


    });


</script>


<form>

    <%--cart Modal--%>
    <div class="modal fade" id="cartModal" tabindex="-1" aria-labelledby="cartModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="cartModalLabel">주문정보입력
                    </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="orderPickUpTime" class="col-form-label">픽업희망시간:</label>
                        <div class="toggle3" role="group" aria-label="Basic radio toggle button group">
                            <input type="radio" class="btn-check" id="orderPickUpTime" name="orderPickUpTime" value="5"
                                   id="btnradio1" autocomplete="off" checked>
                            <label class="btn btn-outline-primary" for="btnradio1">5분</label>

                            <input type="radio" class="btn-check" name="orderPickUpTime" value="10" id="btnradio2"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="btnradio2">10분</label>

                            <input type="radio" class="btn-check" name="orderPickUpTime" value="15" id="btnradio3"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="btnradio3">15분</label>

                            <input type="radio" class="btn-check" name="orderPickUpTime" value="20" id="btnradio4"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="btnradio4">20분</label>

                            <input type="radio" class="btn-check" name="orderPickUpTime" value="30" id="btnradio5"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="btnradio5">30분</label>

                            <input type="radio" class="btn-check" name="orderPickUpTime" value="40" id="btnradio6"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="btnradio6">40분</label>

                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="menuRequest" class="col-form-label">주문요청사항:</label>
                        <textarea class="form-control" id="menuRequest" name="menuRequest"
                                  value="${purchase.orderRequest}"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" id="addMenuCart">확인</button>





                    <input type="hidden" id="orderQty" name="orderQty" value="3"/>
                    <input type="hidden" id="orderTotalPrice" name="orderTotalPrice" value="3000"/>
                </div>
            </div>
        </div>
    </div>

</form>
<script>
    $(function(){
        var modal = $('#exampleModalLong');

        $("#exampleModalLong").on('hide.bs.modal', function(e){
            // window.location.reload();
            // e.stopImmediatePropagation();
        });

        $("#addCart").on("click", function(){
            // 카트에 담기!(selected 등..)

        });

        $("body").on("click", "button[name='getMenu']", function(){
            var menuNo = $(this).parent().find("input[name='menuNo']").val();
            // alert("menuNo : " + menuNo);
            getMenu(menuNo);
        });

        // function getMenuDetail(menuNo){
        //
        // }

    })
</script>



</body>
</html>