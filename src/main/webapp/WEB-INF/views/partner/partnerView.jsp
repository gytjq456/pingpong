<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/header.jsp"/>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>


<body>
	<c:choose>
		<c:when test="${empty pdto }">
			실패
		</c:when>
		<c:otherwise>
			${pdto.seq}<br>
			${pdto.id}<br>
			${pdto.name}<br>
			${pdto.age}<br>
			${pdto.gender}<br>
			${pdto.email}<br>
			${pdto.country}<br>
			${pdto.phone_country}<br>
			${pdto.phone}<br>
			${pdto.address}<br>
			${pdto.profile}<br>
			${pdto.lang_can}<br>
			${pdto.lang_learn}<br>
			${pdto.hobby}<br>
			${pdto.introduce}<br>
			${pdto.partner_date}<br>
			${pdto.review_count}<br>
			${pdto.review_point}<br><br>
			
			<button id="letter">쪽지</button>
			<button id="chat">채팅</button>
			<button id="email">이메일</button>
			<button id="report">신고하기</button><br><br>
			<button id="back">목록으로</button>
		</c:otherwise>
	</c:choose>
	<script>
		$("#back").on("click",function(){
			location.href="/partner/partnerList";
		})
	</script>

<jsp:include page="/WEB-INF/views/footer.jsp"/>	