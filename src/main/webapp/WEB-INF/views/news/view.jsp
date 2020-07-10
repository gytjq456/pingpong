<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<jsp:include page="/WEB-INF/views/header.jsp"/>
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
									<h3 class="se_top">
										<div class="title">${ndto.title}</div>
										<div class="writer">
											${ndto.writer}<span class="stick">|</span>${ndto.write_date_st}
											<ul class="count_news_eye">
												<li><i class="fa fa-eye"></i> 1</li>
												<li><i class="fa fa-commenting-o" aria-hidden="true"></i> 0</li>
											</ul>
										</div>
									</h3>
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
												<li>${ndto.start_date} ~ ${ndto.end_date}</li>
											</ul>
										</li>
									</ul>
									<ul class="tb_se">
										<li>
											<ul>
												<li>행사장소</li>
												<li>${ndto.location}</li>
											</ul>
										</li>
									</ul>
									<ul class="tb_se">
										<li>
											<ul>
												<li>첨부파일</li>
												<li>${ndto.files_name}</li>
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
					</div>
					<div class="btnS1 center">
						<div>
							<input type="submit" id="write" value="등록">
						</div>
						<div><button type="button" id="back">목록</button></div>
					</div>
				</div>
			</article>
		</section>
	</div>
<jsp:include page="/WEB-INF/views/footer.jsp"/>