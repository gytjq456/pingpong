<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/header.jsp" />

<style>
.main_wrapper {
	width: 100%;
	border: 1px solid black;
}

.top_wrapper {
	width: 100%;
	height: 130px;
	border: 1px solid black;
}

.profile {
	width: 30%;
	height: 100%;
	border: 1px solid black;
	float: left;
}

.info {
	width: 70%;
	height: 100%;
	border: 1px solid black;
	float: left;
	border: 1px solid black;
}

.bottom_wrapper {
	margin-top: 30px;
	width: 100%;
	border: 1px solid black;
	width: 100%;
}

.left_title {
	width: 10%;
	border: 1px solid black;
	float: left;
}

.right_contents {
	width: 90%;
	border: 1px solid black;
	float: left;
}

.botton_main {
	width: 100%;
}

.main {
	float: left;
	width: 10%;
}

.contents {
	float: left;
	width: 90%;
}
</style>

<script>
	$(function() {
		$("#fileAdd").on("click", function() {
			var fileComp = $("<div><input type=file name=files></div>");
			$("#fileAdd").after(fileComp);
		})
	})
</script>

<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<article id="tutorApp_view" class="inner1200">

			<h6>튜터 신청서</h6>
			<form action="tutorAppSend" method="post" enctype="multipart/form-data">
			
				<div class="top_wrapper">
					<div class="profile">
						<img
							src="${pageContext.request.contextPath}/resources/img/common/alram.png">
					</div>
					<div class="info">
						<p id="name">이름 : 홍길동 ${list.name}</p>
						<p id="age">나이 : ${list.age}</p>
						<p id="country">국적 : ${list.country}</p>
						<p id="phone">전화번호 : ${list.phone}</p>
						<p id="email">이메일 : ${list.email}</p>
						<p id="lang_can">구사언어 : ${list.lang_can}</p>
					</div>
				</div>

				<div class="bottom_wrapper">
					<div class="bottom_main">
						<div class="title_main main">제목</div>
						<div class="title_contents contents">
							<input type="text" id="title" name="title"
								value="${list.name}-튜터신청합니다." readonly>

						</div>
					</div>
					<div class="bottom_main">
						<div class="license_main main">자격증</div>
						<div class="license_contents contents">
							(자격증사진을 찍어 첨부해주세요.)
							<input type="button" id="fileAdd" name="files" value="파일첨부[+]">
						</div>
					</div>
					<div class="bottom_main">
						<div class="career_main main">경력</div>
						<div class="career_contents contents">
							<textarea id="career" name="career" placeholder="경력"></textarea>
						</div>
					</div>
					<div class="bottom_main">
						<div class="exp_main main">해외경험</div>
						<div class="exp_contents contents">
							<textarea id="exp" name="exp" placeholder="해외경험"></textarea>
						</div>
					</div>
					<div class="bottom_main">
						<div class="introduce_main main">자기소개</div>
						<div class="introduce_contents contents">
							<textarea id="introduce" name="introduce" placeholder="자기소개"></textarea>
						</div>
					</div>
					<div class="bottom_main">
						<div class="recomm_main main">추천인</div>
						<div class="recomm_contents contents">
							<input type="text" id= "recomm" name="recomm" placeholder="추천인">
						</div>
					</div>

				</div>
				
				<button>신청하기</button>
				<input type="button" value="돌아가기">
				
			</form>
		</article>
	</section>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp" />