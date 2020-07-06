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
		<c:when test="${empty ttdto}">
			ㅠㅠ
		</c:when>
		<c:otherwise>
			번호: ${ttdto.seq}<br>
			아이디: ${ttdto.id}<br>
			이름: ${ttdto.name}<br>
			이메일: ${ttdto.email}<br>
			전화번호: ${ttdto.phone}<br>
			계좌번호: (${ttdto.bank_name})${ttdto.account}<br>
			프로필: ${ttdto.profile}<br>
			부모: ${ttdto.parent_seq}<br>
		</c:otherwise>
	</c:choose>
	<a href="/admin/deleteBySeq?pageName=tuteeList&seq=${ttdto.seq}">삭제</a>
	<a href="/admin/tuteeList">목록으로</a>
</body>
</html>