<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<div id="view_wrap">
			<c:choose>
				<c:when test="${empty gdto}">
					<div>내용을 불러오는 데 실패하였습니다. 다시 시도해 주세요.</div>
				</c:when>
				<c:otherwise>
					<div class="view_line">
						<div class="first_line">
							${gdto.title}
						</div>
					</div>
					<div class="view_line">
						<div>
							<div class="second_line_left">
								<span>글번호</span>
								<span class="span_con">${gdto.seq}</span>
								<span>작성자</span>
								<span class="span_con">${gdto.writer_name}(${gdto.writer_id})</span>
								<span>작성일</span>
								<span class="span_con">${fn:substring(gdto.write_date, 0, 10)}</span>
							</div>
							<div class="second_line_right">
								<span>조회수</span>
								<span class="span_con">${gdto.view_count}</span>
								<span>추천수</span>
								<span class="span_con">${gdto.like_count}</span>
								<span>신청수</span>
								<span class="span_con">${gdto.app_count}</span>
								<span>리뷰수</span>
								<span class="span_con">${gdto.review_count}</span>
								<span>평점</span>
								<span class="span_con">${gdto.review_point}</span>
							</div>
						</div>
					</div>
					<div class="view_line">
						<div>
							<div class="third_line_left">
								<ul>
									<li>
										<span>유형</span>
										<span class="span_con">${gdto.hobby_type}</span>
									</li>
									<li>
										<span>모집 기간</span>
										<span class="span_con">${gdto.apply_start} ~ ${gdto.apply_end}</span>
									</li>
									<li>
										<span>진행 기간</span>
										<span class="span_con">${gdto.start_date} ~ ${gdto.end_date}</span>
									</li>
									<li>
										<span>인원</span>
										<span class="span_con">${gdto.cur_num}/${gdto.max_num}</span>
									</li>
								</ul>
							</div>
							<div class="third_line_right">
								<ul>
									<li>
										<span>기간 유형</span>
										<span class="span_con">${gdto.period}</span>
									</li>
									<li>
										<span>모집중</span>
										<span class="span_con">
											<c:if test="${gdto.applying == 'Y'}">O</c:if>
											<c:if test="${gdto.applying == 'N'}">X</c:if>
										</span>
									</li>
									<li>
										<span>진행중</span>
										<span class="span_con">
											<c:if test="${gdto.proceeding == 'Y'}">O</c:if>
											<c:if test="${gdto.proceeding == 'N'}">X</c:if>
										</span>
									</li>
									<li>
										<span>장소</span>
										<span class="span_con">${gdto.location}</span>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="view_line">
						<div id="contents">${gdto.contents}</div>
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
						var seq = ${gdto.seq};
						location.href = "/admins/deleteBySeq?pageName=groupList&seq=" + seq;
					}
				})
				
				$('#goToList').on('click', function(){
					location.href = "/admins/groupList";
				})
			</script>
		</div>
	</div>
</body>
</html>