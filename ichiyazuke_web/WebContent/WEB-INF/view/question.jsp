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
	p  { font-size: 1.0em; }
	form { font-size: 2.0em; }
-->
</style>
<script type="text/javascript"> 
<!--
function checkForm(){
	flag = 0;
	var i;
	for ( i = 0 ; i < document.choice.answer.length ; i++){
		if (document.choice.answer[i].checked){ flag = 1; }
	}
	if (!flag){
		alert('答えをいずれか選択してください');
		return false;
	}
	return true;
}
//-->
</script>
<title>問題ページ</title>
</head>
	<body>
		<h1><%=test_title%></h1>
		<h2><%=test_contents%></h2>
		<h3>1. <%=test_choice1%></h3>
		<h3>2. <%=test_choice2%></h3>
		<h3>3. <%=test_choice3%></h3>
		<h3>4. <%=test_choice4%></h3>
	<form name="choice" method="post" action="answer_question" onSubmit="return checkForm()">
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