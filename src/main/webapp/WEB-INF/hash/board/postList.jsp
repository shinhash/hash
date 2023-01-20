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
    	<jsp:include page="${path}/WEB-INF/hash/layout/temp.jsp" />
    	
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
      
			<!-- partial -->
			<!-- partial:partials/_sidebar.html -->
			<nav class="sidebar sidebar-offcanvas" id="sidebar">
				<ul class="nav">
					<li class="nav-item">
						<a class="nav-link" href="#">
							<i class="icon-grid menu-icon"></i>
							<span class="menu-title">Dashboard</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
							<i class="icon-layout menu-icon"></i>
							<span class="menu-title">UI Elements</span>
							<i class="menu-arrow"></i>
						</a>
						<div class="collapse" id="ui-basic">
							<ul class="nav flex-column sub-menu">
								<li class="nav-item"> <a class="nav-link" href="${path}/resources/pages/ui-features/buttons.html">Buttons</a></li>
								<li class="nav-item"> <a class="nav-link" href="${path}/resources/pages/ui-features/dropdowns.html">Dropdowns</a></li>
								<li class="nav-item"> <a class="nav-link" href="${path}/resources/pages/ui-features/typography.html">Typography</a></li>
							</ul>
						</div>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-toggle="collapse" href="#form-elements" aria-expanded="false" aria-controls="form-elements">
							<i class="icon-columns menu-icon"></i>
							<span class="menu-title">Form elements</span>
							<i class="menu-arrow"></i>
						</a>
						<div class="collapse" id="form-elements">
							<ul class="nav flex-column sub-menu">
								<li class="nav-item"><a class="nav-link" href="${path}/resources/pages/forms/basic_elements.html">Basic Elements</a></li>
							</ul>
						</div>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-toggle="collapse" href="#charts" aria-expanded="false" aria-controls="charts">
							<i class="icon-bar-graph menu-icon"></i>
							<span class="menu-title">Charts</span>
							<i class="menu-arrow"></i>
						</a>
						<div class="collapse" id="charts">
							<ul class="nav flex-column sub-menu">
								<li class="nav-item"> <a class="nav-link" href="${path}/resources/pages/charts/chartjs.html">ChartJs</a></li>
							</ul>
						</div>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-toggle="collapse" href="#tables" aria-expanded="false" aria-controls="tables">
							<i class="icon-grid-2 menu-icon"></i>
							<span class="menu-title">Tables</span>
							<i class="menu-arrow"></i>
						</a>
						<div class="collapse" id="tables">
							<ul class="nav flex-column sub-menu">
								<li class="nav-item"> <a class="nav-link" href="${path}/resources/pages/tables/basic-table.html">Basic table</a></li>
							</ul>
						</div>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-toggle="collapse" href="#icons" aria-expanded="false" aria-controls="icons">
							<i class="icon-contract menu-icon"></i>
							<span class="menu-title">Icons</span>
							<i class="menu-arrow"></i>
						</a>
						<div class="collapse" id="icons">
							<ul class="nav flex-column sub-menu">
								<li class="nav-item"> <a class="nav-link" href="${path}/resources/pages/icons/mdi.html">Mdi icons</a></li>
							</ul>
						</div>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-toggle="collapse" href="#auth" aria-expanded="false" aria-controls="auth">
							<i class="icon-head menu-icon"></i>
							<span class="menu-title">User Pages</span>
							<i class="menu-arrow"></i>
						</a>
						<div class="collapse" id="auth">
							<ul class="nav flex-column sub-menu">
								<li class="nav-item"> <a class="nav-link" href="${path}/resources/pages/samples/login.html"> Login </a></li>
								<li class="nav-item"> <a class="nav-link" href="${path}/resources/pages/samples/register.html"> Register </a></li>
							</ul>
						</div>
					</li>
					<li class="nav-item">
						<a class="nav-link" data-toggle="collapse" href="#error" aria-expanded="false" aria-controls="error">
							<i class="icon-ban menu-icon"></i>
							<span class="menu-title">Error pages</span>
							<i class="menu-arrow"></i>
						</a>
						<div class="collapse" id="error">
							<ul class="nav flex-column sub-menu">
								<li class="nav-item"> <a class="nav-link" href="${path}/resources/pages/samples/error-404.html"> 404 </a></li>
								<li class="nav-item"> <a class="nav-link" href="${path}/resources/pages/samples/error-500.html"> 500 </a></li>
							</ul>
						</div>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="${path}/resources/pages/documentation/documentation.html">
								<i class="icon-paper menu-icon"></i>
								<span class="menu-title">Documentation</span>
							</a>
						</li>
					</ul>
				</nav>
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
