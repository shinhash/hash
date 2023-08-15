<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
	    <meta name="description" content="Male_Fashion Template">
	    <meta name="keywords" content="Male_Fashion, unica, creative, html">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <meta http-equiv="X-UA-Compatible" content="ie=edge">
	    <title>IRON DRUM</title>
	    <style type="text/css">
	    	#postRegistTable{
	    		margin: auto;
	    		width: 90%;
	    	}
	    	.buttonDiv{
	    		float: right;
				margin-right: 60px;
	    	}
	    	.postInfoBtn{
	    		width: 50px;
	    		height: 30px;
	    	}
	    	#bbsPostTitle{
	    		width:98%;
	    		font-weight: bold;
	    	}
	    </style>
	    <script>
	    	$(document).ready(function (){
				// summernote setting and view
				$("#summernote").summernote({
					  height: 300,                 // 에디터 높이
					  minHeight: null,             // 최소 높이
					  maxHeight: null,             // 최대 높이
					  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
					  lang: "ko-KR"					// 한글 설정
					  /*
					  placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
					  */
				});
				// 서머노트 쓰기 활성화
				$("#summernote").summernote('enable');
				
				// 게시글 저장
				// ajax로 변경
				$("#postRegist").on("click", function(){
					// 게시글 작성체크
					if(!fn_isWriteChk()) return;
					/*
					일반 form 전송시 사용하는 enctype='multipart/form-data'
					를 ajax를 이용하여 전송하는 경우
					해당 form 정보를 FormData에 삽입 후 
					contentType, processData 값을 false 로 설정한다.
					 - contentType : false 로 선언 시 content-type 헤더가 multipart/form-data로 전송되게 함
					 - processData : false로 선언 시 formData를 string으로 변환하지 않음
					 - serialize : form 전송시 사용 (type=file 요소는 미포함)_직렬화
					 - FormData : form 전송시 사용 (type=file 요소 포함)
					*/
					let form = $("#postRegistForm")[0];
					let formInfo = new FormData(form);
					$.ajax({
						type		: "POST",
						enctype		: "multipart/form-data",
						url			: "/board/postInfoRegist",
						data		: formInfo,
						contentType	: false,
						processData	: false,
						success : function(result){
							alert("게시글 저장완료");
							let bbsPostIdVal = result.bbsPostId;
							postInfoView(bbsPostIdVal);
						},
						error : function(request, status, error){
							console.log(error);
							alert("게시글 저장실패");
						}
					})
				});
				
				// 게시글 조회
				function postInfoView(bbsPostIdVal){
					if(bbsPostIdVal != null && bbsPostIdVal != ""){
						let formPostInfo = document.createElement("form");
						
						let bbsPostId = document.createElement("input");
						bbsPostId.setAttribute("name", "bbsPostId");
						bbsPostId.setAttribute("type", "hidden");
						bbsPostId.setAttribute("value", bbsPostIdVal);
						formPostInfo.appendChild(bbsPostId);
						
						formPostInfo.setAttribute("method","post");
						formPostInfo.setAttribute("action","/board/postInfoView");
						document.body.appendChild(formPostInfo);
						formPostInfo.submit();
					}
				}
				
				// 게시글 작성체크
				function fn_isWriteChk(){
					let isBlank = true;
		    		let bbsPostTitleVal = $("#bbsPostTitle").val();
		    		let summernoteVal = $("#summernote").val();
		    		
		    		if(bbsPostTitleVal == ""){
		    			isBlank = false;
		    			alert("제목을 작성해주세요.");
		    		}
		    		if(summernoteVal == ""){
		    			isBlank = false;
		    			alert("내용을 작성해주세요.");
		    		}
		    		return isBlank;
		    	}
	    	});
	    </script>
	    
	</head>
	<body>
		<div id="root" class="root">
			<div></div>
			<div id="page-body">
				<br>
				<div class="body-contents">
					<div class="inner">
						<div class="contents">
							<br><br>
							<form id="postRegistForm">
								<table id="postRegistTable" border="1">
									<tr>
										<td>제목</td>
										<td>
											<input id="bbsPostTitle" type="text" name="bbsPostTitle"/>
										</td>
									</tr>
									<tr>
										<td>내용</td>
										<td>
											<textarea id="summernote" name="bbsPostContent"></textarea>
										</td>
									</tr>
									<tr>
										<td>첨부파일</td>
										<td>
											<input type="file" name="bbsPostAttchId" />
										</td>
									</tr>
								</table>
							</form>
							<br>
							<div class="buttonDiv">
								<input class="postInfoBtn" type="button" id="postRegist" value="저장" />
								<input class="postInfoBtn" type="button" id="postList" value="목록" onclick="goPostList();" />
							</div>
						</div>
						<br><br>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>