<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<style type="text/css">
	/**
	게시글 수정부분 style
	*/
	#postModifyTable{
		margin: auto;
		width: 90%;
		border-top: 1px solid rgb(44, 44, 44);
		border-bottom: 1px solid rgb(44, 44, 44);
		padding: 10px;
	}
	#bbsPostTitle{
		width: 99%;
		height: 30px;
		border: none;
		font-weight: bold;
		margin-left: 5px;
	}
	.buttonDiv{
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
	게시글 저장시 로딩처리
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
		margin: 0 auto;
		left: 0;
		right: 0;
	}
	
	
	/**
	게시글 수정 버튼부분 style
	*/
	#postModifyBtn{
		width: 60px;
		height: 35px;
		border: none;
		border-radius: 10px;
		color: white;
		font-size: 15px;
		font-weight: bold;
		background-color: #9147ff;
	}
	#postModifyBtn:hover{
		background-color: #772ce8;
	}
	#postModifyBtn:active{
		background-color: #5c16c5;
	}
	
	#postEditCancleBtn{
		width: 60px;
		height: 35px;
		border: none;
		border-radius: 10px;
		color: white;
		font-size: 15px;
		font-weight: bold;
		background-color: #FF4848;
	}
	#postEditCancleBtn:hover{
		background-color: #C90000;
	}
	#postEditCancleBtn:active{
		background-color: darkred;
	}
	
	
	/**
	첨부파일 수정부분 style
	*/
	#filesUploadDiv{
		width: 99%;
		padding-top: 5px;
		padding-bottom: 5px;
	}
	#bbsPostAttchInfo{
		display: none;
	}
	.removeAttach{
		width: 30px;
		height: 30px;
		border: none;
		border-radius: 10px;
		background-color: #FF4848;
		text-align: center;
		margin-left: 5px;
		vertical-align: middle;
	}
	.removeAttach:hover{
		background-color: #C90000;
	}
	.removeAttach:active{
		background-color: darkred;
	}
	.removeAttach span{
		vertical-align: -webkit-baseline-middle;
		color: white;
	}
	.fileDivs div{
		display: inline-block;
	}
	
	
	/**
	드래그 앤 드롭 style
	*/
	.dropBox {
		width: 100%;
		min-height: 50px;
		height: auto;
		overflow: auto;
		display: flex;
		justify-content: center;
		align-items: center;
		border-radius: 5px;
		border: 4px dashed #ddd;
		user-select: none;
		transition: 0.4s;
	}
	/**
	드롭 반응 
	*/
	.dropBox.active {
		background: #ddd;
	}
	.dropSpan{
		font-size: 12px;
		color: blue;
	}
	/** 
	드롭 박스 스타일
	*/
	.dropBox * {
		margin: 0;
		padding: 0;
		box-sizing: border-box;
		font-family: Pretendard, 'Malgun Gothic', sans-serif;
	}
	.dropBox:hover{
		background-color: #ddd;
	}
	.fileIcons{
		width: 70px;
		height: 70px;
	}
	.dropAddFiles{
		margin-left: 20px;
		margin-top: 10px;
		margin-bottom: 10px;
		display: inline-grid;
	}
	.dropBox.left-sort{
		display: -webkit-inline-box;
	}
