<%@ page import="beans.Verification"%>
<%@ page import="saves.Account_data_SAVE" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="User_ID_SAVE" scope="session" class="saves.Account_data_SAVE"/>
<jsp:useBean id="UPDATE" class="database_access.DATABASE_UPDATE_Beans"/>
<jsp:useBean id="DATABASE_ACCESS" class="database_access.DATABASE_ACCESS_Beans"/>

<%
	request.setCharacterEncoding("UTF-8");
	User_ID_SAVE = (Account_data_SAVE)session.getAttribute("User_ID_SAVE");
	
	boolean FLAG = false;
	if(User_ID_SAVE.getDATA_User_ID() == null) {
		response.sendRedirect("../jsp/ALLFREE_index.jsp");
	} else {
		FLAG = true;
		
		String DATABASE_NAME = "allfree";
		boolean[] Warning_List = new boolean[3];
		/*
			[0] = パスワード更新
			[1] = パスワード重複
			[2] = カード更新
		*/
		beans.Verification verification = new beans.Verification();
		verification.setDATA(User_ID_SAVE.getDATA_User_ID());

		Warning_List[0] = verification.Site_old_search();
		Warning_List[1] = verification.Site_Duplicate_search();
		Warning_List[2] = verification.Card_update();
		
		User_ID_SAVE.setDATA_Warning_List(Warning_List);
	}
	
	String User_ID = User_ID_SAVE.getDATA_User_ID();
	String[] Login_Date = User_ID_SAVE.getDATA_Login_Date();
	boolean[] Warning_List = User_ID_SAVE.getDATA_Warning_List();
%>

<% if(FLAG == true) { %>
	<!DOCTYPE html>
	<html>
		<head>
			
			<meta name="viewport" http-equiv="content-type" content="text/html;width=device-width,initial-scale=1.0,minimum-scale=1.0;charset=utf-8">
			
			<title>TOPページ</title>
			
			<link rel="stylesheet" type="text/css" href="../css/ALLFREE_all.css">
			<link rel="stylesheet" type="text/css" href="../css/ALLFREE_toppage.css">
			
			<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
			<script type="text/javascript" src="../jQuery/jQuery_hamburger_menu.js"></script>
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
					<li><a href="./site_list.jsp">サイト一覧</a></li>
					<li><a href="./card_list.jsp">カード一覧</a></li>
					<li><a href="./New_site_Reg.jsp">サイト登録</a></li>
					<li><a href="./New_card_Reg.jsp">カード登録</a></li>
					<li><a href="./setting.jsp">設定</a></li>
					<li><a href="./ALLFREE_index.jsp" id="LogOut">ログアウト</a></li>
				</ul>
			</nav>
		
			<div id="main_div">
			
				<div id="note_div">
					
					<% if(Warning_List[0] == true) { %>
						<a href="./Warning_site_Updates.jsp">
							<span class="working">&#x26a0;&#xfe0f;</span><span class="working_mess">パスワードを更新してください</span>
						</a><br>
					<% } %>
					<% if(Warning_List[1] == true) { %>
						<a href="./Warning_site_Duplicate.jsp">
							<span class="working">&#x26a0;&#xfe0f;</span><span class="working_mess">パスワードが重複しています</span>
						</a><br>
					<% } %>
					<% if(Warning_List[2] == true) { %> 
						<a href="./Warning_card_Updates.jsp">
							<span class="working">&#x26a0;&#xfe0f;</span><span class="working_mess">カード情報を更新してください</span>
						</a>
					<% } %>
					
				</div>
				
				<br>
				
				<div id="updata_div">
				
					<br>
					<p id="updata_Numbar1">XXXXXX 2021/07/09 00:00:00</p>
					<p id="updata_Numbar2">XXXXXX 2021/07/09 00:00:00</p>
					<p id="updata_Numbar3">XXXXXX 2021/07/09 00:00:00</p>
					<p id="updata_Numbar4">XXXXXX 2021/07/09 00:00:00</p>
					<p id="updata_Numbar5">XXXXXX 2021/07/09 00:00:00</p>
					<br>
					
				</div>
				
				<br>
				
				<div id="date_div">
				
					<br>
					<% for(int i = 0; i < 5; i++) { %>
					
						<% if(Login_Date[i] != null) { %>
							
							<p id="date_Numbar<%= i+1 %>>"><%= Login_Date[i] %></p>
							
						<% } %>
					
					<% } %>
					<br>
					
				</div>
			
			</div>
		
		</body>
	</html>
<% } %>