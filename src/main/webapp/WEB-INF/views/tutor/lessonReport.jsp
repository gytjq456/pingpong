<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
	#layerPop_s2 { position:fixed; left:0; top:0; width:100%; height:100%; z-index:10001; display:none;  background:rgba(0,0,0,0.5); }
	#layerPop_s2 .pop_body { position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); max-width:640px; background:#fff;}
</style>

<script>
$(function(){
	var layerPop_s2 = $("#layerPop_s2");
	$("#report").on("click", function(){
		console.log($(this).css('color'));
		//rgb(39, 91, 160)
		var seq = ${seq};
		var idVal = '${ldto.id}';
		$.ajax({
			url:"/tutor/report",
			data:{
				parent_seq: seq,
				id : idVal
			},
			type: 'POST'
		}).done(function(resp){
			console.log(resp);
			if(resp>0){
				alert("이미 신고 요청이 되었습니다. 대기해주세요.");
				return false;
			}
			layerPop_s2.stop().fadeIn();
		}).fail(function(error1, error2) {
			console.log(error1);
			console.log(error2);
		})

	})
	
	$("#backReport").on("click", function(){
		layerPop_s2.stop().fadeOut();
	})
})


</script>

<article id="layerPop_s2">
	<div class="pop_body">
		<div class="tit_s3">
			<h4>강의 신고</h4>
		</div>
		<form action="reportProc" id="reportProc" method="post">
			<input type="hidden" name="reporter" value="${loginInfo.id}">
			<input type="hidden" name="parent_seq" value="${seq }">
			<input type="hidden" name="id" value="${ldto.id }">
			신고자 : ${loginInfo.id} <br>
			게시물 올린 사람 : ${ldto.id }
			<section data-seq="${seq }">
				<article>
					<div>신고사유</div>
					<div class="reportContents">
						<textarea rows="30" cols="50" name="reason"></textarea>
					</div>
					<div>
						<button>제출하기</button>
						<input type="button" id="backReport" value="닫기">
					</div>
				</article>
			</section>
		</form>
		
		
	</div>
</article>
