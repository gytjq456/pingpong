<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
	#layerPop_s5 { position:fixed; left:0; top:0; width:100%; height:100%; z-index:10001; display:none; background:rgba(0,0,0,0.5);  }
	#layerPop_s5 .pop_body { position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); max-width:640px; background:#fff; padding:30px 20px; box-sizing:border-box;}
	#layerPop_s5 .tit_s3 { text-align:center; font-weight:700; font-size:20px; border-bottom:1px solid #ddd; padding-bottom:12px; margin-bottom:12px;}
	#layerPop_s5 .tit {  font-weight:700; }
	#layerPop_s5 .info {}
	#layerPop_s5 input[type="password"],
	#layerPop_s5 input[type="text"] { border:1px solid #ddd; border-radius:6px; width:100%; padding:5px 10px; font-size:12px; width:100%;}
	#layerPop_s5 .info > dl { overflow:hidden; margin-bottom:14px;}
	#layerPop_s5 .info > dl:last-child { margin:0; }
	#layerPop_s5 .info > dl dt { margin-bottom:10px; } 
	#layerPop_s5 .info > dl dd {}
	#layerPop_s5 .info > dl { float:left; width:48%; margin-right:4%; } 
	#layerPop_s5 .info > dl:nth-child(2n) { margin-right:0; } 
	#layerPop_s5 .txtBox { margin-top:10px; }
</style>

<script>
 	$(function(){
    
		 
	})
</script>

	<article id="layerPop_s5">
		<div class="pop_body">
			<div class="tit_s3">
				<h4>이메일 보내기 </h4>
				<p>이메일은 실제로 사용하시는 정보를 입력하셔야 합니다.</p>
			</div>
			<form id="emailForm"> 
				<c:if test="${!empty pdto.seq}">
					<input type="hidden" name="seq" value="${pdto.seq}">
				</c:if>
				<c:if test="${empty pdto.seq}">
					<input type="hidden" name="seq" value="">
				</c:if>
				
				<div class="info clearfix">
					<dl>
						<dt class="tit">받는이 </dt>
						<c:if test="${!empty pdto}">
							<dd><input type="text" name="name" value="${pdto.name}"></dd>
						</c:if>
						<c:if test="${empty pdto}">
							<dd><input type="text" name="name" value=""></dd>
						</c:if>
					</dl>
					<dl class="">
						<dt class="tit">발신자 이메일</dt>
						<dd><p><input type="text" name="memail" value="${loginInfo.email}"></p></dd>
					</dl>
					<dl class="">
						<dt class="tit">이메일 비밀번호</dt>
						<dd><p><input type="password" name="emailPassword" ></p></dd>
					</dl>
					<dl class="">
						<dt class="tit">수신자 이메일</dt>
						<c:if test="${!empty pdto}">
							<dd><p><input type="text" name="email" value="${pdto.email}"></p></dd>
						</c:if>
						<c:if test="${empty pdto}">
							<dd><p><input type="text" name="email" value=""></p></dd>
						</c:if>
					</dl>
					<dl class="">
						<dt class="tit">제목</dt>
						<dd><p><input type="text" name="subject"></p></dd>
					</dl>
				</div>
				<div data-seq="" class="txtBox">
					<article>
						<div class="tit">내용</div>
						<div class="txtBox">
							<textarea rows="5" cols="80" name="contents"></textarea>
						</div>
						<div class="btns_s3">
							<p><input type="submit" value="전송" id="send"></p>
							<p><input type="button" class="back" value="닫기"></p>
						</div>
					</article>
				</div>
			</form>
		</div>
		<script>
	 		$(function(){
	 			var layerPop_s5 = $("#layerPop_s5");
				 $("#emailForm").on("submit",function(){
					 var formData = new FormData($("#emailForm")[0]);
					 setTimeout(function(){
						$.ajax({
							url:"/partner/send",
							data:formData,
							type:"post",
							dataType:"json",
							cache:false,
							contentType:false,
							processData:false
						}).done(function(resp){
							alert("이메일이 발송되었습니다.");
							layerPop_s5.stop().fadeOut();
							$("input[name='emailPassword']").val("");
							$("input[name='subject']").val("");
							$("textarea[name='contents']").val("");
						})
					 })
					return false;
				})
				
				$(".back").click(function(){
					layerPop_s5.stop().fadeOut();
					$("input[name='emailPassword']").val("");
					$("input[name='subject']").val("");
					$("textarea[name='contents']").val("");
				})
				$(".email_a").click(function(){
					if("${pdto}" == ""){
						var seq = $(this).data("seq");
						var name = $(this).data("name");
						var email = $(this).data("email");
						$("input[name='seq']").val(seq);
						$("input[name='name']").val(name);
						$("input[name='email']").val(email);
					}
					layerPop_s5.stop().fadeIn();
				})
	 		})
		</script>  
	</article>

