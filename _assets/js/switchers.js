// ThemeSwitcher and LiteSwitcher
(function () {
    "use strict";

    var ThemeSwitcher,
        LiteSwitcher,
        firstScript = document.getElementsByTagName('script')[0],
        parent = firstScript.parentNode;

    // Cache createElement for convenience

    function createElem(elem) {
        return document.createElement(elem);
    }

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

    var selected = readCookie('theme-switcher');

    if (selected == null) {
        selected = 'deadcream';
    } else {
        $('html').toggleClass(selected, true);
    }
    var ul = $('nav ul'),
        themes = [{
            id: 'darkgrey',
            color: '#474747',
        }, {
            id: 'deadcream',
            color: '#E7EEF2',
        }],
        li, a, visible = false;

    for (var i = 0; i < themes.length; i++) {
        if (themes.hasOwnProperty(i)) {
            li = $(createElem('li'));
            a = $(createElem('a'));
            a.addClass('tile')
                .attr('href', '#')
                .attr('id', themes[i].id)
                .css('background-color', themes[i].color)
                .appendTo(li);
            li.appendTo(ul);

            a.click(function (e) {
                e.preventDefault();

                $('html').toggleClass(selected, false);

                selected = e.target.id;
                console.log(selected);
                $('html').toggleClass(selected, true);

                eraseCookie('theme-switcher');
                createCookie('theme-switcher', selected, 0);
            });
        }
    }
})();
