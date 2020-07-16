<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<div id="view_wrap">
			<c:choose>
				<c:when test="${empty rdto}">
					<div>내용을 불러오는 데 실패하였습니다. 다시 시도해 주세요.</div>
				</c:when>
				<c:otherwise>
					<div class="view_line">
						<div class="first_line">
							신고서
						</div>
					</div>
					<div class="view_line">
						<div>
							<div class="second_line_left">
								<span>글번호</span>
								<span class="span_con">${rdto.seq}</span>
								<span>신고일</span>
								<span class="span_con">${fn:substring(rdto.report_date, 0, 10)}</span>
							</div>
						</div>
					</div>
					<div class="view_line">
						<div>
							<div class="third_line_left">
								<ul>
									<li>
										<span>신고 대상 아이디</span>
										<span class="span_con">${rdto.id}</span>
									</li>
									<li>
										<span>대상 게시글 코드</span>
										<span class="span_con">${rdto.parent_seq}</span>
									</li>
									<li>
										<span>사유</span>
										<span class="span_con">${rdto.reason}</span>
									</li>
								</ul>
							</div>
							<div class="third_line_right">
								<ul>
									<li>
										<span>신고자 아이디</span>
										<span class="span_con">${rdto.reporter}</span>
									</li>
									<li>
										<span>유형</span>
										<span class="span_con">${rdto.category}</span>
									</li>
									<li>
										<span>처리 현황</span>
										<span class="span_con">
											<c:if test="${rdto.pass == 'Y'}">승인</c:if>
											<c:if test="${rdto.pass == 'N'}">대기</c:if>
										</span>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="btn_wrap">
				<div class="btns">
					<c:if test="${rdto.pass == 'N'}">
						<button id="accept">승인</button>
					</c:if>
					<button id="delete">삭제</button>
					<button id="goToList">목록으로</button>
				</div>
			</div>
			<script>
				$('#accept').on('click', function(){
					var conf = confirm('정말 승인하시겠습니까?');
					
					if (conf) {
						var seq = ${rdto.seq};
						var id = '${rdto.id}';
						var category = '${rdto.category}';
						var parent_seq = ${rdto.parent_seq};
						location.href = "/admins/reportUpdate?seq=" + seq + "&id=" + id + "&category=" + category + "&parent_seq=" + parent_seq;
					}
				})
				
				$('#delete').on('click', function(){
					var conf = confirm('정말 삭제하시겠습니까?');
					
					if (conf) {
						var seq = ${rdto.seq};
						location.href = "/admins/deleteBySeq?pageName=reportList&seq=" + seq;
					}
				})
				
				$('#goToList').on('click', function(){
					location.href = "/admins/reportList";
				})
			</script>
		</div>
	</div>
</body>
</html>