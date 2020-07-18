<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/header.jsp" />

<script>
	
	$(function(){
		
		var userMailSend = $("#userMailSend");
		var sendEmailCode = "";
		var code = $("#code").val();
		var tid;
		var time = 180;		
		
		//타이머
		function setTimer(){
			tid = setInterval(function(){
				time--;
				timer(time)
			},1000);
		}
		
		function timer(seconds) {
            var hour, min, sec
            hour = parseInt(seconds/3600);
            min = parseInt((seconds%3600)/60);
            sec = seconds%60;

            if (hour.toString().length==1) {
               hour = "0" + hour;   
            }
            if(min.toString().length==1){
               min = "0" + min;
            }
            if(sec.toString().length==1){
               sec = "0" + sec;
            }
            var m = min + ":" + sec; 
            $("#timer").html(m);
            if(min == 0 && sec == 0){
               clearInterval(tid);
               authKey = "";
            }
         }
		
		//인증번호 발송
		$("#sendEmail").on("click",function(){
			var emailRegex = /^[a-z A-Z 0-9]+@[a-z]+\.[a-z]{2,6}$/g;
			var result_email = emailRegex.test(userMailSend.val());
			
			if(userMailSend.val() == "" || result_email == false){
				alert("이메일을 입력해주세요.");
				userMailSend.focus();
				return false;
				
			}else{
				$.ajax({
					url :"/member/joinSendMail",
					type : "post",
					data : {
						"userMailSend" : userMailSend.val()
					}
				}).done(function(resp){	
					alert("인증번호가 발송되었습니다.");
					$('#code').prop('readonly','');
					sendEmailCode = resp;
					console.log(sendEmailCode + "코드");
					clearInterval(tid);
					time = 180;
					setTimer();
					
				}).fail(function(error1, error2){
					alert("인증번호 발송이 실패하였습니다.");
				});
			}			
		});	
		
		//인증번호 비교
		$("#code").keyup(function(){			
			code = $("#code").val();
			
			if(sendEmailCode == code){
				$("#codeCk").text("인증번호가 일치합니다.");
				clearInterval(tid);
			}else{
				$("#codeCk").text("인증번호가 불일치합니다.");
				clearInterval(tid);
				setTimer();
			}
		});
		
		//전체약관
		$("#ckboxAll").click(function(){
			if($("#ckboxAll").prop("checked")){
				$("input[name=ckbox1]").prop("checked",true);
				$("input[name=ckbox2]").prop("checked",true);
			}else{
				$("input[name=ckbox1]").prop("checked",false);
				$("input[name=ckbox2]").prop("checked",false);
			}
		});
		
		
		
		//다음버튼을 눌렀을 때 
		$("#join").on("click", function(){
			//이용약관 체크박스
			var ckbox1 = $("input:checkbox[name=ckbox1]");
			var ckIsNull = ckbox1.is(":checked") == true;
			
			//개인정보취급방침 체크박스
			var ckbox2 = $("input:checkbox[name=ckbox2]");
			var ckIsNull2 = ckbox2.is(":checked") == true;
			
			if(userMailSend.val() == "" || code == "" || ckIsNull == false || ckIsNull2 == false){
	
				if(userMailSend.val() == ""){
					alert("이메일이 입력 되어 있어야 합니다.");	
					
				}else if(code == ""){
					ckbox1.focus();
					alert("인증번호가 입력되어 있어야합니다.");
					
				}else if(ckIsNull == false){
					ckbox1.focus();
					alert("이용약관을 체크해주세요.");
					
				}else if(ckIsNull2 == false){
					ckbox2.focus();
					alert("개인정보 취급방침을 체크해주세요.");
				}
				
				return false;
				
			}else{
				if(sendEmailCode == code){
					
					//join url로 다이렉트 접속이 되지 않게 작업
					$('#join').attr('data-ck', code);
					var checkd = $('#join').data('ck');
					
					location.href= "/member/join?mail="+ userMailSend.val()+"&ck="+checkd;
				}else{
					alert("인증번호가 불일치합니다.");
					$("#codeCk").focus();
					return false;
				}
			}
			return false;
		});
	});
