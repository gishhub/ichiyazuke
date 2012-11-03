<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>問題ページ</title>
</head>
<body>
	<p>問題ページです。</p>
	<p>
		nameは、

		<%
		String test_choice1  = (String)request.getAttribute("test_choice1");
		String test_choice2  = (String)request.getAttribute("test_choice2");
		String test_choice3  = (String)request.getAttribute("test_choice3");
		String test_choice4  = (String)request.getAttribute("test_choice4");
		String test_answer   = (String)request.getAttribute("test_answer");
		String test_contents = (String)request.getAttribute("test_contents");
		String test_title    = (String)request.getAttribute("test_title");
		
		%>


		<%=test_choice1%>
		<br>
		<%=test_choice2%>
		<br>
		<%=test_choice3%>
		<br>
		<%=test_choice4%>
		<br>
		<%=test_answer%>
		<br>
		<%=test_contents%>
		<br>
		<%=test_title%>
	</p>
</body>
</html>