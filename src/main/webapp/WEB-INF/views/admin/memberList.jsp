<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
	<c:choose>
		<c:when test="${empty mlist}">
			등록된 회원이 없습니다.
		</c:when>
		<c:otherwise>
			<c:forEach var="mlist" items="${mlist}">
				<input type="checkbox" value="${mlist.id}">
				${mlist.mem_type} : 
				<a href="/admin/memberView?id=${mlist.id}">${mlist.id}</a>
				 : ${mlist.name} : ${mlist.age} : ${mlist.gender} : 
				${mlist.signup_date}<br>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<div class="navi">${navi}</div>
	<a href="/admin">관리자 메인</a>
</body>
</html>