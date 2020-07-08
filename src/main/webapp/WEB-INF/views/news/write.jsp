<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<jsp:include page="/WEB-INF/views/header.jsp"/>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/resources/js/news/write.js"></script>

	<div id="subWrap" class="hdMargin" style="padding-top: 156px;">
		<section id="subContents">
			<article id="news_write" class="inner1200">
				<div class="tit_s1">
					<h2>News</h2>
					<p>새로운 소식을 업로드 해주세요.</p>
				</div>
				<div id="tabContWrap">
					<div class="card_body" id="find_news_write">
						<form action="/news/writeProc" method="post" enctype="multipart/form-data" id="writeForm">
							<div class="news_write_sub">
								<div class="tit_s3">
									<h4>제목</h4>
								</div>
								<input type="text" name="title" id="title">
								<div class="wordsize"><span class="current">0</span>/100</div>
							</div>
							
							<div class="news_write_sub">
								<div class="tit_s3">
									<h4>유형</h4>
								</div>
								<select id="category" name="category" id="category">
									<option value=""> 유형 선택 </option>
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
									<input type="text" name="apply_start" id="apply_start" class="cal_input" readonly>
									<span class="between_calendar">~</span>
									<label for="apply_end" class="calendar_icon">
										<i class="fa fa-calendar" aria-hidden="true"></i>
									</label>
									<input type="text" name="apply_end" id="apply_end" class="cal_input" readonly>
								</div>
							</div>
							
							<div class="news_write_sub">
								<div class="tit_s3">
									<h4>장소</h4>	
									<span class="notice">* 모집 장소가 있을 경우에만 작성해주세요.</span>							
								</div>
								<div class="news_sub_input">
									<div class="se_con">
										<div class="post_code">
											<input type="text" id="sample3_postcode" class="post_css" placeholder="우편번호">
											<span class="btnS1"><input type="button" id="postbtn" value="우편번호 찾기" class="post_btn on"></span>
										</div>
										<input type="text" id="sample3_address" class="address_css" placeholder="주소">
										<input type="text" id="sample3_detailAddress" class="addressD_css" placeholder="상세주소">
										<input type="text" id="sample3_extraAddress" class="addressR_css" placeholder="참고항목">
										
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
									<textarea name="contents" id="contents"></textarea>
								</div>
							</div>
							
							<div class="news_write_sub">
								<div class="tit_s3 f_all">
									<h4>프로필</h4>
									<span class="notice">* 프로필은 필수로 입력하야합니다.</span>
									<div class="file_box"><input type="file" id="fileOne" name="fileOne"></div>	
								</div>
							</div>
							
							<div class="news_write_sub">
								<div class="tit_s3 f_all">
									<h4>첨부파일</h4>
									<span class="notice">* 첨부파일이 있을 경우 +를 눌러주세요. +를 누를 때마다 첨부파일이 늘어납니다.</span>
									<button type="button" id="addFile">+</button>	
								</div>
								<div class="news_sub_input">									
									<div id="fileSpace"></div>
								</div>
							</div>
							
							<div class="btnS1 center">
								<div>
									<input type="button" id="write" value="등록">
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