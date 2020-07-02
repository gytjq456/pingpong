<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<jsp:include page="/WEB-INF/views/header.jsp"/>
	
	<script>
	
	</script>
	
	<br><br><br><br><br><br><br><br><br><br><br><br><br>
	<h2>그룹 관리</h2>
	<div class="groupLeader">
		<section id="subContents">
			<div id="session">		
				<h4>주선자</h4>
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
			</div>
		</section>
	</div>	
	
	<br><hr><br>
	
	<h1>그룹원</h1>
	<div class="groupMember">
		<section id="subContents">
			<div id="session">		
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
			</div>
		</section>
	</div>		
					
		

<jsp:include page="/WEB-INF/views/footer.jsp"/>