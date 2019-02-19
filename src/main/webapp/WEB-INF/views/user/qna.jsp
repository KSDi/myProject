<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet">
<link href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" rel="stylesheet">
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
						<div class="row">
							<table class="table table-board">
								<thead>
									<tr>
										<th width="15%">번호</th>
										<th width="55%">제목</th>
										<th width="15%">작성일</th>
										<th width="15%">상태</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach var="question" items="${questionList}" varStatus="i">
									<tr style="cursor:pointer; ">
										<td>
											<a href="#question_${i.index +1 }" role="button" 
													data-toggle="collapse" aria-expanded="false" 
														aria-controls="collapseExample">
												${i.index+1 }
											</a>
										</td>
										<td>
											<a href="#question_${i.index +1 }" role="button" 
													data-toggle="collapse" aria-expanded="false" 
														aria-controls="collapseExample">
												${question.title }
											</a>
										</td>
										<td>
											<a href="#question_${i.index +1 }" role="button" 
													data-toggle="collapse" aria-expanded="false" 
														aria-controls="collapseExample">
												<fmt:parseDate value="${question.regdate }" var="regdate" pattern="yyyy-mm-dd"/>
												<fmt:formatDate value="${regdate }" pattern="yy-mm-dd"/>
											</a>
										</td>
										<td>
											<a href="#question_${i.index +1 }" role="button" 
													data-toggle="collapse" aria-expanded="false" 
														aria-controls="collapseExample">
												${question.status  }												
											</a>
										</td>
									</tr>
									<tr>
										<td colspan="4">
											<div class="collapse" id="question_${i.index +1 }">
												<div class="well">
													${question.content }
												</div>
											</div>
										</td>
									</tr>
									<c:forEach var="answer" items="${question.answers }">
										<tr style="cursor:pointer;background-color: #efefef">
										<td>
											<a href="#answer_${i.index +1 }" role="button" 
													data-toggle="collapse" aria-expanded="false" 
														aria-controls="collapseExample">
												<i class="fas fa-reply" 
						  						 style="transform:rotate(180deg)"></i>
											</a>
										</td>
										<td>
											<a href="#answer_${i.index +1 }" role="button" 
													data-toggle="collapse" aria-expanded="false" 
														aria-controls="collapseExample">
												${answer.title }
											</a>
										</td>
										<td>
											<a href="#answer_${i.index +1 }" role="button" 
													data-toggle="collapse" aria-expanded="false" 
														aria-controls="collapseExample">
												<fmt:parseDate value="${answer.regdate }" var="regdate" pattern="yyyy-mm-dd"/>
												<fmt:formatDate value="${regdate }" pattern="yy-mm-dd"/>
											</a>
										</td>
										<td>
											<a href="#answer_${i.index +1 }" role="button" 
													data-toggle="collapse" aria-expanded="false" 
														aria-controls="collapseExample">
																							
											</a>
										</td>
									</tr>
									<tr>
										<td colspan="4">
											<div class="collapse" id="answer_${i.index +1 }">
												<div class="well">
													${answer.content }
												</div>
											</div>
										</td>
									</tr>
									</c:forEach>
								</c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="5" class="text-right">
											<a href="/user/qna/insert"
											   class="btn btn-primary">글쓰기</a>
										</td>
									</tr><%-- 
									<tr>
										<td colspan="5" style="border-top:none;">
											<ul class="pagination">
												${pageHTML }
											</ul>
										</td>
									</tr> --%>
								</tfoot>
							</table>
						</div>
				</div>
				<div class="col-sm-2"></div>
			</div>
		</div>
		<jsp:include page="../footer.jsp" />
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	
</body>
</html>