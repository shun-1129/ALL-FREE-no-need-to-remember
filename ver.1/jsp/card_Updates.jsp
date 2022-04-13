<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="saves.Account_data_SAVE" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="User_ID_SAVE" scope="request" class="saves.Account_data_SAVE"/>
<jsp:useBean id="encript" class="encryption_and_decryption.Encryption_and_Decryption"/>
<jsp:useBean id="decrypt" class="encryption_and_decryption.Encryption_and_Decryption"/>
<jsp:useBean id="DATABASE" class="database_access.DATABASE_ACCESS_Beans"/>
<jsp:useBean id="DATE" class="beans.Now_DATETIME"/>

<%
	request.setCharacterEncoding("UTF-8");

	User_ID_SAVE = (Account_data_SAVE)session.getAttribute("User_ID_SAVE");
	String User_ID = User_ID_SAVE.getDATA_User_ID();
	String card_name = request.getParameter("card_name");
	String page_type = request.getParameter("page_type");
	
	boolean FLAG = false;
	if(User_ID_SAVE.getDATA_User_ID() == null) {
		response.sendRedirect("../jsp/ALLFREE_index.jsp");
	} else {
		FLAG = true;
	}
	
	encript.setMesseage(card_name);
	encript.encrypt();
	card_name = encript.getEncrypt_str();
	
	String DATABASE_NAME = "allfree";
	StringBuffer SQL = new StringBuffer();
	SQL.append("SELECT * FROM card_datas WHERE User_ID = '" + User_ID + "' AND card_name = '" + card_name + "';");
	
	DATABASE.setDATAS(DATABASE_NAME, SQL);
	DATABASE.DATA_SELECT();
	ArrayList<HashMap<String, String>> DATAS_Array = DATABASE.getDATA_Array();
	ArrayList<HashMap<String, String>> DATA = new ArrayList<HashMap<String, String>>();
	HashMap<String, String> map = null;
	for(int i = 0; i < DATAS_Array.size(); i++) {
		map = new HashMap<String, String>();
		for(int j = 2; j < DATAS_Array.get(i).size(); j++) {
			decrypt.setCryptText(DATAS_Array.get(i).get(String.valueOf(j)));
			decrypt.decrypt();
			map.put(String.valueOf((j-2)), decrypt.getDecrypt_str());
		}
		DATA.add(map);
	}
	
	DATE.now_date();
	int DATES = DATE.getDATA() - 2000;
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
		<link rel="stylesheet" type="text/css" href="../css/Warning_card_Updates.css">
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script type="text/javascript" src="../jQuery/jQuery_hamburger_menu.js"></script>
		<script type="text/javascript" src="../jQuery/jQuery_SELECToption.js"></script>
		<script type="text/javascript" src="../Ajax/javascript_Ajax/Ajax_Site_Update.js"></script>
		<script type="text/javascript" src="../Ajax/javascript_Ajax/ajax_card_update.js"></script>
		
		
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
		
			<input type="hidden" id="card_limit_y_hidden" value="<%= DATA.get(0).get("2") %>">
			<input type="hidden" id="card_limit_m_hidden" value="<%= DATA.get(0).get("3") %>">
			<input type="hidden" id="page_type" value="<%= page_type %>">
			
			<table>
			
				<tr><td>カード名</td></tr>
				<tr>
					<td>
						<input type="text" id="card_name" value="<%= DATA.get(0).get("0") %>">
					</td>
				<tr>
				
				<tr><td>カード番号</td></tr>
				<tr>
					<td>
						<input type="text" id="card_number" value="<%= DATA.get(0).get("1") %>">
					</td>
				</tr>
				
				<tr><td>カード有効期限</td></tr>
				<tr>
					<td>
						<select id="card_limit_y">
							<% for(int i = 0; i <= 10; i++) { %>
								<% if(i != 0) { %>
									<option value="<%= DATES + i %>"><%= DATES + i %>年</option>
								<% } else { %>
									<option value="<%= DATES %>"><%= DATES %>年</option>
								<% } %>
							<% } %>
						</select>／
						<select id="card_limit_m">
							<% for(int i = 1; i <= 12; i++) { %>
								<option value="<%= i %>"><%= i %>月</option>
							<% } %>
						</select>
					</td>
				</tr>
				
				<tr><td>カード名義</td></tr>
				<tr>
					<td>
						<input type="text" id="card_owner" value="<%= DATA.get(0).get("4") %>">
					</td>
				</tr>
				
				<tr>
					<td>
						<button type="button" id="Change1">確認</button>
					</td>
				</tr>
				
			</table>
			
		</div>
		
		<div id="sub_div">
		
			<input type="hidden" id="card_name_old" value="<%= DATA.get(0).get("0") %>">
		
			<table>
			
				<tr><td colspan="2">カード名</td></tr>
				<tr>
					<td colspan="2"><p id="card_name_P"></p></td>
				</tr>
				
				<tr><td colspan="2">カード番号</td></tr>
				<tr>
					<td colspan="2"><p id="card_number_P"></p></td>
				</tr>
				
				<tr><td colspan="2">カード有効期限</td></tr>
				<tr>
					<td colspan="2"><p id="card_limit_P"></p></td>
				</tr>
				
				<tr><td colspan="2">カード名義</td></tr>
				<tr>
					<td colspan="2"><p id="card_owner_P"></p></td>
				</tr>
				
				<tr>
					<td>
						<button type="button" id="return0">戻る</button>
					</td>
					<td>
						<button type="button" id="Change2">変更</button>
					</td>
				</tr>
			
			</table>
			
		</div>
		
	</body>
</html>
<% } %>