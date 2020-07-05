<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/header.jsp" />


<div id="subWrap" class="hdMargin">
	<section id="subContents">
		<article id="payMain" class="inner1200">
			<script>
			//결제 스크립트
				$(function() {
					var IMP = window.IMP; // 생략가능
					IMP.init('imp05310091'); // 가맹점 식별 코드
			
					IMP.request_pay({
						pg : 'kakao', // 결제방식
						pay_method : 'card', // 결제 수단
						merchant_uid : 'merchant_' + new Date().getTime(),
						name : '${title}', // order 테이블에 들어갈 주문명 혹은 주문 번호
						amount : '${money}', // 결제 금액
						buyer_email : '${ttdto.email}', // 구매자 email
						buyer_name : '${ttdto.name}', // 구매자 이름
						buyer_tel : '${ttdto.phone_contry}${ttdto.phone}', // 구매자 전화번호
						buyer_addr : '${ttdto.address}', // 구매자 주소
						buyer_account : '${ttdto.account}', // 구매자 계좌번호
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
							location.href='${pageContext.request.contextPath}/payments/paySuccess';
			
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

		</article>
	</section>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp" />
	