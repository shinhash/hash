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
	
	
	
	/**
	게시판 게시글 작성버튼부분 style
	*/
	#postWriteBtn{
		width: 70px;
		height: 35px;
		border: none;
		border-radius: 10px;
	}
	#postWriteBtn:hover{
		background-color: gray;
	}
</style>
<script type="text/javascript">
	$(document).ready(function (){
    	// 게시글 상세정보페이지
		$(".postInfoView").on("click", function(){
			let formInfo = document.createElement("form");
			
			let bbsCatalId = document.createElement("input");
			bbsCatalId.setAttribute("name", "bbsCatalId");
			bbsCatalId.setAttribute("type", "hidden");
			bbsCatalId.setAttribute("value", $("#boardListTable").attr("bbs-catal-id"));
			
			let bbsPostId = document.createElement("input");
			bbsPostId.setAttribute("name", "bbsPostId");
			bbsPostId.setAttribute("type", "hidden");
			bbsPostId.setAttribute("value", $(this).attr("bbs-post-id"));
			
			formInfo.appendChild(bbsCatalId);
			formInfo.appendChild(bbsPostId);
			
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
			bbsCatalId.setAttribute("value", $("#boardListTable").attr("bbs-catal-id"));
			
			formInfo.appendChild(bbsCatalId);
			
			document.body.appendChild(formInfo);
			formInfo.submit();
		});
		
		// 게시판 페이지 이동
		$(".page-navi-li").on("click", function(){
			let formInfo = document.createElement("form");
			
			let bbsCatalId = document.createElement("input");
			bbsCatalId.setAttribute("name", "bbsCatalId");
			bbsCatalId.setAttribute("type", "hidden");
			bbsCatalId.setAttribute("value", $("#boardListTable").attr("bbs-catal-id"));
			
			let bbsPostId = document.createElement("input");
			bbsPostId.setAttribute("name", "pageViewInfo");
			bbsPostId.setAttribute("type", "hidden");
			bbsPostId.setAttribute("value", $(this).attr("post-page"));
			
			formInfo.appendChild(bbsCatalId);
			formInfo.appendChild(bbsPostId);

			formInfo.setAttribute("id", "pageControllDiv");
			formInfo.setAttribute("method", "post");
			formInfo.setAttribute("action", "/board/postListView");
			document.body.appendChild(formInfo);
			formInfo.submit();
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
				<div class="contents">
					<br><br>
					<table id="boardListTable" bbs-catal-id="${bbsCatalInfo.bbsCatalId}">
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
											<td class="tdFloatCenter">${postInfo.rn}</td>
											<td class="tdFloatLeft">${postInfo.bbsPostTitle}</td>
											<td class="tdFloatLeft">${postInfo.bbsPostRegId}</td>
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
											<td class="tdFloatCenter">0</td>
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
				<input id="postWriteBtn" class="postBtn" type="button" value="글쓰기" />
				<br><br>
				<nav id="page-navi">
					<ul id="page-navi-ul">
						<c:choose>
							<c:when test="${pageTotalCnt > 0}">
								<c:forEach var="pageCnt" begin="1" end="${pageTotalCnt}" step="1">
									<c:choose>
										<c:when test="${pageCnt eq pageViewInfo}">
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
				<br>
			</div>
		</div>
	</div>
</div>