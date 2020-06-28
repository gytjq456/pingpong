<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<jsp:include page="/WEB-INF/views/header.jsp"/>

<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="/resources/js/summernote.js"></script>
<script src="/resources/js/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/resources/css/summernote.css">  
<script>
$(function(){
 	$('#summernote').summernote({
		height: 300,
		lang: "ko-KR",
		callbacks:{
			onImageUpload : function(files){
				uploadSummernoteImageFile(files[0],this);
			}
		}
	}); 
	
	var titleObj = $("#title");
	var cautionObj = $("#caution");
	
	$("input,textarea").blur(function(){
		var thisVal = $(this).val();
		$(this).val(textChk(thisVal));
	})
/* 	$(".note-editable").blur(function(){
		var thisVal = $(this).html();
		$(this).text(textChk(thisVal));
	}); */
	
	$("#writeForm").on("submit",function(){
		var titleVal = titleObj.val();
		var cautionVal = cautionObj.val();
		var noteObj = $(".note-editable");
	
		if(titleVal.replace(/\s|　/gi, "").length == 0){
			alert("제목을 입력해주세요.")
			titleObj.val("");
			titleObj.focus();
			return false;
		}else if(noteObj.text().replace(/\s|　/gi, "").length == 0){
			alert("내용을 입력해주세요.")
			noteObj.text("");
			noteObj.focus();
			return false;
		}else if(cautionVal.replace(/\s|　/gi, "").length == 0){
			alert("주의사항을 입력해주세요.")
			cautionObj.val("");
			cautionObj.focus();
			return false;
		}
		
		

	})
	
})
function textChk(thisVal){
	var replaceId  = /(script)/gi;
	var textVal = thisVal;
    if (textVal.length > 0) {
        if (textVal.match(replaceId)) {
        	textVal = thisVal.replace(replaceId, "");
        }
    }
    return textVal;
}

function uploadSummernoteImageFile(file, editor) {
	data = new FormData();
	data.append("file", file);
	$.ajax({
		data : data,
		type : "POST",
		url : "/summerNote/uploadSummernoteImageFile",
		contentType : false,
		processData : false,
		success : function(data) {
        	//항상 업로드된 파일의 url이 있어야 한다.
			$(editor).summernote('insertImage', data.url);
		}
	});
}		
</script>

	<div id="subWrap" class="hdMargin">
		<section id="subContents">
			<article id="discussion_write" class="inner1200">
				<div class="tit_s1">
					<h2>Discussion</h2>
					<p>새 주제 게시하기</p>
				</div>				
				<div class="card_body">
					<form action="/discussion/writeProc" method="post" enctype="multipart/form-data" id="writeForm">
						<input type="hidden" name="writer" value="홍길동">
						<section>
							<div class="tit_s3">
								<h4>토론 주제</h4>
							</div>
							<input type="text" name="title" id="title">
						</section>
						
						<section>
							<div class="tit_s3">
								<h4>토론 내용</h4>
							</div>
							<textarea id="summernote" name="contents" ></textarea>
						</section>
						
						<section>
							<div class="tit_s3">
								<h4>이 토론은 어떤 언어로 작성 되었나요?</h4>
							</div>					
							<div id="languageList" name="language">
								<select>
									<c:forEach var="i" items="${langList}">
										<option value="${i.language}">${i.language}</option>
									</c:forEach>
								</select>
							</div>
						</section>
						
						<section>
							<div class="tit_s3">
								<h4>토론시 주의사항</h4>
							</div>
							<div>
								<textarea name="caution" id="caution"></textarea>
							</div>
						</section>
						<div class="btnS1 right">
							<div>
								<input type="submit" value="전송">
							</div>
							<div><a href="#;">돌아가기</a></div>
						</div>						
					</form>
				</div>
			</article>
		</section>
	</div>
	
	
<jsp:include page="/WEB-INF/views/footer.jsp"/>