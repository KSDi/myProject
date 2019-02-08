<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet">
<link href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" rel="stylesheet">
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet">
<style>
	.tab-line{
		border-bottom:2px solid #3d82f7;
		background-color: #f9f9f9;
		
	}
	.tab{
		width:33.3333%;
		float:left;
		padding:12px 0;
	}
	.tab-selected{
		background-color: white;
	    border: 2px solid #3d82f7;
	    border-bottom-width: 0px;
	    margin-bottom: -2px;
	}
	.tab-name{
		font-weight:bold;
		font-size:21px;
	}
	.txt_bar{
		float: left;
	    overflow: hidden;
	    width: 1px;
	    height: 10px;
	    margin-top: 10px;
	    background-color: #ccc;
	    text-indent: -9999px;
	    vertical-align: top;
	}
	.box_layer{
		float: left;
	    position: relative;
	    border: 0;
	    z-index: 300;
	    vertical-align: top;
	}
	.link_option{
		display: block;
	    padding: 8px;
	    vertical-align: top;
	    border-bottom: 1px solid transparent;
	    font-size : 20px;
	    font-weight:600;
	}
	.mod_title{
	    padding-top: 10px;
	    padding-bottom: 5px;
	    border-left: 5px solid #101010;
	    margin-top: 30px;
	}
	td>a:not(.btn){
		padding-left:15px;
		line-height: 55px;
	    width: 100%;
	    display: block;
	    
	}
	.table>tbody>tr>td{
		padding:0;
	}
	.well{
		margin-top:10px;
		margin-bottom:10px;
	}
	.panel{
		margin-top: 20px;
		padding : 0;
	    width: 98%;
	    margin-left: 1%;
	}
</style>
</head>

<body>
	<div>
		<jsp:include page="../header.jsp"/>
	</div>
	<div class="content">
		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-2 col-xs-12">
					<jsp:include page="../left_menu.jsp"/>
				</div>
				<div class="col-sm-8 col-xs-12">
						<div class="tab-line row">
							<ul class="tab-list text-center">
								<li class="tab">
									<a href="/user/mypage" class="tab-link">
										<span class="tab-name">주문목록/배송조회</span>
									</a>
								</li>
								<li class="tab">
									<a href="/user/modify" class="tab-link">
										<span class="tab-name">개인정보수정</span>
									</a>
								</li>
								<li class="tab tab-selected">
									<a href="/user/qna" class="tab-link">
										<span class="tab-name">1:1 문의</span>
									</a>
								</li>
							</ul>
						</div>
						<div class="col-xs-12 mod_title">
							<h1>1&nbsp;:&nbsp;1 문의 </h1>
						</div>
						<div class="col-xs-12 panel panel-primary">
							<div class="panel-heading">
								<h4>글쓰기</h4>
							</div>
							<div class="panel-body">
								<form:form action="/user/qna/insert" method="post"
										   modelAttribute="question">
									<div class="form-group">
										<form:input
											   class="form-control"
											   path="title" 
											   placeholder="제목을 입력해 주세요"/>
										<form:errors path="title" class="error"/>
									</div>
									<div class="form-group">
										<form:textarea class="form-control" id="content"
												  path="content"
												  placeholder="내용을 입력해 주세요"></form:textarea>
										<form:errors path="content" class="error"/>		  
									</div>
									<div class="form-group text-right">
										<button class="btn btn-primary"
												type="submit">등록</button>
									</div>
								</form:form>
							</div>
						</div>
				</div>
				<div class="col-sm-2"></div>
			</div>
		</div>
		<jsp:include page="../footer.jsp" />
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
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