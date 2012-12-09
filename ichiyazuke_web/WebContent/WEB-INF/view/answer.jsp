<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String correctAnswer = (String)request.getAttribute("correctAnswer");
	String contents      = (String)request.getAttribute("contents");
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
body {
	font-size:80%;
	margin-left : 5.0em;
	margin-right: 5.0em;
	padding: 0.1em;
	font-family: HiraKakuProN-W3;
}
h1 { font-size: 2.5em; color: red; font-weight: bold }
h2 { font-size: 2.0em; }
h3 { font-size: 2.0em; }
p  { font-size: 1.2em; }
img {
	zoom: 200%;
	margin-bottom: -0.1em;
}
</style>
<title>解答ページ</title>
</head>
<body>
	<h1><%=judgment%></h1>
	<h2><%=title%></h2>
	<h2><%=contents%></h2>
	<h2>正解は <%=correctAnswer%> </h2>
	<h2><%=choice%></h2>
	<h3>解説</h3>
	<h3><%=explanation%></h3>
</body>
</html>