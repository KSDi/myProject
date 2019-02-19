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
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet">
<style>
.btn-group-sm>.btn, .btn-sm{
		font-size:14px;
	}
	.title{
		margin-bottom:25px;
		border-bottom: 1px solid #bbb;
    	padding: 5px;
	}
	.content{
		background-color:#eee;
		border-radius: 10px;
		min-height:150px;
		padding:15px;
	}
</style>
</head>
<body>
	<jsp:include page="admin_header.jsp" />
	<jsp:include page="sidebar.jsp" />

	<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">
		<div class="row">
			<ol class="breadcrumb">
				<li><a href="/admin/dashboard"> <em class="fa fa-home"></em>
				</a></li>
				<li class="active">QNA</li>
				<li class="active">View</li>
			</ol>
		</div>
		<!--/.row-->
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">QNA 답변</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						문의사항
					</div>
					
					<div class="panel-body">
						<div class="text-right">
							<span class="glyphicon glyphicon-user"></span> ${qna.users_id }
							&nbsp;&nbsp; <span class="glyphicon glyphicon-time"></span>
							${qna.regdate } &nbsp;&nbsp;
						</div>
						<div class="title">
							<h3>${qna.title }</h3>
						</div>
						<div class="content col-xs-12">
							${qna.content }
						</div>
					</div>
				</div>
			</div>
		</div>
		<c:if test="${qna.status eq '답변완료' }">
			<c:forEach var="answer" items="${qna.answers }">
				<div class="row">
					<div class="col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">작성한 답변</div>
							<div class="panel-body">
								<div class="title">
								<h3>${answer.title }</h3>
							</div>
							<div class="content col-xs-12">
								${answer.content }
							</div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</c:if>
		<div class="row">
			<div class="col-xs-12">
				<div class="panel panel-warning">
					<div class="panel-heading">
						답변
					</div>
					<div class="panel-body">
						<form action="/admin/qna/insert" method="post">
							<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
							<input type="hidden" name="qna_id" value="${qna.id }"/>
							<div class="form-group">
								<input
									   class="form-control"
									   name="title" 
									   placeholder="제목을 입력해 주세요"/>
							</div>
							<div class="form-group">
								<textarea class="form-control" id="content"
										  name="content"
										  placeholder="내용을 입력해 주세요"></textarea> 
							</div>
							<div class="form-group text-right">
								<button class="btn btn-primary"
										type="submit">등록</button>
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
	<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/lang/summernote-ko-KR.min.js"></script>
	<script>
	$("#content").summernote({
		height:400,
		//focus: true,
		disableResizeEditor:true,
		lang: 'ko-KR',
		callbacks:{
			onImageUpload:sendFile,
			onMediaDelete:deleteFile
		}
	});
	function deleteFile(target){
		var src = target[0].src.substring(21);
		console.log("src",src);
		$.ajax({
			url:"/filedelete",
			type:"post",
			data:{src:src},
			beforeSend : function(xhr){   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
			success:function(data){
				console.log(data);
			}
		});
	}
	
	function sendFile(files, editor, welEditable){
		//console.log(files[0]);
		var data = new FormData();
		data.append('upload', files[0]);
		
		$.ajax({
			url:"/fileupload",
			contentType:false,
			processData:false,
			data:data,
			type:"post",
			beforeSend : function(xhr){   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
			success:function(data){
				//console.log(data);
				$("#content").summernote(
						'editor.insertImage', data.url);
			},error:function(error){
				console.error(error);
			}
		});
	}
	</script>
	
</body>
</html>