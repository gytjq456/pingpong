<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<jsp:include page="/WEB-INF/views/header.jsp"/>
<script	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<style>


#lessonApp_view .main {
	width: 100%;
	display: block;
}

#lessonApp_view .content-wrap_01 {
	width: 30%;
	border: 4px solid rgba(161, 161, 161, 0.5);
	overflow: hidden;
	background: white;
}

#lessonApp_view .content-wrap_02 {
	width: 30%;
	margin: 0 auto;
	border: 4px solid rgba(161, 161, 161, 0.5);
	overflow: hidden;
	background: white;
}

#lessonApp_view .del-data {
	display: block;
	float: left;
	width: 10%;
	cursor: pointer;
	font-size: 10px;
	padding: 10px;
	background: #0b0809;
	border: none;
	border-radius: 10px;
}

#lessonApp_view .content-right {
	float: left;
	width: 100%;
	padding: 10px;
}

#lessonApp_view .sun {
	color: #ef3333;
}

#lessonApp_view .sat {
	color: #2107e0;
}

#lessonApp_view .content-right table tr td {
	width: 40px;
	height: 20px;
	text-align: center;
	font-size: 9px;
	font-weight: bold;
}

#lessonApp_view .active {
	background: #0b0809;
	border-radius: 50%;
	color: #ffffff;
}

#lessonApp_view .title_left {
	float: left;
}

#lessonApp_view #title {
	width: 70%;
}

</style>

<script>

