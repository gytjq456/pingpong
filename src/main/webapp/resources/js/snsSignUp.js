/* 회원가입 */
$(function(){
	//시군 
	new sojaeji('sido1', 'gugun1');
	
	$('#gugun1').change(function(){
         var sido = $('#sido1 option:selected').val();
         var gugun = $('#gugun1 option:selected').val();
         
         $('#address').val(sido + ' ' + gugun);
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
	
	
	$("#snsSignUp").submit(function(){
		var id_ck = $("#id");
		var name = $("#name");
		var age = $("#age");
		var gender = $('input:radio[name=gender]:checked').val(); //라디오
		var email = $('#email');
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
		
		//이름		
		var regexName = /^[가-힣 a-z A-Z]{3,}$/g;
		var result_name = regexName.test(name.val());
		if(!result_name){
			alert("이름 : 세글자 이상 한글만 가능");
			name.focus();
			return false;
		}		
		
		//나이
		if(age.val() == ""){
			alert("나이를 입력해주세요.");
			age.focus();
			return false;
		}
		
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
		if(email.val() == ""){
			alert("이메일을 입력해주세요.");
			email.focus();
			return false;
		}
		
		if(email.object == undefined){
			if(email.val == 'null'){
				alert("이메일을 입력해주세요.");
				$('#email').focus();
				return false;
			}
		}
		
		//전화번호 (앞자리)
		if(phone_country == 'null'){
			alert("전화번호 앞자리를 입력해주세요.");
			$('#phone_country').focus();			
			return false;
		}
		
		
		// 전화번호 (뒷자리)
		var regexPhone = /^(?!010|070|011)(\d){8}$/gm;
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
		
		//나라
		if(country == "null"){
			alert("나라를 선택해주세요.");
			$('#country').focus();
			return false;
		}
		
		/* 구사가능언어 */
		//체크박스 체크여부 확인
		var langCan = $("input[name='lang_can']");
		var ckIsNull = langCan.is(":checked");		
		var count = $('input:checkbox[name="lang_can"]:checked').length;

		if(ckIsNull == false){
			langCan.focus();
			alert("구사가능 언어를 선택해주세요");
			return false;
		}else{
			if(count > 3){
				max3Call(langCan);
				return false;
			}
		};
		
		/* 배우고 싶은 언어*/
		//체크박스 체크여부 확인
		var langLearn = $("input[name='lang_learn']");
		var ckIsNull2 = langLearn.is(":checked");		
		var count2 = $('input:checkbox[name="lang_learn"]:checked').length;
		
		if(ckIsNull2 == false){
			langLearn.focus();
			alert("배우고 싶은 언어를 선택해주세요");		
			return false;
		}else{
			if(count2 > 3){
				max3Call(langLearn);
				return false;
			}
		}; 
		
		/* 취미  */
		var hobby = $("input[name='hobby']");
		var ckIsNull3 = hobby.is(":checked");		
		var count3 = $('input:checkbox[name="hobby"]:checked').length;
		
		if(ckIsNull3 == false){
			hobby.focus();
			alert("취미를 선택해주세요");
			return false;
		}else{
			if(count3 > 3){
				max3Call(hobby);
				return false;
			}
		};
		
		/* 공통함수 */
		function max3Call(lang){
			lang.focus();
			alert("최대 3개까지만 선택가능합니다.");
			lang.prop("checked", false);
		};
		
		/* 자기소개  */
		if(introduce.val().length < 50){
			introduce.focus();
			alert("자기소개를 최소 50글자 이상 작성해주세요.");
			return false;
		};
		
		//값이 비워있을 때
		var sysname = $("#sysname").val();
		if(
				name.val() == "" ||
				email.val()=="" || age.val() == "" || phone_country == "" || address.val() == "" || bank_name =="" ||
				account.val() =="" || ckIsNull == false ||ckIsNull2 == false || ckIsNull3 == false
		){
			if(sysname == ""){
				if(!profile.val()){
					alert("프로필을 입력해주세요");
					profile.focus();
					return false;	
				}
			}
			return false;		
	 	};
	});
	
});