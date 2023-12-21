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
		width: auto;
		min-width: 130px;
		height: auto;
		position: absolute;
		font-size: 14px;
		background: white;
		text-decoration: none;
		color: #333;
		display: none;
		border: 1px solid rgb(110, 109, 122);
		border-radius: 10px;
	}
	.sign-menu-ul-tab a {
		text-decoration: none;
		color: black;
	}
	
	#userImg{
		height: 40px;
		width: 40px;
		border-radius: 23px;
		background-color: rgb(245, 246, 247);
	}
	#userImg:hover{
		background-color: lightgray;
	}
	#userImg:active{
		background-color: rgb(110, 109, 122);
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
	.sign-menu-info{
		height: 40px;
	}
	.sign-menu-info a{
		vertical-align: -webkit-baseline-middle;
	}
	.sign-menu-info:hover{
		background-color: lightgray;
		border-radius: 10px;
	}
	.sign-menu-info:active{
		background-color: rgb(110, 109, 122);
		border-radius: 10px;
	}
	.sign-menu-info:hover a{
		color: black;
	}
	
	#sign-userNm{
		font-size: 12px;
		color: white;
		background-color: rgb(44, 44, 44);
		border-radius: 10px 10px 0px 0px;
	}
</style>
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
		
		// 메뉴 버튼에 따른 게시판 이동
		$(".topMenuBtn").on("click", function(){
			let catalType = $(this).attr("catal-type");
			
			switch(catalType){
				case "allPost"			: 
					goPostList("ALL");
					break;
				case "notePost"			: 
					goPostList("BC001");
					break;
				case "catalList"		: 
					goBbsCatalList();
					break;
				case "suggestMusicPost"	: 
					goPostList("BC003");
					break;
				case "sheetMusicPost"	: 
					goPostList("BC004");
					break;
				default					: 
					alert("메뉴정보없음");
					break;
			} 
		});
		
		
		$("#selAllKey").on("keydown", function(e){
			if(e.keyCode == "13"){
				searchAllPost();
			}
		});
		
	});
	
	// 검색기능
	function searchAllPost(){
		if(isNull($("#selAllKey").val())){
			alert("검색어를 입력해주세요.");
			return;
		}
		let pageNumInfo = "1";
		searchPostListForm(pageNumInfo);
	}
</script>
<header id="page-head">
	<div class="toolbar inner">
		<div class="toolbar-area">
			<div class="toolbar-area-top flex" >
				<div class="toolbar-area-top-left flex">
					<a class="home-logo" onclick="goHome()">
						<img id="home-icon" alt="홈페이지 아이콘" src="${path}/resources/images/logo/irondrum-logo_icon_mini.jpg">
					</a>
					<div id="header-search-div" class="header-search flex">
						<label id="srbLabel" class="header-search label">
							<input id="selAllKey" name="selAllKey" class="header-search input" placeholder="검색어를 입력해주세요." value="${selAllKey}"/>
						</label>
					</div>
				</div>
				<c:choose>
				<c:when test="${loginSession ne null}">
					<input type="hidden" id="loginUserId" value="${loginSession.userId}" />
					<div id="toolbar-util" class="toolbar-util">
						<!-- 로그인 화면을 드롭다운 메뉴로 변환 필요 -->
						<input type="checkbox" id="signUserMenuChk">
						<ul id="toolbar-util-ul" class="toolbar-util-ul" >
							<li class="toolbar-util-li">
								<label for="signUserMenuChk">
									<a id="signUserMenu">
										<img id="userImg" alt="userImg" src="${path}/resources/images/icons/user-info.png">
									</a>
								</label>
								<div class="sign-menu-ul-tab">
									<div id="sign-userNm">${loginSession.userNm}님 안녕하세요.</div>
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
					<input type="hidden" id="loginUserId" value="" />
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
		</div>
	</div>
	<div class="areaLine"></div>
	<div class="toolbar-mlist" >
		<ul class="toolbar-mlist-ul flex">
			<li class="toolbar-mlist-li flex" ><a class="topMenuBtn" catal-type="allPost">전체보기</a></li>
			<li class="toolbar-mlist-li flex" ><a class="topMenuBtn" catal-type="notePost">공지사항</a></li>
			<li class="toolbar-mlist-li flex" ><a class="topMenuBtn" catal-type="catalList">게시판</a></li>
			<li class="toolbar-mlist-li flex" ><a class="topMenuBtn" catal-type="suggestMusicPost">추천음악</a></li>
			<li class="toolbar-mlist-li flex" ><a class="topMenuBtn" catal-type="sheetMusicPost">악보봐</a></li>
		</ul>
	</div>
	<div class="areaLine"></div>
</header>