<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	
	<!-- jquery -->
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	
	<!-- summernote lite version js -->
	<script src="${path}/resources/summernote/summernote-lite.js"></script>
	<script src="${path}/resources/summernote/lang/summernote-ko-KR.js"></script>
	
	<!-- 공통 javascript code -->
	<script>
		
		// 홈페이지 메인페이지
		function goHome(){
			
			let formInfo = document.createElement("form");
			formInfo.setAttribute("id", "pageControllDiv");
			formInfo.setAttribute("method", "post");
			formInfo.setAttribute("action", "/main/mainpage");
			document.body.appendChild(formInfo);
			formInfo.submit();
		}
	 	
		// 게시판 페이지
		function goPostList(){
			
			let formInfo = document.createElement("form");
			formInfo.setAttribute("id", "pageControllDiv");
			formInfo.setAttribute("method", "post");
			formInfo.setAttribute("action", "/board/postList");
			document.body.appendChild(formInfo);
			formInfo.submit();
		}
  </script>
  
  
  