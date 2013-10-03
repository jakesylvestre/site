if (!Modernizr.mq('only all')) {
	Modernizr.load("//cdnjs.cloudflare.com/ajax/libs/respond.js/1.1.0/respond.min.js");
	console.log("respond.min.js loaded to provide media query support.");
}

!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");