</style>
<script type="text/javascript">

	var loadingDiv = $('<div id="loading" class="loading"></div><img id="loading_img" alt="loading" src="${path}/resources/images/loading/loading.gif" />').appendTo(document.body).hide();
	var rmBbsAttIdArr = [];
	$(document).ready(function (){				
		// summernote setting and view
		$('#summernote').summernote({
			minHeight: 500,		// 최소 높이
			maxHeight: null,	// 최대 높이
			focus: true,		// 에디터 로딩후 포커스를 맞출지 여부
			lang: "ko-KR",		// 한글 설정
			toolbar: [
					    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
					    ['color', ['forecolor','color']],
					    ['table', ['table']],
					    ['para', ['ul', 'ol', 'paragraph']],
					    ['height', ['height']],
					    ['insert',['picture','link','video']],
					    ['view', ['help']]
					 ]
		});
		
		//drop and down
		dragAndDropSetting();
		
		// 게시글 수정저장
		$("#postModifyBtn").on("click", function(){
			// 게시글 작성체크
			if(!fn_isWriteChk()) return;
			
// 			일반 form 전송시 사용하는 enctype='multipart/form-data'
// 			를 ajax를 이용하여 전송하는 경우
// 			해당 form 정보를 FormData에 삽입 후 
// 			contentType, processData 값을 false 로 설정한다.
// 			 - contentType : false 로 선언 시 content-type 헤더가 multipart/form-data로 전송되게 함
// 			 - processData : false로 선언 시 formData를 string으로 변환하지 않음
// 			 - serialize : form 전송시 사용 (type=file 요소는 미포함)_직렬화
// 			 - FormData : form 전송시 사용 (type=file 요소 포함)

			if(!confirm("해당 게시글을 수정하시겠습니까?")) return;

			let form = $("#postModifyForm")[0];
			let formInfo = new FormData(form);
			$.ajax({
				type		: "POST",
				enctype		: "multipart/form-data",
				url			: "/board/updatePostInfo",
				data		: formInfo,
				contentType	: false,
				processData	: false,
				async		: true,
				beforeSend	: function(xhr){
					$(".note-toolbar").css("display", "none");
					document.body.classList.add("no-scroll");
					loadingDiv.show();
				},
				complete : function(){
					document.body.classList.remove("no-scroll");
					loadingDiv.hide();
			    },
				success : function(result){
					alert("게시글 수정완료");
					postInfoView();
				},
				error : function(request, status, error){
					console.log(error);
					alert("게시글 수정실패");
					postInfoView();
				}
			});
		});
		
		// 게시글 수정취소
		$("#postEditCancleBtn").on("click", function(){
			postInfoView();
		});
		
		
		// 첨부파일 삭제 전처리(삭제버튼 클릭 후 저장버튼 클릭진행 필요)
		$(".removeAttach").on("click", function(){
			removeAttachs(this);
		});
		
		
		$(".files").on("click", function(){
			removeAttachs(this);
		});
		
		// 첨부파일 삭제
		function removeAttachs(thisInfo){
			let bbsAttachIdVal = $(thisInfo).parent().attr("attach-id");
			console.log("bbsAttachIdVal = "+bbsAttachIdVal);
			for(let attCnt=0; attCnt<rmBbsAttIdArr.length; attCnt++){
				// 같은 첨부파일정보를 클릭했을 경우 해당 첨부파일번호를 삭제 후 태그정보 재설정
				if(rmBbsAttIdArr[attCnt] == bbsAttachIdVal){
					let tempArr = [];
					let cntNum = 0;
					for(let fileCnt=0; fileCnt<rmBbsAttIdArr.length; fileCnt++){
						if(fileCnt != attCnt){
							tempArr[cntNum] = rmBbsAttIdArr[fileCnt];
							cntNum++;
						}
					}
					rmBbsAttIdArr = [];
					for(let fileCnt=0; fileCnt<tempArr.length; fileCnt++){
						rmBbsAttIdArr[fileCnt] = tempArr[fileCnt];
					}
					$(thisInfo).parent().children(".files").children("p").css({"text-decoration":""});
					$("#removeFileInfo").val(rmBbsAttIdArr);
					return;
				}
			}
			rmBbsAttIdArr[rmBbsAttIdArr.length] = bbsAttachIdVal;
			
			$(thisInfo).parent().children(".files").children("p").css({"text-decoration":"line-through"});
			$("#removeFileInfo").val(rmBbsAttIdArr);
		}
		
		
		// 게시글 조회
		function postInfoView(){
			let formPostInfo = document.createElement("form");
			
			let bbsCatalId = document.createElement("input");
			bbsCatalId.setAttribute("name", "bbsCatalId");
			bbsCatalId.setAttribute("type", "hidden");
			bbsCatalId.setAttribute("value", $("#postModifyTable").attr("bbs-catal-id"));
			
			let bbsPostId = document.createElement("input");
			bbsPostId.setAttribute("name", "bbsPostId");
			bbsPostId.setAttribute("type", "hidden");
			bbsPostId.setAttribute("value", $("#bbsPostId").val());
			
			formPostInfo.appendChild(bbsCatalId);
			formPostInfo.appendChild(bbsPostId);
			
			formPostInfo.setAttribute("method","post");
			formPostInfo.setAttribute("action","/board/postInfoView");
			document.body.appendChild(formPostInfo);
			formPostInfo.submit();
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
		
		
		//drop and down
		function dragAndDropSetting(){
			
			var $file = document.getElementById("bbsPostAttchInfo");
			var dropSpan = document.querySelector(".dropSpan");
			var dropZone = document.querySelector(".dropBox");
			
			// 드래그한 파일 객체가 해당 영역에 놓였을 때
			dropZone.addEventListener("drop", function(e){
				e.preventDefault();
				dropZone.className = "dropBox";
			   
				// 드롭한 파일을 좌측정렬
				dropZone.classList.add("left-sort");
				
				// 선택된 파일 setting
				fileList(e, $file, dropSpan, dropZone);
			})
			
			// ondragover 이벤트가 없으면 onDrop 이벤트가 실핻되지 않습니다.
			dropZone.addEventListener("dragover", function(e){
				e.stopPropagation();
				e.preventDefault();
				dropZone.classList.add("active");
			})
			
			// 드래그한 파일이 최초로 진입했을 때
			dropZone.addEventListener("dragenter", function(e){
				e.preventDefault();
				dropZone.classList.add("active");
			})
			
			// 드래그한 파일이 영역을 벗어났을 때
			dropZone.addEventListener("dragleave", function(e){
				e.preventDefault();
				dropZone.classList.remove("active");
			})
			
			// 드래그 앤 드롭 영억 클릭
			$(".dropBox").on("click", function(){
				$("#bbsPostAttchInfo").trigger("click");
			});
			
			// 선택된 파일 setting
			$file.addEventListener("change", function(e){
				// 드롭한 파일을 좌측정렬
				dropZone.classList.add("left-sort");
				
				// 선택된 파일 setting
				fileList(e, $file, dropSpan, dropZone);
			})
		}
		
		// 선택된 파일 setting
		function fileList(e, $file, dropSpan, dropZone){
			// 파일 리스트
			var files = e.dataTransfer && e.dataTransfer.files;
			$file.files = files;
			let innerText = "";
			if($file.files.length <= 0){
				// 드롭한 파일을 좌측정렬 해재 및 택스트 재설정
				dropZone.classList.remove("left-sort");
				dropSpan.innerHTML = "Drag & Drop";
			}else{
				for(let i=0; i<$file.files.length; i++){
					
					// 파일 이름 및 확장자 추출
					let fileName = $file.files[i].name;
					let fileEx = (fileName.substr(fileName.lastIndexOf("."))).substr(1);
					
					// 해당 파일의 확장자에 맞는 아이콘 이미지 생성
					let iconDefaultLocBefore = "<img class='fileIcons' src='${path}/resources/images/fileExIcons/";
					let iconDefaultLocAfter = "' >";
					let srcLoc =  "icon_ver-"+fileEx.toLowerCase()+".png";
					let imgTag = iconDefaultLocBefore + srcLoc + iconDefaultLocAfter;
					
					// 파일 확장자 아이콘 및 파일명
					let fileIconInfo = "<p class='dropAddFiles'>" + imgTag + fileName + "</p>";
					
					// 추가한 파일정보 저장
					innerText += fileIconInfo;
					
					// 파일정보 간격설정
					if(i < $file.files.length-1){
						innerText += "<br>";
					}
				}
				// 드롭한 정보 재설정
				dropSpan.innerHTML = innerText;
			}
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
					<form id="postModifyForm" enctype="multipart/form-data">
						<table id="postModifyTable" bbs-catal-id="${bbsCatalId}">
							<tr>
								<td>
									<input id="bbsPostTitle" name="bbsPostTitle" type="text" value="${postInfo.bbsPostTitle}"/>
								</td>
							</tr>
							<tr>
								<td>
									<div>
										<textarea id="summernote" name="bbsPostContent">${postInfo.bbsPostContent}</textarea>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div id="filesDiv">
										<c:choose>
											<c:when test="${attachList ne null and attachList.size() > 0}">
												<c:forEach var="attachInfo" items="${attachList}">
													<div class="fileDivs" attach-id="${attachInfo.bbsAttachId}">
														<div class="files">
															<p>${attachInfo.bbsAttachOriginNm}</p>
														</div>
														<div class="removeAttach">
															<span>✖</span>
														</div>
													</div>
												</c:forEach>
											</c:when>
											<c:otherwise>
											</c:otherwise>
										</c:choose>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div id="filesUploadDiv">
										<div class="dropBox">
											<!-- 
											&lt; 	: < (부등호 꺽쇠)
											&gt; 	: > (부등호 꺽쇠)
											&nbsp; 	: ' ' (공백, Space 한칸)
											&amp; 	: & (앰퍼샌드)
											&quot; 	: " (큰따옴표 하나)
											 -->
											<span class="dropSpan">Drag &amp; Drop</span>
										</div>
										<input id="bbsPostAttchInfo" type="file" name="bbsPostAttchInfo" multiple="multiple" />
									</div>
								</td>
							</tr>
						</table>
						<input type="hidden" id="bbsPostId" name="bbsPostId" value="${postInfo.bbsPostId}" />
						<input type="hidden" id="bbsPostRegId" name="bbsPostRegId" value="${loginSession.userId}" />
						<input type="hidden" id="removeFileInfo" name="removeFileInfo" />
					</form>
					<br>
					<div class="buttonDiv">
						<input class="postInfoBtn" type="button" id="postModifyBtn" value="저장" />
						<input class="postInfoBtn" type="button" id="postEditCancleBtn" value="취소" />
					</div>
				</div>
				<br><br>
			</div>
		</div>
	</div>
</div>