<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<jsp:include page="/WEB-INF/views/header.jsp"/>
	<Script>
		$(function(){
			// 글 삭제 버튼 클릭
			$("#delete").click(function(){
				var result = confirm("해당 글을 삭제하시겠습니까?");
				if(result){
					$.ajax({
						url:"/discussion/delete",
						type:"POST",
						dateType:"json",
						data:{
							seq:"${disDto.seq}"
						}
					}).done(function(resp){
						alert("글이 삭제 되었습니다.");
						location.href="/discussion/list";
					})		
				}
			})
			
			// 뒤로가기 버튼 클릭
			$("#historyBack").click(function(){
				location.href="/discussion/list"
			})
			
			// 글 수정 버튼 클릭
			$("#modify").click(function(){
				location.href="/discussion/modify?seq=${disDto.seq}"
			})
			
		})
	</Script>

	<div id="subWrap" class="hdMargin">
	
		<article id="discussion_view" class="viewPage_style1 inner1200">
			
			<div id="">번호 : ${disDto.seq}</div>
			<div id="">글쓴이 : ${disDto.writer}</div>
			<div id="">제목 : ${disDto.title}</div>
			<div id="">내용 : ${disDto.contents}</div>
			<div id="">토론시 주의사항 : ${disDto.caution}</div>
			<div id="">언어 : ${disDto.language}</div>
			<div>날짜  : ${disDto.dateString}</div>			
			<div>조회수 : ${disDto.view_count}</div>			
			<div>좋아요 : ${disDto.like_count}</div>			
			<div>리뷰 : ${disDto.review_count}</div>	
			

			<button type="button" id="modify">글수정</button>
			<button type="button" id="delete">글삭제</button>
			<button type="button" id="historyBack">뒤로가기</button>
			
		</article>
		
	</div>



<jsp:include page="/WEB-INF/views/footer.jsp"/>