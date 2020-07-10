<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<c:choose>
			<c:when test="${empty lddto}">
				ㅠㅠ
			</c:when>
			<c:otherwise>
				글번호: ${lddto.seq}<br>
				작성자: ${lddto.id}<br>
				카테고리: ${lddto.category}<br>
				내용: ${lddto.contents}<br>
				부모: ${lddto.parent_seq}<br>
			</c:otherwise>
		</c:choose>
		<button id="accept">승인</button>
		<button id="delete">삭제</button>
		<a href="/admins/lessonDelList">목록으로</a>
		<script>
			$('#accept').on('click', function(){
				var conf = confirm('정말 승인하시겠습니까?');
				
				if (conf) {
					var seq = ${lddto.parent_seq};
					location.href = "/admins/deleteAppLesson?seq=" + seq;
				}
			})
			
			$('#delete').on('click', function(){
				var conf = confirm('정말 삭제하시겠습니까?');
				
				if (conf) {
					var seq = ${lddto.seq};
					location.href = "/admins/deleteBySeq?pageName=lessonDelList&seq=" + seq;
				}
			})
		</script>
	</div>
</body>
</html>