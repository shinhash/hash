<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<style type="text/css">
	/**
	게시판 목록부분 style
	*/
	#boardListTable{
		margin: 0 auto;
		width: 90%;
		border-collapse: collapse;
	}
	.tdFloatCenter{
		text-align: center;
	}
	.tdFloatLeft{
		text-align: left;
	}
	.theadBottomLine,.tbodyBottomLine{
		border-bottom: 2px solid rgb(44,44,44);
	}
	.trBottomLine{
		border-bottom: 1px solid gray;
	}
	.postInfoView{
		height: 45px;
	}
	.postInfoView:hover {
		background-color: lightgray;
	}
	.postBtn{
		float: right;
		margin-right: 60px;
		width: 60px;
		height: 30px;
	}
	.boardName{
		margin: 0 auto;
		width: 90%;
	}
	
	
	/**
	게시글 리스트 가로길이
	*/
	.postNo{
		width: 5%;
	}
	.postTitle{
		width: 70%;
	}
	.postWriter{
		width: 10%;
	}
	.postDate{
		width: 5%;
	}
	.postView{
		width: 5%;
	}
	.postLike{
		width: 5%;
	}
	
	
	
	/**
	게시판 페이지네이션 버튼부분 style
	*/
	#navi-div{
		margin-top: 80px;
	}
	#page-navi{
		text-align: center;
		font-size: 20px;
		align-content: center;
	}
	#page-navi-ul{
		list-style: none;
		text-align: center;
	}
	.page-navi-li{
		display: inline;
		box-shadow: 1px 0 0 0 #aaa, 0 1px 0 0 #aaa, 1px 0 0 0 #aaa inset, 0 1px 0 0 #aaa inset, 1px 1px 0 0 #aaa;
	}
	.page-navi-li:hover{
		background-color: lightgray;
	}
	.page-navi-link{
		display: table-cell;
		text-decoration: none;
		text-align: center;
		width: 30px;
	}
	.page-act{
		background-color: lightgray;
		pointer-events : none;
	}
	
	
	
	/* 게시글 검색바 */
	#postListBottomDiv{
		margin: 0 auto;
		float: right;
		margin-right: 60px;
	}
	#selPostSrcDiv{
		height: 30px;
		width: 400px;
		display: inline;
	}
	#selSrcType{
		height: 35px;
		width: 85px;
		margin-right: -1px;
		border: 1px solid gray;
 		border-radius: 10px 0px 0px 10px;
		float: left;
		box-sizing: border-box;
	}
	#selSrcKey{
		height: 35px;
		width: 200px;
		margin-right: -1px;
		border: 1px solid gray;
		float: left;
		box-sizing: border-box;
		padding-left: 10px;
		padding-right: 10px;
		
		/* apple 제품 input style 대응 */
		appearance: none;
		-webkit-appearance: none;
		-webkit-border-radius: 0;
	}
	#selSrcbtn{
		height: 35px;
		width: 50px;
 		border: 1px solid gray;
 		border-radius: 0px 10px 10px 0px;
 		color: black;
		font-size: 15px;
 		background-color: white;
 		box-sizing: border-box;
	}
	#selSrcbtn:hover{
 		background-color: lightgray;
	}
	#selSrcbtn:active{
 		background-color: #bbb;
	}
	
	
	
	/**
	게시판 게시글 작성버튼부분 style
	*/
	#postWriteBtn{
		width: 65px;
		height: 35px;
		float: right;
		border: none;
		border-radius: 10px;
		color: white;
		font-weight: bold;
		background-color: #9147ff;
		margin-left: 10px;
	}
	#postWriteBtn:hover{
		background-color: #772ce8;
	}
	#postWriteBtn:active{
		background-color: #5c16c5;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
    	// 게시글 상세정보페이지
		$(".postInfoView").on("click", function(){
			let formInfo = document.createElement("form");
			
			let bbsCatalId = document.createElement("input");
			bbsCatalId.setAttribute("name", "bbsCatalId");
			bbsCatalId.setAttribute("type", "hidden");
			bbsCatalId.setAttribute("value", $("#bbsCatalId").attr("bbs-catal-id"));
			
			let bbsPostId = document.createElement("input");
			bbsPostId.setAttribute("name", "bbsPostId");
			bbsPostId.setAttribute("type", "hidden");
			bbsPostId.setAttribute("value", $(this).attr("bbs-post-id"));
			
			let selSrcKey = document.createElement("input");
			selSrcKey.setAttribute("name", "selSrcKey");
			selSrcKey.setAttribute("type", "hidden");
			selSrcKey.setAttribute("value", $("#selSrcKey").val());
			
			let srcTypeInfo = document.createElement("input");
			srcTypeInfo.setAttribute("name", "srcTypeInfo");
			srcTypeInfo.setAttribute("type", "hidden");
			srcTypeInfo.setAttribute("value", $("#selSrcType").prop("selected", true).val());
			
			formInfo.appendChild(bbsCatalId);
			formInfo.appendChild(bbsPostId);
			formInfo.appendChild(selSrcKey);
			formInfo.appendChild(srcTypeInfo);
			
			formInfo.setAttribute("method","post");
			formInfo.setAttribute("action","/board/postInfoView");
			document.body.appendChild(formInfo);
			formInfo.submit();
		});
		
    	// 게시글 작성페이지
		$("#postWriteBtn").on("click", function(){
			
			let formInfo = document.createElement("form");
			formInfo.setAttribute("method","post");
			formInfo.setAttribute("action","/board/postRegistView");
			
			let bbsCatalId = document.createElement("input");
			bbsCatalId.setAttribute("name", "bbsCatalId");
			bbsCatalId.setAttribute("type", "hidden");
			bbsCatalId.setAttribute("value", $("#bbsCatalId").attr("bbs-catal-id"));
			
			formInfo.appendChild(bbsCatalId);
			
			document.body.appendChild(formInfo);
			formInfo.submit();
		});
    	
    	$(".boardName").on("click", function(){
    		// 검색용 form
    		let formInfo = document.createElement("form");
    		
    		// 게시판 정보
    		let bbsCatalId = document.createElement("input");
    		bbsCatalId.setAttribute("name", "bbsCatalId");
    		bbsCatalId.setAttribute("type", "hidden");
    		bbsCatalId.setAttribute("value", $("#bbsCatalId").attr("bbs-catal-id"));
    		formInfo.appendChild(bbsCatalId);
    		
    		formInfo.setAttribute("id", "pageControllDiv");
    		formInfo.setAttribute("method", "post");
    		formInfo.setAttribute("action", "/board/postListView");
    		document.body.appendChild(formInfo);
    		formInfo.submit();
    	});
    	
    	// 게시글 검색 버튼 클릭
    	$("#selSrcbtn").on("click", function(){
    		srcPostList();
    	});
    	// 게시글 검색 입력 후 엔터
    	$("#selSrcKey").on("keydown", function(e){
    		if(e.keyCode == "13"){
    			srcPostList();
			}
    	});
    	
    	// 게시글 검색
    	function srcPostList(){
    		if(isNull($("#selSrcKey").val())){
    			alert("검색어를 입력해주세요.");
    			return;
    		}
    		let pageNumInfo = "1";
    		searchPostListForm(pageNumInfo);
    	}
		
		// 게시판 페이지 이동
		$(".page-navi-li").on("click", function(){
			let pageNumInfo = $(this).attr("post-page");
			searchPostListForm(pageNumInfo);
		});
	});
