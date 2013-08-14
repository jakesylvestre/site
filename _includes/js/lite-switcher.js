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

$('html').toggleClass('lite', state);

button.click(function () {
    state = !state; // reverse state
    $('html').toggleClass('lite', state);
    
    eraseCookie('lite-switcher');
    createCookie('lite-switcher', state, 0);
});
