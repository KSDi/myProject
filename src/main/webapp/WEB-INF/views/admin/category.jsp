<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css"
	rel="stylesheet">
<style>
.modal-backdrop {
	z-index: 1000 !important;
}
.btn-group-sm>.btn, .btn-sm{
		font-size:14px;
	}
	.note-toolbar-wrapper > .panel-heading{
		height:87px;
	}
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
		<div class="row">
			<div class="col-xs-4">
				<div class="panel panel-default">
					<div class="panel-heading">
						카테고리 추가/삭제 <span
							class="pull-right clickable panel-toggle panel-button-tab-left"><em
							class="fa fa-toggle-up"></em></span>
					</div>
					<div class="panel-body">
						<ul class="list-group">
							<c:forEach var="category" items="${categoryList}">
								<li class="list-group-item">
									<div class="input-group">
										<input type="text" value="${category }" class="form-control"
											id="input_${category }" /> <span class="input-group-btn">
											<button type="button" class="btn btn-warning"
												onclick="updateCategory('${category}')">수정</button>
											<button type="button" class="btn btn-danger"
												onclick="deleteCategory('${category}');">삭제</button>
										</span>
									</div>
								</li>
							</c:forEach>
						</ul>
						<form action="/admin/category/insert" method="post">
							<input type="hidden" name="${_csrf.parameterName }"
								value="${_csrf.token }" />
							<div class="input-group">
								<input type="text" class="form-control" name="category" /> <span
									class="input-group-btn">
									<button class="btn btn-default" type="submit">추가</button>
								</span>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="col-xs-8">
				<div class="panel panel-default">
					<div class="panel-heading">
						상품추가 <span
							class="pull-right clickable panel-toggle panel-button-tab-left"><em
							class="fa fa-toggle-up"></em></span>
					</div>
					<div class="panel-body">
						<form action="/admin/product/insert?${_csrf.parameterName }=${_csrf.token }" method="post"
							class="form-horizontal" enctype="multipart/form-data">
							<div class="form-group">
								<label for="model" class="col-xs-2 control-label">모델명</label>
								<div class="col-xs-10">
									<div class="input-group">
										<input type="text" class="form-control" name="model"
											onchange="isDuplicated = true" /> <span
											class="input-group-btn">
											<button type="button" onclick="dualcheck(this.form);"
												class="btn btn-default">중복확인</button>
										</span>
									</div>

								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-xs-2 control-label">카테고리</label>
								<div class="col-xs-10">
									<select name="category" class="form-control">
										<c:forEach var="category" items="${categoryList }">
											<option value="${category }">${category }</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-xs-2 control-label">이미지</label>
								<div class="col-xs-10">
									<label class="btn btn-default" for="image"> <input
										type="file" name="image_file" id="image" style="display: none"
										onchange="$('#file-info').text(this.files[0].name)" />파일선택
									</label> <span class="label label-default" id="file-info"></span>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-xs-2 control-label">내용</label>
								<div class="col-xs-10">
									<textarea class="form-control" id="content" name="content" /></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-xs-2 control-label">가격</label>
								<div class="col-xs-10">
									<input type="text" class="form-control" name="price" />
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-xs-2 control-label">할인율</label>
								<div class="col-xs-10">
									<input type="text" class="form-control" name="discount"
										placeholder="ex) 0.15" />
								</div>
							</div>
							<div class="form-group">
								<label for="" class="col-xs-2 control-label">수량</label>
								<div class="col-xs-10">
									<input type="text" class="form-control" name="count" />
								</div>
							</div>
							<div class="form-group">
								<div class="col-xs-10 col-xs-offset-2">
									<button type="button" class="btn btn-primary btn-block"
										onclick="checkForm(this.form);">추가</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="/js/jquery-1.11.1.min.js"></script>
	<script src="/js/bootstrap.min.js"></script>
	<script src="/js/bootstrap-datepicker.js"></script>
	<script src="/js/custom_dash.js"></script>
	<script
		src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>
	<script
		src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/lang/summernote-ko-KR.min.js"></script>
	<script>
		$("#content").summernote({
			height : 400,
			//focus: true,
			disableResizeEditor : true,
			lang : 'ko-KR',
			callbacks : {
				onImageUpload : sendFile,
				onMediaDelete : deleteFile
			}
		});
		function deleteFile(target) {
			var src = target[0].src.substring(21);
			console.log("src", src);
			$.ajax({
				url : "/filedelete",
				type : "post",
				data : {
					src : src
				},
				beforeSend : function(xhr) { /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
					xhr.setRequestHeader("${_csrf.headerName}",
							"${_csrf.token}");
				},
				success : function(data) {
					console.log(data);
				}
			});
		}

		function sendFile(files, editor, welEditable) {
			//console.log(files[0]);
			var data = new FormData();
			data.append('upload', files[0]);

			$.ajax({
				url : "/fileupload",
				contentType : false,
				processData : false,
				data : data,
				type : "post",
				beforeSend : function(xhr) { /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
					xhr.setRequestHeader("${_csrf.headerName}",
							"${_csrf.token}");
				},
				success : function(data) {
					//console.log(data);
					$("#content").summernote('editor.insertImage', data.url);
				},
				error : function(error) {
					console.error(error);
				}
			});
		}
	</script>
	<script>
		var isDuplicated = true;
		function dualcheck(f) {
			$.ajax({
				type : "post",
				url : "/admin/product/dualcheck",
				data : {
					model : f.model.value
				},
				beforeSend : function(xhr) { /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
					xhr.setRequestHeader("${_csrf.headerName}",
					"${_csrf.token}");
				},
				success : function(data) {
					if (data == 'duplicated') {
						alert("중복된 모델명입니다.");
					} else {
						alert("사용 가능한 모델명입니다.");
						isDuplicated = false;
					}
				},
				error : function(error) {
					console.error(error);
				}
			});
		}

		function checkForm(f) {
			if (isDuplicated) {
				alert("중복확인을 체크해주세요");
				return;
			}

			if (!/^[A-Za-z가-힣0-9\s]{2,30}$/.test(f.model.value)) {
				alert("모델명이 형식에 어긋납니다\n한글 및 소문자 및 숫자 및 특수문자(-)에 2~30글자 사이");
				f.model.focus();
				return;
			}

			if (!/^.{1,44}\..{1,6}$/.test(f.image.value.replace('C:\\fakepath\\',''))) {
				alert("파일이름형식이 올바르지 않습니다\n" + "ex) apple.jpg");
				return;
			}
			if (!/^.{1,500}$/.test(f.content.value)) {
				alert("1~500글자 이내의 문자를 입력해 주세요");
				f.content.focus();
				return;
			}
			if (!/^[1-9][0-9]{0,9}$/.test(f.price.value)) {
				alert("1이상의 양수를 입력해 주세요");
				f.price.focus();
				return;
			}
			if (!/^(0|0\.[0-9]?[1-9])$/.test(f.discount.value)) {
				alert("0 또는 0.01 ~ 0.99이내의 숫자를 입력해 주세요");
				f.discount.focus();
				return;
			}
			if (!/^[1-9][0-9]{0,4}$/.test(f.count.value)) {
				alert("1이상의 양수를 입력해 주세요");
				f.count.focus();
				return;
			}
			
			f.submit();
		}

		function deleteCategory(category) {
			location.href = "/admin/category/delete?category=" + category;
		}

		function updateCategory(category) {
			var newCategory = $("#input_" + category).val();
			location.href = "/admin/category/update?category=" + category
					+ "&new=" + newCategory;
		}
	</script>
</body>
</html>