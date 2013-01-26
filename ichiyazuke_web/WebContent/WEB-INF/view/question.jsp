<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	int question_id = (Integer)request.getAttribute("questionId");
	String title    = (String)request.getAttribute("title");
	String contents = (String)request.getAttribute("contents");
	String choice1  = (String)request.getAttribute("choice1");
	String choice2  = (String)request.getAttribute("choice2");
	String choice3  = (String)request.getAttribute("choice3");
	String choice4  = (String)request.getAttribute("choice4");
	String answer   = (String)request.getAttribute("answer");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
body {
	margin : 0.0em 5.0em 10.0em;
	padding: 0.5em 0.5em 10.0em;
	font-family: HiraKakuProN-W3;
}
h1 { font-size: 3em; font-weight: bold }
<! h1 { font-size: 3em; font-weight: bold; border-bottom:double 3px } >
h2 { font-size: 2em; font-weight: bold }
h3 { font-size: 2em; }
h4 { font-size: 3em; color: blue; font-weight: bold }
p  { font-size: 1.2em; }
img {
	zoom: 200%;
	margin-bottom: -0.1em;
}
div.radio-group {
	margin-bottom: -0.1em;
	border-top: transparent 5.0em solid;
	border-bottom: transparent 15.0em solid;
}
div.radio-group div {
	position: relative;
}
div.radio-group input {
	display: none;
}
div.radio-group label {
	cursor: pointer;
	font-size: 3.0em;
	font-weight: bold;
	padding: 0.5em 1.5em;
	float: left;
	border: solid 1px #AAAAAA;
	background: #EEEEEE;
	background-image: -webkit-gradient(linear, left top, left bottom, from(#F6F6F6), to(#C0C0C0));
	-webkit-box-shadow: 2px 2px 6px #DDDDDD;
	text-shadow: 1px 1px 0px #FFFFFF;
}
div.radio-group div:first-child label {
	-webkit-border-top-left-radius: 0.5em;
	-webkit-border-bottom-left-radius: 0.5em;
}
div.radio-group div:last-child label {
	-webkit-border-top-right-radius: 0.5em;
	-webkit-border-bottom-right-radius: 0.5em;
}
div.radio-group label.checked {
	color: #FFFFFF;
	background: #C3C3C3;
	background-image: -webkit-gradient(linear, left top, left bottom, from(#C3C3C3), to(#DBDBDB));
	text-shadow: 0px 0px 0px #FFFFFF;
}
input.submit_button {
	margin-top: 0.1em;
	padding: 0.5em;
	font-size: 2.5em;
	widht: 300px;
	height: 200px;
	background-color: #333333;
	color: #FFFFFF;
	border: none;
}
</style>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	var radio = $('div.radio-group');
	$('input', radio).css({'opacity': '0'});
	$('label', radio).click(function() {
		$(this).parent().parent().each(function() {
			$('label',this).removeClass('checked');	
		});
		$(this).addClass('checked');
	});
});

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
</script>
<title><%=title%></title>
</head>
	<body>
		<h4>問題</h4>
		<table border="1" width="800">
		<tr>
		<td><h2><%=contents%></h2></td>
		</tr>
		</table><br>
		<h4>選択肢</h4>
		<table border="1" width="800">
		<tr>
		<td><h3>1. <%=choice1%></h3>
		<h3>2. <%=choice2%></h3>
		<h3>3. <%=choice3%></h3>
		<h3>4. <%=choice4%></h3></td>
		</tr>
		</table>
	<form name="choice" method="post" action="answer_question" onSubmit="return checkForm()">
	<div class="radio-group clearfix">
		<div>
			<input id="radio1" type="radio" class="radio" name="answer" value="1" />
			<label for="radio1"> 1 </label>
		</div>
		<div>
			<input id="radio2" type="radio" class="radio" name="answer" value="2" />
			<label for="radio2"> 2 </label>
		</div>
		<div>
			<input id="radio3" type="radio" class="radio" name="answer" value="3" />
			<label for="radio3"> 3 </label>
		</div>
		<div>
			<input id="radio4" type="radio" class="radio" name="answer" value="4" />
			<label for="radio4"> 4 </label>
		</div>
	</div>
	<input type="hidden" name="questionId" value="<%=question_id%>">
	<div class="submit_button">
		<input class="submit_button" type="submit" value="解答">
	</div>
	</form>
</body>
</html>
