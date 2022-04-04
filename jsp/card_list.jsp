<%@ page import="saves.Account_data_SAVE" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="User_ID_SAVE" scope="request" class="saves.Account_data_SAVE"/>
<jsp:useBean id="DATABASE" class="database_access.DATABASE_ACCESS_Beans"/>
<jsp:useBean id="decrypt" class="encryption_and_decryption.Encryption_and_Decryption"/>

<%
	User_ID_SAVE = (Account_data_SAVE)session.getAttribute("User_ID_SAVE");
	String User_ID = User_ID_SAVE.getDATA_User_ID();
	boolean[] Warning_List = User_ID_SAVE.getDATA_Warning_List();
	
	boolean FLAG = false;
	if(User_ID_SAVE.getDATA_User_ID() == null) {
		response.sendRedirect("../jsp/ALLFREE_index.jsp");
	} else {
		FLAG = true;
	}
	
	String DATABASE_NAME = "allfree";
	StringBuffer SQL = new StringBuffer();
	SQL.append("SELECT * FROM card_datas WHERE User_ID = '" + User_ID + "';");
	
	DATABASE.setDATAS(DATABASE_NAME, SQL);
	DATABASE.DATA_SELECT();
	boolean Flag = DATABASE.getDATA_boolean();
	ArrayList<HashMap<String, String>> DATAS_Array = DATABASE.getDATA_Array();
	ArrayList<HashMap<String, String>> DATA = new ArrayList<HashMap<String, String>>();
	if(Flag == false) {
		response.sendRedirect("../jsp/ALLFREE_toppage.jsp");	
	}
	
	HashMap<String, String> map = null;
	for(int i = 0; i < DATAS_Array.size(); i++) {
		map = new HashMap<String, String>();
		for(int j = 2; j < (DATAS_Array.get(i).size()); j++) {
			decrypt.setCryptText(DATAS_Array.get(i).get(String.valueOf(j)));
			decrypt.decrypt();
			map.put(String.valueOf((j-2)), decrypt.getDecrypt_str());
		}
		DATA.add(map);
	}
	
%>

<% if(FLAG == true) { %>
<!DOCTYPE html>
<html>
	<head>
	
		<meta name="viewport" http-equiv="content-type" content="text/html;width=device-width,initial-scale=1.0,minimum-scale=1.0;charset=utf-8">
		
		<title>site_list</title>
	
		<link rel="stylesheet" type="text/css" href="../css/ALLFREE_all.css">
		<link rel="stylesheet" type="text/css" href="../css/hamburger_menu.css">
		<link rel="stylesheet" type="text/css" href="../css/working_updatas.css">
		<link rel="stylesheet" type="text/css" href="../css/btn_design.css">
		<link rel="stylesheet" type="text/css" href="../css/Warning_site_Updates_modal.css">
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script type="text/javascript" src="../jQuery/jQuery_hamburger_menu.js"></script>
		<script type="text/javascript" src="../jQuery/Warning_site_Updates_modal.js"></script>
		
		
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
		
				<div id="Title_div">
					<% if(Warning_List[2] == true) { %>
						<a href="./Warning_card_Updates.jsp">
							<span class="working">&#x26a0;&#xfe0f;</span><span class="working_mess">カードを更新してください</span>
						</a>
						<br>
					<% } %>
				</div>
				
				<div id="list_div">
				
					<div id="content">
						<% for(int i = 0; i < DATA.size(); i++) { %>
						
							<a href="" class="btn btn-radius-solid btn--shadow js-modal-open" data-target="modal<%= i %>">
								<span class="data_name"><%= DATA.get(i).get("0") %></span>
								<i class="fas fa-angle-right fa-position-right"></i>
							</a><br><br>
						
						<% } %>
					</div>
				
				</div>
				
				<div id="modal_div">
				
					<% for(int i = 0; i < DATA.size(); i++) { %>
					
						<div id="modal<%= i %>" class="modal js-modal">
							<div class="modal__bg js-modal-close"></div>
							<div class="modal__content">
								<form action="./card_Updates.jsp" method="post">
									<input type="hidden" name="card_name" id="card_name" value="<%= DATA.get(i).get("0") %>">
									<input type="hidden" name="page_type" id="page_type" value="true">
									<table>
									
										<tr>
											<td>カード名</td>
										</tr>
									
										<tr>
											<td>
												<p><%= DATA.get(i).get("0") %></p>
											</td>
										</tr>
									
										<tr>
											<td>カード番号</td>
										</tr>
									
										<tr>
											<td>
												<%= DATA.get(i).get("1") %>
											</td>
										</tr>
									
										<tr>
											<td>カード有効期限</td>
										</tr>
									
										<tr>
											<td>
												<p><%= DATA.get(i).get("2") %>　／　<%= DATA.get(i).get("3") %></p>
											</td>
										</tr>
									
										<tr>
											<td>カード名義</td>
										</tr>
									
										<tr>
											<td>
												<p><%= DATA.get(i).get("4") %></p>
											</td>
										</tr>
										
										<tr>
											<td>
												<br>
												<button type="submit" class="Change">変更</button>
											</td>
										</tr>
									
									</table>
									
								</form>
								
							</div>
						</div>
					
					<% } %>
				
				</div>
				
			</div>
		
		</main>
	
	</body>
</html>
<% } %>