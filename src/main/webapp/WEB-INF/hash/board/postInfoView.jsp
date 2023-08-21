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
	    	#boardPostTable{
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
	    </style>
	    <script>
	    	$(document).ready(function (){
				// summernote setting and view
				$("#summernote").summernote({
					height: 800,                 // 에디터 높이
					minHeight: 800,             // 최소 높이
					maxHeight: 800,             // 최대 높이
					focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
					lang: "ko-KR",					// 한글 설정
					placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
				});
				// 서머노트 쓰기 비활성화
				$("#summernote").summernote('disable');
								
				// 게시글 수정페이지
				$("#postModify").on("click", function(){
					let formInfo = document.createElement("form");
					
					let bbsPostId = document.createElement("input");
					bbsPostId.setAttribute("name", "bbsPostId");
					bbsPostId.setAttribute("type", "hidden");
					bbsPostId.setAttribute("value", $("#boardPostTable").attr("bbs-post-id"));
					formInfo.appendChild(bbsPostId);
									
					formInfo.setAttribute("method","post");
					formInfo.setAttribute("action","/board/postModifyView");
					document.body.appendChild(formInfo);
					formInfo.submit();
				});
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
							<table id="boardPostTable" bbs-post-id="${postInfo.bbsPostId}" border="1">
								<tr>
									<td style="font-weight: bold;">${postInfo.bbsPostTitle}</td>
								</tr>
								<tr>
									<td>
										${postInfo.bbsPostRegId}		||		
										<fmt:parseDate var="fmtInfo" value="${postInfo.bbsPostModDate}" pattern="yyyyMMddHHmmss"/>
										<fmt:formatDate value="${fmtInfo }" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
								</tr>
								<tr>
									<td>
										<textarea id="summernote" name="bbsPostContent" >${postInfo.bbsPostContent}</textarea>
									</td>
								</tr>
								<tr>
									<td>첨부파일</td>
								</tr>
							</table>
							<br><br>
							<div class="buttonDiv">
								<input class="postInfoBtn" type="button" id="postModify" value="수정" />
								<input class="postInfoBtn" type="button" id="postList" value="목록" onclick="goPostList();" />
							</div>
						</div>
						<br><br><br><br>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>