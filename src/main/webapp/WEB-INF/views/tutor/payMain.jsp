<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" ></script>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<title>결제페이지</title>

</head>
<body>
	<script>
	//결제 스크립트
		$(function() {
			var IMP = window.IMP; // 생략가능
			IMP.init('imp05310091'); // 가맹점 식별 코드

			IMP.request_pay({
				pg : 'kakao', // 결제방식
				pay_method : 'card', // 결제 수단
				merchant_uid : 'merchant_' + new Date().getTime(),
				name : '주문명: 테스트입니다.', // order 테이블에 들어갈 주문명 혹은 주문 번호
				amount : '${money}', // 결제 금액
				buyer_email : '${email}', // 구매자 email
				buyer_name : '${name}', // 구매자 이름
				buyer_tel : '010-2929-4502', // 구매자 전화번호
				buyer_addr : '용산구 산천동', // 구매자 주소
				buyer_account : '10265', // 구매자 계좌번호
				//m_redirect_url : 'http://www.iamport.kr/mobile/landing' // 결제 완료 후 보낼 컨트롤러의 메소드명
			}, function(rsp) {
				if (rsp.success) {
					var msg = '결제가 완료되었습니다.';
              	 	msg += '\n고유ID : ' + rsp.imp_uid;
               	 	msg += '\n상점 거래ID : ' + rsp.merchant_uid;
               	 	msg += '\n결제 금액 : ' + rsp.paid_amount;
              	 	msg += '카드 승인번호 : ' + rsp.apply_num;
                	alert(msg);
					//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
					$.ajax({
						url : "/payments/complete",
						type : 'POST',
						dataType : 'json',
						data : {
							imp_uid : rsp.imp_uid,
							merchant_uid: rsp.merchant_uid
						}
					}).done(function(data) {
						//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
						if ( everythings_fine ) {
							var msg = '결제가 완료되었습니다.';
		              	 	msg += '\n고유ID : ' + rsp.imp_uid;
		               	 	msg += '\n상점 거래ID : ' + rsp.merchant_uid;
		               	 	msg += '\n결제 금액 : ' + rsp.paid_amount;
		              	 	msg += '\n카드 승인번호 : ' + rsp.apply_num;
		                	alert(msg);
						}else {
		        			//[3] 아직 제대로 결제가 되지 않았습니다.
		        			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
							var msg = '결제에 실패하였습니다.';
					        msg += '에러내용 : ' + rsp.error_msg;
		        		}
					});
					alert("결제가 완료되었습니다.");
					location.href='${pageContext.request.contextPath}/payments/lessonView'

				} else { // 실패시
					var msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;
					//실패시 이동할 페이지
					location.href = "${pageContext.request.contextPath}/payments/payFail";
					alert(msg);
				}
			});
		});
	</script>



</body>
</html>