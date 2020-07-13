<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
	<div id="main_wrap">
		<div id="view_wrap">
			<c:choose>
				<c:when test="${empty ladto}">
					<div>내용을 불러오는 데 실패하였습니다. 다시 시도해 주세요.</div>
				</c:when>
				<c:otherwise>
					<div class="view_line">
						<div class="first_line">
							${ladto.title}
						</div>
					</div>
					<div class="view_line">
						<div>
							<div class="second_line_left">
								<span>글번호</span>
								<span class="span_con">${ladto.seq}</span>
								<span>강사</span>
								<span class="span_con">${ladto.name}(${ladto.id})</span>
							</div>
							<div class="second_line_right">
								<span>추천수</span>
								<span class="span_con">${ladto.like_count}</span>
								<span>조회수</span>
								<span class="span_con">${ladto.view_count}</span>
								<span>리뷰수</span>
								<span class="span_con">${ladto.review_count}</span>
								<span>평점</span>
								<span class="span_con">${ladto.review_point}</span>
							</div>
						</div>
					</div>
					<div class="view_line">
						<div>
							<div class="third_line_left">
								<ul>
									<li>
										<span>이메일</span>
										<span class="span_con">${ladto.email}</span>
									</li>
									<li>
										<span>전화번호</span>
										<span class="span_con">${ladto.phone_country}${ladto.phone}</span>
									</li>
									<li>
										<span>모집 기간</span>
										<span class="span_con">${ladto.apply_start} ~ ${ladto.apply_end}</span>
									</li>
									<li>
										<span>진행 기간</span>
										<span class="span_con">${ladto.start_date} ~ ${ladto.end_date}</span>
									</li>
									<li>
										<span>진행 시간</span>
										<span class="span_con">${ladto.start_hour}:${ladto.start_minute} ~ ${ladto.end_hour}:${ladto.end_minute}</span>
									</li>
									<li>
										<span>장소</span>
										<span class="span_con">${ladto.location}</span>
									</li>
								</ul>
							</div>
							<div class="third_line_right">
								<ul>
									<li>
										<span>유형</span>
										<span class="span_con">${ladto.category}</span>
									</li>
									<li>
										<span>언어</span>
										<span class="span_con">${ladto.language}</span>
									</li>
									<li>
										<span>가격</span>
										<span class="span_con">${ladto.price}</span>
									</li>
									<li>
										<span>인원</span>
										<span class="span_con">${ladto.cur_num}/${ladto.max_num}</span>
									</li>
									<li>
										<span>모집중</span>
										<span class="span_con">
											<c:if test="${ladto.applying == 'Y'}">O</c:if>
											<c:if test="${ladto.applying == 'N'}">X</c:if>
										</span>
									</li>
									<li>
										<span>진행중</span>
										<span class="span_con">
											<c:if test="${ladto.proceeding == 'Y'}">O</c:if>
											<c:if test="${ladto.proceeding == 'N'}">X</c:if>
										</span>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="view_line">
						<div id="contents">${ladto.curriculum}</div>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="btn_wrap">
				<div class="btns">
					<button id="accept">승인</button>
					<button id="delete">삭제</button>
					<button id="goToList">목록으로</button>
				</div>
			</div>
			<script>
				$('#accept').on('click', function(){
					var conf = confirm('정말 승인하시겠습니까?');
					
					if (conf) {
						var seq = ${ladto.seq};
						location.href = "/admins/lessonPass?seq=" + seq;
					}
				})
				
				$('#delete').on('click', function(){
					var conf = confirm('정말 삭제하시겠습니까?');
					
					if (conf) {
						var seq = ${ladto.seq};
						location.href = "/admins/deleteBySeq?pageName=lessonAppList&seq=" + seq;
					}
				})
				
				$('#goToList').on('click', function(){
					location.href = "/admins/lessonAppList";
				})
			</script>
		</div>
	</div>
</body>
</html>