<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<jsp:include page="/WEB-INF/views/header.jsp"/>

<script>
	$(function(){
		//오늘 날짜를 출력
        $("#today").text(new Date().toLocaleDateString());

        //datepicker 한국어로 사용하기 위한 언어설정
        $.datepicker.setDefaults($.datepicker.regional['ko']);
        
        //시작일.
        $('#apply_start').datepicker({
            dateFormat: "yy-mm-dd",             // 날짜의 형식
            minDate: 0,
            onClose: function( selectedDate ) {    
                // 시작일(apply_start) datepicker가 닫힐때
                // 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
                $("#toDate").datepicker( "option", "minDate", selectedDate );
            }                
        });

        //종료일
        $('#apply_end').datepicker({
            dateFormat: "yy-mm-dd",
            changeMonth: true,
            onClose: function( selectedDate ) {
                // 종료일(toDate) datepicker가 닫힐때
                // 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
                $("#apply_start").datepicker( "option", "maxDate", selectedDate );
            }                
        });
			
	})
</script>


	<div id="subWrap" class="hdMargin" style="padding-top: 156px;">
		<section id="subContents">
			<article id="discussion_list" class="inner1200">
				<div class="tit_s1">
					<h2>News</h2>
					<p>새로운 소식을 업로드 해주세요.</p>
				</div>
				<div id="tabContWrap">
					<div class="card_body">
						<form action="/discussion/writeProc" method="post" enctype="multipart/form-data" id="writeForm">
							<input type="hidden" name="writer" value="써니잉">
							<section>
								<div class="tit_s3">
									<h4>제목</h4>
								</div>
								<input type="text" name="title" id="title">
							</section>
							
							<div>
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
							
							<div class="group_write_sub">
								<div class="tit_s3">
									<h4>모집 기간</h4>
									<span class="notice">*모집 기간 시작 날짜는 오늘 날짜 이외의 날짜로 설정이 불가능합니다.</span>
								</div>
								<div class="group_sub_input calendar_wrapper">						
									<label for="apply_start">시작일
										<i class="fa fa-calendar" aria-hidden="true"></i>
									</label>
									<input type="text" name="apply_start" id="apply_start" readonly>
									~<br>
									<label for="toDate">종료일
										<i class="fa fa-calendar" aria-hidden="true"></i>
									</label>
									<input type="text" name="toDate" id="toDate" readonly>
								</div>
							</div>
							
							<div>
								<div class="tit_s3">
									<h4>행사 장소</h4>								
								</div>
								
							</div>
							
							<div>
								<div class="tit_s3">
									<h4>글 내용</h4>
								</div>
								<textarea id="summernote" name="contents" style="display: none;"></textarea>
							</div>
							
						</form>
					</div>
				</div>
			</article>
		</section>
	</div>
				
							
					
<jsp:include page="/WEB-INF/views/footer.jsp"/>