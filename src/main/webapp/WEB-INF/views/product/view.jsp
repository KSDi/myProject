<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/css/style.css" />
<style>
	
	.pad{
		padding: 15px 0;
		border-radius: 0;
	}
	.btn-dark{
		background-color: black;
		color:white;
	}
	.btn-dark:hover{
		background-color: #2f3640;
		color:white;	
	}
	.modelname{
		font-weight:600;
		font-size:30px;
	}
	#option{
		width:100%;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" />
	<div class="content">
		<div class="container-fluid">
			<div class="row" >
				<div class="col-sm-2">
					<jsp:include page="../left_menu.jsp" />
				</div>
				<div class="col-sm-8 text-center">
					<div class="row" >
						<div class="col-sm-6">
							<img style="width:100%;"src="/image/${product.category }/${product.image}" alt="" />
						</div>
						<div class="col-sm-6 text-left">
							<p class="modelname">${product.model }</p>
							<hr />
							<p>판매가격</p>
							<c:if test="${product.discount ne 0 }">
								<span class="aa-product-price">
									<fmt:formatNumber value="${product.price * (1-product.discount) }" type="number" /> 
									<span class="won">원</span>
								</span>				
								<span>
										<del>
											<fmt:formatNumber value="${product.price }" type="number" /> 
											<span class="won">원</span>
										</del>
								</span>
							</c:if>
							<c:if test="${product.discount eq 0 }">
								<span class="aa-product-price">
									<fmt:formatNumber value="${product.price }" type="number" /> 
									<span class="won">원</span>
								</span>	
							</c:if>
							<hr />
							<p>옵션선택</p>
							<select name="option" id="option">
								<option value="">- 필수 : 옵션을 선택해주세요 -</option>
								<optgroup label="Size">
									<option value="XL">XL</option>
									<option value="L">L</option>
									<option value="M">M</option>
								</optgroup>
							</select>
							<hr />
							<button class="btn btn-block btn-dark pad" >지금구매</button>
							<button class="btn btn-block btn-default pad" onclick="basket('${product.model}')" id="basketbtn">장바구니에 담기</button>
						</div>
					</div>
					<div class="row" style="margin-top:30px;">
						<img style="width:100%;"src="/image/upload/gd.jpg" alt="" />
					</div>
				</div>
				<div class="col-sm-2"></div>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp" />
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script>
		function basket(m){
			$('#basketbtn').blur();
			var opt = $('#option').val();
			if(opt == ""){
				alert('필수 옵션을 선택해 주세요');
				return;
			}
			location.href="/cart/insert?model="+ m + "&opt="+opt;
		}
	</script>
</body>
</html>