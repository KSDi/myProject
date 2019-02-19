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
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css"
	rel="stylesheet">
<style>
	.form-control{
		height:46px;
	}
	.col-form-label{
		height:46px;
		line-height:46px;
	}
	.form-btn{
		height:46px;
		line-height:35px;
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
				<li class="active">Product</li>
				<li class="active">Modify</li>
			</ol>
		</div>
		<!--/.row-->
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">Modify</h1>
			</div>
		</div>
		<div class="row">
				<div class="col-md-5 col-sm-12 col-xs-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							선택된 아이템
						</div>
						<div class="panel-body text-center">
							<div class="item-header">
								<img src="/image/${product.image }" style="width:100%" alt="" />
							</div>
							<div class="item-content">
								<p>${product.model}</p>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-7 col-sm-12 col-xs-12">
					<form action="/admin/product/update?${_csrf.parameterName }=${_csrf.token }" method="post" enctype="multipart/form-data">
						<div class="panel panel-default">
							<div class="panel-heading">
								세부사항
							</div>
							<div class="panel-body">
								<div class="form-group row">
								<label for="" class="col-sm-2 col-form-label text-center" >모델명</label>
								<div class="col-sm-10">
									<input type="hidden" class="form-control"  name="old_model" value="${product.model }" />
									<input type="text" class="form-control"  name="model" value="${product.model }" />
								</div>
								</div>
								<div class="form-group row">
									<label for="" class="col-sm-2 col-form-label text-center">카테고리</label>
									<div class="col-sm-10">
										<select name="category" class="form-control col-sm-4">
										<c:forEach var="category" items="${categoryList }">
											<c:if test="${category eq product.category }">
												<option value="${category }" selected="selected">${category }</option>
											</c:if>
											<c:if test="${category ne product.category }">
												<option value="${category }">${category }</option>
											</c:if>
										</c:forEach>
										</select>
									</div>
								</div>
								<div class="form-group row">
									<label for="" class="col-sm-2 col-form-label text-center">이미지변경</label>
									<div class="col-sm-10">
										<label class="btn btn-default form-btn" for="image">
											<input type="file" name="image" id="image" 
												   style="display: none"
							  					   onchange="$('#file-info').text(this.files[0].name)"/>파일선택
										</label>
										<span class="label label-default" 
											  id="file-info"></span>
									</div>
								</div>
								<div class="form-group row">
									<label for="" class="col-xs-2 col-form-label text-center">내용</label>
									<div class="col-xs-10">
										<textarea class="form-control" id="content" name="content" /></textarea>
									</div>
								</div>
								<div class="form-group row">
									<label for="price" class="col-sm-2 col-form-label text-center">가격</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" name="price" value="${product.price }"/>
									</div>
								</div>
								<div class="form-group row">
									<label for="discount" class="col-sm-2 col-form-label text-center">할인율</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" name="discount" value="${product.discount }"/>
									</div>
								</div>
								<div class="form-group row">
									<label for="count" class="col-sm-2 col-form-label text-center">재고</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" name="count" value="${product.count }"/>
									</div>
								</div>
								<div class="text-right">
									<button class="btn btn-primary" type="submit">수정</button>
								</div>
							</div>
						</div>
					</form>
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
		
</body>
</html>