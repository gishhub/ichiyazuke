<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ page import="java.net.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>問題ページ</title>
</head>
<body>
<p>問題ページです。</p>
<p>nameは、

<% HashMap<String,HashMap<Integer, HashMap<String, String>>> questionHashMap = 
	(HashMap<String,HashMap<Integer, HashMap<String, String>>>) request.getAttribute("questionHashMap");

String test_choice1  = "";
String test_choice2  = "";
String test_choice3  = "";
String test_choice4  = "";
String test_answer   = "";
String test_contents = "";
String test_title    = "";

	Object[] objKey = questionHashMap.keySet().toArray();
	
	for (int i = 0; i < objKey.length; i++) {
		HashMap<Integer, HashMap<String, String>> subHashMap = questionHashMap.get(objKey[i]);
		String tmp_str = objKey[i].toString();
		

		
		if(objKey[i].toString().equals("choice1")){
			
			Object[] objKey_sub = subHashMap.keySet().toArray();

			
			for (int j = 0; j < objKey_sub.length; j++) {
				HashMap<String, String> subsubHashMap = subHashMap.get(objKey_sub[j]);
	
				Object[] objKey_subsub = subsubHashMap.keySet().toArray();
				for (int k = 0; k < objKey_subsub.length; k++) {
					if (objKey_subsub[k].equals("math")){
						test_choice1 += "<img src=\"https://chart.googleapis.com/chart?cht=tx&chl=\"" + URLEncoder.encode(subsubHashMap.get(objKey_subsub[k]), "UTF-8") + "\"/>";
					} else {
						test_choice1 += subsubHashMap.get(objKey_subsub[k]);
					}
				}
			}
		} else if(objKey[i].toString().equals("choice2")) {
			Object[] objKey_sub = subHashMap.keySet().toArray();
			
			for (int j = 0; j < objKey_sub.length; j++) {
				HashMap<String, String> subsubHashMap = subHashMap.get(objKey_sub[j]);
	
				Object[] objKey_subsub = subsubHashMap.keySet().toArray();
				for (int k = 0; k < objKey_subsub.length; k++) {
					if (objKey_subsub[k].equals("math")){
						test_choice2 += "<img src=\"https://chart.googleapis.com/chart?cht=tx&chl=" + URLEncoder.encode(subsubHashMap.get(objKey_subsub[k]), "UTF-8") + "\"/>";
					} else {
						test_choice2 += subsubHashMap.get(objKey_subsub[k]);
					}
				}
			}
		} else if(objKey[i].toString().equals("choice3")) {
			Object[] objKey_sub = subHashMap.keySet().toArray();
			
			for (int j = 0; j < objKey_sub.length; j++) {
				HashMap<String, String> subsubHashMap = subHashMap.get(objKey_sub[j]);
	
				Object[] objKey_subsub = subsubHashMap.keySet().toArray();
				for (int k = 0; k < objKey_subsub.length; k++) {
					if (objKey_subsub[k].equals("math")){
						test_choice3 += "<img src=\"https://chart.googleapis.com/chart?cht=tx&chl=" + URLEncoder.encode(subsubHashMap.get(objKey_subsub[k]),"UTF-8") + "\"/>";
					} else {
						test_choice3 += subsubHashMap.get(objKey_subsub[k]);
					}
				}
			}
		} else if(objKey[i].toString().equals("choice4")) {
			Object[] objKey_sub = subHashMap.keySet().toArray();
			
			for (int j = 0; j < objKey_sub.length; j++) {
				HashMap<String, String> subsubHashMap = subHashMap.get(objKey_sub[j]);
	
				Object[] objKey_subsub = subsubHashMap.keySet().toArray();
				for (int k = 0; k < objKey_subsub.length; k++) {
					if (objKey_subsub[k].equals("math")){
						test_choice4 += "<img src=\"https://chart.googleapis.com/chart?cht=tx&chl=" + URLEncoder.encode(subsubHashMap.get(objKey_subsub[k]), "UTF-8") + "\"/>";
					} else {
						test_choice4 += subsubHashMap.get(objKey_subsub[k]);
					}
				}
			}
		} else if(objKey[i].toString().equals("answer")) {
			Object[] objKey_sub = subHashMap.keySet().toArray();
			
			for (int j = 0; j < objKey_sub.length; j++) {
				HashMap<String, String> subsubHashMap = subHashMap.get(objKey_sub[j]);
	
				Object[] objKey_subsub = subsubHashMap.keySet().toArray();
				for (int k = 0; k < objKey_subsub.length; k++) {
					if (objKey_subsub[k].equals("math")){
						test_answer += "<img src=\"https://chart.googleapis.com/chart?cht=tx&chl=" + URLEncoder.encode(subsubHashMap.get(objKey_subsub[k]), "UTF-8") + "\"/>";
					} else {
						test_answer += subsubHashMap.get(objKey_subsub[k]);
					}
				}
			}
		} else if(objKey[i].toString().equals("title")) {
			Object[] objKey_sub = subHashMap.keySet().toArray();
			
			for (int j = 0; j < objKey_sub.length; j++) {
				HashMap<String, String> subsubHashMap = subHashMap.get(objKey_sub[j]);
	
				Object[] objKey_subsub = subsubHashMap.keySet().toArray();
				for (int k = 0; k < objKey_subsub.length; k++) {
					if (objKey_subsub[k].equals("math")){
						test_title += "<img src=\"https://chart.googleapis.com/chart?cht=tx&chl=" + URLEncoder.encode(subsubHashMap.get(objKey_subsub[k]), "UTF-8") + "\"/>";
					} else {
						test_title += subsubHashMap.get(objKey_subsub[k]);
					}
				}
			}
		} else if(objKey[i].toString().equals("contents")) {
			Object[] objKey_sub = subHashMap.keySet().toArray();
			
			for (int j = 0; j < objKey_sub.length; j++) {
				HashMap<String, String> subsubHashMap = subHashMap.get(objKey_sub[j]);
	
				Object[] objKey_subsub = subsubHashMap.keySet().toArray();
				for (int k = 0; k < objKey_subsub.length; k++) {
					if (objKey_subsub[k].equals("math")){
						test_contents += "<img src=\"https://chart.googleapis.com/chart?cht=tx&chl=" + URLEncoder.encode(subsubHashMap.get(objKey_subsub[k]), "UTF-8") + "\"/>";
					} else {
						test_contents += subsubHashMap.get(objKey_subsub[k]);
					}
				}
			}
		}
			
	}
		
%>
<%=test_answer %>

<script type='text/javascript'>
<!--
var answer = "<%=test_answer %>";
document.write(answer);

document.write("<br /><br />");
//-->
</script>

</p>
</body>
</html>