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
	 		var inputId = $("#inputUserId").val();
	 		var inputPw = $("#inputUserPw").val();
	 		
	 		if(isNull(inputId) || isNull(inputPw)){
	 			alert("ID 혹은 PW가 입력되지 않았습니다.");
	 			return;
	 		}
	 		// ajax를 통해 입력된 id, pw 정보 조회
	 		var sendData = {"userId" : inputId, "userPw" : inputPw};
	 		loginCheck(sendData);
	 		
	 		
			// 입력한 비밀번호를 sha256을 통해 암호화 처리
		}
		
		// ajax를 통해 입력된 id, pw 정보 조회
		function loginCheck(sendData){
			$.ajax({
				type	: "POST",
				url		: "/sign/loginCheck",
				data	: sendData,
				success : function(result){
					var userInfo = result.userInfo;
					if(!isNull(userInfo)){
						// 입력된 비밀번호 정보와 서버에 있는 비밀번호가 일치하는지 확인
						var isEqualRst = isEqualsPassWord(sendData, userInfo);
						// 일치할 경우 로그인 process 진행
						if(isEqualRst){
							alert("로그인 성공!!!");
						}else{
							alert("입력한 비밀번호와 일치하지 않습니다.");
							return;
						}
					}else{
						alert("해당 ID는 없는 사용자 입니다.");
						return;
					}
				},
				error : function(request, status, error){
					console.log(error);
				}
			})
		}
		
		// 입력된 비밀번호 정보와 서버에 있는 비밀번호가 일치하는지 확인
		function isEqualsPassWord(sendData, userInfo){
			console.log("sendData.userPw : "+sendData.userPw);
			console.log("userInfo.userPw : "+userInfo.userPw);
			if(sendData.userPw == userInfo.userPw){
				return true;
			}else{
				return false;
			}
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
	<div id="loginDiv">
		<label>ID</label> : <input id="inputUserId" name="inputUserId" type="text"/><br>
		<label>PW</label> : <input id="inputUserPw" name="inputUserPw" type="password"/><br>
		<button id="loginBtn">LOGIN</button>
	</div>
</body>
</html>