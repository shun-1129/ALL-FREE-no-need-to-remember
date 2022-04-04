$(function(){
	$('#Reg').on('click', function(){
		var card_name = document.getElementById('card_name').value;
		var card_number = document.getElementById('card_number').value;
		Number(card_number);
		var card_limit_y = document.getElementById('card_limit_y').value;
		var card_limit_m = document.getElementById('card_limit_m').value;
		var card_owner = document.getElementById('card_owner').value;
		
		var flag1 = false;
		var flag2 = false;
		
		if(isNaN(card_number) == false && (String(card_number).length >= 14 && String(card_number).length <= 16)) {
			flag1 = true;
		}
		
		if(card_name != "" && card_number != "" && card_owner != "") {
			var Any = '以下の内容を登録します。\n';
			Any += 'カード名		：' + card_name + '\n';
			Any += 'カード番号		：' + card_number + '\n';
			Any += '有効期限 年	：' + card_limit_y + '\n';
			Any += '有効期限 月	：' + card_limit_m + '\n';
			Any += 'カード名義		：' + card_owner;
			
			if(confirm(Any)) {
				var request = {
					card_name: card_name,
					card_number: card_number,
					card_limit_y: card_limit_y,
					card_limit_m: card_limit_m,
					card_owner: card_owner
				}
				
				$.ajax({
					type:		"POST",
					url:		"/ALLFREE/servlet/New_card_Reg",
					data:		request,
					success:	function(data) {
						if(data == 'false') {
							if(confirm('更にカードを追加しますか？')) {
							} else {
								window.location.href = '/ALLFREE/jsp/ALLFREE_toppage.jsp';
							}
						} else {
							alert('既に登録されているカードです。');
						}
					}
				});
			}
		} else {
			alert('未入力の項目があります')
		}
	});
});