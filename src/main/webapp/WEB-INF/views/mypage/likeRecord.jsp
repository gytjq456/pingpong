<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 

<jsp:include page="/WEB-INF/views/header.jsp"/>

<style>
	#jjimManage .listWrap h4 span { color: #999; display: block; margin-top: 10px; font-size: 14px; font-weight: 400; }
</style>

<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<article id="jjimManage" class="inner1200">
			<div class="tit_s1">
				<h2>찜 관리</h2>
			</div>
			<div class="listWrap">
				<section class="session card_body">		
					<h4>
						찜한 파트너 리스트
						<span class="under_h4">* 파트너 이름을 누르면 해당 파트너 뷰 페이지로 이동합니다.</span>
					</h4>
					<c:choose>
						<c:when test="${empty plist }">
							<p>찜한 파트너가 없습니다.<p>
						</c:when>
						<c:otherwise>
						<div class="tableWrap">
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
						</div>
						</c:otherwise>
					</c:choose>
					<div class="navi_line">${pnavi}</div>
				</section>
				
				<section class="session card_body">	
				
					<h4>
						찜한 그룹 리스트
						<span class="under_h4">* 그룹명을 누르면 해당 그룹 뷰 페이지로 이동합니다.</span>
					</h4>
					
						<c:choose>
							<c:when test="${empty glist }">
								찜한 그룹이 없습니다.
							</c:when>
							<c:otherwise>
								<div class="tableWrap">
									<table>
										<thead>
											<tr>
												<th>번호</th>
												<th>제목</th>
												<th>주선자</th>
												<th>성격</th>
												<th>인원</th>
												<th>장소</th>
												<th>모집중</th>
												<th>진행중</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="glist" items="${glist}">	
											<tr>
												<td>${glist.seq}</td>
												<td><a href="/group/beforeView?seq=${glist.seq}">${glist.title}</a></td>
												<td>${glist.writer_name}(${glist.writer_id})</td>
												<td>${glist.hobby_type}</td>
												<td>${glist.cur_num}/${glist.max_num}</td>
												<td>${glist.location}</td>
												<td>
													<c:if test="${glist.applying == 'Y'}">모집중</c:if>
													<c:if test="${glist.applying == 'N'}">마감</c:if>
												</td>
												<td>
													<c:if test="${glist.proceeding == 'Y'}">진행중</c:if>
													<c:if test="${glist.proceeding == 'B'}">준비중</c:if>
													<c:if test="${glist.proceeding == 'N'}">종료</c:if>
												</td>
											</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</c:otherwise>
						</c:choose>
						<div class="navi_line">${gnavi}</div>
				</section>
				<section class="session card_body">	
					<h4>
						찜한 강의 리스트
						<span class="under_h4">* 강의 제목을 누르면 해당 강의 뷰 페이지로 이동합니다.</span>
					</h4>
					<c:choose>
						<c:when test="${empty llist }">
							찜한 강의가 없습니다.
						</c:when>
						<c:otherwise>
							<div class="tableWrap">
								<table>
									<thead>
										<tr>
											<th>강의 코드</th>
											<th>제목</th>
											<th>가격</th>
											<th>강사</th>
											<th>언어</th>
											<th>장소</th>
											<th>시간</th>
											<th>수업 기간</th>
											<th>모집중</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="llist" items="${llist}">	
										<tr>
											<td>${llist.seq}</td>
											<td><a href="/tutor/lessonView?seq=${llist.seq}">${llist.title}</a></td>
											<td>${llist.price}</td>
											<td>${llist.name}(${llist.id})</td>
											<td>${llist.language}</td>
											<td>${llist.location}</td>
											<td>${llist.start_hour}:${llist.start_minute} ~ ${llist.end_hour}:${llist.end_minute}</td>
											<td>${llist.start_date} ~ ${llist.end_date}</td>
											<td>
												<c:if test="${llist.applying == 'Y'}">모집중</c:if>
												<c:if test="${llist.applying == 'N'}">마감</c:if>
											</td>
										</tr>
										</c:forEach>
									</tbody>
								</table>	
							</div>
						</c:otherwise>
					</c:choose>
					<div class="navi_line">${lnavi}</div>
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