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
		<c:when test="${empty ttlist}">
			튜티가 없습니다.
		</c:when>
		<c:otherwise>
			<c:forEach var="ttlist" items="${ttlist}">
				${ttlist.seq} : 
				<a href="/admin/tuteeView?seq=${ttlist.seq}">${ttlist.id}</a>
				 : ${ttlist.name} : ${ttlist.email} : ${ttlist.phone} : 
				${ttlist.bank_name} : ${ttlist.account} : ${ttlist.profile} : ${ttlist.parent_seq}<br>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</body>
</html>