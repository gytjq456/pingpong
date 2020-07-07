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
		<c:when test="${empty trdto}">
			ㅠㅠ
		</c:when>
		<c:otherwise>
			타입: ${trdto.mem_type}<br>
			아이디: ${trdto.id}<br>
			이름: ${trdto.name}<br>
			나이: ${trdto.age}<br>
			성별: ${trdto.gender}<br>
			이메일: ${trdto.email}<br>
			전화번호: (${trdto.phone_country})${trdto.phone}<br>
			주소: ${trdto.address}<br>
			계좌번호: (${trdto.bank_name})${trdto.account}<br>
			국적: ${trdto.country}<br>
			구사 언어: ${trdto.lang_can}<br>
			학습 언어: ${trdto.lang_learn}<br>
			관심사: ${trdto.hobby}<br>
			등급: ${trdto.grade}<br>
			소개: ${trdto.introduce}<br>
			신고수: ${trdto.report_count}<br>
			가입일: ${trdto.signup_date}<br>
		</c:otherwise>
	</c:choose>
	<a href="/admin/deleteById?pageName=tutorList&id=${trdto.id}">삭제</a>
	<a href="/admin/tutorList">목록으로</a>
</body>
</html>