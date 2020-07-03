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
		

	})
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
		<article id="discussion_list" class="inner1200">

			<p>질문 수정하기</p>
			<form action="/correct/modifyProc" method="post">
				<input type="hidden" name="seq" value="${dto.seq}"> 
				<input type="hidden" name="writer" value="${dto.writer}"> 
				<label>카테고리</label>
				<select value="${dto.type}" name="type">
					<option label="첨삭" value="첨삭"></option>
					<option label="번역" value="번역"></option>
				</select>
				<p>
					제목   <input type="text" name="title" value="${dto.title}">
				</p>
				<input type="hidden" name="language" value="${dto.language}">
				<textarea id="summernote" name="contents">${dto.contents}</textarea>
				<input type="submit" value="등록"> 
				<input type="reset"
					value="취소">
			</form>

		</article>
	</section>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp" />