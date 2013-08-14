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

    {% include js/theme-switcher.js %}
    {% include js/lite-switcher.js %}
})();
