$(function(){
	$('#change').on('click', function(){
		var site_name_old = document.getElementById('site_name_old').value;
		var site_name = document.getElementById('site_name').value;
		var site_url = document.getElementById('site_url').value;
		var site_User_ID = document.getElementById('site_User_ID').value;
		var site_User_PW = document.getElementById('site_User_PW').value;
		var page_type = document.getElementById('page_type').value;
		
		//alert(site_name_old + '\n' + site_name);
		
		var request = {
			site_name_old: site_name_old,
			site_name	: site_name,
			site_url	: site_url,
			site_User_ID: site_User_ID,
			site_User_PW: site_User_PW
		}
		
		$.ajax({
			type	:	"POST",
			url		:	"../servlet/Site_Update",
			data	:	request,
			success	:	function(data) {
				if(data == 'true') {
					alert('変更されました');
					if(page_type == 'true') {
						window.location.href = '../jsp/Warning_site_Updates.jsp'
					} else if(page_type == 'true2') { 
						window.location.href = '/ALLFREE/jsp/Warning_site_Duplicate.jsp';
					}  else {
						window.location.href = '../jsp/site_list.jsp'
					}
				} else {
					alert('変更出来ませんでした');
					if(page_type == 'true') {
						window.location.href = '../jsp/Warning_site_Updates.jsp'
					} else if(page_type == 'true2') { 
						window.location.href = '/ALLFREE/jsp/Warning_site_Duplicate.jsp';
					}  else {
						window.location.href = '../jsp/site_list.jsp'
					}
				}
			}
		});
	});
});