<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet">

<style>
	.far,.fas{
		font-size: 32px;
		height:40px;
		line-height: 40px;
	}
	.form-control{
		height:40px;
	}
	.col-xs-8{
		margin-top : 10px;
		padding-right:3px;
		padding-left:2px;
	}
	.btn-block{
		height: 50px;
	}
	[id$="errors"]{
		font-size: 12px;
		color:red;
	}
	.input-group-addon{
		padding:0px;
		border: 0px;
		background-color:white;
	}
	#idCheckButton{
		height:40px;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div class="content">
		<div class="container">
			<div class="row">
				<div class="col-sm-2"></div>
				<div class="col-sm-8 text-center">
					<div class="member-main">
						<div class="member-signup">
							<form:form class="form-horizontal" action="/user/signup" method="POST" modelAttribute="user">
								<div class="form-group">
									<div class="col-xs-1 col-xs-offset-2">
										<span><i class="far fa-envelope"></i></span>
									</div>
									<div class="col-xs-7">
										<div class="input-group">
											<form:input class="form-control" path="id" placeholder="아이디"/>
											<div class="input-group-addon">
												<button type="button" class="btn btn-default" id="idCheckButton" onclick="idCheck();">중복확인</button>
											</div>
										</div>
										<form:errors path="id"/>
									</div>
								</div>
								<div class="form-group">
									<div class="col-xs-1 col-xs-offset-2">
										<span><i class="fas fa-lock"></i></span>
									</div>
									<div class="col-xs-7">
										<form:input class="form-control" type="password" path="password" placeholder="비밀번호" onkeyup="dualcheck();"/>
										<form:errors path="password"/>
									</div>
								</div>
								<div class="form-group">
									<div class="col-xs-1 col-xs-offset-2">
										<span><i class="fas fa-unlock"></i></span>
									</div>
									<div class="col-xs-7">
										<form:input class="form-control" path="CheckPassword" type="password" placeholder="비밀번호 확인" onkeyup="dualcheck();"/>
									</div>
									<div class="col-xs-7 col-xs-offset-3 "><span id="errors"></span></div>
								</div>
								<div class="form-group">
									<div class="col-xs-1 col-xs-offset-2">
										<span><i class="far fa-user"></i></span>
									</div>
									<div class="col-xs-7">
										<form:input class="form-control" path="name" placeholder="이름" />
										<form:errors path="name"/>
									</div>
								</div>
								<div class="form-group">
									<div class="col-xs-1 col-xs-offset-2">
										<span><i class="fas fa-mobile-alt"></i></span>
									</div>
									<div class="col-xs-7">
										<form:input class="form-control" path="phone" placeholder="휴대폰 번호(-를 제외한 숫자만 입력)"/>
										<form:errors path="phone"/>
									</div>
								</div>
								<div class="col-xs-8 col-xs-offset-2">
									<button type="submit" class="btn btn-block btn-primary">
										<span>가입하기</span>
									</button>
								</div>
							</form:form>
								
								
						</div>
					</div>
				</div>
				<div class="col-sm-2"></div>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script>
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
				}
			}
		}
	
		function idCheck(){
			
			$.ajax({
				url:"/user/dupCheck",
				type:"get",
				data:{id:$("#id").val()},
				success:function(data){
					if(data == 'exist'){
						alert("존재하는 아이디입니다");
					}else if(data == 'null'){
						alert("아이디를 입력하세요");
					}else if(data == 'short'){
						alert("아이디는 6글자부터 15글자 사이입니다");
					}else if(data == 'long'){
						alert("아이디는 6글자부터 15글자 사이입니다");
					}else{
						$("span").remove("[id^=id]");
						alert("사용 가능한 아이디입니다");
						$("#id").css({borderColor:"green"});
					}
				}
    		});
		}
	</script>
</body>
</html>