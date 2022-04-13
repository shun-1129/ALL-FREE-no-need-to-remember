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
	SQL.append("SELECT site_name, site_url, site_User_ID, site_User_PW, DATEDIFF(NOW(), UPDATE_TIME) FROM site_datas WHERE User_ID = '" + User_ID + "' ");
	SQL.append("AND DATEDIFF(NOW(), UPDATE_TIME) >= 90;");
	
	DATABASE.setDATAS(DATABASE_NAME, SQL);
	DATABASE.DATA_SELECT();
	boolean Flag = DATABASE.getDATA_boolean();
	ArrayList<HashMap<String, String>> DATAS_Array = DATABASE.getDATA_Array();
	ArrayList<HashMap<String, String>> DATA = new ArrayList<HashMap<String, String>>();
	if(Flag == false) {
		response.sendRedirect("../jsp/ALLFREE_toppage.jsp");	
	} else {
		HashMap<String, String> map = null;
		for(int i = 0; i < DATAS_Array.size(); i++) {
			map = new HashMap<String, String>();
			for(int j = 1; j <= (DATAS_Array.get(i).size()); j++) {
				map.put(String.valueOf(j-1), DATAS_Array.get(i).get(String.valueOf(j)));
			}
			DATA.add(map);
		}
	}
	
	String Str = "";
%>

<% if(FLAG == true) { %>
<!DOCTYPE html>
<html>
	<head>
		
		<meta name="viewport" http-equiv="content-type" content="text/html;width=device-width,initial-scale=1.0,minimum-scale=1.0;charset=utf-8">
		
		<title>sample</title>
		
		<link rel="stylesheet" type="text/css" href="../css/ALLFREE_all.css">
		<link rel="stylesheet" type="text/css" href="../css/hamburger_menu.css">
		<link rel="stylesheet" type="text/css" href="../css/working_updatas.css">
		<link rel="stylesheet" type="text/css" href="../css/btn_design.css">
		<link rel="stylesheet" type="text/css" href="../css/Warning_site_Updates_modal.css">
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script type="text/javascript" src="../jQuery/jQuery_hamburger_menu.js"></script>
		<script type="text/javascript" src="../jQuery/Warning_site_Updates_modal.js"></script>
		<script type="text/javascript" src="../jQuery/jQuery_site_updates.js"></script>
		
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
		
		<div id="main_div">
		
			<div id="Title_div">
				<span class="working">&#x26a0;&#xfe0f;</span><span class="working_mess">パスワードを更新してください</span>
			</div>
		
			<div id="DATA_div">
				
				<div id="content">
					<% for(int i = 0; i < DATA.size(); i++) { %>
					
						<a href="" class="btn btn-radius-solid btn--shadow js-modal-open" data-target="modal<%= i %>">
							<span class="data_name">
								<%
									decrypt.setCryptText(DATA.get(i).get("0"));
									decrypt.decrypt();
									Str = decrypt.getDecrypt_str();
								%>
								
								<%= Str %>
							</span>
							<br>
							更新日 : 
							<%= DATA.get(i).get("4") %>
							日前
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
								
								<form action="./Warning_site_Updates2.jsp" method="post" name="form<%= i %>">
									<input type="hidden" id="page_type" name="page_type" value="true">
									<table>
									
										<tr>
											<td>サイト名</td>
										</tr>
									
										<tr>
											<td>
												<%
													decrypt.setCryptText(DATA.get(i).get("0"));
													decrypt.decrypt();
													Str = decrypt.getDecrypt_str();
												%>
												<input type="hidden" name="site_name_old" id="site_name_old" value="<%= Str %>">
												<input type="text" name="site_name" id="site_name" value="<%= Str %>">
											</td>
										</tr>
									
										<tr>
											<td>サイトURL</td>
										</tr>
									
										<tr>
											<td>
												<%
													decrypt.setCryptText(DATA.get(i).get("1"));
													decrypt.decrypt();
													Str = decrypt.getDecrypt_str();
												%>
												<input type="text" name="site_url" id="site_url" value="<%= Str %>">
											</td>
										</tr>
									
										<tr>
											<td>ユーザーID</td>
										</tr>
									
										<tr>
											<td>
												<%
													decrypt.setCryptText(DATA.get(i).get("2"));
													decrypt.decrypt();
													Str = decrypt.getDecrypt_str();
												%>
												<input type="text" name="User_ID" id="User_ID" value="<%= Str %>">
											</td>
										</tr>
									
										<tr>
											<td>ユーザーPW</td>
										</tr>
									
										<tr>
											<td>
												<%
													decrypt.setCryptText(DATA.get(i).get("3"));
													decrypt.decrypt();
													Str = decrypt.getDecrypt_str();
												%>
												<input type="text" name="User_PW" id="User_PW" value="<%= Str %>">
											</td>
										</tr>
										
										<tr>
											<td>
												<br>
												<button type="submit" class="Change" data-id="form<%= i %>">変更</button>
											</td>
										</tr>
									
									</table>
									
								</form>
								
							</div>
						</div>
					
					<% } %>
				
			</div>
		
		</div>
	
	</body>
</html>
<% } %>
