<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<jsp:include page="/WEB-INF/views/header.jsp"/>
	<script>
		$(function(){
			$("#listStyle1 > section").each(function(){
				var text = $(this).find(".contents").text();
				var textSubString;
				if(text.length >= 300) { 
					textSubString = text.substring(0,299)+"...";;
					$(this).find(".contents a").html(textSubString);
				}else{
					$(this).find(".contents a").html(text);
				}
			})



		})
	</script>

	<div id="subWrap" class="hdMargin">
		<section id="subContents">
			<article id="discussion_list" class="inner1200">
				<div class="tit_s1">
					<h2>Discussion</h2>
					<p>이야기하고 싶은 흥미로운 주제가 있으신가요? 여기에서 전 세계 외국어 학습자들과 <br>토론을 하고 소통해 보세요.</p>
				</div>
				
				<div class="btnS1 right">
					<p><a href="/discussion/write" class="on">토론 글쓰기</a></p>
				</div>
				<div id="listStyle1">
					
					<c:forEach var="i" items="${list}">
						<section>
							<div class="title"><a href="/discussion/view?seq=${i.seq}">${i.title}</a></div>
							<div>글쓴이 : ${i.writer}</div>
							<div class="contents"><a href="/discussion/view?seq=${i.seq}">${i.contents}</a></div>			
							<div>언어 : ${i.language}</div>			
							<div>날짜  : ${i.dateString}</div>	
							<div class="countList">
								<ul>
									<li>조회수 : ${i.view_count}</li>
									<li>좋아요 : ${i.like_count}</li>
									<li>리뷰 : ${i.review_count}</li>
								</ul>
							</div>		
						</section>
					</c:forEach>
				</div>
			</article>
		</section>
	</div>



<jsp:include page="/WEB-INF/views/footer.jsp"/>