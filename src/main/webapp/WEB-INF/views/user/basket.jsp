<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="/css/style.css">
<style>
	.btn-group-vertical > button{
		padding-top : 5px;
		padding-bottom : 5px;
	}
	table p{
		margin-top:20px
	}
	#total{
		width:150px;
	}
	span{
		padding: 5px 20px 5px 0;
	}
	.padbtn{
		padding-top:15px;
		padding-bottom:15px;
		font-weight:900;
		font-size:25px;
	}
</style>
</head>
<body>
	<div>
		<jsp:include page="../header.jsp" />
	</div>
	<div class="content">
		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-2 col-xs-12">
					<jsp:include page="../left_menu.jsp" />
				</div>
				<div class="col-sm-8">
					<div class="info">
						<h4><span class="glyphicon glyphicon-shopping-cart"></span>구매할 상품</h4>
						<div>
							<table class="table table-stipped text-center">
								<thead>
									<tr>
										<th></th>
										<th class="text-center">모델명</th>
										<th class="text-center">옵션</th>
										<th class="text-center">수량</th>
										<th class="text-center">가격</th>
										<th class="text-center">합계</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="cart" items="${cartList }">
										<tr>
											<td><img src="/image/${cart.product.category }/${cart.product.image }"
												alt="" style="width: 50px;" /></td>
											<td><p>${cart.product.model }</p></td>
											<td><p>${cart.opt }</p></td>
											<td>
												<div class="td">
													<input readonly type="text" value="${cart.count }"
													class="form-control" style="width: 40px; display: inline; background-color:white;"
													id="input_${cart.id }"/>
													<div class="btn-group-vertical">
														<button type="button" class="btn btn-default"
															onclick="updateCount(${cart.id},'plus')"><i class="glyphicon glyphicon-chevron-up"></i></button>
														<button type="button" class="btn btn-default"
															onclick="updateCount(${cart.id},'minus')"><i class="glyphicon glyphicon-chevron-down"></i></button>
													</div>
												</div>
											</td>
											<td>
												<p><fmt:formatNumber type="number"
													value="${cart.product.price * (1-cart.product.discount) }" />원
												</p>
											</td>
											<td>
												<p id="total_${cart.id }">
													<fmt:formatNumber type="number" 
														value="${cart.product.price*(1-cart.product.discount)*cart.count}" />원
												</p>
											</td>
											<td>
												<p><a href="/cart/delete?id=${cart.id }"><i class="glyphicon glyphicon-remove"></i></a></p>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot style="background-color:#eee">
									<tr>
										<td colspan="6">
										<div style="float:right;">
											<span style="font-weight:600;font-size:15px;">상품가격</span> 
											<span id="total1"><fmt:formatNumber type="number" value="${total }" />원</span>
											<span><i class="glyphicon glyphicon-plus-sign"></i></span>
											<span>배송비</span>
											<span style="font-weight:600;font-size:15px;">무료</span>
											<span>=</span>
											<span id ="total2" style="font-weight:600;font-size:20px;">
													<fmt:formatNumber type="number" value="${total }" />원
											</span>
										</div>
										</td>
										<td>
										</td>
									</tr>
								</tfoot>
							</table>
						</div>
						<div class="row" style="margin-top : 40px;">
							<div class="col-sm-4 col-sm-offset-1">
								<button class="btn btn-block btn-default padbtn" onclick="location.href='/'">계속 쇼핑하기</button>
							</div>
							<div class="col-sm-4 col-sm-offset-2">
								<button class="btn btn-block btn-primary padbtn" onclick="location.href='/user/purchase'">구매하기</button>
							</div>
						</div>
					</div>
				</div>
				</div>
				<div class="col-sm-2"></div>
			</div>
	</div>
	<jsp:include page="../footer.jsp" />
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script>
		function updateCount(id,stat){
			var count = $('#input_'+id).val();
			if(stat == 'plus'){
				count++;
				cartAjax(id,count);
			}else{
				count--;
				if(count == 0 ){
					alert('물품의 수량은 0이 될수 없습니다');
					return;
				}
				cartAjax(id,count);
			}
			
		}
		
		function cartAjax(id,count){
			$.ajax({
				url:"/cart/update",
				type:"GET",
				data:{id:id , count:count},
				success:function(data){
					$('#total_'+id).html(format(data.price)+"원");
					$('#total1').html(format(data.total)+"원");
					$('#total2').html(format(data.total)+"원");
					$('#input_'+id).val(count);
				}
			});
		}
		
		function format(x) {
		    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}

	</script>
</body>
</html>