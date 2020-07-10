<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
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
		<button id="delete">삭제</button>
		<a href="/admins/tutorList">목록으로</a>
		<script>
			$('#delete').on('click', function(){
				var conf = confirm('정말 삭제하시겠습니까?');
				
				if (conf) {
					var seq = ${trdto.id};
					location.href = "/admins/deleteBySeq?pageName=tutorList&id=" + id;
				}
			})
		</script>
	</div>
</body>
</html>