$(function(){
   $(".content-wrap_01").hide();
   $(".content-wrap_02").hide();   
   $(".content-wrap_03").hide();
   $(".content-wrap_04").hide();   
 
   var currentTitle_01 = document.getElementById('current-year-month_01');
   var currentTitle_02 = document.getElementById('current-year-month_02');
   var currentTitle_03 = document.getElementById('current-year-month_03');
   var currentTitle_04 = document.getElementById('current-year-month_04');
   //var currentTitle = $(".current-year-month");
   var calendarBody_01 = document.getElementById('calendar-body_01');
   var calendarBody_02 = document.getElementById('calendar-body_02');
   var calendarBody_03 = document.getElementById('calendar-body_03');
   var calendarBody_04 = document.getElementById('calendar-body_04');
   //var calendarBody = $(".calendar-body");
   console.log(calendarBody_01);

   var today = new Date(); //오늘의 날짜 연도, 요일등의 정보 모두 담기 
   var first = new Date(today.getFullYear(), today.getMonth(), 1);
   var dayList = [ 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday',
         'Friday', 'Saturday' ];
   var monthList = [ 'January', 'February', 'March', 'April', 'May',
         'June', 'July', 'August', 'September', 'October', 'November',
         'December' ];
   var leapYear = [ 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]; // 1월~ 12월까지 총 일수
   var notLeapYear = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]; // 1월~ 12월까지 총 일수
   var pageFirst = first;
   var pageYear;

   if (first.getFullYear() % 4 === 0) { //윤년체크
      pageYear = leapYear; //윤년일때  
   } else {
      pageYear = notLeapYear; //윤년아닐때 
   }
      
   //-----------------------달력 만들기

   function showCalendar(calendarBody, currentTitle) {
	  //console.log($(calendarBody).closest('table').attr('id'));
	  //console.log($(currentTitle).closest('table').attr('id'));
      currentTitle.innerHTML=monthList[today.getMonth()]+'&nbsp;&nbsp;&nbsp;&nbsp;' + today.getFullYear();
      let monthCnt = 100;
      let cnt = 1;

      for (var i = 0; i < 6; i++) { //주 만들기(최대 6주)
         var $tr = document.createElement('tr');
         $tr.setAttribute('id', monthCnt);
         for (var j = 0; j < 7; j++) { //일 만들기
            if ((i === 0 && j < first.getDay()) //만약 첫번째 주라면 시작하는 요일부터 날짜를 출력 
                  || cnt > pageYear[first.getMonth()]) { //달력 출력 종료 조건
               var $td = document.createElement('td');
               $tr.appendChild($td);
            } else {
               var $td = document.createElement('td');
               $td.textContent = cnt;
               $td.setAttribute('class', cnt);
               $tr.appendChild($td);
               cnt++;
            }
         }
         monthCnt++;
         calendarBody.append($tr);
      }
   }

   showCalendar(calendarBody_01, currentTitle_01);
   showCalendar(calendarBody_02, currentTitle_02);
   showCalendar(calendarBody_03, currentTitle_03);
   showCalendar(calendarBody_04, currentTitle_04);
   
   function removeCalendar(calendarBody) {
       $(calendarBody).empty();
    }
   
   $("#cal1").on("click", function(){
	  console.log($(".content-wrap_01").css("display") != "none");
	  
	  $(".content-wrap_01").show();
      $(".content-wrap_02").hide(); 
   })
   $("#cal2").on("click", function(){
      $(".content-wrap_02").show();
      $(".content-wrap_01").hide();
   })
   $("#cal3").on("click", function(){
      $(".content-wrap_03").show();
      $(".content-wrap_04").hide();
   })
   $("#cal4").on("click", function(){
      $(".content-wrap_04").show();
      $(".content-wrap_03").hide();
   })
   
   
   //--------------------달 이동하기
   function prev(calendarBody, currentTitle) {
      console.log($(calendarBody).closest('table').attr('id'));	//부모테이블에 id속성 찾아라 
      if (pageFirst.getMonth() === 1) {
         pageFirst = new Date(first.getFullYear() - 1, 12, 1);
         first = pageFirst;
         if (first.getFullYear() % 4 === 0) {
            pageYear = leapYear;
         } else {
            pageYear = notLeapYear;
         }
      } else {
         pageFirst = new Date(first.getFullYear(), first.getMonth() - 1,
               1);
         first = pageFirst;
      }

      today = new Date(today.getFullYear(), today.getMonth() - 1, today
            .getDate());

      currentTitle.innerHTML=monthList[today.getMonth()]+'&nbsp;&nbsp;&nbsp;&nbsp;' + today.getFullYear();
      removeCalendar(calendarBody);
      showCalendar(calendarBody, currentTitle);
      
      clickedDate1 = $("."+today.getDate());
      //clickedDate1 = document.getElementById(today.getDate());
      
      console.log(clickedDate1);
      $(clickedDate1).addClass('active');
      //$(clickedDate1).classList.add('active'); 
      clickStart(calendarBody, currentTitle);

   }
   $("#prev").on("click", function() {
	 // console.log($(prev).find('table').attr('id'));
    	prev(calendarBody_01,currentTitle_01);
   })
   $("#prev_02").on("click", function() {
      prev(calendarBody_02,currentTitle_02);
   }) 
   $("#prev_03").on("click", function() {
      prev(calendarBody_03,currentTitle_03);
   })  
   $("#prev_04").on("click", function() {
      prev(calendarBody_04,currentTitle_04);
   })  
   
   
   function next(calendarBody, currentTitle) {
      if (pageFirst.getMonth() === 12) {
         pageFirst = new Date(first.getFullYear() + 1, 1, 1);
         first = pageFirst;
         if (first.getFullYear() % 4 === 0) {
            pageYear = leapYear;
         } else {
            pageYear = notLeapYear;
         }
      } else {
         pageFirst = new Date(first.getFullYear(), first.getMonth() + 1,
               1);
         first = pageFirst;
      }
      today = new Date(today.getFullYear(), today.getMonth() + 1, today
            .getDate());
      currentTitle.innerHTML=monthList[today.getMonth()]+'&nbsp;&nbsp;&nbsp;&nbsp;' + today.getFullYear();
      removeCalendar(calendarBody);
      showCalendar(calendarBody, currentTitle);

      clickedDate1 = $("."+today.getDate());
      $(clickedDate1).addClass('active');
      //clickedDate1.classList.add('active'); 
      clickStart(calendarBody, currentTitle);
   }
   
   $("#next").on("click", function() {
      next(calendarBody_01,currentTitle_01);
   })
   $("#next_02").on("click", function() {
      next(calendarBody_02,currentTitle_02);
   })
   $("#next_03").on("click", function() {
      next(calendarBody_03,currentTitle_03);
   })
   $("#next_04").on("click", function() {
      next(calendarBody_04,currentTitle_04);
   })

   //----------------------------누르면 색상 변하기

   clickedDate1 = $("."+today.getDate());
   console.log(clickedDate1);
   $(clickedDate1).addClass('active');

   var prevBtn = $("#prev");
   var nextBtn = $("#next");
   prevBtn.click;
   nextBtn.click;
   
   var prevBtn_02 = $("#prev_02");
   var nextBtn_02 = $("#next_02");
   prevBtn_02.click;
   nextBtn_02.click;
   
   var prevBtn_03 = $("#prev_03");
   var nextBtn_03 = $("#next_03");
   prevBtn_03.click;
   nextBtn_03.click;
   
   var prevBtn_04 = $("#prev_04");
   var nextBtn_04 = $("#next_04");
   prevBtn_04.click;
   nextBtn_04.click;
   
   var tdGroup = [];
   
   function clickStart(calendarBody, currentTitle) {
	   console.log($(calendarBody).closest('table').attr('id'));

    	$(".calendar-body td").on("click",function(){

			clickedDate1 = $(this);
			
			var calendar = clickedDate1.closest(".calendar-body"); 
			
			console.log(calendar);
			
			calendar.find("td").removeClass("active");
			clickedDate1.addClass('active');
			
			today = new Date(today.getFullYear(), today.getMonth(), $(clickedDate1).html());
			   	      
			console.log($(clickedDate1));
			   	      
			keyValue = today.getFullYear() + '' + (today.getMonth()+1) + '' + today.getDate();
			
			if(calendar.attr("id") == "calendar-body_01"){
				$("#apply_start").val(keyValue);
			}else if(calendar.attr("id") == "calendar-body_02"){
				$("#apply_end").val(keyValue);
			}else if(calendar.attr("id")=="calendar-body_03"){
				$("start_date").val(keyValue);
			}else if(calendar.attr("id")=="calendar-body_04"){
				$("end_date").val(keyValue);
			}

	
   			})

		}


   clickStart();
   
})

