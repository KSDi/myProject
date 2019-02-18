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
	<div id="sidebar-collapse" class="col-sm-3 col-lg-2 sidebar">
		<div class="profile-sidebar">
			<div class="profile-userpic">
				<img src="http://placehold.it/50/30a5ff/fff" class="img-responsive"
					alt="">
			</div>
			<div class="profile-usertitle">
				<div class="profile-usertitle-name">${user.id }</div>
				<div class="profile-usertitle-status">
					<span class="indicator label-success"></span>Online
				</div>
			</div>
			<div class="clear"></div>
		</div>
		<div class="divider"></div>
		<form role="search">
			<div class="form-group">
				<input type="text" class="form-control" placeholder="Search">
			</div>
		</form>
		<ul class="nav menu">
			<li><a href="/admin/dashboard"><em
					class="fas fa-tachometer-alt">&nbsp;</em> Dashboard</a></li>
			<li class="parent">
				<a data-toggle="collapse" href="#sub-item-1">
					<em class="fas fa-chart-pie">&nbsp;</em> Category&Product
					<span
					data-toggle="collapse" href="#sub-item-1" class="icon pull-right"><em
						class="fa fa-plus"></em></span>
				</a>
				<ul class="children collapse" id="sub-item-1">
					<li><a class="" href="/admin/category"> <span class="fa fa-arrow-right">&nbsp;</span>
							추가/삭제
					</a></li>
					<li><a class="" href="/admin/product"> <span class="fa fa-arrow-right">&nbsp;</span>
							Product 관리
					</a></li>
				</ul>
			</li>
			<li class="parent "><a data-toggle="collapse" href="#sub-item-2">
					<em class="fa fa-navicon">&nbsp;</em> Orders <span
					data-toggle="collapse" href="#sub-item-2" class="icon pull-right"><em
						class="fa fa-plus"></em></span>
			</a>
				<ul class="children collapse" id="sub-item-2">
					<li><a class="" href="#"> <span class="fa fa-arrow-right">&nbsp;</span>
							배송대기
					</a></li>
					<li><a class="" href="#"> <span class="fa fa-arrow-right">&nbsp;</span>
							배송중
					</a></li>
					<li><a class="" href="#"> <span class="fa fa-arrow-right">&nbsp;</span>
							배송완료
					</a></li>
				</ul></li>
			<li><a href="login.html"><em class="fa fa-power-off">&nbsp;</em>
					Logout</a></li>
		</ul>
	</div>
	<!--/.sidebar-->

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
										<img src="/image/${product.image }" alt="" style="width:100%;height:300px;"/>
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