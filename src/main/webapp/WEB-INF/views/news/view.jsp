<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<jsp:include page="/WEB-INF/views/header.jsp"/>
	<style>
		#listStyle1 .title {    white-space: break-spaces;}
	</style>

	<script>
	$(function(){
		$("#back").on('click',function(){
			location.href="/news/listProc";
		});
		
		$("#modify").on('click',function(){
			location.href="/news/modify?seq=${ndto.seq}";
		});
		
		$("#delete").on('click',function(){
			var result = confirm("삭제를 진행하시겠습니까?");
			if(result){
				$.ajax({
					url:"/news/delete",
					type:"post",
					data:{
						seq : '${ndto.seq}'
					}
				}).done(function(resp){
					if(resp>0){
						alert("삭제가 완료되었습니다.");
						location.href="/news/listProc";
					}else{
						alert("삭제되지 않았습니다. 다시 확인해주세요.");
					}
				});
			}else{
				alert("취소하였습니다.");
			}
			
		});
		
		
	});
		
	</script>
	<div id="subWrap" class="hdMargin" style="padding-top: 156px;">
		<section id="subContents">
			<article id="new_view" class="inner1200">
				<div id="tabContWrap" class="contImg">
					<div id="listStyle1" class="card_body">
					
						<div class="con">
							<div id="se_con">
								<div class="imgbox">
									<img src="/upload/news/thumbnail/${ndto.thumbnail_img}" alt="이미지">
								</div>
								<div class="textbox">
									<div class="se_top">
										<div class="title">${ndto.title}</div>
										<div class="writer">
											${ndto.writer}<span class="stick">|</span>${ndto.write_date_st}
											<ul class="count_news_eye">
												<li><i class="fa fa-eye"></i>${ndto.view_count}</li>
											</ul>
										</div>
									</div>
									<ul class="tb_se">
										<li>
											<ul>
												<li>유형</li>
												<li>${ndto.category}</li>
											</ul>
										</li>
									</ul>
									
									<ul class="tb_se">
										<li>
											<ul>
												<li>행사기간</li>
												<c:choose>
													<c:when test="${not empty ndto.start_date || not empty ndto.start_date}">
														<li>${ndto.start_date} ~ ${ndto.end_date}</li>
													</c:when>
													<c:otherwise>
														<li>-</li>
													</c:otherwise>
												</c:choose>
											</ul>
										</li>
									</ul>
<<<<<<< HEAD

=======
									
>>>>>>> 0ad9583bbfb4af5c0f772db4ffeae07a52acdbbc
									<ul class="tb_se">
										<li>
											<ul>
												<li>행사장소</li>
												<c:choose>
													<c:when test="${ndto.location != '  '}">
														<li>${ndto.location}</li>
													</c:when>
													<c:otherwise>
														<li>-</li>
													</c:otherwise>
												</c:choose>
											</ul>
										</li>
									</ul>
									<ul class="tb_se">
										<li>
											<ul>
												<li>첨부파일</li>
												<li>
													<c:forEach items="${files}" var="i">
														<a href="/file/downloadFile?seq=${ndto.seq}&files_name=${i.sysname}" class="downloadF">
															${i.oriname}
														</a>
													</c:forEach>
												</li>											
											</ul>
										</li>
									</ul>
								</div>
							</div>
							<div id="se_con">
								<div class="contents">
									${ndto.contents}
								</div>
							</div>												
						</div>
						<div class="btnS1 center">
							<button type="button" id="back" style="display:inline-block;float:right;">목록</button>
							<c:if test="${sessionScope.loginInfo.id == ndto.writer}">
								<button type="button" id="modify" style="display:inline-block; margin-right:20px; float:right;">수정</button>
								<button type="button" id="delete" style="display:inline-block; margin-right:20px; float:right;">삭제</button>

							</c:if>
						</div>
					</div>
				</div>
			</article>
		</section>
	</div>
<jsp:include page="/WEB-INF/views/footer.jsp"/>