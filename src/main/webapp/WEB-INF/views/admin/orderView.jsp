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
.table {
	margin-left: 20px;
	
}

.table>tbody>tr>th {
	background-color: #f1f2f6 !important;
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
				<li class="active">Order</li>
				<li class="active">View</li>
			</ol>
		</div>
		<!--/.row-->
		
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">주문 내역</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<div class="panel panel-default">
					<div class="panel-heading" style="text-transform: capitalize;">${order.u_id }</div>
					<div class="panel-body">
					<div class="row">
						<div class="col-md-11 col-xs-11">
							
							<h4 style="<c:if test="${order.status eq '배송준비' }">color:#1e90ff;</c:if>
											  <c:if test="${order.status eq '배송중' }">color:#ffb53e;</c:if>
											  <c:if test="${order.status eq '배송완료' }">color:#ff4757;</c:if>
							">${order.status } 상품입니다</h4>
						</div>
					</div>
						<div class="row">
							<div class="col-md-11 col-xs-11">
								<div class="head">
									<h2>결제자 정보</h2>
								</div>
								<div class="body">
									<table class="table table-bordered">
										<tr>
											<th>이름</th>
											<td>${orderUser.name }</td>
										</tr>
										<tr>
											<th>전화번호</th>
											<td>${orderUser.phone }</td>
										</tr>
										<tr>
											<th>이메일</th>
											<td>${orderUser.email }</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-11 col-xs-11">
								<div class="head">
									<h2>주문 상품</h2>
								</div>
								<div class="body">
									<table class="table table-bordered">
										<tr>
											<th>상품 이름</th>
											<th>상품 사이즈</th>
											<th>개수</th>
										</tr>
										<c:forEach var="product" items="${order.products }">
											<tr>
												<td><p class="">${product.product_id }</p></td>
												<td><p class="">${product.product_opt }</p></td>
												<td><p class="">${product.count }개</p></td>
											</tr>
										</c:forEach>
									</table>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-11 col-xs-11">
								<div class="head">
									<h2>배송 정보</h2>
								</div>
								<div class="body">
									<table class="table table-bordered">
										<tr>
											<th>받으시는분 이름</th>
											<td>${order.delivery_name }</td>
										</tr>
										<tr>
											<th>배송지</th>
											<td>${order.addr }</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
						<div class="row text-center">
							<c:if test="${order.status eq '배송준비' }">
								<p>배송 후 배송버튼을 눌러주세요 !!</p>
								<a class="btn btn-primary"
									style="height: 60px; width: 150px;line-height: 48px;" href="/admin/order/status?u_id=${order.u_id }&change=배송중">배송</a>
							</c:if>
							<c:if test="${order.status eq '배송중' }">
								<p>배송 완료 후 완료버튼을 눌러주세요 !!</p>
								<a class="btn btn-warning"
									style="height: 60px; width: 150px;line-height: 48px;" href="/admin/order/status?u_id=${order.u_id }&change=배송완료">완료</a>
							</c:if>
							<c:if test="${order.status eq '배송완료' }">
								<h1 style="color:#ff4757;">배송이 완료된 주문입니다</h1>
							</c:if>
						</div>
					</div>
				</div>
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