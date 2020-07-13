<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/header.jsp" />

<script>
	$(function(){
		$("#pwFindProc").submit(function(){
			var f_id = $("#f_id");
			var f_name = $("#f_name");
			var f_email = $("#f_email");
			
			
			if(f_id.val() == ""){
				alert("아이디를 입력해주세요.");
				f_id.focus();
				return false;
			}else if(f_name.val() == ""){
				alert("이름을 입력해주세요.");
				f_name.focus();
				return false;
			}else if(f_email.val() == ""){
				alert("이메일을 입력해주세요.");
				f_email.focus();
				return false;
			};
			
			pwFindProc1();
			return false;
		});
		
		function pwFindProc1(){
			var idVal = $("#f_id").val();
			var nameVal =$("#f_name").val();
			var emailVal =$("#f_email").val();
			$.ajax({
				url : "/member/pwFindProc",
				type : "post",
				data : {
					id : idVal,
					name : nameVal,
					email : emailVal
				}
			}).done(function(resp){
				if(resp>0){
					location.href="/member/pwModify?id=" + idVal + "&name="+ nameVal + "&email="+emailVal;
				}else{
					alert("입력하신 값이 일치하지 않습니다.");
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
						<h3>패스워드 찾기</h3>
					</div>				
					<form id="pwFindProc">
						<div><input type="text" id="f_id" name="id" placeholder="아이디을 입력해주세요"></div>
						<div><input type="text" id="f_name" name="name" placeholder="이름을 입력해주세요"></div>
						<div><input type="text" id="f_email" name="email" placeholder="이메일을 입력해주세요"></div>					
						<div class="btnS1 center ">
							<input type="submit" id="submitBtn">
						</div>
					</form>
				</div>
			</article>
			
			
			
			
		</section>
	</div>

<jsp:include page="/WEB-INF/views/footer.jsp" />