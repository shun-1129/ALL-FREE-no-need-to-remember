<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
	session.removeAttribute("User_ID_SAVE");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" http-equiv="content-type" content="text/html;width=device-width,initial-scale=1.0,minimum-scale=1.0;charset=utf-8">
		<title>ALL FREE ~no need to remember~</title>
		
		<link rel="stylesheet" type="text/css" href="../css/ALLFREE_all.css">
		<link rel="stylesheet" type="text/css" href="../css/ALLFREE_index_SmartPhone.css">
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script type="text/javascript" src="../jQuery/jQuery_LOGSIN.js"></script>
		<script type="text/javascript" src="../jQuery/jQuery_SINGUP.js"></script>
		<script type="text/javascript" src="../jQuery/jQuery_main_return.js"></script>
		
		<script type="text/javascript" src="../Ajax/javascript_Ajax/LOGIN_Ajax.js"></script>
		<script type="text/javascript" src="../Ajax/javascript_Ajax/Ajax_SINGUP.js"></script>
		<script type="text/javascript" src="../Ajax/javascript_Ajax/Ajax_ID_search.js"></script>
	</head>
	<body>
		<div id="LOG_SIN">
			<a href="" class="btn btn--orange btn--radius" id="LOGIN_BUTTON">ログイン</a><br><br>
			<a href="" class="btn btn--blue btn--radius" id="SINGUP_BUTTON">新規登録</a>
		</div>
		
		<div id="LOGIN_FORM">
			
			<button type="button" class="MAIN_RETURN">戻る</button>
			
			<form action="/ALLFREE/jsp/ALLFREE_toppage.jsp" method="post" id="LOGIN_form" name="LOGIN_form">
			
				<table id="LOGIN_TAB">
					<tr>
						<td colspan="2">ユーザーID</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="text" name="User_ID" placeholder="User ID" id="User_ID">
						</td>
					</tr>
					
					<tr>
						<td colspan="2">ユーザーPW</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="password" name="User_PW" placeholder="User PW" id="User_PW">
						</td>
					</tr>
					
					<tr>
						<td>
							<button type="button" id="LOGIN_SUBMIT">ログイン</button>
						</td>
						<td>
							<input type="reset" value="入力クリア">
						</td>
					</tr>
				</table>
			
			</form>
			
		</div>
		
		<div id="SINGUP_FROM">
		
			<button type="button" class="MAIN_RETURN">戻る</button>
			
			<form action="#" method="post" id="SINGUP_form" name="SINGUP_form">
			
				<table id="SINGUP_TBA">
				
					<tr>
						<td>ユーザーID</td>
						<td>
							<input type="text" id="User_ID_SIN" name="User_ID_SIN" placeholder="User ID">
						</td>
					</tr>
					<tr>
						<td>
							<button type="button" id="search_BTN">検索</button>
						</td>
						<td id="search_result"></td>
					</tr>
					<tr>
						<td>ユーザーPW</td>
						<td>
							<input type="password" id="User_PW_SIN" name="User_PW" placeholder="User PW">
						</td>
					</tr>
					<tr>
						<td>ユーザーPW (確認)</td>
						<td>
							<input type="password" id="User_PW_SIN_1" name="User_PW_1" placeholder="User PW">
						</td>
					</tr>
					
					<tr>
						<td>氏名(姓)</td>
						<td>
							<input type="text" id="User_name_1" name="User_name_1" placeholder="名前(姓)">
						</td>
					</tr>
					<tr>
						<td>氏名(名)</td>
						<td>
							<input type="text" id="User_name_2" name="User_name_2" placeholder="名前(名)">
						</td>
					</tr>
					<tr>
						<td>シメイ(セイ)</td>
						<td>
							<input type="text" id="User_name_3" name="User_name_3" placeholder="シメイ(セイ)">
						</td>
					</tr>
					<tr>
						<td>シメイ(メイ)</td>
						<td>
							<input type="text" id="User_name_4" name="User_name_4" placeholder="シメイ(メイ)">
						</td>
					</tr>
					
					<tr>
						<td rowspan="2">メールアドレス</td>
						<td>
							<input type="text" id="mail1" name="mail1">
						</td>
					</tr>
					<tr>
						<td>
							<select id="mail2" name="mail2">
								<option value="@docomo.ne.jp">@docomo.ne.jp</option>
								<option value="@ezweb.ne.jp">@ezweb.ne.jp</option>
								<option value="@softbank.ne.jp">@softbank.ne.jp</option>
								<option value="@gmail.com" selected>@gmail.com</option>
								<option value="@outlook.com">@outlook.com</option>
								<option value="@live.jp">@live.jp</option>
								<option value="@yahoo.co.jp">@yahoo.co.jp</option>
							</select>
						</td>
					</tr>
					<tr>
						<td rowspan="2">メールアドレス(確認)</td>
						<td>
							<input type="text" id="mail3" name="mail3">
						</td>
					</tr>
					<tr>
						<td>
							<select id="mail4" name="mail4">
								<option value="@docomo.ne.jp">@docomo.ne.jp</option>
								<option value="@ezweb.ne.jp">@ezweb.ne.jp</option>
								<option value="@softbank.ne.jp">@softbank.ne.jp</option>
								<option value="@gmail.com" selected>@gmail.com</option>
								<option value="@outlook.com">@outlook.com</option>
								<option value="@live.jp">@live.jp</option>
								<option value="@yahoo.co.jp">@yahoo.co.jp</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<td rowspan="3">生年月日</td>
						<td>
							<select id="year" name="year">
								<option value="1950">1950年</option>
								<option value="1951">1951年</option>
								<option value="1952">1952年</option>
								<option value="1953">1953年</option>
								<option value="1954">1954年</option>
								<option value="1955">1955年</option>
								<option value="1956">1956年</option>
								<option value="1957">1957年</option>
								<option value="1958">1958年</option>
								<option value="1959">1959年</option>
								<option value="1960">1960年</option>
								<option value="1961">1961年</option>
								<option value="1962">1962年</option>
								<option value="1963">1963年</option>
								<option value="1964">1964年</option>
								<option value="1965">1965年</option>
								<option value="1966">1966年</option>
								<option value="1967">1967年</option>
								<option value="1968">1968年</option>
								<option value="1969">1969年</option>
								<option value="1970">1970年</option>
								<option value="1971">1971年</option>
								<option value="1972">1972年</option>
								<option value="1973">1973年</option>
								<option value="1974">1974年</option>
								<option value="1975">1975年</option>
								<option value="1976">1976年</option>
								<option value="1977">1977年</option>
								<option value="1978">1978年</option>
								<option value="1979">1979年</option>
								<option value="1980">1980年</option>
								<option value="1981">1981年</option>
								<option value="1982">1982年</option>
								<option value="1983">1983年</option>
								<option value="1984">1984年</option>
								<option value="1985">1985年</option>
								<option value="1986">1986年</option>
								<option value="1987">1987年</option>
								<option value="1988">1988年</option>
								<option value="1989">1989年</option>
								<option value="1990">1990年</option>
								<option value="1991">1991年</option>
								<option value="1992">1992年</option>
								<option value="1993">1993年</option>
								<option value="1994">1994年</option>
								<option value="1995">1995年</option>
								<option value="1996">1996年</option>
								<option value="1997">1997年</option>
								<option value="1998">1998年</option>
								<option value="1999">1999年</option>
								<option value="2000" selected>2000年</option>
								<option value="2001">2001年</option>
								<option value="2002">2002年</option>
								<option value="2003">2003年</option>
								<option value="2004">2004年</option>
								<option value="2005">2005年</option>
								<option value="2006">2006年</option>
								<option value="2007">2007年</option>
								<option value="2008">2008年</option>
								<option value="2009">2009年</option>
								<option value="2010">2010年</option>
								<option value="2011">2011年</option>
								<option value="2012">2012年</option>
								<option value="2013">2013年</option>
								<option value="2014">2014年</option>
								<option value="2015">2015年</option>
								<option value="2016">2016年</option>
								<option value="2017">2017年</option>
								<option value="2018">2018年</option>
								<option value="2019">2019年</option>
								<option value="2020">2020年</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<td>
							<select id="month" name="month">
								<option value="1">1月</option>
								<option value="2">2月</option>
								<option value="3">3月</option>
								<option value="4">4月</option>
								<option value="5">5月</option>
								<option value="6">6月</option>
								<option value="7">7月</option>
								<option value="8">8月</option>
								<option value="9">9月</option>
								<option value="10">10月</option>
								<option value="11">11月</option>
								<option value="12">12月</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<td>
							<select id="day" name="day">
								<option value="1">1日</option>
								<option value="2">2日</option>
								<option value="3">3日</option>
								<option value="4">4日</option>
								<option value="5">5日</option>
								<option value="6">6日</option>
								<option value="7">7日</option>
								<option value="8">8日</option>
								<option value="9">9日</option>
								<option value="10">10日</option>
								<option value="11">11日</option>
								<option value="12">12日</option>
								<option value="13">13日</option>
								<option value="14">14日</option>
								<option value="15">15日</option>
								<option value="16">16日</option>
								<option value="17">17日</option>
								<option value="18">18日</option>
								<option value="19">19日</option>
								<option value="20">20日</option>
								<option value="21">21日</option>
								<option value="22">22日</option>
								<option value="23">23日</option>
								<option value="24">24日</option>
								<option value="25">25日</option>
								<option value="26">26日</option>
								<option value="27">27日</option>
								<option value="28">28日</option>
								<option value="29">29日</option>
								<option value="30">30日</option>
								<option value="31">31日</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<td>性別</td>
						<td>
							<input type="radio" id="SEX" name="SEX" value="0">男
							<input type="radio" id="SEX" name="SEX" value="1">女
							<input type="radio" id="SEX" name="SEX" value="2" checked>その他
						</td>
					</tr>
					
					<tr>
						<td>秘密の質問</td>
						<td>
							<select name="secret_Q" id="secret_Q">
								<option value="出身地" selected>出身地</option>
								<option value="卒業した小学校">卒業した小学校</option>
								<option value="ペットの名前">ペットの名前</option>
								<option value="母親の旧姓">母親の旧姓</option>
								<option value="あだ名">あだ名</option>
								<option value="好きな食べ物">好きな食べ物</option>
								<option value="嫌いな食べ物">嫌いな食べ物</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<td>回答</td>
						<td>
							<input type="text" name="secret_A" id="secret_A" placeholder="秘密の質問 解答">
						</td>
					</tr>
					
					<tr>
						<td>
							<input type="reset" value="入力クリア">
						</td>
						<td>
							<button type="button" id="SINGUP_BTN">登録</button>
						</td>
					</tr>
				
				</table>
			
			</form>
		
		</div>
	</body>
</html>