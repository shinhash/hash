<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<style type="text/css">

	/**
	게시글 정보부분 style
	*/
	#boardPostTable{		
		margin: auto;
		width: 90%;
		border-top: 2px solid rgb(44, 44, 44);
		border-bottom: 2px solid rgb(44, 44, 44);
		padding: 10px;
	}
	#bbsPostTitle{
		width: 99%;
		height: 30px;
		border: none;
		font-weight: bold;
		margin-left: 5px;
	}
	#bbsPostRegId{
		margin-left: 5px;
		float: left;
	}
	#bbsPostInfo{
		display: inline-block;
		float: right;
	}
	#buttonDivLine{
		height: 30px;
	}
	#buttonDiv{
		float: right;
		margin-right: 70px;
	}
	.postInfoBtn{
		width: 50px;
		height: 30px;
	}
	.note-editable{
		height: auto;
	}
	.note-resizebar{
		display: none;
	}
	.contents{
		overflow: hidden;
		height: auto;
	}
	
	
	/**
	게시글 삭제시 로딩처리
	*/
	#loading{ /*화면 전체를 어둡게 합니다.*/
		position: fixed;
		left:0;
		right:0;
		top:0;
		bottom:0;
		background: rgba(0,0,0,0.2); /*not in ie */
		filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000', endColorstr='#20000000');    /* ie */
	}
	#loading_img{ /*화면 전체를 어둡게 합니다.*/
		position: fixed;
		margin-top: 300px;
		margin-left: 45%;
		z-index: 1;
	}
	body.no-scroll{
		position: fixed;
	}
	
	
	/**
	게시글 수정/목록 버튼부분 style
	*/
	#postDeleteBtn{
		width: 60px;
		height: 30px;
		border: none;
		border-radius: 10px;
	}
	#postDeleteBtn:hover{
		background-color: gray;
	}
	#postModifyBtn{
		width: 60px;
		height: 30px;
		border: none;
		border-radius: 10px;
	}
	#postModifyBtn:hover{
		background-color: gray;
	}
	#postListBtn{
		width: 60px;
		height: 30px;
		border: none;
		border-radius: 10px;
	}
	#postListBtn:hover{
		background-color: gray;
	}
	
	
	/**
	게시글 정보 첨부파일부분 style
	*/
	#filesUploadDiv{
		width: 98%;
		padding-top: 5px;
		padding-bottom: 5px;
		padding-left: 5px;
	}
	
	
	/**
	댓글 리스트부분 style
	*/
	#repleArea{
		width: 90%;
		margin: auto;
	}
	#repleAreaHead{
		height: 30px;
		padding-top: 10px;
	}
	#repleAreaHead span{
		font-size: 20px;
		padding-left: 30px;
	}
	.repleWriter,.repleContent{
		padding: 5px;
	}
	.repleWriter{
		font-size: 12px;
		color: gray;
		height: 30px;
	}
	.repleContent{
		padding-top: 12px;
		padding-bottom: 10px;
		min-height: 30px;
		font-size: 12px;
	}
	.repleLine{
		border: 2px solid rgb(44, 44, 44);
	}
	.repleInfoBody{
		margin: auto;
		width: 95%;
		border: 1px solid gray;
		margin-top: 10px;
		font-size: 15px;
		border-radius: 5px;
	}
	.repleInfo{
		width: 100%;
	}
	.repleDelSpan{
		float: right;
	}
	.repleDelBtn{
		width: 65px;
		height: 30px;
		border: none;
		border-radius: 10px;
	}
	.repleDelBtn:hover{
		background-color: gray;
	}


	/**
	댓글 작성부분 style
	*/
	#bbsRepleInfo{
		width: 95%;
		height: 160px;
		margin: auto;
		border: 1px solid gray;
		font-size: 15px;
		padding-top: 5px;
		border-radius: 10px;
	}
	#bbsRepleWriter{
		width: 98%;
		height: 20px;
		margin: auto;
	}
	#bbsRepleContent{
		width: 98%;
		height: 80px;
		margin: 5px;
		font-size: 12px;
		padding: 5px;
		resize: none;
		border: none;
	}
	.repleWrtieLine{
		border: 1px solid gray;
	}
	
	
	/**
	댓글 작성 버튼부분 style
	*/
	#repleBtn{
		float: right;
		width: 60px;
		height: 30px;
		border: none;
		margin-right: 10px;
		border-radius: 10px;
	}
	#repleBtn:hover {
		background-color: gray;
	}
	
