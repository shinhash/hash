<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	   	#resetPassDiv{
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
	   	.resetPass{
	   		width: 280px;
	   		height: 25px;
	   		border-radius: 5px;
	   	}
	   	#resetPassBtn{
	   		margin-top: 10px;
	   		width: 285px;
	   		height: 35px;
	   		background-color: green;
	   		color: white;
	   		border-radius: 5px;
	   		font-size: 15px;
	   		font-weight: bold;
	   	}
	   	#resetPassBtn:hover{
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
			
			$("#resetPassBtn").on("click", function(){
				
				let formInfo = new FormData();
				formInfo.append("inputUserId", inputUserId = $("#inputUserId").val());
				formInfo.append("inputUserEmail", $("#inputUserEmail").val());
				
				$.ajax({
					type		: "POST",
					url			: "/sign/resetPwProcess",
					data		: formInfo,
					async		: false,
					contentType	: false,
					processData	: false,
					success : function(result){
						if(result.errorMsg == ""){
							
						}else{
							alert(result.errorMsg);
						}
					},
					error : function(request, status, error){
						console.log(error);
						alert("비밀번호 초기화 중 오류가 발생했습니다.");
					}
				});
			});
			
		});
	</script>
</head>
<body>
	<div id="signInDiv">
		<a id="homeLogo" onclick="goHome()">
			<img id="bottomLogo" alt="홈페이지 아이콘" src="${path}/resources/images/logo/irondrum-logo_icon.jpg">
		</a>
		<h2>Reset Password in to Metronome</h2>
		<form id="resetPassForm">
			<div id="resetPassDiv">
				<div>
					<label for="inputUserId" class="inputLabel">ID</label>
					<br>
					<input id="inputUserId" name="inputUserId" type="text" class="resetPass" required/>
				</div>
				<div>
					<label for="inputUserEmail" class="inputLabel">Email</label>
					<br>
					<input id="inputUserEmail" name="inputUserEmail" type="email" class="resetPass" required/>
				</div>
				<input id="resetPassBtn" type="button" value="Reset Password" />
			</div>
		</form>
	</div>
</body>
</html>