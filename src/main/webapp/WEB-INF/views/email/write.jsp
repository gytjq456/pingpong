<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

<style>
	#layerPop_s3 { position:fixed; left:0; top:0; width:100%; height:100%; z-index:10001; display:none;  background:rgba(0,0,0,0.5);  }
	#layerPop_s3 .pop_body { position:absolute; left:50%; top:50%; transform:translate(-50%, -50%); max-width:640px; background:#fff; padding:30px 20px; box-sizing:border-box;}
	#layerPop_s3 .tit_s3 { text-align:center; font-weight:700; font-size:20px; border-bottom:1px solid #ddd; padding-bottom:12px; margin-bottom:12px;}
	#layerPop_s3 .tit {  font-weight:700; }
	#layerPop_s3 .info {}
	#layerPop_s3 .info > dl { overflow:hidden; margin-bottom:10px;}
	#layerPop_s3 .info > dl:last-child { margin:0; }
	#layerPop_s3 .info > dl dt { margin-right:10px;} 
	#layerPop_s3 .info > dl dt, 
	#layerPop_s3 .info > dl dd  { float:left; }
	#layerPop_s3 .txtBox { margin-top:10px; }
	#layerPop_s3 .email_title { margin-top:10px; }
	#layerPop_s3 .contents { margin-top:10px; }
</style>

<script>
 	$(function(){
		var writeEmail = $("#writeEmail");
	    $('a[href="#writeEmail"]').click(function(e) {
	    	e.preventDefault();
	     	 $("#writeEmail").stop().fadeIn();
	     	 var seq = $(this).data("seq");
	     	 var name = $(".list_"+seq).find(".name").text();
	     	 var email = $(".list_"+seq).find(".email").text();
	     	 alert(name)
	     	writeEmail.find("#receiverName").val(name);
	     	writeEmail.find("#sendrMail").val(email);
	    });
    
		 $("#emailForm").submit(function(){
			 var formData = new FormData($("#emailForm")[0]);
			$.ajax({
				url:"/partner/send",
				data:formData,
				type:"post",
				dataType:"json",
				cache:false,
				contentType:false,
				processData:false
			}).done(function(resp){
				alert("test :" + resp)
			})
			return false;
		})
		
		$('a[href="#writeEmail"]').click(function(event) {
		      event.preventDefault();
		 
		      $(this).modal({
		        fadeDuration: 250
		      });
		    });
		
	})
</script>

<article id="layerPop_s3">
	<div class="pop_body">
		<div class="tit_s3">
			<h4>이메일 보내기</h4>
		</div>
		<form action="" id="emailProc" method="post">
			<input type="hidden" name="reporter" value="${loginInfo.id}">
			<input type="hidden" name="parent_seq" value="">
			<input type="hidden" name="id" value="">
			<input type="hidden" name="commSeq" value="">
			
			<div class="info">
				<dl class="receiver">
					<dt class="tit">받는 사람:</dt>
					<dd>${loginInfo.id}</dd>
				</dl>
				<dl class="receiver_email">
					<dt class="tit">발신자 이메일 :</dt>
					<dd>${loginInfo.email}</dd>
				</dl>
				<dl class="email_password">
					<dt class="tit">이메일 비밀번호 :</dt>
					<dd>${loginInfo.email}</dd>
				</dl>
				<dl class="email_password">
					<dt class="tit">수신자 이메일 :</dt>
					<dd>${pdto.email}</dd>
				</dl>
				
				<div data-seq="${pdto.seq}" class="txtBox">
					<article>
						<div class="tit">제목</div>
						<div class="email_title">
							<textarea rows="5" cols="50" name="contents" ></textarea>
						</div>
						<div class="tit">내용</div>
						<div class="contents">
							<textarea rows="30" cols="50" name="contents" ></textarea>
						</div>
						<div class="btns_s3">
						<p><button>보내기</button></p>
						<p><input type="button" id="backPage" value="닫기"></p>
					</div>
					</article>
				</div>
			</div>
		</form>
	</div>
</article>
<div class=modal>
	<div id="writeEmail">
		<div id="" class="emailPop">
			<h2>이메일 보내기</h2>
			<form id="emailForm"> 
			<!-- post방식으로 자료를 컨트롤러로 보냄 -->
				<input type="hidden" name="seq" value="${pdto.seq}">
				받는 사람  : <input name="name" value="${pdto.name}"><br>
				발신자 이메일 : <input name="memail" value="${loginInfo.email}"><br>
				이메일 비밀번호 : <input type="password" name="emailPassword"><br>
				수신자 이메일 : <input name="email" value="${pdto.email}"><br>
				제목 : <input name="subject"><br>
				내용 : <textarea rows="5" cols="80" name="contents"></textarea><br>
				<input type="submit" value="전송" id="send">
			</form>
		</div>
	</div>	
</div>
	