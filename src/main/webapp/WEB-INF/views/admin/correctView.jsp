<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<div id="view_wrap">
			<c:choose>
				<c:when test="${empty cdto}">
					<div>내용을 불러오는 데 실패하였습니다. 다시 시도해 주세요.</div>
				</c:when>
				<c:otherwise>
					<div class="view_line">
						<div class="first_line">
							${cdto.title}
						</div>
					</div>
					<div class="view_line">
						<div>
							<div class="second_line_left">
								<span>글번호</span>
								<span class="span_con">${cdto.seq}</span>
								<span>작성자</span>
								<span class="span_con">${cdto.writer}</span>
								<span>작성일</span>
								<span class="span_con">${fn:substring(cdto.write_date, 0, 10)}</span>
							</div>
							<div class="second_line_right">
								<span>조회수</span>
								<span class="span_con">${cdto.view_count}</span>
								<span>추천수</span>
								<span class="span_con">${cdto.like_count}</span>
								<span>싫어요수</span>
								<span class="span_con">${cdto.hate_count}</span>
								<span>댓글수</span>
								<span class="span_con">${cdto.reply_count}</span>
							</div>
						</div>
					</div>
					<div class="view_line">
						<div>
							<div class="third_line_left">
								<ul>
									<li>
										<span>언어</span>
										<span class="span_con">${cdto.language}</span>
									</li>
								</ul>
							</div>
							<div class="third_line_right">
								<ul>
									<li>
										<span>유형</span>
										<span class="span_con">${cdto.type}</span>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="view_line">
						<div id="contents">${cdto.contents}</div>
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
						var seq = ${cdto.seq};
						location.href = "/admins/deleteBySeq?pageName=correctList&seq=" + seq;
					}
				})
				
				$('#goToList').on('click', function(){
					location.href = "/admins/correctList";
				})
			</script>
		</div>
	</div>
</body>
</html>