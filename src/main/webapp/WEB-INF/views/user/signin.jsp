<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/css/style.css" />
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
	.naver{
		width:100%;
		height:100%;
	}
	.btn-block{
		height: 60px;
	}
	.nabtn{
		padding:0px;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" />
	<div class="content">
		<div class="container">
			<div class="row">
				<div class="col-sm-2"></div>
				<div class="col-sm-8 text-center">
					<div class="member-main">
						<div class="member-signup">
							<form class="form-horizontal" action="/user/signin" method="POST">
								<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
								<div class="form-group">
									<div class="col-xs-1 col-xs-offset-2">
										<span><i class="far fa-envelope"></i></span>
									</div>
									<div class="col-xs-7">
										<input class="form-control" name="id" placeholder="아이디"/>
									</div>
								</div>
								<div class="form-group">
									<div class="col-xs-1 col-xs-offset-2">
										<span><i class="fas fa-lock"></i></span>
									</div>
									<div class="col-xs-7">
										<input class="form-control" type="password" name="password" placeholder="비밀번호"/>
									</div>
								</div>
								<c:if test="${param.fail != null }">
									<div class="form-group text-center">
										<span class="error">아이디 또는 비밀번호가 일치하지 않습니다</span>
									</div>
								</c:if>
								<div class="col-xs-8 col-xs-offset-2">
									<button type="submit" class="btn btn-block btn-primary">
										<span>로그인</span>
									</button>
								</div>
								<div class="col-xs-8 col-xs-offset-2">
									<button type="button" class="btn btn-block nabtn">
										<img class="naver" src="/image/naver_login.jpg" alt="" style =""/>
									</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="col-sm-2"></div>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
</body>
</html>