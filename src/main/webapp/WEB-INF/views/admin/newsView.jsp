<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<div id="view_wrap">
			<c:choose>
				<c:when test="${empty ndto}">
					<div>내용을 불러오는 데 실패하였습니다. 다시 시도해 주세요.</div>
				</c:when>
				<c:otherwise>
					<div class="view_line">
						<div class="first_line">
							${ndto.title}
						</div>
					</div>
					<div class="view_line">
						<div>
							<div class="second_line_left">
								<span>글번호</span>
								<span class="span_con">${ndto.seq}</span>
								<span>작성자</span>
								<span class="span_con">${ndto.writer}</span>
								<span>작성일</span>
								<span class="span_con">${fn:substring(ndto.write_date, 0, 10)}</span>
							</div>
							<div class="second_line_right">
								<span>조회수</span>
								<span class="span_con">${ndto.view_count}</span>
								<span>추천수</span>
								<span class="span_con">${ndto.like_count}</span>
								<span>댓글수</span>
								<span class="span_con">${ndto.comment_count}</span>
							</div>
						</div>
					</div>
					<div class="view_line">
						<div>
							<div class="third_line_left">
								<ul>
									<li>
										<span>유형</span>
										<span class="span_con">${ndto.category}</span>
									</li>
									<li>
										<span>기간</span>
										<span class="span_con">${fn:substring(ndto.start_date, 0, 10)} ~ ${fn:substring(ndto.end_date, 0, 10)}</span>
									</li>
								</ul>
							</div>
							<div class="third_line_right">
								<ul>
									<li>
										<span>장소</span>
										<span class="span_con">${ndto.location}</span>
									</li>
									<li>
										<span>파일명</span>
										<span class="span_con">${ndto.files_name}</span>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="view_line">
						<div id="contents">${ndto.contents}</div>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="btn_wrap">
				<div class="btns">
					<button id="delete">삭제</button>
					<button id="goToList">목록으로</button>
				</div>
			</div>
			<script>
				$('#delete').on('click', function(){
					var conf = confirm('정말 삭제하시겠습니까?');
					
					if (conf) {
						var seq = ${ndto.seq};
						location.href = "/admins/deleteBySeq?pageName=newsList&seq=" + seq;
					}
				})
				
				$('#goToList').on('click', function(){
					location.href = "/admins/newsList";
				})
			</script>
		</div>
	</div>
</body>
</html>