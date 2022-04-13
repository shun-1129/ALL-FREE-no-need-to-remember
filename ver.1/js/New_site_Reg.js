$(function(){
	$('#Reg').on('click', function(){
		var site_name = document.getElementById('site_name').value;
		var site_url = document.getElementById('site_url').value;
		var user_id = document.getElementById('User_ID').value;
		var user_pw = document.getElementById('User_PW').value;
		
		if(site_url == "") site_url = 'https://';
		
		if(site_name != "" && user_id != "" && user_pw != "") {
			var Any = '以下の内容を登録します。\n';
			Any += 'サイト名		：' + site_name + '\n';
			Any += 'サイトURL		：' + site_url + '\n';
			Any += 'ユーザーID		：' + user_id + '\n';
			Any += 'ユーザーPW	：' + user_pw;
			
			if(confirm(Any)) {
				var request = {
					site_name: site_name,
					site_url: site_url,
					User_ID: user_id,
					User_PW: user_pw
				}
				
				$.ajax({
					type:		"POST",
					url:		"/ALLFREE/servlet/New_site_Reg",
					data:		request,
					success:	function(data) {
						if(data == 'false') {
							if(confirm('更にサイトを追加しますか？')) {
							} else {
								window.location.href = '/ALLFREE/jsp/ALLFREE_toppage.jsp';
							}
						} else {
							alert('既に登録されているサイト名です。');
						}
					}
				});
			}
		} else {
			alert('未入力の項目があります')
		}
	});
});