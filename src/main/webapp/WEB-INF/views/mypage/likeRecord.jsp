<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<jsp:include page="/WEB-INF/views/header.jsp"/>
	
	<script>
	
	</script>

	<br><br><br><br><br><br><br><br><br><br><br><br><br>
	
	<article id="management">
		<h2>찜관리</h2>
		<section class="likeRecord">
			<div class="subContents">
				<div class="session">		
					<h4>찜한 파트너 리스트</h4>
					<c:choose>
						<c:when test="${empty plist }">
							찜한 파트너가 없습니다.
						</c:when>
						<c:otherwise>
							<c:forEach var="plist" items="${plist}">	
								<table>
								<tr>
									<td>글번호:${plist.seq}</td>
									<td><a href="/partner/partnerView?seq=${pdto.seq}">이름:${plist.name}</a></td>
									<td>나이:${plist.age}</td>
									<td>성별:${plist.gender}</td>
									<td>구사가능한언어:${plist.lang_can}</td>
									<td>배우고싶은언어:${plist.lang_learn}</td>
									<td>거주지:${plist.address}</td>
									<td>취미:${plist.hobby}</td>
									<td>평점:${plist.review_point}</td>
								</tr>
							</table>
					</c:forEach>
						</c:otherwise>
					</c:choose>
					
				</div>
			</div>
		</section>
		
		<section class="likeRecord">
			<div class="subContents">
				<div class="session">		
					<h4>찜한 그룹 리스트</h4>
					<c:choose>
						<c:when test="${empty glist }">
							찜한 그룹이 없습니다.
						</c:when>
						<c:otherwise>
							<c:forEach var="glist" items="${glist}">	
								<table>
								<tr>
									<td>글번호:${glist.seq}</td>
									<td>제목:${glist.title}</td>
									<td>성격:</td>
									<td>최대인원(현재인원/최대인원):${glist.cur_num}/${glist.max_num}</td>
									<td>만남장소:${glist.location}</td>
									<td>조회수:${glist.view_count}</td>
									<td>추천수:${glist.like_count}</td>
									<td>신청수:${glist.app_count}</td>
									<td>리뷰수:${glist.review_count}</td>
									<td>평점:${glist.review_point}</td>
									<td><a href="#;">신청서보기:${glist.applying}</a></td>
								</tr>
							</table>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</section>
		
		<section class="likeRecord">
			<div class="subContents">
				<div class="session">		
					<h4>찜한 튜터 리스트</h4>
					<c:choose>
						<c:when test="${empty tlist }">
							찜한 튜터가 없습니다.
						</c:when>
						<c:otherwise>
							<c:forEach var="tlist" items="${tlist}">	
								<table>
									<tr>
										<td>이름:${tlist.name}</td>
										<td>이메일:${tlist.email}</td>
										<td>전화번호:010${tlist.phone}</td>
										<td>가르치는 언어:${tlist.language}</td>
										<td>추천수:${tlist.like_count}</td>
										<td>리뷰수:${tlist.review_count}</td>
										<td>평점:${tlist.review_point}</td>
									</tr>
								</table>	
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</section>
	</article>
<jsp:include page="/WEB-INF/views/footer.jsp"/>