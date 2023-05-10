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
			
			// 게시글 상세정보 페이지
			$(".postInfoVIew").on("click", function(){
				
				var formInfo = document.getElementById("pageControllDiv");
				formInfo.setAttribute("method","post");
				formInfo.setAttribute("action","/board/postInfoView");
				
				let bbsPostId = document.createElement("input");
				bbsPostId.setAttribute("name", "bbsPostId");
				bbsPostId.setAttribute("value", $(this).attr("bbs-post-id"));
				formInfo.appendChild(bbsPostId);
				
				formInfo.submit();
			});
			
			$("#postWrite").on("click", function(){
				
				var formInfo = document.getElementById("pageControllDiv");
				formInfo.setAttribute("method","post");
				formInfo.setAttribute("action","/board/postRegistView");
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
									<div class="card-body">
										<p class="card-title mb-0">Top Products</p>
										<div class="table-responsive">
											<table class="table table-striped table-borderless">
												<thead>
													<tr>
														<th>번호</th>
														<th>제목</th>
														<th>작성자</th>
														<th>최근수정일</th>
													</tr>  
												</thead>
												<c:choose>
													<c:when test="${postList} == null">
														<tr>no data</tr>
													</c:when>
													<c:otherwise>
														<c:forEach var="postInfo" items="${postList}" >
															<tr class="postInfoVIew" bbs-post-id="${postInfo.bbsPostId}"> 
																<td>${postInfo.rn}	</td>
																<td>${postInfo.bbsPostTitle}	</td>
																<td>${postInfo.bbsPostRegId}	</td>
																<td>
																	<fmt:parseDate var="fmtInfo" value="${postInfo.bbsPostModDate}" pattern="yyyyMMddHHmmss"/>
																	<fmt:formatDate value="${fmtInfo }" pattern="yyyy-MM-dd HH:mm:ss"/>
																</td>
															</tr>
														</c:forEach>
													</c:otherwise>
												</c:choose>
												</tbody>
											</table>
										</div>
										<br>
										<button style="display: inline-block; float: right;" type="submit" class="add btn btn-success todo-list-add-btn" id="postWrite">Write</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- content-wrapper ends -->
					
					<!-- tiles로 변경작업 -->
    				<jsp:include page="${path}/WEB-INF/hash/layout/footer.jsp" />
    				
					 
				<!-- partial -->
				</div>
			<!-- main-panel ends -->
			</div>   
		<!-- page-body-wrapper ends -->
		</div>
		<!-- container-scroller -->
	
		<div>
			<form id="pageControllDiv"></form>
		</div>
  
	</body>

</html>

