<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<style type="text/css">
	
	/**
	게시판 목록 스타일
	*/
	#bbsCatalogListDiv{
		margin: auto;
		width: 1000px;
		overflow: hidden;
		height: auto;
	}
	.catal-float{
		min-height: 100px;
	}
	.catal-float.left{
		width: 500px;
		float: left;
	}
	.catal-float.right{
		width: 500px;
		margin-left: 500px;
	}
	.bbsCatallogLine{
		width: 480px;
		border: 2px solid rgb(44, 44, 44);
	}
	.bbsCatalogInfo{
		width: 480px;
		font-size: 20px;
		font-weight: bold;
	}
	
	
	.bbsCatalogInfo{
		margin-bottom: 5px;
	}
	.bbsCatalogInfo:hover{
		cursor: pointer;
	}
	.postData{
		width: 480px;
	}
	.postData:hover{
		background-color: lightgray;
	}
	
	.bbsCatalogInfo-right{
		float: right;
	}
	
</style>
<script type="text/javascript">
	$(document).ready(function (){

		// 게시글 화면 이동
		$(".postData").on("click", function(){
			
			let formInfo = document.createElement("form");
			
			let bbsCatalId = document.createElement("input");
			bbsCatalId.setAttribute("name", "bbsCatalId");
			bbsCatalId.setAttribute("type", "hidden");
			bbsCatalId.setAttribute("value", $(this).parent().find(".bbsCatalogInfo").attr("bbs-catal-id"));
			
			let bbsPostId = document.createElement("input");
			bbsPostId.setAttribute("name", "bbsPostId");
			bbsPostId.setAttribute("type", "hidden");
			bbsPostId.setAttribute("value", $(this).find($(".bbsPostId")).val());
			
			formInfo.appendChild(bbsCatalId);
			formInfo.appendChild(bbsPostId);
			
			formInfo.setAttribute("method","post");
			formInfo.setAttribute("action","/board/postInfoView");
			document.body.appendChild(formInfo);
			formInfo.submit();
		});
		
		
		// 게시판 이동
		$(".bbsCatalogInfo").on("click", function(){
			goPostList($(this).attr('bbs-catal-id'));
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
					<div id="bbsCatalogListDiv">
						<!-- bbsCatalogList forEach -->
						<c:forEach var="bbsCatalInfo" items="${bbsCatalList}" varStatus="varIndex">
							<c:choose>
								<c:when test="${varIndex.count % 2 eq 1}">
									<!-- bbsCatalInfo 홀수 -->
									<c:if test="${varIndex.count ne 1}">
										<br>
									</c:if>
									<div class="catal-float left">
										<div class="bbsCatalogInfo" bbs-catal-id="${bbsCatalInfo.bbsCatalId}">
											<span class="bbsCatalogInfo-left">${bbsCatalInfo.bbsCatalNm}</span>
											<span class="bbsCatalogInfo-right"> ▶ </span>
										</div>
										<div class="bbsCatallogLine"></div>
										<!-- postList forEach -->
										<c:forEach var="postInfo" items="${postList}">
											<fmt:parseDate var="fmtInfo" value="${postInfo.bbsPostRegDate}" pattern="yyyyMMddHHmmss"/>
											<fmt:formatDate value="${fmtInfo}" pattern="yyyy.MM.dd" var="fmtInfoChk"/>
											<c:if test="${bbsCatalInfo.bbsCatalId eq postInfo.bbsCatalId}">
												<div class="postData">
													<input type="hidden" class="bbsPostId" name="bbsPostId" value="${postInfo.bbsPostId}" />
													<span>${postInfo.bbsPostTitle}</span>
													<span>
														<c:choose>
															<c:when test="${today eq fmtInfoChk}">
																<fmt:formatDate value="${fmtInfo}" pattern="kk:mm"/>
															</c:when>
															<c:otherwise>
																<fmt:formatDate value="${fmtInfo}" pattern="yyyy.MM.dd"/>
															</c:otherwise>
														</c:choose>
													</span>
												</div>
											</c:if>
										</c:forEach>
									</div>
								</c:when>
								<c:otherwise>
									<!-- bbsCatalInfo 짝수 -->
									<div class="catal-float right">
										<div class="bbsCatalogInfo" bbs-catal-id="${bbsCatalInfo.bbsCatalId}">
											<span class="bbsCatalogInfo-left">${bbsCatalInfo.bbsCatalNm}</span>
											<span class="bbsCatalogInfo-right"> ▶ </span>
										</div>
										<div class="bbsCatallogLine"></div>
										<!-- postList forEach -->
										<c:forEach var="postInfo" items="${postList}">
											<fmt:parseDate var="fmtInfo" value="${postInfo.bbsPostRegDate}" pattern="yyyyMMddHHmmss"/>
											<fmt:formatDate value="${fmtInfo}" pattern="yyyy.MM.dd" var="fmtInfoChk"/>
											<c:if test="${bbsCatalInfo.bbsCatalId eq postInfo.bbsCatalId}">
												<div class="postData">
													<input type="hidden" class="bbsPostId" name="bbsPostId" value="${postInfo.bbsPostId}" />
													<span>${postInfo.bbsPostTitle}</span>
													<span>
														<c:choose>
															<c:when test="${today eq fmtInfoChk}">
																<fmt:formatDate value="${fmtInfo}" pattern="kk:mm"/>
															</c:when>
															<c:otherwise>
																<fmt:formatDate value="${fmtInfo}" pattern="yyyy.MM.dd"/>
															</c:otherwise>
														</c:choose>
													</span>
												</div>
											</c:if>
										</c:forEach>
									</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</div>
					<br><br>
				</div>
				<br><br>
			</div>
		</div>
	</div>
</div>