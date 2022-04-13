<%@ page import="saves.Account_data_SAVE" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="User_ID_SAVE" scope="session" class="saves.Account_data_SAVE"/>
<jsp:useBean id="DATE" class="beans.Now_DATETIME"/>

<%
	request.setCharacterEncoding("UTF-8");
	User_ID_SAVE = (Account_data_SAVE)session.getAttribute("User_ID_SAVE");
	boolean Flag = false;
	
	if(User_ID_SAVE.getDATA_User_ID() == null) {
		response.sendRedirect("/jsp/ALLFREE_index.jsp");
	} else {
		Flag = true;
	}
	
	String User_ID = User_ID_SAVE.getDATA_User_ID();
	
	DATE.now_date();
	int DATES = DATE.getDATA() - 2000;
%>

<% if(Flag == true) { %>
<!DOCTYPE html>
<html>
	<head>
		
		<meta name="viewport" http-equiv="content-type" content="text/html;width=device-width,initial-scale=1.0,minimum-scale=1.0;charset=utf-8">
		
		<title>sample</title>
		
		<link rel="stylesheet" type="text/css" href="../css/ALLFREE_all.css">
		<link rel="stylesheet" type="text/css" href="../css/hamburger_menu.css">
		<link rel="stylesheet" type="text/css" href="../css/New_card_Reg.css">
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script type="text/javascript" src="../jQuery/jQuery_hamburger_menu.js"></script>
		<script type="text/javascript" src="../Ajax/javascript_Ajax/New_card_Reg.js"></script>
		
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
				
					<form action="" method="post">
				
						<table>
						
							<tr>
								<td colspan="2">カード名</td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="text" name="card_name" id="card_name" placeholder="カード名">
								</td>
							</tr>
							
							<tr>
								<td colspan="2">カード番号</td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="text" name="card_number" id="card_number" placeholder="カード番号">
								</td>
							</tr>
							
							<tr>
								<td colspan="2">有効期限</td>
							</tr>
							<tr>
								<td colspan="2">
								
									<select id="card_limit_y" name="card_limit_y">
										<% for(int i = 0; i <= 10; i++) { %>
											<% if(i != 0) { %>
												<option value="<%= DATES + i %>"><%= DATES + i %>年</option>
											<% } else { %>
												<option value="<%= DATES %>"><%= DATES %>年</option>
											<% } %>
										<% } %>
									</select>／
									<select id="card_limit_m" name="card_limit_m">
										<% for(int i = 1; i <= 12; i++) { %>
											<option value="<%= i %>"><%= i %>月</option>
										<% } %>
									</select>
								</td>
							</tr>
							
							<tr>
								<td colspan="2">カード名義</td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="text" name="card_owner" id="card_owner" placeholder="カード名義">
								</td>
							</tr>
							
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
