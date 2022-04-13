$(function(){
	$('#LOGIN_SUBMIT').on('click', function(){
		var User_ID = document.getElementById('User_ID').value;
		var User_PW = document.getElementById('User_PW').value;
		
		var reqest = {
			User_ID: User_ID,
			User_PW: User_PW
		};
		
		$.ajax({
			type: "POST",
			url: "../servlet/LOGIN",
			data: reqest,
			success: function(data){
				if(data == 1) {
					window.location.href = "/ALLFREE/jsp/ALLFREE_toppage.jsp";
					//$('#LOGIN_form').submit();
				} else {
					alert('ユーザーID もしくは ユーザーPW が違います' + data);
				}
			}
		});
	});
});