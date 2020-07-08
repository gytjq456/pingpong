<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<jsp:include page="/WEB-INF/views/header.jsp"/>
	
	<br><br><br><br><br><br><br><br><br><br><br><br><br>
	
	<article id="management">
		<h2>나의 강의목록</h2>
		<section class="tuteeRecord">
			<div class="subContents">
				<div class="session">		
					<h4>강의목록</h4>
					<c:choose>
						<c:when test="${empty telist}">
							등록된 강의기록이 없습니다.
						</c:when>
						<c:otherwise>
						
							<c:forEach var="telist" items="${telist}">	
								<table>
									<tr>
										<td>강의번호:${telist.seq}</td>
										<td><a href="#;">${telist.title}</a></td>
										<td><a href="#;">튜터명:${telist.name}</a></td>
										<td>언어:${telist.language}</td>
										<td>커리큘럼:${telist.curriculum}</td>
										<td>강의 기간:${telist.start_date}~${telist.end_date}</td>
										<td>최대인원(현재인원/최대인원):${telist.cur_num}/${telist.max_num}</td>
										<td>만남장소:${telist.location}</td>
										<td>추천수:${trlist.like_count}</td>
										<td>리뷰수:${trlist.review_count}</td>
										<td>평점:${trlist.review_point}</td>
										
										<a href="/payments/cancle?parent_seq=${ldto.seq }&start_date=${ldto.start_date }&price=${ldto.price }">test환불</a>
										<input type="button" value="삭제" onclick="SomeDeleteRowFunction()">
									</tr>
								</table>
								
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</section>
	</article>
	<script>
		function SomeDeleteRowFunction(){
			$('table').on("click",'input[type=button]',function(e){
				$(this).closest('tr').remove()
			})
		}
	</script>
	
<jsp:include page="/WEB-INF/views/footer.jsp"/>