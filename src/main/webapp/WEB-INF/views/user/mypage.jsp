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
	.userinfobox{
		margin-top: 15px;
    	padding-bottom: 15px;
		border-bottom: 1px solid #e7e7e7;
	}
	.box-item .fas{
	    font-size: 50px;
	    background-color: #556982;
	    border-radius: 100%;
	    padding: 12px;
	    margin-left : 25px;
	    color: white;
	}
	.greetings{
		border-top: 3px solid #556982;
	    border-bottom: 1px solid #e7e7e7;
	}
	.greeting{
        height: 30px;
	    padding-top: 10px;
	    padding-left: 10px;
	    color: #666;
	    text-align: center;
	}
	.info{
		margin-top : 30px;
	}
	
	.box-item,.box-item > div{
		margin: 0;
		display:inline-block;
	}
	.box-item p{
		margin : 0;
	}
	.stat-title{
		font-size: 20px;
	    font-weight: 600;
	    padding-left: 10px;
	}
	.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th{
		vertical-align: middle;
		text-align: center;
		padding : 20px 10px;
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
								<li class="tab tab-selected">
									<a href="/user/mypage" class="tab-link">
										<span class="tab-name">주문목록/배송조회</span>
									</a>
								</li>
								<li class="tab">
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
							<div class="row info">
								<div class="col-xs-12 greetings">
									<p class="greeting">
										<i class="fas fa-user"></i>&nbsp;<strong>${user.name }</strong>님 반갑습니다.
									</p>
								</div>
								<div class="userinfobox col-xs-12">
									<div class="box col-xs-12 text-center">
										<div class=" box-item ">
											<div class=" text-right">
												<i class="fas fa-box "></i>
											</div>
											<div class=" text-center">
												<p class="stat-title">배송 준비</p>
												<p>${status.waiting }</p>
											</div>
										</div>
										<div class=" box-item">
											<div class="text-right">
												<i class="fas fa-truck "></i>
											</div>
											<div class=" text-center">
												<p class="stat-title">배송 중</p>
												<p>${status.delivery }</p>
											</div>
										</div>
										<div class=" box-item">
											<div class=" text-right">
												<i class="fas fa-home "></i>
											</div>
											<div class="text-center">
												<p class="stat-title">배송 완료</p>
												<p>${status.complete }</p>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row" style="margin-top:40px;">
								<table class="table table-responsive">
									<thead>
										<tr>
											<th>구매일</th>
											<th>상품/옵션정보</th>
											<th>결제금액</th>
											<th>상태</th>
										</tr>
									</thead>
									<c:forEach var="order" items="${orderList }">
										<tr>
											<td>${order.regdate }</td>
											<td>
												<ul>
										<c:forEach var="orderProduct" items="${order.products }">
												<li>${orderProduct.product_id } | 옵션내용 : ${orderProduct.product_opt } | 가격 : <fmt:formatNumber value="${orderProduct.product.price * (1-orderProduct.product.discount) }" type="number" />원 / ${orderProduct.count }개</li>
										</c:forEach>
												</ul>
											</td>
											<td><fmt:formatNumber value="${order.cost }" type="number" />원</td>
											<td class="stat">${order.status }</td>
										</tr>
									</c:forEach>
								</table>
							</div>
				</div>
				<div class="col-sm-2"></div>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	
</body>
</html>