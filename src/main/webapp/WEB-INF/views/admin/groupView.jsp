<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<c:choose>
			<c:when test="${empty gdto}">
				ㅠㅠ
			</c:when>
			<c:otherwise>
				글번호: ${gdto.seq}<br>
				제목: ${gdto.title}<br>
				작성자: ${gdto.writer_name}(${gdto.writer_id})<br>
				유형: ${gdto.hobby_type}<br>
				모집 기간: ${gdto.apply_start} ~ ${gdto.apply_end}<br>
				진행 기간: ${gdto.start_date} ~ ${gdto.end_date}<br>
				기간 유형: ${gdto.period}<br>
				인원: ${gdto.cur_num}/${gdto.max_num}<br>
				장소: ${gdto.location}<br>
				내용: ${gdto.contents}<br>
				작성일: ${gdto.date}<br>
				조회수: ${gdto.view_count}<br>
				추천수: ${gdto.like_count}<br>
				신청수: ${gdto.app_count}<br>
				리뷰수: ${gdto.review_count}<br>
				평점: ${gdto.review_point}<br>
				모집중: ${gdto.applying}<br>
				진행중: ${gdto.proceeding}<br>
			</c:otherwise>
		</c:choose>
		<button id="delete">삭제</button>
		<a href="/admins/groupList">목록으로</a>
		<script>
			$('#delete').on('click', function(){
				var conf = confirm('정말 삭제하시겠습니까?');
				
				if (conf) {
					var seq = ${gdto.seq};
					location.href = "/admins/deleteBySeq?pageName=groupList&seq=" + seq;
				}
			})
		</script>
	</div>
</body>
</html>