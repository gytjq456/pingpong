<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	$(function(){
		var layerPop_s2 = $("#layerPop_s2");
		$("#applyForm").on("click", function(){
			var cur_num = ${gdto.cur_num};
			var max_num = ${gdto.max_num};
			
			if (cur_num == max_num) {
				alert('이미 정원이 다 찼습니다.');
				return false;
			}
			layerPop_s2.stop().fadeIn();
		})
		
		$('#app_contents').focusin(function(){
			var agree = $('#agree').is(':checked');
			if (!agree) {
				alert('프로필 공유에 동의해 주세요.');
				$('#agree').focus();
			}
		})
		
		$("#back2").on("click", function(){
			layerPop_s2.stop().fadeOut();
		})
	})
</script>

<article id="layerPop_s2">
	<div class="pop_body">
		<div class="tit_s3">
			<h3>그룹 참가 신청서</h3>
		</div>
		<form action="/group/apply" method="post">
			<input type="hidden" name="parent_seq" value="${gdto.seq}">
			<section>
				<article>
					<div>
						<ul class="checkBox_s1">
							<li>
								<input type="checkbox" id="agree" required>
								<label for="agree" class="checkLabel"><span></span>프로필 공유 동의</label>
							</li>
						</ul>
						<div class="checkAgree">* 프로필 공유에 동의하지 않으면 신청서 제출이 불가능합니다.</div>
					</div>
					<div class="tit">가입 이유/포부</div>
					<div class="contents">
						<textarea rows="30" cols="50" name="contents" id="app_contents"></textarea>
					</div>
					<div class="btns_s3">
						<p><button>제출</button></p>
						<p><input type="button" id="back2" value="닫기"></p>
					</div>
				</article>
			</section>
		</form>
	</div>
</article>
