$(document).ready(function() {
	$('body').append('<div class="lite-switcher-container clearfix"><div id="lite-switcher"></div></div>');
	
	var button = $('#lite-switcher'),
	    state = readCookie('lite-switcher');
	    
	if (state == null) {
		createCookie('lite-switcher', false);
	}
	
	getStylesheet('lite').disabled = !state; // load lite styles
	button.click(function() {
		state = !state; // reverse state
		getStylesheet('lite').disabled = !state; // load lite styles
		
		eraseCookie('lite-switcher');
		createCookie('lite-switcher', state, 7);
	});
});
