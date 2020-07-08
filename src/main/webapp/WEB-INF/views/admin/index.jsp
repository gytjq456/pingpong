<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
<style>
	#chartForLang, #chartForLoc { float: left; }
</style>
</head>
<body>
<canvas id="chartForVisitor" width="1200" height="500"></canvas>
<canvas id="chartForLang" width="600" height="300"></canvas>
<canvas id="chartForLoc" width="600" height="300"></canvas>
	<c:choose>
		<c:when test="${empty sessionScope.adminLog}">
			<div>
				<form action="/admin/login" method="post">
					<input type="text" name="id" id="id"><br>
					<input type="password" name="pw" id="pw"><br>
					<button>로그인</button>
				</form>
			</div>
		</c:when>
		<c:otherwise>
			<a href="/admin/memberList">회원</a>
			<a href="/admin/partnerList">파트너</a>
			<a href="/admin/groupList">그룹</a>
			<a href="/admin/tutorList">튜터</a>
			<a href="/admin/tutorAppList">튜터 신청</a>
			<a href="/admin/lessonList">강의</a>
			<a href="/admin/lessonAppList">강의 신청</a>
			<a href="/admin/lessonDelList">강의 삭제</a>
			<a href="/admin/tuteeList">튜티</a>
			<a href="/admin/discussionList">토론 게시판</a>
			<a href="/admin/correctList">첨삭 게시판</a>
			<a href="/admin/reportList">신고</a>
			<a href="/admin/logout">로그아웃</a>
		</c:otherwise>
	</c:choose>
	<a href="/">메인으로</a>
	<script>
		function getFormatDate(date, number){
		    var year = date.getFullYear();              //yyyy
		    var month = (1 + date.getMonth());          //M
		    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
		    var day = date.getDate() - number;          //d
		    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
		    return  month + '/' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
		}
		
		var today = new Date();
		day1 = getFormatDate(today, 0);
		day2 = getFormatDate(today, 1);
		day3 = getFormatDate(today, 2);
		day4 = getFormatDate(today, 3);
		day5 = getFormatDate(today, 4);
		day6 = getFormatDate(today, 5);
		day7 = getFormatDate(today, 6);

		var ctx1 = document.getElementById('chartForVisitor').getContext('2d');
		var chartForVisitor = new Chart(ctx1, {
		    type: 'bar',
		    data: {
		        labels: [day7, day6, day5, day4, day3, day2, day1],
		        datasets: [{
		            label: '일일 방문자 수',
		            data: [12, 19, 3, 5, 2, 3, 15],
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
		
		var ctx2 = document.getElementById('chartForLang').getContext('2d');
		var chartForLang = new Chart(ctx2, {
		    type: 'doughnut',
		    data: {
		        labels: ['한국어', '영어', '중국어', '일본어', '스페인어'],
		        datasets: [{
		            label: '언어 선호도',
		            data: [12, 19, 3, 5, 2],
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
		
		var ctx3 = document.getElementById('chartForLoc').getContext('2d');
		var chartForLang = new Chart(ctx3, {
		    type: 'doughnut',
		    data: {
		        labels: ['서울특별시', '경기도', '부산광역시', '대구광역시', '경상북도'],
		        datasets: [{
		            label: '지역 선호도',
		            data: [12, 19, 3, 5, 2],
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
</body>
</html>