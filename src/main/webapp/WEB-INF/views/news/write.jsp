<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<jsp:include page="/WEB-INF/views/header.jsp"/>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/resources/js/news/write.js"></script>

<<<<<<< HEAD
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
							<!--  <input type="hidden" name="start_date" id="apply_start" value="2020-07-23">
							<input type="hidden" name="end_date" id="apply_end" value="2020-07-30">-->
							
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
								<select id="category" name="category" >
									<option value=""> 유형 선택 </option>
									<option value="세미나">세미나</option>
									<option value="공모전">공모전</option>
									<option value="페스티벌">페스티벌</option>
									<option value="기타">기타</option>
								</select>
							</div>
							
							 
							<div class="news_write_sub">
								<div class="tit_s3">
									<h4>기간</h4>
									<span class="notice">* 모집기간이 있을 경우에만 작성해주세요.</span>
								</div>
								<div class="group_sub_input calendar_wrapper">	
									<div>
										<label for="apply_start" class="calendar_icon">
											<i class="fa fa-calendar" aria-hidden="true"></i>
										</label>
										<input type="text" name="start_date" id="apply_start" class="cal_input" readonly>
									</div>
									<div>
										<span class="between_calendar">~</span>
									</div>
									<div>
										<label for="apply_end" class="calendar_icon">
											<i class="fa fa-calendar" aria-hidden="true"></i>
										</label>
										<input type="text" name="end_date" id="apply_end" class="cal_input" readonly>
									</div>					
								</div>
							</div>
							<script>
							   //오늘 날짜를 출력
							    $("#today").text(new Date().toLocaleDateString());
=======
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
                     <!-- <input type="hidden" name="start_date" value="">
                     <input type="hidden" name="end_date"value=""> -->
                     
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
                        <select id="category" name="category" >
                           <option value=""> 유형 선택 </option>
                           <option value="세미나">세미나</option>
                           <option value="공모전">공모전</option>
                           <option value="페스티벌">페스티벌</option>
                           <option value="기타">기타</option>
                        </select>
                     </div>
                     
                      
                     <div class="news_write_sub">
                        <div class="tit_s3">
                           <h4>기간</h4>
                           <span class="notice">* 모집기간이 있을 경우에만 작성해주세요.</span>
                        </div>
                        <div class="group_sub_input calendar_wrapper">   
                           <div>
                              <label for="apply_start" class="calendar_icon">
                                 <i class="fa fa-calendar" aria-hidden="true"></i>
                              </label>
                              <input type="text" name="start_date" id="apply_start" class="cal_input" readonly>
                           </div>
                           <div>
                              <span class="between_calendar">~</span>
                           </div>
                           <div>
                              <label for="apply_end" class="calendar_icon">
                                 <i class="fa fa-calendar" aria-hidden="true"></i>
                              </label>
                              <input type="text" name="end_date" id="apply_end" class="cal_input" readonly>
                           </div>               
                        </div>
                     </div>
                     <script>
                     	$(function(){
                     		
                        //오늘 날짜를 출력
                         $("#today").text(new Date().toLocaleDateString());
>>>>>>> 0ad9583bbfb4af5c0f772db4ffeae07a52acdbbc

                         //datepicker 한국어로 사용하기 위한 언어설정
                         $.datepicker.setDefaults($.datepicker.regional['ko']);
                         
                         //시작일.
                         $('#apply_start').datepicker({
                             dateFormat: "yy-mm-dd",             // 날짜의 형식
                             minDate: 0,
                             onClose: function( selectedDate ) {    
                                if($("#apply_start").val() == ""){
                                   return false;
                                }
                                 // 시작일(apply_start) datepicker가 닫힐때
                                 // 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
                                // $("#apply_end").datepicker( "option", "minDate", selectedDate );
                                 $('#apply_end').datepicker({
                                   dateFormat: "yy-mm-dd",
                                   changeMonth: true,
                                   minDate : new Date($("#apply_start").val()),
                                   onClose: function( selectedDate ) {
                                       // 종료일(toDate) datepicker가 닫힐때
                                       // 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
                                       $("#apply_start").datepicker( "option", "maxDate", selectedDate );
                                   }                
                               })
                             }                
                         });

<<<<<<< HEAD
							    $('#apply_end').on("focus",function(){
							       var start = $("#apply_start").val();
							       
							    });
							</script>
							
							
							<div class="news_write_sub">
								<div class="tit_s3">
									<h4>장소</h4>	
									<span class="notice">* 모집 장소가 있을 경우에만 작성해주세요.</span>							
								</div>
								<div class="news_sub_input">
									<div class="se_con">
										<div class="post_code clearfix">
											<p><input type="text" name="postcode" id="sample3_postcode" class="post_css" placeholder="우편번호"></p>
											<p><span class="btnS1"><input type="button" id="postbtn" value="우편번호 찾기" class="post_btn on"></span></p>
										</div>
										<div class="post_input clearfix">
											<p><input type="text" name="address" id="sample3_address" class="address_css" placeholder="주소"></p>
											<p><input type="text" name="detailAddress" id="sample3_detailAddress" class="addressD_css" placeholder="상세주소"></p>
											<p><input type="text" name="extraAddress" id="sample3_extraAddress" class="addressR_css" placeholder="참고항목"></p>
										</div>
										
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
									<h4>썸네일</h4>
									<span class="notice">* 썸네일은 필수로 입력하야합니다. 프로필 사이즈 : 267px * 300px</span>
									<div class="file_box"><input type="file" id="thumbnail" name="thumbnail"></div>	
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
				
							
					
=======
                         $('#apply_end').on("focus",function(){
                            var start = $("#apply_start").val();
                            
                         });
                     	})
                     </script>
                     
                     
                     <div class="news_write_sub">
                        <div class="tit_s3">
                           <h4>장소</h4>   
                           <span class="notice">* 모집 장소가 있을 경우에만 작성해주세요.</span>                     
                        </div>
                        <div class="news_sub_input">
                           <div class="se_con">
                              <div class="post_code clearfix">
                                 <p><input type="text" name="postcode" id="sample3_postcode" class="post_css" placeholder="우편번호"></p>
                                 <p><span class="btnS1"><input type="button" id="postbtn" value="우편번호 찾기" class="post_btn on"></span></p>
                              </div>
                              <div class="post_input clearfix">
                                 <p><input type="text" name="address" id="sample3_address" class="address_css" placeholder="주소"></p>
                                 <p><input type="text" name="detailAddress" id="sample3_detailAddress" class="addressD_css" placeholder="상세주소"></p>
                                 <p><input type="text" name="extraAddress" id="sample3_extraAddress" class="addressR_css" placeholder="참고항목"></p>
                              </div>
                              
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
                           <h4>썸네일</h4>
                           <span class="notice">* 썸네일은 필수로 입력하야합니다. 프로필 사이즈 : 267px * 300px</span>
                           <div class="file_box"><input type="file" id="thumbnail" name="thumbnail"></div>   
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
            
                     
               
>>>>>>> 0ad9583bbfb4af5c0f772db4ffeae07a52acdbbc
<jsp:include page="/WEB-INF/views/footer.jsp"/>