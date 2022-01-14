<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>메뉴 목록</title>
    <jsp:include page="../../common/lib.jsp"/>

    <script>
        <%--        메뉴 상세보기 모달에서 장바구니에 담기!--%>

        $(function(){

            var modalApply = $('#exampleModalLong');



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
                    if(originalSession.length){ //세션에 담긴 애가 있을 때
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



                        else{// 만약 session의 od 갯수가 1과 0이 아닐 때 (0인 경우는 한 단계 outer에 있음 - null check 시
                            //console.log("가가가가");
                            //qtyFlag가 0인 애 찾기

                            var arrayMenuZero = []; //수량제공메뉴 파악해서 모아두기
                            for(var zero=0; zero<originalSession.length; zero++){
                                if(originalSession[zero]['odMenuQtyFlag']==0){

                                    arrayMenuZero.push(zero);
                                }
                            }
                            console.log("00000");
                            console.log("00000arrayMenuZero : " + arrayMenuZero);
                            console.log("00000");

                            var arrayMatch = [];
                            for(var match=0; match<arrayMenuZero.length; match++){
                                // arrayMenuZero[match+1]*=1;
                                // arrayMenuZero[match]*=1;
                                arrayMatch.push(arrayMenuZero[match+1]-arrayMenuZero[match]-1);
                            }

                            console.log("11111");
                            console.log("11111arrayMatch : " + arrayMatch);
                            console.log("11111");

                            var hard = 0;
                            var comparisonTarget = []; //여기에 옵션그룹 수가 같아서 비교 대상이 되는 수량제공메뉴의 순서가 들어감

                            for(var aOrB=0; aOrB<arrayMatch.length; aOrB++){
                                if(isThereOptionGroup==arrayMatch[aOrB]){
                                    ++hard;
                                    comparisonTarget.push(arrayMenuZero[aOrB]);

                                }
                            }

                            console.log("22222");
                            console.log("22222comparisonTarget : " + comparisonTarget);
                            console.log("22222");

                            // hard가 0일 때 그냥 단순 push 하면 되고, 0이 아닐 때는 comparisonTarget에 담긴 순서에 있는 애를 비교
                            if(hard===0){ //단순 올리기
                                ///////////////////////////////
                                // 원래 있던 session에 수량 정보 제공 메뉴 하나 더 담기
                                menuOdList.push(orderDetail);

                                if(isThereOptionGroup!=0){
                                    for(var i=0; i<odOptionGroupList.length; i++){
                                        menuOdList.push(odOptionGroupList[i]);
                                    }
                                }
                                //list의 json을 스트링으로 만들어서 menu에 넣고 session에 담는다.
                                sessionStorage.setItem("menuOdList", JSON.stringify(menuOdList));

                            }else{ // comparisonTarget에 담긴 순서에 있는 애를 추가할 메뉴랑 비교
                                for(var compa=0; compa<originalSession; compa++){
                                    for(var tar=0; tar<comparisonTarget; tar++){
                                        if(comparisonTarget[tar]==compa){//여기까지가 비교대상인지 아닌지 거르기 (compa== 세션에서의 비교대상 수량제공메뉴 순번
                                            if(originalSession[compa]['odMenuNo']==orderDetail['odMenuNo']){ //수량제공메뉴가 같은지
                                                var optionSame = 0;
                                                for(var order=compa+1;order<comparisonTarget[tar+1];order++){//옵션no 같은지
                                                    if(originalSession[order]['odOptionNo']==odOptionGroupList[order-compa-1]){//옵션no 같으면 optionSame에 1추가
                                                        optionSame++;
                                                    }
                                                }//for문 다 돌아가고 optionSame이 isthereOptionGroup과 같은지 비교
                                                console.log("optionSame : " + optionSame);
                                                console.log("isThereOptionGroup : " + isThereOptionGroup);

                                                if(optionSame!=0 && optionSame==isThereOptionGroup){ //드디어 같다면 수량추가
                                                    ///////////////////////////////수량추가
                                                    orderDetail['odMenuQty']=originalSession[compa]['odMenuQty']+1;
                                                    //수량 추가된 메뉴를 list의 요소와 바꾼다.
                                                    menuOdList[compa]=(orderDetail);
                                                    //console.log("ccc : list 요소 바꾼 후 : "  +JSON.stringify(menuOdList[i]));
                                                    //list의 json을 스트링으로 만들어서 menu에 넣고 session에 담는다.(겉으로는 수량이 추가된 것
                                                    // if(isThereOptionGroup!=1){
                                                        for(var c=0; c<isThereOptionGroup; c++){
                                                            menuOdList[compa+c+1]=odOptionGroupList[c];
                                                        }
                                                    // }else{
                                                    //     menuOdList[compa+1]=odOptionGroupList[0];
                                                    //     //console.log("1개일 때");
                                                    // }
                                                    sessionStorage.setItem("menuOdList", JSON.stringify(menuOdList));


                                                }//!!!!!!!!!!!!!!!
                                                else{//옵션이 다르면 단순 올리기
                                                    ///////////////////////////////
                                                    menuOdList.push(orderDetail);

                                                    if(isThereOptionGroup!=0){
                                                        for(var i=0; i<odOptionGroupList.length; i++){
                                                            menuOdList.push(odOptionGroupList[i]);
                                                        }
                                                    }
                                                    //list의 json을 스트링으로 만들어서 menu에 넣고 session에 담는다.
                                                    sessionStorage.setItem("menuOdList", JSON.stringify(menuOdList));

                                                }
                                            }
                                            else{//수량제공메뉴랑 다르면 단순 올리기
                                                ///////////////////////////////
                                                menuOdList.push(orderDetail);

                                                if(isThereOptionGroup!=0){
                                                    for(var i=0; i<odOptionGroupList.length; i++){
                                                        menuOdList.push(odOptionGroupList[i]);
                                                    }
                                                }
                                                //list의 json을 스트링으로 만들어서 menu에 넣고 session에 담는다.
                                                sessionStorage.setItem("menuOdList", JSON.stringify(menuOdList));

                                            }

                                        }
                                    }
                                }
                            }
                        //
                        //     for(var i=0; i<originalSession.length;i++){//qtyFlag가 0인 애가 추가 메뉴&옵션 갯수와 이름까지 같을 때 이 안에서 session 저장 끝남
                        //         if(originalSession[i]['odMenuQtyFlag']==0){//세션에 담긴 애 중 수량제공메뉴일 때
                        //             //console.log("//세션에 담긴 애 중 수량제공메뉴일 때 i : " +i);
                        //
                        //             if(originalSession[i+1]!=null
                        //                 && originalSession[i]['odMenuNo']==originalSession[i+1]['odMenuNo']
                        //                 && originalSession[i+1]['odMenuQtyFlag']==1){//bbb. 세션에 옵션그룹이 있는 메뉴
                        //                 //console.log("cccccccccccccccc");
                        //                 //console.log("////bbb. 옵션그룹이 있는 메뉴 i : " +i);
                        //                 //console.log("추가할 메뉴랑 no 같은가");
                        //                 //console.log("메뉴 no 같은지 확인 : " +originalSession[i]['odMenuNo']+"==="+orderDetail['odMenuNo']);
                        //                 if(originalSession[i]['odMenuNo']===orderDetail['odMenuNo']){//추가할 메뉴랑 같을 때
                        //                     //console.log("추가할 메뉴랑 no 같을 때");
                        //                     //console.log("메뉴 no 같은지 확인 : " +originalSession[i]['odMenuNo']+"==="+orderDetail['odMenuNo']);
                        //                     //console.log("i="+i);
                        //                     var isItSame = 0;
                        //                     // for(var k=i+1; k<i+originalSession.length; k++){
                        //                     //     //console.log("///////////originalSession json parse"+k+" : "+JSON.stringify(originalSession[k]));
                        //                     // }
                        //
                        //                     if(isThereOptionGroup!=1){//추가할 옵션그룹 수가 1이 아닐 때
                        //                         for(var f=i+1; f<i+originalSession.length; f++) {
                        //
                        //                             if(originalSession[f]!=null && originalSession[f]['odMenuQtyFlag']!=0) {
                        //                                 isItSame++;
                        //                                 // console.log(isItSame + " : isItSame");
                        //                                 //console.log(isThereOptionGroup + " : isThereOptionGroup");
                        //
                        //                             }else {
                        //                                 //console.log("break;");
                        //                                 break;
                        //
                        //                             }
                        //                         }
                        //                     }else{//추가할 옵션그룹 수가 1일 때
                        //                         if(originalSession[i+2]!=null){
                        //                             if(originalSession[i+2]['odMenuQtyFlag']===1){
                        //                                 isItSame++;
                        //                             }
                        //                         }else{
                        //                             isItSame++;
                        //                         }
                        //
                        //                     }
                        //                     //console.log("111111111111111isItSame : " + isItSame);
                        //                     //console.log("111111111111111111111isThereOptionGroup : " + isThereOptionGroup);
                        //                     if(isItSame===isThereOptionGroup) { //옵션그룹의 수 같은가?
                        //                         var isItReallySame =0;
                        //                         if(isThereOptionGroup!=1){ //추가하려는 옵션그룹&비교대상 옵션그룹 수가 1이 아닐 때
                        //                             for(var a = i+1; a<i+isItSame+1; a++) {
                        //                                 //console.log("제발 111111111111");
                        //
                        //                                 if(originalSession[a]['odOptionNo']===odOptionGroupList[a-i-1]['odOptionNo']) {
                        //                                     //console.log("제발 222222222222222222");
                        //                                     //console.log("///////////originalSession json parse"+a+" : "+JSON.stringify(originalSession[a]));
                        //                                     //console.log("///////////odOptionGroupList json parse"+(a-i-1)+" : "+JSON.stringify(odOptionGroupList[a-i-1]));
                        //
                        //                                     isItReallySame++;
                        //                                 }//옵션그룹의 옵션 넘버가 다 같은가?
                        //                             }
                        //                         }else{//추가하려는 옵션그룹&비교대상 옵션그룹 수가 1일 때
                        //                             //console.log("제발 3333333333333");
                        //                             //console.log( " i : " + i);
                        //                             if(originalSession[i+1]!=null){//널체크
                        //                                 //console.log("제발 444444444444444");
                        //                                 //console.log( " i : " + i);
                        //                                 //console.log("JSON.stringify(originalSession["+i+1+"])"+(originalSession)[i+1]['odOptionNo']);
                        //                                 //console.log("JSON.stringify(odOptionGroupList[0])"+(odOptionGroupList)[0]['odOptionNo']);
                        //                                 if(originalSession[i+1]['odOptionNo']===odOptionGroupList[0]['odOptionNo']) {
                        //                                     isItReallySame++;
                        //                                     //console.log("제발 55555555555555");
                        //                                 }//옵션그룹의 옵션 넘버가 다 같은가?
                        //
                        //                             }else{
                        //                                 //console.log("제발 66666666666");
                        //                                 for(var a = i+1; a<i+isItSame; a++) {
                        //                                     //console.log("제발 777777777777777");
                        //                                     if(originalSession[a]['odOptionNo']===optionGroupOrderDetail['odOptionNo']) {
                        //                                         //console.log("제발 88888888888888");
                        //                                         isItReallySame++;
                        //                                     }//옵션그룹의 옵션 넘버가 다 같은가?
                        //                                 }
                        //                             }
                        //                         }
                        //
                        //                         //console.log("111111111111111isItReallySame : " + isItReallySame);
                        //                         //console.log("111111111111111111111isThereOptionGroup : " + isThereOptionGroup);
                        //
                        //                         if(isItReallySame===isThereOptionGroup ) {//ccc. 옵션그룹들도 다 똑같으면
                        //                             // 수량 추가
                        //                             //console.log("ccc : 수량 추가 이전 ="+originalSession[i]['odMenuQty']);
                        //                             orderDetail['odMenuQty']=originalSession[i]['odMenuQty']+1;
                        //                             //console.log("ccc : 수량 추가 이후 ="+orderDetail['odMenuQty']);
                        //                             //수량 추가된 메뉴를 list의 요소와 바꾼다.
                        //                             //console.log("ccc : list 요소 바꾸기 전 : "  +JSON.stringify(menuOdList[i]));
                        //                             menuOdList[i]=(orderDetail);
                        //                             //console.log("ccc : list 요소 바꾼 후 : "  +JSON.stringify(menuOdList[i]));
                        //                             //list의 json을 스트링으로 만들어서 menu에 넣고 session에 담는다.(겉으로는 수량이 추가된 것
                        //                             if(odOptionGroupList.length!=1){
                        //                                 for(var c=0; c<odOptionGroupList.length; c++){
                        //                                     menuOdList[i+c+1]=odOptionGroupList[c];
                        //                                     //console.log("1개 아닐 때 "+c);
                        //                                     //console.log("odOptionGroupList ["+c+"] : " + odOptionGroupList[c]);
                        //                                 }
                        //                             }else{
                        //                                 menuOdList[i+1]=odOptionGroupList[0];
                        //                                 //console.log("1개일 때");
                        //                             }
                        //
                        //
                        //                             sessionStorage.setItem("menuOdList", JSON.stringify(menuOdList));
                        //                             didYouAddOp++;
                        //                             //console.log("didYouAddOp(1 초과 불가) : "+didYouAddOp );
                        //
                        //                             //console.log("ccc. 요소 수량 추가 로직 끝");
                        //
                        //                         }
                        //                     }
                        //
                        //                 }//추가할 메뉴랑 같을 때 끝
                        //
                        //             }//bbb. 마지막 요소 아니면서 옵션 그룹 있는 애 끝
                        //         }//세션에 담긴 애 중 수량제공메뉴일 때 끝
                        //
                        //     }//qtyFlag가 0인 애가 있으면서 추가 메뉴와 같을 때 이 안에서 session 저장 끝남
                        //
                        //     //console.log("didYouAddOp(1 초과 불가) : "+didYouAddOp );
                        //     if(didYouAddOp==0 && didYouAdd==0){//fianl 만약 세션에 추가메뉴가 저장되지 않았다면
                        //
                        //         // 원래 있던 session에 수량 정보 제공 메뉴 하나 더 담기
                        //         //console.log("fianl : 하나 더 담기 이전 ="+JSON.stringify(menuOdList));
                        //         menuOdList.push(orderDetail);
                        //         //console.log("fianl : 하나 더 담기 이후 ="+JSON.stringify(menuOdList));
                        //
                        //         // 원래 있던 session에 수량 정보 제공 메뉴 하나 더 담기
                        //         //console.log("fianl : 옵션 더 담기 이전 ="+JSON.stringify(menuOdList));
                        //         if(isThereOptionGroup!=0){
                        //             for(var i=0; i<odOptionGroupList.length; i++){
                        //                 menuOdList.push(odOptionGroupList[i]);
                        //             }
                        //         }
                        //         //console.log("fianl : 옵션 더 담기 이후 ="+JSON.stringify(menuOdList));
                        //         //console.log("bbbbbbbbbbbb");
                        //         var beforeAnyway = JSON.parse(sessionStorage.getItem("menuOdList"));
                        //
                        //         for( var i in beforeAnyway){
                        //             // console.log("beforeAnyway : " + beforeAnyway[i]);
                        //             for(var j in beforeAnyway[i]){
                        //                 //console.log("afterAnyway key : " +j+"/value : " + beforeAnyway[i][j]);
                        //
                        //             }
                        //         }
                        //
                        //
                        //         //list의 json을 스트링으로 만들어서 menu에 넣고 session에 담는다.
                        //         sessionStorage.setItem("menuOdList", JSON.stringify(menuOdList));
                        //         didYouAddOp++;
                        //         //console.log("didYouAddOp(1 초과 불가) : "+didYouAddOp );
                        //
                        //         //console.log("fianl. 메뉴와 옵션 더 담기 로직 끝");
                        //     }//fianl.만약 세션에 추가메뉴가 저장되지 않았다면 끝
                        //     //console.log("aaaaaaaaaaaaaaaa");
                        //     var beforeAnyway = JSON.parse(sessionStorage.getItem("menuOdList"));
                        //
                        //     for( var i in beforeAnyway){
                        //         // console.log("beforeAnyway : " + beforeAnyway[i]);
                        //         for(var j in beforeAnyway[i]){
                        //             //console.log("afterAnyway key : " +j+"/value : " + beforeAnyway[i][j]);
                        //
                        //         }
                        //     }
                        //
                        }// 만약 session의 od 갯수가 1과 0이 아닐 때 끝
//////////////////////////////////////////////////////
                    } //세션에 담긴 애 있을 때 끝

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




                // location.reload();

            });

            // 화면에 담기

            var targetCart = $('div.sticky').find('ul');

            var beforeAnyway = JSON.parse(sessionStorage.getItem("menuOdList"));

            for( var i in beforeAnyway){
                // console.log("beforeAnyway : " + beforeAnyway[i]);
                for(var j in beforeAnyway[i]){
                    console.log("afterAnyway key : " +j+"/value : " + beforeAnyway[i][j]);

                }
            }
            //담을 li

            var finalCart = "";
            var forOne=0;




            // ////////////시작///////////////////
            // if(beforeAnyway) { // sessionStorage에 뭔가 있다?
            //     console.log("sessionStorage에 있다! 시작!");
            //     for (var i = 0; i < beforeAnyway.length; i++) {//sessionStorage만큼 for문 돌리기
            //
            //
            //
            //
            //         console.log("for문 안에 있다!");
            //         console.log("beforeAnyway[" + i + "] : " + JSON.stringify(beforeAnyway[i]));
            //         // finalCart += "<li class=\"list-group-item d-flex justify-content-between lh-sm\">"+
            //         //     "<div><h6 class=\"my-0\">"+beforeAnyway[i]['odMenuName']+"</h6>"+
            //         //     "<h6 class=\"my-0\">"+beforeAnyway[i]['odMenuQty']+"</h6>"+
            //         //     "<small class=\"text-muted\">"+beforeAnyway[i]['odOptionGroupName']+"</small>"+
            //         //     "<small class=\"text-muted\">"+beforeAnyway[i]['odOptionName']+"</small>"+
            //         //     "</div><span class=\"text-muted\">"+beforeAnyway[i]['odMenuPrice']+"</span></li>";
            //
            //         if(beforeAnyway[i]['odMenuQtyFlag']==0){//플래그0일 때 메뉴 수량, 이름 출력
            //             finalCart+=""+
            //                 "<li class=\"list-group-item d-flex justify-content-between lh-sm\">"+
            //                 "<div><h6 class=\"my-0\">"+beforeAnyway[i]['odMenuName']+"</h6>"+
            //                 "<h6 class=\"my-0\">수량 : "+beforeAnyway[i]['odMenuQty']+"</h6>"+
            //                 "";
            //             forOne+=1;
            //             // }else{
            //             for(var j=i+1; j<beforeAnyway.length; j++){
            //                 if(beforeAnyway[j]['odMenuQtyFlag']==1){
            //                     finalCart+=""+
            //                         "<p></p>"+
            //                         "<small class=\"text-muted\">"+beforeAnyway[j]['odOptionGroupName']+"</small> : "+
            //                         "<small class=\"text-muted\">"+beforeAnyway[j]['odOptionName']+"</small> +"+
            //                         "<small class=\"text-muted\">"+beforeAnyway[j]['odOptionPrice']+"원</small>";
            //                     forOne+=1;
            //                 }else{
            //                     // i=j-1;
            //                     break;
            //                 }
            //             }
            //         }else{
            //             if(forOne!=0){
            //                 i=forOne;
            //             }else{
            //                 break;
            //             }
            //
            //         }
            //         finalCart+="</div><span class=\"text-muted\">"+beforeAnyway[i]['odMenuPrice']+"원</span></li>";
            //         i=forOne;
            //
            //
            //
            //     }//sessionStorage만큼 for문 돌리기
            // }
            // targetCart.html(finalCart);


        });




        $(function (){

            var beforeAny = JSON.parse(sessionStorage.getItem("menuOdList"));
            var orderDetailList = "";

            for (var i in beforeAny) {



                orderDetailList += "<input type='hidden' name='odMQFlag' id='odMQFlag' value='" + beforeAny[i]['odMenuQtyFlag'] + "'>" +
                    "<input type='hidden' name='odMQty' id='odMQty' value='" + beforeAny[i]['odMenuQty'] + "'>" +
                    "<input type='hidden' name='odMName' id='odMName' value='" + beforeAny[i]['odMenuName'] + "'>" +
                    "<input type='hidden' name='odMPrice' id='odMPrice' value='" + beforeAny[i]['odMenuPrice'] + "'>" +
                    "<input type='hidden' name='odOGName' id='odOGName' value='" + beforeAny[i]['odOptionGroupName'] + "'>" +
                    "<input type='hidden' name='odOpName' id='odOpName' value='" + beforeAny[i]['odOptionName'] + "'>" +
                    "<input type='hidden' name='odOpPrice' id='odOpPrice' value='" + beforeAny[i]['odOptionPrice'] + "'>" +
                    "<input type='hidden' name='odMImg1' id='odMImg1' value='" + beforeAny[i]['odMenuImg1'] + "'>";



            }
            $("#cartList").append(orderDetailList);

        });



        /*장바구니 주문하기 이후 Modal에서 확인 클릭 시*/
        $(function () {
            $("#addMenuCart").click(function () {


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


    </script>

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
    </style>

</head>
<body>
<jsp:include page="/views/navbar.jsp" />
<br>
<br>
<br>
<br>
<br>


<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">

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

    </div>

    <!--================truck info 끝=============-->

    <hr/>



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
                <li class="list-group-item d-flex justify-content-between lh-sm">
                    <div>
                        <h6 class="my-0">Product name</h6>
                        <small class="text-muted">Brief description</small>
                    </div>
                    <span class="text-muted">$12</span>
                </li>
                <li class="list-group-item d-flex justify-content-between lh-sm">
                    <div>
                        <h6 class="my-0">Second product</h6>
                        <small class="text-muted">Brief description</small>
                    </div>
                    <span class="text-muted">$8</span>
                </li>
                <li class="list-group-item d-flex justify-content-between lh-sm">
                    <div>
                        <h6 class="my-0">Third item</h6>
                        <small class="text-muted">Brief description</small>
                    </div>
                    <span class="text-muted">$5</span>
                </li>
                <li class="list-group-item d-flex justify-content-between bg-light">
                    <div class="text-success">
                        <h6 class="my-0">Promo code</h6>
                        <small>EXAMPLECODE</small>
                    </div>
                    <span class="text-success">−$5</span>
                </li>
                <li class="list-group-item d-flex justify-content-between">
                    <span>Total (USD)</span>
                    <strong>$20</strong>
                </li>
                <div class="appendCart"></div>
            </ul>
            <input type="hidden" id="orderUserId" name="orderUserId.userId" value="user01"/>
            <input type="hidden" id="orderTruckId" name="orderTruckId.truckId" value="${truck.truckId}"/>
            <button type="button"  class="btn btn-warning" data-toggle="modal" data-target="#cartModal" >주문하기</button>
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
                    <button class="button is-warning is-light" name="getMenu"
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
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"></span>
                </button>
            </div>
            <div class="modal-body-hey" style="min-height: 500px; margin-left: 19px;">
                <p>This is some placeholder content to show the scrolling behavior for modals. Instead of repeating the text the modal, we use an inline style set a minimum height, thereby extending the length of the overall modal and demonstrating the overflow scrolling. When content becomes longer than the height of the viewport, scrolling will move the modal as needed.</p>
            </div>
            <div class="modal-happy">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-default" id="addCart" name="addCart">장바구니로!</button>
            </div>
        </div>
    </div>
</div>




<form>

    <%--cart Modal--%>
    <div class="modal fade" id="cartModal" tabindex="-1" aria-labelledby="cartModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="cartModalLabel">New message
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="orderPickUpTime" class="col-form-label">픽업희망시간:</label>
                        <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
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
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
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