</script>


	<div id="subWrap" class="hdMargin">
		<section id="subContents">
			<article id="lessonApp_view" class="inner1200">
			<div class="tit_s1">
				<h2>Lesson</h2>
				<p>새 강의 등록하기</p>
			</div>
			
			<div class="title_main">
					<div class="title_wrap">
						<div class="left">제목 &nbsp;&nbsp;&nbsp;</div>
						<div class="right">
							<input type="text" id="title" name="title" 
							placeholder="강의 성격이 드러날 키워드를 포함하여 간결한 제목으로 설정해 주세요.">
						</div>
						
					</div>
				</div>
				
				<div class="price_main">
					<div class="price_wrap">
						<div class="left">가격 &nbsp;&nbsp;&nbsp;</div>
						<div class="right">
							<input type="text" id="price" name="price" 
							placeholder="시간당 가격"> 원 /시간
						</div>
					</div>
				</div>
				
				<div class="language_main">
					<div class="language_wrap">
						<div class="left">언어 &nbsp;&nbsp;&nbsp;</div>
						<div class="right">
							<select id="language" name="language">
								<c:forEach var="i" items="${lanList}">	
									<option value="${i.language}">${i.language}</option>
								</c:forEach>
							</select>
						</div>
					</div>
				</div>
			
				<div class="appPeriod_main">
					<div class="appPeriod_wrap">
					<div class="tit_s3">
						<h4>모집 기간</h4>
					</div>
					<div class="right">
							<span id="cal1">달력1</span> <input type="text" id="apply_start"
								name="apply_start"> ~ <span id="cal2">달력2</span> <input
								type="text" id="apply_end" name="apply_end">
						</div>
					</div>
				</div>
			
				<!-- 달력 1 -->
				<div class="main">
					<div id="content-wrap_01" class="content-wrap_01">
						<div class="content-right">
							<table id="calendar_01" class="calendar" align="center">
								<thead>
									<tr class="btn-wrap clearfix">
										<td><label id="prev"> &#60; </label></td>
										<td align="center" id="current-year-month_01" colspan="5"></td>
										<td><label id="next"> &#62; </label></td>
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
								<tbody id="calendar-body_01" class="calendar-body"></tbody>
							</table>
						</div>
					</div>
				</div>
			
				<!-- 달력 2 -->
				<div class="main">
					<div id="content-wrap_02" class="content-wrap_02">
						<div class="content-right">
							<table id="calendar_02" class="calendar" align="enter">
								<thead>
									<tr class="btn-wrap clearfix">
										<td><label id="prev_02"> &#60; </label></td>
										<td align="center" id="current-year-month_02" colspan="5"></td>
										<td><label id="next_02"> &#62; </label></td>
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
								<tbody id="calendar-body_02" class="calendar-body"></tbody>
							</table>
						</div>
					</div>
				</div>
				
				<!-- 수업기간 -->
				<div class="lessonPeriod_main">
					<div class="lessonPeriod_wrap">
						<div class="left">모집기간 &nbsp;&nbsp;&nbsp;</div>
						<div class="right">
							<span id="cal1">달력3</span> <input type="text" id="start_date"
								name="start_date"> ~ <span id="cal2">달력4</span> <input
								type="text" id="end_date" name="end_date">
						</div>
					</div>
				</div>
			
				<!-- 달력 3 -->
				<div class="main">
					<div id="content-wrap_03" class="content-wrap_03">
						<div class="content-right">
							<table id="calendar_03" class="calendar" align="center">
								<thead>
									<tr class="btn-wrap clearfix">
										<td><label id="prev_03"> &#60; </label></td>
										<td align="center" id="current-year-month_03" colspan="5"></td>
										<td><label id="next_03"> &#62; </label></td>
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
								<tbody id="calendar-body_03" class="calendar-body"></tbody>
							</table>
						</div>
					</div>
				</div>
			
				<!-- 달력 4 -->
				<div class="main">
					<div id="content-wrap_04" class="content-wrap_04">
						<div class="content-right">
							<table id="calendar_04" class="calendar" align="enter">
								<thead>
									<tr class="btn-wrap clearfix">
										<td><label id="prev_04"> &#60; </label></td>
										<td align="center" id="current-year-month_04" colspan="5"></td>
										<td><label id="next_04"> &#62; </label></td>
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
								<tbody id="calendar-body_04" class="calendar-body"></tbody>
							</table>
						</div>
					</div>
				</div>
			
			
			</article>
		</section>
	</div>
	
<jsp:include page="/WEB-INF/views/footer.jsp"/>