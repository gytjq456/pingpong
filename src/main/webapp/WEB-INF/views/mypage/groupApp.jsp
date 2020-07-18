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

	
	/* 레이어 팝업 */
	#layerPop_s1 { position:fixed; left:0; top:0; width:100%; height:100%; z-index:10001; display:none; background:rgba(0,0,0,0.5); }
	#layerPop_s1 .pop_body { position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); max-width:640px; background:#fff; padding:20px; width:100%; box-sizing:border-box;}
	#layerPop_s1 .tit_s3 {text-align: center; font-size: 20px; font-weight: bold; border-bottom:1px solid #ddd; padding-bottom:12px; margin-bottom:12px;}
	#layerPop_s1 .checkAgree { color: #999; }
	#layerPop_s1 .checkLabel { vertical-align: middle; }
	#layerPop_s1 .checkLabel { vertical-align: middle; }
	#layerPop_s1 .tit { font-weight:500; }
	#layerPop_s1 article > div { margin-bottom:10px;}
	#layerPop_s1 article > div:last-child { margin:0; }
	#layerPop_s1 dl { overflow:hidden; margin-bottom:10px;}
	#layerPop_s1 dl:last-child { margin:0; }
	#layerPop_s1 dl dt { margin-right:4px;}
	#layerPop_s1 dl dd {}
	#layerPop_s1 dl dt,
	#layerPop_s1 dl dd { float:left; }
	#layerPop_s1 .info {}
	#layerPop_s1 .info > dl { }
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
				<div class="info">
					<dl>
						<dt class="tit">신청자 :</dt>
						<dd id="name_from_app"></dd>
					</dl>
					<dl>
						<dt class="tit">나이 :</dt>
						<dd id="age_from_app"></dd>
					</dl>
					<dl>
						<dt class="tit">성별 :</dt>
						<dd id="gender_from_app"></dd>
					</dl>
					<dl>
						<dt class="tit">구사 언어 :</dt>
						<dd id="lang_can_from_app"></dd>
					</dl>
					<dl>
						<dt class="tit">학습 언어:</dt>
						<dd id="lang_learn_from_app"></dd>
					</dl>
					<dl>
						<dt class="tit">주소:</dt>
						<dd id="add_from_app"></dd>
					</dl>
					<dl>
						<dt class="tit">가입 이유/포부</dt>
						<dd class="contents" id="contents_from_app"></dd>
					</dl>
				</div>				
				<div>
				</div>
				<div class="btns_s3">
					<p><button id="accept">승인</button></p>
					<p><button id="refuse">거절</button></p>
					<p><button id="back">닫기</button></p>
				</div>
			</article>
		</section>
	</div>
</article>
