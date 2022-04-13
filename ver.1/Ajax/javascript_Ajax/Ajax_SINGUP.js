var User_ID = "";
var User_PW1 = "";
var User_PW2 = "";
var NAME = [];
var mail = [];
var Birth = [];
var sex2 = 2;
var secret_Q = "";
var secret_A = "";

$(function(){
	$('#SINGUP_BTN').on('click', function(){
		var X1 = "<span id='ID_YES'>";
		var X2 = "<span id='ID_NO'>";
		var Y = "</span>";
	
		User_ID = document.getElementById('User_ID_SIN').value;
		User_PW1 = document.getElementById('User_PW_SIN').value;
		User_PW2 = document.getElementById('User_PW_SIN_1').value;
		NAME[0] = document.getElementById('User_name_1').value;
		NAME[1] = document.getElementById('User_name_2').value;
		NAME[2] = document.getElementById('User_name_3').value;
		NAME[3] = document.getElementById('User_name_4').value;
		mail[0] = document.getElementById('mail1').value + document.getElementById('mail2').value;
		mail[1] = document.getElementById('mail3').value + document.getElementById('mail4').value;
		Birth[0] = document.getElementById('year').value;
		Birth[1] = document.getElementById('month').value;
		Birth[2] = document.getElementById('day').value;
		var sex = document.getElementsByName('SEX');
		for(var i = 0; i < sex.length; i++) {
			if(sex[i].checked) {
				sex2 = sex[i].value;
				break;
			}
		}
		secret_Q = document.getElementById('secret_Q').value;
		secret_A = document.getElementById('secret_A').value;
		
		if(User_PW1 != User_PW2) alert('パスワードが一致しません');
		if(mail[0] != mail[1]) alert('メールアドレスが一致しません');
		
		var judg = 0;
		if(NAME[0] == "" || NAME[1] == "" || NAME[2] == "" || NAME[3] == "" || secret_A == "") {
			judg = 1;
		}
		
		var reqest = {
			User_ID: User_ID,
			User_PW: User_PW1,
			NAME1: NAME[0],
			NAME2: NAME[1],
			NAME3: NAME[2],
			NAME4: NAME[3],
			mail: mail[0],
			B_y: Birth[0],
			B_m: Birth[1],
			B_d: Birth[2],
			SEX: sex2,
			secret_Q: secret_Q,
			secret_A: secret_A
		};
		
		//alert("judg" + judg);
		
		if(User_ID == "NO_DATA") {
			alert('このユーザーIDは利用出来ません');
		} else if(User_ID == "") {
			alert('ユーザーIDを入力してください');
		} else if(judg == 1) {
			alert('未入力があります');
		} else {
			$.ajax({
				type: "POST",
				url: "../servlet/SINGUP",
				data: reqest,
				success: function(data) {
					if(data == 1) {
						document.getElementById('search_result').innerHTML = X2 + "利用不可" + Y;
						alert('このユーザーIDは利用出来ません');
					} else {
						window.location.href = "/ALLFREE/jsp/ALLFREE_toppage.jsp";
					}
				}
			});
		}
		User_ID = "";
		User_PW1 = "";
		User_PW2 = "";
		NAME1 = "";
		NAME2 = "";
		NAME3 = "";
		NAME4 = "";
		mail1 = "";
		mail2 = "";
		year = "";
		month = "";
		day = "";
		sex2 = 2;
		secret_Q = "";
		secret_A = "";
	});
});
