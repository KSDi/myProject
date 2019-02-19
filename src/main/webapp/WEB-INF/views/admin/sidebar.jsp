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
			<li ><a href="/admin/dashboard"><em class="fas fa-tachometer-alt">&nbsp;</em>
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
					<li><a class="" href="/admin/order?status=wait"> <span class="fa fa-arrow-right">&nbsp;</span>
							배송준비
					</a></li>
					<li><a class="" href="/admin/order?status=delivery"> <span class="fa fa-arrow-right">&nbsp;</span>
							배송중
					</a></li>
					<li><a class="" href="/admin/order?status=complete"> <span class="fa fa-arrow-right">&nbsp;</span>
							배송완료
					</a></li>
				</ul></li>
			<li><a href="/admin/qna"><em class="fas fa-question-circle">&nbsp;</em>
					QNA</a>
			</li>
			<li><a href="login.html"><em class="fa fa-power-off">&nbsp;</em>
					Logout</a>
			</li>
		</ul>
	</div>
	<!--/.sidebar-->