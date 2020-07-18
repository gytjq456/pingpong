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
<style>
	.idResult {}
	.idResult .list { } 
	.idResult .list li { position:relative; padding-left:12px; font-size:16px; margin-bottom:10px; border:1px solid #ddd; box-sizing:border-box; padding:10px; text-align:center;  }
	.idResult .list li:last-child { margin-bottom:0; }
</style>

	<div id="subWrap" class="hdMargin">
		<section id="subContents">
			<article id="" class="inner1200">
				<div id="login" class="card_body idResult">
					<div class="tit_s1">
						<h3>아이디 찾기 결과</h3>
					</div>
					<div class="list">
						<ul>
							<li>
								<c:forEach var="i" items="${mlist}">
									<p>${i.id}</p>
								</c:forEach>
							</li>
							<li>
								<c:forEach var="i" items="${mlist}">
									<p>${i.id}</p>
								</c:forEach>
							</li>
						</ul>
					</div>
					<div class="btnS1 center ">
						<div><button id="goLogin">로그인페이지로 바로가기</button></div>
						<div><button id="idFind">비밀번호 찾기로 바로가기</button></div>
					</div>
				</div>
			</article>
		</section>
	</div>



<jsp:include page="/WEB-INF/views/footer.jsp" />