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
		<c:when test="${empty glist}">
			등록된 그룹이 없습니다.
		</c:when>
		<c:otherwise>
			<c:forEach var="glist" items="${glist}">
				${glist.seq} : 
				<a href="/admin/groupView?seq=${glist.seq}">${glist.title}</a>
				 : ${glist.writer_id} : ${glist.writer_name} : 
				${glist.hobby_type} : ${glist.date}<br>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</body>
</html>