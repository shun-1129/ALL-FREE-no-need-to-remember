$(function(){
	$('#return0').on('click', function() {
		var page_type = document.getElementById('page_type').value;
		
		if(page_type == 'false') {
			window.location.href = '/ALLFREE/jsp/site_list.jsp';
		} else if(page_type == 'true2') { 
			window.location.href = '/ALLFREE/jsp/Warning_site_Duplicate.jsp';
		} else {
			window.location.href = '/ALLFREE/jsp/Warning_site_Updates.jsp';
		}
	});
});