<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#signUpDiv{
		width: 500px;
		margin: 0 auto;
	}
	#signUpHead h2{
		width : 300px;
		text-align: center;
	}
	.signUpTag{
		width: 350px;
		padding: 10px;
	}
	#signUpTable{
		width: 350px;
	}
	#signUpTable .inputTxt{
		width : 90%;
	}
	#homeLogo{
		text-align: center;
	}
	#signUpBtn{
		width: 350px;
		height: 50px;
	}
	#bottomLogo{
   		width: 350px;
   	}
   	#idCheckTd{
   		float: left;
   	}
   	#idCheckTd #inputUserId{
	   	width: 180px;
   	}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> 
<script type="text/javascript">
	$(function(){
		
		var idCheckRst = false;
		
		$("#signUpIdChkBtn").on("click", function(){
			signUpIdChk();
		});
		
		$("#signUpBtn").on("click", function(){
			signUpConfirm();
		});
		
		function signUpConfirm(){
			
			if(!idCheckRst){
				alert("ID 확인을 진행해주세요.");
				return;
			}
			
			// id, pw 입력이 완료되었는지 확인
	 		var inputId 		= $("#inputUserId").val();
	 		var inputPw 		= $("#inputUserPw").val();
	 		var inputPwRe 		= $("#inputUserPwRe").val();
	 		var inputNm			= $("#inputUserNm").val();
	 		var inputBirth 		= $("#inputUserBirth").val();
	 		var inputMail 		= $("#inputUserMail").val();
	 		var inputPhone 		= $("#inputUserPhone").val();
	 		var inputAddr1 		= $("#inputUserAddr1").val();
	 		var inputAddr2 		= $("#inputUserAddr2").val();
	 		var inputZipcode 	= $("#inputUserZipcode").val();
	 		
	 		var singUpData = {
 				userId		: inputId,
 				userPw		: inputPw,
 				userNm		: inputNm,
 				birth		: inputBirth,
 				mail		: inputMail,
 				phone		: inputPhone,
 				addr		: inputAddr1,
 				addrDetail	: inputAddr2,
 				zipCode		: inputZipcode
	 		};
	 		
	 		
	 		if(isNull(inputId)) return alert("ID를 입력해주세요.");
	 		if(isNull(inputPw)) return alert("PW를 입력해주세요.");
	 		if(isNull(inputPwRe)) return alert("PW를 재입력해주세요.");
	 		if(isNull(inputNm)) return alert("이름을 입력해주세요.");
	 		if(isNull(inputBirth)) return alert("생년월일을 입력해주세요.");
	 		if(isNull(inputMail)) return alert("이메일을 입력해주세요.");
	 		if(isNull(inputPhone)) return alert("전화번호를 입력해주세요.");
	 		if(isNull(inputAddr1)) return alert("주소를 입력해주세요.");
	 		if(isNull(inputAddr2)) return alert("상세주소를 입력해주세요.");
	 		if(isNull(inputZipcode)) return alert("우편번호를 입력해주세요.");
	 		
	 		// ajax를 통해 입력된 ID가 이미 등록된 정보인지 확인
	 		var isUsedIdCheck = singUpIdChk();
	 		if(isUsedIdCheck){
	 			singUpProcess(singUpData);
	 		}
		}
		
		// ajax를 통해 입력된 ID가 이미 등록된 정보인지 확인
		function signUpIdChk(){
			var inputId = $("#inputUserId").val();
			if(inputId == ''){
				alert("id 정보를 입력해주세요.");
				return;
			}
			$.ajax({
				type	: "POST",
				url		: "/sign/singUpIdChk",
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
	})
	
	// null check
	function isNull(inputTemp){
		var isNullRst = false;
		if(inputTemp == undefined || inputTemp == "" || inputTemp == null){
			isNullRst = true;
		}
		return isNullRst;
	}
	
	// 홈페이지 메인페이지
	function goHome(){
		let formInfo = document.createElement("form");
		formInfo.setAttribute("id", "pageControllDiv");
		formInfo.setAttribute("method", "post");
		formInfo.setAttribute("action", "/main/mainpage");
		document.body.appendChild(formInfo);
		formInfo.submit();
	}
	
	// 입력된 회원정보를 DB에 저장
	function signUpProcess(){
		// id, pw 체크 및 저장 후 닉네임 등록 페이지로 이동(예정)
		idCheckRst = false;
		let formInfo = document.getElementById("signUpUserInfoForm");
		formInfo.setAttribute("method", "post");
		formInfo.setAttribute("action", "/sign/singUpProcess");
		formInfo.submit();
	}

</script>
</head>
<body>
	<div id="signUpDiv">
		<a id="homeLogo" onclick="goHome()">
			<img id="bottomLogo" alt="홈페이지 아이콘" src="${path}/resources/images/logo/irondrum-logo_icon.jpg">
		</a>
		<div id="signUpHead" class="signUpTag">
			<h2>SIGN UP</h2>
		</div>
		<form id="signUpUserInfoForm">
			<div id="signUpTableDiv" class="signUpTag">
				<table id="signUpTable">
					<tr>
						<td>ID</td>
						<td id="idCheckTd"> : 
							<input id="inputUserId" class="inputTxt" name="inputUserId" type="text" />
							<input id="signUpIdChkBtn" type="button" value="ID확인"/>
						</td>
					<tr>
					<tr>
						<td>PW</td>
						<td> : <input id="inputUserPw" class="inputTxt" name="inputUserPw" type="password"/></td>
					<tr>
					<tr>
						<td>PW RE</td>
						<td> : <input id="inputUserPwRe" class="inputTxt" name="inputUserPwRe" type="password"/></td>
					<tr>
					<tr>
						<td>이름</td>
						<td> : <input id="inputUserNm" class="inputTxt" name="inputUserNm" type="text"/></td>
					<tr>
					<tr>
						<td>생년월일</td>
						<td> : <input id="inputUserBirth" class="inputTxt" name="inputUserBirth" type="text"/></td>
					<tr>
					<tr>
						<td>Mail</td>
						<td> : <input id="inputUserMail" class="inputTxt" name="inputUserMail" type="text"/></td>
					<tr>
					<tr>
						<td>전화번호</td>
						<td> : <input id="inputUserPhone" class="inputTxt" name="inputUserPhone" type="text"/></td>
					<tr>
					<tr>
						<td>주소</td>
						<td> : <input id="inputUserAddr1" class="inputTxt" name="inputUserAddr1" type="text"/></td>
					<tr>
					<tr>
						<td>상세주소</td>
						<td> : <input id="inputUserAddr2" class="inputTxt" name="inputUserAddr2" type="text"/></td>
					<tr>
					<tr>
						<td>우편번호</td>
						<td> : <input id="inputUserZipcode" class="inputTxt" name="inputUserZipcode" type="text"/></td>
					<tr>
				</table>
			</div>
		</form>
		<div id="signUpBtnDiv" class="signUpTag">
			<input type="button" id="signUpBtn" value="회원가입" />
		</div>
	</div>
</body>
</html>