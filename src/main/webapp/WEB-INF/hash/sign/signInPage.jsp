<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Metronome</title>
	<style type="text/css">
		#signInDiv{
			width: 500px;
			margin: 0 auto;
			text-align: center;
			align-content: center;
		}
		#bottomLogo{
	   		width: 350px;
	   	}
	   	#signBoxDiv{
	   		background-color: lightgray;
	   		width: 300px;
	   		height: 180px;
	   		margin: 0 auto;
	   		border-radius: 5px;
	   		padding-top: 10px;
	   	}
	   	.inputLabel{
	   		font-weight: lighter;
	   		float: left;
	   		padding-left: 3%;
	   		padding-bottom: 5px;
	   	}
	   	.signInInput{
	   		width: 280px;
	   		height: 25px;
	   		border-radius: 5px;
	   	}
	   	#signInBtn{
	   		margin-top: 10px;
	   		width: 285px;
	   		height: 35px;
	   		background-color: green;
	   		color: white;
	   		border-radius: 5px;
	   		font-size: 15px;
	   		font-weight: bold;
	   	}
	   	#signInBtn:hover{
	   		background-color: darkgreen;
	   	}
	   	#resetPwLink{
	   		float: right;
	   		font-size: 12px;
	   		padding-right: 3%;
	   		padding-top: 1%;
	   		text-decoration-line: none;
	   	}
	   	#resetPwLink:hover {
			color: blue;
			text-decoration-line: underline;
		}
	</style>
	<script type="text/javascript" charset="UTF-8">
		<%@ include file="/js/commonJS.js" %>
	</script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> 
	<script type="text/javascript">
		$(document).ready(function (){
			if('${errorRst}' != ''){
				alert('${errorRst}');
			}
			$("#inputUserId").focus();
			
			$("#signInBtn").on("click", function(){
				signInProcess();
			});
			// Enter key 입력시 로그인
			$("input").on("keyup", function(key){
				if(key.keyCode == 13){
					signInProcess();
				}
			});
			
			// 비밀번호 찾기 페이지 이동
			$("#resetPwLink").on("click", function(){
				let formInfo = document.getElementById("signInForm");
				formInfo.method = "post"
				formInfo.action = "/sign/resetPwLink";
				formInfo.submit();
			});
			
			function signInProcess(){
				// id, pw 입력이 완료되었는지 확인
		 		if(isNull($("#inputUserId").val()) || isNull($("#inputUserPw").val())){
		 			alert("ID 혹은 PW가 입력되지 않았습니다.");
		 			return;
		 		}
		 		// signIn check process
		 		signInCheck();
				// 입력한 비밀번호를 sha256을 통해 암호화 처리
			}
			
			// 입력된 회원정보를 DB에 저장
			function signInCheck(){
				idCheckRst = false;
				let formInfo = document.getElementById("signInForm");
				formInfo.method = "post"
				formInfo.action = "/sign/signInCheck";
				formInfo.submit();
			}
			
		});
	</script>
</head>
<body>
	<div id="signInDiv">
		<a id="homeLogo" onclick="goHome()">
			<img id="bottomLogo" alt="홈페이지 아이콘" src="${path}/resources/images/logo/irondrum-logo_icon.jpg">
		</a>
		<h2>Sign in to Metronome</h2>
		<form id="signInForm">
			<div id="signBoxDiv">
				<div>
					<label for="inputUserId" class="inputLabel">Email or ID</label>
					<br>
					<input id="inputUserId" name="inputUserId" type="text" class="signInInput" required/>
				</div>
				<div>
					<label for="inputUserPw" class="inputLabel">Password</label>
					<a id="resetPwLink">Forget password?</a>
					<br>
					<input id="inputUserPw" name="inputUserPw" type="password" class="signInInput" required/>
				</div>
				<input id="signInBtn" type="button" value="Sign in" />
			</div>
		</form>
	</div>
</body>
</html>