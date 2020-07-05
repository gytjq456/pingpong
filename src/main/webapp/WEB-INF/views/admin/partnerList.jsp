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
		<c:when test="${empty plist}">
			등록된 파트너가 없습니다.
		</c:when>
		<c:otherwise>
			<c:forEach var="plist" items="${plist}">
				${plist.seq} : 
				<a href="/admin/partnerView?seq=${plist.seq}">${plist.id}</a>
				 : ${plist.name} : ${plist.age} : ${plist.gender} : 
				${plist.email} : ${plist.contact}<br>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</body>
</html>