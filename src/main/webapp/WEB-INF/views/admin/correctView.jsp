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
		<c:when test="${empty cdto}">
			ㅠㅠ
		</c:when>
		<c:otherwise>
			글번호: ${cdto.seq}<br>
			작성자: ${cdto.writer}<br>
			언어: ${cdto.language}<br>
			제목: ${cdto.title}<br>
			유형: ${cdto.type}<br>
			내용: ${cdto.contents}<br>
			작성일: ${cdto.write_date}<br>
			조회수: ${cdto.view_count}<br>
			추천수: ${cdto.like_count}<br>
			싫어수: ${cdto.hate_count}<br>
			댓글수: ${cdto.reply_count}<br>
		</c:otherwise>
	</c:choose>
	<a href="/admin/deleteBySeq?pageName=correctList&seq=${cdto.seq}">삭제</a>
	<a href="/admin/correctList">목록으로</a>
</body>
</html>