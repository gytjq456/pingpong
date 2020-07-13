<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<div id="view_wrap">
			<c:choose>
				<c:when test="${empty ldto}">
					<div>내용을 불러오는 데 실패하였습니다. 다시 시도해 주세요.</div>
				</c:when>
				<c:otherwise>
					<div class="view_line">
						<div class="first_line">
							${ldto.title}
						</div>
					</div>
					<div class="view_line">
						<div>
							<div class="second_line_left">
								<span>글번호</span>
								<span class="span_con">${ldto.seq}</span>
								<span>강사</span>
								<span class="span_con">${ldto.name}(${ldto.id})</span>
							</div>
							<div class="second_line_right">
								<span>추천수</span>
								<span class="span_con">${ldto.like_count}</span>
								<span>조회수</span>
								<span class="span_con">${ldto.view_count}</span>
								<span>리뷰수</span>
								<span class="span_con">${ldto.review_count}</span>
								<span>평점</span>
								<span class="span_con">${ldto.review_point}</span>
							</div>
						</div>
					</div>
					<div class="view_line">
						<div>
							<div class="third_line_left">
								<ul>
									<li>
										<span>이메일</span>
										<span class="span_con">${ldto.email}</span>
									</li>
									<li>
										<span>전화번호</span>
										<span class="span_con">(${ldto.phone_country})${ldto.phone}</span>
									</li>
									<li>
										<span>모집 기간</span>
										<span class="span_con">${ldto.apply_start} ~ ${ldto.apply_end}</span>
									</li>
									<li>
										<span>진행 기간</span>
										<span class="span_con">${ldto.start_date} ~ ${ldto.end_date}</span>
									</li>
									<li>
										<span>진행 시간</span>
										<span class="span_con">${ldto.start_hour}:${ldto.start_minute} ~ ${ldto.end_hour}:${ldto.end_minute}</span>
									</li>
									<li>
										<span>인원</span>
										<span class="span_con">${ldto.cur_num}/${ldto.max_num}</span>
									</li>
								</ul>
							</div>
							<div class="third_line_right">
								<ul>
									<li>
										<span>유형</span>
										<span class="span_con">${ldto.category}</span>
									</li>
									<li>
										<span>가격</span>
										<span class="span_con">${ldto.price}</span>
									</li>
									<li>
										<span>언어</span>
										<span class="span_con">${ldto.language}</span>
									</li>
									<li>
										<span>모집중</span>
										<span class="span_con">
											<c:if test="${ldto.applying == 'Y'}">○</c:if>
											<c:if test="${ldto.applying == 'N'}">Ｘ</c:if>
										</span>
									</li>
									<li>
										<span>진행중</span>
										<span class="span_con">
											<c:if test="${ldto.proceeding == 'Y'}">○</c:if>
											<c:if test="${ldto.proceeding == 'N'}">Ｘ</c:if>
										</span>
									</li>
									<li>
										<span>장소</span>
										<span class="span_con">${ldto.location}</span>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="view_line">
						<div id="contents">${ldto.curriculum}</div>
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
						var seq = ${ldto.seq};
						location.href = "/admins/deleteBySeq?pageName=lessonList&seq=" + seq;
					}
				})
				
				$('#goToList').on('click', function(){
					location.href = "/admins/lessonList";
				})
			</script>
		</div>
	</div>
</body>
</html>