<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	#header-search-div{
		width: 370px;
		position: relative;
		margin-left: 10px;
	}
	#home-icon{
		height: 50px;
		width: 50px;
	}
	#toolbar-util {
		height:50px;
		line-height: 20px;
		text-align: center;
		float: right;
		margin-left: 15%;
	}
	.toolbar-util-ul{
		list-style: none;
	}
	.sign-menu-ul-tab {
		width:130px;
		position: absolute;
		font-size:14px;
		background: white;
		text-decoration: none;
		color:#333;
		display: none;
	}
	.sign-menu-ul-tab a {
		text-decoration: none;
		color: black;
	}
	/**
	css sibling element
	 - ~ : 자식을 제외한 태그 선택
	 - + : 자식을 제외한 특정태그에 근접한 태그(다음태그) 선택
	*/
	#signUserMenuChk{
		display: none;
	}
	#signUserMenuChk:checked ~ * .sign-menu-ul-tab{
		display: block;
	}
	.sign-menu-info:hover{
		background-color: rgb(110, 109, 122);
	}
	.sign-menu-info:hover a{
		color: black;
	}
</style>
<script src="https://kit.fontawesome.com/3d4638d271.js" crossorigin="anonymous"></script>
<script type="text/javascript">
	$(document).ready(function (){
		//배너 setInterval
		// search-bar 라벨을 클릭할 경우 라벨에 포커스
		$("html").on("click", function(e){
			if(!$(e.target).hasClass("header-search")){
				$("#srbLabel").attr("class", "header-search label");
			}else{
				$("#srbLabel").attr("class", "header-search label focus");
			}
		});
		window.blur();
		
		// logout process
		$("#logout-div").on("click", function(){
			logout();
		});
		$("#logout-a").on("click", function(){
			logout();
		});
	});

	// 검색버튼 클릭
	function headSearchClick(){
		fn_headSearch();
	}
	
	// 검색 프로세스
	function fn_headSearch(){
		alert("search!!!");
	}
</script>
<header id="page-head">
	<div class="toolbar inner">
		<div class="toolbar-area">
			<div class="toolbar-area-top flex" >
				<div class="toolbar-area-top-left flex" style=" width: 70%">
					<a class="home-logo" onclick="goHome()">
						<img id="home-icon" alt="홈페이지 아이콘" src="${path}/resources/images/logo/irondrum-logo_icon_mini.jpg">
					</a>
					<div id="header-search-div" class="header-search flex">
						<label id="srbLabel" class="header-search label">
							<input class="header-search input" placeholder="검색어를 입력해주세요"/>
							<i id="search-icon" class="fa-solid fa-magnifying-glass fa-lg flex" onclick="fn_headSearch()"></i>
						</label>
					</div>
				</div>
				<c:choose>
				<c:when test="${loginSession ne null}">
					<div id="toolbar-util" class="toolbar-util">
						<!-- 로그인 화면을 드롭다운 메뉴로 변환 필요 -->
						<input type="checkbox" id="signUserMenuChk">
						<ul id="toolbar-util-ul" class="toolbar-util-ul" >
							<li class="toolbar-util-li">
								<label for="signUserMenuChk">
									<a id="signUserMenu">
										<img id="userImg" alt="userImg" style="height: 50px; width: 50px;" 
											 src="${path}/resources/images/logo/irondrum-logo_icon_mini.jpg">
									</a>
								</label>
								<div class="sign-menu-ul-tab">
									<div class="sign-menu-ul-tab-group">
										<div class="sign-menu-info">
											<a href="#">북마크</a>
										</div>
										<div class="sign-menu-info">
											<a href="#">내정보</a>
										</div>
										<div id="logout-div" class="sign-menu-info">
											<a id="logout-a" onclick="logout()">로그아웃</a>
										</div>
									</div>
								</div>
							</li>
						</ul>
					</div>
				</c:when>
				<c:otherwise>
					<div class="toolbar-util" style="float: right; margin-left: 10%;">
						<ul id="toolbar-util-ul" class="toolbar-util-ul flex" >
							<li class="toolbar-util-li flex" ><a onclick="goSignIn()">로그인</a></li>
							<li class="toolbar-util-li flex" ><a onclick="goSignUp()">회원가입</a></li>
							<li class="toolbar-util-li flex" ><a href="#">안내</a></li>
						</ul>
					</div>
				</c:otherwise>
				</c:choose>
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
	<div class="topLineDiv lineTopBottomDiv"></div>
</header>