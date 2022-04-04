<%@ page import="saves.Account_data_SAVE" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="User_ID_SAVE" scope="request" class="saves.Account_data_SAVE"/>
<jsp:useBean id="SELECT" class="database_access.DATABASE_SELECT_Beans"/>
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
	
	
	String Judg = "Array";
	String DATABASE_NAME = "allfree";
	String[] SQL_DATA = {"site_datas"};
	String[] WHERE_DATA = {"User_ID = '" + User_ID + "'"};
	String[] GET_DATA = {
			"site_name",
			"site_url",
			"site_User_ID",
			"site_User_PW"
	};
	
	SELECT.setDATAS(Judg, DATABASE_NAME, SQL_DATA, WHERE_DATA, GET_DATA, "");
	SELECT.DATA_SELECT();
	ArrayList<HashMap<String, String>> DATAS_Array = SELECT.getDATAArray();
	ArrayList<HashMap<String, String>> LIST = new ArrayList<HashMap<String, String>>();
	HashMap<String, String> map = null;
	
	for(int j = 0; j < DATAS_Array.size(); j++) {
		map = new HashMap<String, String>();
		for(int i = 0; i < DATAS_Array.get(j).size(); i++) {
			decrypt.setCryptText(DATAS_Array.get(j).get(GET_DATA[i]));
			decrypt.decrypt();
			map.put(GET_DATA[i], decrypt.getDecrypt_str());
		}
		LIST.add(map);
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
					<% if(Warning_List[0] == true) { %>
						<a href="./Warning_site_Updates.jsp">
							<span class="working">&#x26a0;&#xfe0f;</span><span class="working_mess">パスワードを更新してください</span>
						</a>
						<br>
					<% } %>
					<% if(Warning_List[1] == true) { %>
						<a href="./Warning_site_Duplicate.jsp">
							<span class="working">&#x26a0;&#xfe0f;</span><span class="working_mess">パスワードが重複しています</span>
						</a>
					<% } %>
				</div>
				
				<div id="list_div">
				
					<div id="content">
						<% for(int i = 0; i < LIST.size(); i++) { %>
						
							<a href="" class="btn btn-radius-solid btn--shadow js-modal-open" data-target="modal<%= i %>">
								<span class="data_name"><%= LIST.get(i).get("site_name") %></span>
								<i class="fas fa-angle-right fa-position-right"></i>
							</a><br><br>
						
						<% } %>
					</div>
				
				</div>
				
				<div id="modal_div">
				
					<% for(int i = 0; i < LIST.size(); i++) { %>
					
						<div id="modal<%= i %>" class="modal js-modal">
							<div class="modal__bg js-modal-close"></div>
							<div class="modal__content">
								
								<form action="./Warning_site_Updates2.jsp" method="post">
									<input type="hidden" id="page_type" name="page_type" value="false">
									<table>
									
										<tr>
											<td>サイト名</td>
										</tr>
									
										<tr>
											<td>
												<input type="hidden" name="site_name_old" id="site_name_old" value="<%= LIST.get(i).get(GET_DATA[0]) %>">
												<input type="text" name="site_name" id="site_name" value="<%= LIST.get(i).get(GET_DATA[0]) %>">
											</td>
										</tr>
									
										<tr>
											<td>サイトURL</td>
										</tr>
									
										<tr>
											<td>
												<input type="text" name="site_url" id="site_url" value="<%= LIST.get(i).get(GET_DATA[1]) %>">
											</td>
										</tr>
									
										<tr>
											<td>ユーザーID</td>
										</tr>
									
										<tr>
											<td>
												<input type="text" name="User_ID" id="User_ID" value="<%= LIST.get(i).get(GET_DATA[2]) %>">
											</td>
										</tr>
									
										<tr>
											<td>ユーザーPW</td>
										</tr>
									
										<tr>
											<td>
												<input type="text" name="User_PW" id="User_PW" value="<%= LIST.get(i).get(GET_DATA[3]) %>">
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
