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
<link rel="stylesheet" href="/css/style.css" />
<style>
	.product-img{
		width:86%;
		height:320px;
	}
</style>
</head>
<body>
<jsp:include page="../header.jsp" />
	<div class="content">
		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-2 col-xs-12">
					<jsp:include page="../left_menu.jsp" />
				</div>
				<div class="col-sm-8 col-xs-12 text-center">
					<div class="row" style="margin-bottom:10px;">
						<div class="col-sm-5 col-sm-offset-7 text-right">
							<div class="btn-group btn-group-sm">
								<a href="?order=price&base=asc<c:if test="${param.category != null }">&category=${param.category }</c:if>" 
								   class="btn btn-default <c:if test="${param.order eq 'price' && param.base eq 'asc' }">active</c:if>">낮은가격순</a>
								<a href="?order=price&base=desc<c:if test="${param.category != null }">&category=${param.category }</c:if>" 
								   class="btn btn-default <c:if test="${param.order eq 'price' && param.base eq 'desc' }">active</c:if>">높은가격순</a>
								<a href="?order=popular&base=desc<c:if test="${param.category != null }">&category=${param.category }</c:if>" 
								   class="btn btn-default <c:if test="${param.order eq 'popular' && param.base eq 'desc' }">active</c:if>">인기많은순</a>
								<a href="?order=popular&base=asc<c:if test="${param.category != null }">&category=${param.category }</c:if>" 
								   class="btn btn-default <c:if test="${param.order eq 'popular' && param.base eq 'asc' }">active</c:if>">인기적은순</a>   
								</div>
							</div>
						</div>
					<div class="row">
						<c:forEach var="product" items="${productList }">
						<div class="col-xs-6 col-sm-6 col-md-4">
							<div class="product">
								<div class="product-header">
									<a href="/product/view?model=${product.model }">
										<img class="product-img" src="/image/${product.category }/${product.image}" alt="" />
									</a>
								</div>
								<div class="product-content text-center">
									<p class="aa-product-title">${product.model }</p>
									<span class="aa-product-price"> 
										<fmt:formatNumber value="${product.price * (1-product.discount) }" type="number" /> 
										<span class="won">원</span>
									</span>
									<c:if test="${product.discount ne 0 }">
										<span class="">
											<del>
												<fmt:formatNumber value="${product.price }" type="number" /> 원
											</del>
										</span>
									</c:if>
								</div>
							</div>
						</div>
						</c:forEach>
					</div>
						
				</div>
				<div class="col-sm-2"></div>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp" />
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</body>
</html>