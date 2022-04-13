$(function(){
	$('#LogOut').on('click', function(){
		var logout = 'logout';
		
		var request = {
			logout: logout
		};
		
		$.ajax({
			type	:	"post",
			url		:	"../servlet/LOGOUT",
			data	:	request,
			success	:	function(data) {
				alert(data);
				if(data == true) {
				}
			}
		});
	});
});
