<%@ page contentType="text/html; charset=euc-kr" %>
    
    
    
<!DOCTYPE html>


<html lang="ko">

<head>
	<meta charset="EUC-KR">
	
	<title>회원가입</title>

	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >

	<!-- DatePicker -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
 	<!-- <link rel="stylesheet" href="/resources/demos/style.css">  -->
  	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
  
	<!-- <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>  -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>  -->
	<!-- <script type="text/javascript" src="../javascript/calendar.js"></script>  -->
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
        
        div h3, div h5 {text-align: center;}
        
        label {
        	color : #6593A6;
        }
        
     </style>
    

<script type="text/javascript">
	
	
	function fncAddProduct(){
		
		var name = $("input[name='prodName']").val();
		var detail = $("input[name='prodDetail']").val();ㄴ
		var manuDate = $("input[name='manuDate']").val();
		var price = $("input[name='price']").val();
		
		if( name == null || name.length<1){
			alert("상품명은 반드시 입력하여 합니다.");
			return;
		}
		
		if( detail == null || detail.length<1){
			alert("상품 상세정보는 반드시 입력하여 합니다.");
			return;
		}
		
		if( manuDate == null || manuDate.length<1){
			alert("제조일자는 반드시 입력하여 합니다.");
			return;
		}
		
		if( price == null || price.length<1){
			alert("가격은 반드시 입력하여 합니다.");
			return;
		}
		
		$("form").attr("method","POST").attr("action","/product/addProduct").attr("enctype","multipart/form-data").submit();
		
	}
	
	$(function(){
		$("button.btn.btn-primary").click(function(){
			//alert( $("td.ct_btn01:contains('등록')").html() );
			fncAddProduct();
		});
	});
	
	
	$(function() {
		 $( "a[href='#']" ).click( function() {
				$("form")[0].reset();
		});
	});	

/* 	$( function() {
	    $( "#manuDate" ).datepicker({
	      showOn: "button",
	      buttonImage: "/images/calendar.gif",
	      buttonImageOnly: true,
	      buttonText: "Select date", 
	      dateFormat : 'yy-mm-dd', 
	      
	      showButtonPanel: true,
	      closeText : "닫기",
          prevText : "이전달",
          nextText : "다음달",
          currentText : "오늘",
          changeMonth: true, // 월을 바꿀 수 있는 셀렉트 박스
          changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스
          monthNames : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
          monthNamesShort : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
          dayNames : [ "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일" ],
          dayNamesShort : [ "일", "월", "화", "수", "목", "금", "토" ],
          dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
          weekHeader : "주",
	    });
	    
	  } ); */


</script>
</head>

<body>


 	<div class="container">
	
		<div class="page-header" >
	       <h3 class="text-info">상 품 등 록</h3>
	       <h5 class="text-muted">상품 정보를 <strong class="text-danger">정확하게 입력</strong>해 주세요.</h5>
	    </div>
		
		<form class="form-horizontal">

			<div class="form-group">
			    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="prodName" name="prodName" placeholder="상품명">
			    </div>
			  </div>
			
			<hr/>
			
			<div class="form-group">
			    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="prodDetail" name="prodDetail" placeholder="상품상세정보">
			    </div>
			  </div>
			
			<hr/>
			
			<div class="form-group">
			    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="manuDate" name="manuDate" placeholder="제조일자">
			    </div>
			  </div>
			
			<hr/>
			
			<div class="form-group">
			    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="price" name="price" placeholder="가격">
			    </div>
			  </div>
			
			<hr/>
			
			<div class="form-group">
			    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
			    <div class="col-sm-4">
			      <input type="file" class="form-control" id="fileName1" name="fileName1" placeholder="상품이미지">
			    </div>
			  </div>
			
			<hr/>


 		<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >가&nbsp;입</button>
			  <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
		    </div>
		</div>
		  
	</form>
	</div>
</body>
</html>