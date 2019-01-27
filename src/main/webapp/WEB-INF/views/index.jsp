<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css?family=Luckiest+Guy" rel="stylesheet">
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	rel="stylesheet">
<link rel="stylesheet" href="/css/style.css" />
<link href="/css/sequence-theme.modern-slide-in.css" rel="stylesheet"
	media="all">
	<style>
		.hot{
			font-family: 'Luckiest Guy', cursive;
			font-size : 50px;
			color:#ff3838;
		}
	</style>
</head>
<body>
	<div class="header">
		<jsp:include page="header.jsp" />
	</div>
	<div class="content">
		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-2 col-xs-12">
					<jsp:include page="left_menu.jsp" />
				</div>
				<div class="col-sm-8 col-xs-12">
					<!-- Start slider -->
					<section id="aa-slider">
						<div class="aa-slider-area">
							<div id="sequence" class="seq">
								<div class="seq-screen">
									<ul class="seq-canvas">
										<!-- single slide item -->
										<li>
											<div class="seq-model">
												<img data-seq src="https://placeimg.com/970/353/people"
													alt="Men slide img" />
											</div> <!-- <div class="seq-title">
					               <span data-seq>Save Up to 75% Off</span>                
					                <h2 data-seq>Men Collection</h2>                
					                <p data-seq>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Minus, illum.</p>
					                <a data-seq href="#" class="aa-shop-now-btn aa-secondary-btn">SHOP NOW</a>
					              </div> -->
										</li>
										<!-- single slide item -->
										<li>
											<div class="seq-model">
												<img data-seq src="https://placeimg.com/971/250/people"
													alt="Wristwatch slide img" />
											</div>
											
										</li>
										<!-- single slide item -->
										<li>
											<div class="seq-model">
												<img data-seq src="https://placeimg.com/970/251/people"
													alt="Women Jeans slide img" />
											</div>
											
										</li>
										<!-- single slide item -->
										<li>
											<div class="seq-model">
												<img data-seq src="https://placeimg.com/970/252/people"
													alt="Shoes slide img" />
											</div>
											
										</li>
										<!-- single slide item -->
										<li>
											<div class="seq-model">
												<img data-seq src="https://placeimg.com/972/250/people"
													alt="Male Female slide img" />
											</div>
											
										</li>
									</ul>
								</div>
								<!-- slider navigation btn -->
								<fieldset class="seq-nav" aria-controls="sequence"
									aria-label="Slider buttons">
									<a type="button" class="seq-prev" aria-label="Previous"><span
										class="fa fa-angle-left"></span></a> <a type="button"
										class="seq-next" aria-label="Next"><span
										class="fa fa-angle-right"></span></a>
								</fieldset>
							</div>
						</div>
					</section>
					<section id="aa-product">
						<div class="col-md-12">
							<p  class="hot text-center">!&nbsp;!&nbsp;&nbsp;W&nbsp;E&nbsp;E&nbsp;K&nbsp;L&nbsp;Y&nbsp;&nbsp;H&nbsp;O&nbsp;T&nbsp;&nbsp;I&nbsp;T&nbsp;E&nbsp;M&nbsp;&nbsp;!&nbsp;!</p>
						</div>
						<div class="col-md-12">
							<div class="row">
								<div class="aa-product-area">
									<div class="aa-product-inner">
										<!-- start prduct navigation -->
										<ul class="nav nav-tabs aa-products-tab">
											<li class="active btn btn-default"><a href="#top" data-toggle="tab">Top</a></li>
											<li class="btn btn-default"><a href="#outer" data-toggle="tab">Outer</a></li>
											<li class="btn btn-default"><a href="#pants" data-toggle="tab">Pants</a></li>
											<li class="btn btn-default"><a href="#acc" data-toggle="tab">Acc</a></li>
										</ul>
										<!-- Tab panes -->
										<div class="tab-content">
											<!-- Start men product category -->
											<div class="tab-pane fade in active" id="top">
												<ul class="aa-product-catg">
													<c:forEach var="product" items="${productList }">
														<!-- start single product item -->
														<c:if test="${product.category eq 'top' }">
															<li>
																<figure>
																	<a class="aa-product-img" href="/product/view?model=${product.model }"><img
																		src="/image/top/${product.image }"
																		alt="polo shirt img"></a>
																	<a class="aa-add-card-btn" href="#"><span
																		class="fas fa-shopping-cart"></span>Add To Cart</a>
																	<figcaption>
																		<h4 class="aa-product-title">
																			<a href="#">${product.model }</a>
																		</h4>
																		<span class="aa-product-price"> <fmt:formatNumber
																				value="${product.price * (1-product.discount) }"
																				type="number" /> <span class="won">원</span>
																		</span>
																		<c:if test="${product.discount ne 0 }">
																			<span class="aa-product-price"><del>
																					<fmt:formatNumber value="${product.price }"
																						type="number" />
																					원
																				</del></span>
																		</c:if>
																	</figcaption>
																</figure>
																<div class="aa-product-hvr-content">
																	<a href="#" data-toggle="tooltip" data-placement="top"
																		title="Add to Wishlist"><span class="far fa-heart"></span></a>
																	<a href="/product/view?model=${product.model }" 
																		data-toggle2="tooltip" data-placement="top"
																		title="View"><span class="fas fa-search"></span></a>
																</div> <!-- product badge --> <c:if
																	test="${product.discount ne 0 }">
																	<span class="aa-badge aa-sale" href="#">SALE!</span>
																</c:if>
															</li>
														</c:if>
													</c:forEach>
												</ul>
											</div>
											<!-- start women product category -->
											<div class="tab-pane fade" id="outer">
												<ul class="aa-product-catg">
													<!-- start single product item -->
													<c:forEach var="product" items="${productList }">
														<c:if test="${product.category eq 'outer' }">
															<li>
																<figure>
																	<a class="aa-product-img" href="/product/view?model=${product.model }"><img
																		src="/image/outer/${product.image }"
																		alt="polo shirt img"></a>
																	<a class="aa-add-card-btn" href="#"><span
																		class="fas fa-shopping-cart"></span>Add To Cart</a>
																	<figcaption>
																		<h4 class="aa-product-title">
																			<a href="#">${product.model }</a>
																		</h4>

																		<span class="aa-product-price"> <fmt:formatNumber
																				value="${product.price * (1-product.discount) }"
																				type="number" /> <span class="won">원</span>
																		</span>
																		<c:if test="${product.discount ne 0 }">
																			<span class="aa-product-price"> <del>
																					<fmt:formatNumber value="${product.price }"
																						type="number" />
																					원
																				</del>
																			</span>
																		</c:if>
																	</figcaption>
																</figure>
																<div class="aa-product-hvr-content">
																	<a href="#" data-toggle="tooltip" data-placement="top"
																		title="Add to Wishlist"><span class="far fa-heart"></span></a>
																	<a href="/product/view?model=${product.model }" 
																	     data-toggle2="tooltip" data-placement="top"
																		title="View"><span
																		class="fa fa-search"></span></a>
																</div> <c:if test="${product.discount ne 0 }">
																	<!-- product badge -->
																	<span class="aa-badge aa-sale" href="#">SALE!</span>
																</c:if>
															</li>
														</c:if>
													</c:forEach>
												</ul>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</section>
				</div>
				<div class="col-xs-2">
					<jsp:include page="right_menu.jsp" />
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<!-- To Slider JS -->
	<script src="/js/sequence.js"></script>
	<script src="/js/sequence-theme.modern-slide-in.js"></script>
</body>
</html>