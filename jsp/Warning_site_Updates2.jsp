<%@ page import="saves.Account_data_SAVE" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="User_ID_SAVE" scope="request" class="saves.Account_data_SAVE"/>

<%
	request.setCharacterEncoding("UTF-8");

	User_ID_SAVE = (Account_data_SAVE)session.getAttribute("User_ID_SAVE");
	String User_ID = User_ID_SAVE.getDATA_User_ID();
	
	boolean FLAG = false;
	if(User_ID_SAVE.getDATA_User_ID() == null) {
		response.sendRedirect("../jsp/ALLFREE_index.jsp");
	} else {
		FLAG = true;
	}
	

	String site_name_old = request.getParameter("site_name_old");
	String site_name = request.getParameter("site_name");
	String site_url = request.getParameter("site_url");
	String site_User_ID = request.getParameter("User_ID");
	String site_User_PW = request.getParameter("User_PW");
	String page_type = request.getParameter("page_type");
%>

<% if(FLAG == true) { %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" http-equiv="content-type" content="text/html;width=device-width,initial-scale=1.0,minimum-scale=1.0;charset=utf-8">
		<title>Warning_site_Updates</title>
		
		<link rel="stylesheet" type="text/css" href="../css/ALLFREE_all.css">
		<link rel="stylesheet" type="text/css" href="../css/hamburger_menu.css">
		<link rel="stylesheet" type="text/css" href="../css/working_updatas.css">
		<link rel="stylesheet" type="text/css" href="../css/btn_design.css">
		<link rel="stylesheet" type="text/css" href="../css/Warning_site_Updates_modal.css">
		<link rel="stylesheet" type="text/css" href="../css/Warning_site_Updatas.css">
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script type="text/javascript" src="../jQuery/jQuery_hamburger_menu.js"></script>
		<script type="text/javascript" src="../Ajax/javascript_Ajax/Ajax_Site_Update.js"></script>
		<script type="text/javascript" src="../jQuery/jQuery_site.js"></script>
		
		<script type="text/javascript" src="../Ajax/javascript_Ajax/Logout_Ajax.js"></script>
		
	</head>
	<body>
	
		<header>
			<div class="hamburger">
				<span></span>
				<span></span>
				<span></span>
			</div>
			<div id="header2"><h1>ようこそ <%= User_ID %>さん</h1></div>
		</header>
		
		<nav class="globalMenuSp">
			<ul>
				<li><a href="./ALLFREE_toppage.jsp">TOPページに戻る</a></li>
				<li><a href="./site_list.jsp">サイト一覧</a></li>
				<li><a href="./card_list.jsp">カード一覧</a></li>
				<li><a href="./New_site_Reg.jsp">サイト登録</a></li>
				<li><a href="./New_card_Reg.jsp">カード登録</a></li>
				<li><a href="#">設定</a></li>
				<li><a href="./ALLFREE_index.jsp" id="LogOut">ログアウト</a></li>
			</ul>
		</nav>
		
		<input type="hidden" id="site_name_old" value="<%= site_name_old %>">
		<input type="hidden" id="site_name" value="<%= site_name %>">
		<input type="hidden" id="site_url" value="<%= site_url %>">
		<input type="hidden" id="site_User_ID" value="<%= site_User_ID %>">
		<input type="hidden" id="site_User_PW" value="<%= site_User_PW %>">
		<input type="hidden" id="page_type" value="<%= page_type %>">
		
		<div id="main_div">
		
			<table>
			
				<tr>
					<td colspan="2">サイト名</td>
				</tr>
			
				<tr>
					<td colspan="2">
						<p><%= site_name %></p>
					</td>
				</tr>
			
				<tr>
					<td colspan="2">サイトURL</td>
				</tr>
			
				<tr>
					<td colspan="2">
						<p><%= site_url %></p>
					</td>
				</tr>
			
				<tr>
					<td colspan="2">ユーザーID</td>
				</tr>
			
				<tr>
					<td colspan="2">
						<p><%= site_User_ID %></p>
					</td>
				</tr>
			
				<tr>
					<td colspan="2">ユーザーPW</td>
				</tr>
			
				<tr>
					<td colspan="2">
						<p><%= site_User_PW %></p>
					</td>
				</tr>
				
				<tr>
					<td colspan="2">
						<br>
						以上の内容で変更しますか?
						<br>	
					</td>
				</tr>
				
				<tr>
					<td>
						<!-- <a href="/ALLFREE/jsp/Warning_site_Updates.jsp"> -->
							<button type="button" id="return0">戻る</button>
					</td>
					<td>
						<button type="button" id="change">変更</button>
					</td>
				</tr>
			
			</table>
			
		</div>
		
	</body>
</html>
<% } %>
