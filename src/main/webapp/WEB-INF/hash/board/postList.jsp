<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

<head>


  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>IRON DRUM</title>
  
  
  
  
  
  <!-- plugins:css -->
  <link rel="stylesheet" href="${path}/resources/vendors/feather/feather.css">
  <link rel="stylesheet" href="${path}/resources/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="${path}/resources/vendors/css/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- Plugin css for this page -->
  <link rel="stylesheet" href="${path}/resources/vendors/datatables.net-bs4/dataTables.bootstrap4.css">
  <link rel="stylesheet" href="${path}/resources/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" type="text/css" href="${path}/resources/js/select.dataTables.min.css">
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="${path}/resources/css/vertical-layout-light/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="${path}/resources/images/favicon.png" />
  
  
  
  
  
  <!-- plugins:js -->
  <script src="${path}/resources/vendors/js/vendor.bundle.base.js"></script>
  <!-- endinject -->
  <!-- Plugin js for this page -->
  <script src="${path}/resources/vendors/chart.js/Chart.min.js"></script>
  <script src="${path}/resources/vendors/datatables.net/jquery.dataTables.js"></script>
  <script src="${path}/resources/vendors/datatables.net-bs4/dataTables.bootstrap4.js"></script>
  <script src="${path}/resources/js/dataTables.select.min.js"></script>

  <!-- End plugin js for this page -->
  <!-- inject:js -->
  <script src="${path}/resources/js/off-canvas.js"></script>
  <script src="${path}/resources/js/hoverable-collapse.js"></script>
  <script src="${path}/resources/js/template.js"></script>
  <script src="${path}/resources/js/settings.js"></script>
  <script src="${path}/resources/js/todolist.js"></script>
  <!-- endinject -->
  <!-- Custom js for this page-->
  <script src="${path}/resources/js/dashboard.js"></script>
  <script src="${path}/resources/js/Chart.roundedBarCharts.js"></script>
  <!-- End custom js for this page-->
  
  <script>
  	function goHome(){
  		var homeForm = document.getElementById("pageControllDiv");
  		homeForm.setAttribute("method","post");
  		homeForm.setAttribute("action","/main/mainpage");
  		homeForm.submit();
  	}
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
															<tr> 
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
	
		<div>
			<form id="pageControllDiv"></form>
		</div>
  
	</body>

</html>

