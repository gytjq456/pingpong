<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<jsp:include page="/WEB-INF/views/header.jsp"/>
	
	<script>
		$(function(){
			$('#myInfoModify').on("click",function(){
				location.href="/member/myInfoModify?mem_type=${mdto.mem_type}";
			});
			
			$('#memWithdrawal').on("click",function(){
				var id = '${mdto.id}';
				$.ajax({
					type : "post",
					url : "/member/memWithdrawal"					
				}).done(function(resp){
					alert("회원 탈퇴 되었습니다.");
					location.href="/";
					
				}).fail(function(error1, error2){
					alert("관리자에게 문의 주세요");
				});
			});
		});	
	</script>

		
	<div id="subWrap" class="hdMargin">
		<section id="subContents">
			<article id="mypage" class="inner1200">
		
			<div id="session" class="card_body">	
				<form action="/member/memberSelect" method="post">	
					<div class="userInfo clearfix">
						<div class="thum">
							<div class="img"><img src="/upload/member/${loginInfo.id}/${loginInfo.sysname}"></div>
						</div>
						<div class="infoBox">
							<div class="name">
								<span class="grade">
									<c:choose>
										<c:when test="${mdto.grade == 'default'}">
											튜티
										</c:when>
										<c:when test="${mdto.grade == 'tutor'}">
											튜터
										</c:when>
										<c:otherwise>
											파트너
										</c:otherwise>
									</c:choose>
								</span>
								${mdto.name} <span>(${mdto.age}, ${mdto.id}, ${mdto.gender})</span>
							</div>
							<div class="infoTxt">
								<ul>
									<li>
										<span>이메일</span>
										<p>${mdto.email}</p>
									</li>
									<li>
										<span>전화번호</span>
										<p>${mdto.phone}</p>
									</li>
									<li>
										<span>국적</span>
										<p>${mdto.country}</p>
									</li>
									<li>
										<span>지역</span>
										<p>${mdto.address}</p>
									</li>
									<li>
										<span>은행</span>
										<p>${mdto.bank_name} ( ${mdto.account} )</p>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="sideInfo">
						<ul>
							<li>
								<span>구사 가능언어</span>
								<p>${mdto.lang_can}</p>
							</li>
							<li>
								<span>배우고 싶은 언어</span>
								<p>${mdto.lang_learn}</p>
							</li>
							<li>
								<span>취미</span>
								<p>${mdto.hobby}</p>
							</li>
							<li class="introduce">
								<span>자기소개</span>
								<p>${mdto.introduce}</p>
							</li>
						</ul>
					</div>
					<%-- <img src ="/upload/member/${mdto.id}/${mdto.sysname}"> --%>
				</form>
				
				<div class="btnS1 right">
					<div><button id="myInfoModify">수정하기</button></div>
					<div>
						<button id="memWithdrawal">회원탈퇴</button>
					</div>
				</div>
				
			</div>
		</section>
	</div>
		
<jsp:include page="/WEB-INF/views/footer.jsp"/>