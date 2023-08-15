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
	    
	    <style type="text/css">   	
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
	    	.theadBottomLine{
	    		border-bottom: 2px solid rgb(44,44,44);
	    	}
	    	.trBottomLine{
	    		border-bottom: 1px solid gray;
	    	}
	    	.tbodyBottomLine{
	    		border-bottom: 2px solid rgb(44,44,44);
	    	}
	    	.postInfoVIew{
	    		height: 50px;
	    	}
	    	.postInfoVIew:hover {
				background-color: lightgray;
			}
			.postBtn{
				float: right;
				margin-right: 60px;
				width: 60px;
	    		height: 30px;
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
	    </style>
	    <script>
	    	$(document).ready(function (){
		    	// 게시글 상세정보페이지
				$(".postInfoVIew").on("click", function(){
					let formInfo = document.createElement("form");
					
					let bbsPostId = document.createElement("input");
					bbsPostId.setAttribute("name", "bbsPostId");
					bbsPostId.setAttribute("value", $(this).attr("bbs-post-id"));
					formInfo.appendChild(bbsPostId);
					
					formInfo.setAttribute("method","post");
					formInfo.setAttribute("action","/board/postInfoView");
					document.body.appendChild(formInfo);
					formInfo.submit();
				});
				
		    	// 게시글 작성페이지
				$("#postWrite").on("click", function(){
					let formInfo = document.createElement("form");
					formInfo.setAttribute("method","post");
					formInfo.setAttribute("action","/board/postRegistView");
					document.body.appendChild(formInfo);
					formInfo.submit();
				});
				
				// 게시글 수정페이지
				$("#postModify").on("click", function(){
					let formInfo = document.createElement("form");
					
					let bbsPostId = document.createElement("input");
					bbsPostId.setAttribute("name", "bbsPostId");
					bbsPostId.setAttribute("type", "hidden");
					bbsPostId.setAttribute("value", $("#boardPostTable").attr("bbs-post-id"));
					formInfo.appendChild(bbsPostId);
									
					formInfo.setAttribute("method","post");
					formInfo.setAttribute("action","/board/postModifyView");
					document.body.appendChild(formInfo);
					formInfo.submit();
				});
				
				// 게시판 페이지 이동
				$(".page-navi-li").on("click", function(){
					let formInfo = document.createElement("form");
					
					let bbsPostId = document.createElement("input");
					bbsPostId.setAttribute("name", "pageViewInfo");
					bbsPostId.setAttribute("type", "hidden");
					bbsPostId.setAttribute("value", $(this).attr("post-page"));
					formInfo.appendChild(bbsPostId);
					
					formInfo.setAttribute("id", "pageControllDiv");
					formInfo.setAttribute("method", "post");
					formInfo.setAttribute("action", "/board/postList");
					document.body.appendChild(formInfo);
					formInfo.submit();
				});
	    	});
	    </script>
	    
	</head>
	<body>
		<div id="root" class="root">
			<div></div>
			<div id="page-body">
				<br>
				<div class="body-contents">
					<div class="inner">
						<div class="contents">
							<br><br>
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
										<c:when test="${postList == null}">
											<tr><td colspan="6">no data</td></tr>
										</c:when>
										<c:otherwise>
											<c:forEach var="postInfo" items="${postList}" >
												<tr class="postInfoVIew trBottomLine" bbs-post-id="${postInfo.bbsPostId}"> 
													<td class="tdFloatCenter">${postInfo.rn}</td>
													<td class="tdFloatLeft">${postInfo.bbsPostTitle}	</td>
													<td class="tdFloatLeft">${postInfo.bbsPostRegId}</td>
													<td class="tdFloatCenter">
														<fmt:parseDate var="fmtInfo" value="${postInfo.bbsPostRegDate}" pattern="yyyyMMddHHmmss"/>
														<fmt:formatDate value="${fmtInfo}" pattern="yyyy-MM-dd HH:mm:ss"/>
													</td>
													<td class="tdFloatCenter">0</td>
													<td class="tdFloatCenter">0</td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
						<br><br>
						<input id="postWrite" class="postBtn" type="button" value="글쓰기" />
						<br><br>
						<nav id="page-navi">
							<ul id="page-navi-ul">
								<c:forEach var="pageCnt" begin="1" end="${pageTotalCnt}" step="1">
								<c:choose>
									<c:when test="${pageCnt eq pageViewInfo}">
									<li class="page-navi-li page-act" id="post-page-${pageCnt}" post-page="${pageCnt}">
										<a class="page-navi-link">${pageCnt}</a>
									</li>
									</c:when>
									<c:otherwise>
									<li class="page-navi-li" id="post-page-${pageCnt}" post-page="${pageCnt}">
										<a class="page-navi-link">${pageCnt}</a>
									</li>
									</c:otherwise>
								</c:choose>
								</c:forEach>
							</ul>
						</nav>
						<br><br>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>