<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	int question_id      = (Integer)request.getAttribute("questionId");
	String test_title    = (String)request.getAttribute("test_title");
	String test_contents = (String)request.getAttribute("test_contents");
	String test_choice1  = (String)request.getAttribute("test_choice1");
	String test_choice2  = (String)request.getAttribute("test_choice2");
	String test_choice3  = (String)request.getAttribute("test_choice3");
	String test_choice4  = (String)request.getAttribute("test_choice4");
	String test_answer   = (String)request.getAttribute("test_answer");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/style.css" type="text/css" />
<title>問題ページ</title>
</head>
	<body>
		<h1><%=test_title%></h1>
		<h2><%=test_contents%></h2>
		<h3>1. <%=test_choice1%></h3>
		<h3>2. <%=test_choice2%></h3>
		<h3>3. <%=test_choice3%></h3>
		<h3>4. <%=test_choice4%></h3>
	<form method="post" action="answer_question">
	<p>
		<input type="hidden" name="questionId" value="<%=question_id%>">
		<input type="radio" name="answer" value="1">1
		<input type="radio" name="answer" value="2">2
		<input type="radio" name="answer" value="3">3
		<input type="radio" name="answer" value="4">4
	</p>
	<p><input type="submit" value="解答"></p>
	</form>
</body>
</html>