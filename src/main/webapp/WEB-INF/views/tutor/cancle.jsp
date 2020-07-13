 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



<script>
	$(function() {
		var layerPop_s1 = $("#layerPop_s1");
		$("#popOnBtn").on("click", function() {
			var parent_seqVal = '${seq}';
			var categoryVal = '${ldto.category}';
			console.log(parent_seqVal);
			$.ajax({
				url: "/tutor/lessonCancle",
				data:{
					'parent_seq': parent_seqVal,
					'category' : categoryVal
				},
				type: 'POST'
			}).done(function(resp){
				console.log(resp)
				if(resp>0){
					alert("이미 강의취소 요청이 되었습니다. 대기해주세요.");
					return false;
				}
				layerPop_s1.stop().fadeIn();
			}).fail(function(error1, error2) {
				console.log(error1);
				console.log(error2);
			})

		})
		
		$("#cancleProc").submit(function(){
			var txt = $("#cancleProc textarea").val();
			if(txt == ""){
				alert("취소 사유를 입력해주세요.");
				return false;
			}
		})		
		
		$("#back").on("click", function(){
			layerPop_s1.stop().fadeOut();
			$("#cancleProc textarea").val("");
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
	})
</script>
<style>
	#layerPop_s1 { position:fixed; left:0; top:0; width:100%; height:100%; z-index:10001; display:none;  background:rgba(0,0,0,0.5);  }
	#layerPop_s1 .pop_body { position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); max-width:640px; background:#fff; padding:30px 20px; box-sizing:border-box;}
	#layerPop_s1 .tit_s3 { text-align:center; font-weight:700; font-size:20px; border-bottom:1px solid #ddd; padding-bottom:12px; margin-bottom:12px;}
	#layerPop_s1 .tit {  font-weight:700; }
	#layerPop_s1 .info {}
	#layerPop_s1 .info > dl { overflow:hidden; margin-bottom:10px;}
	#layerPop_s1 .info > dl:last-child { margin:0; }
	#layerPop_s1 .info > dl dt { margin-right:10px;} 
	#layerPop_s1 .info > dl dt, 
	#layerPop_s1 .info > dl dd  { float:left; }
	#layerPop_s1 .txtBox { margin-top:10px; }
	#layerPop_s1 .reportContents { margin-top:10px; }
</style>



<article id="layerPop_s1">
	<div class="pop_body"> 
		<div class="tit_s3">
			<h4>강의 취소 신청서</h4>
		</div>		
		<form action="cancleProc" id="cancleProc" method="post">
			<input type="hidden" name="id" value="${ldto.id}">
			<input type="hidden" name="parent_seq" value="${seq}">
			<input type="hidden" name="category" value="${ldto.category}" />
			<div class="info">
				<dl>
					<dt class="tit">id :</dt>
					<dd>${ldto.id }</dd>
				</dl>
			</div>			
			<div data-seq="${seq}" class="txtBox">
				<article>
					<div class="tit">취소이유</div>
					<div class="contents reportContents">
						<textarea rows="30" cols="50" name="contents"></textarea>
					</div>
					<div class="btns_s3">
						<p><button>제출하기</button></p>
						<p><input type="button" id="back" value="닫기"></p>
					</div>

				</article>
			</div>
		</form>
	</div>
</article>
