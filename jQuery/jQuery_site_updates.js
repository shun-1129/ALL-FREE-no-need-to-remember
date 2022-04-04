$(function(){
	$('.Change').on('click', function(){
		var OnClickForm = $(this).data('id');
		var form = document.forms[OnClickForm];
		
		var site_name = form.elements[0].value;
		var site_url = form.elements[1].value;
		var site_User_ID = form.elements[2].value;
		var site_User_PW = form.elements[3].value;
		
		alert(site_name + '\n' + site_url + '\n' + site_User_ID + '\n' + site_User_PW);
	});
});