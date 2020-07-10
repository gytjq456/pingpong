<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
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
				연락 수단: ${pdto.contact}<br>
			</c:otherwise>
		</c:choose>
		<button id="delete">삭제</button>
		<a href="/admins/partnerList">목록으로</a>
		<script>
			$('#delete').on('click', function(){
				var conf = confirm('정말 삭제하시겠습니까?');
				
				if (conf) {
					var seq = ${pdto.seq};
					location.href = "/admins/deleteBySeq?pageName=partnerList&seq=" + seq;
				}
			})
		</script>
	</div>
</body>
</html>