<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<c:choose>
			<c:when test="${empty cdto}">
				ㅠㅠ
			</c:when>
			<c:otherwise>
				글번호: ${cdto.seq}<br>
				작성자: ${cdto.writer}<br>
				언어: ${cdto.language}<br>
				제목: ${cdto.title}<br>
				유형: ${cdto.type}<br>
				내용: ${cdto.contents}<br>
				작성일: ${cdto.write_date}<br>
				조회수: ${cdto.view_count}<br>
				추천수: ${cdto.like_count}<br>
				싫어수: ${cdto.hate_count}<br>
				댓글수: ${cdto.reply_count}<br>
			</c:otherwise>
		</c:choose>
		<button id="delete">삭제</button>
		<a href="/admins/correctList">목록으로</a>
		<script>
			$('#delete').on('click', function(){
				var conf = confirm('정말 삭제하시겠습니까?');
				
				if (conf) {
					var seq = ${cdto.seq};
					location.href = "/admins/deleteBySeq?pageName=correctList&seq=" + seq;
				}
			})
		</script>
	</div>
</body>
</html>