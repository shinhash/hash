<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">

<head>

	<!-- Required meta tags -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- 암호화된 HTTPS 페이지에 암호화되지 않은 HTTP를 통해 요청할 때 발생하는 에러관련 META설정 -->
	<meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">
	<title>IRON DRUM</title>
  
	<!-- tiles로 변경작업 -->
	<jsp:include page="${path}/WEB-INF/hash/plugins/plugins_css.jsp" />
	
	<!-- tiles로 변경작업 -->
    <jsp:include page="${path}/WEB-INF/hash/plugins/plugins_js.jsp" />
	
  
	<script>
		$(document).ready(function (){
			
			// summernote setting and view
			$('#summernote').summernote({
				height: 300,                 // 에디터 높이
				minHeight: null,             // 최소 높이
				maxHeight: null,             // 최대 높이
				focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
				lang: "ko-KR",					// 한글 설정
				placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
			});
			
			
			$("#postModiEdit").on("click", function(){
				var formInfo = document.getElementById("bbsPostForm");
				
				let bbsPostId = document.createElement("input");
				bbsPostId.setAttribute("name", "bbsPostId");
				bbsPostId.setAttribute("type", "hidden");
				bbsPostId.setAttribute("value", $("#boardPostTable").attr("bbs-post-id"));
				formInfo.appendChild(bbsPostId);
				
				formInfo.setAttribute("method","post");
				formInfo.setAttribute("action","/board/postModiEdit");
				formInfo.submit();
			});
			
			
			$("#postEditCancle").on("click", function(){
				var formInfo = document.getElementById("pageControllDiv");
				
				let bbsPostId = document.createElement("input");
				bbsPostId.setAttribute("name", "bbsPostId");
				bbsPostId.setAttribute("type", "hidden");
				bbsPostId.setAttribute("value", $("#boardPostTable").attr("bbs-post-id"));
				formInfo.appendChild(bbsPostId);
				
				formInfo.setAttribute("method","post");
				formInfo.setAttribute("action","/board/postInfoView");
				formInfo.submit();
			});
		});
		
  </script>
  
  
</head>

<body>
	<div class="container-scroller">
	 
		<!-- tiles로 변경작업 -->
    	<jsp:include page="${path}/WEB-INF/hash/layout/topMenu.jsp" />
    	
			<!-- partial -->
			<div class="container-fluid page-body-wrapper">
				<!-- partial:partials/_settings-panel.html -->
				<div class="theme-setting-wrapper">
					<div id="settings-trigger">
						<i class="ti-settings"></i>
					</div>
					<div id="theme-settings" class="settings-panel">
						<i class="settings-close ti-close"></i>
						<p class="settings-heading">SIDEBAR SKINS</p>
						<div class="sidebar-bg-options selected" id="sidebar-light-theme">
							<div class="img-ss rounded-circle bg-light border mr-3"></div>
							Light
						</div>
						<div class="sidebar-bg-options" id="sidebar-dark-theme"><div class="img-ss rounded-circle bg-dark border mr-3"></div>Dark</div>
						<p class="settings-heading mt-2">HEADER SKINS</p>
						<div class="color-tiles mx-0 px-4">
							<div class="tiles success"></div>
							<div class="tiles warning"></div>
							<div class="tiles danger"></div>
							<div class="tiles info"></div>
							<div class="tiles dark"></div>
							<div class="tiles default"></div>
						</div>
					</div>
				</div>
      
				<!-- tiles로 변경작업 -->
				<jsp:include page="${path}/WEB-INF/hash/layout/leftMenu.jsp" />

				<!-- partial -->
				<div class="main-panel">
					<div class="content-wrapper">
						<div class="row">
							<p>게시판</p>
						</div>
						<div class="row">
							<div class="col-md-15 grid-margin stretch-card">
								<div class="card">
									<div class="card-body" align="center">
										<br><br>
										<form id="bbsPostForm" enctype="multipart/form-data">
											<table id="boardPostTable" bbs-post-id="${postInfo.bbsPostId}" border="1" style="align-content: center; width: 100%">
												<tr>
													<td>제목</td>
													<td>
														<input id="bbsPostTitle" name="bbsPostTitle" type="text" style="font-weight: bold; width: 100%" value="${postInfo.bbsPostTitle}"/>
													</td>
												</tr>
												<tr>
													<td>내용</td>
													<td>
														<div>
															<textarea id="summernote" name="bbsPostContent">${postInfo.bbsPostContent}</textarea>
														</div>
													</td>
												</tr>
												<tr>
													<td>첨부파일</td>
												</tr>
											</table>
										</form>
										<br>
										<button style="display: inline-block; float: right; margin-left: 10px;" type="submit" class="add btn btn-success todo-list-add-btn" id="postModiEdit">Edit</button>
										<button style="display: inline-block; float: right;" type="submit" class="add btn btn-warning todo-list-add-btn" id="postEditCancle">cancle</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- content-wrapper ends -->
					<!-- partial:partials/_footer.html -->
					<footer class="footer">
						<div class="d-sm-flex justify-content-center justify-content-sm-between">
							<span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright © 2021.  Premium <a href="https://www.bootstrapdash.com/" target="_blank">Bootstrap admin template</a> from BootstrapDash. All rights reserved.</span>
							<span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Hand-crafted & made with <i class="ti-heart text-danger ml-1"></i></span>
						</div>
						<div class="d-sm-flex justify-content-center justify-content-sm-between">
							<span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Distributed by <a href="https://www.themewagon.com/" target="_blank">Themewagon</a></span> 
						</div>
					</footer> 
				<!-- partial -->
				</div>
			<!-- main-panel ends -->
			</div>   
		<!-- page-body-wrapper ends -->
		</div>
		<!-- container-scroller -->
		<form id="pageControllDiv"></form>
		<div>
			
		</div>
  
	</body>

</html>

