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
		<c:when test="${empty bldto}">
			ㅠㅠ
		</c:when>
		<c:otherwise>
			글번호: ${bldto.seq}<br>
			아이디: ${bldto.id}<br>
			이름: ${bldto.name}<br>
			사유: ${bldto.reason}<br>
			등록일: ${bldto.start_date}<br>
			해제일: ${bldto.end_date}<br>
		</c:otherwise>
	</c:choose>
	<a href="/admin/deleteBySeq?pageName=blacklistList&seq=${bldto.seq}">삭제</a>
	<a href="/admin/blacklistList">목록으로</a>
</body>
</html>