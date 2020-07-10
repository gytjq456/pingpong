<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<c:choose>
			<c:when test="${empty ndto}">
				ㅠㅠ
			</c:when>
			<c:otherwise>
				글번호: ${ndto.seq}<br>
				작성자: ${ndto.writer}<br>
				제목: ${ndto.title}<br>
				유형: ${ndto.category}<br>
				기간: ${ndto.start_date} ~ ${ndto.end_date}<br>
				장소: ${ndto.location}<br>
				파일명: ${ndto.files_name}<br>
				내용: ${ndto.contents}<br>
				작성일: ${ndto.write_date}<br>
				조회수: ${ndto.view_count}<br>
				추천수: ${ndto.like_count}<br>
				댓글수: ${ndto.comment_count}<br>
			</c:otherwise>
		</c:choose>
		<button id="delete">삭제</button>
		<a href="/admins/newsList">목록으로</a>
		<script>
			$('#delete').on('click', function(){
				var conf = confirm('정말 삭제하시겠습니까?');
				
				if (conf) {
					var seq = ${ndto.seq};
					location.href = "/admins/deleteBySeq?pageName=newsList&seq=" + seq;
				}
			})
		</script>
	</div>
</body>
</html>