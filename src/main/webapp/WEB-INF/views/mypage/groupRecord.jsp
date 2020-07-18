<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/header.jsp" />
<style>
.app_list {
	display: none;
}
</style>
<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<article id="groupManage" class="inner1200">
			<div class="tit_s1">
				<h2>그룹 관리</h2>
			</div>
			<div class="groupWrap">
				<section id="my_group_manage" class="card_body">
					<div class="cate">주선자</div>
					<div class="title_wrap">
						<div class="my_seq">글번호</div>
						<div class="my_title">제목</div>
						<div class="my_num">인원</div>
						<div class="my_loc">장소</div>
						<div class="my_date">등록일</div>
						<div class="my_app">신청</div>
					</div>
					<c:choose>
						<c:when test="${empty gl_list}">
							<div>
								<div class="show_app">주선자로서의 기록이 존재하지 않습니다.</div>
							</div>
						</c:when>
						<c:otherwise>
							<c:forEach var="gl_list" items="${gl_list}">
								<div class="option_wrap">
									<div class="my_seq">${gl_list.seq}</div>
									<div class="my_title">
										<a href="/group/beforeView?seq=${gl_list.seq}">${gl_list.title}</a>
									</div>
									<div class="my_num">${gl_list.cur_num}/${gl_list.max_num}</div>
									<div class="my_loc">${gl_list.location}</div>
									<div class="my_date">${fn:substring(gl_list.write_date, 0, 10)}</div>
									<div class="my_app">
										<button class="all_app">${gl_list.app_count}</button>
									</div>
								</div>
								<div class="app_list">
									<div class="title_wrap">
										<div class="app_seq">글번호</div>
										<div class="app_name">이름(아이디)</div>
										<div class="app_age">나이</div>
										<div class="app_gender">성별</div>
										<div class="app_lang_can">구사 언어</div>
										<div class="app_lang_learn">학습 언어</div>
										<div class="app_accept">신청서</div>
									</div>
									<div>
										<c:choose>
											<c:when test="${!empty gla_list}">
												<c:forEach var="gla_list" items="${gla_list}">
													<c:choose>
														<c:when test="${gla_list.parent_seq == gl_list.seq}">
															<div class="option_wrap" id="${gla_list.seq}">
																<div class="app_seq">${gla_list.seq}</div>
																<div class="app_name">${gla_list.name}(${gla_list.id})</div>
																<div class="app_age">${gla_list.age}</div>
																<div class="app_gender">${gla_list.gender}</div>
																<div class="app_lang_can">${gla_list.lang_can}</div>
																<div class="app_lang_learn">${gla_list.lang_learn}</div>
																<div class="app_accept">
																	<button class="app_accpet_btn">보기</button>
																</div>
															</div>
														</c:when>
														<c:otherwise>
																<c:if test="${gl_list.app_count == 0}">
																	아직 신청한 사람이 없습니다.
																</c:if>
																<c:if test="${gl_list.app_count != 0}">
																	모든 신청서를 확인하셨습니다.
																</c:if>
														</c:otherwise>
													</c:choose>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${gl_list.app_count != 0}">
														모든 신청서를 확인하셨습니다.
													</c:when>
													<c:otherwise>
														아직 신청한 사람이 없습니다.
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					<div class="navi_line">${lnavi}</div>
				</section>
				<section id="group_manage" class="card_body">
					<div class="cate">그룹원</div>
					<div class="title_wrap">
						<div class="mem_seq">글번호</div>
						<div class="mem_title">제목</div>
						<div class="mem_num">인원</div>
						<div class="mem_loc">장소</div>
						<div class="mem_leader">주선자</div>
						<div class="mem_proceeding">진행</div>
					</div>
					<c:choose>
						<c:when test="${empty gm_list}">
							<div class="show_app">그룹 멤버로서 기록이 존재하지 않습니다.</div>
						</c:when>
						<c:otherwise>
							<c:forEach var="gm_list" items="${gm_list}">
										<div class="option_wrap">
											<div class="mem_seq">${gm_list.seq}</div>
											<div class="mem_title">
												<a href="/group/beforeView?seq=${gm_list.seq}">${gm_list.title}</a>
											</div>
											<div class="mem_num">${gm_list.cur_num}/${gm_list.max_num}</div>
											<div class="mem_loc">${gm_list.location}</div>
											<div class="mem_leader">${gm_list.writer_name}(${gm_list.writer_id})</div>
											<div class="mem_proceeding">
												<c:if test="${gm_list.proceeding == 'Y'}">진행중</c:if>
												<c:if test="${gm_list.proceeding == 'B'}">준비중</c:if>
												<c:if test="${gm_list.proceeding == 'N'}">종료</c:if>
											</div>
										</div>
									</c:forEach>
						</c:otherwise>
					</c:choose>
					<div class="navi_line">${mnavi}</div>
				</section>
			</div>
		</article>
	</section>
</div>
<script>
	$('.all_app').on('click', function() {
		if ($(this).closest('.option_wrap').next().css('display') == 'none') {
			var myGroupCount = $('.app_list').length;
	
			for (var i = 0; i < myGroupCount; i++) {
				$($('.app_list')[i]).hide();
			}
	
			$(this).closest('.option_wrap').next().show();
		} else {
			$(this).closest('.option_wrap').next().hide();
		}
	})
</script>
<jsp:include page="/WEB-INF/views/mypage/groupApp.jsp" />
<jsp:include page="/WEB-INF/views/footer.jsp" />