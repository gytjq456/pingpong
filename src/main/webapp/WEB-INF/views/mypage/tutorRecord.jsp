<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<jsp:include page="/WEB-INF/views/header.jsp"/>
	
	<script>
	
	</script>
	
	<br><br><br><br><br><br><br><br><br><br><br><br><br>
	
	<article id="management">
		<h2>튜터/튜티관리</h2>
		<section class="tutorRecord">
			<div class="subContents">
				<div class="session">		
					<h4>튜터인 경우</h4>
					<c:choose>
						<c:when test="${empty trlist }">
							튜터로서의 기록이 존재하지 않습니다.
						</c:when>
						<c:otherwise>						
							<c:forEach var="trlist" items="${trlist}">	
								<table>
									<tr>
										<td>강의번호:${trlist.class_num}</td>
										<td><a href="#;">강의명:${trlist.class_name}</a></td>
										<td>언어:${trlist.lang_can}</td>
										<td>강의 기간:없음</td>
										<td>인원(현재인원/최대인원):${trlist.cur_num}/${trlist.max_num}</td>
										<td>만남장소:${trlist.address}</td>
										<td>추천수:${trlist.like_count}</td>
										<td>리뷰수:${trlist.review_count}</td>
										<td>평점:${trlist.review_point}</td>
									</tr>
								</table>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</section>
		
		<section class="tuteeRecord">
			<div class="subContents">
				<div class="session">		
					<h4>튜티</h4>
					<c:choose>
						<c:when test="${empty telist}">
							튜티로서의 기록이 존재하지 않습니다.
						</c:when>
						<c:otherwise>
						
							<c:forEach var="telist" items="${telist}">	
								<table>
									<tr>
										<td>강의번호:${telist.seq}</td>
										<td><a href="#;">강의명:없음</a></td>
										<td><a href="#;">튜터명:튜티명은 tuteeApp참조</a></td>
										<td>언어:${trlist.lang_can}</td>
										<td>강의 기간:없음</td>
										<td>최대인원(현재인원/최대인원):${trlist.cur_num}/${trlist.max_num}</td>
										<td>만남장소:없음</td>
										<td>추천수:${trlist.like_count}</td>
										<td>리뷰수:${trlist.review_count}</td>
										<td>평점:${trlist.review_point}</td>
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