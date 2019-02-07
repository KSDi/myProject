<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet">
<link href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" rel="stylesheet">
<style>
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
	.pswdcheck{
		height:600px;
	}
	.form-control{
		display : inline-block;
		width:63%;
		height:45px;
	}
	.label-control{
		text-align:right;
		width:25%;
		margin-right:20px;
		
	}
	.checkBtn{
		width:100px;
		height:100px;
		float:left;
		border-radius: 10px;
    	background-color: #6cb5e0;
    	line-height: 100px;
    	text-align: center;
    	color:white;
    	font-size:25px;
	}
	.wrapper{
		padding-top : 7%;
		padding-left : 10%;
	}
	.pd{
		margin-top : 10px;
	}
	.mod_title{
	    padding-top: 10px;
	    padding-bottom: 5px;
	    border-left: 5px solid #101010;
	    margin-top: 30px;

	}
	.form-control[readonly]{
		cursor: default;
	}
	#error{
		font-size:13px;
		text-align:center;
		color:red;
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
									<a href="/user/mypage" class="tab-link">
										<span class="tab-name">1:1 문의</span>
									</a>
								</li>
							</ul>
						</div>
						<div class="col-xs-12 mod_title">
							<h1>비밀번호 확인 </h1>
							<span style="color:#aaa; padding-left:15px;">회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한 번 확인합니다.</span>
						</div>
						<div class="pswdcheck col-xs-12">
							<div class="wrapper col-xs-12 ">
								<div class="col-xs-9">
									<div>
										<label for="" class="label-control" >아이디</label>
										<input type="text" readonly class="form-control" value="${user.id }"/>
									</div>
									<div class="pd">
										<label for="" class="label-control" >비밀번호</label>
										<input type="password" id="password" class="form-control"/>
									</div>
								</div>
								<div class="col-xs-2">
									<a href="javascript:check();" class="checkBtn">확인</a>
								</div>
							</div>
							<p id="error"></p>
						</div>
				</div>
				<div class="col-sm-2"></div>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script>
		function check(){
			$.ajax({
				url:"/user/checkpassword",
				type:"post",
				data:{password : $("#password").val()},
				beforeSend : function(xhr)
                {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                success : function(data){
                	if(data=="success"){
                		location.href="/user/modify";
                	}else{
                		$("#password").css({borderColor:"red"});
                		$("#error").text("비밀번호가 일치하지 않습니다. 다시 입력해주세요");
                	}
                }
			});
		}
	</script>
</body>
</html>