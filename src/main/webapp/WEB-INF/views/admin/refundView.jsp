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
		<c:when test="${empty rfdto}">
			ㅠㅠ
		</c:when>
		<c:otherwise>
			번호: ${rfdto.seq}<br>
			아이디: ${rfdto.id}<br>
			이름: ${rfdto.name}<br>
			이메일: ${rfdto.email}<br>
			전화번호: ${rfdto.phone}<br>
			계좌번호: (${rfdto.bank_name})${rfdto.account}<br>
			프로필: ${rfdto.profile}<br>
			부모: ${rfdto.parent_seq}<br>
			환불 요청: ${rfdto.cancle}<br>
			환불 가격: ${rfdto.refundPrice}<br>
		</c:otherwise>
	</c:choose>
	<a href="/admin/deleteBySeq?pageName=refundList&seq=${rfdto.seq}">승인</a>
	<a href="/admin/refundList">목록으로</a>
</body>
</html>