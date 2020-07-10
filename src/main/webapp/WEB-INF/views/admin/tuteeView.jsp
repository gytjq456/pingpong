<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
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
		<button id="delete">삭제</button>
		<a href="/admins/tuteeList">목록으로</a>
		<script>
			$('#delete').on('click', function(){
				var conf = confirm('정말 삭제하시겠습니까?');
				
				if (conf) {
					var seq = ${ttdto.seq};
					location.href = "/admins/deleteBySeq?pageName=tuteeList&seq=" + seq;
				}
			})
		</script>
	</div>
</body>
</html>