</script>
<div id="root" class="root">
	<jsp:useBean id="today" class="java.util.Date" />
	<fmt:formatDate value="${today}" pattern="yyyy.MM.dd" var="today"/>
	<div></div>
	<div id="page-body">
		<br>
		<div class="body-contents">
			<div class="inner">
				<h1 class="boardName">${bbsCatalInfo.bbsCatalNm}</h1>
				<div class="contents">
					<br><br>
					<div id="bbsCatalId" bbs-catal-id="${bbsCatalInfo.bbsCatalId}"></div>
					<table id="boardListTable">
						<thead class="theadBottomLine">
							<tr>
								<th class="tdFloatCenter postNo">번호</th>
								<th class="tdFloatLeft postTitle">제목</th>
								<th class="tdFloatLeft postWriter">작성자</th>
								<th class="tdFloatCenter postDate">작성일</th>
								<th class="tdFloatCenter postView">조회수</th>
								<th class="tdFloatCenter postLike">추천수</th>
							</tr>
						</thead>
						<tbody class="tbodyBottomLine">
							<c:choose>
								<c:when test="${postList ne null and postList.size() > 0}">
									<c:forEach var="postInfo" items="${postList}" >
										<tr class="postInfoView trBottomLine" bbs-post-id="${postInfo.bbsPostId}"> 
											<td class="tdFloatCenter">${postInfo.pageRn}</td>
											<td class="tdFloatLeft">
												${postInfo.bbsPostTitle}
												[${postInfo.postRepleCnt}]
											</td>
											<td class="tdFloatLeft">${postInfo.bbsPostWriter}</td>
											<td class="tdFloatCenter">
												<fmt:parseDate var="fmtInfo" value="${postInfo.bbsPostRegDate}" pattern="yyyyMMddHHmmss"/>
												<fmt:formatDate value="${fmtInfo}" pattern="yyyy.MM.dd" var="fmtInfoChk"/>
												<c:choose>
													<c:when test="${today eq fmtInfoChk}">
														<fmt:formatDate value="${fmtInfo}" pattern="kk:mm"/>
													</c:when>
													<c:otherwise>
														<fmt:formatDate value="${fmtInfo}" pattern="yyyy.MM.dd"/>
													</c:otherwise>
												</c:choose>
											</td>
											<td class="tdFloatCenter">${postInfo.bbsViewCnt }</td>
											<td class="tdFloatCenter">0</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr><td colspan="6">no data</td></tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<br><br>
				<c:if test="${bbsCatalInfo.bbsCatalId ne 'ALL'}">
					<div id="postListBottomDiv">
						<div id="selPostSrcDiv">
							<select id="selSrcType">
								<option value="postAll" 
									<c:if test="${srcTypeInfo eq 'postAll' or srcTypeInfo eq null or srcTypeInfo eq ''}">selected</c:if>
								>전체</option>
								<option value="postTitleContent" 
									<c:if test="${srcTypeInfo eq 'postTitleContent'}">selected</c:if>
								>제목/내용</option>
								<option value="bbsPostRegId" 
									<c:if test="${srcTypeInfo eq 'bbsPostRegId'}">selected</c:if>
								>작성자</option>
							</select>
							<input type="text" id="selSrcKey" name="selSrcKey" value="${selSrcKey}">
							<input type="button" id="selSrcbtn" value="검색">
						</div>
						<c:if test="${loginSession.userId ne null and bbsCatalInfo.bbsCatalId ne 'ALL'}">
							<input id="postWriteBtn" type="button" value="글쓰기" />
						</c:if>
					</div>
				</c:if>
				<div id="navi-div">
					<nav id="page-navi">
						<ul id="page-navi-ul">
							<c:choose>
								<c:when test="${pageTotalCnt > 0}">
									<c:forEach var="pageCnt" begin="1" end="${pageTotalCnt}" step="1">
										<c:choose>
											<c:when test="${pageCnt eq pageNumInfo}">
											<li class="page-navi-li page-act" post-page="${pageCnt}">
												<a class="page-navi-link">${pageCnt}</a>
											</li>
											</c:when>
											<c:otherwise>
											<li class="page-navi-li" post-page="${pageCnt}">
												<a class="page-navi-link">${pageCnt}</a>
											</li>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<li class="page-navi-li page-act" post-page="1">
										<a class="page-navi-link">1</a>
									</li>
								</c:otherwise>
							</c:choose>
						</ul>
					</nav>
				</div>
				<br>
			</div>
		</div>
	</div>
</div>