var card_name_old;
var card_limit_y_hidden;
var card_limit_m_hidden;

var card_name;
var card_number;
var card_limit_y;
var card_limit_m;
var card_owner;

jQuery(document).ready(function(){
	card_name_old = document.getElementById('card_name_old').value;
	card_limit_y_hidden = document.getElementById('card_limit_y_hidden').value;
	card_limit_m_hidden = document.getElementById('card_limit_m_hidden').value;
	
	//alert(card_name_old + '\n' + card_limit_y_hidden + '\n' + card_limit_m_hidden);
	
	var min = document.getElementById('card_limit_y').options[0].value;
	Number(card_limit_y_hidden);
	var select = 0;
	Number(select);
	if(card_limit_y_hidden > min) {
		for(min; min < card_limit_y_hidden; min++) {
			select++;
		}
	} else {
		select = 0;
	}
	
	document.getElementById('card_limit_y').selectedIndex = select;
	document.getElementById('card_limit_m').selectedIndex = card_limit_m_hidden-1;
	
	$('#Change1').on('click', function() {
		this.card_name = document.getElementById('card_name').value;
		this.card_number = document.getElementById('card_number').value;
		this.card_limit_y = document.getElementById('card_limit_y').value;
		this.card_limit_m = document.getElementById('card_limit_m').value;
		this.card_owner = document.getElementById('card_owner').value;
		
		$('#card_name_P').html(this.card_name);
		$('#card_number_P').html(this.card_number);
		$('#card_limit_P').html(this.card_limit_y + '　／　' + this.card_limit_m);
		$('#card_owner_P').html(this.card_owner);
		
		$('#main_div').css('display', 'none');
		$('#sub_div').css('display', 'block');
	});
	
	$('#return0').on('click', function() {
		$('#main_div').css('display', 'block');
		$('#sub_div').css('display', 'none');
	});
});