<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login-GaJi</title>

<link rel="icon"
	href="${pageContext.request.contextPath}/resources/img/favicon.ico">
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/img/favicon.ico">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/login.css">

<script>
var msg = '${msg}';
if(msg ){
	alert(msg);
}
</script>
</head>
<body>


	<!-- Page Preloder -->
	<div id="preloder">
		<div class="loader"></div>
	</div>

	<header>
		<div>
			<a href="./" target="_blank" class="logo_a_tag">
				<img
				src="${pageContext.request.contextPath}/resources/img/gaji_logo.png"
				class="gaji_logo">
			</a>
		</div>
	</header>
	<div class="content">
		<div class="login_wrap">
			<form id="login-form" name="frmNIDLogin" target="_top"
				AUTOCOMPLETE="off" action="login-check" method="POST">
				<ul class="panel_wrap">
					<li class="panel_item" style="display: block;">
						<div class="panel_inner" role="tabpanel" aria-controls="loinid">
							<div class="id_pw_wrap">
								<div class="input_row" id="id_line">
									<div class="icon_cell" id="id_cell">
										<span class="icon_id"> <span class="blind">아이디</span>
										</span>
									</div>
									<input type="text" id="id" name="userId" placeholder="아이디"
										title="아이디" class="input_text" maxlength="41" value="">
								</div>
								<div class="input_row" id="pw_line">
									<div class="icon_cell" id="pw_cell">
										<span class="icon_pw"> <span class="blind">비밀번호</span>
										</span>
									</div>
									<input type="password" id="pw" name="password"
										placeholder="비밀번호" title="비밀번호" class="input_text pw"
										maxlength="16">
								</div>
							</div>

							<!--						<div class="login_keep_wrap" id="login_keep_wrap">
								<div class="keep_check">
									<input type="checkbox" id="keep" name="nvlong"
										class="input_keep" value="off"> <label for="keep"
										class="keep_text">로그인  상태 유지</label>
								</div>

							</div>
 -->
							<div class="login_error_wrap" id="err_capslock"
								style="display: none;">
								<div class="error_message">
									<strong>CapsLock</strong>이 켜져 있습니다.
								</div>
							</div>

							<div class="login_error_wrap" id="err_empty_id"
								style="display: none;">
								<div class="error_message">
									<strong>아이디</strong>를 입력해 주세요.
								</div>
							</div>

							<div class="login_error_wrap" id="err_empty_pw"
								style="display: none;">
								<div class="error_message">
									<strong>비밀번호</strong>를 입력해 주세요.
								</div>
							</div>
							<div class="login_error_wrap" id="err_common"
								style="display: none;">
								<div class="error_message" style="width: 90%"></div>
							</div>
							<div class="btn_login_wrap">

								<button type="submit" class="btn_login" id="log.login">
									<span class="btn_text">로그인</span>
								</button>

							</div>
						</div>
					</li>
				</ul>
			</form>
		</div>
		<ul class="find_wrap" id="find_wrap">

			<li><a target="_blank" href="/gaji/pwInquiry" class="find_text">비밀번호 찾기</a></li>
			<li><a target="_blank" href="./idInquiry" class="find_text">아이디 찾기</a></li>
			<li><a target="_blank" href="./signup" class="find_text">회원가입</a></li>

		</ul>
		<!--배너-->
		<div id="gladbanner" class="banner_wrap">&nbsp;</div>
	</div>
	<div class="footer">
        <div class="footer_inner">
            <!--[주]고객센터,제휴문의,서비스안내-->
            <ul class="footer_link" id="footer_link">
                <li><a target="_blank" class="footer_item" href="#" id="fot.agreement"><span class="text">이용약관</span></a></li>
                <li><a target="_blank" class="footer_item" href="#" id="fot.privacy"><span class="text">개인정보처리방침</span></a></li>
                <li><a target="_blank" class="footer_item" href="#" id="fot.disclaimer"><span class="text">책임의 한계와 법적고지</span></a></li>
                <li><a target="_blank" class="footer_item" href="#" id="fot.help"><span class="text">회원정보 고객센터</span></a></li>
            </ul>
            <div class="footer_copy">
                <a id="fot.gaji" target="_blank" href="#">
                    <span class="footer_logo"><span class="blind">가지마켓</span></span>
                </a>
                <span class="text">Copyright</span>
                <span class="corp">© GaJi Corp.</span>
                <span class="text">All Rights Reserved.</span>
            </div>
        </div>
    </div>
	<script
		src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>

	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>

</body>
</html>