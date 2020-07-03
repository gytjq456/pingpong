<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<jsp:include page="/WEB-INF/views/header.jsp"/>
	
<style>
	table{border: 1px solid black;}
</style>
	
	<br><br><br><br><br><br><br><br><br><br><br><br><br>
	<h2>그룹 관리</h2>
	<div class="groupLeader">
		<section id="subContents">
			<div id="session">		
				<h4>주선자</h4>
				<c:choose>
					<c:when test="${empty gl_list}">
					 	주선자로서의 기록이 존재하지 않습니다.
					</c:when>
					<c:otherwise>
						<c:forEach var="gl_list" items="${gl_list}">	
							<table>
								<tr>
									<td>글번호:${gl_list.seq}</td>
									<td>제목:${gl_list.title}</td>
									<td>성격:</td>
									<td>최대인원(현재인원/최대인원):${gl_list.cur_num}/${gl_list.max_num}</td>
									<td>만남장소:${glist.location}</td>
									<td>조회수:${gl_list.view_count}</td>
									<td>추천수:${gl_list.like_count}</td>
									<td>신청수:${gl_list.app_count}</td>
									<td>리뷰수:${gl_list.review_count}</td>
									<td>평점:${gl_list.review_point}</td>
									<td><a href="#;">신청서보기:${gl_list.applying}</a></td>
								</tr>
							</table>
						</c:forEach>
					</c:otherwise>			
				</c:choose>				
			</div>
		</section>
	</div>	
	
	<br><hr><br>
	
	<h1>그룹원</h1>
	<div class="groupMember">
		<section id="subContents">
			<div id="session">		
				<c:forEach var="gm_list" items="${gm_list}">	
					<table>
						<tr>
							<td>글번호:${gm_list.seq}</td>
							<td>제목:${gm_list.title}</td>
							<td>성격:</td>
							<td>최대인원(현재인원/최대인원):${gm_list.cur_num}/${gm_list.max_num}</td>
							<td>만남장소:${gm_list.location}</td>
							<td>조회수:${gm_list.view_count}</td>
							<td>추천수:${gm_list.like_count}</td>
							<td>신청수:${gm_list.app_count}</td>
							<td>리뷰수:${gm_list.review_count}</td>
							<td>평점:${gm_list.review_point}</td>
							<td><a href="#;">신청서보기:${gm_list.applying}</a></td>
						</tr>
					</table>
				</c:forEach>
			</div>
		</section>
	</div>	
					
		

<jsp:include page="/WEB-INF/views/footer.jsp"/>