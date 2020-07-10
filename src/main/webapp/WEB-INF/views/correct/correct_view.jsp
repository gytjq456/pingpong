<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/header.jsp" />


<script>
	$(function() {
		$('#form').submit(function() {
			console.log(form);
			var formData = new FormData($('#form')[0]);
			console.log(formData);
			$.ajax({
				url : "/correct/commentProc",
				type : "post",
				datatype : "json",
				data : formData,
				cache : false,
				contentType : false,
				processData : false
			}).done(function(resp) {
				if (resp) {
					alert("댓글 작성이 완료 되었습니다.")
					location.href = "/correct/correct_view?seq=${dto.seq}"
				}
			})
			return false;
		})
		
		$("#modify").click(function() {
			location.href="/correct/correct_modify?seq=${dto.seq}"
		})
		
		var checkLikeVal = ${checkLike};
		console.log(checkLikeVal);
		$(".correct_like").click(function() {
			
			var seq = $(this).data("seq");
			if(checkLikeVal) {
				$.ajax ({
					url : "/correct/likecancle",
					dataType : "json",
					type : "post",
					data : {seq:seq}
				}).done(function(resp) {
					if(resp) {
						location.href = "/correct/correct_view?seq=${dto.seq}"
					}
				})
			}else {
			
			$.ajax({
				url : "/correct/like",
				dataType : "json",
				type : "post",
				data : {seq:seq}
			}).done(function(resp) {
				if(resp) {
					location.href = "/correct/correct_view?seq=${dto.seq}"
				}
			})
			}
			
		})
		
		
		$("#delete").click(function() {
			var seq = $(this).data("seq");
			$.ajax({
				url : "/correct/delete",
				dataType : "json",
				type : "post",
				data : {seq:seq}
			}).done(function(resp) {
				if(resp) {
					location.href = "/correct/correct_list"
				}
			})
			
		})
	})
		
		
		
</script>

<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<article id="discussion_list" class="inner1200">

			<div class="write_view">
				<div>제목 : ${dto.title}</div>
				<div>작성자 : ${dto.writer}</div>
				<div>등록 기간 : ${dto.write_date}</div>
				<div>질문 언어 : ${dto.language}</div>
				<div>유형 : ${dto.type}</div>
				<div>
					<button>조회수 : ${dto.view_count}</button>
					<button class="correct_like" data-seq ="${dto.seq}">좋아요 : ${likecount}</button>

				</div>
				<div>내용 : ${dto.contents}</div>
				<div>댓글 (${dto.reply_count})</div>
				<button type="button" id="modify">글수정</button>
				<button type="button" id="delete" data-seq="${dto.seq}">글삭제</button>
				<button type="button" id="historyBack">뒤로가기</button>
			</div>
			<div id="comment">
				<form id="form">
					<input type="hidden" name="writer" value="박선호2"> <input
						type="hidden" name="title" value="안녕하세요"> <input
						type="hidden" name="parent_seq" value="${dto.seq}">
					<div class="text">
						<textarea name="contents" id="text"></textarea>
					</div>
					<input type="submit" value="등록"> <input type="reset"
						value="취소">
				</form>
			</div>
			<br><div>베스트 댓글</div><br>
			<c:forEach var="u" items="${cdto2}">
				<div class="info">
					<p class="userId">${u.writer}</p>
					<p class="writeDate">${u.write_date}</p>
				</div>

				<div class="cont">
					<div class="contents">${u.contents}</div>
				</div>
			</c:forEach>


    		<br><br><div>전체댓글</div><br>
			<c:forEach var="i" items="${cdto}">
				<div class="info">
					<p class="userId">${i.writer}</p>
					<p class="writeDate">${i.write_date}</p>
				</div>

				<div class="cont">
					<div class="contents">${i.contents}</div>
				</div>
			</c:forEach>

		</article>
	</section>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp" />