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
				<li class="active">Category&Product</li>
			</ol>
		</div>
		<!--/.row-->
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">Category&Product</h1>
			</div>
		</div>
		<div class="row" style="margin-bottom:10px;">
			<div class="col-xs-12 text-right">
				<div class="btn-group btn-group-sm">
					<a href="/admin/product" 
						   class="btn btn-default <c:if test="${empty param.category}">active</c:if>">all</a>
					<c:forEach var="category" items="${categoryList }">
						<a href="?category=${category }" 
						   class="btn btn-default <c:if test="${param.category eq category}">active</c:if>">${category }</a>
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="row">
			<c:forEach var="product" items="${productList }">
					<div class="col-md-3 col-sm-6 col-xs-6 items">
						<div class="panel panel-default">
							<div class="panel-body">
								<div class="item">
									<div class="item-header text-center">
										<a href="/product/view?model=${product.model }">
											<img src="/image/${product.image }" alt="" style="width:100%;height:300px;"/>
										</a>
									</div>
									<div class="item-content">
										<p>
											${product.model }
										</p>
										<p>
											분류 : ${product.category }
										</p>
										<p>
											<fmt:parseDate pattern="yyyy-MM-dd HH:mm:ss" var="formattedDate" value="${product.regdate }"/>
											출시일 :  <fmt:formatDate value="${formattedDate }" pattern="yy. MM. dd"/>
										</p>
										<p>원가 : <fmt:formatNumber value="${product.price }" type="number" />원</p>
										<p>할인율 : ${product.discount *100 }%</p>
										<p>할인가 : <fmt:formatNumber value="${product.price * (1-product.discount) }" type="number" />원</p>
										<p>
											재고량 : ${product.count }
										</p>
									</div>
									<div class="item-footer row">
										<div>
											<button class="btn btn-block btn-warning text-center" onclick="update('${product.model}');">수정</button>
										</div>
										<div>
												<a class="btn btn-block btn-danger text-center" onclick="deletethis('${product.model}');">삭제</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
				<div class="row">
					<div class="col-xs-12 text-center">
						<ul class="pagination">
							${pageHTML }
						</ul>					
					</div>
				</div>
		</div>
	</div>
	<script src="/js/jquery-1.11.1.min.js"></script>
	<script src="/js/bootstrap.min.js"></script>
	<script src="/js/bootstrap-datepicker.js"></script>
	<script src="/js/custom_dash.js"></script>
	<script>
	function update(model){
		location.href="/admin/product/update?name="+model
	}
	function deletethis(model){
		check = confirm("정말 이 상품을 삭제하시겠습니까?");
		if(check){
			$.ajax({
    			url:"/admin/product/delete",
    			data:{"model":model},
    			type:"post",
    			success:function(data){
    				console.log(data);
    				alert("삭제완료");
    				location.href="/admin/product";
    			}
    		});
		}
	}
	</script>
		
</body>
</html>