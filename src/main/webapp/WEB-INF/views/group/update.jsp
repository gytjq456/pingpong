<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
	#apply_start_cal, #apply_end_cal, #start_date_cal, #end_date_cal{display: none;}
	.sun{color: #ef3333;}
	.sat{color: #2107e0;}
	.active{background-color: dodgerblue; color: #fff;}
	#apply_start, #apply_end, #start_date, #end_date{background-color: #ccc; border: 1px solid #bbb;}
</style>
<jsp:include page="/WEB-INF/views/header.jsp"/>
<script>
	$(function(){
		$('#title').val('${gdto.title}');
		$('#hobby_type').val('${gdto.hobby_type}');
		$('#max_num').val('${gdto.max_num}');
		$('#location').val('${gdto.location}');
		$('#contents').html('${gdto.contents}');
		
		var selectedHobbyList = '${gdto.hobby_type}';
		var selectedHobbyArr = selectedHobbyList.split(',');
		var hobbyCount = $("input:checkbox[name='hobby']").length;
		var hobbyArrValue = [];
		
		for (var i = 0; i < hobbyCount; i++) {
			hobbyArrValue.push($("input:checkbox[name='hobby']:eq(" + i + ")").val());
		}
		
		var hobbyArr = $("input:checkbox[name='hobby']");
		
		for (var i = 0; i < hobbyCount; i++) {
			for (var j = 0; j < selectedHobbyList.length; j++) {
				if (hobbyArrValue[i] == selectedHobbyArr[j]) {
					$(hobbyArr[i]).attr('checked', 'true');
				}
			}
		}
		
		$('#apply_start_cal_btn').on('click', function(){
			if ($('#apply_start_cal').css('display') == 'none') {
				$('#apply_start_cal').css('display', 'block');
				if ($('#apply_end_cal').css('display') == 'block') {
					$('#apply_end_cal').css('display', 'none');
				}
			} else {
				$('#apply_start_cal').css('display', 'none');
			}
		})
		
		$('#apply_end_cal_btn').on('click', function(){
			if ($('#apply_end_cal').css('display') == 'none') {
				$('#apply_end_cal').css('display', 'block');
				if ($('#apply_start_cal').css('display') == 'block') {
					$('#apply_start_cal').css('display', 'none');
				}
			} else {
				$('#apply_end_cal').css('display', 'none');
			}
		})
		
		$('#start_date_cal_btn').on('click', function(){
			if ($('#start_date_cal').css('display') == 'none') {
				$('#start_date_cal').css('display', 'block');
				if ($('#end_date_cal').css('display') == 'block') {
					$('#end_date_cal').css('display', 'none');
				}
			} else {
				$('#start_date_cal').css('display', 'none');
			}
		})
		
		$('#end_date_cal_btn').on('click', function(){
			if ($('#end_date_cal').css('display') == 'none') {
				$('#end_date_cal').css('display', 'block');
				if ($('#start_date_cal').css('display') == 'block') {
					$('#start_date_cal').css('display', 'none');
				}
			} else {
				$('#end_date_cal').css('display', 'none');
			}
		})
		
		var currentTitle = $('.current_year_month');
		var calendarBody = $('.calendar_body');
		var tableName = [];
		for (var i = 0; i < $('table').length; i++) {
			tableName[i] = $('table')[i].id;
		}
		var today = new Date();
		
		var setMonth = today.getMonth() + 1;
		
		if (setMonth < 10) {
			setMonth = '0'.concat(setMonth);
		}
		
		$('#apply_start').val('${gdto.apply_start}');
		$('#apply_end').val('${gdto.apply_end}');
		$('#start_date').val('${gdto.start_date}');
		$('#end_date').val('${gdto.end_date}');
		
		var first = new Date(today.getFullYear(), today.getMonth(), 1);
		var dayList = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
		var monthList = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
		var leapYear = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
		var notLeapYear = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
		var pageFirst = first;
		var pageYear;
		var tdGroup = [];
		
		if (first.getFullYear() % 4 == 0) {
			pageYear = leapYear;
		} else {
			pageYear = notLeapYear;
		}
		
		function showCalendar(calendarBody) {
			let monthCnt = 100;
			let cnt = 1;
			for (var i = 0; i < 6; i++) {
				var $tr = document.createElement('tr');
				$tr.setAttribute('class', monthCnt);
				for (var j = 0; j < 7; j++) {
					if ((i === 0 && j < first.getDay()) || cnt > pageYear[first.getMonth()]) {
						var $td = document.createElement('td');
						$tr.append($td);
					} else {
						var $td = document.createElement('td');
						$td.textContent = cnt;
						$td.setAttribute('class', 'day' + cnt);
						$tr.append($td);
						cnt++;
					}
				}
				monthCnt++;
				calendarBody.append($tr);
			}
		}
		currentTitle.html(monthList[first.getMonth()] + ' ' + first.getFullYear());
		showCalendar(calendarBody);
		clickedDate1 = $('.day' + today.getDate());
		clickedDate1.addClass('active');
		
		for (var i = 0; i < calendarBody.length; i++) {
			clickStart(calendarBody[i], tableName[i]);
		}
		
		function removeCalendar(calendarBody) {
			calendarBody.empty();
		}
		
		function prev(currentTitle, calendarBody, tableName) {
			var thisMonth = new Date();
			if (currentTitle.html().substring(0, (currentTitle.html()).length - 5) == (monthList[thisMonth.getMonth()])) {
				today = new Date();
				first = new Date(today.getFullYear(), today.getMonth(), 1);
			}
			
			if (pageFirst.getMonth() === 1) {
				pageFirst = new Date(first.getFullYear() - 1, 12, 1);
				first = pageFirst;
				if (first.getFullYear() % 4 === 0) {
					pageYear = leapYear;
				} else {
					pageYear = notLeapYear;
				}
			} else {
				pageFirst = new Date(first.getFullYear(), first.getMonth() - 1, 1);
				first = pageFirst;
			}
			today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
			currentTitle.html(monthList[first.getMonth()] + ' ' + first.getFullYear());
			removeCalendar(calendarBody);
			showCalendar(calendarBody);

			var inputName = tableName.substring(0, tableName.length - 4);
			console.log($('#' + inputName).val());
			var inputValue = $('#' + inputName).val();
			var inputValueYear = inputValue.substring(0, 4);
			var inputValueMonth = inputValue.substring(5, 7);
			var inputValueDay = inputValue.substring(8, 10);
			
			if (inputValueDay < 10) {
				inputValueDay = inputValue.substring(9, 10);
			}
			
			if (today.getFullYear() == inputValueYear && (today.getMonth() + 1) == inputValueMonth) {
				clickedDate1 = calendarBody.find('.day' + inputValueDay);
				clickedDate1.addClass('active');
			}
			clickStart(calendarBody, tableName);
		}
		
		function next(currentTitle, calendarBody, tableName) {
			var thisMonth = new Date();
			if (currentTitle.html().substring(0, (currentTitle.html()).length - 5) == (monthList[thisMonth.getMonth()])) {
				today = new Date();
				first = new Date(today.getFullYear(), today.getMonth(), 1);
			}
			
			if (pageFirst.getMonth() === 12) {
				pageFirst = new Date(first.getFullYear() + 1, 1, 1);
				first = pageFirst;
				if (first.getFullYear() % 4 === 0) {
					pageYear = leapYear;
				} else {
					pageYear = notLeapYear;
				}
			} else {
				pageFirst = new Date(first.getFullYear(), first.getMonth() + 1, 1);
				first = pageFirst;
			}
			today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
			currentTitle.html(monthList[first.getMonth()] + ' ' + first.getFullYear());
			removeCalendar(calendarBody);
			showCalendar(calendarBody);
			
			var inputName = tableName.substring(0, tableName.length - 4);
			console.log($('#' + inputName).val());
			var inputValue = $('#' + inputName).val();
			var inputValueYear = inputValue.substring(0, 4);
			var inputValueMonth = inputValue.substring(5, 7);
			var inputValueDay = inputValue.substring(8, 10);
			
			if (inputValueDay < 10) {
				inputValueDay = inputValue.substring(9, 10);
			}
			
			if (today.getFullYear() == inputValueYear && (today.getMonth() + 1) == inputValueMonth) {
				clickedDate1 = calendarBody.find('.day' + inputValueDay);
				clickedDate1.addClass('active');
			}
			clickStart(calendarBody, tableName);
		}
		
		var clickedDate1 = $('.day' + today.getDate());
		clickedDate1.addClass('active');
		var prevBtn = $('.calendar_prev');
		var nextBtn = $('.calendar_next');
		
		prevBtn.on('click', function(){
			var currentTitle = $(this).parent().next();
			var calendarBody = $(this).closest('table').find('.calendar_body');
			var tableName = $(this).closest('table').attr('id');
			prev(currentTitle, calendarBody, tableName);
		})
		
		nextBtn.on('click', function(){
			var currentTitle = $(this).parent().prev();
			var calendarBody = $(this).closest('table').find('.calendar_body');
			var tableName = $(this).closest('table').attr('id');
			next(currentTitle, calendarBody, tableName);
		})
		
		function clickStart(calendarBody, tableName) {
			$(calendarBody).find('td').on('click', function(){
				for (let i = 1; i <= pageYear[first.getMonth()]; i++) {
					tdGroup[i] = $(calendarBody).find('td');
				}
				clickedDate1 = $(this);
				var daylength = $(this).attr('class').length;
				var day = $(this).attr('class').substring(3, daylength);
				
				today = new Date(today.getFullYear(), today.getMonth(), day);
				var month = today.getMonth() + 1;
				var currentYearMonth = $(this).closest('table').find('.current_year_month').html();
				var currentLength = currentYearMonth.length;
				var currentMonthName = currentYearMonth.substring(0, currentLength - 5);
				var currentMonthNum = monthList.indexOf(currentMonthName) + 1;
				
				if (currentMonthNum < 10) {
					month = '0'.concat(currentMonthNum);
				}
				
				if (daylength < 5) {
					day = '0'.concat(day);
				}
				
				keyValue = today.getFullYear() + '-' + month + '-' + day;
				
				var selectedDate = new Date(today.getFullYear(), month - 1, day);
				
				var realToday = new Date();
				realToday.setDate(realToday.getDate() - 1);
				
				if (selectedDate < realToday) {
					alert('오늘부터 선택 가능합니다.');
					return false;
				}
				
				if (tableName == 'apply_end_cal' || tableName == 'end_date_cal') {
					var inputSibling = $(this).closest('table').prev().attr('id');
					var inputSiblingName = inputSibling.substring(0, inputSibling.length - 4);
					if ($('#' + inputSiblingName).val() == '') {
						alert('시작 날짜를 먼저 설정해 주세요.');
						return false;
					}
					
					var startDate = $('#' + inputSiblingName).val();
					var startDateYear = startDate.substring(0, 4);
					var startDateMonth = startDate.substring(5, 7);
					var startDateDay = startDate.substring(8, 10);
					
					startDate = new Date(startDateYear, startDateMonth - 1, startDateDay);
					
					if (selectedDate < startDate) {
						alert('시작 날짜보다 이전 날짜를 마감 날짜로 설정하실 수 없습니다.');
						return false;
					}
				}
				
				if (tableName == 'apply_start_cal' || tableName == 'start_date_cal') {
					var inputSibling = $(this).closest('table').next().attr('id');
					var inputSiblingName = inputSibling.substring(0, inputSibling.length - 4);
					if ($('#' + inputSiblingName).val() != '') {
						var endDate = $('#' + inputSiblingName).val();
						var endDateYear = endDate.substring(0, 4);
						var endDateMonth = endDate.substring(5, 7);
						var endDateDay = endDate.substring(8, 10);
						
						endDate = new Date(endDateYear, endDateMonth - 1, endDateDay);
						
						if (selectedDate > endDate) {
							alert('마감 날짜보다 이후 날짜를 시작 날짜로 설정하실 수 없습니다.');
							return false;
						}
					}
				}
				
				for (let j = 1; j <= pageYear[first.getMonth()]; j++) {
					if ($(tdGroup[j]).hasClass('active')) {
						$(tdGroup[j]).removeClass('active');
					}
				}
				
				var inputName = tableName.substring(0, tableName.length - 4);
				$('#' + inputName).val(keyValue);
				
				$(this).addClass('active');
			});
 		}
		
		$('#max_num').on('keyup', function(){
			var num = $(this).val();
			var regex = /^[0-9]*$/;
			if (!regex.test(num)) {
				alert('숫자만 입력 가능합니다.');
				$(this).val('');
			}
		})
		
		$('#max_num').focusout(function(){
			var tryModify = $('#max_num').val();
			var curNum = ${gdto.cur_num};
			if (tryModify < curNum) {
				alert('현재 인원보다 적은 인원으로 설정하실 수 없습니다.');
				$('#max_num').val('${gdto.max_num}');
			}
		})
		
		$('#contents').summernote({
			height: 600,
			callbacks: {
				onImageUpload: function(files) {
					uploadSummernoteImageFile(files[0], this);
				}
			}
		})
		
		function uploadSummernoteImageFile(file, editor) {
			data = new FormData();
			data.append("file", file);
			$.ajax({
				data: data,
				type: "POST",
				url: "/group/imgUpload",
				contentType: false,
				processData: false,
				success: function(data) {
					$(editor).summernote('insertImage', data.url);
				}
			})
		}
	})
</script>
	<h2>그룹 등록하기</h2>
	<form action="/group/updateProc?seq=${gdto.seq}" id="updateProc" name="updateProc" method="post">
		제목: <input type="text" name="title" id="title"><br>
		유형: 
		<c:forEach var="hbdto" items="${hblist}">
			<input type="checkbox" name="hobby" class="hobby_list" id="${hbdto.seq}" value="${hbdto.hobby}"><label for="${hbdto.seq}">${hbdto.hobby}</label>
		</c:forEach>
		<input type="text" name="hobby_type" id="hobby_type">
		<br>
		모집 기간: 
		<span id="apply_start_cal_btn">달력</span>
		<input type="text" name="apply_start" id="apply_start" readonly>
		 ~ 
		<span id="apply_end_cal_btn">달력</span>
		<input type="text" name="apply_end" id="apply_end" readonly><br>
		<table id="apply_start_cal" align="center">
			<thead>
				<tr>
					<td>
						<label class="calendar_prev">◀</label>
					</td>
					<td align="center" class="current_year_month" colspan="5"></td>
					<td>
						<label class="calendar_next">▶</label>
					</td>
				</tr>
				<tr>
					<td class="sun" align="center">Sun</td>
					<td align="center">Mon</td>
					<td align="center">Tue</td>
					<td align="center">Wed</td>
					<td align="center">Thu</td>
					<td align="center">Fri</td>
					<td class="sat" align="center">Sat</td>
				</tr>
			</thead>
			<tbody class="calendar_body"></tbody>
		</table>
		<table id="apply_end_cal" align="center">
			<thead>
				<tr>
					<td>
						<label class="calendar_prev">◀</label>
					</td>
					<td align="center" class="current_year_month" colspan="5"></td>
					<td>
						<label class="calendar_next">▶</label>
					</td>
				</tr>
				<tr>
					<td class="sun" align="center">Sun</td>
					<td align="center">Mon</td>
					<td align="center">Tue</td>
					<td align="center">Wed</td>
					<td align="center">Thu</td>
					<td align="center">Fri</td>
					<td class="sat" align="center">Sat</td>
				</tr>
			</thead>
			<tbody class="calendar_body"></tbody>
		</table>
		진행 기간: 
		<span id="start_date_cal_btn">달력</span>
		<input type="text" name="start_date" id="start_date" readonly>
		 ~ 
		<span id="end_date_cal_btn">달력</span>
		<input type="text" name="end_date" id="end_date" readonly><br>
		<table id="start_date_cal" align="center">
			<thead>
				<tr>
					<td>
						<label class="calendar_prev">◀</label>
					</td>
					<td align="center" class="current_year_month" colspan="5"></td>
					<td>
						<label class="calendar_next">▶</label>
					</td>
				</tr>
				<tr>
					<td class="sun" align="center">Sun</td>
					<td align="center">Mon</td>
					<td align="center">Tue</td>
					<td align="center">Wed</td>
					<td align="center">Thu</td>
					<td align="center">Fri</td>
					<td class="sat" align="center">Sat</td>
				</tr>
			</thead>
			<tbody class="calendar_body"></tbody>
		</table>
		<table id="end_date_cal" align="center">
			<thead>
				<tr>
					<td>
						<label class="calendar_prev">◀</label>
					</td>
					<td align="center" class="current_year_month" colspan="5"></td>
					<td>
						<label class="calendar_next">▶</label>
					</td>
				</tr>
				<tr>
					<td class="sun" align="center">Sun</td>
					<td align="center">Mon</td>
					<td align="center">Tue</td>
					<td align="center">Wed</td>
					<td align="center">Thu</td>
					<td align="center">Fri</td>
					<td class="sat" align="center">Sat</td>
				</tr>
			</thead>
			<tbody class="calendar_body"></tbody>
		</table>
		최대 인원: <input type="text" name="max_num" id="max_num" placeholder="00"> 명<br>
		장소: <input type="text" name="location" id="location" placeholder="**시 **구"><br>
		내용: <textarea name="contents" id="contents">그룹을 소개할 내용을 작성하는 곳입니다. 정확한 모임 날짜와 시간, 참여 가능 기준 등을 기재하시면 도움이 됩니다.</textarea><br>
		<input type="button" id="update" onclick="javascript:updateProc_func()" value="수정하기">
		<button type="button" id="back">돌아가기</button>
	</form>
	<script>
		function updateProc_func(){
			var hobbyCheckLength = $("input:checkbox[name='hobby']").length;
			var hobbyList = [];
			
			for (var i = 0; i < hobbyCheckLength; i++) {
				if ($("input:checkbox[name='hobby']:eq(" + i + ")").prop('checked') == true) {
					hobbyList.push($("input:checkbox[name='hobby']:eq(" + i + ")").val());
				}
			}
			console.log(hobbyList);
			$('#hobby_type').val(hobbyList);
			
			$('#updateProc').submit();
		}
	</script>
<jsp:include page="/WEB-INF/views/footer.jsp"/>