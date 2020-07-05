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
		<c:when test="${empty rdto}">
			ㅠㅠ
		</c:when>
		<c:otherwise>
			글번호: ${rdto.seq}<br>
			아이디: ${rdto.id}<br>
			사유: ${rdto.reason}<br>
			신고자: ${rdto.reporter}<br>
			신고일: ${rdto.sDate}<br>
			부모: ${rdto.parent_seq}<br>
			유형: ${rdto.category}<br>
			패스: ${rdto.pass}
		</c:otherwise>
	</c:choose>
</body>
</html>