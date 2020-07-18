/* 마이페이지 수정 */
$(function() {
	var id = $("#id").val();
	var name = $("#name").val();
	var email = $("#email").val();

	/* 회원정보 수정 버튼 클릭시 노출 */
	$(".show_input").hide();

	$(".modyBtn").on("click", function() {
		$(this).siblings('.show_input').show();
	});

	/* === 회원수정 === */
	// 시군
	new sojaeji('sido1', 'gugun1');

	$('#gugun1').change(function() {
		var sido = $('#sido1 option:selected').val();
		var gugun = $('#gugun1 option:selected').val();

		$('#address').val(sido + ' ' + gugun);
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
	
	//비밀번호 페이지로 넘어가기
	$("#modyPwBtn").on("click",function(){
		location.href="/member/pwModify?name="+name+"&email="+email+"&id="+id;
	});
	
	/* 자기소개 */
	$('#introduce').keyup(function(e) {
		var content = $(this).val();
		$('#counter').html("(" + content.length + " / 최대 500글자)"); // 글자수 실시간
																	// 카운팅

		if (content.length > 500) {
			alert("최대 500까지 입력 가능합니다.");
			$(this).val(content.substring(0, 500));
			$('#counter').html("(500 / 최대 500글자)");
		}
	})

	// 전화번호를 눌렀을 때
	$("#phone_Result").on('click', function() {
		var phone_country = $('#phone_country option:selected').val();// 셀렉트
		var phone = $('#phone');

		// 전화번호 (앞자리)
		/*
		if (phone_country == 'null') {
			alert("전화번호 앞자리를 입력해주세요.");
			$('#phone_country').focus();
			return false;
		}*/

		// 전화번호 (뒷자리)
		var regexPhone = /^(?!010|070|011)(\d){8}$/gm;
		var result_phone = regexPhone.test(phone.val());
		if(!result_phone){
			alert("전화번호 : 숫자이며 8글자입니다. 010 / 011 / 070 빼주세요.");
			phone.focus();
			return false;
		}	

		// 값이 비워있을 때
		if (phone_country == "" || phone.val() == "") {
			return false;
		}

		$.ajax({
			type : "post",
			url : "/member/myInfoMoPhone",
			data : {
				'phone_country' : phone_country,
				'phone' : phone.val()
			}
		}).done(function(resp) {
			if (resp > 0) {
				alert("전화번호 수정이 완료되었습니다.");
				location.reload();
			} else {
				alert("전화번호 수정이 실패하였습니다.");
			}
		}).fail(function(error1, error2) {
			alert("관리자에게 문의주세요.")
		});
	});
	
	//주소수정을 눌렀을 때
	$("#address_Result").on("click", function() {
		var address = $("#address");
		
		// 주소
		var sidoVal = $("#sido1").val();
		var gugunVal = $("#gugun1").val();

		if (sidoVal == "시, 도 선택" || gugunVal == "구, 군 선택") {
			alert("주소를 다시 선택해주세요.");
			$("#sido1").focus();
			return false;
		}
		// 주소 :시,도 선택을 했을 때
		$("#sido1").on("change", function() {
			$("#sido1").focus();
			var selVal = $(this).val();
			return false;
		});
		// 주소 :구,군 선택을 했을 때
		$("#gugun1").on("change", function() {
			$("#gugun1").focus();
			var selVal = $(this).val();
			return false;
		});
		
		$.ajax({
			type : "post",
			url : "/member/myInfoMoAddress",
			data : {
				'address' : address.val()
			}
		}).done(function(resp) {
			if (resp > 0) {
				alert("주소 수정이 완료되었습니다.");
				location.reload();
			} else {
				alert("주소 수정이 실패하였습니다.");
			}
		}).fail(function(error1, error2) {
			alert("관리자에게 문의주세요.")
		});
	});
	
	//은행 수정을 눌렀을 때
	$("#bank_Result").on("click", function() {
		var bank_name = $("#bank_name option:selected").val();// 셀렉트
		var account = $("#account");
		
		// 은행
		if (bank_name == "null") {
			alert("은행을 선택해주세요.");
			$('#bank_name').focus();
			return false;
		}

		// 은행계좌
		var regexAccount = /^(\d){4,15}$/gm;
		var result_account = regexAccount.test(account.val());
		if (!result_account) {
			account.focus();
			alert("계좌번호  : 숫자로 4~15글자입니다.");
			return false;
		}
		
		$.ajax({
			type : "post",
			url : "/member/myInfoMobank",
			data : {
				'bank_name' : bank_name,
				'account' : account.val()
			}
		}).done(function(resp) {
			if (resp > 0) {
				alert("계좌번호 수정이 완료되었습니다.");
				location.reload();
			} else {
				alert("계좌번호 수정이 실패하였습니다.");
			}
		}).fail(function(error1, error2) {
			alert("관리자에게 문의주세요.")
		});
	});
	
	//프로필사진 수정
	$("#profile_form").submit(function() {		
		var profile = $("#profile");// 파일
		var formData = new FormData($("#profile_form")[0]);
		
		//프로필 확장자 체크
		if(!/\.(gif|jpg|jpeg|png)$/i.test(profile.val())){
			alert("확장자 확인 하기 " + profile.val());
			alert('gif, jpg, png 파일만 선택해 주세요.\n\n현재 파일 : ' + profile.val());
			profile.focus();
			return false;
		}
		
		// 프로필
		if (profile.val() == "") {
			alert("프로필 사진을 넣어주세요");
			profile.focus();
			return false;
		}
		
		//프로필 용량
		var limit = 1024*1024*5;
		if(limit < profile[0].files[0].size){
			alert("파일용량 5MB을 초과했습니다. 다른 파일로 변경해주세요");
			profile.val("");
			$('#profile').focus();
			return false;
		}
		
		$.ajax({
			type : "post",
			url : "/member/myInfoProfile",
			data : formData,
			cache : false,
			contentType : false,
			processData : false
			
		}).done(function(resp) {
			if (resp > 0) {
				alert("프로필사진 수정이 완료되었습니다.");
				location.reload();
			} else {
				alert("프로필사진 수정이 실패하였습니다.");
			}
		}).fail(function(error1, error2) {
			alert("관리자에게 문의주세요.")
		});
		
		return false;
	});
	
	//나라 수정
	$("#country_Result").on("click", function() {
		var country = $("#country option:selected").val();// 셀렉트		
		// 나라
		if (country == "null") {
			alert("나라를 선택해주세요.");
			$('#country').focus();
			return false;
		}
		
		$.ajax({
			type : "post",
			url : "/member/myInfoCountry",
			data : {
				'country' : country
			}
		}).done(function(resp) {
			if (resp > 0) {
				alert("나라 수정이 완료되었습니다.");
				location.reload();
			} else {
				alert("나라 수정이 실패하였습니다.");
			}
		}).fail(function(error1, error2) {
			alert("관리자에게 문의주세요.")
		});
	});
	
	//구사가능언어 수정
	$("#lang_can_Result").on("click", function() {
		/* 구사가능언어 */
		// 체크박스 체크여부 확인
		var langCan = $("input:checkbox[name=lang_can]");
		var langCan2 = $("input:checkbox[name=lang_can]:checked");
		var ckIsNull = langCan.is(":checked") == true;
		var count = $('input:checkbox[name="lang_can"]:checked').length;

		if (ckIsNull == false) {
			langCan.focus();
			alert("구사가능 언어를 선택해주세요");
			location.reload();
			return false;
		} else {
			if (count > 3) {
				langCan.focus();
				alert("최대 3개까지만 선택가능합니다.");
				langCan.prop("checked", false);
				return false;
			}
		};
		
		//배열로 담기
		var langArray = new Array();
		langCan2.each(function(){
			langArray.push(this.value);
		});
		
		//배열을 리스트로 담기
		var allData = { "langArrayA": langArray };
		
		$.ajax({
			type : "post",
			url : "/member/myInfoLang_can",
			data : allData
			
		}).done(function(resp) {
			if (resp > 0) {
				alert("구사가능언어 수정이 완료되었습니다.");
				location.reload();				
			} else {
				alert("구사가능언어 수정이 실패하였습니다.");
			}
		}).fail(function(error1, error2) {
			alert("관리자에게 문의주세요.")
		});
	});
	
	//배우고 싶은 언어 수정
	$("#lang_learn_Result").on("click", function() {
		/* 배우고 싶은 언어 */
		// 체크박스 체크여부 확인
		var langLearn = $("input:checkbox[name=lang_learn]");
		var langLearn2 = $("input:checkbox[name=lang_learn]:checked");
		var ckIsNull2 = langLearn.is(":checked") == true;
		var count2 = $('input:checkbox[name="lang_learn"]:checked').length;

		if (ckIsNull2 == false) {
			langLearn.focus();
			alert("배우고 싶은 언어를 선택해주세요");
			return false;
		} else {
			if (count2 > 3) {
				langLearn.focus();
				alert("최대 3개까지만 선택가능합니다.");
				$('input:checkbox[name="lang_learn"]').prop(
						"checked", false);
				return false;
			}
		}
		
		//배열로 담기
		var langArray = new Array();
		langLearn2.each(function(){
			langArray.push(this.value);
		});
		
		//배열을 리스트로 담기
		var allData = { "langArrayA": langArray };
		
		$.ajax({
			type : "post",
			url : "/member/myInfoLang_learn",
			data : allData
		}).done(function(resp) {
			if (resp > 0) {
				alert("배우고 싶은 언어 수정이 완료되었습니다.");
				location.reload();
			} else {
				alert("배우고 싶은 언어 수정이 실패하였습니다.");
			}
		}).fail(function(error1, error2) {
			alert("관리자에게 문의주세요.")
		});
	});
	
	//취미 수정
	$("#hobby_Result").on("click", function() {
		/* 취미 */
		var hobby = $("input:checkbox[name=hobby]");
		var hobby2 = $("input:checkbox[name=hobby]:checked");
		var ckIsNull3 = hobby.is(":checked") == true;
		var count3 = $('input:checkbox[name="hobby"]:checked').length;

		if (ckIsNull3 == false) {
			hobby.focus();
			alert("취미를 선택해주세요");
			return false;
		} else {
			if (count3 > 3) {
				hobby.focus();
				alert("최대 3개까지만 선택가능합니다.");
				$('input:checkbox[name="hobby"]').prop(
						"checked", false);
				return false;
			}
		}
		
		//배열로 담기
		var hobbyArray = new Array();
		hobby2.each(function(){
			hobbyArray.push(this.value);
		});
		
		//배열을 리스트로 담기
		var allData = { "hobbyArrayA": hobbyArray};
		
		$.ajax({
			type : "post",
			url : "/member/myInfoHobby",
			data : allData
		}).done(function(resp) {
			if (resp > 0) {
				alert("취미 수정이 완료되었습니다.");
				location.reload();
			} else {
				alert("취미 수정이 실패하였습니다.");
			}
		}).fail(function(error1, error2) {
			alert("관리자에게 문의주세요.")
		});
	});
	
	//자기소개 수정
	$("#introduce_Result").on("click", function() {
		var introduce = $("#introduce");

		/* 자기소개 */
		if (introduce.val().length < 50) {
			introduce.focus();
			alert("자기소개를 최소 50글자 이상 작성해주세요.");
			return false;
		}
		
		$.ajax({
			type : "post",
			url : "/member/myInfoIntroduce",
			data : {
				introduce : introduce.val()
			}
		}).done(function(resp) {
			if (resp > 0) {
				alert("자기소개 수정이 완료되었습니다.");
				location.reload();
			} else {
				alert("자기소개 수정이 실패하였습니다.");
			}
		}).fail(function(error1, error2) {
			alert("관리자에게 문의주세요.");
		});
	});

});