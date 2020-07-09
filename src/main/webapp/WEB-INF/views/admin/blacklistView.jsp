<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<c:choose>
			<c:when test="${empty bldto}">
				ㅠㅠ
			</c:when>
			<c:otherwise>
				글번호: ${bldto.seq}<br>
				아이디: ${bldto.id}<br>
				이름: ${bldto.name}<br>
				사유: ${bldto.reason}<br>
				등록일: ${bldto.start_date}<br>
				해제일: ${bldto.end_date}<br>
			</c:otherwise>
		</c:choose>
		<button id="delete">삭제</button>
		<a href="/admins/blacklistList">목록으로</a>
		<script>
			$('#delete').on('click', function(){
				var conf = confirm('정말 삭제하시겠습니까?');
				
				if (conf) {
					var seq = ${bldto.seq};
					location.href = "/admins/deleteBySeq?pageName=blacklistList&seq=" + seq;
				}
			})
		</script>
	</div>
</body>
</html>