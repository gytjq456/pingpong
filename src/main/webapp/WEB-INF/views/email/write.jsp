<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<!-- <style>
	.emailPop { position:fixed; left:0; top:0; width:100%; height:100%; z-index:10001; display:none;  background:rgba(0,0,0,0.5); paddint: 15px; }
</style> -->
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
	
	
