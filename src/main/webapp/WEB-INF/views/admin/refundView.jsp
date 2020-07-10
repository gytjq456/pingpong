<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
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
		<button id="accept">승인</button>
		<a href="/admins/refundList">목록으로</a>
		<script>
			$('#accept').on('click', function(){
				var conf = confirm('정말 승인하시겠습니까?');
				
				if (conf) {
					var seq = ${rfdto.seq};
					location.href = "/admins/deleteBySeq?pageName=refundList&seq=" + seq;
				}
			})
		</script>
	</div>
</body>
</html>