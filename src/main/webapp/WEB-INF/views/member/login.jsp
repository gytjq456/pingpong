<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/header.jsp" />
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="/resources/js/login.js"></script>

<div id="subWrap" class="hdMargin" style="padding-top: 155.8px;">
	<section id="subContents">
		<div id="login" class="card_body">
			<h1 class="h1">login</h1>
			<input type="text" name="id" id="id" placeholder="Id"><br>
			<input type="password" name="pw" id="pw" placeholder="Password"><br>
			
			<div class="idSave">
				<input type="checkbox" name="rememberId" id="rememberId" name="rememberId"> <label for="rememberId">아이디 저장하기</label>
			</div>
			<div class="loginBtn">
				<input type="button" value="Login" id="isIdPwSame">  
				<a id="login-form-btn" href="#;" onclick="loginFormWithKakao()">
					<span class="icon"><img src="/resources/img/login/kakao_login_large_wide.png" alt="카카오 로그인"></span>
				</a>
			</div>

			<div id="other_text">
				<a href="#" class="side" id="idFind">id찾기</a>
				<a href="#"	class="side" id="pwFind">비밀번호 찾기</a>
				<a href="#" class="side" id="signup">회원가입</a>
			</div>
		</div>
	</section>
</div>

	<!--  카카오 회원가입 -->
	<form id="kakoForm" action="/member/snsSignUp?mem_type=kakao" method="post">
		<input type="hidden" name="kakaoId" id="kakaoId">
		<input type="hidden" name="kakaoNickname" id="kakaoNickname">
		<input type="hidden" name="pw" value="defalut">
		<!--  <input type="hidden" name="kakaoEmail" id="kakaoEmail">-->
	</form>
	<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
	<script>
            // @details 카카오톡 Developer API 사이트에서 발급받은 JavaScript Key
            Kakao.init("67c7c1d4f175618189bdbaf82c2e4f4c");
            // @breif 카카오 로그인 버튼을 생성합니다.
            
            function loginFormWithKakao() {
                Kakao.Auth.loginForm({
                    success: function (authObj) {
                        //alert(JSON.stringify(authObj)); //<----Kakao.Auth.createLoginButton에서 불러온 결과값 json형태로 출력
                        Kakao.API.request({
                            url: "/v2/user/me",
                            success: function (res) {
                                /*
                                	res.id
                                	res.kaccount_email
                                	res.properties.nickname;
                               		res.properties.profile_image;
                               		res.properties.thumbnail_image;
                                */
                             // @breif 아이디
                                document.getElementById("kakaoId").value = res.id;
                                // @breif 닉네임
                                document.getElementById("kakaoNickname").value = res.properties.nickname;
                                document.getElementById("kakoForm").submit();
                               
                            }, fail: function (error) {
                                alert(JSON.stringify(error));
                            }
                        });
                    },
                    fail: function (err) {
                        alert(JSON.stringify(err))
                    },
                })
            }
        </script>

<jsp:include page="/WEB-INF/views/footer.jsp" />