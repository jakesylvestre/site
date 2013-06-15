$(document).ready(function() {
	$('body').append('<div class="lite-switcher-container clearfix"><div id="lite-switcher"></div></div>');
	
	var button = $('#lite-switcher'),
	    state = false;
	
	button.click(function() {
		state = !state; // reverse state
		getStylesheet( 'lite' ).disabled = !state; // load lite styles
	});
});
