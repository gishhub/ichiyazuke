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
	margin : 0.0em 5.0em 10.0em;
	padding: 0.5em 0.5em 10.0em;
	font-family: HiraKakuProN-W3;
}
h1 { font-size: 5em; color: red; font-weight: bold }
h2 { font-size: 2em; }
h3 { font-size: 2em; }
h4 { font-size: 3em; color: blue; font-weight: bold }
p  { font-size: 1.2em; }
img {
	zoom: 200%;
	margin-bottom: -0.1em;
}
</style>
<title><%=title%></title>
</head>
<body>
	<h1><%=judgment%></h1>
	<h4>問題</h4>
	<table border="1" width="800">
	<tr>
	<td><h2><%=contents%></h2></td>	
	</tr>
	</table>
	<h4>正解</h4>
	<table border="1" width="800">
	<tr>
	<td><h2><%=correctAnswer%>. <%=choice%></h2></td>
	</tr>
	</table>
	<h4>解説</h4>
        <table border="1" width="800">
        <tr>
	<td><h2><%=explanation%></h2></td>
        </tr>
        </table>
</body>
</html>
