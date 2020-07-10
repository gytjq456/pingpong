<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="/resources/css/schedule.css"/>
<script>
	$(function(){
		//매달 시작하는 요일과 일자가 다릅니다.
		var currentTitle = document.getElementById('current-year-month');
		var calendarBody = document.getElementById('calendar-body');
		var today = new Date();
		var first = new Date(today.getFullYear(), today.getMonth(),1);
		var dayList = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
		var monthList = ['January','February','March','April','May','June','July','August','September','October','November','December'];
		var leapYear=[31,29,31,30,31,30,31,31,30,31,30,31];
		var notLeapYear=[31,28,31,30,31,30,31,31,30,31,30,31];
		var pageFirst = first;
		var pageYear;
		if(first.getFullYear() % 4 === 0){
		    pageYear = leapYear;
		}else{
		    pageYear = notLeapYear;
		}

		function showCalendar(){
			currentTitle.innerHTML = monthList[first.getMonth()] + '&nbsp;&nbsp;&nbsp;&nbsp;'+ first.getFullYear();
		    let monthCnt = 100;
		    let cnt = 1;
		    for(var i = 0; i < 6; i++){
		        var $tr = document.createElement('tr');
		        $tr.setAttribute('id', monthCnt);   
		        for(var j = 0; j < 7; j++){
		            if((i === 0 && j < first.getDay()) || cnt > pageYear[first.getMonth()]){
		                var $td = document.createElement('td');
		                $tr.appendChild($td);     
		            }else{
		                var $td = document.createElement('td');
		                $td.textContent = cnt;
		                $td.setAttribute('id', cnt);                
		                $tr.appendChild($td);
		                cnt++;
		            }
		        }
		        monthCnt++;
		        calendarBody.appendChild($tr);
		    }
		}
		showCalendar();

		function removeCalendar(){
		    let catchTr = 100;
		    for(var i = 100; i< 106; i++){
		        var $tr = document.getElementById(catchTr);
		        $tr.remove();
		        catchTr++;
		    }
		}
		
		//화살표를 클릭하면 이전 달과 다음 달로 이동할 수 있습니다.
		function prev(){
		    //inputBox.value = "";
		    const $divs = document.querySelectorAll('#input-list > div');
		    $divs.forEach(function(e){
		      e.remove();
		    });
		    const $btns = document.querySelectorAll('#input-list > button');
		    $btns.forEach(function(e1){
		      e1.remove();
		    });
		    if(pageFirst.getMonth() === 1){
		        pageFirst = new Date(first.getFullYear()-1, 12, 1);
		        first = pageFirst;
		        if(first.getFullYear() % 4 === 0){
		            pageYear = leapYear;
		        }else{
		            pageYear = notLeapYear;
		        }
		    }else{
		        pageFirst = new Date(first.getFullYear(), first.getMonth()-1, 1);
		        first = pageFirst;
		    }
		    today = new Date(today.getFullYear(), today.getMonth()-1, today.getDate());
		    currentTitle.innerHTML = monthList[first.getMonth()] + '&nbsp;&nbsp;&nbsp;&nbsp;'+ first.getFullYear();
		    removeCalendar();
		    showCalendar();
		    //showMain();
		    clickedDate1 = document.getElementById(today.getDate());
		    clickedDate1.classList.add('active');
		    clickStart();
		    
		    classSchFn();
		    //reshowingList();
		}

		function next(){
		    //inputBox.value = "";
		    const $divs = document.querySelectorAll('#input-list > div');
		    $divs.forEach(function(e){
		      e.remove();
		    });
		    const $btns = document.querySelectorAll('#input-list > button');
		    $btns.forEach(function(e1){
		      e1.remove();
		    });
		    if(pageFirst.getMonth() === 12){
		        pageFirst = new Date(first.getFullYear()+1, 1, 1);
		        first = pageFirst;
		        if(first.getFullYear() % 4 === 0){
		            pageYear = leapYear;
		        }else{
		            pageYear = notLeapYear;
		        }
		    }else{
		        pageFirst = new Date(first.getFullYear(), first.getMonth()+1, 1);
		        first = pageFirst;
		    }
		    today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
		    currentTitle.innerHTML = monthList[first.getMonth()] + '&nbsp;&nbsp;&nbsp;&nbsp;'+ first.getFullYear();
		    removeCalendar();
		    showCalendar(); 
		    //showMain();
		    clickedDate1 = document.getElementById(today.getDate());
		    clickedDate1.classList.add('active');  
		    clickStart();
		
		    classSchFn();
		}
		
		
		
		// 날짜를 클릭하면 해당 날짜 스타일 변경되고 왼쪽의 날짜와 요일이 업데이트 됩니다.
		
		/* function showMain(){
		    mainTodayDay.innerHTML = dayList[today.getDay()];
		    mainTodayDate.innerHTML = today.getDate();
		} */
		var clickedDate1 = document.getElementById(today.getDate());
		clickedDate1.classList.add('active');
		var prevBtn = document.getElementById('prev');
		var nextBtn = document.getElementById('next');
		prevBtn.addEventListener('click',prev);
		nextBtn.addEventListener('click',next);
		
		classSchFn();
		var tdGroup = [];
		clickStart()
		function clickStart(){
		    for(let i = 1; i <= pageYear[first.getMonth()]; i++){
		        tdGroup[i] = document.getElementById(i);
		        tdGroup[i].addEventListener('click',changeToday);
		    }
		}
		function changeToday(e){
		    for(let i = 1; i <= pageYear[first.getMonth()]; i++){
		        if(tdGroup[i].classList.contains('active')){
		            tdGroup[i].classList.remove('active');
		        }
		    }
		    clickedDate1 = e.currentTarget;
		    clickedDate1.classList.add('active');
		    today = new Date(today.getFullYear(), today.getMonth(), clickedDate1.id);
		    //showMain();
		    keyValue = today.getFullYear() + '' + today.getMonth()+ '' + today.getDate();
		    //reshowingList();
		    classSchFn();
		}
		
		function classSchFn(){
		    var getDate = today.getDate();
		    var getMonth = today.getMonth() + 1
		    if(getDate < 10){
		    	getDate = "0"+getDate
			}
			if(getMonth < 10){
				getMonth = "0"+getMonth
			}
		    classDateSch(today.getFullYear()+"-"+getMonth+"-"+getDate);
		}
		
		
		function classDateSch(day){
			$(".groupClass ul").html("");
			$(".tutorClass ul").html("");
			$.ajax({
				url:"/classDateSch",
				dataType:"json",
				type:"post",
				data:{
					day:day
				}
			}).done(function(resp){
				if(resp.gList.length){
					for(var i=0; i<resp.gList.length; i++){
						var li = $("<li>");
						var info = $('<div class="info">');
						li.append('<div class="thum"><img src="/resources/img/sub/userThum.jpg"></div>')
						info.append('<div class="tit">'+resp.gList[i].title+'</div>')
						info.append('<div class="txtBox">'+resp.gList[i].contents+' </div>')
						info.append('<div class="time">진행 기간 : '+resp.gList[i].start_date+' ~ '+resp.gList[i].end_date+'')
						li.append(info);
						$(".groupClass ul").append(li);
					}
				}
				if(resp.LessonList.length){
					for(var i=0; i<resp.LessonList.length; i++){
						var li = $("<li>");
						var info = $('<div class="info">');
						li.append('<div class="thum"><img src="/resources/img/sub/userThum.jpg"></div>')
						info.append('<div class="tit">'+resp.LessonList[i].title+'</div>')
						info.append('<div class="txtBox">'+resp.LessonList[i].curriculum+' </div>')
						info.append('<div class="time">진행 기간 : '+resp.LessonList[i].start_date+' ~ '+resp.LessonList[i].end_date+'')
						li.append(info);
						$(".tutorClass ul").append(li);
					}
				}
				

			})
		}
	});
</script>

  <div class="mainSchedule">
    <div class="content-wrap">
      <div class="content-right">
        <table id="calendar" align="center">
          <thead>
            <tr class="btn-wrap clearfix">
              <td>
                <label id="prev">
                    <button type="button"><i class="fa fa-angle-left" aria-hidden="true"></i></button>
                </label>
              </td>
              <td align="center" id="current-year-month" colspan="5"></td>
              <td>
                <label id="next">
                    <button type="button"><i class="fa fa-angle-right" aria-hidden="true"></i></button>
                </label>
              </td>
            </tr>
            <tr>
                <td class = "sun" align="center">Sun</td>
                <td align="center">Mon</td>
                <td align="center">Tue</td>
                <td align="center">Wed</td>
                <td align="center">Thu</td>
                <td align="center">Fri</td>
                <td class= "sat" align="center">Sat</td>
              </tr>
          </thead>
          <tbody id="calendar-body" class="calendar-body"></tbody>
        </table>
      </div>
    </div>
  </div>
