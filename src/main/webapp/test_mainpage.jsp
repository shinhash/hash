<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	    
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script> 
	    <script>
	    	$(function(){
	    		// search-bar 라벨을 클릭할 경우 라벨에 포커스
		    	$("html").on("click", function(e){
		    		if(!$(e.target).hasClass("search-bar")){
		    			$("#srbLabel").attr("class", "search-bar label");
		    		}else{
		    			$("#srbLabel").attr("class", "search-bar label focus");
		    		}
		    	});
	    		
		    	window.blur();
	    	});
	    </script>
	    <style type="text/css">
	    	body {
	    		min-width: 1200px;
	    		display: block;
	    		font-family: "Noto Sans KR", "NanumGothic", "나눔고딕", "Nanum Gothic", "맑은 고딕", "Malgun Gothic", Dotum;
	    	}
	    	
	    	.inner {
	    		width: 1200px;
	    		margin: 0 auto;
	    		padding: 0 80px;
	    	}
	    
	    
	    	.focus {
	    		border: 1px solid rgb(38, 86, 246);
	    	}
	    	
	    	.toolbar-util-li {
	    		margin-left: 15px;
	    	}
	    	.toolbar-util-li a {
	    		display: block;
	    	}
	    	.toolbar-util-li > a {
	    		color: #6e6d7a;
	    		text-decoration: none;
	    		font-weight: 500;
	    		font-size: 14px;
	    	}


	    	
	    	.toolbar-mlist{
	    		height: 55px;
	    	}
	    	.toolbar-mlist-ul {
	    		margin: inherit;
	    		display: flex;
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
	    		font-weight: 700;
	    		font-size: 15px;
	    	}
	    	
	    	.toolbar-mlist-li > a:hover {
	    		color: blue;
	    	}
	    	
	    	
	    	a {
	    		font-family: "Noto Sans KR", "NanumGothic", "나눔고딕", "Nanum Gothic", "맑은 고딕", "Malgun Gothic", Dotum;
	    	}
	    </style>
	</head>
	<body>
		<div id="root" class="root">
			<header id="page-head">
				<div class="toolbar inner">
					<div class="toolbar-area">
						<div class="toolbar-area-top" style="display: flex;">
							<div class="toolbar-area-top-left" style="display: flex; width: 70%">
								<a class="home-logo">
									<img alt="홈페이지 아이콘" style="height: 50px; width: 50px;" src="${path}/resources/images/logo/irondrum-logo_icon_mini.jpg">
								</a>
								<div class="search-bar" style="width: 370px; display: flex; position: relative; margin-left: 10px;">
									<label	id="srbLabel"
											class="search-bar label"
											style="width: 100%; height: 30px; 
											align-items :center; 
											padding: 8px 32px 8px 16px; 
											position: relative;
											border-radius: 23px;
											background-color: rgb(245, 246, 247);
											margin-top: 5px;
											">
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
								<ul class="toolbar-util-ul" style="display: flex;">
									<li class="toolbar-util-li" style="display: flex;"><a href="#">로그인</a></li>
									<li class="toolbar-util-li" style="display: flex;"><a href="#">회원가입</a></li>
									<li class="toolbar-util-li" style="display: flex;"><a href="#">안내</a></li>
								</ul>
							</div>
						</div>
						<div class="toolbar-mlist" >
							<ul class="toolbar-mlist-ul">
								<li class="toolbar-mlist-li" style="display: flex;"><a href="#">전체보기</a></li>
								<li class="toolbar-mlist-li" style="display: flex;"><a href="#">공지사항</a></li>
								<li class="toolbar-mlist-li" style="display: flex;"><a href="#">게시판</a></li>
								<li class="toolbar-mlist-li" style="display: flex;"><a href="#">추천음악</a></li>
								<li class="toolbar-mlist-li" style="display: flex;"><a href="#">악보봐</a></li>
							</ul>
						</div>
					</div>
				</div>
			</header>
			<div></div>
			<div id="page-body">
				<div>body-top[rollingtab]</div>	
				<div class="inner">body-middle[contents]</div>				
			</div>
			<footer id="page-foot">footer</footer>
		</div>
	</body>
</html>