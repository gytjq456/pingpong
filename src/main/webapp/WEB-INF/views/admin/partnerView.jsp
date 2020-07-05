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
		<c:when test="${empty pdto}">
			ㅠㅠ
		</c:when>
		<c:otherwise>
			번호: ${pdto.seq}<br>
			아이디: ${pdto.id}<br>
			이름: ${pdto.name}<br>
			나이: ${pdto.age}<br>
			성별: ${pdto.gender}<br>
			이메일: ${pdto.email}<br>
			국적: ${pdto.country}<br>
			전화번호: (${pdto.phone_country})${pdto.phone}<br>
			주소: ${pdto.address}<br>
			구사 언어: ${pdto.lang_can}<br>
			학습 언어: ${pdto.lang_learn}<br>
			관심사: ${pdto.hobby}<br>
			소개: ${pdto.introduce}<br>
			등록일: ${pdto.partner_date}<br>
			리뷰수: ${pdto.review_count}<br>
			평점: ${pdto.review_point}<br>
			연락 수단: ${pdto.contact}
		</c:otherwise>
	</c:choose>
</body>
</html>