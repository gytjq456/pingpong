/* 회원가입 */
$(function(){
	//시군 
	new sojaeji('sido1', 'gugun1');
	
	$('#gugun1').change(function(){
         var sido = $('#sido1 option:selected').val();
         var gugun = $('#gugun1 option:selected').val();
         
         $('#address').val(sido + ' ' + gugun);
    });
	
	
		
	//아이디 중복 체크
	$("#duplcheckId").on("click",function(){
		$.ajax({
			url : "/member/duplcheckId",
			type : "post",
			data : {
				id : $("#id").val()
			}
		}).done(function(resp){
			if("true" == resp){
				alert("이미 사용중인 아이디 입니다.");
				$("#duplcheckId").attr("name","");
			}else{
				alert("사용가능한 아이디입니다.");
				$("#duplcheckId").attr("name","true");
			}    				
		}).fail(function(error1, error2){
			console.log(error1);
			console.log(error2);
		})
	});
	
	//비밀번호 일치
	$("#pw_ck").on("keyup",function(){
		var pwResult1 = $("#pw").val();
		var pwResult2 = $("#pw_ck").val();
		if(pwResult1 == pwResult2){
			$("#pwConfrom").text("비밀번호가 일치합니다.");
		}else{
			$("#pwConfrom").text("비밀번호가 하지 않습니다.");
		}
	});

	//유효성 검사
	$("#joinBtn").submit(function(){
		alert(id_ck + "아이디");
		alert(pw_ck + "비밀번호");
		
		var id_ck = $("#id").val();
		var pw_ck = $("#pw").val();
		var name = $("#name").val();
		var age = $("#age").val();
		var phone_country = $("#phone_country").val();
		var phone = $("#phone").val();
		var address = $("#address").val();
		var bank_name = $("#bank_name").val();//셀렉트
		var account = $("#account").val();
		var profile = $("#profile").val();//파일
		var country = $("#country").val();//셀렉트
		var lang_can = $("#lang_can").val();//체크박스
		var lang_learn = $("#lang_learn").val();//체크박스
		var hobby = $("#hobby").val();//체크박스
		var introduce = $("#introduce").val();//체크박스
		
		
		
		//아이디 정규식		
		//var regexId = ;
		var result_id = regexId.test(id_ck);
		if(!result_id){
			alert("아이디 조건이 맞지 않습니다.");
		}else{
			alert("사용가능한 아이디 입니다.");        			
		}
		
		//비밀번호		
		//var regexPw = ;
		var result_pw = regexPw.test(pw_ck);
		if(!result_pw){
			alert("비밀번호 조건이 맞지 않습니다.");
		}
		
		//이름		
		//var regexName = ;
		var result_name = regexName.test(name);
		if(!result_name){
			alert("이름 조건이 맞지 않습니다.");
		}
		
		//나이		
		//var regexAge = ;
		var result_age = regexAge.test(age);
		if(!result_age){
			alert("나이 조건이 맞지 않습니다.");
		}
		
		//성별
		var gender = $('input:radio[name=gender]:checked');
		
		//email
		//이메일은 고정으로 바뀌지 않게 작업
		
		//전화번호		
		var result_phone = regexPhone.test(phone);
		if(!result_phone){
			alert("전화번호 조건이 맞지 않습니다.");
		}
		
		//주소
		var sidoVal = $("#sido1").val();
			var gugunVal = $("#gugun1").val();
			
		if(sidoVal == "시, 도 선택"){
			alert("시,도를 선택해주세요.");
		}else if(sidoVal == "구, 군 선택"){
			alert("구, 군을 선택해주세요.");
		}  
	
		//주소 :시,도 선택을 했을 때
		$("#sido1").on("change",function(){
			var selVal = $(this).val();
			if(selVal == "시, 도 선택"){
				return false;
			}
		});        		
		//주소 :구,군 선택을 했을 때
		$("#gugun1").on("change",function(){
			var selVal = $(this).val();
			if(selVal == "구, 군 선택"){
				return false;
			}
		});
		
		//은행계좌
		var account = $("#account").val();
		var result_account = regexAccount.test(account);
		if(!result_account){
			alert("계좌번호를 입력해주세요.");
		}
		
		//정규식
		if(!result_id || !result_pw || !result_name){
     	   return false;		
     	}
		
		//값이 비워있을 때
		if(id_ck == "" || pw_ck == ""){
			alert("빈 값이 있습니다.");
	 	   return false;		
	 	}
		
	});
});