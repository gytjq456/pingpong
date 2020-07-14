<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<jsp:include page="/WEB-INF/views/header.jsp"/>
	<script>
		$(function(){
			$("#write").on("click",function(){
				location.href="/news/write";
			});
			
			$("#align").on("change",function(){
				var schAlign = $(this).val();
				alert(schAlign);
				location.href="/news/schAlign?cpage=1&schAlign="+schAlign;
			});
		});
	</script>
	
	<div id="subWrap" class="hdMargin" style="padding-top: 156px;">
		<section id="subContents">			
			<article id="new_list" class="inner1200">				
				<div class="tit_s1">
					<h2>News</h2>
					<p>새로운 세미나, 공모전, 페스티벌을 한번에 볼 수 있는 자유 게시판입니다.</p>
				</div>
				<div id="tabContWrap" class="contImg">
					<div class="btnS1 right">
						<div>
							<select name="align" id="align">
								<option value="recent" <c:if test="${schAlign == 'recent'}">selected</c:if>>최신 순</option>
								<option value="like" <c:if test="${schAlign == 'like'}">selected</c:if>>인기 순</option>
							</select>
						
						</div>
					</div>
					
					
					
					<div id="listStyle1" class="card_body">
					<c:choose>
						<c:when test="${empty newsSelect}">
							<div class="no_list">
								등록된 게시글이 없습니다.
							</div>
						</c:when>
						<c:otherwise>
							<c:forEach var="list" items="${newsSelect}">
							<div class="back_and_wrap item">
								<a href="/news/viewProc?seq=${list.seq}">
									<div class="img_w">
										<img src="/upload/news/thumbnail/${list.thumbnail_img}" alt="이미지">
									</div>
									<div class="title">${list.title}</div>
									<div>${list.writer}</div>
									<div>행사기간 : ${list.start_date} ~ ${list.end_date}</div>
									<span>${list.write_date_st}</span>
									<div class="countList" style="position:static;">
										<ul>
											<li><i class="fa fa-eye"></i>${list.view_count}</li>
										</ul>
									</div>	
								</a>						
							</div>
						</c:forEach>
						</c:otherwise>
					</c:choose>
					</div>
					
					<div id="listNav">
						${navi}
					</div>
					
					<div class="btnS1 right">						
							<button type="button" id="write" class="on">글 작성</button>
					</div>
					
				</div>
			</article>
		</section>
	</div>

<jsp:include page="/WEB-INF/views/footer.jsp"/>