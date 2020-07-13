<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<jsp:include page="/WEB-INF/views/header.jsp"/>

<style>
	
</style>

<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<article id="jjimManage" class="inner1200">
			<div class="tit_s1">
				<h2>찜 관리</h2>
			</div>
			<div class="listWrap">
				<section class="session card_body">		
					<h4>찜한 파트너 리스트</h4>
					<c:choose>
						<c:when test="${empty plist }">
							<p>찜한 파트너가 없습니다.<p>
						</c:when>
						<c:otherwise>
								<table>
								<thead>
									<tr>
										<th>번호</th>
										<th>이름</th>
										<th>나이</th>
										<th>성별</th>
										<th>구사 언어</th>
										<th>배울 언어</th>
										<th>지역</th>
										<th>취미</th>
										<th>평점</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="plist" items="${plist}">	
									<tr>
										<td>${plist.seq}</td>
										<td><a href="/partner/partnerView?seq=${pdto.seq}">${plist.name}</a></td>
										<td>${plist.age}</td>
										<td>${plist.gender}</td>
										<td>${plist.lang_can}</td>
										<td>${plist.lang_learn}</td>
										<td>${plist.address}</td>
										<td>${plist.hobby}</td>
										<td>${plist.review_point}</td>
									</tr>
									</c:forEach>
								</tbody>
							</table>
						</c:otherwise>
					</c:choose>
				</section>
				
				<section class="session card_body">	
				
					<h4>찜한 그룹 리스트</h4>
						<c:choose>
							<c:when test="${empty glist }">
								찜한 그룹이 없습니다.
							</c:when>
							<c:otherwise>
									<table>
										<thead>
											<tr>
												<th>번호</th>
												<th>제목</th>
												<th>성격</th>
												<th>인원</th>
												<th>장소</th>
												<th>조회</th>
												<th>추천</th>
												<th>신청</th>
												<th>리뷰</th>
												<th>평점</th>
												<!-- <th>보기</th> -->
											</tr>
										</thead>
										<tbody>
											<c:forEach var="glist" items="${glist}">	
											<tr>
												<td>${glist.seq}</td>
												<td>${glist.title}</td>
												<td></td>
												<td>${glist.cur_num}/${glist.max_num}</td>
												<td>${glist.location}</td>
												<td>${glist.view_count}</td>
												<td>${glist.like_count}</td>
												<td>${glist.app_count}</td>
												<td>${glist.review_count}</td>
												<td>${glist.review_point}</td>
												<%-- <td><a href="#;">${glist.applying}</a></td> --%>
											</tr>
											</c:forEach>
										</tbody>
									</table>
							</c:otherwise>
						</c:choose>	
				</section>
				<section class="session card_body">	
					<h4>찜한 튜터 리스트</h4>
					<c:choose>
						<c:when test="${empty tlist }">
							찜한 튜터가 없습니다.
						</c:when>
						<c:otherwise>
								<table>
									<thead>
										<tr>
											<th>이름</th>
											<th>이메일</th>
											<th>전화번호</th>
											<th>언어</th>
											<th>추천</th>
											<th>리뷰</th>
											<th>평점</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="tlist" items="${tlist}">	
										<tr>
											<td>${tlist.name}</td>
											<td>${tlist.email}</td>
											<td>${tlist.phone_country}${tlist.phone}</td>
											<td>${tlist.language}</td>
											<td>${tlist.like_count}</td>
											<td>${tlist.review_count}</td>
											<td>${tlist.review_point}</td>
										</tr>
										</c:forEach>
									</tbody>
								</table>	
						</c:otherwise>
					</c:choose>
				</section>
			</div>
		</article>
	</section>
</div>
	
	<article id="management">
		
		
		<section class="likeRecord">
			<div class="subContents">
				<div class="session">		
					
				</div>
			</div>
		</section>
		
		<section class="likeRecord">
			<div class="subContents">
				<div class="session">		
					
				</div>
			</div>
		</section>
	</article>
<jsp:include page="/WEB-INF/views/footer.jsp"/>