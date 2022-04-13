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
	
	boolean FLAG = false;
	if(User_ID_SAVE.getDATA_User_ID() == null) {
		response.sendRedirect("../jsp/ALLFREE_index.jsp");
	} else {
		FLAG = true;
	}
	
	
	String DATABASE_NAME = "allfree";
	StringBuffer SQL = new StringBuffer();
	
	SQL.append("SELECT ");
	SQL.append("User_PW, ");
	SQL.append("mail, ");
	SQL.append("secret_Q, secret_A ");
	SQL.append("FROM user_account, user_account_secret ");
	SQL.append("WHERE user_account.User_ID = '" + User_ID + "' AND user_account_secret.User_ID = '" + User_ID + "';");
	
	DATABASE.setDATAS(DATABASE_NAME, SQL);
	DATABASE.DATA_SELECT();
	boolean Flag = DATABASE.getDATA_boolean();
	ArrayList<HashMap<String, String>> DATAS_Array = DATABASE.getDATA_Array();
	if(Flag == false) {
		response.sendRedirect("../jsp/ALLFREE_toppage.jsp");	
	}
	
	String User_PW_Old = DATAS_Array.get(0).get("1");
	String mail_Old = DATAS_Array.get(0).get("2");
	String secret_Q_Old = DATAS_Array.get(0).get("3");
	String secret_A_Old = DATAS_Array.get(0).get("4");
	
	decrypt.setCryptText(User_PW_Old);
	decrypt.decrypt();
	String User_PW = decrypt.getDecrypt_str();
	
	decrypt.setCryptText(mail_Old);
	decrypt.decrypt();
	String mail = decrypt.getDecrypt_str();
	
	decrypt.setCryptText(secret_Q_Old);
	decrypt.decrypt();
	String secret_Q = decrypt.getDecrypt_str();
	
	decrypt.setCryptText(secret_A_Old);
	decrypt.decrypt();
	String secret_A = decrypt.getDecrypt_str();
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
		<link rel="stylesheet" type="text/css" href="../css/setting.css">
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script type="text/javascript" src="../jQuery/jQuery_hamburger_menu.js"></script>
		<script type="text/javascript" src="../jQuery/Warning_site_Updates_modal.js"></script>
		<script type="text/javascript" src="../jQuery/jQuery_setting.js"></script>
		
		
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
				<li><a href="./setting.jsp">設定</a></li>
				<li><a href="./ALLFREE_index.jsp" id="LogOut">ログアウト</a></li>
			</ul>
		</nav>
		
		<main>
		
			<div id="main_div">
				
				<div id="list_div">
				
					<div id="content">
						
						<br><br><br><br>
						
						<a href="" class="btn btn-radius-solid btn--shadow js-modal-open" data-target="modal_mail">
							<span class="data_name">メールアドレス変更</span>
							<i class="fas fa-angle-right fa-position-right"></i>
						</a>
						
						<br><br>
						
						<a href="" class="btn btn-radius-solid btn--shadow js-modal-open" data-target="modal_pass">
							<span class="data_name">パスワード変更</span>
							<i class="fas fa-angle-right fa-position-right"></i>
						</a>
						
						<br><br>
						
						<a href="" class="btn btn-radius-solid btn--shadow js-modal-open" data-target="modal_secret">
							<span class="data_name">秘密の質問変更</span>
							<i class="fas fa-angle-right fa-position-right"></i>
						</a>
					</div>
				
				</div>
				
				<div id="modal_div">
					
					<div id="modal_mail" class="modal js-modal">
						<div class="modal__bg js-modal-close"></div>
						<div class="modal__content">
							<form action="#" method="post" name="mail_Change" id="mail_Change">
								<input type="hidden" id="mail_Old" name="mail_Old" value="<%= mail_Old %>">
								<input type="hidden" id="pass1" value="<%= User_PW %>">
								<table>
								
									<tr><td colspan="2">現在のメールアドレス</td></tr>
									<tr><td colspan="2"><%= mail %></td></tr>
									<tr><td colspan="2">変更メールアドレス</td></tr>
									<tr><td colspan="2">
											<input type="email" id="mail_Change" name="mail_Change" placeholder="メールアドレス">
									</td></tr>
									
									<tr><td colspan="2">変更メールアドレス確認</td></tr>
									<tr><td colspan="2">
											<input type="email" id="mail_Change" name="mail_Change" placeholder="メールアドレス確認">
									</td></tr>
									
									<tr><td colspan="2">パスワード</td></tr>
									<tr><td colspan="2">
										<input type="password" id="pass2" placeholder="パスワード">
									</td></tr>
									
									<tr><td colspan="2"><br></td></tr>
									
									<tr>
										<td><input type="reset" value="入力クリア" class="formreset"></td>
										<td><button type="button" class="Change" data-id="mail_Change">変更</button></td>
									</tr>
								
								</table>
							
							</form>
						</div>
					</div>
					
					<div id="modal_pass" class="modal js-modal">
						<div class="modal__bg js-modal-close"></div>
						<div class="modal__content">
							<form action="#" method="post" id="pass_Change" name="pass_Change">
								<input type="hidden" id="pass_Old" name="pass_Old" value="<%= User_PW_Old %>">
								<input type="hidden" id="pass" name="pass" value="<%= User_PW %>">
								<table>
								
									<tr><td colspan="2">現在のパスワード</td></tr>
									<tr><td colspan="2">
										<input type="password" id="pass_Old2" placeholder="現在のパスワード">
									</td></tr>
									
									<tr><td colspan="2">変更パスワード</td></tr>
									<tr><td colspan="2">
										<input type="password" id="pass_new1" placeholder="変更するパスワード">
									</td></tr>
									
									<tr><td colspan="2">変更パスワード確認</td></tr>
									<tr><td colspan="2">
										<input type="password" id="pass_new1" placeholder="変更するパスワード確認">
									</td></tr>
									
									<tr><td colspan="2"><br></td></tr>
									
									<tr>
										<td><input type="reset" value="入力クリア" class="formreset"></td>
										<td><button type="button" class="Change" data-id="pass_Change">変更</button></td>
									</tr>
								
								</table>
							</form>
						</div>
					</div>
					
					<div id="modal_secret" class="modal js-modal">
						<div class="modal__bg js-modal-close"></div>
						<div class="modal__content">
							<form action="#" method="post" id="secret_Change" name="secret_Change">
								<input type="hidden" id="secretQ_Old" value="<%= secret_Q_Old %>">
								<input type="hidden" id="secretA_Old" value="<%= secret_A_Old %>">
								<input type="hidden" id="secretA" value="<%= secret_A %>">
								<input type="hidden" id="pass1" value="<%= User_PW %>">
								<table>
								
									<tr><td colspan="2">秘密の質問 : <%= secret_Q %></td></tr>
									<tr><td colspan="2">
										<input type="text" id="secret_A_NOW" placeholder="秘密の質問　解答">
									</td></tr>
									
									<tr><td colspan="2">秘密の質問</td></tr>
									<tr><td colspan="2">
										<select id="secret_Q_new">
											<option value="出身地" selected>出身地</option>
											<option value="卒業した小学校">卒業した小学校</option>
											<option value="ペットの名前">ペットの名前</option>
											<option value="母親の旧姓">母親の旧姓</option>
											<option value="あだ名">あだ名</option>
											<option value="好きな食べ物">好きな食べ物</option>
											<option value="嫌いな食べ物">嫌いな食べ物</option>
										</select>
									</td></tr>
									
									<tr><td colspan="2">秘密の質問 解答</td></tr>
									<tr><td colspan="2">
										<input type="text" id="secretA_new" placeholder="秘密の質問 解答">
									</td></tr>
									
									<tr><td colspan="2">パスワード</td></tr>
									<tr><td colspan="2">
										<input type="password" id="pass2" placeholder="パスワード">
									</td></tr>
									
									<tr><td colspan="2"><br></td></tr>
									
									<tr>
										<td><input type="reset" value="入力クリア" class="formreset"></td>
										<td><button type="button" class="Change" data-id="secret_Change">変更</button></td>
									</tr>
								
								</table>
							</form>
						</div>
					</div>
				
				</div>
				
			</div>
		
		</main>
	
	</body>
</html>
<% } %>
