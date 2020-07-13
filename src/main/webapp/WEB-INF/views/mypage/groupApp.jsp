<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	$(function(){
		var layerPop_s1 = $("#layerPop_s1");
		$(".app_accpet_btn").on("click", function(){
			var seq = $(this).parent().siblings('.app_seq').html();
			$.ajax({
				url: "/group/showApp",
				data: {
					seq: seq
				},
				type: "POST"
			}).done(function(resp){
				$('#seq_from_app').val(resp.seq);
				$('#parent_seq_from_app').val(resp.parent_seq);
				$('#name_from_app').html(resp.name + "(" + resp.id + ")");
				$('#age_from_app').html(resp.age);
				$('#gender_from_app').html(resp.gender);
				$('#lang_can_from_app').html(resp.lang_can);
				$('#lang_learn_from_app').html(resp.lang_learn);
				$('#add_from_app').html(resp.address);
				$('#contents_from_app').html(resp.contents);
				
				layerPop_s1.stop().fadeIn();
			})
		})
		
		$('#accept').on('click', function(){
			var conf = confirm('정말 승인하시겠습니까?');
			
			if (!conf) {
				return false;
			}
			
			var seq = $('#seq_from_app').val();
			var id = ($('#name_from_app').html().split('('))[1];
			var id = id.substring(0, id.length - 1);
			var parent_seq = $('#parent_seq_from_app').val();
			
			$.ajax({
				url: "/group/acceptApp",
				data: {seq: seq,
					id: id,
					parent_seq: parent_seq},
				type: "POST"
			}).done(function(resp){
				if (resp) {
					alert('성공적으로 승인하였습니다.');
					layerPop_s1.stop().fadeOut();
					$('#' + seq).remove();
				} else {
					alert('알 수 없는 이유로 실패하였습니다. 잠시 후 다시 시도해 주세요.');
				}
			})
		})
		
		$('#refuse').on('click', function(){
			var conf = confirm('정말 거절하시겠습니까?');
			
			if (!conf) {
				return false;
			}
			
			var seq = $('#seq_from_app').val();
			
			$.ajax({
				url: "/group/refuseApp",
				data: {seq: seq},
				type: "POST"
			}).done(function(resp){
				if (resp) {
					alert('성공적으로 거절하였습니다.');
					layerPop_s1.stop().fadeOut();
					$('#' + seq).remove();
				} else {
					alert('알 수 없는 이유로 실패하였습니다. 잠시 후 다시 시도해 주세요.');
				}
			})
		})
		
		$('#back').on('click', function(){
			layerPop_s1.stop().fadeOut();
		})
	})
</script>
<style>
	#layerPop_s1 { position:fixed; left:0; top:0; width:100%; height:100%; z-index:10001; display:none;  background:rgba(0,0,0,0.5); paddint: 15px; }
	#layerPop_s1 .pop_body { position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); max-width:640px; background:#fff;}
	#layerPop_s1 .tit_s3 { margin: 12px; text-align: center; font-size: 20px; font-weight: bold; }
	#layerPop_s1 .checkAgree { color: #999; }
	#layerPop_s1 .checkLabel { vertical-align: middle; }
</style>
<article id="layerPop_s1">
	<div class="pop_body">
		<div class="tit_s3">
			<h3>그룹 참가 신청서</h3>
		</div>
		<input type="hidden" id="seq_from_app">
		<input type="hidden" id="parent_seq_from_app">
		<section>
			<article>
				<div>
					<span>신청자</span>
					<span id="name_from_app"></span>
				</div>
				<div>
					<span>나이</span>
					<span id="age_from_app"></span>
					<span>성별</span>
					<span id="gender_from_app"></span>
				</div>
				<div>
					<span>구사 언어</span>
					<span id="lang_can_from_app"></span>
				</div>
				<div>
					<span>학습 언어</span>
					<span id="lang_learn_from_app"></span>
				</div>
				<div>
					<span>주소</span>
					<span id="add_from_app"></span>
				</div>
				<div>가입 이유/포부</div>
				<div class="contents" id="contents_from_app"></div>
				<div>
					<button id="accept">승인</button>
					<button id="refuse">거절</button>
					<button id="back">닫기</button>
				</div>
			</article>
		</section>
	</div>
</article>
