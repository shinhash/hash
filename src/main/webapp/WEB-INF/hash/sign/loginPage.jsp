<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> 
<script type="text/javascript">

	$(function(){
		$("#loginBtn").on("click", function(){
			loginProcess();
		});
		
		function loginProcess(){
			// id, pw 입력이 완료되었는지 확인
	 		if(isNull($("#inputUserId").val()) || isNull($("#inputUserPw").val())){
	 			alert("ID 혹은 PW가 입력되지 않았습니다.");
	 			return;
	 		}
	 		// login check process
	 		loginCheck();
	 		
			// 입력한 비밀번호를 sha256을 통해 암호화 처리
		}
		
		// 입력된 회원정보를 DB에 저장
		function loginCheck(){
			
			idCheckRst = false;
			let formInfo = document.getElementById("loginForm");
			formInfo.setAttribute("method", "post");
			formInfo.setAttribute("action", "/sign/loginCheck");
			formInfo.submit();
		}
		
		
		function isNull(inputTemp){
			var isNullRst = false;
			if(inputTemp == undefined || inputTemp == "" || inputTemp == null){
				isNullRst = true;
			}
			return isNullRst;
		}
	})

</script>
</head>
<body>
	<h2>LogIn</h2>
	<form id="loginForm">
		<div id="loginDiv">
			<label>ID</label> : <input id="inputUserId" name="inputUserId" type="text"/><br>
			<label>PW</label> : <input id="inputUserPw" name="inputUserPw" type="password"/><br>
			<button id="loginBtn">LOGIN</button>
		</div>
	</form>
</body>
</html>