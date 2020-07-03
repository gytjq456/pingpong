<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/header.jsp" />

<script>
	$(function(){
		$("#goLogin").on("click",function(){
			location.href="/member/login";
		});
		
		$("#idFind").on("click",function(){
			location.href="/member/pwFind";
		});
		
	});
</script>

<div id="subWrap" class="hdMargin" style="padding-top: 155.8px;">
		<section id="subContents">
			<div id="join">
				<c:forEach var="i" items="${mlist}">
					${i.id}<br>
				</c:forEach>
			</div>
			<button id="goLogin">로그인페이지로 바로가기</button>
			<button id="idFind">비밀번호 찾기로 바로가기</button>
		</section>
</div>


<jsp:include page="/WEB-INF/views/footer.jsp" />