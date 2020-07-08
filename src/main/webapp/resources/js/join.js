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
			if($("#id").val()==""){
				alert("아이디를 입력해주세요");
				id.focus();
			}else{
				if("true" == resp){
					alert("이미 사용중인 아이디 입니다.");
					$("#duplcheckId").attr("name","");
				}else{
					alert("사용가능한 아이디입니다.");
					$("#duplcheckId").attr("name","true");
				}   
			}
			 				
		}).fail(function(error1, error2){
			console.log(error1);
			console.log(error2);
		})
	});
	
	
	//비밀번호 일치
	$("#pw").on("keyup",function(){
		var pwResult1 = $("#pw").val();
		var pwResult2 = $("#pw_ck").val();
		if(pwResult1 == pwResult2){
			$("#pwConfrom").text("비밀번호가 일치합니다.");
		}else{
			$("#pwConfrom").text("비밀번호 일치 하지 않습니다.");
		}
	});
	
	//비밀번호 일치
	$("#pw_ck").on("keyup",function(){
		var pwResult1 = $("#pw").val();
		var pwResult2 = $("#pw_ck").val();
		if(pwResult1 == pwResult2){
			$("#pwConfrom").text("비밀번호가 일치합니다.");
		}else{
			$("#pwConfrom").text("비밀번호 일치 하지 않습니다.");
		}
	});
	
	/* 자기소개  */		
	$('#introduce').keyup(function(e){
		var content = $(this).val();
		$('#counter').html("("+ content.length +" / 최대 500글자)"); //글자수 실시간 카운팅
		
		if(content.length > 500){
			alert("최대 500까지 입력 가능합니다.");
			$(this).val(content.substring(0,500));
			$('#counter').html("(500 / 최대 500글자)");
		}
	})
	
	
	$("#joinProc").submit(function(){
		
		var id_ck = $("#id");
		var pw_ck = $("#pw");
		var name = $("#name");
		var age = $("#age");
		var gender = $('input:radio[name=gender]:checked').val(); //라디오
		//이메일은 고정
		var phone_country = $('#phone_country option:selected').val();//셀렉트
		var phone = $('#phone');
		var address = $("#address");
		var bank_name = $("#bank_name option:selected").val();//셀렉트
		var account = $("#account");
		var profile = $("#profile");//파일
		var country = $("#country option:selected").val();//셀렉트
		var introduce = $("#introduce");	
		
		//아이디 정규식		
		var regexId = /^(\w){4,20}$/g;
		var result_id = regexId.test(id_ck.val());
		if(!result_id){
			alert("아이디 : 알파벳 대소문자, 숫자, _ 까지 4~20글자입니다.");
			id_ck.focus();
			return false;
		}
		
		//아이디 중복확인 했는지 안했는지
		if($("#duplcheckId").prop("name") == ""){
			alert("아이디 중복체크를 확인해주세요");
			id_ck.focus();
			return false;
		}
		
		//비밀번호		
		var regexPw = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/g;
		var result_pw = regexPw.test(pw_ck.val());
		if(!result_pw){
			alert("비밀번호 : 최소 8글자, 숫자, 특수문자를 넣어주세요.");
			pw_ck.focus();
			return false;
		}
		
		//이름		
		var regexName = /^[가-힣 a-z A-Z]{3,}$/g;
		var result_name = regexName.test(name.val());
		if(!result_name){
			alert("이름 : 세글자 이상 한글만 가능");
			name.focus();
			return false;
		}		
		
		//나이		
		var regexAge = /^(\d){0,3}$/gm;
		var result_age = regexAge.test(age.val());
		if(!result_age){
			alert("나이 : 세글자 이하 숫자만 가능");
			age.focus();
			return false;
		}
		
		//성별
		var gender = $('input:radio[name=gender]:checked').val();
		if($('input:radio[name=gender]:checked').length < 1){
			alert("성별을 체크해주세요.");
			$('input:radio[name=gender]').focus();
			return false;
		}
		
		//email
		//이메일은 고정으로 바뀌지 않게 작업	
		
		//전화번호 (앞자리)
		/*
		if(phone_country == 'null'){
			alert("전화번호 앞자리를 입력해주세요.");
			$('#phone_country').focus();			
			return false;
		}*/
		
		//전화번호	(뒷자리)
		//var regexPhone = /^(\d){8}$/g;
		var regexPhone = /^[^010 070 011 a-z A-Z 가-힣 ㄱ-ㅎ ! @ # $ %](\d){7}$/gm;
		var result_phone = regexPhone.test(phone.val());
		if(!result_phone){
			alert("전화번호 : 숫자이며 8글자입니다. 010 / 011 / 070 빼주세요.");
			phone.focus();
			return false;
		}		
		
		//주소
		var sidoVal = $("#sido1").val();
		var gugunVal = $("#gugun1").val();
		
		if(sidoVal == "시, 도 선택" || gugunVal == "구, 군 선택"){
			alert("주소를 다시 선택해주세요.");
			$("#sido1").focus();
			return false;
		} 		
		//주소 :시,도 선택을 했을 때
		$("#sido1").on("change",function(){
			$("#sido1").focus();
			var selVal = $(this).val();
			return false;
		});        		
		//주소 :구,군 선택을 했을 때
		$("#gugun1").on("change",function(){
			$("#gugun1").focus();
			var selVal = $(this).val();
			return false;
		});
		
		//은행
		if(bank_name == "null"){
			alert("은행을 선택해주세요.");
			$('#bank_name').focus();			
			return false;
		}
		
		//은행계좌
		var regexAccount = /^(\d){4,15}$/gm;
		var result_account = regexAccount.test(account.val());
		if(!result_account){
			account.focus();
			alert("계좌번호  : 숫자로 4~15글자입니다.");
			return false;
		}
		
		//프로필
		if(profile.val() == ""){
			alert("프로필 사진을 넣어주세요");
			profile.focus();
			return false;
		}
		
		//프로필 확장자 체크
		if(!/\.(gif|jpg|jpeg|png)$/i.test(profile.val())){
			alert("확장자 확인 하기 " + profile.val());
			alert('gif, jpg, png 파일만 선택해 주세요.\n\n현재 파일 : ' + profile.val());
			profile.focus();
			return false;
		}
		
		//나라
		if(country == "null"){
			alert("나라를 선택해주세요.");
			$('#country').focus();
			return false;
		}
		
		/* 구사가능언어 */
		//체크박스 체크여부 확인
		var langCan = $("input:checkbox[name=lang_can]");
		var ckIsNull = langCan.is(":checked") == true;		
		var count = $('input:checkbox[name="lang_can"]:checked').length;
		
		if(ckIsNull == false){
			langCan.focus();
			alert("구사가능 언어를 선택해주세요");
			return false;
		}else{
			if(count > 3){
				langCan.focus();
				alert("최대 3개까지만 선택가능합니다.");
				langCan.prop("checked", false);
				return false;
			}
		};
		
		/* 배우고 싶은 언어 */
		//체크박스 체크여부 확인
		var langLearn = $("input:checkbox[name=lang_learn]");
		var ckIsNull2 = langLearn.is(":checked") == true;		
		var count2 = $('input:checkbox[name="lang_learn"]:checked').length;
		
		if(ckIsNull2 == false){
			langLearn.focus();
			alert("배우고 싶은 언어를 선택해주세요");		
			return false;
		}else{
			if(count2 > 3){
				langLearn.focus();
				alert("최대 3개까지만 선택가능합니다.");
				$('input:checkbox[name="lang_learn"]').prop("checked", false);
				return false;
			}
		}
		
		/* 취미  */
		var hobby = $("input:checkbox[name=hobby]");
		var ckIsNull3 = hobby.is(":checked") == true;		
		var count3 = $('input:checkbox[name="hobby"]:checked').length;
		
		if(ckIsNull3 == false){
			hobby.focus();
			alert("취미를 선택해주세요");
			return false;
		}else{
			if(count3 > 3){
				hobby.focus();
				alert("최대 3개까지만 선택가능합니다.");
				$('input:checkbox[name="hobby"]').prop("checked", false);
				return false;
			}
		}
		
		/* 자기소개  */
		if(introduce.val().length < 50){
			introduce.focus();
			alert("자기소개를 최소 50글자 이상 작성해주세요.");
			return false;
		}
		
		//값이 비워있을 때
		if(
				id_ck.val() == "" || $("#duplcheckId").prpp("name") == "" || pw_ck.val() == "" || name.val() == "" ||
				age.val() == "" || phone_country == "" || address.val() == "" || bank_name =="" ||
				account.val() =="" || phone.val() == "" || !profile.val() || ckIsNull == false ||
				ckIsNull2 == false || ckIsNull3 == false || introduce.val().length < 100
		){
			return false;		
	 	}
	});
	
});