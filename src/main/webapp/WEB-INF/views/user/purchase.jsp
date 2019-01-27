<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*, java.text.*"  %>
<%
	Date sourceDate = new Date();
	
	SimpleDateFormat sdf = new SimpleDateFormat("MM/dd");
	
	Calendar calendar = Calendar.getInstance();
	calendar.setTime(sourceDate); // parsed date and setting to calendar
	
	calendar.add(Calendar.DATE, 3);  // number of days to add
	String destDate = sdf.format(calendar.getTime());  // End date
	int dayofweek = calendar.get(Calendar.DAY_OF_WEEK);
	String day = "";
    switch(dayofweek){
        case 1:
            day = "일";
            break ;
        case 2:
            day = "월";
            break ;
        case 3:
            day = "화";
            break ;
        case 4:
            day = "수";
            break ;
        case 5:
            day = "목";
            break ;
        case 6:
            day = "금";
            break ;
        case 7:
            day = "토";
            break ;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/css/style.css" />
<style>
	body,table,input,button{
		font-family: 돋움, Dotum, sans-serif;
   		font-size: 100%;
	}
	div,td,th,input,.btn{
		font-size:13px !important;
	}
	.ordTitle{
		border-bottom: 3px solid black;
		margin-bottom:10px;
	}
	.table-first{
		width:15%;
	}
	.table-second{
		width:66.6%;
	}
	.table>tbody>tr>th,.table>tbody>tr>td{
		vertical-align: inherit;
		padding-right:20px;
		padding-left:0;
	}
	th{
		background-color:#eee;
		text-align:right;
	}
	.table-top{
		border-top:4px solid #ddd; 
	}
	.table-bottom{
		border-bottom:1px solid #ddd; 
	}
	.pos-m{
		margin-bottom:5px;
		padding-left:0;
	}
	.pad-l{
		padding : 5px 0 5px 15px;
		margin-bottom:0;
	}
	h3{
		margin-top:30px;
	}
	@media (min-width: 1200px){
		.container {
	    	width: 1070px;
		}
	}
	.product-ex{
		padding-left:15px;
		font-size:18px;
		text-align:left;
	}
	.row{
		padding-left:15px;
	}
	#email-error{
		height: 34px;
    	line-height: 34px;
	}
	.pur_sec{
		width:90%;
		margin : 0 auto;
		
	}
