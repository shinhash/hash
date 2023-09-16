<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		Hello web project!!!!
		<br>
		현재 서버에 로그인한 유저	
	</div>
	<div>
		<br>
		<br>
		<br>
		<table border="1" style="width: 500px;">
			<tr>
				<th style="width: 60%;">아이디</th>
				<th style="width: 10%;">이름</th>
				<th style="width: 30%;">접속IP</th>
			</tr>
			<c:choose>
				<c:when test="${applicationScope.userList ne null and applicationScope.userList.size() > 0 }">
					<c:forEach  var="userInfo" items="${applicationScope.userList }">
						<tr>
							<td>${userInfo.userId}</td>
							<td>${userInfo.userNm}</td>
							<td>${userInfo.loginIp}</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="3" style="text-align: center;">로그인 유저 없음</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
	</div>
</body>
</html>