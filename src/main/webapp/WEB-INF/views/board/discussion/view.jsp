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
				}).done(function(data){
		        	if(data){
		        		alert("댓글 작성이 완료 되었습니다.")
		        		location.href="/discussion/view?seq=${disDto.seq}"
		        	}
				})
				return false;
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
						</form>
					</div>
				</section>
				
				<section class="comment_list">
					<div class="tit_s2">
						<h3>댓글(1)</h3>
					</div>
					<c:forEach var="i" items="${commDto}">
						<article>
							<div class="userInfo">
								<div class="thumb"><img src="/resources/img/sub/userThum.jpg"/></div>
								<div class="info">
									<p class="userId">Youngram</p>
									<p class="writeDate">2020-06-26</p>
								</div>
							</div>
							<div class="cont">
								${i.contents}
							</div>
						</article>
					</c:forEach>					
				</section>
			</div>
			
		</article>
		
	</div>



<jsp:include page="/WEB-INF/views/footer.jsp"/>