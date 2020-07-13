<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<jsp:include page="/WEB-INF/views/header.jsp"/>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/resources/js/news/modify.js"></script>

	<div id="subWrap" class="hdMargin" style="padding-top: 156px;">
		<section id="subContents">
			<article id="news_write" class="inner1200">
				<div class="tit_s1">
					<h2>News</h2>
					<p>새로운 소식을 업로드 해주세요.</p>
				</div>
				<div id="tabContWrap">
					<div class="card_body" id="find_news_write">
						<form action="/news/modifyProc" method="post" enctype="multipart/form-data" id="writeForm">
							<input type="hidden" name="seq" id="seq" value="${ndto.seq}">
							<div class="news_write_sub">
								<div class="tit_s3">
									<h4>제목</h4>
								</div>
								<input type="text" name="title" id="title" value="${ndto.title}">
								<div class="wordsize"><span class="current">0</span>/100</div>
							</div>
							
							<div class="news_write_sub">
								<div class="tit_s3">
									<h4>유형</h4>
								</div>
								<script>
									$(function(){
										$("#category option").each(function(){
											if($(this).val() == "${ndto.category}"){
												$(this).attr("selected","selected");
												//select는 선택된게 최 상단으로 오는게 해라!
											}
										})
									})
								</script>
								<select id="category" name="category" id="category">
									<option value="세미나">세미나</option>
									<option value="공모전">공모전</option>
									<option value="페스티벌">페스티벌</option>
									<option value="기타">기타</option>
								</select>
							</div>
							
							<div class="news_write_sub">
								<div class="tit_s3">
									<h4>모집 기간</h4>
									<span class="notice">* 모집기간이 있을 경우에만 작성해주세요.</span>
								</div>
								<div class="group_sub_input calendar_wrapper">						
									<label for="apply_start" class="calendar_icon">
										<i class="fa fa-calendar" aria-hidden="true"></i>
									</label>
									<input type="text" name="start_date" id="apply_start" class="cal_input" value="${ndto.start_date}" readonly>
									<span class="between_calendar">~</span>
									<label for="apply_end" class="calendar_icon">
										<i class="fa fa-calendar" aria-hidden="true"></i>
									</label>
									<input type="text" name="end_date" id="apply_end" class="cal_input" value="${ndto.end_date}" readonly>
								</div>
							</div>
							
							<div class="news_write_sub">
								<div class="tit_s3">
									<h4>장소</h4>	
									<span class="notice">* 모집 장소가 있을 경우에만 작성해주세요.</span>							
								</div>
								<div class="news_sub_input">
									<div class="se_con">
										<div class="post_code">${ndto.location}</div>
										<input type="hidden" value="${ndto.location}" name="location">
										
										<div class="post_code">
											<input type="text" name="postcode" id="sample3_postcode" class="post_css" >
											<span class="btnS1"><input type="button" id="postbtn" value="우편번호 찾기" class="post_btn on"></span>
										</div>
										<input type="text" name="address" id="sample3_address" class="address_css" >
										<input type="text" name="detailAddress" id="sample3_detailAddress" class="addressD_css">
										<input type="text" name="extraAddress" id="sample3_extraAddress" class="addressR_css">
										
										<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
											<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode(wrap)" alt="접기 버튼">
										</div>
									</div>
								</div>
							</div>
							
							<div class="news_write_sub">
								<div class="tit_s3">
									<h4>글 내용 </h4>
								</div>
								<div class="news_sub_input">
									<textarea name="contents" id="contents">${ndto.contents}</textarea>
								</div>
							</div>
							
							<div class="news_write_sub">
								<div class="tit_s3 f_all">
									<h4>프로필</h4>
									<span class="notice">* 프로필은 필수로 입력하야합니다. 프로필 사이즈 : 267px * 300px</span>
									<div class="file_box">
										<input type="file" id="thumbnail" name="thumbnail">
										<div id="thumbnail_dele">
											<span class="notice">첨부된 파일 : </span>
											<span class="thumbnail_img">
												${ndto.thumbnail_img}
											</span>
										</div>
									</div>									
								</div>
							</div>
							
							<div class="news_write_sub">
								<div class="tit_s3 f_all">
									<h4>첨부파일</h4>
									<span class="notice">* 첨부파일이 있을 경우 +를 눌러주세요. +를 누를 때마다 첨부파일이 늘어납니다.</span>
									<button type="button" id="addFile">+</button>								
									<ul>
										<c:forEach items="${files}" var="i">
											<li>
												<div>
													${i.oriname}
													<button type="button" class="x" data-seq="${ndto.seq}" data-files_name="${i.sysname}">X</button>
												</div>
												수정 파일 : <input type="file" name="files">
												<br>
												<br>
											</li>
										</c:forEach>
									</ul>									
								</div>
								<div class="news_sub_input">									
									<div id="fileSpace"></div>
								</div>
							</div>
							
							<div class="btnS1 center">
								<div>
									<input type="submit" id="write" value="등록">
								</div>
								<div><button type="button" id="back">목록</button></div>
							</div>							
						</form>
					</div>
				</div>
			</article>
		</section>
	</div>
				
							
					
<jsp:include page="/WEB-INF/views/footer.jsp"/>