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
		<c:when test="${empty rlist}">
			신고된 컨텐츠가 없습니다.
		</c:when>
		<c:otherwise>
			<c:forEach var="rlist" items="${rlist}">
				${rlist.seq} : ${rlist.id} : 
				<a href="/admin/reportView?seq=${rlist.seq}">${rlist.reason}</a>
				 : ${rlist.reporter} : 
				${rlist.report_date} : ${rlist.parent_seq} : ${rlist.category} : ${rlist.pass}<br>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</body>
</html>