<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	$(function(){
		var layerPop_s2 = $("#layerPop_s2");
		$("#applyForm").on("click", function(){
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
<style>
	#layerPop_s2 { position:fixed; left:0; top:0; width:100%; height:100%; z-index:10001; display:none;  background:rgba(0,0,0,0.5); }
	#layerPop_s2 .pop_body { position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); max-width:640px; background:#fff;}
</style>
<article id="layerPop_s2">
	<div class="pop_body">
		<div class="tit_s3">
			<h3>그룹 참가 신청서</h3>
		</div>
		<form action="/group/apply" method="post">
			<input type="hidden" name="parent_seq" value="${gdto.seq}">
			<section>
				<article>
					<input type="checkbox" id="agree" required><label for="agree">프로필 공유 동의</label><br>
					* 프로필 공유에 동의하지 않으면 신청서 제출이 불가능합니다.<br>
					<div>가입 이유/포부</div>
					<div class="contents">
						<textarea rows="30" cols="50" name="contents" id="app_contents"></textarea>
					</div>
					<div>
						<button>제출</button>
						<input type="button" id="back2" value="닫기">
					</div>
				</article>
			</section>
		</form>
	</div>
</article>
