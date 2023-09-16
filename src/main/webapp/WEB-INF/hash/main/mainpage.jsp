<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<style type="text/css">
	.contents-item{
		width: 150px;
		height: 150px;
	}
	#rollBanDiv{
		margin: auto;
	}
	#ipCheckTemp{
		display: none;
	}
</style>
<script>
	$(document).ready(function (){
		fnRollBanner();
	});
	function fnRollBanner(){
		// DB에서 배너이미지정보 조회
		//var tempBannerArr = ["rolling-banner-01", "rolling-banner-02", "rolling-banner-03"];
		$(".rolling-banner-div").css("background-color", "rgb(44,44,44)");
		$(".rolling-banner-div").css("height", "250px");
		$(".rolling-banner-div").css("width", "100%");
		$(".rolling-banner-div").css("min-width", "1360px");
		$(".rolling-banner-div").css("margin-bottom", "5px");
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
		$("#rollImg").css("margin-top", "10px");
		$("#rollImg").css("margin-bottom", "10px");
		$("#rollImg").css("height", "230px");
		$("#rollImg").attr("class", bannerClass);
		setTimeout(fnRollBanner, 10000);
	}
</script>
<div id="root" class="root">
	<div id="ipCheckTemp">loginIP : ${loginSession.loginIp}</div>
	<div></div>
	<div id="page-body">
		<div class="rolling-banner-div">
			<div class="wrap">
				<div class="roller">
					<ul>
						<li class="banner flex" >
							<div id="rollBanDiv">
								<img id="rollImg" class="rollban-01" src="${path}/resources/images/banner/roll-banner-01.jpg" />
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="body-contents">
			<div class="inner">
				<div class="contents">
					<div class="contents-item">
						<div class="mp-item-info">
							<a href="#" class="item-link"></a>
							<div class="item-img">
								<img style="width: 100px; height: 100px;" alt="드럼이미지" src="${path}/resources/images/banner/roll-banner-01.jpg">
							</div>
							<div class="item-title">
								콘텐츠 1
							</div>
							<div class="item-cont">
								이 콘텐츠를 클릭시 페이지가 이동됩니다.
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>