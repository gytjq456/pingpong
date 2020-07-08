<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<jsp:include page="/WEB-INF/views/header.jsp"/>
	<script>
		$(function(){
			$("#write").on("click",function(){
				location.href="/news/write";
			});
		});
	</script>
	
	<div id="subWrap" class="hdMargin" style="padding-top: 156px;">
		<section id="subContents">
			<article id="discussion_list" class="inner1200">
				<div class="tit_s1">
					<h2>News</h2>
					<p>새로운 세미나, 공모전, 페스티벌을 한번에 볼 수 있는 자유 게시판입니다.</p>
				</div>
				<div id="tabContWrap" class="search_wrap">
				
				<button type="button" id="write">글 작성</button>
				</div>
			</article>
		</section>
	</div>

<jsp:include page="/WEB-INF/views/footer.jsp"/>