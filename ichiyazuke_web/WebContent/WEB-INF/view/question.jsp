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
	margin-left : 5.0em;
	margin-right: 5.0em;
	padding: 0.1em;
	font-family: HiraKakuProN-W3;
}
h1 { font-size: 2.5em; }
h2 { font-size: 2.0em; }
h3 { font-size: 2.0em; }
p  { font-size: 1.2em; }
img {
	zoom: 200%;
	margin-bottom: -0.1em;
}
div.radio-group {
	margin-bottom: -0.1em;
}
div.radio-group div {
	position: relative;
}
div.radio-group input {
	position: absolute;
	left: 0px;
	outline:none;
}
div.radio-group label {
	cursor: pointer;
	font-size: 3.0em;
	padding: 0.1em 0.2em;
	float: left;
	border: solid 1px #aaa;
	margin-left: -1px;
	background: #eee;
	background-image: -moz-linear-gradient(top, #F6F6F6, #ccc);
	background-image: -webkit-gradient(linear, left top, left bottom, from(#F6F6F6), to(#ccc));
	-moz-box-shadow: 2px 2px 6px #ddd;
	-webkit-box-shadow: 2px 2px 6px #ddd;
	text-shadow: 1px 1px 0px #fff;
}
div.radio-group div:first-child label {
	-webkit-border-top-left-radius: 7px;
	-webkit-border-bottom-left-radius: 7px;
	-moz-border-radius-topleft: 7px;
	-moz-border-radius-bottomleft: 7px;
}
div.radio-group div:last-child label {
	-webkit-border-top-right-radius: 7px;
	-webkit-border-bottom-right-radius: 7px;
	-moz-border-radius-topright: 7px;
	-moz-border-radius-bottomright: 7px;
}
div.radio-group label.checked {
	color: #fff;
	background: #C3C3C3;
	background-image: -moz-linear-gradient(top, #C3C3C3, #DBDBDB);
	background-image: -webkit-gradient(linear, left top, left bottom, from(#C3C3C3), to(#DBDBDB));
	text-shadow: 0px 0px 0px #fff;
}
input.submit_button {
	padding: 0.3em 0.5em;
	font-size: 1.5em;
	widht: 100px;
	height: 40px;
	background-color: #000080;
	color: #FFFFFF;
	border-style: none;
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
		<h1><%=title%></h1>
		<h2><%=contents%></h2><br />
		<h3>1. <%=choice1%></h3>
		<h3>2. <%=choice2%></h3>
		<h3>3. <%=choice3%></h3>
		<h3>4. <%=choice4%></h3>
	<form name="choice" method="post" action="answer_question" onSubmit="return checkForm()">
	<div class="radio-group clearfix">
		<div>
			<input id="Radio1" type="radio" class="radio" name="answer" value="1" />
			<label for="Radio1">1</label>
		</div>
		<div>
			<input id="Radio2" type="radio" class="radio" name="answer" value="2" />
			<label for="Radio2">2</label>
		</div>
		<div>
			<input id="Radio3" type="radio" class="radio" name="answer" value="3" />
			<label for="Radio3">3</label>
		</div>
		<div>
			<input id="Radio4" type="radio" class="radio" name="answer" value="4" />
			<label for="Radio4">4</label>
		</div>
	</div>
	<input type="hidden" name="questionId" value="<%=question_id%>">
	<br /><br /><br /><br /><br /><br />
	<div class="submit_button">
	<input class="submit_button" type="submit" value="解答">
	</div>
	</form>
</body>
</html>