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
					<c:forEach var="llist" items="${llist}">	
						<table>
							<tr>
								<td>찜 파트너 리스트 목록 나오는 곳</td>
							</tr>
						</table>
					</c:forEach>
				</div>
			</div>
		</section>
		
		<section class="likeRecord">
			<div class="subContents">
				<div class="session">		
					<h4>찜한 그룹 리스트</h4>
					<c:forEach var="llist" items="${llist}">	
						<table>
							<tr>
								<td>찜 그룹 리스트 목록 나오는 곳</td>
							</tr>
						</table>
					</c:forEach>
				</div>
			</div>
		</section>
		
		<section class="likeRecord">
			<div class="subContents">
				<div class="session">		
					<h4>찜한 튜터 리스트</h4>
					<c:forEach var="llist" items="${llist}">	
						<table>
							<tr>
								<td>찜 튜터 리스트 목록 나오는 곳</td>
							</tr>
						</table>
					</c:forEach>
				</div>
			</div>
		</section>
	</article>
<jsp:include page="/WEB-INF/views/footer.jsp"/>