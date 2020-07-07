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
		<c:when test="${empty llist}">
			등록된 강의가 없습니다.
		</c:when>
		<c:otherwise>
			<c:forEach var="llist" items="${llist}">
				<input type="checkbox" value="${llist.seq}">
				${llist.seq} : ${llist.id} : ${llist.name} : ${llist.email} : 
				${llist.phone_country} : ${llist.phone} : ${llist.category} : 
				<a href="/admin/lessonView?seq=${llist.seq}">${llist.title}</a>
				 : ${llist.price}<br>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<div class="navi">${navi}</div>
	<a href="/admin">관리자 메인</a>
</body>
</html>