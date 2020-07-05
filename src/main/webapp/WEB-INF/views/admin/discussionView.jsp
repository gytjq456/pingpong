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
		<c:when test="${empty ddto}">
			ㅠㅠ
		</c:when>
		<c:otherwise>
			글번호: ${ddto.seq}<br>
			작성자: ${ddto.writer}<br>
			제목: ${ddto.title}<br>
			내용: ${ddto.contents}<br>
			주의: ${ddto.caution}<br>
			언어: ${ddto.language}<br>
			작성일: ${ddto.dateString}<br>
			조회수: ${ddto.view_count}<br>
			추천수: ${ddto.like_count}<br>
			댓글수: ${ddto.comment_count}
		</c:otherwise>
	</c:choose>
</body>
</html>