</style>
<script type="text/javascript">

	var loadingDiv = $('<div id="loading" class="loading"></div><img id="loading_img" alt="loading" src="${path}/resources/images/loading/loading.gif" />').appendTo(document.body).hide();
	
	$(document).ready(function (){
		// summernote setting and view
		$("#summernote").summernote({
			minHeight: 500,		// 최소 높이
			maxHeight: null,	// 최대 높이
			focus: true,		// 에디터 로딩후 포커스를 맞출지 여부
			lang: "ko-KR",		// 한글 설정
			disableDragAndDrop: true,		// Drag and Drop disable
			toolbar: []
		});
		// 서머노트 쓰기 비활성화
		$("#summernote").summernote('disable');
		
		
		// 게시글 삭제
		$("#postDeleteBtn").on("click", function(){
			
			if(!confirm("해당 게시글을 삭제하시겠습니까?")) return;
			
			let form = document.createElement("form");
			
			let bbsCatalId = document.createElement("input");
			bbsCatalId.setAttribute("name", "bbsCatalId");
			bbsCatalId.setAttribute("type", "hidden");
			bbsCatalId.setAttribute("value", $("#boardPostTable").attr("bbs-catal-id"));
			
			let bbsPostId = document.createElement("input");
			bbsPostId.setAttribute("name", "bbsPostId");
			bbsPostId.setAttribute("type", "hidden");
			bbsPostId.setAttribute("value", $("#boardPostTable").attr("bbs-post-id"));
			
			form.appendChild(bbsCatalId);
			form.appendChild(bbsPostId);
			
			let formInfo = new FormData(form);
			$.ajax({
				type		: "POST",
				url			: "/board/deletePostInfo",
				data		: formInfo,
				contentType	: false,
				processData	: false,
				async		: true,
				beforeSend	: function(xhr){
					document.body.classList.add("no-scroll");
					loadingDiv.show();
				},
				complete : function(){
					document.body.classList.remove("no-scroll");
					loadingDiv.hide();
			    },
				success : function(result){
					alert("게시글 삭제완료");
					goPostList($("#boardPostTable").attr("bbs-catal-id"));
				},
				error : function(request, status, error){
					console.log(error);
					alert("게시글 삭제실패");
				}
			});
		});
		
		
		// 게시글 수정페이지
		$("#postModifyBtn").on("click", function(){
			let formInfo = document.createElement("form");
			
			let bbsCatalId = document.createElement("input");
			bbsCatalId.setAttribute("name", "bbsCatalId");
			bbsCatalId.setAttribute("type", "hidden");
			bbsCatalId.setAttribute("value", $("#boardPostTable").attr("bbs-catal-id"));
			
			let bbsPostId = document.createElement("input");
			bbsPostId.setAttribute("name", "bbsPostId");
			bbsPostId.setAttribute("type", "hidden");
			bbsPostId.setAttribute("value", $("#boardPostTable").attr("bbs-post-id"));
			
			formInfo.appendChild(bbsCatalId);
			formInfo.appendChild(bbsPostId);
							
			formInfo.setAttribute("method","post");
			formInfo.setAttribute("action","/board/postModifyView");
			document.body.appendChild(formInfo);
			formInfo.submit();
		});
		
		
		// 댓글 저장
		$("#repleBtn").on("click", function(){
			let repleContent = $("#bbsRepleContent").val();
			if(repleContent == "") {
				alert("댓글내용을 작성해주세요.");
				return;
			}
			
			// 댓글 줄바꿈 처리
			let repleContTemp = repleContent.replace(/(?:\r\n|\r|\n)/g, '<br>');
			$("#bbsRepleContent").val(repleContTemp);
			
			let form = $("#repleForm")[0];
			let formInfo = new FormData(form);
			$.ajax({
				type		: "POST",
				url			: "/board/insertPostReple",
				data		: formInfo,
				async		: false,
				contentType	: false,
				processData	: false,
				success : function(result){
					alert("댓글 저장완료");
					bbsRepleListView(result);
				},
				error : function(request, status, error){
					console.log(error);
					alert("댓글 저장실패");
				}
			});
		});
		
		
		// 댓글 삭제
		$(document).on("click", ".repleDelBtn", function(){
			
			if(!confirm("해당 댓글을 삭제하시겠습니까?")) return;
			
			let form = document.createElement("form");
			
			let bbsPostId = document.createElement("input");
			bbsPostId.setAttribute("name", "bbsPostId");
			bbsPostId.setAttribute("type", "hidden");
			bbsPostId.setAttribute("value", $("#boardPostTable").attr("bbs-post-id"));
			
			let bbsRepleId = document.createElement("input");
			bbsRepleId.setAttribute("name", "bbsRepleId");
			bbsRepleId.setAttribute("type", "hidden");
			bbsRepleId.setAttribute("value", $(this).parent().parent().parent().attr("bbs-reple-id"));
			
			form.appendChild(bbsPostId);
			form.appendChild(bbsRepleId);
			
// 			console.log("bbsPostId : "+bbsPostId.value);
// 			console.log("bbsRepleId : "+bbsRepleId.value);
			
			let formInfo = new FormData(form);
			$.ajax({
				type		: "POST",
				url			: "/board/deletePostReple",
				data		: formInfo,
				async		: false,
				contentType	: false,
				processData	: false,
				success : function(result){
					alert("댓글 삭제성공");
					bbsRepleListView(result);
				},
				error : function(request, status, error){
					console.log(error);
					alert("댓글 삭제실패");
				}
			});
		});
		
		
		
		// 댓글리스트 재조회
		function bbsRepleListView(result){
			$("#repleAreaBody").empty();
			$("#bbsRepleContent").val("");
			$(".repleCnt").text(result.postRepleList.length);
			let repleList = result.postRepleList;
			
			repleList.forEach(function(bbsRepleInfo){
// 				console.log(bbsRepleInfo);
				
				// repleAreaBody
				let repleInfoBody = document.createElement("div");
				repleInfoBody.setAttribute("class", "repleInfoBody");
				
				// repleInfo
				let repleInfo = document.createElement("div");
				repleInfo.setAttribute("class", "repleInfo");
				repleInfo.setAttribute("bbs-reple-id", bbsRepleInfo.bbsRepleId);
				
				// repleWriter
				let repleWriter = document.createElement("div");
				repleWriter.setAttribute("class", "repleWriter");
				
				// repleRegId
				let repleRegId = document.createElement("span");
				repleRegId.setAttribute("class", "repleRegId");
				repleRegId.innerText = bbsRepleInfo.bbsRepleRegId;
				
				// repleDelSpan
				let repleDelSpan = document.createElement("span");
				repleDelSpan.setAttribute("class", "repleDelSpan");
				
				// repleDelBtn
				let repleDelBtn = document.createElement("input");
				repleDelBtn.setAttribute("type", "button");
				repleDelBtn.setAttribute("class", "repleDelBtn");
				repleDelBtn.setAttribute("value", "댓글삭제");
				
				// repleWrtieLine
				let repleWrtieLine = document.createElement("div");
				repleWrtieLine.setAttribute("class", "repleWrtieLine");
				
				// repleContent
				let repleContent = document.createElement("div");
				repleContent.setAttribute("class", "repleContent");
				repleContent.innerText = bbsRepleInfo.bbsRepleContent.replaceAll("<br>", "\r\n");
				

				
				// append (repleDelBtn) to repleDelSpan
				if(bbsRepleInfo.bbsRepleRegId == $("#bbsRepleRegId").val()){
					repleDelSpan.appendChild(repleDelBtn);					
				}
				
				// append (repleRegId, repleDelSpan) to repleWriter
				repleWriter.appendChild(repleRegId);
				repleWriter.appendChild(repleDelSpan);
				
				// append (repleWriter, repleWrtieLine, repleContent) to repleInfo
				repleInfo.appendChild(repleWriter);
				repleInfo.appendChild(repleWrtieLine);
				repleInfo.appendChild(repleContent);
				
				// append (repleInfo) to repleInfoBody
				repleInfoBody.appendChild(repleInfo);
				
				// append (repleInfoBody) to repleListForm
				document.getElementById("repleAreaBody").appendChild(repleInfoBody);
			});
		}
		
	});
