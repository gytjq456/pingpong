<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/header.jsp" />

<script>
	$(function() {
		$('#summernote').summernote({
			height : 300,

			callbacks : {
				onImageUpload : function(files) {
					console.log(files)
					console.log(files[0])
					uploadSummernoteImageFile(files[0], this);
				}
			}
		});
		
		
		$("input,textarea").blur(function(){
			var thisVal = $(this).val();
			$(this).val(textChk(thisVal));
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
				console.log(data)
				$(editor).summernote('insertImage', data.url);
			}
		});
	}
</script>

<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<article id="discussion_write" class="inner1200">
			<div class="tit_s1">
				<h2>Question</h2>
				<p>새 질문 게시하기</p>
			</div>
			<div class="card_body">
				<form action="/correct/writeProc" method="post">
					<input type="hidden" value="${sessionScope.loginInfo.id}" name="writer">
					<input type="hidden" value="한국어" name="language">
					<input type="hidden" value="${loginInfo.sysname}" name="thumNail">
					
					<section>
						<div class="tit_s3">
							<h4>제목</h4>
						</div>
						 <input type="text" name="title" required>
					</section>
					
					<section>
						<div class="tit_s3">
							<h4>카테고리</h4>
						</div>
						<select name="type">
							<option label="첨삭" value="첨삭"></option>
							<option label="번역" value="번역"></option>
						</select>
					</section>
					<section>
						<div class="tit_s3">
							<h4>질문 내용</h4>
						</div>
						<textarea id="summernote" name="contents"></textarea>
					</section>
					<!--  -->
				
					<div class="btnS1 right">
						<div>
							<input type="submit" value="등록"> 
						</div>
						<div><a href="javascript:window.history.back();">돌아가기</a></div>
					</div>
						
				</form>
			</div>
		</article>
	</section>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp" />