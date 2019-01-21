<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/css/style.css" />
<style>
	.ordTitle{
		border-bottom: 3px solid black;
	}
	.table-first{
		width:33.3%;
	}
	.table-second{
		width:66.6%;
	}
	th{
		background-color:#eee;
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
			<div class="customer">
				<h3>구매자 정보</h3>
				<table class="table">
					<tr>
						<th class="table-first">이름</th>
						<td class="table-second">${user.name }</td>
					</tr>
					<tr>
						<th>휴대폰 번호</th>
						<td>
							<c:set var="phone" value="${user.phone }" />
							<c:out value="${fn:substring(phone,0,3) }-${fn:substring(phone,3,7) }-${fn:substring(phone,7,11) }"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</body>
</html>