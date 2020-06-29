<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/header.jsp" />

<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<article id="" class="inner1200">

			<div class="header">
				<h2>그룹 탈퇴 신청서</h2>
			</div>
			<div>탈퇴이유</div>
			id: ${loginInfo.id }
			<section data-seq="${i.seq}">
				<article>
				<div class="category">
					<select>
						<option>그룹</option>
						<option>튜터</option>
						<option>강의</option>
					</select>
				</div>
				<div class="contents">
					<textarea rows="100" cols="100"></textarea>
				</div>
				
				</article>
			</section>

		</article>
	</section>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp" />