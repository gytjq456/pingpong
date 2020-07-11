<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
	#layerPop_s3 { position:fixed; left:0; top:0; width:100%; height:100%; z-index:10001; display:none;  background:rgba(0,0,0,0.5); }
	#layerPop_s3 .pop_body { position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); max-width:640px; background:#fff;}
</style>

<script>
$(function(){
	var layerPop_s3 = $("#layerPop_s3");
	$("#report, .report").on("click", function(){
		var seq = $(this).data("seq");
		var idVal = $(this).data("id");
		var url = $(this).data("url");
		var proc = $(this).data("proc");
		var thisSeq = $(this).data("thisseq");
		if(thisSeq == ""){
			thisSeq = 0;
		}
		$("form").attr("action", proc);
		$("input[name=parent_seq]").val(seq);
		$("input[name=id]").val(idVal);
		$("input[name=commSeq]").val(thisSeq);
		reportFn(seq,idVal,url,thisSeq);
		
	})
	
	function reportFn(seq,idVal,url,thisSeq){
		//console.log($(this).css('color'));
		//rgb(39, 91, 160)
		//var seq = seq;
		//var idVal = id;
		$.ajax({
			url:url,
			data:{
				parent_seq: seq,
				id : idVal,
				commSeq:thisSeq
			},
			type: 'POST'
		}).done(function(resp){
			if(resp>0){
				alert("이미 신고 요청이 되었습니다. 대기해주세요.");
				return false;
			}
			layerPop_s3.stop().fadeIn();
		}).fail(function(error1, error2) {
			console.log(error1);
			console.log(error2);
		})
		
		$(".writer_id p").text(idVal);
	}
	
	$("#backReport").on("click", function(){
		layerPop_s3.stop().fadeOut();
	})
})


</script>

<article id="layerPop_s3">
	<div class="pop_body">
		<div class="tit_s3">
			<h4>그룹 신고</h4>
		</div>
		<form action="" id="grouptProc" method="post">
			<input type="hidden" name="reporter" value="${loginInfo.id}">
			<input type="hidden" name="parent_seq" value="">
			<input type="hidden" name="id" value="">
			<input type="hidden" name="commSeq" value="">
			신고자 : ${loginInfo.id} <br>
			<div class="writer_id">
				게시물 올린 사람 :
				<p></p>
			</div>
			
			<section data-seq="${gdto.seq}">
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
