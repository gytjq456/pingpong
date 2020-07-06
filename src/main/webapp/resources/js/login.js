/* 로그인 */
$(function() {
	//쿠키
	var cookieIdR;
	
	if(document.cookie!=""){
		var cookie = document.cookie;
		var cookieObj = cookieToJson(cookie);
		
		//로그인 ID에 쿠키에 자장된 ID값을 가지고 온다.
		$("#id").val(cookieObj.userID);
		$("input:checkbox[id='rememberId']").prop("checked", true);
	}
	
	//아이디 쿠키에 저장
	$("#rememberId").on("change",function(){
		alert("쿠우키이");
		if($("#id").val()==""){
			alert("111");
			return false;
		}else{
			alert("222");
			var exdate = new Date();
				//쿠키체크한 것
			if ($("#rememberId").prop("checked")){
				exdate.setDate(exdate.getDate()+30);
				document.cookie = 
					"userID="+$("#id").val()+";expires="+exdate.toString();
				
			}else{
				//쿠키체크해제
				exdate.setDate(exdate.getDate()-1);
				document.cookie =
					"userID="+$("#id").val()+";expires="+exdate.toString();
			}
		}
	});
	
	//쿠키 제이슨형으로 만들기
	function cookieToJson(cookie){		
		var cookieJson = {};
		var cookies = cookie.split("; ");
		for(var i =0; i<cookies.length; i++){
			var entry = cookies[i].split("=");
			cookieJson[entry[0]] = entry[1];
		}
		return cookieJson;
	}
	
	//로그인
	$("#isIdPwSame").on('click', function() {
		var id = $("#id").val();
		var pw = $("#pw").val();

		if (id == "") {
			alert("id를 입력해주세요.");
			$("#id").focus();
			return false;
		} else if (pw == "") {
			alert("pw를 입력해주세요.");
			$("#pw").focus();
			return false;
		}

		$.ajax({
			type : "post",
			url : "/member/isIdPwSame",
			data : {
				id : $('#id').val(),
				pw : $('#pw').val()
			}
		}).done(function(resp) {
			if (resp == 'true') {
				alert("로그인이 되었습니다.");
				location.href = "/";
			} else {
				alert("로그인에 실패하였습니다.");
				$("#id").val("");
				$("#pw").val("");
			}
		}).fail(function(error1, error2) {
			alert("관리자에게 문의주세요.")
		});
	});

	//id찾기
	$("#idFind").on('click', function() {
		location.href = "/member/idFind";
	});

	//pw찾기
	$("#pwFind").on('click', function() {
		location.href = "/member/pwFind";
	});

	//회원가입
	$("#signup").click(function() {
		location.href = "/member/joinMail";
	});
});