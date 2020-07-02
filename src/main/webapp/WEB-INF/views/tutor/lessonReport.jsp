<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
	#layerPop_s1 { position:fixed; left:0; top:0; width:100%; height:100%; z-index:10001; display:none;  background:rgba(0,0,0,0.5); }
	#layerPop_s1 .pop_body { position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); max-width:640px; background:#fff;}
</style>

<script>
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
		
	})

})

</script>

<article id="layerPop_s1">
	<div class="pop_body">
		<div class="tit_s3">
			<h4>강의 신고</h4>
		</div>
		
		
	</div>
</article>
