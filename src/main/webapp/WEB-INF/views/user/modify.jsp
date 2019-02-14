<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet">
<link href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" rel="stylesheet">
<style>
	.wrapper{
		margin-top:30px;
	}
	.tab-line{
		border-bottom:2px solid #3d82f7;
		background-color: #f9f9f9;
		
	}
	.tab{
		width:33.3333%;
		float:left;
		padding:12px 0;
	}
	.tab-selected{
		background-color: white;
	    border: 2px solid #3d82f7;
	    border-bottom-width: 0px;
	    margin-bottom: -2px;
	}
	.tab-name{
		font-weight:bold;
		font-size:21px;
	}
	.txt_bar{
		float: left;
	    overflow: hidden;
	    width: 1px;
	    height: 10px;
	    margin-top: 10px;
	    background-color: #ccc;
	    text-indent: -9999px;
	    vertical-align: top;
	}
	.box_layer{
		float: left;
	    position: relative;
	    border: 0;
	    z-index: 300;
	    vertical-align: top;
	}
	.link_option{
		display: block;
	    padding: 8px;
	    vertical-align: top;
	    border-bottom: 1px solid transparent;
	    font-size : 20px;
	    font-weight:600;
	}
	
	.mod_title{
	    padding-top: 10px;
	    padding-bottom: 5px;
	    border-left: 5px solid #101010;
	    margin-top: 30px;
	}
	.table>tbody>tr>th{
		width:25%;
	}
	.table>tbody>tr>th,.table>tbody>tr>td{
	    vertical-align: inherit;
	    padding-left: 26px;
	    padding-top: 15px;
	    padding-bottom: 15px;
	}
	th{
		background-color:#efefef;
		text-align:left;
		font-size:14px;
	}
	.table-top{
		border-top:4px solid #ddd; 
	}
	.table-bottom{
		border-bottom:1px solid #ddd; 
	}
	.wrapper{
		width:95%;
		padding-left:5%;
	}
	.form-control[readonly]{
		cursor: default;
	}
	
	[id $= error],#errors{
		font-size:12px;
		margin-bottom: -15px;
	}
	#ast{
		padding-left:2px;
		color:red;
	}
	#modifyBtn{
		margin-top: 20px;
	    height: 60px;
	    width: 160px;
	    border: none;
	    background-color: #6cb5e0;
	    border-radius: 6px;
	    color: white;
	    font-size: 20px;
	}
	.mg_b{
		margin-bottom:30px;
	}
