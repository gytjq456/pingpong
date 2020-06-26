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
	$(".note-editable").blur(function(){
		var thisVal = $(this).text();
		$(this).text(textChk(thisVal));
	});
	
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
	var replaceId  = /[<script>()]/gi;
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
        	console.log(data)
			$(editor).summernote('insertImage', data.url);
		}
	});
}		
</script>

	<div id="subWrap" class="hdMargin">
		<section id="subContents">
			<article id="discussion_write" class="inner1200">
			
				<form action="/discussion/writeProc" method="post" enctype="multipart/form-data" id="writeForm">
					<input type="hidden" name="writer" value="홍길동">
					<p>토론 주제</p>
					<input type="text" name="title" id="title">
					
					<div>
						<p>토론 내용</p>
						<textarea id="summernote" name="contents" ></textarea>
					</div>
					
					<p>이 토론은 어떤 언어로 작성 되었나요?</p>
					<select id="languageList" name="language">
						<c:forEach var="i" items="${langList}">
							<option value="${i.language}">${i.language}</option>
						</c:forEach>
					</select>
					
					<p>토론시 주의사항</p>
					<p>
						<textarea name="caution" id="caution"></textarea>
					</p>
					
					<input type="submit" value="전송">
					<a href="#;">돌아가기</a>
				</form>
			
			</article>
		</section>
	</div>
	
	
<jsp:include page="/WEB-INF/views/footer.jsp"/>