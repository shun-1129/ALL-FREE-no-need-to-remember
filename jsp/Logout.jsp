<%@ page import="saves.Account_data_SAVE"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<jsp:useBean id="User_ID_SAVE" scope="session" class="saves.Account_data_SAVE"/>
<%
	User_ID_SAVE = (Account_data_SAVE)session.getAttribute("User_ID_SAVE");
	
	session.removeAttribute("User_ID_SAVE");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	さようなら<%= User_ID_SAVE.getDATA_User_ID() %>
	
	<br>
	<a href="/ALLFREE/html/ALLFREE_index.html">さようなら</a>
</body>
</html>