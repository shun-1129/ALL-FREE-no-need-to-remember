$(function(){
	$('.Change').on('click', function(){
		var click = $(this).data('id');
		var form = document.forms[click];
		
		var mail_Old;
		var mail_new;
		var pass_Old;
		var pass_new;
		var secretQ_Old;
		var secretQ_new;
		var secretA_Old;
		var secretA_new;
		
		if(click == 'mail_Change') {
			mail_Old = form.elements[0].value;
			if(form.elements[2].value == form.elements[3].value) {
				if(form.elements[1].value == form.elements[4].value){
					mail_new = form.elements[2].value;
				} else {
					alert('入力されたメールアドレスが一致しません。');
				}
			} else {
				alert('入力されたメールアドレスが一致しません。');
			}
			pass_Old = '0';
			pass_new = '0';
			secretQ_Old = "NO_DATA";
			secretQ_new = "NO_DATA";
			secretA_Old = "NO_DATA";
			secretA_new = "NO_DATA";
		} else if(click == 'pass_Change') {
			pass_Old = form.elements[0].value;
			if(form.elements[1].value == form.elements[2].value) {
				if(form.elements[3].value == form.elements[4].value){
					pass_new = form.elements[3].value;
				} else {
					alert('入力されたパスワードが一致しません。');
				}
			} else {
				alert('入力されたパスワードが一致しません。');
			}
			mail_Old = 'NO_DATA';
			mail_new = 'NO_DATA';
			secretQ_Old = "NO_DATA";
			secretQ_new = "NO_DATA";
			secretA_Old = "NO_DATA";
			secretA_new = "NO_DATA";
		} else if(click == 'secret_Change') {
			secretQ_Old = form.elements[0].value;
			secretA_Old = form.elements[1].value;
			if(form.elements[2].value == form.elements[4].value) {
				if(form.elements[3].value == form.elements[7].value) {
					secretQ_new = form.elements[5].value;
					secretA_new = form.elements[6].value;
				} else {
					alert('入力された解答が一致しません。');
				}
			} else {
				alert('入力された解答が一致しません。');
			}
			mail_Old = 'NO_DATA';
			mail_new = 'NO_DATA';
			pass_Old = '0';
			pass_new = '0';
		}
		
		var request = {
			mail_Old	:	mail_Old,
			mail_new	:	mail_new,
			pass_Old	:	pass_Old,
			pass_new	:	pass_new,
			secretQ_Old	:	secretQ_Old,
			secretQ_new	:	secretQ_new,
			secretA_Old	:	secretA_Old,
			secretA_new	:	secretA_new,
		};
		
		$.ajax({
			type	: "POST",
			url		: "../servlet/setting_Change",
			data	: request,
			success	: function() {
				alert('変更されました。');
				window.location.reload();
			}
		});
	});
});