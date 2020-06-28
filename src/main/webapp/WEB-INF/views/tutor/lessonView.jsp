<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/header.jsp" />

<script>
	$(function() {
		$("#lessonCancle").on("click", function() {
			var url = "lessonCancle";
			var name = "Lesson Cancle";
			var option = "width = 500, height = 500, top = 100, left = 200"
			window.open(url, name, option);
		})
	})
</script>


<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<article id="lessonView" class="inner1200">

			<div class="tit_s1">
				<h2>강의 View</h2>
			</div>

			<div class="btnS1 right">
				<p>
					<a href="/tutor/lessonApp" class="on">강의 수정</a>
					<input type="button" id="lessonCancle" class="on" value="강의 삭제">
				</p>
			</div>

		</article>
	</section>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp" />