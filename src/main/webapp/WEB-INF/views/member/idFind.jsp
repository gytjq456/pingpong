<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/header.jsp" />

<script>
	$(function(){
		$("#idFind").submit(function(){
			var f_name = $("#f_name");
			var f_email = $("#f_email");
			
			if(f_name.val() == "" || f_email.val() == ""){
				alert("아이디와 이메일을 입력해주세요.");
				return false;
			}
			
			idFindProc1();
			return false;
		});	
		
		function idFindProc1(){
			var f_name = $("#f_name").val();
			var f_email = $("#f_email").val();
			
			$.ajax({
				url : "/member/idFindProc",
				type : "post",
				data : {
					name : f_name,
					email : f_email
				}
			}).done(function(resp){
				if(resp==0){
					alert("입력하신 값이 일치하지 않습니다.");					
				}else{
					location.href="/member/idResult?name="+f_name+"&email="+f_email;
				}
			}).fail(function(error1, error2){
				console.log(error1);
				console.log(error2);
				return false;
			});			
		}	
	});
</script>

	<div id="subWrap" class="hdMargin">
		<section id="subContents">
			<article id="" class="inner1200">
				<div id="login" class="card_body">
					<div class="tit_s1">
						<h3>아이디 찾기</h3>
					</div>				
					<form id="idFind">
						<div><input type="text" id="f_name" name="name" placeholder="이름을 입력해주세요"></div>
						<div><input type="text" id="f_email" name="email" placeholder="이메일을 입력해주세요"></div>
						<div></div>
						<div class="btnS1 center ">
							<input type="submit" id="submitBtn">
						</div>
					</form>
				</div>
			</article>
		</section>
	</div>

				

<jsp:include page="/WEB-INF/views/footer.jsp" />