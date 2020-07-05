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
		<c:when test="${empty trlist}">
			등록된 튜터가 없습니다.
		</c:when>
		<c:otherwise>
			<c:forEach var="trlist" items="${trlist}">
				${trlist.mem_type} : 
				<a href="/admin/tutorView?id=${trlist.id}">${trlist.id}</a>
				 : ${trlist.name} : ${trlist.age} : 
				${trlist.grade} : ${trlist.signup_date}<br>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</body>
</html>