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
<style>
	#layerPop_s2 { position:fixed; left:0; top:0; width:100%; height:100%; z-index:10001; display:none;  background:rgba(0,0,0,0.5); paddint: 15px; }
	#layerPop_s2 .pop_body { position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); max-width:640px; background:#fff;}
	#layerPop_s2 .tit_s3 { margin: 12px; text-align: center; font-size: 20px; font-weight: bold; }
	#layerPop_s2 .checkAgree { color: #999; }
	#layerPop_s2 .checkLabel { vertical-align: middle; }
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
					<input type="checkbox" id="agree" required><label for="agree" class="checkLabel">프로필 공유 동의</label><br>
					<div class="checkAgree">* 프로필 공유에 동의하지 않으면 신청서 제출이 불가능합니다.</div>
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
