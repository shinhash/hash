<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>IronDrum</title>
	<tiles:insertAttribute name="commonLib"/>
</head>

<body id="page-top">
	<!--  header -->
	<tiles:insertAttribute name="header" />

	<!-- Content -->
	<tiles:insertAttribute name="content" />
	
	<!-- footer -->
	<tiles:insertAttribute name="footer" />
</body>

</html>