<%@ page import="saves.Account_data_SAVE" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="User_ID_SAVE" scope="session" class="saves.Account_data_SAVE"/>

<%
	request.setCharacterEncoding("UTF-8");
	User_ID_SAVE = (Account_data_SAVE)session.getAttribute("User_ID_SAVE");
	
	boolean FLAG = false;
	if(User_ID_SAVE.getDATA_User_ID() == null) {
		response.sendRedirect("../jsp/ALLFREE_index.jsp");
	} else {
		FLAG = true;
	}
	
	
	String User_ID = User_ID_SAVE.getDATA_User_ID();
%>

<% if(FLAG ==true) { %>
<!DOCTYPE html>
<html>
	<head>
		
		<meta name="viewport" http-equiv="content-type" content="text/html;width=device-width,initial-scale=1.0,minimum-scale=1.0;charset=utf-8">
		
		<title>sample</title>
		
		<link rel="stylesheet" type="text/css" href="../css/ALLFREE_all.css">
		<link rel="stylesheet" type="text/css" href="../css/hamburger_menu.css">
		<link rel="stylesheet" type="text/css" href="../css/New_site_Reg.css">
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script type="text/javascript" src="../jQuery/jQuery_hamburger_menu.js"></script>
		<script type="text/javascript" src="../js/New_site_Reg.js"></script>
		
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
		
		<main>
		
			<div id="main_div">
			
				<div id="tbl_div">
				
					<form action="/ALLFREE/servlet/New_site_Reg" method="post">
				
						<table>
						
							<tr>
								<td colspan="2">サイト名</td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="text" name="site_name" id="site_name" placeholder="サイト名">
								</td>
							</tr>
							
							<tr>
								<td colspan="2">サイトURL</td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="text" name="site_url" id="site_url" placeholder="サイトURL">
								</td>
							</tr>
							
							<tr>
								<td colspan="2">ユーザーID</td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="text" name="User_ID" id="User_ID" placeholder="ユーザーID">
								</td>
							</tr>
							
							<tr>
								<td colspan="2">ユーザーPW</td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="password" name="User_PW" id="User_PW" placeholder="ユーザーPW">
								</td>
							</tr>
							
							<!-- 
							<tr>
								<td colspan="2">
									<button type="button">パスワードを作成する</button>
								</td>
							</tr>
							 -->
							 
							<tr>
								<td>
									<button type="button" id="Reg">登録</button>
								</td>
								<td>
									<input type="reset" value="入力クリア">
								</td>
							</tr>
						
						</table>
						
					</form>
					
				</div>
			
			</div>
		
		</main>
	
	</body>
</html>
<% } %>
