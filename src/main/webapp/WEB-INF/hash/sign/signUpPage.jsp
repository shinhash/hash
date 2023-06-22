<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#singUpDiv{
		width: 500px;
		margin: 0 auto;
	}
	#signUpHead h2{
		width : 300px;
		text-align: center;
	}
	.signUpTag{
		width: 300px;
		padding: 10px;
	}
	#singUpTable{
		width: 300px;
	}
	#singUpTable input{
		width : 90%;
	}
	#SingUpBtn{
		width: 300px;
		height: 50px;
	}
	#homeLogo{
		text-align: center;
	}
	#bottomLogo{
   		width: 300px;
   	}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> 
<script type="text/javascript">
	$(function(){
		
		var idCheckRst = false;
		
		$("#SingUpIdChkBtn").on("click", function(){
			singUpIdChk();
		});
		
		$("#SingUpBtn").on("click", function(){
			singUpConfirm();
		});
		
		function singUpConfirm(){
			
			if(!idCheckRst){
				alert("ID 확인을 진행해주세요.");
				return;
			}
			
			// id, pw 입력이 완료되었는지 확인
	 		var inputId 		= $("#inputUserId").val();
	 		var inputPw 		= $("#inputUserPw").val();
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
		function singUpIdChk(){
			var inputId = $("#inputUserId").val();
			$.ajax({
				type	: "POST",
				url		: "/sign/singUpIdChk",
				data	: inputId,
				success : function(result){
					var idCheckRst = false;
					
					if(result.isUsedRst){
						idCheckRst = true;
						alert("사용가능한 ID 입니다.");
					}else{
						alert("이미 사용중인 ID 입니다.");
					}
					
					return idCheckRst;
				},
				error : function(request, status, error){
					console.log(error);
				}
			})
		}
		
		// 입력된 회원정보를 DB에 저장
		function singUpProcess(){
			
			idCheckRst = false;
			let formInfo = document.getElementById("signUpUserInfoForm");
			formInfo.setAttribute("method", "post");
			formInfo.setAttribute("action", "/sign/singUpProcess");
			formInfo.submit();
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

</script>
</head>
<body>
	<div id="singUpDiv">
		<a id="homeLogo" onclick="goHome()">
			<img id="bottomLogo" alt="홈페이지 아이콘" src="${path}/resources/images/logo/irondrum-logo_icon.jpg">
		</a>
		<div id="signUpHead" class="signUpTag">
			<h2>SIGN UP</h2>
		</div>
		<form id="signUpUserInfoForm">
			<div id="singUpTableDiv" class="signUpTag">
				<table id="singUpTable">
					<tr>
						<td>ID</td>
						<td> : <input id="inputUserId" name="inputUserId" type="text"/>
							<button id="SingUpIdChkBtn">ID확인</button>
						</td>
					<tr>
					<tr>
						<td>PW</td>
						<td> : <input id="inputUserPw" name="inputUserPw" type="password"/></td>
					<tr>
					<tr>
						<td>PW RE</td>
						<td> : <input id="inputUserPw" name="inputUserPwRe" type="password"/></td>
					<tr>
					<tr>
						<td>이름</td>
						<td> : <input id="inputUserNm" name="inputUserNm" type="text"/></td>
					<tr>
					<tr>
						<td>생년월일</td>
						<td> : <input id="inputUserBirth" name="inputUserBirth" type="text"/></td>
					<tr>
					<tr>
						<td>Mail</td>
						<td> : <input id="inputUserMail" name="inputUserMail" type="text"/></td>
					<tr>
					<tr>
						<td>전화번호</td>
						<td> : <input id="inputUserPhone" name="inputUserPhone" type="text"/></td>
					<tr>
					<tr>
						<td>주소</td>
						<td> : <input id="inputUserAddr1" name="inputUserAddr1" type="text"/></td>
					<tr>
					<tr>
						<td>상세주소</td>
						<td> : <input id="inputUserAddr2" name="inputUserAddr2" type="text"/></td>
					<tr>
					<tr>
						<td>우편번호</td>
						<td> : <input id="inputUserZipcode" name="inputUserZipcode" type="text"/></td>
					<tr>
				</table>
			</div>
		</form>
		<div id="signUpBtnDiv" class="signUpTag">
			<button id="SingUpBtn">회원가입</button>
		</div>
	</div>
</body>
</html>