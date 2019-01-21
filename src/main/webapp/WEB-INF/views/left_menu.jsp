<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<div>
	<p class="dmall text-center"><a href="/">D SHOP</a></p>
	<hr />
	<ul class="nav flex-column text-center">
	  <li class="nav-item">
	    <a class="nav-link" href="/product/list">ALL</a>
	  </li>
	  <c:forEach var="category" items="${categoryList }">
	  <li class="nav-item">
	    <a class="nav-link" href="/product/list?category=${category }">${fn:toUpperCase(category) }</a>
	  </li>
	  </c:forEach>
	</ul>
</div>
