<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/admin/aheader.jsp"/>
<style>
	#chartForLang, #chartForLoc { float: left; }
	html,body{height:100%; width:100%;}
</style>
	<c:choose>
		<c:when test="${empty sessionScope.adminLog}">
			<div id="login_wrap">
				<div id="logo_and_form">
					<div id="logo">PINGPONG</div>
					<div id="loginForm">
						<form action="/admin/login" method="post">
							<input type="text" name="id" id="id" placeholder="Admin ID"><br>
							<input type="password" name="pw" id="pw" placeholder="Admin Password"><br>
							<button>로그인</button>
						</form>
					</div>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div id="main_wrap">
				<div>일일 방문자 수</div>
				<canvas id="chartForVisitor" width="1200" height="500"></canvas>
				<div>언어 선호도</div>
				<canvas id="chartForLang" width="600" height="300"></canvas>
				<div>지역 선호도</div>
				<canvas id="chartForLoc" width="600" height="300"></canvas>
				<c:forEach var="vlist" items="${vlist}">
					<input type="hidden" id="${vlist.visit_date}" value="${vlist.visit_count}" class="dayInput">
				</c:forEach>
				<c:forEach var="llist" items="${llist}">
					<input type="hidden" id="${llist.language}" value="${llist.lang_count}" class="langInput">
				</c:forEach>
				<c:forEach var="clist" items="${clist}">
					<input type="hidden" id="${clist.loc_name}" value="${clist.loc_count}" class="locInput">
				</c:forEach>
				<script>
					function getFormatDate(date, number, type){
					    var year = date.getFullYear();              //yyyy
					    var month = (1 + date.getMonth());          //M
					    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
					    var day = date.getDate() - number;          //d
					    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
					    if (type == 'full') {
					    	return year + '/' + month + '/' + day;
					    } else {
					    	return  month + '/' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
					    }
					}
					
					var today = new Date();
					var day1 = getFormatDate(today, 0, 'short');
					var day2 = getFormatDate(today, 1, 'short');
					var day3 = getFormatDate(today, 2, 'short');
					var day4 = getFormatDate(today, 3, 'short');
					var day5 = getFormatDate(today, 4, 'short');
					var day6 = getFormatDate(today, 5, 'short');
					var day7 = getFormatDate(today, 6, 'short');
					
					var dayInputCount = $('.dayInput').length;
					
					var dayList = ["", "", "", "", "", "", ""];
					
					for (var i = 0; i < dayInputCount; i++) {
						dayList[i] = document.getElementById(getFormatDate(today, i, 'full')).value;
					}
			
					var ctx1 = document.getElementById('chartForVisitor').getContext('2d');
					var chartForVisitor = new Chart(ctx1, {
					    type: 'bar',
					    data: {
					        labels: [day7, day6, day5, day4, day3, day2, day1],
					        datasets: [{
					            label: '일일 방문자 수',
					            data: [dayList[6], dayList[5], dayList[4], dayList[3], dayList[2], dayList[1], dayList[0]],
					            backgroundColor: [
					                'rgba(255, 99, 132, 0.2)',
					                'rgba(54, 162, 235, 0.2)',
					                'rgba(255, 206, 86, 0.2)',
					                'rgba(75, 192, 192, 0.2)',
					                'rgba(153, 102, 255, 0.2)',
					                'rgba(255, 159, 64, 0.2)',
					                'rgba(100, 100, 100, 0.2)'
					            ],
					            borderColor: [
					                'rgba(255, 99, 132, 1)',
					                'rgba(54, 162, 235, 1)',
					                'rgba(255, 206, 86, 1)',
					                'rgba(75, 192, 192, 1)',
					                'rgba(153, 102, 255, 1)',
					                'rgba(255, 159, 64, 1)',
					                'rgba(100, 100, 100, 1)'
					            ],
					            borderWidth: 1
					        }]
					    },
					    options: {
					    	responsive: false,
					        scales: {
					            yAxes: [{
					                ticks: {
					                    beginAtZero: true
					                }
					            }]
					        }
					    }
					});
					
					var langLength = $('.langInput').length;
					var langList = [];
					var langNameList = [];
					
					for (var i = 0; i < langLength; i++) {
						langList[i] = $($('.langInput')[i]).val();
						langNameList[i] = $($('.langInput')[i]).attr('id');
					}
					
					var ctx2 = document.getElementById('chartForLang').getContext('2d');
					var chartForLang = new Chart(ctx2, {
					    type: 'doughnut',
					    data: {
					        labels: [langNameList[0], langNameList[1], langNameList[2], langNameList[3], langNameList[4]],
					        datasets: [{
					            label: '언어 선호도',
					            data: [langList[0], langList[1], langList[2], langList[3], langList[4]],
					            backgroundColor: [
					                'rgba(255, 99, 132, 0.4)',
					                'rgba(54, 162, 235, 0.4)',
					                'rgba(255, 206, 86, 0.4)',
					                'rgba(75, 192, 192, 0.4)',
					                'rgba(153, 102, 255, 0.4)'
					            ],
					            borderWidth: 0
					        }]
					    },
					    options: {
					    	responsive: false,
					        scales: {
					            yAxes: [{
					                ticks: {
					                    beginAtZero: true,
					                    display: false
					                },
					                gridLines: {
					                	display: false
					                }
					            }]
					        }
					    }
					});
					
					var locLength = $('.locInput').length;
					var locList = [];
					var locNameList = [];
					
					for (var i = 0; i < locLength; i++) {
						locList[i] = $($('.locInput')[i]).val();
						locNameList[i] = $($('.locInput')[i]).attr('id');
					}
					
					var ctx3 = document.getElementById('chartForLoc').getContext('2d');
					var chartForLang = new Chart(ctx3, {
					    type: 'doughnut',
					    data: {
					        labels: [locNameList[0], locNameList[1], locNameList[2], locNameList[3], locNameList[4]],
					        datasets: [{
					            label: '지역 선호도',
					            data: [locList[0], locList[1], locList[2], locList[3], locList[4]],
					            backgroundColor: [
					                'rgba(255, 99, 132, 0.4)',
					                'rgba(54, 162, 235, 0.4)',
					                'rgba(255, 206, 86, 0.4)',
					                'rgba(75, 192, 192, 0.4)',
					                'rgba(153, 102, 255, 0.4)'
					            ],
					            borderWidth: 0
					        }]
					    },
					    options: {
					    	responsive: false,
					        scales: {
					            yAxes: [{
					                ticks: {
					                    beginAtZero: true,
					                    display: false
					                },
					                gridLines: {
					                	display: false
					                }
					            }]
					        }
					    }
					});
				</script>
			</div>
		</c:otherwise>
	</c:choose>
</body>
</html>