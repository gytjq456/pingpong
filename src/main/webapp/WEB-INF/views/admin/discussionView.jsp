<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<c:choose>
			<c:when test="${empty ddto}">
				ㅠㅠ
			</c:when>
			<c:otherwise>
				글번호: ${ddto.seq}<br>
				작성자: ${ddto.writer}<br>
				제목: ${ddto.title}<br>
				내용: ${ddto.contents}<br>
				주의: ${ddto.caution}<br>
				언어: ${ddto.language}<br>
				작성일: ${ddto.dateString}<br>
				조회수: ${ddto.view_count}<br>
				추천수: ${ddto.like_count}<br>
				댓글수: ${ddto.comment_count}<br>
			</c:otherwise>
		</c:choose>
		<button id="delete">삭제</button>
		<a href="/admins/discussionList">목록으로</a>
		<script>
			$('#delete').on('click', function(){
				var conf = confirm('정말 삭제하시겠습니까?');
				
				if (conf) {
					var seq = ${ddto.seq};
					location.href = "/admins/deleteBySeq?pageName=discussionList&seq=" + seq;
				}
			})
		</script>
	</div>
</body>
</html>