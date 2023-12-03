<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#signUpDiv{
		width: 500px;
		margin: 0 auto;
		text-align: center;
		align-content: center;
	}
	#signUpBoxDiv{
		background-color: lightgray;
   		width: 320px;
   		height: 290px;
   		margin: 0 auto;
   		border-radius: 5px;
   		padding-top: 10px;
	}
	.inputLabel{
   		font-weight: lighter;
   		float: left;
   		padding-left: 5%;
   		padding-bottom: 5px;
   	}
	.signUpInput{
   		width: 280px;
   		height: 25px;
   		border-radius: 5px;
   	}
	#signUpBtn{
		margin-top: 10px;
   		width: 285px;
   		height: 35px;
   		background-color: green;
   		color: white;
   		border-radius: 5px;
   		font-size: 15px;
   		font-weight: bold;
	}
	#bottomLogo{
   		width: 350px;
   	}
   	#signUpIdChkBtn{
   		float: right;
   		margin-right: 5%;
   		margin-bottom: 5px;
   	}
</style>
<script type="text/javascript" charset="UTF-8">
	<%@ include file="/js/commonJS.js" %>
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> 
<script type="text/javascript">
	$(document).ready(function (){
		
		$("#inputUserId").focus();
		var idCheckRst = false;
		
		$("#signUpIdChkBtn").on("click", function(){
			signUpIdChk();
		});
		
		// ajax를 통해 입력된 ID가 이미 등록된 정보인지 확인
		// 1차 확인 후 서버 insert시 2차 확인
		function signUpIdChk(){
			var inputId = $("#inputUserId").val();
			if(inputId == ''){
				alert("id 정보를 입력해주세요.");
				return;
			}
			$.ajax({
				type	: "POST",
				url		: "/sign/signUpIdChk",
				data	: {"inputId" : inputId},
				success : function(result){
					
					if(result.isAleadyUsed){
						idCheckRst = false;
						alert("이미 사용중인 ID 입니다.");
					}else{
						idCheckRst = true;
						alert("사용가능한 ID 입니다.");
					}
				},
				error : function(request, status, error){
					console.log(error);
				}
			})
		}
		
		$("#signUpBtn").on("click", function(){
			signUpConfirm();
		});
		
		// 회원가입 전 체크
		function signUpConfirm(){
			if(!idCheckRst){
				idCheckRst = false;
				alert("ID 확인을 진행해주세요.");
				return;
			}
			// id, pw 입력이 완료되었는지 확인
			let tagCnt = $("#signUpUserInfoForm").find(".signUpInput").length;
	 		for(let i=0; i<tagCnt; i++){
				let getElement = $("#signUpUserInfoForm").find(".signUpInput")[i].id;
				if(isNull($("#"+getElement).val())){
					alert("미작성된 부분을 입력해주세요.");
					return;
				}
	 		}
	 		if($("#inputUserPw").val() != $("#inputUserPwRe").val){
	 			alert("비밀번호를 재확인 해주세요.");
				return;
	 		}
	 		// 회원가입 진행
	 		signUpProcess();
		}
		
		// 회원가입
		function signUpProcess(){
			let formInfo = document.getElementById("signUpUserInfoForm");
			formInfo.setAttribute("method", "post");
			formInfo.setAttribute("action", "/sign/signUpProcess");
			formInfo.submit();
		}
		
	});
</script>
</head>
<body>
	<div id="signUpDiv">
		<a id="homeLogo" onclick="goHome()">
			<img id="bottomLogo" alt="홈페이지 아이콘" src="${path}/resources/images/logo/irondrum-logo_icon.jpg">
		</a>
		<h2>Sign up to Iron</h2>
		<div id="signUpBoxDiv">
			<form id="signUpUserInfoForm">
				<div>
					<label for="inputUserId" class="inputLabel">Email or ID</label>
					<input id="signUpIdChkBtn" type="button" value="ID확인"/>
					<br>
					<input id="inputUserId" class="signUpInput" name="inputUserId" type="text" />
					
				</div>
				<div>
					<label for="inputUserPw" class="inputLabel">Password</label>
					<br>
					<input id="inputUserPw" class="signUpInput" name="inputUserPw" type="password"/>
				</div>
				<div>
					<label for="inputUserPw" class="inputLabel">Password Check</label>
					<br>
					<input id="inputUserPwRe" class="signUpInput" name="inputUserPwRe" type="password"/>
				</div>
				<div>
					<label for="inputUserNm" class="inputLabel">Name</label>
					<br>
					<input id="inputUserNm" class="signUpInput" name="inputUserNm" type="text"/>
				</div>
<!-- 				<div> -->
<!-- 					<label for="inputUserBirth" class="inputLabel">Birth</label> -->
<!-- 					<br> -->
<!-- 					<input id="inputUserBirth" class="signUpInput" name="inputUserBirth" type="text"/> -->
<!-- 				</div> -->
<!-- 				<div> -->
<!-- 					<label for="inputUserMail" class="inputLabel">Mail</label> -->
<!-- 					<br> -->
<!-- 					<input id="inputUserMail" class="signUpInput" name="inputUserMail" type="text"/> -->
<!-- 				</div> -->
<!-- 				<div> -->
<!-- 					<label for="inputUserPhone" class="inputLabel">Phone</label> -->
<!-- 					<br> -->
<!-- 					<input id="inputUserPhone" class="signUpInput" name="inputUserPhone" type="text"/> -->
<!-- 				</div> -->
<!-- 				<div> -->
<!-- 					<label for="inputUserZipcode" class="inputLabel">Zipcode</label> -->
<!-- 					<br> -->
<!-- 					<input id="inputUserZipcode" class="signUpInput" name="inputUserZipcode" type="text"/> -->
<!-- 				</div> -->
<!-- 				<div> -->
<!-- 					<label for="inputUserAddr1" class="inputLabel">Address</label> -->
<!-- 					<br> -->
<!-- 					<input id="inputUserAddr1" class="signUpInput" name="inputUserAddr1" type="text"/> -->
<!-- 				</div> -->
<!-- 				<div> -->
<!-- 					<label for="inputUserAddr2" class="inputLabel">Address Detail</label> -->
<!-- 					<br> -->
<!-- 					<input id="inputUserAddr2" class="signUpInput" name="inputUserAddr2" type="text"/> -->
<!-- 				</div> -->
			</form>
			<div id="signUpBtnDiv">
				<input type="button" id="signUpBtn" value="Sign up" />
			</div>
		</div>
	</div>
</body>
</html>