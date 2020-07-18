<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<jsp:include page="/WEB-INF/views/header.jsp"/>

<script src="/resources/js/snsSignUp.js"></script>

	<div id="subWrap" class="hdMargin" style="padding-top: 155.8px;">
		<section id="subContents">
			<article id="group_list" class="inner1200">	
				<div id="joinForm">
					<div class="tit_s1">
				    	<h2>MEMBER</h2>
				    	<p>SNS 회원가입</p>
				    </div>
				    <div class="formBox card_body">
						<form action="snsSingUpProc" method="post" id="joinProc" enctype="multipart/form-data">
							<input type="hidden" name="mem_type" value="${mdto.mem_type}">
							<input type="hidden" name="category" value="member">
							<input type="hidden" name="grade" value="defalut">
							<input type="hidden" name="id" value="${mdto.id}">
							<input type="hidden" name="name" value="${mdto.name}">
							<input type="hidden" name="pw" value="${mdto.pw}">
							<input type="hidden" name="sysname" value="${mdto.sysname}">
							
							
							<div class="se_singup">
								<div class="title">아이디</div>
								<div class="se_con">
									${mdto.id}
								</div>
							</div>
				
							<div class="se_singup">
								<div class="title">이름</div>
								<div class="se_con">
									${mdto.name}
								</div>
							</div>
				
							<div class="se_singup ageGenderSec">
								<div class="title">나이</div>
								<div class="se_con clearfix">
									<div class="age">
										<input type="text" id="age" name="age" class="w70"> 세				
									</div>
									<div class="gender">
										<ul class="radio_s1">
											<li>
												<input type="radio" name="gender" value="남자" id="m">
												<label for="m"><span></span>남자</label>
											</li>
											<li>
												<input type="radio" name="gender" value="여자" id="g">
												<label for="g"><span></span>여자</label>
											</li>
										</ul>									
									</div>
								</div>
							</div>
				
							<div class="se_singup">
								<div class="title">e-mail</div>
								<div class="se_con">
									<input type="text" id="email" name="email" class="w100" placeholder="이메일을 올려주세요">
								</div>
							</div>
				
							<div class="se_singup phoneSec">
								<div class="title">전화번호</div>
								<div class="se_con clearfix">
									<div>
										<select id="phone_country" name="phone_country" class="w20">
											<option value="null" id="phone_countryNull">선택 안함</option>
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="070">070</option>
										</select>
									</div>
									<div>
										<input type="text" id="phone" name="phone" class="w80" placeholder="'-'는 제외하고 작성">
									</div>
								</div>
							</div>
				
							<div class="se_singup addrSec">
								<input type="hidden" name="address" id="address">
								<div class="title">주소</div>
								<div class="se_con clearfix">
									<div><select name="sido1" id="sido1"></select></div>
									<div><select name="gugun1" id="gugun1"></select></div>
								</div>
							</div>
				
							<div class="se_singup bankSec">
								<div class="title">은행</div>
								<div class="se_con clearfix">
									<div>
										<select id="bank_name" name="bank_name">
											<option value="null">선택 안함</option>
											<c:forEach var="i" items="${bankList}">	
												<option value="${i.bank_name}">${i.bank_name}</option>
											</c:forEach>
										</select>
									</div>
									<div>
										<input type="text" id="account" name="account" class="w80">
									</div>
								</div>
							</div>
							
							<div class="se_singup">
								<div class="title">프로필 사진</div>
								<div class="se_con">
									<img src="${mdto.sysname}" alt="카카오 프로필">
									<!--  <input type="file" id="profile" name="profile">-->
								</div>
							</div>
				
							<div class="se_singup">
								<div class="title">나라</div>
								<div class="se_con">
									<select id="country" name="country" class="w100">
										<option value="null">선택 안함</option>
										<c:forEach var="i" items="${countryList}">						
											<option value="${i.name}">${i.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
				
							<div class="se_singup">
								<div class="title">구사 가능 언어 (최대 3개)</div>
								<div class="se_con">
									<ul class="checkBox_s1">
										<c:forEach var="i" items="${lanList}" varStatus="status">	
										<li>
											<input type="checkbox" name="lang_can" value="${i.language}" id="test${status.index}" name="lang_can"/>
											<label for="test${status.index}" ><span></span>${i.language}</label>
										</li>
										</c:forEach>
									</ul>
								</div>
							</div>
				
							<div class="se_singup">
								<div class="title">배우고 싶은 언어 (최대 3개)</div>
								<div class="se_con">
									<ul class="checkBox_s1">
										<c:forEach var="i" items="${lanList}" varStatus="status">	
										<li>
											<input type="checkbox" name="lang_learn" value="${i.language}" id="test2${status.index}" />
											<label for="test2${status.index}" ><span></span>${i.language}</label>
										</li>
										</c:forEach>
									</ul>
								</div>
							</div>
				
							<div class="se_singup">
								<div class="title">취미 (최대 3개)</div>
								<div class="se_con">
									<ul class="checkBox_s1">
										<c:forEach var="i" items="${hobbyList}" varStatus="status">		
										<li>
											<input type="checkbox" name="hobby" value="${i.hobby}" id="test3${status.index}" name="hobby">
											<label for="test3${status.index}"><span></span>${i.hobby}</label>
										</li>
										</c:forEach>
									</ul>
								</div>
							</div>
				
							<div class="se_singup">
								<div class="title">자기소개</div>
								<div class="se_con">
									<textarea id="introduce" name="introduce" class="w100"> </textarea>
									<span id="counter">(0 / 최대 500자)</span>
								</div>
							</div>
							<div class="btnS1 center">
								<div>
									<input value="회원가입" type="submit">
								</div>
								<div><a href="javascript:history.back();">뒤로가기</a></div>
							</div>
						</form>
				    </div>
				</div>
			</article>
		</section>
	</div>
	
<jsp:include page="/WEB-INF/views/footer.jsp"/>