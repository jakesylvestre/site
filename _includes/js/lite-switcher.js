$(document).ready(function() {
	$('body').append('<div class="lite-switcher-container clearfix"><div id="lite-switcher"></div></div>');
	
	var button = $('#lite-switcher'),
	    state = false;
	
	var cookie = readCookie('lite-switcher')
	if (cookie == null) {
		console.log("lite-switcher cookie does not exist; creating new cookie with state 'false'");
		createCookie('lite-switcher', state);
	} else if (cookie == "true") {
		state = true
	}
	
	getStylesheet('lite').disabled = !state; // load lite styles
	
	button.click(function() {
		state = !state; // reverse state
		getStylesheet('lite').disabled = !state; // load lite styles
		
		eraseCookie('lite-switcher');
		createCookie('lite-switcher', state, 0);
	});
});
