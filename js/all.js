---
---
{% include js/functions/cookie.js %}

// ThemeSwitcher and LiteSwitcher
(function() {
    "use strict";

    var ThemeSwitcher,
        LiteSwitcher,
        firstScript = document.getElementsByTagName('script')[0],
        parent = firstScript.parentNode;

    // Cache createElement for convenience
    function createElem(elem) {
        return document.createElement(elem);
    }

    function getStylesheet(id) {
        var url = '/css/colors/' + id + '.css',
            styleSheet;

        if (!(styleSheet = $('link[href="' + url + '"]')[0])) {
            styleSheet = createElem('link');
            styleSheet.rel = 'stylesheet';
            styleSheet.href = url;
            parent.insertBefore(styleSheet, firstScript)
        }

        return styleSheet;
    }

    {% include js/theme-switcher.js %}
    {% include js/lite-switcher.js %}
})();
