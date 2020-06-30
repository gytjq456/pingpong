<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/header.jsp" />
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>

<script>
	$(function() {
		$("#apply_start").datepicker({
			showOn : "both",
			buttonImage : "/resources/img/common/alram.png",
			buttonImageOnly : true,
			buttonText : "",
			onSelect : function(dateText, inst) {
				console.log(dateText);
			}
		});

		$("#apply_end").datepicker({
			showOn : "both",
			buttonImage : "/resources/img/common/alram.png",
			buttonImageOnly : true,
			buttonText : "",
			onSelect : function(dateText, inst) {
				console.log(dateText);
			}
		});
	});
</script>


<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<article id="lessonApp_view" class="inner1200">
			<div class="tit_s1">
				<h2>Lesson</h2>
				<p>새 강의 등록하기</p>
			</div>

			<div class="title_main">
				<div class="title_wrap">
					<div class="left">제목 &nbsp;&nbsp;&nbsp;</div>
					<div class="right">
						<input type="text" id="title" name="title"
							placeholder="강의 성격이 드러날 키워드를 포함하여 간결한 제목으로 설정해 주세요.">
					</div>

				</div>
			</div>

			<div class="price_main">
				<div class="price_wrap">
					<div class="left">가격 &nbsp;&nbsp;&nbsp;</div>
					<div class="right">
						<input type="text" id="price" name="price" placeholder="시간당 가격">
						원 /시간
					</div>
				</div>
			</div>

			<div class="language_main">
				<div class="language_wrap">
					<div class="left">언어 &nbsp;&nbsp;&nbsp;</div>
					<div class="right">
						<select id="language" name="language">
							<c:forEach var="i" items="${lanList}">
								<option value="${i.language}">${i.language}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>


			<div class="apply_date">
				<input type="text" id="apply_start" name="apply_start" size="12">
				~ <input type="text" id="apply_end" name="apply_end" size="12">
			</div>


		</article>
	</section>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp" />