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
			
			// view right_body 
			var viewPage = $("#discussion_view");
			var cardOffset = viewPage.offset().top; 
			var headerHeight = $("header").height();
			var quick_top = 100;
			var quick_menu = viewPage.find(".body_right");
			$(window).scroll(function(){
				var scrollTop = $(this).scrollTop();
				if(scrollTop >= cardOffset - headerHeight - 30){
					quick_menu.stop().animate({ 
						"top": scrollTop + "px" 
					}, 500 ); //스크롤 내려갈 때의 속도					
				}else{
					quick_menu.stop().animate({ 
						"top":0
					});
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
		<section id="subContents">
		
			<article id="discussion_view" class="viewPage_style1 inner1200 clearfix">
				
				<div class="body_left">
					<div class="card_body">
						<%-- <div id="">번호 : ${disDto.seq}</div> --%>
						<div class="title">${disDto.title}</div>
						<div class="userInfo_s1">
							<div class="thumb"><img src="/resources/img/sub/userThum.jpg"/></div>
							<div class="info">
								<p class="userId">${disDto.writer}</p>
								<p class="writeDate">${disDto.dateString}</p>
							</div>
						</div>
						<div class="language">${disDto.language}</div>	
						<div class="contents">${disDto.contents}</div>
						<div class="countList">
							<ul>
								<li><i class="fa fa-eye"></i> ${disDto.view_count}</li>			
								<li><i class="fa fa-commenting-o" aria-hidden="true"></i> ${disDto.comment_count}</li>
								<li>
									<button class="discussion_likeBtn likeBtn like-hate-btn" data-seq="${disDto.seq}">
										<i class="fa fa-thumbs-up"></i> : ${disDto.like_count}
									</button>
								</li>
							</ul>
						</div>
					</div>
					
					<div class="">
						<div class="comment_wrap">
							<section class="comment_write card_body">
								<div class="tit_s2">
									<h3>댓글쓰기</h3>
								</div>
								<div class="comment_box">
									<form id="commentForm">
										<input type="hidden" name="category" value="discussion">
										<input type="hidden" name="writer" value="홍길동">
										<input type="hidden" name="parent_seq" value="${disDto.seq}">
										<div class="opinion">
											<div>의견(찬/반)</div>
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
										<div class="btnS1 right">
											<div><input type="submit" value="작성" class="on"></div>
											<div>
												<input type="reset" value="취소">
											</div>
										</div>										
									</form>
								</div>
							</section>
							
							<section class="comment_list card_body">
								<div class="tit_s2">
									<h3>베스트 댓글(${fn:length(bestCommentList)})</h3>
								</div>
								<c:forEach var="i" items="${bestCommentList}">
									<article>
										<div class="userInfo_s1">
											<div class="thumb"><img src="/resources/img/sub/userThum.jpg"/></div>
											<div class="info">
												<p class="userId">${i.writer}</p>
												<p class="writeDate">${i.dateString}</p>
											</div>
										</div>
										<div class="opinion">
											<p class="<c:if test="${i.opinion == '찬성'}">yes</c:if><c:if test="${i.opinion == '반대'}">no</c:if>">${i.opinion}</p>
										</div>
										
										<div class="cont">
											<div class="contents">${i.contents}</div>
											<div class="countList">
												<ul>
													<li>
														<button class="comment_likeBtn likeBtn like-hate-btn" data-seq="${i.seq}"><i class="fa fa-thumbs-up"></i> ${i.like_count}</button>
													</li>
													<li>
														<button class="comment_hateBtn hateBtn like-hate-btn" data-seq="${i.seq}"><i class="fa fa-thumbs-down"></i> ${i.hate_count}</button>
													</li>
													<li>
														<button class="comment_declaration" data-seq="${i.seq}"><i class="fa fa-bell color_white" aria-hidden="true"></i> 신고하기</button>
													</li>
													<li>
														<button class="comment_delete normal" data-seq="${i.seq}">댓글삭제</button>
													</li>
												</ul>
											</div>
										</div>
									</article>
								</c:forEach>					
							</section>				
							
							<section class="comment_list card_body">
								<div class="tit_s2">
									<h3>댓글(${fn:length(commentList)})</h3>
								</div>
								<c:forEach var="i" items="${commentList}">
									<article>
										<div class="userInfo_s1">
											<div class="thumb"><img src="/resources/img/sub/userThum.jpg"/></div>
											<div class="info">
												<p class="userId">${i.writer}</p>
												<p class="writeDate">${i.dateString}</p>
											</div>
										</div>
										<div class="opinion">
											<p class="<c:if test="${i.opinion == '찬성'}">yes</c:if><c:if test="${i.opinion == '반대'}">no</c:if>">${i.opinion}</p>
										</div>
										
										<div class="cont">
											<div class="contents">${i.contents}</div>
											<div class="countList">
												<ul>
													<li>
														<button class="comment_likeBtn likeBtn like-hate-btn" data-seq="${i.seq}"><i class="fa fa-thumbs-up"></i> ${i.like_count}</button>
													</li>
													<li>
														<button class="comment_hateBtn hateBtn like-hate-btn" data-seq="${i.seq}"><i class="fa fa-thumbs-down"></i> ${i.hate_count}</button>
													</li>
													<li>
														<button class="comment_declaration" data-seq="${i.seq}"><i class="fa fa-bell color_white" aria-hidden="true"></i> 신고하기</button>
													</li>
													<li>
														<button class="comment_delete normal" data-seq="${i.seq}">댓글삭제</button>
													</li>
												</ul>
											</div>
										</div>
									</article>
								</c:forEach>					
							</section>
						</div>
					</div>
				</div>
				<div class="body_right card_body">
					<div class="caution">
						<div class="tit_s2">
							<h3>토론시 주의사항</h3>
						</div>					
						<div id="txt">${disDto.caution}</div>
					</div>
					<div class="moreList">
						<div class="tit_s2">
							<h3>토론 더 보기</h3>
						</div>
						<div class="list">
							<ul>
								<c:forEach var="i" items="${moreList}"> 
									<li><a href="/discussion/view?seq=${i.seq}">- ${i.title}</a></li>
								</c:forEach>
							</ul>
						</div>
					</div>	
					<div class="btns_s2">
						<button type="button" id="modify">글수정</button>
						<button type="button" id="delete">글삭제</button>
						<button type="button" id="historyBack">뒤로가기</button>					
					</div>			
				</div>
				

		
	
				
				
				
				

				
			</article>
		</section>
	</div>



<jsp:include page="/WEB-INF/views/footer.jsp"/>