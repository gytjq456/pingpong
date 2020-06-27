<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
			
			// 댓글 쓰기
			var opinion = $("#opinion");
			var textCont = $("#textCont");
			$("#commentForm").submit(function(){
		        var form = $('#commentForm')[0];
		        var formData = new FormData(form);		
		        if(opinion.val() == ""){
		        	alert("의견을 선택해주세요.");
		        	opinion.focus();
		        	return false;
		        }else if(textCont.val() == "" || textCont.val().replace(/\s|　/gi, "").length == 0){
		        	alert("댓글을 입력해주세요.")
		        	textCont.focus();
		        	textCont.val("");
		        	return false;
		        }
				$.ajax({
					url:"/discussion/commentProc",
					type:"post",
					dataType:"json",
					data:formData,
		        	contentType : false,
		            processData : false  					
				}).done(function(resp){
		        	if(resp){
		        		alert("댓글 작성이 완료 되었습니다.")
		        		location.href="/discussion/view?seq=${disDto.seq}"
		        	}
				})
				return false;
			})
			
			// 댓글 좋아요, 싫어요 증가
			var comment_likeBtn = $(".comment_likeBtn");
			var comment_hateBtn = $(".comment_hateBtn");
			var discussion_likeBtn = $(".discussion_likeBtn");
			likeHateCount(comment_likeBtn,"/discussion/commentLike");
			likeHateCount(comment_hateBtn,"/discussion/commentHate");
			likeHateCount(discussion_likeBtn,"/discussion/like");
			
			
			// 댓글 삭제
			$(".comment_delete").click(function(){
				var result = confirm("댓글을 삭제 하시겠습니까?");
				var seq = $(this).data("seq");
				if(result){
					$.ajax({
						url:"/discussion/commentDelete",
						dataType:"json",
						data:"post",
						data:{
							seq:seq
						}
					}).done(function(resp){
						if(resp){
							alert("댓글이 삭제되었습니다.");
							location.reload();
						}
					})
				}
			})
		})
		
		function likeHateCount(btn,url){
			btn.click(function(){
				var seq = $(this).data("seq");
				$.ajax({
					url:url,
					dataType:"json",
					data:"post",
					data:{
						seq:seq
					}
				}).done(function(resp){
					if(resp){
						//location.href="/discussion/view?seq=${disDto.seq}"
						location.reload();
					}
				})
			})	
		}
		
		
		
		
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
			<div><button class="discussion_likeBtn">좋아요 : ${disDto.like_count}</button></div>			
			<div>댓글 : ${disDto.comment_count}</div>	
			

			<button type="button" id="modify">글수정</button>
			<button type="button" id="delete">글삭제</button>
			<button type="button" id="historyBack">뒤로가기</button>
	

			
			<div class="comment_wrap">
				<section class="comment_write">
					<div class="tit_s2">
						<h3>댓글쓰기</h3>
					</div>
					<div class="comment_box">
						<form id="commentForm">
							<input type="hidden" name="category" value="discussion">
							<input type="hidden" name="writer" value="홍길동">
							<input type="hidden" name="parent_seq" value="${disDto.seq}">
							<div class="opinion">
								<div>의견 <div>
								<div>
									<select name="opinion" id="opinion">
										<option value="">선택</option>
										<option value="찬성">찬성</option>
										<option value="반대">반대</option>
									</select>
								</div>
							</div>
							<div class="textInput">
								<textarea name="contents" id="textCont"></textarea>
							</div>
							<input type="submit">
							<input type="reset">
						</form>
					</div>
				</section>
				
				<section class="comment_list">
					<div class="tit_s2">
						<h3>베스트 댓글(${fn:length(bestCommentList)})</h3>
					</div>
					<c:forEach var="i" items="${bestCommentList}">
						<article>
							<div class="userInfo">
								<div class="thumb"><img src="/resources/img/sub/userThum.jpg"/></div>
								<div class="info">
									<p class="userId">${i.writer}</p>
									<p class="writeDate">${i.dateString}</p>
								</div>
							</div>
							<div class="cont">
								<p></p>
								<p>내용 ${i.contents}</p>
								<p>의견 ${i.opinion}</p>
								<p><button class="comment_likeBtn" data-seq="${i.seq}">좋아요 ${i.like_count}</button></p>
								<p><button class="comment_hateBtn" data-seq="${i.seq}">싫어요 ${i.hate_count}</button></p>
							</div>
						</article>
					</c:forEach>					
				</section>				
				
				<section class="comment_list">
					<div class="tit_s2">
						<h3>댓글(${fn:length(commentList)})</h3>
					</div>
					<c:forEach var="i" items="${commentList}">
						<article>
							<div class="userInfo">
								<div class="thumb"><img src="/resources/img/sub/userThum.jpg"/></div>
								<div class="info">
									<p class="userId">${i.writer}</p>
									<p class="writeDate">${i.dateString}</p>
								</div>
							</div>
							<div class="cont">
								<p></p>
								<p>내용 ${i.contents}</p>
								<p>의견 ${i.opinion}</p>
								<p><button class="comment_likeBtn" data-seq="${i.seq}">좋아요 ${i.like_count}</button></p>
								<p><button class="comment_hateBtn" data-seq="${i.seq}">싫어요 ${i.hate_count}</button></p>
								<p><button class="comment_delete" data-seq="${i.seq}">댓글삭제</button></p>
							</div>
						</article>
					</c:forEach>					
				</section>
			</div>
			
			
			<div class="moreList">
				<div class="tit_s2">
					<h3>토론 더 보기</h3>
				</div>
				<div class="list">
					<ul>
						<li><a href=""></a></li>
					</ul>
				</div>
			</div>
			
		</article>
		
	</div>



<jsp:include page="/WEB-INF/views/footer.jsp"/>