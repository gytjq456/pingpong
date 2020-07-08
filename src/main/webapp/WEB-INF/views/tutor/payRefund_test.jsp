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
		
/* 		var start_dateArr = start_dateVal.split('-');
		
		//start_date 
		var startDateCompare = new Date(start_dateArr[0], parseInt(start_dateArr[1])-1, start_dateArr[2]);
		
		console.log(startDateCompare);
		//현재 날짜
		console.log(today);
		console.log(today.getDate());
		
		
		//start_date+10일 
		startDateCompare.setDate(startDateCompare.getDate()+10);
		var plusTenDateVal = startDateCompare;
		console.log(plusTenDateVal);
		
		//start_date+15일
		startDateCompare.setDate(startDateCompare.getDate()+15);
		var plusFifteenDateVal = startDateCompare;
		console.log(plusFifteenDateVal);
		
		//가격확인
		var price = ${ttdto.price};
		console.log(price); */
		
		$.ajax({
			url: "/payments/refundPrice",
			data:{
				start_date : start_dateVal
			},
			type: "POST"
		}).done(function(resp){
			console.log(resp);
		})

	}
})

	
</script>