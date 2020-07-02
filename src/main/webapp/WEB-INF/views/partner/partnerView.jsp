<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/header.jsp"/>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>


<body>
	<br><br><br><br><br><br><br><br><br><br><br>
	<c:choose>
		<c:when test="${empty pdto }">
			해당 뷰페이지에 파트너 정보를 찾을 수 없습니다.
		</c:when>
		<c:otherwise>
			<div class="box">
				${pdto.sysname}<br>
				<span class="seq">${pdto.seq}</span> <br>
				${pdto.id}<br>
				${pdto.name}<br>
				${pdto.age}<br>
				${pdto.gender}<br>
				${pdto.email}<br>
				${pdto.country}<br>
				${pdto.phone_country}<br>
				${pdto.phone}<br>
				${pdto.address}<br>
				${pdto.lang_can}<br>
				${pdto.lang_learn}<br>
				${pdto.hobby}<br>
				${pdto.introduce}<br>
				${pdto.partner_date}<br>
				${pdto.review_count}<br>
				${pdto.review_point}<br><br>
			</div>
			<div class="button_aa">
				<button class="letter">쪽지</button>
				<button class="chat">채팅</button>
				<button class="email">이메일</button>
				<button class="report">신고하기</button><br><br>
				<button class="back">목록으로</button>
			</div>
		</c:otherwise>
	</c:choose>
	<script>
		$("#back").on("click",function(){
			location.href="/partner/partnerList";
		})
		$(".button_aa .email").on("click",function(e){
			var seq = $(this).closest('.email').siblings('.box').find('.seq').html();
			location.href="/partner/selectPartnerEmail?seq="+seq;
		})
	</script>

<jsp:include page="/WEB-INF/views/footer.jsp"/>	