</script>
<div id="root" class="root">
	<div></div>
	<div id="page-body">
		<br>
		<div class="body-contents">
			<div class="inner">
				<div class="contents">
					<br><br>
					<table id="boardPostTable" bbs-catal-id="${postInfo.bbsCatalId}" bbs-post-id="${postInfo.bbsPostId}">
						<tr>
							<td>
								<div id="bbsPostTitle">${postInfo.bbsPostTitle}</div> 
							</td>
						</tr>
						<tr>
							<td>
								<div>
									<div id="bbsPostRegId">${postInfo.bbsPostRegId}</div>
									<div id="bbsPostInfo">
										<span>조회수</span>
										<span>${postViewCnt}</span>
										<span>|</span>
										<span>댓글</span>
										<span class="repleCnt">${repleList.size()}</span>
										<span>|</span>
										<span>작성일</span>
										<span>
											<fmt:parseDate var="fmtInfo" value="${postInfo.bbsPostModDate}" pattern="yyyyMMddHHmmss"/>
											<fmt:formatDate value="${fmtInfo}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</span>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<textarea id="summernote" name="bbsPostContent" >${postInfo.bbsPostContent}</textarea>
							</td>
						</tr>
						<tr>
							<td>
								<div id="filesDiv">
									<c:choose>
										<c:when test="${attachList ne null and attachList.size() > 0}">
											<c:forEach var="attachInfo" items="${attachList}">
												<div class="files" attach-id="${attachInfo.bbsAttachId}">
													${attachInfo.bbsAttachOriginNm}
												</div>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<div>첨부파일없음</div>
										</c:otherwise>
									</c:choose>
								</div>
							</td>
						</tr>
					</table>
					<br>
					<div id="buttonDivLine">
						<div id="buttonDiv">
							<c:if test="${loginSession.userId ne null and loginSession.userId eq postInfo.bbsPostRegId}">
								<input class="postInfoBtn" type="button" id="postDeleteBtn" value="삭제" />
								<input class="postInfoBtn" type="button" id="postModifyBtn" value="수정" />
							</c:if>
							<input class="postInfoBtn" type="button" id="postListBtn" value="목록" onclick="goPostList('${postInfo.bbsCatalId}')" />
						</div>
					</div>
					<!-- reple area -->
					<div id="repleArea">
						<div id="repleAreaHead">
							<span>댓글</span>
						</div>
						<div class="repleLine"></div>
						<!-- 댓글 리스트 -->
						<div id="repleAreaBody">
							<c:choose>
								<c:when test="${repleList ne null and repleList.size() > 0}">
									<c:forEach var="repleInfo" items="${repleList}">
										<div class="repleInfoBody">
											<div class="repleInfo" bbs-reple-id="${repleInfo.bbsRepleId}">
												<div class="repleWriter">
													<span class="repleRegId">${repleInfo.bbsRepleRegId}</span>
													<c:if test="${loginSession.userId eq repleInfo.bbsRepleRegId}">
														<span class="repleDelSpan"><input type="button" class="repleDelBtn" value="댓글삭제" /></span>
													</c:if>
												</div>
												<div class="repleWrtieLine"></div>
												<div class="repleContent">${repleInfo.bbsRepleContent}</div>
											</div>
										</div>
									</c:forEach>
								</c:when>
							</c:choose>
						</div>
						<br><br>
						<c:if test="${loginSession.userId ne null}">
							<form id="repleForm">
								<div id="bbsRepleInfo">
									<input type="hidden" name="bbsCatalId" value="${postInfo.bbsCatalId}" />
									<input id="bbsPostId" type="hidden" name="bbsPostId" value="${postInfo.bbsPostId}" />
									<input type="hidden" id="bbsRepleRegId" name="bbsRepleRegId" value="${loginSession.userId}" />
									<div id="bbsRepleWriter">${loginSession.userNm}</div>
									<div class="repleWrtieLine"></div>
									<textarea id="bbsRepleContent" name="bbsRepleContent" placeholder="댓글내용은 2000자 이하로 작성해주세요."></textarea>
									<input type="button" id="repleBtn" value="등록" />
								</div>
							</form>
						</c:if>
					</div>
				</div>
				<br><br>
			</div>
		</div>
	</div>
</div>