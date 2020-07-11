<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/header.jsp" />
<script>
$(function(){
	var val = confirm("정말로 취소하시겠습니까?");
	console.log(val);
	
	if(val==true){
		/* var today = new Date(); */
		var start_dateVal = '${start_date}';
		
		//가격확인
		var priceVal = ${ttdto.price};
		console.log(priceVal); 

		var idVal = '${ttdto.id}';
		console.log(idVal);
		$.ajax({
			url: "/payments/refundPrice",
			data:{
				start_date : start_dateVal,
				price : priceVal
			},
			type: "POST"
		}).done(function(resp){
			console.log(resp);
			alert("환불요청이 완료되었습니다. 환불 소요까지 2~3일 소요됩니다.");
			var refundPrice = resp;
			var parent_seqVal = ${ttdto.parent_seq};
			location.href="/payments/refundInsert?refundPrice="+refundPrice+"&id="+idVal+"&parent_seq="+parent_seqVal;
		
		}).fail(function(error1, error2) {
			console.log(error1);
			console.log(error2);
		})

	}else{
		location.href="/payments/refundFail";
	}
})

	
</script>