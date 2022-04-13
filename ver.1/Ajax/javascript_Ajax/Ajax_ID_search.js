var User_ID = "";
$(function(){
	$('#search_BTN').on('click', function(){
		User_ID = document.getElementById('User_ID_SIN').value;
		
		var X1 = "<span id='ID_YES'>";
		var X2 = "<span id='ID_NO'>";
		var Y = "</span>";
		
		var reqest = {
			User_ID: User_ID
		};
		
		if(User_ID == "NO_DATA") {
			document.getElementById('search_result').innerHTML = X2 + "利用不可" + Y;
			alert('このユーザーIDは利用出来ません');
		} else if(User_ID == "") {
			document.getElementById('search_result').innerHTML = X2 + "入力してください" + Y;
			alert('ユーザーIDを入力してください');
		} else {
			$.ajax({
				type: "POST",
				url: "../servlet/User_ID_search",
				data: reqest,
				success: function(data) {
					if(data == 1) {
						document.getElementById('search_result').innerHTML = X2 + "利用不可" + Y;
						alert('このユーザーIDは利用出来ません');
					} else {
						document.getElementById('search_result').innerHTML = X1 + "利用可能" + Y;
					}
				}
			});
		}
		User_ID = "";
	});
});