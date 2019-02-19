<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"
	rel="stylesheet">
<link href="/css/bootstrap.min.css" rel="stylesheet">
<link href="/css/font-awesome.min.css" rel="stylesheet">
<link href="/css/styles_dash.css" rel="stylesheet">
<link href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Montserrat:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet">

<style>
	.tr{
		padding-top:20px;padding-bottom:20px;
	}
	.table>tbody>tr>td{
		padding :0;
		vertical-align: middle;
	}
	td>a{
		text-decoration:none;
		padding-left:15px;
		line-height: 50px;
	    width: 100%;
	    display: block;
	    color:black;
	}
	a:hover{
		text-decoration:none;
		color:inherit;
	}
</style>
</head>
<body>
	<jsp:include page="admin_header.jsp" />
	<jsp:include page="sidebar.jsp"/>

	<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">
		<div class="row">
			<ol class="breadcrumb">
				<li><a href="/admin/dashboard"> <em class="fa fa-home"></em>
				</a></li>
				<li class="active">QNA</li>
			</ol>
		</div>
		<!--/.row-->
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">QNA</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<table class="table table-stripped table-hover table-sm">
							<thead>
								<tr>
									<th style="width:5%"></th>
									<th style="width:65%;overflow: hidden;">제목</th>
									<th style="width:20%">작성자</th>
									<th style="width:10%">비고</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="qna" items="${qnaList }" varStatus="i">
								<tr>
									<td><a href="/admin/qna/view?id=${qna.id }">${i.index+1}</a></td>
									<td><a href="/admin/qna/view?id=${qna.id }">${qna.title }</a></td>
									<td><a href="/admin/qna/view?id=${qna.id }">${qna.users_id }</a></td>
									<td><a href="/admin/qna/view?id=${qna.id }"  style="<c:if test="${qna.status eq '답변대기' }">color:#ff6b81 !important;</c:if><c:if test="${qna.status eq '답변완료' }">color:black !important;</c:if>
									">${qna.status }</a></td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 text-center">
				<ul class="pagination">
					${pageHTML }
				</ul>					
			</div>
		</div>
	</div>
	<script src="/js/jquery-1.11.1.min.js"></script>
	<script src="/js/bootstrap.min.js"></script>
	<script src="/js/bootstrap-datepicker.js"></script>
	<script src="/js/custom_dash.js"></script>
	<script>
	
	</script>
		
</body>
</html>