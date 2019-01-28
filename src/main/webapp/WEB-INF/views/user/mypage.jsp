<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet">
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
				<div class="col-sm-8">
						<div class="tab-line row">
							<ul class="tab-list text-center">
								<li class="tab <c:if test="${empty param.tab || param.tab eq 'order'}">tab-selected</c:if>">
									<a href="/user/mypage?tab=order" class="tab-link">
										<span class="tab-name">주문목록/배송조회</span>
									</a>
								</li>
								<li class="tab <c:if test="${param.tab eq 'usermod'}">tab-selected</c:if>">
									<a href="/user/mypage?tab=usermod" class="tab-link">
										<span class="tab-name">개인정보수정</span>
									</a>
								</li>
								<li class="tab <c:if test="${param.tab eq 'qna'}">tab-selected</c:if>">
									<a href="/user/mypage?tab=qna" class="tab-link">
										<span class="tab-name">1:1 문의</span>
									</a>
								</li>
							</ul>
						</div>
						<c:if test="${empty param.tab || param.tab eq 'order' }">
							<div class="row">
								<p>waiting ${status.waiting }</p>
								<p>delivery ${status.delivery }</p>
								<p>complete ${status.complete }</p>
								<c:forEach var="order" items="${orderList }">
									<p> ${order.u_id}</p>
									<p> ${order.buyer_id}</p>
									<p> ${order.addr}</p>
									<p> ${order.regdate}</p>
									<p> ${order.cost}</p>
								</c:forEach>
							</div>
						</c:if>
				</div>
				<div class="col-sm-2"></div>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</body>
</html>