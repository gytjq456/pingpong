<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/header.jsp" />

<style>
.profile{width:50px; height:100px;}
</style>
<script>
	$(function() {
		$("#listClick>section").each(
				function() {
					var text = $(this).find(".title").text();
					var seq = $(this).data("seq");
					console.log(seq);
					$(this).children("article").wrap(
							'<a href="/tutor/lessonView?seq=' + seq + '">')
				})
		$("#orderBy").on("change",function(){
			console.log($("#orderBy").val());
			
			var orderbyVal = $("#orderBy").val();
			location.href="/tutor/lessonList?orderBy="+orderbyVal;
		})

		
	})
</script>

<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<article id="lessonList" class="inner1200">

			<div class="tit_s1">
				<h2>강의 목록</h2>
			</div>
			
			<div class="btnS1 right">
				<c:choose>
					<c:when test="${loginInfo.grade == 'tutor' }">
						<p>
							<a href="/tutor/lessonApp" class="on">강의 신청</a>
						</p>
					</c:when>
				</c:choose>
				
			</div>
			<!-- 검색 3가지 -->
			<div class="tab_s1">
				<ul class="clearfix">
					<li class="on"><a href="#;">키워드 검색</a></li>
					<li><a href="#;">달력 검색</a></li>
					<li><a href="#;">지도 검색</a></li>
				</ul>
			</div>

			<div id="tabContWrap">
				<article id="tab_1" class="kewordSch">키워드 검색</article>
				<article id="tab_2" class="calendarSch">달력 검색</article>
				<article id="tab_3" class="mapSch">지도 검색</article>
			</div>

			<!-- 정렬 전체 모집중 진행중 마감 -->
			<div class="btnS1 left">
				<div>
					<button type="button" id="all" class="ing">전체</button>
				</div>
				<div>
					<button type="button" id="applying" class="ing">모집중</button>
				</div>
				<div>
					<button type="button" id="proceeding" class="ing">진행중</button>
				</div>
				<div>
					<button type="button" id="done" class="ing">마감</button>
				</div>
			</div>
			<div>
				<select id="orderBy">
					<option value="seq">최신순</option>
					<option value="view_count">조회순</option>
					<option value="like_count">추천순</option>
					<option value="review_point">평점순</option>
				</select>
			</div>

			<div>
				<c:choose>
					<c:when test="${empty lessonlist}">
						<div class="row">
							<div class='col-12'>강의가 없습니다.</div>
						</div>
					</c:when>
					<c:otherwise>
						<div id="listClick">
							<c:forEach var="i" items="${lessonlist}">
								<section data-seq="${i.seq}">
									<article>
										<div class="profile">
											<img src="/upload/member/${i.id}/${i.sysname}">
										</div>
										<div class="title">${i.title}</div>
										<div class="language">언어 : ${i.language}</div>
										<div class="price">
											가격 : ${i.price}
											<!-- <span class="badge badge-danger">New</span> -->
										</div>
										<div class="view_count">조회 : ${i.view_count}</div>
										<div class="like_count">좋아요 : ${i.like_count}</div>
										<div class="review_point">리뷰 평점 : ${i.review_point}</div>
										<div class="review_count">리뷰 갯수 : ${i.review_count}</div>
										<br>
									</article>
								</section>
							</c:forEach>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
			
			<div>
				<div class="navi">${navi}</div>
			</div>
		</article>
	</section>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp" />