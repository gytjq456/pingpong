<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/header.jsp" />

<script>
	$(function() {
		$(".view").click(function() {
			var seq = $(this).data("seq");
			$.ajax({
				url : "/correct/correct_list",
				dataType : "json",
				type : "post",
				data : {
					seq : seq
				}
			})
		})
	})
</script>

<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<article id="correct_list" class="inner1200">
			<div class="tit_s1">
				<h2>질문</h2>
				<p>
					언어에 빠진 당신! 고민이 많으시군요. 여기에서 친구들에게 물어봐보세요 <br> 첨삭, 번역질문을 통해 우리 모두 언어 실력을 높히자구요!
				</p>
			</div>
			<div class="btnS1 right">
				<div>
					<a href="/correct/correct_write" class="on">질문등록하기</a>
				</div>
			</div>
			<div id="listStyle1" class="card_body">
				<c:choose>
					<c:when test="${empty list}">
						토론 게시글이 없습니다.
					</c:when>
					<c:otherwise>
						<c:forEach var="i" items="${list}">
							<section data-seq="${i.seq}">
								<a href="/correct/correct_view?seq=${i.seq}" data-seq="${i.seq}"
									class="view">
									<article>
										<div class="title">${i.title}</div>
										<div class="userInfo_s1">
											<div class="thumb">
												<img src="/upload/member/${i.id}/${i.thumNail}" />
											</div>
											<%-- <div class="thumb"><img src="/resources/img/sub/${sessionScope.loginInfo.profile}"/></div> --%>
											<div class="info">
												<p class="userId">${i.writer}</p>
												<p class="writeDate">${i.dateString}</p>
											</div>
										</div>
										<div class="contents">
											<c:choose>
												<c:when test="${fn:length(i.contents) gt 201}">
													<c:out
														value='${fn:substring(i.contents.replaceAll("\\\<.*?\\\>",""), 0, 200)}'>...</c:out>
												</c:when>
												<c:otherwise>
													<c:out value='${i.contents.replaceAll("\\\<.*?\\\>","")}'>
													</c:out>
												</c:otherwise>
											</c:choose>
										</div>
										<div class="sideInfo">
											<div class="countList">
												<ul>
													<li><i class="fa fa-eye"></i> ${i.view_count}</li>
													<li><i class="fa fa-commenting-o" aria-hidden="true"></i>
														${i.reply_count}</li>
												</ul>
											</div>
										</div>
									</article>
								</a>
							</section>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
			<div id="listNav">${navi}</div>
		</article>
	</section>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp" />