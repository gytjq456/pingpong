<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<style>
	div{width: 300px; border-bottom: 1px solid #ccc;}
</style>
</head>
<body>
	<c:choose>
		<c:when test="${empty glist}">
			등록된 게시글이 없습니다.
		</c:when>
		<c:otherwise>
			<div class="type">
				진행: 
				<button type="button" id="all" class="ing">전체</button>
				<button type="button" id="applying" class="ing">모집중</button>
				<button type="button" id="proceeding" class="ing">진행중</button>
				<button type="button" id="done" class="ing">마감</button>
			</div>
			<div class="order">
				순서: 
				<button type="button" id="seq" class="orderBy">최신순</button>
				<button type="button" id="view_count" class="orderBy">조회순</button>
				<button type="button" id="like_count" class="orderBy">추천순</button>
				<button type="button" id="app_count" class="orderBy">인기순</button>
				<button type="button" id="review_point" class="orderBy">평점순</button>
			</div>
			<c:forEach var="glist" items="${glist}">
				<a href="/group/beforeView?seq=${glist.seq}">
					<div>
						글번호: ${glist.seq}<br>
						작성자: ${glist.writer}<br>
						제목: ${glist.title}<br>
						유형: ${glist.hobby_type}<br>
						모집 기간: ${glist.apply_start} ~ ${glist.apply_end}<br>
						진행 기간: ${glist.start_date} ~ ${glist.end_date}<br>
						평점: ★ ${glist.review_point}<br>
						조회 ${glist.view_count}  추천 ${glist.like_count}  리뷰 ${glist.review_count}<br>
						<c:if test="${glist.applying == 'Y'}">
							모집중  
						</c:if>
						<c:if test="${glist.proceeding == 'Y'}">
							진행중
						</c:if>
						<c:if test="${glist.proceeding == 'N' && glist.applying == 'N'}">
							마감
						</c:if>
					</div>
				</a>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<div class="navi">${navi}</div>
	<a href="/group/write">그룹 등록하기</a>
	<script>
		$('.orderBy').on('click', function(){
			var orderBy = $(this).attr('id');
			var ingCount = $('.ing').length;
			var ing = [];
			
			for (var i = 0; i < ingCount; i++) {
				ing[i] = $($('.ing')[i]).attr('id');
			}
			
			console.log(ing)
			
			//location.href = '/group/main?orderBy=' + orderBy + '&ing=' + ing;
		})
		
		$('.ing').on('click', function(){
			var ing = $(this).attr('id');
			location.href = '/group/main?orderBy=seq&ing=' + ing;
		})
	</script>
</body>
</html>