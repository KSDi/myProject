<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<link rel="stylesheet" href="/css/style.css" />
<link href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	rel="stylesheet">

<script>
	function signout(){
		var form = document.createElement("form");
		form.method="post";
		form.action="/user/signout"
		var input = document.createElement("input");
		input.type="hidden"
		input.name="${_csrf.parameterName}";
		input.value="${_csrf.token}";
		form.appendChild(input);
		document.body.appendChild(form);
		form.submit();
	}
</script>

<!-- SCROLL TOP BUTTON -->
    <a class="scrollToTop" href="#"><i class="fas fa-chevron-up"></i></a>
  <!-- END SCROLL TOP BUTTON -->
	
  <!-- Start header section -->
  <header id="aa-header">
    <!-- start header top  -->
    <div class="aa-header-top">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <div class="aa-header-top-area">
              <!-- start header top left -->
              <div class="aa-header-top-left">
                <!-- start cellphone -->
                <div class="cellphone hidden-xs">
                  <p><span class="fa fa-phone"></span>010-4288-9979</p>
                </div>
                <!-- / cellphone -->
              </div>
              <!-- / header top left -->
              <div class="aa-header-top-right">
                <ul class="aa-head-top-nav-right">
	               	<sec:authorize access="isAuthenticated()">
	                  <li><a href="javascript:signout();">로그아웃</a></li>
	               	</sec:authorize>
	               	<sec:authorize access="!isAuthenticated()">
	                  <li><a href="/user/signin">로그인</a></li>
	                  <li><a href="/user/signup">회원가입</a></li>
	               	</sec:authorize>
                  <sec:authorize access="isAuthenticated() && !hasRole('ROLE_ADMIN')">
                  <li class="hidden-xs"><a href="/user/basket">장바구니</a></li>
                  	<li class="hidden-xs"><a href="/user/mypage">마이페이지</a></li>
                  </sec:authorize>
                  <sec:authorize access="hasRole('ROLE_ADMIN')">
                  <li class="hidden-xs"><a href="/admin/manage">홈페이지관리</a></li>
                  </sec:authorize>
                  <li class="hidden-xs"><a href="https://search.naver.com/search.naver?sm=top_hty&fbm=1&ie=utf8&query=%EB%B0%B0%EC%86%A1%EC%A1%B0%ED%9A%8C">배송조회</a></li>
                </ul>
              </div>
            </div>
          </div>
        </div>
        </div>
      </div>
      <div>
    		<h1 class="text-center"><button type="button" class="logo" onclick="location.href='/'"><img id="logo_img" src="/image/logo.png" alt="" /></button></h1>
  	  </div>
    </header>
    
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="/js/custom.js"></script>