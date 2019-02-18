<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	Date sourceDate = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("M");
	String month = sdf.format(sourceDate);
%>
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
<link href="/css/datatables.min.css" rel="stylesheet">
<link href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Montserrat:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
	
<!-- Styles -->
<style>
#chartdiv {
	width: 100%;
	height: 470px;
}

.amcharts-export-menu-top-right {
	top: 10px;
	right: 0;
}

.dropdown-menu {
	top: 110%;
}

.canvas-wrapper {
	margin-bottom: -70px;
}

g[aria-labelledby="id-47-title"] {
	display: none;
}

.c_title {
	font-size: 2em;
}

.c_wrapper {
	padding: 10px;
}

.p_body {
	height: 430px;
}

.c_wrapper {
	height: ${100/categoryCostMap.size()}%
}

%;
}
.c_wrapper>span {
	height: 100%;
}
.table-wrapper-scroll-y {
		display: block;
		max-height: 200px;
		overflow-y: auto;
		-ms-overflow-style: -ms-autohiding-scrollbar;
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
</style>
</head>
<body>
	<jsp:include page="admin_header.jsp"/>
	<div id="sidebar-collapse" class="col-sm-3 col-lg-2 sidebar">
		<div class="profile-sidebar">
			<div class="profile-userpic">
				<img src="http://placehold.it/50/30a5ff/fff" class="img-responsive"
					alt="">
			</div>
			<div class="profile-usertitle">
				<div class="profile-usertitle-name">Admin</div>
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
			<li class="active"><a href="/admin/dashboard"><em class="fas fa-tachometer-alt">&nbsp;</em>
					Dashboard</a></li>
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
				<li><a href="/admin/manage"> <em class="fa fa-home"></em>
				</a></li>
				<li class="active">DashBoard</li>
			</ol>
		</div>
		<!--/.row-->
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">DashBoard</h1>
			</div>
		</div>
		<!--/.row-->
		<div class="panel panel-container">
			<div class="row">
				<div class="col-xs-6 col-md-3 col-lg-3 no-padding">
					<div class="panel panel-teal panel-widget border-right">
						<div class="row no-padding">
							<em class="fa fa-xl fa-shopping-cart color-blue"></em>
							<div class="large">${todayOrders }</div>
							<div class="text-muted">New Orders</div>
						</div>
					</div>
				</div>
				<div class="col-xs-6 col-md-3 col-lg-3 no-padding">
					<div class="panel panel-blue panel-widget border-right">
						<div class="row no-padding">
							<em class="fa fa-xl fa-truck color-orange"></em>
							<div class="large">${delivery }</div>
							<div class="text-muted">Delivering</div>
						</div>
					</div>
				</div>
				<div class="col-xs-6 col-md-3 col-lg-3 no-padding">
					<div class="panel panel-orange panel-widget border-right">
						<div class="row no-padding">
							<em class="fa fa-xl fa-users color-teal"></em>
							<div class="large">${newUsers }</div>
							<div class="text-muted">New Users</div>
						</div>
					</div>
				</div>
				<div class="col-xs-6 col-md-3 col-lg-3 no-padding">
					<div class="panel panel-red panel-widget ">
						<div class="row no-padding">
							<em class="fa fa-xl fa-money color-red"></em>
							<div class="large">
								<fmt:formatNumber value="${todayRevenue}" type="currency"
									currencySymbol="￦" />
							</div>
							<div class="text-muted">Todays Revenue</div>
						</div>
					</div>
				</div>
			</div>
			<!--/.row-->
		</div>
		<div class="row">
			<div class="col-md-7 col-xs-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						판매 현황 <span
							class="pull-right clickable panel-toggle panel-button-tab-left"><em
							class="fa fa-toggle-up"></em></span>
					</div>
					<div class="panel-body">
						<div class="canvas-wrapper">
							<div id="chartdiv"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-5 col-xs-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<%=month%>월 매출 현황 <span
							class="pull-right clickable panel-toggle panel-button-tab-left"><em
							class="fa fa-toggle-up"></em></span>
					</div>
					<div class="panel-body p_body">
						<div class="text-center col-xs-12"
							style="color: #2ed573; height: 20%">
							<span class="won"
								style="font-size: 1.5em; vertical-align: top;  line-height: 240%;">￦</span>
							<span style="font-size: 3.5em"> <fmt:formatNumber
									value="${monthRevenue }" type="number" />
							</span>
						</div>
						<div class="month_c text-center col-xs-12" style="height: 80%">
							<c:forEach var="category" items="${categoryList }">
								<div class="c_wrapper col-xs-12">
									<div class="c_title col-xs-12">
										<span class="col-xs-6">${fn:toUpperCase(category)}</span> 
										<span class="c_cost col-xs-6"> <fmt:formatNumber
												value="${categoryCostMap[category] }" type="number" />
										</span>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
			<div class="col-xs-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							최근 주문 목록
							<span class="pull-right clickable panel-toggle panel-button-tab-left"><em
								class="fa fa-toggle-up"></em></span>
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
													<td>${order.regdate }</td>
													<td>${order.buyer_id }</td>
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
									</tbody>
								</table>
							</div>
				</div>
			</div>
		</div>
	</div>

	<!-- <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> -->
	<!-- Resources -->
	<script src="https://www.amcharts.com/lib/4/core.js"></script>
	<script src="https://www.amcharts.com/lib/4/charts.js"></script>
	<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
	<script src="/js/jquery-1.11.1.min.js"></script>
	<script src="/js/bootstrap.min.js"></script>
	<script src="/js/chart.min.js"></script>
	<script src="/js/chart-data.js"></script>
	<script src="/js/easypiechart.js"></script>
	<script src="/js/easypiechart-data.js"></script>
	<script src="/js/bootstrap-datepicker.js"></script>
	<script src="/js/custom_dash.js"></script>
	<script type="text/javascript" src="/js/datatables.min.js"></script>
	<!-- Chart code -->
	<script>
var key = "PRODUCT_ID";


// Themes begin
am4core.useTheme(am4themes_animated);
// Themes end



// Create chart instance
var chart = am4core.create("chartdiv", am4charts.XYChart);
chart.scrollbarX = new am4core.Scrollbar();

// Add data
chart.data = [
	<c:forEach var="orderProduct" items="${orderProducts}">
		{
		  "model":"${orderProduct["PRODUCT_ID"]}",
		  "count": ${orderProduct["SALE"]}
		},
	</c:forEach>
];

// Create axes
var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "model";
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.minGridDistance = 30;
categoryAxis.renderer.labels.template.horizontalCenter = "middle";
categoryAxis.renderer.labels.template.verticalCenter = "middle";
categoryAxis.renderer.labels.template.rotation = 0;
categoryAxis.tooltip.disabled = true;
categoryAxis.renderer.minHeight = 110;

var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.minWidth = 1;

// Create series
var series = chart.series.push(new am4charts.ColumnSeries());
series.sequencedInterpolation = true;
series.dataFields.valueY = "count";
series.dataFields.categoryX = "model";
series.tooltipText = "[{modelX}: bold]{valueY}[/]";
series.columns.template.strokeWidth = 1;

series.tooltip.pointerOrientation = "vertical";

series.columns.template.column.cornerRadiusTopLeft = 10;
series.columns.template.column.cornerRadiusTopRight = 10;
series.columns.template.column.fillOpacity = 0.8;

// on hover, make corner radiuses bigger
let hoverState = series.columns.template.column.states.create("hover");
hoverState.properties.cornerRadiusTopLeft = 0;
hoverState.properties.cornerRadiusTopRight = 0;
hoverState.properties.fillOpacity = 1;

series.columns.template.adapter.add("fill", (fill, target)=>{
  return chart.colors.getIndex(target.dataItem.index);
})

// Cursor
chart.cursor = new am4charts.XYCursor();
</script>
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