</script>

<div id="subWrap" class="hdMargin">
	<section id="subContents" class="inner1200">
		<div class="tit_s1">
			<h2>이메일 인증</h2>
			<p>이메일 인증을 받아야 회원가입을 진행하실 수 있습니다.</p>
		</div>			
		<div id="loginMail" >
			<div id="joinSendMail" class="card_body">
				<div>
					<div class="ov">
						<input type="text" id="userMailSend" name="userMailSend" placeholder="이메일을 입력해주세요">
						<button type="button" id="sendEmail" name="sendEmail">인증번호받기</button>
					</div>
					<dl>
						<dt>인증번호</dt>
						<dd>
							<input type="text" id="code" name="code" placeholder="인증번호 입력해주세요" readonly="readonly">
							<span id="timer"></span>
							<span id="codeCk"></span>
						</dd>
					</dl>
				</div>
				<div class="joinbox">
				
				<div class="allck">
					<ul class="checkBox_s1">
						<li>
							<input type="checkbox" name="ckboxAll" value="ckboxAll" id="ckboxAll"/>
							<label for="ckboxAll"><span></span>전체동의</label>
						</li>
					</ul>
				</div>
				
					<h3>이용약관 <span>(필수)</span></h3>
					<div class="text01">
						<div class="private">
							1.총칙
							제1조 (목적)
							이 약관은 회원이 주식회사 카카오(이하 “회사”라 합니다)에서 제공하는 유무선 인터넷 음악서비스(웹, 모바일 웹•앱 서비스를 포함합니다.)인 Melon(멜론)서비스(이하 ‘서비스'라 합니다) 및 멜론 관련 제반 서비스를 이용함에 있어 회원과 회사간의 권리, 의무 및 책임사항, 서비스 이용조건 및 절차 등 기본적인 사항을 규정함을 목적으로 합니다.
							제2조 (약관의 효력 및 변경)
							① 이 약관은 대한민국 내에서 서비스를 이용하고자 하는 모든 회원에 대하여 그 효력을 발생합니다. 한편, 회사가 해외 권리자 등과의 계약 체결을 통하여 해당 국가에서의 서비스가 가능한 경우 이 약관은 해당 국가 내에서 서비스를 이용하고자 하는 모든 회원에 대하여도 그 효력을 발생합니다.
							② 이 약관의 내용은 서비스 화면에 게시하거나 기타의 방법으로 회원에게 공시하고, 이에 동의한 회원이 서비스에 가입함으로써 효력이 발생합니다. 회사는 회원이 동의하기에 앞서 약관의 내용을 회원이 쉽게 이해하여 착오 없이 거래할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 회원의 확인을 구합니다.
							③ 회사는 필요하다고 인정하는 경우, “약관의규제에관한법률”, “정보통신망이용촉진및정보보호에관한법률", “콘텐츠산업진흥법”, “전자상거래등에서의소비자보호에관한법률” 등 관련 법령을 위반하지 않는 범위에서 이 약관을 변경할 수 있으며, 회사가 약관을 변경하는 경우에는 적용일자 및 변경사유를 명시하여 그 적용일자 15일 전부터 서비스 사이트에 공지하고, 회원에게 불리한 약관의 변경의 경우 개정 내용을 회원이 알기 쉽게 표시하여 그 적용일자 30일 전부터 공지하며, 이메일 주소, 문자메시지 등으로 회원에게 개별 통지합니다. 회원의 연락처 미기재, 변경 등으로 인하여 개별 통지가 어려운 경우, 회원이 등록한 연락처로 공지를 하였음에도 2회 이상 반송된 경우 이 약관에 의한 공지를 함으로써 개별 통지한 것으로 간주합니다.
							④ 회사가 제3항에 따라 변경 약관을 공지 또는 통지하면서 회원에게 약관 변경 적용 일까지 거부의사를 표시하지 아니할 경우, 약관의 변경에 동의한 것으로 간주한다는 내용을 공지 또는 통지하였음에도 회원이 명시적으로 약관 변경에 대한 거부의사를 표시하지 아니하면, 회사는 회원이 변경 약관에 동의한 것으로 간주합니다.
							⑤ 변경된 약관에 대하여 거부의사를 표시한 회원은 계약의 해지 또는 회원 탈퇴를 선택할 수 있습니다. 개별 이용권의 해지 효력과 관련하여서는 멜론 유료서비스 약관 관련 조항의 내용을 따릅니다.
							⑥ 회사는 이 약관을 회원이 그 전부를 인쇄할 수 있고 확인할 수 있도록 필요한 기술적 조치를 취합니다.
							⑦ 이 약관은 회원이 이 약관에 동의한 날로부터 회원 탈퇴 시까지 적용하는 것을 원칙으로 합니다. 단, 이 약관의 일부 조항은 회원이 탈퇴 후에도 유효하게 적용될 수 있습니다.
							제3조 (약관 외 준칙)
							이 약관에 명시되지 않은 사항은 콘텐츠산업진흥법, 전자상거래등에서의소비자보호에관한법률, 저작권법 등 관련 법령의 규정과 일반 상관례에 의합니다.
							제4조 (용어의 정의)
							① 이 약관에서 사용하는 용어의 정의는 다음과 같습니다.
							1.회원 : 서비스를 이용하기 위하여 서비스 사이트에 접속하여 이 약관에 동의하거나 기타 회사가 요청하는 절차를 거쳐 서비스 이용 계약을 체결하여 서비스를 이용하는 모든 고객
							2.아이디(ID) : 회원 식별과 회원의 서비스 이용을 위하여 회원이 선정하고 회사가 승인하는 영문자와 숫자의 조합
							3.비밀번호(PASSWORD) : 회원의 정보 보호를 위해 회원 자신이 설정한 문자와 숫자의 조합
							4.닉네임(별명) : 회원이 아이디(ID) 외에 별도로 지정한 고유의 별도명칭
							5.운영자 : 서비스의 전반적인 관리와 원활한 운영을 위하여 회사가 선정한 자
							6.서비스 중지 : 정상 이용 중 회사가 정한 일정한 요건에 따라 일정기간 동안 서비스의 제공을 중지하는 것
							7.문자메시지 인증 : 이동전화로 문자메시지 난수를 발송, 고객이 해당 번호를 사이트에 등록하도록 함으로써 회원 인증을 하는 것
							② 제1항에서 정하는 사항 이외의 약관 내 용어의 정의는 관계 법령 및 서비스 안내에서 정하는 바에 의합니다.
						</div>
						<ul class="checkBox_s1">
							<li>
								<input type="checkbox" name="ckbox1" value="ckbox1" id="ckbox1"/>
								<label for="ckbox1" ><span></span>이용약관 동의</label>
							</li>
						</ul>
					</div>					
				</div>
				<div class="joinbox">
					<h3>개인정보 수집 및 이용동의 <span>(필수)</span></h3>
					<div class="text01">
						<div class="private">
							하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하하
						</div>
						<ul class="checkBox_s1">
							<li>
								<input type="checkbox" name="ckbox2" value="ckbox2" id="ckbox2"/>
								<label for="ckbox2"><span></span>개인정보 수집 및 이용에 동의합니다.</label>
							</li>
						</ul>
						
					</div>					
				</div>
				
				<div class="btnS1 center ">
					<div><button class="w100" type="button" id="join" name="join" data-ck="">다음</button></div>
				</div>
			</div>
		</div>
	</section>
</div>


<jsp:include page="/WEB-INF/views/footer.jsp" />