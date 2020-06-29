<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/header.jsp"/>
<<<<<<< HEAD

	<div id="subWrap" class="hdMargin">
		<section id="subContents">
			<article id="group_view" class="inner1200 clearfix">
	
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
			
			</article>
		</section>
	</div>		
	
=======
<div id="subWrap" class="hdMargin">
		<section id="subContents">
			<article id="group_list" class="inner1200">
				<div class="tit_s1">
					<h2>Group</h2>
					<p>다양한 사람들을 원하시나요?<br>관심사가 비슷한 사람들과 함께 소통해 보세요.</p>
				</div>
				<div class="group_search_box">
					<div class="search_as_keyword">
						<select id="keyword_type">
							<option>작성자</option>
							<option>글제목</option>
							<option>글내용</option>
						</select>
						<input type="text" name="keyword" id="keyword_input" placeholder="검색어를 입력하세요.">
						<div>
							<span>유형</span>
							<c:forEach var="hbdto" items="${hblist}">
								<input type="checkbox" name="hobby" class="hobby_list" id="${hbdto.seq}" value="${hbdto.hobby}"><label for="${hbdto.seq}">${hbdto.hobby}</label>
							</c:forEach>
							<input type="text" id="selected_hobby" name="hobby_type">
						</div>
						<div>
							<span>기간</span>
							<input type="radio" name="period" class="period" id="short_period" value="short_period">
							<label for="short_period">단기(1년 미만)</label>
							<input type="radio" name="period" class="period" id="long_period" value="long_period">
							<label for="long_period">장기(1년 이상)</label>
						</div>
						<button type="button" id="searchAsKeyword">이 조건으로 검색</button>
					</div>
				</div>
				<div class="btnS1 left">
					<div><button type="button" id="all" class="ing">전체</button></div>
					<div><button type="button" id="applying" class="ing">모집중</button></div>
					<div><button type="button" id="proceeding" class="ing">진행중</button></div>
					<div><button type="button" id="done" class="ing">마감</button></div>
				</div>
				<div class="btnS1 right">
					<div><button type="button" id="seq" class="orderBy">최신순</button></div>
					<div><button type="button" id="view_count" class="orderBy">조회순</button></div>
					<div><button type="button" id="like_count" class="orderBy">추천순</button></div>
					<div><button type="button" id="app_count" class="orderBy">인기순</button></div>
					<div><button type="button" id="review_point" class="orderBy">평점순</button></div>
				</div>
				<div id="listStyle1" class="card_body">
					<c:choose>
						<c:when test="${empty glist}">
							등록된 게시글이 없습니다.
						</c:when>
						<c:otherwise>
							<c:forEach var="glist" items="${glist}">
								<a href="/group/beforeView?seq=${glist.seq}">
									<div class="group_each_wrapper">
										<div><span class="sub_title">작성자</span> ${glist.writer}</div>
										<div><span class="sub_title">제목</span> ${glist.title}</div>
										<div><span class="sub_title">유형</span> ${glist.hobby_type}</div>
										<div><span class="sub_title">모집 기간</span> ${glist.apply_start} ~ ${glist.apply_end}</div>
										<div><span class="sub_title">진행 기간</span> ${glist.start_date} ~ ${glist.end_date}</div>
										<div><span class="sub_title">평점</span> ★ ${glist.review_point}</div>
										<div>
											<span class="sub_title">조회</span> ${glist.view_count}  
											<span class="sub_title">추천</span> ${glist.like_count}  
											<span class="sub_title">리뷰</span> ${glist.review_count}
										</div>
										<c:if test="${glist.applying == 'Y'}">
											<span>모집중</span>  
										</c:if>
										<c:if test="${glist.proceeding == 'Y'}">
											<span>진행중</span>
										</c:if>
										<c:if test="${glist.proceeding == 'N' && glist.applying == 'N'}">
											<span>마감</span>
										</c:if>
									</div>
								</a>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					<div class="navi">${navi}</div>
					<a href="/group/write">그룹 등록하기</a>
				</div>
			</article>
		</section>
	</div>
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
		
		$('#searchAsKeyword').on('click', function(){
			var keywordType = null;
			var keywordInput = null;
			
			if ($('#keyword_input').val() != null) {
				keywordType = $('#keyword_type option:selected').val();
				keywordInput = $('#keyword_input').val();
				
				if (keywordType == '작성자') {
					keywordType = 'writer';
				} else if (keywordType == '글내용') {
					keywordType = 'contents';
				} else if (keywordType == '글제목') {
					keywordType = 'title'
				}
				
				var selectedHobbyListCount = $('.hobby_list:checked').length;
				var selectedHobbyList = [];
				
				for (var i = 0; i < selectedHobbyListCount; i++) {
					selectedHobbyList.push($($('.hobby_list:checked')[i]).val());
				}
				
				$('#selected_hobby').val(selectedHobbyList);
				
				var hobby_type = $('#selected_hobby').val();
				
				location.href = "/group/search?searchType=" + keywordType + "&searchThing=" + keywordInput + "&orderBy=seq&hobby_type=" + hobby_type;
			}
		})
	</script>
>>>>>>> 32fee040fced899526abfd0de3c0ec92a6db14e9
<jsp:include page="/WEB-INF/views/footer.jsp"/>