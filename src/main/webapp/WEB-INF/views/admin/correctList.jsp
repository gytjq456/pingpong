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
		<c:when test="${empty clist}">
			등록된 첨삭 게시글이 없습니다.
		</c:when>
		<c:otherwise>
			<c:forEach var="clist" items="${clist}">
				<input type="checkbox" value="${clist.seq}">
				${clist.seq} : ${clist.writer} : ${clist.language} : 
				 <a href="/admin/correctView?seq=${clist.seq}">${clist.title}</a>
				  : ${clist.type} : ${clist.write_date}<br>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<div class="navi">${navi}</div>
	<a href="/admin">관리자 메인</a>
</body>
</html>