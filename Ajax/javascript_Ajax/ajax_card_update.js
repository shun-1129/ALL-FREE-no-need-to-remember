$(function(){
	$('#Change2').on('click', function() {
		var page_type = document.getElementById('page_type').value;
		var card_name_old = document.getElementById('card_name_old').value;
		var card_name = document.getElementById('card_name').value;
		var card_number = document.getElementById('card_number').value;
		var card_limit_y = document.getElementById('card_limit_y').value;
		var card_limit_m = document.getElementById('card_limit_m').value;
		var card_owner = document.getElementById('card_owner').value;
		
		var request = {
			card_name_old	:	card_name_old,
			card_name		:	card_name,
			card_number		:	card_number,
			card_limit_y	:	card_limit_y,
			card_limit_m	:	card_limit_m,
			card_owner		:	card_owner
		};
		
		$.ajax({
			type	: "POST",
			url		: "../servlet/Card_update",
			data	: request,
			success	: function() {
				if(confirm('他のカードを更新しますか？')) {
					if(page_type == 'true') {
						window.location.href = '/ALLFREE/jsp/card_list.jsp';
					} else {
						window.location.href = '/ALLFREE/jsp/Warning_card_Updates.jsp';
					}
				} else {
					window.location.href = '/ALLFREE/jsp/ALLFREE_toppage.jsp';
				}
			}
		});
	});
});