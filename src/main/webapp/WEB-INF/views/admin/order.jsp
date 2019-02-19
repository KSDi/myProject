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
<link href="/css/datatables.min.css" rel="stylesheet">
<style>
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
	    
	}
	ul{
		margin-bottom:0 !important;
	}
	a, a:hover{
	    text-decoration: none;
	    color: #333333;
	}
	
	table.dataTable thead .sorting:after,
table.dataTable thead .sorting:before,
table.dataTable thead .sorting_asc:after,
table.dataTable thead .sorting_asc:before,
table.dataTable thead .sorting_asc_disabled:after,
table.dataTable thead .sorting_asc_disabled:before,
table.dataTable thead .sorting_desc:after,
table.dataTable thead .sorting_desc:before,
table.dataTable thead .sorting_desc_disabled:after,
table.dataTable thead .sorting_desc_disabled:before {
  bottom: .5em;
}
.dataTables_scrollHead{
	height:37px;
}
#dtVerticalScrollExample th, td {
white-space: nowrap;
}
.odd,.even{
	border-bottom:1px solid #e6e7e8;
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
				<li class="active">${param.status }</li>
			</ol>
		</div>
		<!--/.row-->
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header" style="text-transform: capitalize;">${param.status }</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							주문 목록
						</div>
						<div class="panel-body">
								<table id ="dtVerticalScrollExample" class="table table-stripped table-hover table-sm" cellspacing="0" width="100%">
									<thead>
										<tr>
											<th></th>
											<th scope="col">구매일</th>
											<th scope="col">아이디</th>
											<th scope="col">상품/옵션정보</th>
											<th scope="col">결제금액</th>
											<th scope="col">상태</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="order" items="${orderList }">
												<tr >
													<td scope="row"></td>
													<td><a href="/admin/order/view?order=${order.u_id }">${order.regdate }</a></td>
													<td><a href="/admin/order/view?order=${order.u_id }">${order.buyer_id }</a></td>
													<td>
														<a href="/admin/order/view?order=${order.u_id }">
															<ul>
													<c:forEach var="orderProduct" items="${order.products }">
															<li>${orderProduct.product_id } | 옵션내용 : ${orderProduct.product_opt } | 가격 : <fmt:formatNumber value="${orderProduct.product.price * (1-orderProduct.product.discount) }" type="number" />원 / ${orderProduct.count }개</li>
													</c:forEach>
															</ul>
														</a>
													</td>
													<td><a href="/admin/order/view?order=${order.u_id }"><fmt:formatNumber value="${order.cost }" type="number" />원</a></td>
													<td class="stat"><a href="/admin/order/view?order=${order.u_id }">${order.status }</a></td>
												</tr>
											</c:forEach>
									</tbody>
								</table>
							</div>
				</div>
			</div>
		</div>
		
	</div>
	<script src="/js/jquery-1.11.1.min.js"></script>
	<script src="/js/bootstrap.min.js"></script>
	<script src="/js/bootstrap-datepicker.js"></script>
	<script src="/js/custom_dash.js"></script>
	<script type="text/javascript" src="/js/datatables.min.js"></script>
		<script>
	$(document).ready(function () {
		$('#dtVerticalScrollExample').DataTable({
			"scrollX": true
		});
		$('.dataTables_length').addClass('bs-select');
	});
</script>
</body>
</html>