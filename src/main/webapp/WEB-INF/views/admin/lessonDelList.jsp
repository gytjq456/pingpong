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
		<c:when test="${empty ldlist}">
			등록된 강의 취소 신청이 없습니다.
		</c:when>
		<c:otherwise>
			<c:forEach var="ldlist" items="${ldlist}">
				<input type="checkbox" value="${ldlist.seq}">
				${ldlist.seq} : 
				<a href="/admin/lessonDelView?seq=${ldlist.seq}">${ldlist.id}</a>
				 : ${ldlist.category} : 
				${ldlist.contents} : ${ldlist.parent_seq}<br>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<div class="navi">${navi}</div>
	<a href="/admin">관리자 메인</a>
</body>
</html>