</style>
</head>
<body>
	<div>
		<jsp:include page="../header.jsp"/>
	</div>
	<div class="container">
		<div class="row">
			<div class="ordTitle">
				<h1 style="font-weight:700;">결제하기</h1>
			</div>
			<div class="customer pur_sec">
				<h3>구매자 정보</h3>
				<div class="col-sm-10 col-sm-offset-1"></div>
				<table class="table">
					<tr class="table-top">
						<th class="table-first">이름</th>
						<td class="table-second">
							<p class="pad-l">
							
							
								${user.name }						
							</p>
						</td>
					</tr>
					<tr>
						<th>휴대폰 번호</th>
						<td >
							<p class="pad-l">
								<c:set var="phone" value="${user.phone }" />
								<c:out value="${fn:substring(phone,0,3) }-${fn:substring(phone,3,7) }-${fn:substring(phone,7,11) }"/>
							</p>
						</td>
					</tr>
					<tr class="table-bottom">
						<th>이메일</th>
						<td>
							<div class="row">
								<div class="col-xs-5">
									<input type="email" class="form-control" id="email"
												 value="${user.email }" <c:if test="${!empty user.email  }">readonly</c:if> placeholder="Email"/>
								</div>
								<c:if test="${empty user.email  }">
									<div class="col-xs-2">
										<button id="email_check"class="btn btn-default" type="button" onclick="checkEmail();">이메일 인증</button>
									</div>
									<div class="col-xs-5">
										<div id="loader"></div>
										<span id="email-error"></span>
									</div>
								</c:if>
							</div>
							<div class="row"  id="emailCertify" style="margin-top : 8px; display: none;">
								<div class="col-xs-2">
									<input type="text" class="form-control" id="emailCode" placeholder="인증번호" />
								</div>
								<div class="col-xs-2">
									<button type="button" class="btn btn-default" onclick="checkEmailCode();">인증</button>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div class="customer_get pur_sec">
				<h3>받는사람 정보</h3>
				<table class="table">
					<tr class="table-top">
						<th class="table-first">이름</th>
						<td class="table-second">
							<div class="col-sm-4">
								<input type="text" class="form-control" value="${user.name }"/>
							</div>
						</td>
					</tr>
					<tr class="table-bottom">
						<th>배송지 주소</th>
						<td>
							<div class="pos-m col-xs-12">
								<div class="col-xs-4">
									<input type="text" id="postcode" class="form-control" placeholder="우편번호">
								</div>
								<input type="button" class="btn btn-default" onclick="execDaumPostcode();" value="우편번호 찾기">
							</div>
							<div class="pos-m col-xs-12">
								<div class="col-xs-6">
									<input type="text" id="roadAddress" class="form-control" placeholder="도로명주소">
								</div>
								<div class="col-xs-6">
									<input type="text" id="jibunAddress" class="form-control" placeholder="지번주소">
								</div>
								<div class="col-xs-12">
									<span id="guide" style="color:#999;display:none"></span>
								</div>
							</div>
							<div class="pos-m col-xs-12">
								<div class="col-xs-6">
									<input type="text" id="detailAddress" class="form-control" placeholder="상세주소">
								</div>
								<div class="col-xs-6">
									<input type="text" id="extraAddress" class="form-control" placeholder="참고항목">
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div class="product pur_sec">
				<h3>배송될 물건 ( ${fn:length(cartList) }개 )</h3>
				<div class="panel panel-default">
					<div class="panel-heading" style="font-size:20px; color: #4cd137; ">
						<strong style="font-size:25px;"><%=destDate %>(<%=day %>)</strong><span> 도착예정</span>
					</div>
					<div class="panel-body">
						<table class="table">
							<c:forEach var="cart" items="${cartList }">
								<tr>
									<td><p class="product-ex">${cart.product.model }</p></td>
									<td><p class="product-ex">${cart.opt }</p></td>
									<td><p class="product-ex">${cart.count }개</p></td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
			</div>
			<div class="pay-price pur_sec">
				<h3>결제 정보</h3>
				<div class="col-sm-10 col-sm-offset-1"></div>
				<table class="table">
					<tr class="table-top">
						<th class="table-first">총상품가격</th>
						<td class="table-second">
							<p class="pad-l">
								<strong><fmt:formatNumber type="number" value="${total }" />원</strong>
							</p>
						</td>
					</tr>
					<tr >
						<th class="table-first">배송비</th>
						<td class="table-second">
							<p class="pad-l">
								<strong>0원</strong>
							</p>
						</td>
					</tr>
					<tr>
						<th>총 결제금액</th>
						<td >
							<p class="pad-l" style="color:#ae0000;">
								<strong><fmt:formatNumber type="number" value="${total }" />원</strong>
								
							</p>
						</td>
					</tr>
					<tr class="table-bottom">
						<th>결제 방식</th>
						<td >
							<p class="pad-l">
								<input type="radio" checked="checked"/> <span>카카오페이</span>
							</p>
						</td>
					</tr>
				</table>
			</div>
			<div>
				<div class="col-xs-12">
					<form action="" name="pgForm">
						<input type="hidden" id="name" value="${user.name }" />
						<input type="hidden" id="cost" value="${total }" />
						<input type="hidden" id="phone" value="${user.phone }"/>
						<button class="btn btn-block" type="button" onclick="purchase();">결제하기</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp" />
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	<script>
	    function execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                var roadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 참고 항목 변수
	
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }
	
	                document.getElementById('postcode').value = data.zonecode;
	                document.getElementById("roadAddress").value = roadAddr;
	                document.getElementById("jibunAddress").value = data.jibunAddress;
	                
	                if(roadAddr !== ''){
	                    document.getElementById("extraAddress").value = extraRoadAddr;
	                } else {
	                    document.getElementById("extraAddress").value = '';
	                }
	
	                var guideTextBox = document.getElementById("guide");
	                if(data.autoRoadAddress) {
	                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	                    guideTextBox.style.display = 'block';
	
	                } else if(data.autoJibunAddress) {
	                    var expJibunAddr = data.autoJibunAddress;
	                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	                    guideTextBox.style.display = 'block';
	                } else {
	                    guideTextBox.innerHTML = '';
	                    guideTextBox.style.display = 'none';
	                }
	            }
	        }).open();
	    }
	    
	    var IMP = window.IMP; // 생략가능
	    IMP.init('imp08051410');  // 가맹점 식별 코드
	    
	    
	    function purchase(){
	    	if($("#detailAddress").val() ==""){
	    		alert("상세주소를 입력해주세요");
	    		return;
	    	}else if($("#roadAddress").val()==""){
	    		alert("주소를 입력해주세요");
	    		return;
	    	}
	    	
	    	var cost = parseInt($("#cost").val());
	    	var name = "${user.id}";
	    	var phone = $("#phone").val();
	    	var addr = $("#roadAddress").val()+" "+$("#extraAddress").val()+" "+$("#detailAddress").val();
	    	var email = $("#email").val();
	    	   IMP.request_pay({
	    	      pg : 'kakaopay', // 결제방식
	    	       pay_method : 'card',	// 결제 수단
	    	       merchant_uid : 'merchant_' + new Date().getTime(),
	    	       name : '주문명: '+ name,	// order 테이블에 들어갈 주문명 혹은 주문 번호
	    	       amount : cost,	// 결제 금액
	    	      buyer_name :  name,	// 구매자 이름
	    	       buyer_tel :  '010-4288-9979',	// 구매자 전화번호
	    	    	buyer_addr : addr,
	    	    	buyer_email : email
	    	   }, function(rsp) {
	    		    if ( rsp.success ) {
	    		    		/* 	$.ajax({
	    		    				url:"/order/insert",
	    		    				type:"post",
	    		    				data : {
	    		    					u_id : rsp.merchant_uid,
	    		    					cost : rsp.paid_amount,
	    		    					buyer_tel : rsp.buyer_tel,
	    		    					buyer_addr : rsp.buyer_addr
	    		    				},
	    		    				success: function(data){
	    		    					
	    		    				}
	    		    			}); */
	    		    		} else {
	    		    			//[3] 아직 제대로 결제가 되지 않았습니다.
	    		    			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
	    		    			 var msg = '결제에 실패하였습니다.';
	    		    		        msg += '에러내용 : ' + rsp.error_msg;
	    		    		        alert(msg);
	    		    		}
	    	});
	    	
	    }
	    
	    function checkEmail(){
	    	$("#loader").addClass("loader");
	    	$.ajax({
	    		url:"/user/checkEmail",
	    		type:"post",
	    		data:{email : $('#email').val()},
	    		beforeSend : function(xhr)
	                {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
	                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	                },
	    		success : function(data){
	    			if(data == "unvalidEmail"){
	    				$("#email-error").text("올바른 이메일 형식을 입력해 주세요.").css({color:"red"});
	    				$("#loader").removeClass("loader");
	    			}
	    			if(data == "duplicatedEmail"){
	    				$("#email-error").text("이미 가입된 이메일입니다.").css({color:"red"});
	    				$("#loader").removeClass("loader");
	    			}
	    			if(data =="success"){
	    				$("#loader").removeClass("loader");
	    				$("#email_check").attr("disabled","disabled");
	    				$("#email-error").text("");
	    				$("#emailCertify").css({display:"block"});
	    			}
	    		}
	    	});
	    }
	    
	    function checkEmailCode(){
	    	$.ajax({
	    		url:"/user/checkEmailCode",
	    		method:"post",
	    		data:{email : $('#email').val(),
	    				  emailCode : $("#emailCode").val()},
  				beforeSend : function(xhr){   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
	    		success:function(data){
	    			if(data == "success"){
	    				$("#email-error").text("인증이 완료되었습니다").css({color:"green"});
	    				$("#emailCertify").css({display:"none"});	    				
	    			}
	    		}
	    		
	    	});
	    }
	</script>
</body>
</html>