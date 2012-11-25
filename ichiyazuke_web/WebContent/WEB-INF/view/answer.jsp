<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String correctAnswer = (String)request.getAttribute("correctAnswer");
	String title         = (String)request.getAttribute("title");
	String choice        = (String)request.getAttribute("choice");
	String judgment      = (String)request.getAttribute("judgment");
	String explanation   = (String)request.getAttribute("explanation");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
<!--
	body {
		font-size:80%;
		margin-left : 3.0em;
		margin-right: 3.0em;
		padding: 0.1em;
		font-family: HiraKakuProN-W3;
	}
	h1 { font-size: 2.0em; }
	h2 { font-size: 1.5em; }
	h3 { font-size: 1.2em; }
	h3 { font-size: 1.0em; }
	p  { font-size: 1.0em; }
-->
</style>
<title>解答ページ</title>
</head>
<body>
	<p><%=title%></p>
	<h1><%=judgment%></h1>
	<h2>正解は <%=correctAnswer%> </h2>
	<h3><%=choice%></h3>
	<h4>解説</h4>
	<p><%=explanation%></p>
</body>
</html>