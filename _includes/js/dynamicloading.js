$("a").bind("click", function(e) {
    var url = $(this).attr("href");
    
    if (url.substring(url.length-5, url.length) === '.html' && // .html format
        $(window).width() >= 1280) {
        history.pushState(null, null, url);
        
        $('.content.clearfix').fadeOut(200, function() {
            $('body').load(url, function() {
                $('.content.clearfix').fadeIn(200);
            });
        });

        $("html, body").animate({ scrollTop: "0px" }, 500);
        
        return false;
    }
    else {
        window.location.href(url);
    }
});
