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
	    
	    <!-- summernote lite version css -->
		<link rel="stylesheet" href="${path}/resources/summernote/summernote-lite.css">
	    <style type="text/css">
	    	body {
	    		margin: 0px;
	    		min-width: 1200px;
	    		display: block;
	    		font: 12px/18px "Noto Sans KR",NanumGothic,"나눔고딕","Nanum Gothic","맑은 고딕","Malgun Gothic",Dotum;
	    	}
	    	
	    	.inner {
	    		width: 1200px;
	    		margin: 0 auto;
	    		padding: 0 80px;
	    		padding-left: 80px;
	    		padding-right: 80px;
	    	}
	    
	    
	    	.focus {
	    		border: 1px solid rgb(38, 86, 246);
	    	}
	    	
	    	.toolbar-util-li {
	    		margin-left: 15px;
	    	}
	    	.toolbar-util-li > a {
	    		display: block;
	    	}
	    	.toolbar-util-li > a {
	    		color: rgb(0, 0, 0);
	    		text-decoration: none;
	    		font-weight: 700;
	    		font-size: 14px;
	    	}
			.toolbar-util-ul a:hover {
	    		color: rgb(110, 109, 122);
	    	}

	    	
	    	.toolbar-mlist{
	    		height: 55px;
	    	}
	    	.toolbar-mlist-ul {
	    		margin: inherit;
	    		display: -webkit-flex;
		    	padding: inherit;
	    		height: 100%;
	    		align-items: center;
	    		-webkit-align-items: center;
	    	}
	    	.toolbar-mlist-li {
	    		margin-right: 50px;
	    	}
	    	.toolbar-mlist-li a {
	    		display: block;
	    	}
	    	.toolbar-mlist-li > a {
	    		color: #101c33;
	    		text-decoration: none;
	    		font-weight: 800;
	    		font-size: 15px;
	    	}
	    	
	    	.toolbar-mlist-li a:hover{
	    		color: blue;
	    	}
	    	
	    	
	    	a {
	    		font-family: "Noto Sans KR", "NanumGothic", "나눔고딕", "Nanum Gothic", "맑은 고딕", "Malgun Gothic", Dotum;
	    		color: rgb(110, 109, 122);
	    	}
	    	
	    	.flex{
	    		display: flex;
	    	}
	    	
	    	footer{
	    		height: 500px;
	    		display: block;
	    	}
	    	.footer-div > .inner{
	    		width: 100%;
	    		max-width: 1440px;
	    		min-width: 1200px;
	    		padding: 0px 80px;
	    		margin: 0px auto;
	    	}
	    	
	    	#bottomLogo{
	    		width: 300px;
	    	}
	    	
	    	.bottomBanner{
	    		width: 100%; 
	    		height: 150px; 
	    		background-color: rgb(44,44,44);
	    	}
	    	
	    	.contents-item{
	    		width: 150px;
	    		height: 150px;
	    	}
	    	
	    	.rolling-banner-div{
	    		background-color: rgb(44,44,44);
	    		height: 50px;
	    	}
	    	
	    	#bbsPostTitle{
	    		font-weight: bold; 
	    		width: 90%;
	    	}
	    </style>
	    
	   	<!-- jquery -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> 
		
		<!-- summernote lite version js -->
		<script src="${path}/resources/summernote/summernote-lite.js"></script>
		<script src="${path}/resources/summernote/lang/summernote-ko-KR.js"></script>
	    <script>
	    	$(document).ready(function (){
				
	    		// 배너 setInterval
	    		// search-bar 라벨을 클릭할 경우 라벨에 포커스
		    	$("html").on("click", function(e){
		    		if(!$(e.target).hasClass("search-bar")){
		    			$("#srbLabel").attr("class", "search-bar label");
		    		}else{
		    			$("#srbLabel").attr("class", "search-bar label focus");
		    		}
		    	});
		    	window.blur();
		    	
		    	fnRollBanner();
		    	
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
				
				
				// summernote setting and view
				$('#summernote').summernote({
					height: 300,                 // 에디터 높이
					minHeight: null,             // 최소 높이
					maxHeight: null,             // 최대 높이
					focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
					lang: "ko-KR",					// 한글 설정
					placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
				});
				
				
				$("#postModify").on("click", function(){
					var formInfo = document.getElementById("pageControllDiv");
					
					let bbsPostId = document.createElement("input");
					bbsPostId.setAttribute("name", "bbsPostId");
					bbsPostId.setAttribute("type", "hidden");
					bbsPostId.setAttribute("value", $("#boardPostTable").attr("bbs-post-id"));
					formInfo.appendChild(bbsPostId);
									
					formInfo.setAttribute("method","post");
					formInfo.setAttribute("action","/board/postModifyView");
					formInfo.submit();
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
	    	
	    	
	    	function fnRollBanner(){
	    		// DB에서 배너이미지정보 조회
	    		//var tempBannerArr = ["rolling-banner-01", "rolling-banner-02", "rolling-banner-03"];
	    		$(".rolling-banner-div").css("background-color", "rgb(44,44,44)");
				let bannerClass = $("#rollImg").attr("class");
				let baseImgPath = "${path}/resources/images/banner/roll-banner-";
				let imgExt = ".jpg";
				let imgNo = "";
				
				if(bannerClass == "rollban-01"){
					imgNo = "02";
					bannerClass = "rollban-02";
				}else if(bannerClass == "rollban-02"){
					imgNo = "01";
					bannerClass = "rollban-01";
				}
				let bannerImgInfo = baseImgPath + imgNo + imgExt;
				$("#rollImg").attr("src", bannerImgInfo).stop(true,true).hide().fadeIn();
				$("#rollImg").css("width", "80%");
				$("#rollImg").attr("class", bannerClass);
	    		setTimeout(fnRollBanner, 10000);
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
	    
	</head>
	<body>
		<div id="root" class="root">
			<header id="page-head">
				<div class="toolbar inner">
					<div class="toolbar-area">
						<div class="toolbar-area-top flex" >
							<div class="toolbar-area-top-left flex" style=" width: 70%">
								<a class="home-logo" onclick="goHome()">
									<img alt="홈페이지 아이콘" style="height: 50px; width: 50px;" src="${path}/resources/images/logo/irondrum-logo_icon_mini.jpg">
								</a>
								<div class="search-bar flex" style="width: 370px;  position: relative; margin-left: 10px;">
									<label	id="srbLabel"
											class="search-bar label"
											style="width: 100%; height: 30px; 
											align-items :center; 
											padding: 8px 32px 8px 16px; 
											position: relative;
											border-radius: 23px;
											background-color: rgb(245, 246, 247);
											margin-top: 5px;">
										<input 	class="search-bar input"
												style="width: 100%; 
												height: 30px; 
												border: none; 
												background-color: rgb(245, 246, 247);
												outline-style: none;" 
												placeholder="검색어를 입력해주세요"/>
									</label>
									<svg	class="search-svg"
											style="width: 18px; height: 18px; 
											position: absolute; right: 20px;
											margin-top: 17px;" 
											color="#101C33" 
											viewBox="0 0 12 12"
											tabindex="-1"
											onclick="alert('test!!');">
										<path fill-rule="evenodd" clip-rule="evenodd" d="M5.16483 8.33C3.41907 8.33 1.99996 6.91 1.99996 5.165C1.99996 3.41917 3.41907 1.99917 5.16483 1.99917C6.91059 1.99917 8.32969 3.41917 8.32969 5.165C8.32969 6.91 6.91059 8.33 5.16483 8.33ZM10.8538 10.1483L8.42886 7.7225C8.98467 7.015 9.32965 6.13417 9.32965 5.165C9.32965 2.86417 7.46473 1 5.16483 1C2.86492 1 1 2.86417 1 5.165C1 7.465 2.86492 9.32917 5.16483 9.32917C6.13395 9.32917 7.01558 8.98417 7.72222 8.42917L10.1471 10.8533C10.2454 10.9517 10.3729 11 10.5004 11C10.6288 11 10.7563 10.9517 10.8538 10.8533C11.0487 10.6592 11.0487 10.3417 10.8538 10.1483Z">
										</path>
										<defs></defs>
									</svg>
								</div>
							</div>
							<div class="toolbar-util" style="float: right;">
								<ul id="toolbar-util-ul" class="toolbar-util-ul flex" >
									<li class="toolbar-util-li flex" ><a href="#">로그인</a></li>
									<li class="toolbar-util-li flex" ><a href="#">회원가입</a></li>
									<li class="toolbar-util-li flex" ><a href="#">안내</a></li>
								</ul>
							</div>
						</div>
						<div class="toolbar-mlist" >
							<ul class="toolbar-mlist-ul flex">
								<li class="toolbar-mlist-li flex" ><a href="#">전체보기</a></li>
								<li class="toolbar-mlist-li flex" ><a href="#">공지사항</a></li>
								<li class="toolbar-mlist-li flex" ><a onclick="goPostList()">게시판</a></li>
								<li class="toolbar-mlist-li flex" ><a href="#">추천음악</a></li>
								<li class="toolbar-mlist-li flex" ><a href="#">악보봐</a></li>
							</ul>
						</div>
					</div>
				</div>
			</header>
			<div></div>
			<div id="page-body">
				<div class="rolling-banner-div"></div>
				<br>
				<div class="body-contents">
					<div class="inner">
						<div class="contents">
							<br><br>
							<form id="bbsPostForm" enctype="multipart/form-data">
								<table id="boardPostTable" bbs-post-id="${postInfo.bbsPostId}" border="1" style="align-content: center; width: 100%">
									<tr>
										<td>제목</td>
										<td>
											<input id="bbsPostTitle" name="bbsPostTitle" type="text" value="${postInfo.bbsPostTitle}"/>
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
						<br><br>
					</div>
				</div>
				<div class="bottomBanner"></div>			
			</div>
			<footer id="page-foot">
				<div class="footer-div">
					<div class="inner">
						<div class="flex" style="justify-content: space-between;">
							<div class="footer-left">
								<div style="letter-spacing: -0.25px; margin-top: 32px;">
									<img id="bottomLogo" src="${path}/resources/images/logo/irondrum-logo_icon.jpg" />
								</div>
								<div style="margin-top: 97px;">bottom compony info</div>
							</div>
							<div class="footer-right" style="width: 25%">right</div>
						</div>
						<div class="footer-link"></div>
					</div>
				</div>
			</footer>
		</div>
		
		<div>
			<form id="pageControllDiv"></form>
		</div>
		
	</body>
</html>