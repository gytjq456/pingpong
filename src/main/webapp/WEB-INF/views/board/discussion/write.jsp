<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<jsp:include page="/WEB-INF/views/header.jsp"/>


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
		$(this).val(textChk(thisVal,$(this)));
	})
 /* 	$(".note-editable").blur(function(){
		var thisVal = $(this).html();
		$(this).text(textChk(thisVal,$(this)));
	}); */
	
	$("#writeForm").on("submit",function(){
		var titleVal = titleObj.val();
		var cautionVal = cautionObj.val();
		var noteObj = $(".note-editable");
		var replaceId  = /(script)/gi;
		
		var blank_pattern = /^\s+|\s+$/g;

		
		if(titleVal.replace(/\s|　/gi, "").length == 0){
			alert("제목을 입력해주세요.")
			titleObj.val("");
			titleObj.focus();
			return false;
		}else if(cautionVal.replace(/\s|　/gi, "").length == 0){
			alert("주의사항을 입력해주세요.")
			cautionObj.val("");
			cautionObj.focus();
			return false;
		}
		
		if( noteObj.html().replace(blank_pattern, '' ) == ""){
			alert("공백만 입력할 수 없습니다.")
			noteObj.focus();	
			return false;
		}
		
		alert(noteObj.html())
		if(noteObj.html() == ""){
			alert("내용을 입력해주세요.니다.")
			noteObj.focus();	
			return false;
		}
		
		// noteObj.text() == ""
		/* else if(noteObj.text().replace(/\s|　/gi, "").length == 0){
			alert("내용을 입력해주세요.")
			noteObj.text("");
			noteObj.focus();
			return false;
		} */
		
		var noteObj = $(".note-editable");
		var replaceId  = /(script)/gi;
		if(noteObj.text().match(replaceId)){
			alert("부적절한 내용이 들어가있습니다.")
			noteObj.focus();
			noteObj.html("")
			return false;
		}
	})
	
	
	// 타이틀 글자수 체크
	$("#discussion_write").find("#title").keyup(function(){
		var word = $(this).val();
		var wordSize = word.length;
		console.log(wordSize)
		if(wordSize <= 100){
			$(this).siblings(".wordsize").find(".current").text(wordSize);
		}else{
			word = word.substr(0,100);
			$(this).siblings(".wordsize").find(".current").text(word.length);
			$(this).val(word);
			alert("제목은  100자 이하로 등록해 주세요")
		}
		
	})
	$("#discussion_write").find("#caution").keyup(function(){
		var word = $(this).val();
		var wordSize = word.length;
		console.log(wordSize)
		if(wordSize <= 100){
			$(this).siblings(".wordsize").find(".current").text(wordSize);
		}else{
			word = word.substr(0,1000);
			$(this).siblings(".wordsize").find(".current").text(word.length);
			$(this).val(word);
			alert("주의사항은  1000자 이하로 등록해 주세요")
		}
	})
	
	
})
function textChk(thisVal, obj){
	var replaceId  = /(script)/gi;
	var textVal = thisVal;
    if (textVal.length > 0) {
        if (textVal.match(replaceId)) {
        	console.log(obj)
        	if(obj.val().length){
	        	obj.val("");
	        	$(".wordsize .current").text("0");
	        	textVal = obj.val();
        	}else{
	        	obj.html("");
	        	$(".wordsize .current").text("0");
	        	textVal = obj.val();
        	}
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
						<input type="hidden" name="id" value="${sessionScope.loginInfo.id}">
						<input type="hidden" name="writer" value="${sessionScope.loginInfo.name}">
						<input type="hidden" name="thumNail" value="${sessionScope.loginInfo.sysname}">
						<section>
							<div class="tit_s3">
								<h4>토론 주제</h4>
							</div>
							<input type="text" name="title" id="title">
							<div class="wordsize"><span class="current">0</span>/100</div>
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
							<div id="languageList" >
								<select name="language">
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
								<div class="wordsize"><span class="current">0</span>/1000</div>
							</div>
						</section>
						<div class="btnS1 right">
							<div>
								<input type="submit" value="전송">
							</div>
							<div><a href="javascript:window.history.back();">돌아가기</a></div>
						</div>						
					</form>
				</div>
			</article>
		</section>
	</div>
	
	
<jsp:include page="/WEB-INF/views/footer.jsp"/>