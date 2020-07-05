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
		<c:when test="${empty mdto}">
			ㅠㅠ
		</c:when>
		<c:otherwise>
			타입: ${mdto.mem_type}<br>
			아이디: ${mdto.id}<br>
			이름: ${mdto.name}<br>
			나이: ${mdto.age}<br>
			성별: ${mdto.gender}<br>
			이메일: ${mdto.email}<br>
			전화번호: (${mdto.phone_country})${mdto.phone}<br>
			주소: ${mdto.address}<br>
			계좌번호: (${mdto.bank_name})${mdto.account}<br>
			국적: ${mdto.country}<br>
			구사 언어: ${mdto.lang_can}<br>
			학습 언어: ${mdto.lang_learn}<br>
			관심사: ${mdto.hobby}<br>
			등급: ${mdto.grade}<br>
			소개: ${mdto.introduce}<br>
			신고수: ${mdto.report_count}<br>
			가입일: ${mdto.signup_date}
		</c:otherwise>
	</c:choose>
</body>
</html>