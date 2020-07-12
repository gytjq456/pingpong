<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/header.jsp" />

<script>
	$(function() {
		var totalSize=0;
		
		$("input, textarea").blur(function(){
			var thisVal = $(this).val();
			$(this).val(textChk(thisVal));
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
		
		//용량제한하기
		$(".license_contents").on('change','input[type=file]',function(e){

			if(!$(this).val()) {return false};
			var f = this.files[0];
			
			var size = f.size || f.fileSize;
			console.log(f.size + ":" +f.fileSize);
			var limit = 1024*1024*5;
			if(size > limit){
				alert("파일용량 5GB을 초과했습니다.");
				$(this).val("");
				return false;
			}
			totalSize = totalSize+size;
			console.log(totalSize);
		})
		
		//파일 첨부 여러개
		$("#fileAdd").on("click", function() {
			var fileComp = $("<div class='fileDiv'><input type=file class='file' name=files><button type='button' class='fileDelete'>삭제</button></div>");
			$("#fileAdd").after(fileComp);
		})
		
		//파일 첨부한거 지우기 / 사이즈도 같이지우기
		$(".license_contents").on("click",".fileDelete", function(e){
			console.log($(this).parent());
		
			console.log($(this).siblings());
			var f = ($(this).siblings())[0].files[0];
			
			/* console.log(($(this).siblings())[0].files[0]); */
			if(f==null){
				$(this).parent().remove();
			}else{
				var size = f.size || f.fileSize;
				totalSize = totalSize-size;
				console.log(totalSize);
				$(this).parent().remove();
			}

		})
		
		// 글자수 체크 -3개 다
		wordSize($(".tutorApp_view").find("#career"));
		wordSize($(".tutorApp_view").find("#exp"));
		wordSize($(".tutorApp_view").find("#introduce"));
		function wordSize(obj){
			obj.keyup(function(){
				var word = $(this).val();
				var wordSize = word.length;
				console.log(wordSize)
				if(wordSize <= 1000){
					$(this).siblings().find(".current").text(wordSize);
					//$(".wordsize .current1").text(wordSize);
				}else{
					word = word.substr(0,1000);
					$(this).siblings().find(".current").text(word.length);
					//$(".wordsize .current1").text(word.length);
					$(this).val(word);
					alert("1000자 이하로 작성해 주세요")
				}			
			})
		}
		
	})
</script>

<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<!-- tutorApp_view -->
		<article id="discussion_write" class="inner1200 tutorApp_view">
 			<div class="tit_s1">
				<h2>튜터 신청서</h2>
			</div>
			<form id ="frm" action="tutorAppSend" method="post" enctype="multipart/form-data">
			
				<div class="top_wrapper">
					<div class="profile">
						<%-- <img src="/upload/member/${loginInfo.id}/${loginInfo.sysname}"> --%>
						<img src="/resources/img/sub/userThum.jpg">
					</div>
					<div class="info">
						<p id="name"><span>이름 :</span> ${loginInfo.name}</p>
						<p id="age"><span>나이 :</span> ${loginInfo.age}</p>
						<p id="country"><span>국적 :</span> ${loginInfo.country}</p>
						<p id="phone"><span>전화번호 :</span> ${loginInfo.phone}</p>
						<p id="email"><span>이메일 :</span> ${loginInfo.email}</p>
						<p id="lang_can"><span>구사언어 :</span> ${loginInfo.lang_can}</p>
					</div>
				</div>

				<div class="bottom_wrapper card_body">
					<section class="bottom_main">
						<div class="tit_s3">
							<h4>제목</h4>
						</div>						
						<div class="title_contents contents">
							<input type="hidden" name="id" value="${loginInfo.id}">
							<input type="text" id="title" name="title" value="${loginInfo.name}-튜터신청합니다." readonly>
						</div>
					</section>
					<section class="bottom_main">
						<div class="tit_s3">
							<h4>자격증</h4>
						</div>						
						<div class="license_contents contents">
						*자격증사진을 찍어 첨부해주세요.
							<input type="button" id="fileAdd" name="files" value="파일첨부[+]">
						</div>
					</section>
					<section class="bottom_main">
						<!-- <div class="career_main main">경력</div> -->
						<div class="tit_s3">
							<h4>경력</h4>
						</div>						
						<div class="career_contents contents">
							<textarea class="wordCheck" id="career" name="career" placeholder="경력"></textarea>
							<div class="wordsize"><span class="current">0</span>/1000</div>
						</div>
					</section>
					<section class="bottom_main">
						<!-- <div class="exp_main main">해외경험</div> -->
						<div class="tit_s3">
							<h4>해외경험</h4>
						</div>							
						<div class="exp_contents contents">
							<textarea class="wordCheck" id="exp" name="exp" placeholder="해외경험"></textarea>
							<div class="wordsize"><span class="current">0</span>/1000</div>
						</div>
					</section>
					<section class="bottom_main">
						<!-- <div class="introduce_main main">자기소개</div> -->
						<div class="tit_s3">
							<h4>자기소개</h4>
						</div>							
						<div class="introduce_contents contents">
							<textarea class="wordCheck" id="introduce" name="introduce" placeholder="자기소개"></textarea>
							<div class="wordsize"><span class="current">0</span>/1000</div>
						</div>
					</section>
					<section class="bottom_main">
						<!-- <div class="recomm_main main">추천인</div> -->
						<div class="tit_s3">
							<h4>추천인</h4>
						</div>							
						<div class="recomm_contents contents">
							<input type="text" id= "recomm" name="recomm" placeholder="추천인">
						</div>
					</section>

					
					<div class="btnS1 right">
						<div>
							<button>신청하기</button>
						</div>
						<div><input type="button" value="돌아가기"></div>
					</div>				
				</div>
				
			</form>
		</article>
	</section>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp" />