</style>
</head>
<body>
	<div>
		<jsp:include page="../header.jsp"/>
	</div>
	<div class="content">
		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-2 col-xs-12">
					<jsp:include page="../left_menu.jsp"/>
				</div>
				<div class="col-sm-8 col-xs-12">
					<div class="tab-line row">
							<ul class="tab-list text-center">
								<li class="tab">
									<a href="/user/mypage" class="tab-link">
										<span class="tab-name">주문목록/배송조회</span>
									</a>
								</li>
								<li class="tab tab-selected">
									<a href="/user/modify" class="tab-link">
										<span class="tab-name">개인정보수정</span>
									</a>
								</li>
								<li class="tab">
									<a href="/user/qna" class="tab-link">
										<span class="tab-name">1:1 문의</span>
									</a>
								</li>
							</ul>
						</div>
						<div class="col-xs-12 mod_title">
							<h1>개인정보 수정 </h1>
						</div>
						<div class="row mg_b">
							<div class="wrapper col-xs-12">
								<form action="/user/modify" method="post">
								<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
									<table class="table">
										<tr class="table-top">
											<th>이름</th>
											<td>${user.name }	</td>
										</tr>
										<tr>
											<th>휴대폰 번호</th>
											<td>
												<c:set var="phone" value="${user.phone }" />
												<c:out value="${fn:substring(phone,0,3) }-${fn:substring(phone,3,7) }-${fn:substring(phone,7,11) }"/>
											</td>
										</tr>
										<tr>
											<th>이메일</th>
											<td>
												<div class="row">
													<div class="col-xs-6" id="">
														<input type="email" class="form-control" id="email"
																	 value="${user.email }" <c:if test="${!empty user.email  }">readonly</c:if> placeholder="Email"/>
													</div>
													<c:if test="${!empty user.email }">
													<div class="col-xs-5">
														<button type="button" onclick="changeEmail();" id="cgEmailBtn" class="btn btn-default">이메일 변경</button>
													</div>
													</c:if>
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
													<div class="col-xs-4">
														<input type="text" class="form-control" id="emailCode" placeholder="인증번호" />
													</div>
													<div class="col-xs-2">
														<button type="button" class="btn btn-default" onclick="checkEmailCode();">인증</button>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<th>현재 비밀번호<span id="ast">*</span></th>
											<td>
												<div class="row">
													<div class="col-xs-6">
														<input type="password" id="currntPw" name="currntPw" class="form-control" onblur="checkRealPw();"/>
													</div>
													<div class="col-xs-12">
														<span id="currntPw_error"></span>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<th>신규 비밀번호</th>
											<td>
												<div class="row">
													<div class="col-xs-6">
														<input type="password" id="password" name="password" class="form-control" onkeyup="dualcheck();"/>
													</div>
												</div>
											</td>
										</tr>
										<tr class="table-bottom">
											<th>신규 비밀번호 확인</th>
											<td>
												<div class="row">
													<div class="col-xs-6">
														<input type="password" id="CheckPassword" name="CheckPassword"w class="form-control" onkeyup="dualcheck();"/>
													</div>
													<div class="col-xs-12">
														<span id="errors"></span>
													</div>
												</div>
											</td>
										</tr>
									</table>
									<div class="btn_area text-center">
										<button type="button" onclick="formCheck(this.form);" id="modifyBtn">수 정</button>
									</div>
								</form>
							</div>
						</div>
				</div>
				<div class="col-sm-2"></div>
			</div>
		</div>
		<jsp:include page="../footer.jsp" />
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script>
		const email = $("#email").val();
		var c1 = false;
		var c2 = false;
		var c3 = false;
		
		function formCheck(f){
			if(!c1){
				$("#currntPw").focus();
				return;
			}else if(!c2){
				$("#password").focus();
				return;
			}else if(!c3){
				$("#CheckPassword").focus();
				return;
			}
			f.submit();
		}
		
		function checkRealPw(){
			$.ajax({
				url:"/user/checkRealPw",
	    		type:"post",
	    		data:{pw : $("#currntPw").val()},
	    		beforeSend : function(xhr)
	                {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
	                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	                },
	    		success : function(data){
	    			console.log(data);
	    			if(data == "unmatch"){
	    				$("#currntPw_error").text("현재 비밀번호와 일치하지 않습니다.").css({color:"red"});
	    				c1 = false;
	    			}else if(data == "match"){
	    				$("#currntPw_error").text("현재 비밀번호와 일치합니다").css({color:"green"});
	    				c1 = true;
	    			}
	    		}
			});
			
		}
		
		var p = $("#password");
		var cp = $("#CheckPassword");
		var regexp = /^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,15}$/;
		function dualcheck(){
			$("span").remove("[id^=password]");
			if(p.val() != cp.val()){
				if(p.val().length <8){
					cp.css({borderColor:"red"});
					$("#errors").text("8글자이상 입력해주세요").css({color:"red"});
				}else{
					cp.css({borderColor:"red"});
					$("#errors").text("비밀번호가 일치하지 않습니다.").css({color:"red"});
				}
			}else if(p.val() == cp.val() && cp.val != ""){
				if(p.val().length <8){
					cp.css({borderColor:"red"});
					$("#errors").text("8글자이상 입력해주세요").css({color:"red"});
				}else if(!regexp.test(p.val())){
					if(p.val().length>15){
						cp.css({borderColor:"red"});
						$("#errors").text("15글자 이하로 입력해주세요").css({color:"red"});
					}else{
						cp.css({borderColor:"red"});
						$("#errors").text("특수문자(@$!%*?&)를 한개이상 입력하세요").css({color:"red"});
					}
				}else{
					cp.css({borderColor:"green"});
					p.css({borderColor:"green"});
					$("#errors").text("비밀번호가 일치합니다").css({color:"green"});	
					c2 = true;
					c3 = true;
				}
			}
		}
		
		function changeEmail(){
			$("#email").removeAttr("readonly");
			$("#cgEmailBtn").parent().css({display:"none"});
			$("#email").parent().parent().append(`
					<div class="col-xs-2">
						<button id="email_check"class="btn btn-default" type="button" onclick="checkEmail();">이메일 인증</button>
					</div>
					<div class="col-xs-5">
						<div id="loader"></div>
						<span id="email-error"></span>
					</div>
				`);
			
		}
	
		function checkEmail(){
			if(email == $("#email").val()){
				$("#email-error").text("바꾸실 이메일을 입력하세요").css({color:"red"});
				$("#loader").removeClass("loader");
				return;
			}
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
	    				$("#email-error").text("변경이 완료되었습니다").css({color:"green"});
	    				$("#emailCertify").css({display:"none"});
	    				$("#email").addAttr("readonly");
	    			}
	    		}
	    		
	    	});
	    }
	</script>
</body>
</html>