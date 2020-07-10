<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<c:choose>
			<c:when test="${empty ldto}">
				ㅠㅠ
			</c:when>
			<c:otherwise>
				글번호: ${ldto.seq}<br>
				강사: ${ldto.name}(${ldto.id})<br>
				이메일: ${ldto.email}<br>
				전화번호: (${ldto.phone_country})${ldto.phone}<br>
				유형: ${ldto.category}<br>
				제목: ${ldto.title}<br>
				가격: ${ldto.price}<br>
				언어: ${ldto.language}<br>
				모집 기간: ${ldto.apply_start} ~ ${ldto.apply_end}<br>
				진행 기간: ${ldto.start_date} ~ ${ldto.end_date}<br>
				진행 시간: ${ldto.start_hour}:${ldto.start_minute} ~ ${ldto.end_hour}:${ldto.end_minute}<br>
				인원: ${ldto.cur_num}/${ldto.max_num}<br>
				장소: ${ldto.location}<br>
				내용: ${ldto.curriculum}<br>
				추천수: ${ldto.like_count}<br>
				조회수: ${ldto.view_count}<br>
				리뷰수: ${ldto.review_count}<br>
				평점: ${ldto.review_point}<br>
				모집중: ${ldto.applying}<br>
				진행중: ${ldto.proceeding}<br>
			</c:otherwise>
		</c:choose>
		<button id="delete">삭제</button>
		<a href="/admins/lessonList">목록으로</a>
		<script>
			$('#delete').on('click', function(){
				var conf = confirm('정말 삭제하시겠습니까?');
				
				if (conf) {
					var seq = ${ldto.seq};
					location.href = "/admins/deleteBySeq?pageName=lessonList&seq=" + seq;
				}
			})
		</script>
	</div>
</body>
</html>