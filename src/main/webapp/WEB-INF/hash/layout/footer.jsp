<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
	function searchPostListForm(pageNumInfo){
		// 검색용 form
		let formInfo = document.createElement("form");
		
		// 전체 검색어
		let selAllKey = $("#selAllKey").val();
		
		// 게시판 ID
		let bbsCatalInfo = $("#bbsCatalId").attr("bbs-catal-id");
		
		// 게시글 검색어
		let selSrcKey = $("#selSrcKey").val();
		// 게시글 검색조건
		let selSrcTypeInfo = $("#selSrcType").prop("selected", true).val();
		
		// 게시판 정보
		let bbsCatalId = document.createElement("input");
		bbsCatalId.setAttribute("name", "bbsCatalId");
		bbsCatalId.setAttribute("type", "hidden");
		
		if(!isNull(bbsCatalInfo) && isNull(selAllKey)){
			// 게시글 검색기능 사용시
			bbsCatalId.setAttribute("value", bbsCatalInfo);
			
			// 검색어 타입
			let srcType = document.createElement("input");
			srcType.setAttribute("name", "srcTypeInfo");
			srcType.setAttribute("type", "hidden");
			if(!isNull(selSrcTypeInfo)){
				srcType.setAttribute("value", selSrcTypeInfo);
			}else{
				srcType.setAttribute("value", "postAll");
			}
			
			// 검색어 정보
			let srcKeyword = document.createElement("input");
			srcKeyword.setAttribute("name", "selSrcKey");
			srcKeyword.setAttribute("type", "hidden");
			if(!isNull(selSrcKey)){
				srcKeyword.setAttribute("value", selSrcKey);
			}else{
				srcKeyword.setAttribute("value", "");
			}
			formInfo.appendChild(srcType);
			formInfo.appendChild(srcKeyword);
			
		}else if(!isNull(selAllKey) || isNull(bbsCatalInfo)){
			// 전체 검색기능 사용시
			bbsCatalInfo = "ALL";
			bbsCatalId.setAttribute("value", bbsCatalInfo);
			
			// 전체 검색어 입력했을 경우
			if(!isNull(selAllKey)){
				// 검색어 정보
				let srcKeyword = document.createElement("input");
				srcKeyword.setAttribute("name", "selAllKey");
				srcKeyword.setAttribute("type", "hidden");
				srcKeyword.setAttribute("value", selAllKey);
				formInfo.appendChild(srcKeyword);
			}
		}
		formInfo.appendChild(bbsCatalId);
		
		// 페이지번호
		let pageNum = document.createElement("input");
		pageNum.setAttribute("name", "pageNumInfo");
		pageNum.setAttribute("type", "hidden");
		pageNum.setAttribute("value", pageNumInfo);
		
		formInfo.appendChild(pageNum);
	
		formInfo.setAttribute("id", "pageControllDiv");
		formInfo.setAttribute("method", "post");
		formInfo.setAttribute("action", "/board/postListView");
		document.body.appendChild(formInfo);
		formInfo.submit();
	}
</script>
<footer id="page-foot">
	<div class="bottomBanner lineTopBottomDiv"></div>			
	<div class="footer-div">
		<div class="footerInner">
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